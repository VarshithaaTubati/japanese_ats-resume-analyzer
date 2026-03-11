-- Add columns to store extracted CV text and matched keywords
ALTER TABLE public.applicants
ADD COLUMN cv_extracted_text text,
ADD COLUMN matched_keywords text[];