-- Supabase Database Schema for SnapClass

-- 1. Teachers Table
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Students Table
CREATE TABLE IF NOT EXISTS students (
    student_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    face_embedding JSONB,
    voice_embedding JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Subjects Table
CREATE TABLE IF NOT EXISTS subjects (
    subject_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    subject_code TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    section TEXT NOT NULL,
    teacher_id BIGINT REFERENCES teachers(teacher_id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Subject Enrolled Students Table
CREATE TABLE IF NOT EXISTS subject_students (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id BIGINT REFERENCES students(student_id) ON DELETE CASCADE,
    subject_id BIGINT REFERENCES subjects(subject_id) ON DELETE CASCADE,
    UNIQUE(student_id, subject_id)
);

-- 5. Attendance Logs Table
CREATE TABLE IF NOT EXISTS attendance_logs (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id BIGINT REFERENCES students(student_id) ON DELETE CASCADE,
    subject_id BIGINT REFERENCES subjects(subject_id) ON DELETE CASCADE,
    timestamp TEXT NOT NULL,
    is_present BOOLEAN NOT NULL DEFAULT FALSE
);

-- Row Level Security (RLS) Policies (allow public access with Anon Key)
ALTER TABLE teachers ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE subject_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance_logs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anon all on teachers" ON teachers FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon all on students" ON students FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon all on subjects" ON subjects FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon all on subject_students" ON subject_students FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon all on attendance_logs" ON attendance_logs FOR ALL USING (true) WITH CHECK (true);
