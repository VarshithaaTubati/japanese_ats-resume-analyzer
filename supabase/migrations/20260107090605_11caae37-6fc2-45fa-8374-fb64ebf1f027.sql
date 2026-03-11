-- Create enum for application status
CREATE TYPE public.application_status AS ENUM ('pending', 'reviewed', 'accepted', 'rejected');

-- Add status column to applicants table
ALTER TABLE public.applicants 
ADD COLUMN status public.application_status NOT NULL DEFAULT 'pending';

-- Allow authenticated users to update applicants (for status changes)
CREATE POLICY "Authenticated users can update applicants"
ON public.applicants
FOR UPDATE
TO authenticated
USING (auth.uid() IS NOT NULL)
WITH CHECK (auth.uid() IS NOT NULL);