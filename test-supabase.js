#!/usr/bin/env node

// Test Supabase Connection and Tables
const SUPABASE_URL = 'https://wofjapxwmowdhxchcjqs.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvZmphcHh3bW93ZGh4Y2hjanFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODk1MzU3ODksImV4cCI6MjEwNTExMTc4OX0.ESoYWOVmv-Xue3sAEN8x_SBFk14g07GlkqaNwE9fl18';

async function testSupabase() {
    console.log('🔍 Testing Supabase Connection...\n');
    console.log('URL:', SUPABASE_URL);
    console.log('Key:', SUPABASE_ANON_KEY.substring(0, 50) + '...\n');

    const tables = [
        'fs1cse_students',
        'fs1cse_exam_results',
        'fs1aids_students',
        'fs1aids_exam_results',
        'fs1it_students',
        'fs1it_exam_results',
        'fs1civil_students',
        'fs1civil_exam_results'
    ];

    console.log('📊 Testing Tables:\n');

    for (const table of tables) {
        try {
            const response = await fetch(`${SUPABASE_URL}/rest/v1/${table}?select=count`, {
                method: 'HEAD',
                headers: {
                    'apikey': SUPABASE_ANON_KEY,
                    'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
                }
            });

            if (response.ok) {
                const count = response.headers.get('content-range');
                console.log(`✅ ${table}: EXISTS (${count || 'unknown count'})`);
            } else {
                console.log(`❌ ${table}: NOT FOUND (${response.status} ${response.statusText})`);
            }
        } catch (error) {
            console.log(`❌ ${table}: ERROR - ${error.message}`);
        }
    }

    // Test inserting a sample result
    console.log('\n🧪 Testing Insert to fs1cse_exam_results...\n');
    
    const testData = {
        roll_number: 'TEST_' + Date.now(),
        correct_answers: 20,
        wrong_answers: 5,
        total_questions: 25,
        percentage: 80.00,
        user_answers: { test: true },
        additional_data: { test: 'sample' },
        violation_detected: false
    };

    try {
        const response = await fetch(`${SUPABASE_URL}/rest/v1/fs1cse_exam_results`, {
            method: 'POST',
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
                'Content-Type': 'application/json',
                'Prefer': 'return=representation'
            },
            body: JSON.stringify(testData)
        });

        if (response.ok) {
            const data = await response.json();
            console.log('✅ INSERT SUCCESS!');
            console.log('Inserted data:', JSON.stringify(data, null, 2));
        } else {
            const error = await response.text();
            console.log(`❌ INSERT FAILED: ${response.status} ${response.statusText}`);
            console.log('Error:', error);
        }
    } catch (error) {
        console.log('❌ INSERT ERROR:', error.message);
    }

    // Test student lookup
    console.log('\n🔍 Testing Student Lookup (fs1cse_students)...\n');
    
    try {
        const response = await fetch(`${SUPABASE_URL}/rest/v1/fs1cse_students?roll_number=eq.160525733004&select=*`, {
            method: 'GET',
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
            }
        });

        if (response.ok) {
            const data = await response.json();
            if (data.length > 0) {
                console.log('✅ STUDENT FOUND!');
                console.log('Student:', JSON.stringify(data[0], null, 2));
            } else {
                console.log('⚠️  Student not found - table exists but no data');
            }
        } else {
            const error = await response.text();
            console.log(`❌ LOOKUP FAILED: ${response.status} ${response.statusText}`);
            console.log('Error:', error);
        }
    } catch (error) {
        console.log('❌ LOOKUP ERROR:', error.message);
    }

    console.log('\n✅ Test Complete!\n');
}

testSupabase().catch(console.error);
