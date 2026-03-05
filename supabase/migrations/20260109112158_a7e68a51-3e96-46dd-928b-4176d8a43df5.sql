-- Add columns to store extracted CV text and matched keywords
ALTER TABLE public.applicants
ADD COLUMN cv_extracted_text text,
ADD COLUMN matched_keywords text[];


-- =========================
-- RESUMES TABLE
-- =========================
CREATE TABLE resumes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  applicant_id UUID REFERENCES applicants(id) ON DELETE CASCADE,
  file_path TEXT NOT NULL,
  extracted_text TEXT,
  uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- JOB ROLES TABLE
-- =========================
CREATE TABLE job_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  required_skills TEXT[],
  min_experience INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- ATS SCORES TABLE
-- =========================
CREATE TABLE ats_scores (
  applicant_id UUID REFERENCES applicants(id) ON DELETE CASCADE,
  job_role_id UUID REFERENCES job_roles(id) ON DELETE CASCADE,
  matched_keywords TEXT[],
  score INT,
  evaluated_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (applicant_id, job_role_id)
);

-- =========================
-- KEYWORDS TABLE
-- =========================
CREATE TABLE keywords (
  id SERIAL PRIMARY KEY,
  keyword TEXT UNIQUE NOT NULL
);

-- =========================
-- SAMPLE DATA
-- =========================
INSERT INTO keywords (keyword) VALUES
('Python'), ('Java'), ('JavaScript'), ('React'), ('HTML'),
('CSS'), ('SQL'), ('REST APIs'), ('Node.js'), ('MongoDB'),
('Japanese'), ('JLPT');

INSERT INTO job_roles (title, required_skills, min_experience) VALUES
('Frontend Developer', ARRAY['JavaScript','React','HTML','CSS'],0),
('Backend Developer', ARRAY['Python','SQL','REST APIs'],0),
('Full Stack Developer', ARRAY['JavaScript','React','Node.js','SQL'],1);
