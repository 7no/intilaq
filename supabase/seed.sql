-- ============================================================
-- INTILAQ Seed Data
-- 5 roles × 3 levels × 3 projects = 45 projects
-- ============================================================

DO $$
DECLARE
  role_customer_support   UUID;
  role_sales_rep          UUID;
  role_hr_assistant       UUID;
  role_marketing_coord    UUID;
  role_data_analyst       UUID;

  cs_l1 UUID; cs_l2 UUID; cs_l3 UUID;
  sr_l1 UUID; sr_l2 UUID; sr_l3 UUID;
  hr_l1 UUID; hr_l2 UUID; hr_l3 UUID;
  mc_l1 UUID; mc_l2 UUID; mc_l3 UUID;
  da_l1 UUID; da_l2 UUID; da_l3 UUID;

BEGIN

-- ══════════════════════════════════════════════════════════════
-- ROLE 1: Customer Support
-- ══════════════════════════════════════════════════════════════
INSERT INTO role (title_ar, title_en, description_ar, description_en, status, is_active)
VALUES (
  'دعم العملاء', 'Customer Support',
  'تولّي التواصل مع العملاء، معالجة استفساراتهم وشكاواهم، وتقديم حلول فعّالة وسريعة تعكس احترافية الشركة وتُعزز رضا العملاء.',
  'Handle customer communications, resolve inquiries and complaints, and deliver effective solutions that reflect company professionalism and build customer satisfaction.',
  'published', true
) RETURNING id INTO role_customer_support;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_customer_support, 1, 'الأساسيات', 'Foundations',
  'فهم مبادئ خدمة العملاء، أسلوب التواصل المهني، وكيفية التعامل مع الاستفسارات الشائعة.',
  'Understanding customer service principles, professional communication style, and handling common inquiries.'
) RETURNING id INTO cs_l1;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_customer_support, 2, 'التطبيق العملي', 'Applied Execution',
  'التعامل مع سيناريوهات معقدة، حل الشكاوى المتصاعدة، والتنسيق مع الفرق الداخلية.',
  'Handling complex scenarios, resolving escalated complaints, and coordinating with internal teams.'
) RETURNING id INTO cs_l2;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_customer_support, 3, 'محاكاة بيئة العمل', 'Workplace Simulation',
  'إدارة حالة عميل متكاملة من البداية للنهاية، تقييم الأداء الذاتي، وإعداد توثيق مهني.',
  'Managing a complete customer case from start to finish, self-assessing performance, and producing professional documentation.'
) RETURNING id INTO cs_l3;
-- CS Level 1 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l1, 1, 'صياغة رد على استفسار عميل', 'Drafting a Customer Inquiry Response',
  'تلقّيتَ رسالة من عميل يسأل عن سياسة الاسترجاع لمنتج اشتراه قبل 20 يومًا. اكتب ردًا احترافيًا وواضحًا.',
  'You received a message from a customer asking about the return policy for a product they purchased 20 days ago. Write a professional and clear response.',
  'قياس قدرتك على صياغة ردود مكتوبة واضحة ومهنية تتوافق مع سياسات الشركة.',
  'Measure your ability to write clear, professional written responses that align with company policy.',
  'أنت موظف جديد في فريق دعم العملاء لشركة تجارة إلكترونية سعودية. سياسة الاسترجاع تتيح استرداد المنتجات خلال 30 يومًا من تاريخ الشراء بشرط أن يكون المنتج في حالته الأصلية.',
  'You are a new employee on the customer support team of a Saudi e-commerce company. The return policy allows product returns within 30 days of purchase, provided the product is in its original condition.',
  '["اكتب الرد بالعربية بأسلوب مهني وودّي", "أشر إلى سياسة الاسترجاع بشكل مباشر وواضح", "اختم الرد بعرض المساعدة المستمرة"]',
  '["Write the response in Arabic in a professional and friendly tone", "Reference the return policy directly and clearly", "Close with an offer of continued assistance"]',
  'يجب أن يكون الرد باللغة العربية الفصحى. لا يتجاوز 150 كلمة. لا تستخدم قوالب جاهزة.',
  'The response must be in formal Arabic. No more than 150 words. Do not use pre-made templates.',
  '["يُعالج الرد استفسار العميل بشكل مباشر ودون غموض", "النبرة ودية واحترافية في آنٍ معًا", "تُذكر سياسة الاسترجاع بدقة وتتوافق مع السياق المقدَّم"]',
  '["The response directly addresses the customer inquiry without ambiguity", "Tone is both friendly and professional", "Return policy is stated accurately and matches the given context"]',
  'أرسل ردك كنص مكتوب في حقل الإجابة. لا يُقبل ملف مرفق في هذا المشروع.',
  'Submit your response as written text in the answer field. No file attachment is accepted for this project.',
  1.5,
  '[{"id":"clarity","label_ar":"وضوح الرد","label_en":"Response Clarity","description_ar":"هل الرد واضح ويُجيب مباشرة على سؤال العميل؟","description_en":"Is the response clear and directly answers the customer question?","weight":3,"passing_score":1},{"id":"policy_accuracy","label_ar":"دقة السياسة","label_en":"Policy Accuracy","description_ar":"هل تُذكر سياسة الاسترجاع بشكل صحيح؟","description_en":"Is the return policy referenced correctly?","weight":2,"passing_score":1},{"id":"tone","label_ar":"الأسلوب المهني","label_en":"Professional Tone","description_ar":"هل النبرة ودية ومهنية وتليق ببيئة العمل؟","description_en":"Is the tone friendly, professional, and workplace-appropriate?","weight":2,"passing_score":1},{"id":"completeness","label_ar":"اكتمال الرد","label_en":"Response Completeness","description_ar":"هل يتضمن الرد خطوة تالية أو عرض مساعدة؟","description_en":"Does the response include a next step or offer of further help?","weight":1,"passing_score":0}]',
  'published');

-- CS Level 1 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l1, 2, 'تصنيف الشكاوى وترتيب أولوياتها', 'Classifying and Prioritizing Complaints',
  'زُوِّدتَ بقائمة من 8 شكاوى واردة من العملاء. صنِّفها حسب نوع المشكلة ورتّبها حسب الأولوية مع ذكر مبرراتك.',
  'You have been given a list of 8 incoming customer complaints. Classify them by problem type and prioritize them with justification.',
  'قياس قدرتك على التمييز بين أنواع الشكاوى واتخاذ قرار تحليلي بشأن ترتيب أولوياتها.',
  'Measure your ability to distinguish between complaint types and make analytical decisions about prioritization.',
  'فريق دعم العملاء يستقبل يوميًا عشرات الشكاوى. القدرة على التصنيف السريع والدقيق تُقلل وقت الاستجابة وترفع رضا العملاء.',
  'The customer support team receives dozens of complaints daily. The ability to quickly and accurately classify them reduces response time and improves satisfaction.',
  '["جدول يحتوي على: رقم الشكوى، نوع المشكلة، مستوى الأولوية (عاجل / مرتفع / متوسط / منخفض)، مبرر الأولوية"]',
  '["A table containing: complaint number, problem type, priority level (Urgent / High / Medium / Low), and priority justification"]',
  'استخدم فقط الفئات التالية: مشكلة في التوصيل، عيب في المنتج، خطأ في الفاتورة، استفسار عام، طلب استرداد. لا تبتكر فئات جديدة.',
  'Use only these categories: Delivery issue, Product defect, Billing error, General inquiry, Refund request. Do not invent new categories.',
  '["جميع الشكاوى الـ 8 مُصنَّفة ضمن الفئات المحددة", "الأولويات منطقية ومتسقة مع السياق", "المبررات واضحة ومرتبطة بأثر المشكلة على العميل"]',
  '["All 8 complaints classified within the specified categories", "Priorities are logical and consistent with context", "Justifications are clear and tied to the impact on the customer"]',
  'أرسل جدولك كملف PDF أو صورة واضحة، أو كنص منظّم في حقل الإجابة.',
  'Submit your table as a PDF file, a clear image, or as structured text in the answer field.',
  2.0,
  '[{"id":"classification","label_ar":"دقة التصنيف","label_en":"Classification Accuracy","description_ar":"هل صُنِّفت جميع الشكاوى بشكل صحيح ضمن الفئات المقررة؟","description_en":"Were all complaints correctly classified within the specified categories?","weight":3,"passing_score":1},{"id":"priority_logic","label_ar":"منطقية الأولويات","label_en":"Priority Logic","description_ar":"هل ترتيب الأولويات معقول ومبرر بالسياق؟","description_en":"Is the prioritization reasonable and justified by context?","weight":3,"passing_score":1},{"id":"justification","label_ar":"جودة المبررات","label_en":"Justification Quality","description_ar":"هل المبررات محددة وتربط القرار بأثره على العميل؟","description_en":"Are justifications specific and connect the decision to customer impact?","weight":2,"passing_score":1}]',
  'published');

-- CS Level 1 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l1, 3, 'كتابة نص رسالة ترحيب للعملاء الجدد', 'Writing a New Customer Welcome Message',
  'اكتب رسالة ترحيب تُرسَل تلقائيًا للعملاء الجدد عند إنشاء حسابهم لأول مرة في المتجر.',
  'Write a welcome message sent automatically to new customers when they create their first account in the store.',
  'قياس قدرتك على كتابة محتوى تواصلي ودي ومنسجم مع هوية العلامة التجارية.',
  'Measure your ability to write warm, brand-aligned communication content.',
  'المتجر متخصص في بيع المنتجات الإلكترونية ويستهدف الشباب السعودي. قيمه: السرعة، الجودة، خدمة ما بعد البيع.',
  'The store specializes in electronics for Saudi youth. Its values are: speed, quality, and after-sales service.',
  '["نص الرسالة بالعربية (لا يتجاوز 120 كلمة)", "عنوان للرسالة"]',
  '["Message text in Arabic (no more than 120 words)", "A subject line for the message"]',
  'لا تتضمن أرقام هواتف وهمية أو روابط. لا تستخدم صيغة رسمية باردة — الرسالة يجب أن تكون دافئة وشخصية.',
  'Do not include fake phone numbers or links. Do not use a cold formal tone — the message must be warm and personal.',
  '["الرسالة تُرحب بالعميل باسمه (باستخدام متغير [اسم العميل])", "تعكس قيم العلامة التجارية الثلاث بشكل واضح", "النبرة دافئة وتحثّ العميل على اتخاذ خطوة أولى"]',
  '["Message welcomes the customer by name (using [Customer Name] variable)", "Clearly reflects the three brand values", "Tone is warm and encourages the customer to take a first action"]',
  'أرسل النص في حقل الإجابة. اكتب عنوان الرسالة في السطر الأول.',
  'Submit the text in the answer field. Write the message subject on the first line.',
  1.5,
  '[{"id":"brand_alignment","label_ar":"انسجام العلامة التجارية","label_en":"Brand Alignment","description_ar":"هل تعكس الرسالة قيم العلامة التجارية الثلاث؟","description_en":"Does the message reflect the three brand values?","weight":2,"passing_score":1},{"id":"warmth","label_ar":"الدفء والشخصية","label_en":"Warmth and Personalization","description_ar":"هل النبرة دافئة وشخصية وتُخاطب العميل مباشرة؟","description_en":"Is the tone warm, personal, and directly addresses the customer?","weight":3,"passing_score":1},{"id":"cta","label_ar":"دعوة للتصرف","label_en":"Call to Action","description_ar":"هل تحثّ الرسالة العميل على خطوة محددة؟","description_en":"Does the message prompt the customer to take a specific action?","weight":2,"passing_score":1}]',
  'published');
-- CS Level 2 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l2, 1, 'التعامل مع عميل غاضب', 'Handling an Angry Customer',
  'عميل يتصل غاضبًا لأن طلبه تأخر 5 أيام عن الموعد المحدد وأصابه ذلك بإحراج أمام عائلته. اكتب كيف ستتعامل مع هذا الموقف خطوة بخطوة.',
  'A customer calls furious because their order is 5 days late and it caused them embarrassment with their family. Write how you would handle this situation step by step.',
  'قياس قدرتك على إدارة المواقف العاطفية الحساسة مع الحفاظ على الاحترافية وتقديم حل فعلي.',
  'Measure your ability to manage emotionally charged situations while maintaining professionalism and providing a real solution.',
  'شركة توصيل سعودية. التأخير ناتج عن مشكلة في مستودع التوزيع وليس بسبب خطأ العميل. لديك صلاحية تقديم قسيمة خصم 50 ريال أو إلغاء رسوم التوصيل.',
  'A Saudi delivery company. The delay was caused by a warehouse issue, not the customer''s fault. You have authority to offer a 50 SAR discount voucher or waive the delivery fee.',
  '["خطة استجابة مكتوبة: خطوة بخطوة تصف ما ستقوله وما ستفعله", "الحل المقترح للعميل مع مبرراته"]',
  '["A written response plan: step-by-step describing what you will say and do", "The proposed solution with justification"]',
  'يجب أن تشمل خطتك مرحلة الاستماع قبل تقديم الحل. لا تعرض الحلّين معًا في آنٍ واحد.',
  'Your plan must include a listening phase before proposing a solution. Do not offer both solutions at the same time.',
  '["تبدأ الاستجابة بالاعتذار والتعاطف قبل أي تبرير", "يُقدَّم حل واحد محدد مع مبرر واضح", "الخطة قابلة للتطبيق الفعلي في بيئة العمل"]',
  '["Response begins with apology and empathy before any explanation", "One specific solution is offered with clear justification", "The plan is practically applicable in a real work environment"]',
  'أرسل خطتك كنص مكتوب أو ملف.',
  'Submit your plan as written text or a file.',
  2.5,
  '[{"id":"empathy","label_ar":"التعاطف","label_en":"Empathy","description_ar":"هل تعترف الاستجابة بمشاعر العميل أولاً؟","description_en":"Does the response acknowledge the customer feelings first?","weight":3,"passing_score":1},{"id":"solution","label_ar":"جودة الحل","label_en":"Solution Quality","description_ar":"هل الحل المقدم مناسب وضمن الصلاحيات المتاحة؟","description_en":"Is the proposed solution appropriate and within available authority?","weight":3,"passing_score":1},{"id":"structure","label_ar":"تسلسل الخطوات","label_en":"Step Sequence","description_ar":"هل الخطوات منطقية ومتسلسلة؟","description_en":"Are the steps logical and sequential?","weight":2,"passing_score":1}]',
  'published');

-- CS Level 2 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l2, 2, 'كتابة تقرير أسبوعي للشكاوى', 'Writing a Weekly Complaints Report',
  'بناءً على بيانات وهمية مُقدَّمة لـ 15 شكوى خلال أسبوع، أعدّ تقريرًا موجزًا للمشرف.',
  'Based on provided mock data for 15 complaints over a week, prepare a concise summary report for the supervisor.',
  'قياس قدرتك على تلخيص البيانات وتقديم الأنماط والتوصيات بشكل منظم.',
  'Measure your ability to summarize data, identify patterns, and present recommendations in an organized format.',
  'المشرف يراجع التقرير صباح كل أحد. يريد: الأرقام الرئيسية، الأنماط الملاحظة، والتوصيات.',
  'The supervisor reviews the report every Sunday morning. They want: key numbers, observed patterns, and recommendations.',
  '["تقرير لا يتجاوز صفحة واحدة يتضمن: إجمالي الشكاوى، التصنيف، أبرز 3 أنماط، توصية واحدة على الأقل"]',
  '["A one-page report including: total complaints, classification, top 3 patterns, at least one recommendation"]',
  'البيانات مقدمة في نص المشروع. لا تخترع بيانات جديدة.',
  'Data is provided in the project text. Do not invent new data.',
  '["التقرير يغطي جميع عناصر المطلوبة", "الأنماط مستنتجة بشكل منطقي من البيانات", "التوصية مرتبطة بالبيانات وليست عامة"]',
  '["Report covers all required elements", "Patterns are logically inferred from data", "Recommendation is data-driven, not generic"]',
  'أرسل التقرير كملف أو نص.',
  'Submit the report as a file or text.',
  2.0,
  '[{"id":"coverage","label_ar":"تغطية العناصر","label_en":"Element Coverage","description_ar":"هل يغطي التقرير جميع العناصر المطلوبة؟","description_en":"Does the report cover all required elements?","weight":3,"passing_score":1},{"id":"insight","label_ar":"جودة الاستنتاجات","label_en":"Insight Quality","description_ar":"هل الأنماط منطقية ومستنتجة من البيانات؟","description_en":"Are patterns logical and inferred from the data?","weight":3,"passing_score":1},{"id":"recommendation","label_ar":"التوصية","label_en":"Recommendation","description_ar":"هل التوصية محددة وقابلة للتطبيق؟","description_en":"Is the recommendation specific and actionable?","weight":2,"passing_score":1}]',
  'published');

-- CS Level 2 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l2, 3, 'محاكاة تصعيد الشكوى داخليًا', 'Simulating Internal Complaint Escalation',
  'شكوى لم تتمكن من حلها في مستواك. اكتب رسالة تصعيد داخلية موجهة لمشرفك توضح فيها المشكلة، ما جرّبته، ولماذا تحتاج تدخله.',
  'A complaint you could not resolve at your level. Write an internal escalation message to your supervisor explaining the problem, what you tried, and why you need their intervention.',
  'قياس قدرتك على التواصل الداخلي الواضح والمهني في مواقف التصعيد.',
  'Measure your ability to communicate clearly and professionally in escalation situations.',
  'سياسة الشركة: كل موظف دعم لديه 4 ساعات لحل الشكوى قبل التصعيد. إذا تجاوزت المشكلة صلاحياته تُصعَّد فورًا.',
  'Company policy: each support agent has 4 hours to resolve a complaint before escalation. If it exceeds their authority, it is escalated immediately.',
  '["رسالة تصعيد داخلية: وصف المشكلة، الإجراءات المتخذة، السبب المحدد للتصعيد، طلب واضح للمشرف"]',
  '["Internal escalation message: problem description, actions taken, specific reason for escalation, clear request for supervisor"]',
  'الرسالة للاستخدام الداخلي فقط — أسلوب مختلف عن التواصل مع العملاء.',
  'The message is for internal use only — different tone from customer communication.',
  '["تُوضح المشكلة بإيجاز وبدقة", "تُذكر الإجراءات المتخذة بشكل محدد", "الطلب من المشرف واضح وقابل للتنفيذ"]',
  '["Problem is described concisely and accurately", "Actions taken are mentioned specifically", "The request to the supervisor is clear and actionable"]',
  'أرسل الرسالة كنص في حقل الإجابة.',
  'Submit the message as text in the answer field.',
  2.0,
  '[{"id":"problem_description","label_ar":"وصف المشكلة","label_en":"Problem Description","description_ar":"هل المشكلة موصوفة بدقة وإيجاز؟","description_en":"Is the problem described accurately and concisely?","weight":2,"passing_score":1},{"id":"actions_taken","label_ar":"الإجراءات المتخذة","label_en":"Actions Taken","description_ar":"هل ذُكرت الإجراءات التي جُرِّبت بوضوح؟","description_en":"Are the attempted actions clearly mentioned?","weight":3,"passing_score":1},{"id":"clear_ask","label_ar":"الطلب الواضح","label_en":"Clear Ask","description_ar":"هل الطلب من المشرف محدد وقابل للتنفيذ؟","description_en":"Is the supervisor request specific and actionable?","weight":3,"passing_score":1}]',
  'published');
-- CS Level 3 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l3, 1, 'إدارة حالة عميل متكاملة', 'End-to-End Customer Case Management',
  'زُوِّدتَ بتاريخ كامل لحالة عميل: أولى رسائله، محادثة الدعم، والنتيجة. قيّم الأداء المُقدَّم وأعدّ تقريرًا يوضح نقاط القوة والضعف ومقترحات التحسين.',
  'You are given the complete history of a customer case: initial messages, support conversation, and outcome. Evaluate the performance shown and prepare a report identifying strengths, weaknesses, and improvement suggestions.',
  'قياس قدرتك على التحليل النقدي لأداء دعم العملاء وتقديم ملاحظات مهنية بنّاءة.',
  'Measure your ability to critically analyze customer support performance and deliver constructive professional feedback.',
  'أنت في اجتماع مراجعة الجودة الأسبوعي. هذه الحالة ستُستخدم لتدريب الموظفين الجدد.',
  'You are in the weekly quality review meeting. This case will be used to train new employees.',
  '["تقرير مكتوب: ثلاثة نقاط قوة، ثلاثة نقاط تحسين، توصية تدريبية واحدة"]',
  '["A written report: three strengths, three improvement areas, one training recommendation"]',
  'اعتمد على الحالة المقدمة فقط. لا تحكم على الموظف شخصيًا — ركّز على السلوك المهني.',
  'Base your analysis only on the provided case. Do not judge the employee personally — focus on professional behavior.',
  '["التقرير يغطي النقاط الست المطلوبة", "التحليل مبني على الحالة وليس تعميمات", "التوصية التدريبية محددة وقابلة للتطبيق"]',
  '["Report covers all six required points", "Analysis is grounded in the case, not generalizations", "Training recommendation is specific and actionable"]',
  'أرسل تقريرك كملف أو نص منظّم.',
  'Submit your report as a file or structured text.',
  3.5,
  '[{"id":"analysis_depth","label_ar":"عمق التحليل","label_en":"Analysis Depth","description_ar":"هل التحليل يتجاوز السطح ويحدد الأسباب الجذرية؟","description_en":"Does the analysis go beyond surface level to identify root causes?","weight":3,"passing_score":1},{"id":"balance","label_ar":"التوازن","label_en":"Balance","description_ar":"هل يتوازن التقرير بين نقاط القوة والضعف؟","description_en":"Does the report balance strengths and weaknesses?","weight":2,"passing_score":1},{"id":"training_rec","label_ar":"التوصية التدريبية","label_en":"Training Recommendation","description_ar":"هل التوصية محددة وتنبثق من التحليل؟","description_en":"Is the recommendation specific and derived from the analysis?","weight":3,"passing_score":1}]',
  'published');

-- CS Level 3 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l3, 2, 'إعداد دليل استجابة للأسئلة الشائعة', 'Preparing a FAQ Response Guide',
  'أعدّ دليلاً يحتوي على 6 أسئلة شائعة وردودها الموصى بها لفريق الدعم.',
  'Prepare a guide containing 6 common questions and their recommended responses for the support team.',
  'قياس قدرتك على إنتاج مواد داخلية منظمة تدعم فريق العمل.',
  'Measure your ability to produce organized internal materials that support the team.',
  'الشركة تُحدِّث دليل الاستجابة كل ربع سنة. الأسئلة مستمدة من الشكاوى الأكثر تكرارًا.',
  'The company updates the response guide every quarter. Questions are derived from the most repeated complaints.',
  '["دليل منظم: السؤال، الرد الموصى به، ملاحظات للموظف (متى يصعِّد، ماذا يتجنب)"]',
  '["Organized guide: the question, recommended response, notes for the employee (when to escalate, what to avoid)"]',
  'الأسئلة يجب أن تكون واقعية ومرتبطة بسياق التجارة الإلكترونية. لا تُكرر نفس السؤال بصياغات مختلفة.',
  'Questions must be realistic and related to e-commerce context. Do not repeat the same question with different wording.',
  '["الدليل يغطي 6 أسئلة مختلفة حقًا", "كل رد يحتوي على الملاحظات الإضافية", "الأسلوب مناسب للاستخدام الداخلي"]',
  '["Guide covers 6 genuinely different questions", "Each response includes additional notes", "Style is appropriate for internal use"]',
  'أرسل الدليل كملف PDF أو DOCX.',
  'Submit the guide as a PDF or DOCX file.',
  3.0,
  '[{"id":"variety","label_ar":"تنوع الأسئلة","label_en":"Question Variety","description_ar":"هل الأسئلة الستة متنوعة وتغطي سيناريوهات مختلفة؟","description_en":"Are the six questions varied and covering different scenarios?","weight":2,"passing_score":1},{"id":"response_quality","label_ar":"جودة الردود","label_en":"Response Quality","description_ar":"هل الردود واضحة ومناسبة للسياق؟","description_en":"Are the responses clear and context-appropriate?","weight":3,"passing_score":1},{"id":"notes_quality","label_ar":"جودة الملاحظات","label_en":"Notes Quality","description_ar":"هل الملاحظات للموظف مفيدة وعملية؟","description_en":"Are the employee notes helpful and practical?","weight":3,"passing_score":1}]',
  'published');

-- CS Level 3 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (cs_l3, 3, 'محاكاة يوم عمل كامل في الدعم', 'Simulating a Full Support Workday',
  'خُذ دور موظف دعم خلال يوم عمل وهمي. زُوِّدتَ بـ 5 تفاعلات متسلسلة مع عملاء مختلفين. أجب على كل منها وقدّم في النهاية تقييمًا ذاتيًا موجزًا.',
  'Take the role of a support agent during a simulated workday. You are given 5 sequential interactions with different customers. Respond to each and provide a brief self-assessment at the end.',
  'قياس قدرتك على الحفاظ على الجودة عبر تفاعلات متعددة ومتنوعة في يوم عمل واحد.',
  'Measure your ability to maintain quality across multiple varied interactions in a single workday.',
  'هذه المحاكاة تعكس يوم عمل حقيقي. كل تفاعل يتطلب أسلوبًا مختلفًا: عميل جديد، عميل غاضب، استفسار تقني، طلب استرداد، بلاغ عن خطأ في الفاتورة.',
  'This simulation reflects a real workday. Each interaction requires a different approach: new customer, angry customer, technical inquiry, refund request, billing error report.',
  '["5 ردود على التفاعلات المُقدَّمة", "تقييم ذاتي: جملتان لكل تفاعل تصف فيهما قرارك وكيف كنت ستتصرف لو كان لديك وقت أكثر"]',
  '["5 responses to the provided interactions", "Self-assessment: two sentences per interaction describing your decision and how you would have acted with more time"]',
  'يجب الإجابة على جميع التفاعلات الخمسة. الترتيب مهم — لا تتجاهل أيًا منها.',
  'You must respond to all five interactions. Order matters — do not skip any.',
  '["جميع التفاعلات الخمسة مُجاب عليها", "الأسلوب يتكيف مع نوع كل تفاعل", "التقييم الذاتي يُظهر وعيًا حقيقيًا بقرارات الموظف"]',
  '["All five interactions have been answered", "Tone adapts to the type of each interaction", "Self-assessment shows genuine awareness of the employee decision-making"]',
  'أرسل ردودك مرتبة ومرقمة في ملف أو نص.',
  'Submit your responses numbered and ordered in a file or text.',
  4.5,
  '[{"id":"adaptability","label_ar":"التكيّف مع السياق","label_en":"Context Adaptability","description_ar":"هل يتكيف الأسلوب مع نوع كل تفاعل؟","description_en":"Does the style adapt to each interaction type?","weight":3,"passing_score":1},{"id":"consistency","label_ar":"الاتساق في الجودة","label_en":"Consistency","description_ar":"هل تُحافظ على جودة الردود عبر التفاعلات الخمسة؟","description_en":"Is quality maintained across all five interactions?","weight":3,"passing_score":1},{"id":"self_awareness","label_ar":"الوعي الذاتي","label_en":"Self-Awareness","description_ar":"هل التقييم الذاتي يعكس تأملًا حقيقيًا وليس مجاملة ذاتية؟","description_en":"Does the self-assessment reflect genuine reflection, not self-flattery?","weight":2,"passing_score":1}]',
  'published');

-- CS Onboarding Unlocks
INSERT INTO onboarding_unlock (role_id, unlocked_at_level, content_type, content_ar, content_en, sort_order) VALUES
(role_customer_support, 1, 'company_context',
 'مرحبًا بك في فريق دعم العملاء لشركة "نوفا ستور" — متجر إلكتروني سعودي متخصص في الإلكترونيات الاستهلاكية، يخدم أكثر من 200,000 عميل عبر المملكة. مهمة فريقنا: أن يشعر كل عميل بأنه محور اهتمامنا، في كل تفاعل.',
 'Welcome to the customer support team at Nova Store — a Saudi e-commerce company specializing in consumer electronics, serving over 200,000 customers across the Kingdom. Our team''s mission: every customer should feel like the center of our attention, in every interaction.',
 1),
(role_customer_support, 2, 'team_structure',
 'فريقنا مكوّن من 12 موظفًا يعملون في ثلاث فترات. كل موظف مسؤول عن إغلاق شكاواه في اليوم ذاته. هناك مشرف واحد لكل فترة، ونظام تذاكر داخلي يسمح بتتبع كل حالة.',
 'Our team consists of 12 agents working in three shifts. Each agent is responsible for closing their complaints the same day. There is one supervisor per shift and an internal ticketing system to track every case.',
 1),
(role_customer_support, 3, 'kpis',
 'مؤشرات نجاحك في هذا الدور: معدل رضا العملاء (CSAT) لا يقل عن 4.2 من 5، وقت أول رد أقل من ساعتين، معدل حل الشكاوى من أول تواصل (FCR) لا يقل عن 75%.',
 'Your success metrics in this role: Customer Satisfaction Score (CSAT) of no less than 4.2/5, First Response Time under two hours, First Contact Resolution (FCR) rate of at least 75%.',
 1);
-- ══════════════════════════════════════════════════════════════
-- ROLE 2: Sales Representative
-- ══════════════════════════════════════════════════════════════
INSERT INTO role (title_ar, title_en, description_ar, description_en, status, is_active)
VALUES ('مندوب مبيعات', 'Sales Representative',
  'بناء علاقات مع العملاء المحتملين، تقديم عروض مبيعات مقنعة، ومتابعة صفقات البيع حتى الإغلاق بما يحقق أهداف الإيرادات.',
  'Build relationships with prospects, deliver persuasive sales pitches, and follow through on deals to closure in a way that meets revenue targets.',
  'published', true
) RETURNING id INTO role_sales_rep;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_sales_rep, 1, 'أساسيات المبيعات', 'Sales Foundations',
  'فهم دورة المبيعات، أسلوب التقديم، وبناء أولى علاقات العملاء.',
  'Understanding the sales cycle, pitch delivery, and building initial client relationships.'
) RETURNING id INTO sr_l1;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_sales_rep, 2, 'التطبيق والمتابعة', 'Application and Follow-up',
  'إعداد عروض مبيعات، التعامل مع الاعتراضات، والمتابعة مع العملاء المحتملين.',
  'Preparing sales proposals, handling objections, and following up with prospects.'
) RETURNING id INTO sr_l2;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_sales_rep, 3, 'محاكاة دورة المبيعات', 'Sales Cycle Simulation',
  'إدارة صفقة كاملة من التواصل الأول حتى الإغلاق أو الرفض مع التوثيق المناسب.',
  'Managing a complete deal from first contact to closure or rejection with appropriate documentation.'
) RETURNING id INTO sr_l3;

-- SR Level 1 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l1, 1, 'كتابة رسالة تعريفية لمنتج', 'Writing a Product Introduction Message',
  'اكتب رسالة تعريفية قصيرة عبر البريد الإلكتروني لتقديم منتج برمجي لإدارة المخازن لشركة تجارية صغيرة في الرياض.',
  'Write a short introductory email to present a warehouse management software product to a small trading company in Riyadh.',
  'قياس قدرتك على صياغة أولى رسائل التواصل مع العملاء المحتملين بشكل مقنع ومركّز.',
  'Measure your ability to craft compelling and focused first-contact messages to prospects.',
  'أنت مندوب مبيعات في شركة تقنية سعودية ناشئة. المنتج يوفر وقت إدارة المخزون بنسبة 40% وفق تقديرات الشركة.',
  'You are a sales rep at a Saudi tech startup. The product saves 40% of inventory management time according to company estimates.',
  '["رسالة بريد إلكتروني باللغة العربية: عنوان، نص (100–130 كلمة)، دعوة للتصرف واحدة"]',
  '["An Arabic email: subject line, body (100–130 words), one call to action"]',
  'رسالة واحدة فقط. لا تذكر أسعارًا. لا تستخدم قائمة نقطية طويلة.',
  'One message only. No pricing. No long bullet-point lists.',
  '["العنوان يستثير فضول القارئ", "النص يركز على فائدة واحدة رئيسية للعميل", "دعوة للتصرف واضحة ومحددة"]',
  '["Subject line sparks reader curiosity", "Body focuses on one key benefit to the customer", "Call to action is clear and specific"]',
  'أرسل الرسالة كاملة في حقل الإجابة.',
  'Submit the complete message in the answer field.',
  1.5,
  '[{"id":"subject","label_ar":"العنوان","label_en":"Subject Line","description_ar":"هل العنوان يستثير الفضول ويدفع للفتح؟","description_en":"Does the subject spark curiosity and encourage opening?","weight":2,"passing_score":1},{"id":"benefit_focus","label_ar":"التركيز على الفائدة","label_en":"Benefit Focus","description_ar":"هل يركز النص على فائدة واضحة للعميل؟","description_en":"Does the body focus on a clear customer benefit?","weight":3,"passing_score":1},{"id":"cta","label_ar":"دعوة للتصرف","label_en":"Call to Action","description_ar":"هل الدعوة للتصرف محددة وغير ملزِمة؟","description_en":"Is the call to action specific and non-pressuring?","weight":3,"passing_score":1}]',
  'published');

-- SR Level 1 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l1, 2, 'تحليل الاعتراضات الشائعة', 'Analyzing Common Objections',
  'لديك قائمة بـ 5 اعتراضات شائعة يقولها العملاء المحتملون. لكل اعتراض، اكتب ردًا مقنعًا.',
  'You have a list of 5 common objections from prospects. For each, write a persuasive response.',
  'قياس قدرتك على التفكير النقدي في الاعتراضات وإعداد ردود فعّالة.',
  'Measure your ability to think critically about objections and prepare effective responses.',
  'الاعتراضات من سياق SaaS في السوق السعودي. مثال: "نحن نستخدم Excel حاليًا ولا نحتاج نظامًا جديدًا".',
  'Objections from a SaaS context in the Saudi market. Example: "We currently use Excel and don''t need a new system."',
  '["جدول: الاعتراض، الرد المقترح، المبدأ الذي يستند إليه الرد"]',
  '["Table: the objection, proposed response, and the principle behind the response"]',
  'استخدم الاعتراضات المقدمة فقط. لا تخترع اعتراضات جديدة. الردود يجب أن تتجنب الاستخفاف أو المجادلة.',
  'Use only the provided objections. Do not invent new ones. Responses must avoid dismissiveness or argumentation.',
  '["كل اعتراض له رد مباشر وغير مواجه", "كل رد مبني على مبدأ مبيعات محدد", "الردود تليق بثقافة الأعمال السعودية"]',
  '["Each objection has a direct, non-confrontational response", "Each response is grounded in a specific sales principle", "Responses are appropriate for Saudi business culture"]',
  'أرسل الجدول كملف أو نص.',
  'Submit the table as a file or text.',
  2.0,
  '[{"id":"directness","label_ar":"المباشرة","label_en":"Directness","description_ar":"هل يرد على الاعتراض مباشرة دون تهرب؟","description_en":"Does the response address the objection directly without deflection?","weight":3,"passing_score":1},{"id":"principle","label_ar":"المبدأ","label_en":"Principle","description_ar":"هل الرد مبني على مبدأ مبيعات محدد وليس فقط حدسًا؟","description_en":"Is the response grounded in a specific sales principle, not just intuition?","weight":2,"passing_score":1},{"id":"cultural_fit","label_ar":"الملاءمة الثقافية","label_en":"Cultural Fit","description_ar":"هل الردود تراعي السياق الثقافي السعودي؟","description_en":"Do the responses respect Saudi cultural business context?","weight":3,"passing_score":1}]',
  'published');

-- SR Level 1 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l1, 3, 'بحث عن عميل محتمل', 'Prospect Research',
  'ابحث عن شركة سعودية حقيقية في قطاع التجزئة (لا تتجاوز 50 موظفًا) قد تستفيد من نظام إدارة المخازن. وثّق ما وجدته واشرح لماذا تعتبرها عميلًا محتملًا مناسبًا.',
  'Research a real Saudi retail company (under 50 employees) that could benefit from a warehouse management system. Document your findings and explain why you consider them a suitable prospect.',
  'قياس قدرتك على البحث المستهدف وتقييم مدى ملاءمة العميل المحتمل.',
  'Measure your ability to conduct targeted research and assess prospect fit.',
  'مرحلة البحث والتأهيل هي أولى خطوات دورة المبيعات. الوقت المُنفق في البحث يوفّر وقتًا أطول في التقديم.',
  'Research and qualification is the first step in the sales cycle. Time spent in research saves more time in pitching.',
  '["ملف تعريف بالشركة: الاسم، القطاع، الحجم التقريبي، احتياج محتمل", "فقرة تبرّر لماذا تُعتبر عميلًا محتملًا مناسبًا"]',
  '["Company profile: name, sector, approximate size, potential need", "A paragraph justifying why they are a suitable prospect"]',
  'يجب أن تكون الشركة حقيقية وموثقة علنيًا. لا تختر شركات كبرى مدرجة في السوق المالية.',
  'The company must be real and publicly documented. Do not choose large publicly listed companies.',
  '["الشركة تتطابق مع معايير الاستهداف المحددة", "الاحتياج المحتمل مبرر بشكل منطقي", "التوثيق يعتمد على مصادر حقيقية"]',
  '["Company matches the specified targeting criteria", "Potential need is logically justified", "Documentation is based on real sources"]',
  'أرسل ملف التعريف كنص أو ملف.',
  'Submit the profile as text or a file.',
  2.5,
  '[{"id":"fit","label_ar":"ملاءمة العميل","label_en":"Prospect Fit","description_ar":"هل تتطابق الشركة مع معايير الاستهداف؟","description_en":"Does the company match the targeting criteria?","weight":3,"passing_score":1},{"id":"need_justification","label_ar":"تبرير الاحتياج","label_en":"Need Justification","description_ar":"هل الاحتياج المحتمل مبرر بمعطيات حقيقية؟","description_en":"Is the potential need justified with real information?","weight":3,"passing_score":1},{"id":"source_quality","label_ar":"جودة المصادر","label_en":"Source Quality","description_ar":"هل استُند إلى مصادر قابلة للتحقق؟","description_en":"Were verifiable sources used?","weight":2,"passing_score":1}]',
  'published');
-- SR Level 2 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l2, 1, 'إعداد عرض مبيعات قصير', 'Preparing a Short Sales Pitch',
  'أعدّ عرضًا مبيعات مكتوبًا لمدة 3 دقائق لتقديم المنتج للعميل المحتمل الذي بحثت عنه في المستوى السابق.',
  'Prepare a written 3-minute sales pitch to present the product to the prospect you researched in the previous level.',
  'قياس قدرتك على بناء عرض مبيعات هيكلي ومقنع ومخصص للعميل.',
  'Measure your ability to build a structured, persuasive, and customer-tailored sales pitch.',
  'لديك موعد 15 دقيقة مع مدير الشركة. الـ 3 دقائق الأولى هي العرض. الباقي للأسئلة.',
  'You have a 15-minute appointment with the company manager. The first 3 minutes are the pitch. The rest is for questions.',
  '["نص العرض مقسمًا إلى: افتتاحية، مشكلة، حل، دعوة للتصرف"]',
  '["Pitch text divided into: opening, problem, solution, call to action"]',
  'العرض مكتوب بأسلوب المحادثة، ليس نقاط تقرير. لا تستخدم أرقامًا تقنية معقدة.',
  'Pitch is written in conversational style, not report bullet points. No complex technical numbers.',
  '["الافتتاحية تستقطب الانتباه خلال 20 ثانية", "المشكلة معرّفة بسياق العميل المحدد", "الدعوة للتصرف واضحة وغير مُلزِمة"]',
  '["Opening captures attention within 20 seconds", "Problem is defined in the specific customer context", "Call to action is clear and non-pressuring"]',
  'أرسل نص العرض في حقل الإجابة أو ملف.',
  'Submit the pitch text in the answer field or as a file.',
  2.5,
  '[{"id":"opening","label_ar":"الافتتاحية","label_en":"Opening","description_ar":"هل الافتتاحية تستقطب الانتباه فورًا؟","description_en":"Does the opening immediately capture attention?","weight":3,"passing_score":1},{"id":"problem_fit","label_ar":"ملاءمة المشكلة","label_en":"Problem Fit","description_ar":"هل المشكلة مُقدَّمة بسياق العميل المحدد؟","description_en":"Is the problem presented in the specific customer context?","weight":3,"passing_score":1},{"id":"cta","label_ar":"دعوة للتصرف","label_en":"Call to Action","description_ar":"هل الدعوة للتصرف واضحة وغير مُلزِمة؟","description_en":"Is the CTA clear and non-pressuring?","weight":2,"passing_score":1}]',
  'published');

-- SR Level 2 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l2, 2, 'تتبع صفقة في CRM وهمي', 'Tracking a Deal in a Mock CRM',
  'زُوِّدتَ بنموذج CRM بسيط. أدخل بيانات الصفقة التي تتابعها وحدّد مرحلتها ووثّق آخر تواصل وخطوتك التالية.',
  'You are given a simple CRM template. Enter your deal data, identify its stage, document the last contact, and note your next action.',
  'قياس قدرتك على توثيق الصفقات بشكل منظم ضمن أدوات المبيعات الأساسية.',
  'Measure your ability to document deals systematically within basic sales tools.',
  'كل صفقة في CRM لها مراحل: اتصال أول، عرض مُقدَّم، قيد المفاوضة، مُغلقة (رابحة/خاسرة).',
  'Every deal in CRM has stages: first contact, pitch delivered, under negotiation, closed (won/lost).',
  '["نموذج CRM مكتمل", "ملاحظة واحدة تشرح قرارك في تحديد مرحلة الصفقة"]',
  '["Completed CRM template", "One note explaining your decision to assign the deal stage"]',
  'استخدم النموذج المقدم — لا تعدّله أو تُعيد تصميمه.',
  'Use the provided template — do not modify or redesign it.',
  '["جميع حقول النموذج مكتملة", "المرحلة المحددة منطقية وفق المعطيات", "الخطوة التالية واضحة وزمنية"]',
  '["All template fields are complete", "Assigned stage is logical given the information", "Next action is clear and time-bound"]',
  'أرسل النموذج المكتمل كملف PDF.',
  'Submit the completed template as a PDF file.',
  2.0,
  '[{"id":"completeness","label_ar":"اكتمال النموذج","label_en":"Template Completeness","description_ar":"هل جميع الحقول المطلوبة مكتملة؟","description_en":"Are all required fields complete?","weight":2,"passing_score":1},{"id":"stage_logic","label_ar":"منطقية المرحلة","label_en":"Stage Logic","description_ar":"هل المرحلة المختارة منطقية وفق المعطيات؟","description_en":"Is the chosen stage logical given the information?","weight":3,"passing_score":1},{"id":"next_action","label_ar":"الخطوة التالية","label_en":"Next Action","description_ar":"هل الخطوة التالية محددة ومُقيَّدة بوقت؟","description_en":"Is the next action specific and time-bound?","weight":3,"passing_score":1}]',
  'published');

-- SR Level 2 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l2, 3, 'بناء خطة متابعة أسبوعية', 'Building a Weekly Follow-up Plan',
  'لديك 6 عملاء محتملين في مراحل مختلفة. أعدّ خطة متابعة أسبوعية تحدد: من ستتواصل معه، متى، وبأي رسالة.',
  'You have 6 prospects at different stages. Prepare a weekly follow-up plan specifying: who you will contact, when, and with what message.',
  'قياس قدرتك على إدارة وقتك وأولوياتك في المبيعات بفاعلية.',
  'Measure your ability to manage your time and priorities in sales effectively.',
  'هدف الأسبوع: إغلاق صفقتين وتحريك ثلاث صفقات للمرحلة التالية.',
  'Week goal: close two deals and advance three others to the next stage.',
  '["جدول أسبوعي: اليوم، العميل، طريقة التواصل، الرسالة الرئيسية، الهدف من التواصل"]',
  '["Weekly table: day, prospect, contact method, main message, goal of the contact"]',
  'لا تحدد أكثر من 3 تواصلات في اليوم الواحد. اعتمد على المعطيات المقدمة.',
  'Do not schedule more than 3 contacts per day. Base on the provided information.',
  '["الخطة تغطي جميع الأيام العملية", "أولويات التواصل منطقية وفق مراحل الصفقات", "كل تواصل له هدف محدد غير مكرر"]',
  '["Plan covers all working days", "Contact priorities are logical based on deal stages", "Each contact has a specific non-repeated goal"]',
  'أرسل الجدول كملف أو نص منظم.',
  'Submit the table as a file or structured text.',
  2.5,
  '[{"id":"coverage","label_ar":"تغطية الأسبوع","label_en":"Week Coverage","description_ar":"هل تغطي الخطة جميع أيام الأسبوع؟","description_en":"Does the plan cover all working days?","weight":2,"passing_score":1},{"id":"priority","label_ar":"ترتيب الأولويات","label_en":"Prioritization","description_ar":"هل أولويات التواصل منطقية وفق مراحل الصفقات؟","description_en":"Are contact priorities logical based on deal stages?","weight":3,"passing_score":1},{"id":"goal_specificity","label_ar":"تحديد الهدف","label_en":"Goal Specificity","description_ar":"هل لكل تواصل هدف محدد وقابل للقياس؟","description_en":"Does each contact have a specific measurable goal?","weight":3,"passing_score":1}]',
  'published');

-- SR Level 3 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l3, 1, 'محاكاة دورة مبيعات كاملة', 'Full Sales Cycle Simulation',
  'اتبع صفقة وهمية من الاتصال الأول حتى الإغلاق. كل مرحلة لها مدخلات وقرارات. وثّق قراراتك وعقلانيتها.',
  'Follow a mock deal from first contact to closure. Each stage has inputs and decisions. Document your decisions and rationale.',
  'قياس قدرتك على إدارة دورة مبيعات كاملة وتوثيق قراراتك باحترافية.',
  'Measure your ability to manage a full sales cycle and document your decisions professionally.',
  'هذه المحاكاة مبنية على 5 مراحل. في كل مرحلة ستُقدَّم لك معطيات جديدة وتُطلب منك قرار واحد موثق.',
  'This simulation is built on 5 stages. At each stage you are given new information and asked to make one documented decision.',
  '["5 قرارات موثقة: القرار، المبرر، المخاطر المحتملة"]',
  '["5 documented decisions: the decision, rationale, potential risks"]',
  'لا تتجاهل أي مرحلة. القرارات يجب أن تكون واقعية ومتسقة مع المراحل السابقة.',
  'Do not skip any stage. Decisions must be realistic and consistent with prior stages.',
  '["جميع المراحل الخمس موثقة", "القرارات متسقة مع مسار الصفقة", "المبررات تبيّن تفكيرًا استراتيجيًا"]',
  '["All five stages are documented", "Decisions are consistent with the deal trajectory", "Rationale demonstrates strategic thinking"]',
  'أرسل التوثيق كملف.',
  'Submit documentation as a file.',
  4.0,
  '[{"id":"stage_completion","label_ar":"اكتمال المراحل","label_en":"Stage Completion","description_ar":"هل وُثِّقت جميع المراحل الخمس؟","description_en":"Were all five stages documented?","weight":2,"passing_score":1},{"id":"consistency","label_ar":"الاتساق","label_en":"Consistency","description_ar":"هل القرارات متسقة مع مسار الصفقة؟","description_en":"Are decisions consistent with the deal trajectory?","weight":3,"passing_score":1},{"id":"strategic_thinking","label_ar":"التفكير الاستراتيجي","label_en":"Strategic Thinking","description_ar":"هل المبررات تبيّن تفكيرًا استراتيجيًا؟","description_en":"Do the rationales demonstrate strategic thinking?","weight":3,"passing_score":1}]',
  'published');

-- SR Level 3 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l3, 2, 'تحليل أسباب خسارة صفقة', 'Analyzing a Lost Deal',
  'زُوِّدتَ بتاريخ صفقة خُسرت. حلّل الأسباب من منظور عملي واقترح ما كان يمكن فعله بشكل مختلف.',
  'You are given the history of a lost deal. Analyze the reasons from a practical perspective and suggest what could have been done differently.',
  'قياس قدرتك على التأمل النقدي في الأداء وتحويل الإخفاقات إلى دروس.',
  'Measure your ability to critically reflect on performance and convert failures into lessons.',
  'ثقافة المبيعات الناضجة تتعامل مع الصفقات الخاسرة كمصدر بيانات لا كفشل شخصي.',
  'A mature sales culture treats lost deals as data sources, not personal failures.',
  '["تقرير تحليلي: 3 أسباب محددة للخسارة، 3 بدائل كان يمكن اتخاذها، درس رئيسي واحد"]',
  '["Analysis report: 3 specific causes of loss, 3 alternatives that could have been taken, one key lesson"]',
  'التحليل يجب أن يكون بنّاءً وغير دفاعي. ركّز على القرارات لا على الشخصية.',
  'Analysis must be constructive and non-defensive. Focus on decisions, not personality.',
  '["الأسباب محددة ومستنتجة من تاريخ الصفقة", "البدائل واقعية وليست متأخرة الحكمة المبالغة", "الدرس قابل للتطبيق في صفقات مستقبلية"]',
  '["Causes are specific and inferred from deal history", "Alternatives are realistic, not excessive hindsight", "Lesson is applicable to future deals"]',
  'أرسل التقرير كملف أو نص.',
  'Submit the report as a file or text.',
  3.0,
  '[{"id":"cause_specificity","label_ar":"تحديد الأسباب","label_en":"Cause Specificity","description_ar":"هل الأسباب محددة ومستنتجة من الحالة؟","description_en":"Are the causes specific and inferred from the case?","weight":3,"passing_score":1},{"id":"alternatives","label_ar":"البدائل","label_en":"Alternatives","description_ar":"هل البدائل واقعية ومعقولة؟","description_en":"Are the alternatives realistic and reasonable?","weight":3,"passing_score":1},{"id":"lesson","label_ar":"الدرس","label_en":"Lesson","description_ar":"هل الدرس قابل للتطبيق وغير بديهي؟","description_en":"Is the lesson actionable and non-obvious?","weight":2,"passing_score":1}]',
  'published');

-- SR Level 3 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (sr_l3, 3, 'إعداد خطة مبيعات شخصية لشهر', 'Building a Personal Monthly Sales Plan',
  'أعدّ خطة مبيعات شخصية لمدة شهر: الهدف الرئيسي، عدد الصفقات المستهدفة، الأنشطة الأسبوعية، وطريقة قياس الأداء.',
  'Prepare a personal monthly sales plan: main target, number of deals targeted, weekly activities, and performance measurement method.',
  'قياس قدرتك على بناء خطة عمل ذاتية والالتزام بإطار قابل للقياس.',
  'Measure your ability to build a self-directed work plan with a measurable framework.',
  'مندوبو المبيعات الناجحون يعملون وفق خطط محددة ومرنة. الهدف الشهري للمندوب الجديد: 3 صفقات مُغلقة.',
  'Successful sales reps operate on specific, flexible plans. Monthly target for a new rep: 3 closed deals.',
  '["خطة شهرية: الهدف، التوزيع الأسبوعي للأنشطة، مؤشر أداء واحد لكل أسبوع"]',
  '["Monthly plan: goal, weekly activity breakdown, one KPI per week"]',
  'الأهداف يجب أن تكون واقعية لمندوب جديد. لا تضع 20 صفقة هدفًا.',
  'Goals must be realistic for a new rep. Do not target 20 deals.',
  '["الهدف الشهري واقعي ومتوافق مع المعيار المعطى", "الأنشطة الأسبوعية مفصلة وليست عامة", "مؤشر الأداء لكل أسبوع محدد وقابل للقياس"]',
  '["Monthly goal is realistic and aligned with the given benchmark", "Weekly activities are detailed, not generic", "KPI for each week is specific and measurable"]',
  'أرسل الخطة كملف أو جدول منظم.',
  'Submit the plan as a file or structured table.',
  3.5,
  '[{"id":"goal_realism","label_ar":"واقعية الهدف","label_en":"Goal Realism","description_ar":"هل الهدف واقعي لمندوب في مرحلة الدخول؟","description_en":"Is the goal realistic for an entry-level rep?","weight":2,"passing_score":1},{"id":"activity_detail","label_ar":"تفصيل الأنشطة","label_en":"Activity Detail","description_ar":"هل الأنشطة الأسبوعية مفصلة وقابلة للتنفيذ؟","description_en":"Are weekly activities detailed and actionable?","weight":3,"passing_score":1},{"id":"measurability","label_ar":"قابلية القياس","label_en":"Measurability","description_ar":"هل مؤشرات الأداء قابلة للقياس الفعلي؟","description_en":"Are the KPIs actually measurable?","weight":3,"passing_score":1}]',
  'published');

-- SR Onboarding Unlocks
INSERT INTO onboarding_unlock (role_id, unlocked_at_level, content_type, content_ar, content_en, sort_order) VALUES
(role_sales_rep, 1, 'company_context',
 'أنت في فريق المبيعات لشركة "تك برايم" — شركة سعودية ناشئة متخصصة في حلول SaaS لقطاع التجزئة الصغيرة والمتوسطة. فريقنا يؤمن أن المبيعات تبدأ بفهم العميل لا بعرض المنتج.',
 'You are on the sales team at TechPrime — a Saudi startup specializing in SaaS solutions for small and medium retail. Our team believes sales start with understanding the customer, not pitching the product.',
 1),
(role_sales_rep, 2, 'tools',
 'نستخدم HubSpot CRM لتتبع الصفقات. كل صفقة يجب تحديثها في نهاية كل يوم. التقرير الأسبوعي يُولَّد تلقائيًا — مهمتك هي دقة البيانات المُدخلة.',
 'We use HubSpot CRM to track deals. Every deal must be updated at the end of each day. The weekly report is auto-generated — your job is the accuracy of the entered data.',
 1),
(role_sales_rep, 3, 'kpis',
 'مؤشرات المندوب الجديد: 20 اتصال مؤهَّل أسبوعيًا، 5 عروض مقدمة، هدف إغلاق 3 صفقات شهريًا. المراجعة كل اثنين في اجتماع 30 دقيقة مع مدير المبيعات.',
 'New rep metrics: 20 qualified calls per week, 5 pitches delivered, monthly closure target of 3 deals. Review every Monday in a 30-minute meeting with the sales manager.',
 1);
-- ══════════════════════════════════════════════════════════════
-- ROLE 3: HR Assistant
-- ══════════════════════════════════════════════════════════════
INSERT INTO role (title_ar, title_en, description_ar, description_en, status, is_active)
VALUES ('مساعد موارد بشرية', 'HR Assistant',
  'دعم عمليات التوظيف والتأهيل وإدارة ملفات الموظفين والمساهمة في بناء بيئة عمل إيجابية.',
  'Support recruitment, onboarding, employee records management, and contribute to building a positive work environment.',
  'published', true
) RETURNING id INTO role_hr_assistant;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_hr_assistant, 1, 'أساسيات الموارد البشرية', 'HR Foundations',
  'فهم دورة الموظف، أساسيات التوظيف، وإدارة الوثائق.',
  'Understanding the employee lifecycle, recruitment basics, and document management.'
) RETURNING id INTO hr_l1;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_hr_assistant, 2, 'العمليات التطبيقية', 'Applied Operations',
  'المشاركة في عمليات التوظيف، تجهيز ملفات الموظفين، وإدارة الإجازات.',
  'Participating in recruitment processes, preparing employee files, and managing leave.'
) RETURNING id INTO hr_l2;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_hr_assistant, 3, 'محاكاة بيئة العمل', 'Workplace Simulation',
  'إدارة عدة مهام موارد بشرية متزامنة وتقديم توصيات إجرائية.',
  'Managing multiple concurrent HR tasks and delivering procedural recommendations.'
) RETURNING id INTO hr_l3;

-- HR Level 1 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l1, 1, 'صياغة إعلان وظيفي', 'Writing a Job Posting',
  'اكتب إعلانًا وظيفيًا لمنصب "موظف خدمة عملاء" في شركة خدمات مالية سعودية.',
  'Write a job posting for a "Customer Service Agent" position at a Saudi financial services company.',
  'قياس قدرتك على صياغة إعلانات وظيفية واضحة وجاذبة.',
  'Measure your ability to write clear and attractive job postings.',
  'الشركة تبحث عن مرشح حاصل على بكالوريوس، خبرة سنة كحد أدنى، يجيد العربية والإنجليزية.',
  'Company seeks a candidate with a bachelor''s degree, minimum one year experience, fluent in Arabic and English.',
  '["إعلان وظيفي كامل: المسمى، الوصف الوظيفي، المتطلبات، المزايا، طريقة التقديم"]',
  '["Complete job posting: title, job description, requirements, benefits, application method"]',
  'الإعلان باللغة العربية. لا تتجاوز 300 كلمة. يجب أن يتوافق مع نظام العمل السعودي.',
  'Posting in Arabic. No more than 300 words. Must comply with Saudi labor regulations.',
  '["الإعلان يغطي جميع العناصر المطلوبة", "المتطلبات واضحة وقابلة للقياس", "الإعلان يتوافق مع نظام العمل السعودي"]',
  '["Posting covers all required elements", "Requirements are clear and measurable", "Posting complies with Saudi labor law"]',
  'أرسل الإعلان في حقل الإجابة أو ملف.',
  'Submit posting in answer field or file.',
  2.0,
  '[{"id":"completeness","label_ar":"اكتمال العناصر","label_en":"Element Completeness","description_ar":"هل يغطي الإعلان جميع العناصر المطلوبة؟","description_en":"Does the posting cover all required elements?","weight":3,"passing_score":1},{"id":"clarity","label_ar":"وضوح المتطلبات","label_en":"Requirements Clarity","description_ar":"هل المتطلبات واضحة وقابلة للقياس؟","description_en":"Are requirements clear and measurable?","weight":3,"passing_score":1},{"id":"compliance","label_ar":"التوافق القانوني","label_en":"Legal Compliance","description_ar":"هل الإعلان يتوافق مع نظام العمل السعودي؟","description_en":"Does the posting comply with Saudi labor law?","weight":2,"passing_score":1}]',
  'published');

-- HR Level 1 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l1, 2, 'مراجعة سيرة ذاتية', 'Reviewing a Resume',
  'زُوِّدتَ بسيرة ذاتية لمتقدم على منصب المستوى الأول. قيّمها وأعط توصية بالاستمرار أو الرفض مع مبررات.',
  'You are given a resume from an applicant for a Level 1 position. Evaluate it and give a continue or reject recommendation with justification.',
  'قياس قدرتك على تقييم السير الذاتية بشكل موضوعي ومنظم.',
  'Measure your ability to evaluate resumes objectively and systematically.',
  'المتطلبات الأساسية: بكالوريوس، إجادة الحاسب، خبرة تطوعية أو عملية ولو بسيطة.',
  'Core requirements: bachelor''s degree, computer proficiency, any volunteer or work experience however minimal.',
  '["ورقة تقييم: نقاط القوة، مواطن الضعف، التوصية مع مبرراتها"]',
  '["Evaluation sheet: strengths, weaknesses, recommendation with justification"]',
  'لا تحكم على المظهر أو الصورة الشخصية — فقط المحتوى والمؤهلات.',
  'Do not judge appearance or personal photo — content and qualifications only.',
  '["التقييم موضوعي ومبني على المعايير المحددة", "نقاط القوة والضعف محددة لا عامة", "التوصية مبررة بشكل واضح"]',
  '["Evaluation is objective and based on specified criteria", "Strengths and weaknesses are specific, not generic", "Recommendation is clearly justified"]',
  'أرسل ورقة التقييم كملف أو نص.',
  'Submit evaluation sheet as file or text.',
  1.5,
  '[{"id":"objectivity","label_ar":"الموضوعية","label_en":"Objectivity","description_ar":"هل التقييم موضوعي ومبني على المعايير؟","description_en":"Is the evaluation objective and criteria-based?","weight":3,"passing_score":1},{"id":"specificity","label_ar":"التحديد","label_en":"Specificity","description_ar":"هل النقاط محددة وليست تعميمات؟","description_en":"Are the points specific and not generalizations?","weight":3,"passing_score":1},{"id":"justification","label_ar":"التبرير","label_en":"Justification","description_ar":"هل التوصية مبررة بشكل واضح؟","description_en":"Is the recommendation clearly justified?","weight":2,"passing_score":1}]',
  'published');

-- HR Level 1 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l1, 3, 'إعداد قائمة وثائق الموظف الجديد', 'Preparing a New Employee Document Checklist',
  'أعدّ قائمة كاملة بالوثائق المطلوبة عند تعيين موظف جديد في شركة سعودية خاصة.',
  'Prepare a complete list of documents required when hiring a new employee at a Saudi private company.',
  'قياس معرفتك بمتطلبات التوثيق الإجرائية في بيئة الأعمال السعودية.',
  'Measure your knowledge of procedural documentation requirements in the Saudi business environment.',
  'اللوائح تشترط توثيق هوية الموظف، مؤهلاته، وعقد العمل قبل بدء الدوام.',
  'Regulations require documenting the employee''s identity, qualifications, and employment contract before the start date.',
  '["قائمة تشمل: اسم الوثيقة، الجهة المصدِرة، الغرض منها، الإلزامية (إلزامي/اختياري)"]',
  '["A list including: document name, issuing authority, purpose, requirement (mandatory/optional)"]',
  'يجب أن تتوافق القائمة مع متطلبات نظام العمل السعودي ونظام التأمينات الاجتماعية.',
  'List must align with Saudi Labor Law and Social Insurance requirements.',
  '["القائمة تشمل الوثائق الإلزامية الأساسية", "التصنيف (إلزامي/اختياري) دقيق", "الغرض من كل وثيقة واضح"]',
  '["List includes core mandatory documents", "Mandatory/optional classification is accurate", "Purpose of each document is clear"]',
  'أرسل القائمة كملف أو نص منظم.',
  'Submit list as file or structured text.',
  1.5,
  '[{"id":"coverage","label_ar":"الشمولية","label_en":"Coverage","description_ar":"هل تشمل القائمة الوثائق الأساسية الإلزامية؟","description_en":"Does the list include the core mandatory documents?","weight":3,"passing_score":1},{"id":"accuracy","label_ar":"الدقة","label_en":"Accuracy","description_ar":"هل التصنيف إلزامي/اختياري دقيق؟","description_en":"Is the mandatory/optional classification accurate?","weight":3,"passing_score":1},{"id":"clarity","label_ar":"الوضوح","label_en":"Clarity","description_ar":"هل الغرض من كل وثيقة موضح بوضوح؟","description_en":"Is the purpose of each document clearly stated?","weight":2,"passing_score":1}]',
  'published');

-- HR Level 2 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l2, 1, 'إجراء مقابلة هيكلية', 'Conducting a Structured Interview',
  'أعدّ قائمة أسئلة مقابلة هيكلية لمنصب "مندوب مبيعات" مدتها 30 دقيقة.',
  'Prepare a structured interview question list for a "Sales Representative" position lasting 30 minutes.',
  'قياس قدرتك على بناء عملية مقابلة عادلة وموضوعية وذات هيكل.',
  'Measure your ability to build a fair, objective, and structured interview process.',
  'المقابلة الهيكلية تضمن عدالة التقييم بين المرشحين وتقلل من التحيز.',
  'Structured interviews ensure fairness across candidates and reduce bias.',
  '["قائمة أسئلة: 8–10 أسئلة مع نوع كل سؤال (سلوكي/موقفي/معرفي) وما يقيسه"]',
  '["Question list: 8-10 questions with each question type (behavioral/situational/knowledge) and what it measures"]',
  'يجب أن تشمل القائمة أسئلة سلوكية على الأقل. لا تشمل أسئلة شخصية أو تتعلق بالديانة أو الحالة الاجتماعية.',
  'List must include at least behavioral questions. No personal, religious, or marital status questions.',
  '["القائمة تتنوع بين الأنواع الثلاثة", "كل سؤال مرتبط بكفاءة محددة للمنصب", "لا تتضمن أسئلة غير مقبولة قانونيًا"]',
  '["List includes all three question types", "Each question is tied to a specific competency for the role", "No legally impermissible questions included"]',
  'أرسل القائمة كملف أو نص.',
  'Submit list as file or text.',
  2.0,
  '[{"id":"variety","label_ar":"تنوع الأسئلة","label_en":"Question Variety","description_ar":"هل تشمل القائمة الأنواع الثلاثة؟","description_en":"Does the list include all three types?","weight":2,"passing_score":1},{"id":"competency_link","label_ar":"الربط بالكفاءات","label_en":"Competency Link","description_ar":"هل كل سؤال مرتبط بكفاءة محددة؟","description_en":"Is each question tied to a specific competency?","weight":3,"passing_score":1},{"id":"compliance","label_ar":"التوافق القانوني","label_en":"Legal Compliance","description_ar":"هل القائمة خالية من الأسئلة غير المقبولة قانونيًا؟","description_en":"Is the list free of legally impermissible questions?","weight":3,"passing_score":1}]',
  'published');

-- HR Level 2 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l2, 2, 'معالجة طلب إجازة', 'Processing a Leave Request',
  'موظف يطلب إجازة اضطرارية لظرف عائلي وهو في منتصف مشروع حساس. كيف ستعالج هذا الطلب؟',
  'An employee is requesting emergency leave for a family matter while in the middle of a critical project. How will you process this request?',
  'قياس قدرتك على تطبيق سياسات الإجازات بعدالة مع مراعاة متطلبات العمل.',
  'Measure your ability to apply leave policies fairly while considering operational requirements.',
  'سياسة الإجازات: للموظف 15 يوم إجازة اضطرارية سنويًا. استخدم منها 8 أيام. المشروع ينتهي خلال أسبوعين.',
  'Leave policy: employee has 15 annual emergency days, has used 8. The project ends in two weeks.',
  '["قرار مكتوب: الموافقة/الرفض/التعديل مع مبرر، خطة التعامل مع الفجوة في العمل"]',
  '["Written decision: approve/reject/modify with justification, plan to handle the work gap"]',
  'القرار يجب أن يراعي حق الموظف وحاجة الشركة معًا.',
  'The decision must balance both the employee''s right and the company''s need.',
  '["القرار محدد وليس مبهمًا", "مبرر القرار يستند إلى السياسة وليس الرأي الشخصي", "خطة التعامل مع الفجوة واقعية"]',
  '["Decision is specific and not vague", "Justification is policy-based, not personal opinion", "Gap handling plan is realistic"]',
  'أرسل القرار والخطة كنص أو ملف.',
  'Submit decision and plan as text or file.',
  2.0,
  '[{"id":"decision_clarity","label_ar":"وضوح القرار","label_en":"Decision Clarity","description_ar":"هل القرار محدد وغير مبهم؟","description_en":"Is the decision specific and unambiguous?","weight":3,"passing_score":1},{"id":"policy_basis","label_ar":"الاستناد إلى السياسة","label_en":"Policy Basis","description_ar":"هل يستند القرار إلى السياسة المعطاة؟","description_en":"Is the decision grounded in the given policy?","weight":3,"passing_score":1},{"id":"gap_plan","label_ar":"خطة الفجوة","label_en":"Gap Plan","description_ar":"هل خطة التعامل مع الفجوة واقعية؟","description_en":"Is the gap handling plan realistic?","weight":2,"passing_score":1}]',
  'published');

-- HR Level 2 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l2, 3, 'تجهيز برنامج تأهيل للموظف الجديد', 'Preparing a New Employee Onboarding Program',
  'صمّم برنامج تأهيل لأسبوع واحد لموظف جديد في قسم المبيعات.',
  'Design a one-week onboarding program for a new employee in the sales department.',
  'قياس قدرتك على تصميم تجربة تأهيل فعّالة وهيكلية.',
  'Measure your ability to design an effective and structured onboarding experience.',
  'الأسبوع الأول يحدد انطباع الموظف الجديد ويؤثر في معدل استمراريته.',
  'The first week shapes the new employee''s impression and affects retention rate.',
  '["جدول أسبوعي يومي: النشاط، المسؤول، الهدف من النشاط، المخرجات المتوقعة"]',
  '["Daily weekly schedule: activity, responsible person, activity goal, expected outputs"]',
  'يجب أن يشمل البرنامج: التعريف بالشركة، التدريب على الأدوات، اللقاء بالفريق، والهدف الأول للموظف.',
  'Program must include: company introduction, tools training, team meeting, and the employee''s first goal.',
  '["البرنامج يغطي الأيام الخمسة", "يشمل العناصر الأربعة المطلوبة", "الأنشطة متدرجة ومنطقية"]',
  '["Program covers all five days", "Includes the four required elements", "Activities are progressive and logical"]',
  'أرسل الجدول كملف أو نص.',
  'Submit schedule as file or text.',
  2.5,
  '[{"id":"coverage","label_ar":"تغطية الأيام","label_en":"Day Coverage","description_ar":"هل يغطي البرنامج الأيام الخمسة كاملة؟","description_en":"Does the program cover all five days?","weight":2,"passing_score":1},{"id":"elements","label_ar":"العناصر الأربعة","label_en":"Four Elements","description_ar":"هل يشمل البرنامج العناصر الأربعة المطلوبة؟","description_en":"Does the program include the four required elements?","weight":3,"passing_score":1},{"id":"progression","label_ar":"التدرج المنطقي","label_en":"Logical Progression","description_ar":"هل الأنشطة متدرجة من العام إلى المتخصص؟","description_en":"Are activities progressive from general to specialized?","weight":3,"passing_score":1}]',
  'published');

-- HR Level 3 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l3, 1, 'محاكاة يوم HR مكثف', 'Simulating an Intensive HR Day',
  'تواجه 4 طلبات متزامنة: تعيين جديد، شكوى موظف، تحديث سياسة، وطلب بيانات من الإدارة. كيف ستتعامل مع كل منها؟',
  'You face 4 simultaneous requests: new hire, employee complaint, policy update, data request from management. How will you handle each?',
  'قياس قدرتك على تحديد الأولويات وإدارة مهام متزامنة في الموارد البشرية.',
  'Measure your ability to prioritize and manage simultaneous HR tasks.',
  'العمل في الموارد البشرية يتطلب التعامل مع طلبات متنافسة في وقت محدود.',
  'HR work requires handling competing requests in limited time.',
  '["خطة تعامل مع الطلبات الأربعة: الأولوية، الإجراء، التوقيت المقدر"]',
  '["A handling plan for the four requests: priority, action, estimated timing"]',
  'يجب أن تبرر ترتيب الأولويات. لا يمكنك تأجيل جميع الطلبات.',
  'You must justify the prioritization. You cannot defer all requests.',
  '["جميع الطلبات الأربعة معالجة", "الأولويات مبررة بمنطق واضح", "التوقيتات واقعية"]',
  '["All four requests are addressed", "Priorities are justified with clear logic", "Timings are realistic"]',
  'أرسل الخطة كملف أو نص.',
  'Submit plan as file or text.',
  3.0,
  '[{"id":"all_addressed","label_ar":"معالجة الكل","label_en":"All Addressed","description_ar":"هل معالجت جميع الطلبات الأربعة؟","description_en":"Were all four requests addressed?","weight":2,"passing_score":1},{"id":"priority_logic","label_ar":"منطق الأولويات","label_en":"Priority Logic","description_ar":"هل ترتيب الأولويات مبرر بمنطق واضح؟","description_en":"Is the prioritization justified with clear logic?","weight":3,"passing_score":1},{"id":"realism","label_ar":"الواقعية","label_en":"Realism","description_ar":"هل التوقيتات واقعية لمسار عمل واحد؟","description_en":"Are the timings realistic for a single work thread?","weight":3,"passing_score":1}]',
  'published');

-- HR Level 3 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l3, 2, 'كتابة سياسة حضور وانصراف', 'Writing an Attendance Policy',
  'اكتب سياسة حضور وانصراف لشركة هجينة (حضور + عن بُعد) تتوافق مع نظام العمل السعودي.',
  'Write an attendance and departure policy for a hybrid company (in-person + remote) that complies with Saudi Labor Law.',
  'قياس قدرتك على صياغة سياسات إجرائية واضحة وملزِمة.',
  'Measure your ability to write clear and binding procedural policies.',
  'الشركة تعمل 5 أيام أسبوعيًا. ساعات العمل: 8 صباحًا إلى 5 مساءً. يوم العمل عن بُعد: الأربعاء.',
  'Company operates 5 days a week. Working hours: 8 AM to 5 PM. Remote day: Wednesday.',
  '["وثيقة سياسة: قواعد الحضور، آلية تسجيل الدوام، عواقب التأخر، استثناءات العمل عن بُعد"]',
  '["Policy document: attendance rules, time recording mechanism, tardiness consequences, remote work exceptions"]',
  'السياسة يجب ألا تتعارض مع نظام العمل السعودي.',
  'Policy must not conflict with Saudi Labor Law.',
  '["السياسة تغطي جميع العناصر الأربعة", "لا تتعارض مع نظام العمل السعودي", "الأسلوب رسمي وقانوني"]',
  '["Policy covers all four elements", "Does not conflict with Saudi Labor Law", "Style is formal and legal"]',
  'أرسل الوثيقة كملف.',
  'Submit document as a file.',
  3.5,
  '[{"id":"completeness","label_ar":"اكتمال السياسة","label_en":"Policy Completeness","description_ar":"هل تغطي السياسة جميع العناصر الأربعة؟","description_en":"Does the policy cover all four elements?","weight":3,"passing_score":1},{"id":"legal_compliance","label_ar":"التوافق القانوني","label_en":"Legal Compliance","description_ar":"هل السياسة تتوافق مع نظام العمل السعودي؟","description_en":"Does the policy comply with Saudi Labor Law?","weight":3,"passing_score":1},{"id":"formality","label_ar":"الرسمية","label_en":"Formality","description_ar":"هل الأسلوب رسمي ومناسب لوثيقة سياسة؟","description_en":"Is the style formal and appropriate for a policy document?","weight":2,"passing_score":1}]',
  'published');

-- HR Level 3 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (hr_l3, 3, 'تحليل بيانات دوران الموظفين', 'Analyzing Employee Turnover Data',
  'بناءً على بيانات وهمية لدوران الموظفين خلال سنة، حلّل الأنماط وقدّم توصيات للإدارة.',
  'Based on mock employee turnover data over one year, analyze the patterns and present recommendations to management.',
  'قياس قدرتك على تحليل بيانات الموارد البشرية واستخلاص توصيات استراتيجية.',
  'Measure your ability to analyze HR data and derive strategic recommendations.',
  'معدل دوران الموظفين في القطاع: 18% سنويًا. بيانات الشركة مقدمة في المشروع.',
  'Industry turnover rate: 18% annually. Company data is provided in the project.',
  '["تقرير تحليلي: معدل الدوران الفعلي، الأنماط الملاحظة، 3 توصيات مبنية على البيانات"]',
  '["Analysis report: actual turnover rate, observed patterns, 3 data-driven recommendations"]',
  'ركّز على الأنماط لا على الأفراد. لا تذكر أسماء وهمية من البيانات.',
  'Focus on patterns, not individuals. Do not mention mock names from the data.',
  '["معدل الدوران محسوب بشكل صحيح", "الأنماط مستنتجة من البيانات لا من افتراضات", "التوصيات محددة وقابلة للتنفيذ"]',
  '["Turnover rate is correctly calculated", "Patterns are inferred from data, not assumptions", "Recommendations are specific and actionable"]',
  'أرسل التقرير كملف أو نص.',
  'Submit report as file or text.',
  3.5,
  '[{"id":"calculation","label_ar":"دقة الحساب","label_en":"Calculation Accuracy","description_ar":"هل حُسب معدل الدوران بشكل صحيح؟","description_en":"Is the turnover rate correctly calculated?","weight":2,"passing_score":1},{"id":"pattern_inference","label_ar":"استنتاج الأنماط","label_en":"Pattern Inference","description_ar":"هل الأنماط مستنتجة من البيانات؟","description_en":"Are patterns inferred from the data?","weight":3,"passing_score":1},{"id":"recommendations","label_ar":"التوصيات","label_en":"Recommendations","description_ar":"هل التوصيات محددة وقابلة للتنفيذ؟","description_en":"Are recommendations specific and actionable?","weight":3,"passing_score":1}]',
  'published');

-- HR Onboarding Unlocks
INSERT INTO onboarding_unlock (role_id, unlocked_at_level, content_type, content_ar, content_en, sort_order) VALUES
(role_hr_assistant, 1, 'company_context',
 'أنت في قسم الموارد البشرية لشركة "الريادة للخدمات المالية" — شركة سعودية تعمل في قطاع التأمين والاستشارات المالية بأكثر من 300 موظف في المملكة. فريق الموارد البشرية يتكون من 5 أعضاء.',
 'You are in the HR department of Al-Riyadah Financial Services — a Saudi company operating in insurance and financial consulting with over 300 employees across the Kingdom. The HR team consists of 5 members.',
 1),
(role_hr_assistant, 2, 'tools',
 'نستخدم نظام "مدد" لإدارة الرواتب والعقود، وصندوق العمل للسعودة ومتابعة نسب نطاقات. كل وثيقة رسمية تمر عبر منصة موارد.',
 'We use the "Mudd" system for salary and contract management, and the Labor Fund for Saudization tracking and Nitaqat compliance. All official documents go through the Mawarid platform.',
 1),
(role_hr_assistant, 3, 'kpis',
 'مؤشراتك الأساسية: وقت إغلاق الشاغر (هدف: أقل من 30 يومًا)، رضا الموظفين الجدد بعد 90 يومًا (هدف: 80%+)، معدل دوران الموظفين دون 15% سنويًا.',
 'Your core metrics: time-to-fill (target: under 30 days), new employee satisfaction at 90 days (target: 80%+), employee turnover rate under 15% annually.',
 1);
-- ══════════════════════════════════════════════════════════════
-- ROLE 4: Marketing Coordinator
-- ══════════════════════════════════════════════════════════════
INSERT INTO role (title_ar, title_en, description_ar, description_en, status, is_active)
VALUES ('منسق تسويق', 'Marketing Coordinator',
  'دعم تنفيذ الحملات التسويقية، إنتاج المحتوى، وتتبع الأداء عبر القنوات الرقمية.',
  'Support marketing campaign execution, content production, and performance tracking across digital channels.',
  'published', true
) RETURNING id INTO role_marketing_coord;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_marketing_coord, 1, 'أساسيات التسويق', 'Marketing Foundations',
  'فهم أساسيات العلامة التجارية والمحتوى والجمهور المستهدف.',
  'Understanding brand fundamentals, content basics, and target audience.'
) RETURNING id INTO mc_l1;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_marketing_coord, 2, 'تنفيذ الحملات', 'Campaign Execution',
  'إعداد خطط المحتوى، تنفيذ حملات بسيطة، وقياس النتائج.',
  'Preparing content plans, executing simple campaigns, and measuring results.'
) RETURNING id INTO mc_l2;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_marketing_coord, 3, 'محاكاة دور تسويقي', 'Marketing Role Simulation',
  'إدارة حملة كاملة وتقديم تقرير أداء مهني.',
  'Managing a full campaign and delivering a professional performance report.'
) RETURNING id INTO mc_l3;

-- MC Level 1 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l1, 1, 'تحليل الجمهور المستهدف', 'Target Audience Analysis',
  'لمنتج عطور نسائية فاخرة سعودية، صِف شريحة الجمهور المستهدف الرئيسية بالتفصيل.',
  'For a luxury Saudi women''s perfume product, describe the primary target audience segment in detail.',
  'قياس قدرتك على بناء صورة دقيقة ومتعمقة للجمهور المستهدف.',
  'Measure your ability to build an accurate and in-depth target audience profile.',
  'العلامة التجارية تُركّز على الأصالة السعودية مع حداثة التصميم. المنتج بسعر 300–500 ريال.',
  'The brand focuses on Saudi authenticity with modern design. Product priced at 300–500 SAR.',
  '["ملف الجمهور: العمر، المستوى المعيشي، الاهتمامات، القنوات المفضلة، الدافع للشراء"]',
  '["Audience profile: age, lifestyle level, interests, preferred channels, purchase motivation"]',
  'اعتمد على المنطق والمعرفة بالسوق السعودي. لا تنسخ تعريفات أكاديمية عامة.',
  'Base on logic and knowledge of the Saudi market. Do not copy generic academic definitions.',
  '["الملف محدد وليس تعميمًا", "يراعي السياق السعودي والثقافي", "الدافع للشراء واقعي ومقنع"]',
  '["Profile is specific, not a generalization", "Considers Saudi cultural context", "Purchase motivation is realistic and convincing"]',
  'أرسل الملف كنص أو وثيقة.',
  'Submit profile as text or document.',
  1.5,
  '[{"id":"specificity","label_ar":"التحديد","label_en":"Specificity","description_ar":"هل الملف محدد ويتجنب التعميم؟","description_en":"Is the profile specific and avoids generalization?","weight":3,"passing_score":1},{"id":"cultural_context","label_ar":"السياق الثقافي","label_en":"Cultural Context","description_ar":"هل يراعي السياق السعودي والثقافي؟","description_en":"Does it consider Saudi cultural context?","weight":3,"passing_score":1},{"id":"motivation","label_ar":"الدافع","label_en":"Motivation","description_ar":"هل دافع الشراء واقعي ومقنع؟","description_en":"Is the purchase motivation realistic and convincing?","weight":2,"passing_score":1}]',
  'published');

-- MC Level 1 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l1, 2, 'كتابة نسخة إعلانية', 'Writing Ad Copy',
  'اكتب نسختين إعلانيتين قصيرتين للمنتج: واحدة لتويتر (أقل من 280 حرف) وواحدة لإنستغرام (100–150 كلمة).',
  'Write two short ad copies for the product: one for Twitter (under 280 characters) and one for Instagram (100–150 words).',
  'قياس قدرتك على تكييف المحتوى حسب القناة مع الحفاظ على هوية العلامة التجارية.',
  'Measure your ability to adapt content per channel while maintaining brand identity.',
  'العلامة التجارية: أصيلة، فاخرة، سعودية الهوية. هاشتاق العلامة: #عطرك_يحكي.',
  'Brand voice: authentic, luxurious, Saudi identity. Brand hashtag: #عطرك_يحكي.',
  '["نسخة تويتر (أقل من 280 حرف بالعربية)", "نسخة إنستغرام (100–150 كلمة بالعربية)"]',
  '["Twitter copy (under 280 Arabic characters)", "Instagram copy (100–150 Arabic words)"]',
  'لا تستخدم كلمة "أفضل" أو "الأول". التزم بحدود الكلمات.',
  'Do not use the words "best" or "first". Respect word limits.',
  '["كلا النسختين ضمن الحدود المحددة", "الصوت العلامي متسق في النسختين", "الهاشتاق مُدرج في إنستغرام"]',
  '["Both copies within the specified limits", "Brand voice consistent in both", "Hashtag included in Instagram copy"]',
  'أرسل النسختين في حقل الإجابة.',
  'Submit both copies in the answer field.',
  1.5,
  '[{"id":"limits","label_ar":"الالتزام بالحدود","label_en":"Limit Compliance","description_ar":"هل كلا النسختين ضمن الحدود المحددة؟","description_en":"Are both copies within the specified limits?","weight":2,"passing_score":1},{"id":"brand_voice","label_ar":"صوت العلامة","label_en":"Brand Voice","description_ar":"هل الصوت العلامي متسق في النسختين؟","description_en":"Is the brand voice consistent in both copies?","weight":3,"passing_score":1},{"id":"engagement","label_ar":"جاذبية المحتوى","label_en":"Content Appeal","description_ar":"هل المحتوى جذّاب ويدفع للتفاعل؟","description_en":"Is the content engaging and drives interaction?","weight":3,"passing_score":1}]',
  'published');

-- MC Level 1 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l1, 3, 'تحليل منافس', 'Competitor Analysis',
  'اختر علامة عطور سعودية حقيقية واحدة وحلّل حضورها الرقمي.',
  'Choose one real Saudi perfume brand and analyze its digital presence.',
  'قياس قدرتك على البحث التسويقي وتحليل المنافسين.',
  'Measure your ability to conduct marketing research and analyze competitors.',
  'تحليل المنافسين يساعد على تحديد الفجوات والفرص.',
  'Competitor analysis helps identify gaps and opportunities.',
  '["تقرير تحليلي: قنوات التواصل، أسلوب المحتوى، نقاط القوة، نقاط الضعف، فرصة واحدة لمنتجنا"]',
  '["Analysis report: social channels, content style, strengths, weaknesses, one opportunity for our product"]',
  'اعتمد على ما هو مرئي للعموم. لا تقتبس أرقامًا لا يمكنك التحقق منها.',
  'Base on publicly visible content. Do not cite numbers you cannot verify.',
  '["العلامة المختارة حقيقية وسعودية", "التحليل مبني على مشاهدة فعلية", "الفرصة المحددة منطقية وليست عامة"]',
  '["Chosen brand is real and Saudi", "Analysis is based on actual observation", "Identified opportunity is logical and specific"]',
  'أرسل التقرير كملف أو نص.',
  'Submit report as file or text.',
  2.0,
  '[{"id":"real_brand","label_ar":"واقعية العلامة","label_en":"Brand Reality","description_ar":"هل العلامة المختارة حقيقية وسعودية؟","description_en":"Is the chosen brand real and Saudi?","weight":1,"passing_score":1},{"id":"observation_basis","label_ar":"الاستناد للمشاهدة","label_en":"Observation Basis","description_ar":"هل التحليل مبني على مشاهدة فعلية؟","description_en":"Is the analysis based on actual observation?","weight":3,"passing_score":1},{"id":"opportunity","label_ar":"الفرصة","label_en":"Opportunity","description_ar":"هل الفرصة منطقية ومحددة؟","description_en":"Is the opportunity logical and specific?","weight":3,"passing_score":1}]',
  'published');

-- MC Level 2 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l2, 1, 'إعداد خطة محتوى أسبوعية', 'Preparing a Weekly Content Plan',
  'أعدّ خطة محتوى لأسبوع واحد لحساب إنستغرام علامة العطور (5 منشورات).',
  'Prepare a one-week content plan for the perfume brand''s Instagram account (5 posts).',
  'قياس قدرتك على التخطيط المنهجي للمحتوى بما يتوافق مع أهداف الحملة.',
  'Measure your ability to systematically plan content aligned with campaign goals.',
  'الهدف الأسبوعي: رفع الوعي بمنتج جديد ضمن مجموعة صيف 2025.',
  'Weekly goal: raising awareness of a new product in the Summer 2025 collection.',
  '["جدول خطة المحتوى: اليوم، نوع المنشور، الرسالة الرئيسية، الهاشتاقات، الدعوة للتصرف"]',
  '["Content plan table: day, post type, main message, hashtags, call to action"]',
  'المنشورات الخمسة يجب أن تتنوع (منتج، قصة، تفاعلي، تثقيفي، ترويجي). لا تكرر النوع.',
  'The five posts must vary (product, story, interactive, educational, promotional). No type repetition.',
  '["الخطة تغطي 5 منشورات متنوعة", "الرسائل الرئيسية متسقة مع هدف الحملة", "الدعوات للتصرف مختلفة ومناسبة لكل نوع"]',
  '["Plan covers 5 varied posts", "Main messages consistent with campaign goal", "CTAs are different and appropriate per post type"]',
  'أرسل الجدول كملف أو نص.',
  'Submit table as file or text.',
  2.0,
  '[{"id":"variety","label_ar":"تنوع المنشورات","label_en":"Post Variety","description_ar":"هل تتنوع أنواع المنشورات الخمسة؟","description_en":"Are the five post types varied?","weight":2,"passing_score":1},{"id":"message_alignment","label_ar":"توافق الرسائل","label_en":"Message Alignment","description_ar":"هل الرسائل متسقة مع هدف الحملة؟","description_en":"Are messages consistent with the campaign goal?","weight":3,"passing_score":1},{"id":"cta_variety","label_ar":"تنوع الدعوات","label_en":"CTA Variety","description_ar":"هل الدعوات للتصرف مختلفة ومناسبة؟","description_en":"Are CTAs different and appropriate?","weight":3,"passing_score":1}]',
  'published');

-- MC Level 2 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l2, 2, 'قياس أداء منشور', 'Measuring Post Performance',
  'زُوِّدتَ ببيانات أداء 3 منشورات. حللها وحدد أيها الأفضل أداءً ولماذا.',
  'You are given performance data for 3 posts. Analyze them and identify the best performer and why.',
  'قياس قدرتك على قراءة بيانات الأداء واستخلاص رؤى قابلة للتطبيق.',
  'Measure your ability to read performance data and derive actionable insights.',
  'مقاييس مقدمة: المشاهدات، التفاعلات، النقرات، الوصول. الهدف كان زيادة الوصول بـ 20%.',
  'Provided metrics: views, engagements, clicks, reach. Goal was a 20% reach increase.',
  '["تحليل مكتوب: الأداء النسبي للمنشورات الثلاثة، العوامل المؤثرة، توصية واحدة للمنشور القادم"]',
  '["Written analysis: relative performance of three posts, influencing factors, one recommendation for next post"]',
  'ركّز على الأرقام المقدمة فقط. لا تحلل عوامل خارجية لا تعكسها البيانات.',
  'Focus only on the provided numbers. Do not analyze external factors not reflected in the data.',
  '["التحليل يستند إلى الأرقام المقدمة", "العوامل المؤثرة منطقية ومستنتجة", "التوصية محددة وقابلة للتطبيق"]',
  '["Analysis is based on provided numbers", "Influencing factors are logical and inferred", "Recommendation is specific and actionable"]',
  'أرسل التحليل كنص أو ملف.',
  'Submit analysis as text or file.',
  2.0,
  '[{"id":"data_basis","label_ar":"الاستناد للبيانات","label_en":"Data Basis","description_ar":"هل يستند التحليل إلى الأرقام المقدمة؟","description_en":"Is the analysis based on the provided numbers?","weight":3,"passing_score":1},{"id":"factor_logic","label_ar":"منطق العوامل","label_en":"Factor Logic","description_ar":"هل العوامل المؤثرة منطقية ومستنتجة؟","description_en":"Are the influencing factors logical and inferred?","weight":3,"passing_score":1},{"id":"recommendation","label_ar":"التوصية","label_en":"Recommendation","description_ar":"هل التوصية محددة وقابلة للتطبيق؟","description_en":"Is the recommendation specific and actionable?","weight":2,"passing_score":1}]',
  'published');

-- MC Level 2 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l2, 3, 'إعداد ميزانية حملة محدودة', 'Preparing a Limited Campaign Budget',
  'خُصِّص لك ميزانية 5,000 ريال لحملة وعي على إنستغرام وسناب. وزّع الميزانية ومبرر توزيعها.',
  'You have a 5,000 SAR budget for an awareness campaign on Instagram and Snapchat. Distribute the budget and justify the distribution.',
  'قياس قدرتك على اتخاذ قرارات توزيع ميزانية مدروسة ومبررة.',
  'Measure your ability to make thoughtful and justified budget allocation decisions.',
  'الجمهور المستهدف: نساء سعوديات 20–35 سنة. هدف الحملة: الوعي بمنتج جديد.',
  'Target audience: Saudi women aged 20–35. Campaign goal: awareness of a new product.',
  '["جدول توزيع الميزانية: القناة، المبلغ، النوع (محتوى مدفوع/عضوي/مؤثرون)، المبرر"]',
  '["Budget distribution table: channel, amount, type (paid/organic/influencers), justification"]',
  'المجموع يجب أن يساوي 5,000 ريال بالضبط. لا تتجاوز منصتين.',
  'Total must equal exactly 5,000 SAR. Do not exceed two platforms.',
  '["المجموع يساوي 5,000 ريال بالضبط", "التوزيع مبرر بمنطق يعكس الجمهور المستهدف", "التوزيع بين القنوات معقول"]',
  '["Total equals exactly 5,000 SAR", "Distribution is justified with logic reflecting target audience", "Cross-channel allocation is reasonable"]',
  'أرسل الجدول كملف أو نص.',
  'Submit table as file or text.',
  2.0,
  '[{"id":"total_accuracy","label_ar":"دقة المجموع","label_en":"Total Accuracy","description_ar":"هل المجموع يساوي 5,000 ريال بالضبط؟","description_en":"Does the total equal exactly 5,000 SAR?","weight":2,"passing_score":1},{"id":"justification","label_ar":"التبرير","label_en":"Justification","description_ar":"هل التوزيع مبرر بمنطق يعكس الجمهور؟","description_en":"Is the distribution justified by audience-reflective logic?","weight":3,"passing_score":1},{"id":"allocation_sense","label_ar":"معقولية التوزيع","label_en":"Allocation Sense","description_ar":"هل التوزيع بين القنوات معقول للسوق السعودي؟","description_en":"Is the cross-channel allocation reasonable for the Saudi market?","weight":3,"passing_score":1}]',
  'published');

-- MC Level 3 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l3, 1, 'إدارة حملة رمضانية كاملة', 'Managing a Complete Ramadan Campaign',
  'خطّط لحملة تسويقية رمضانية من الأسبوع الأول لرمضان حتى العيد لعلامة العطور. الميزانية: 15,000 ريال.',
  'Plan a Ramadan marketing campaign from the first week of Ramadan to Eid for the perfume brand. Budget: 15,000 SAR.',
  'قياس قدرتك على التخطيط التسويقي الموسمي المتكامل.',
  'Measure your ability to execute integrated seasonal marketing planning.',
  'رمضان هو الموسم الأعلى مبيعًا للعطور في السوق السعودي. المنافسة شديدة. الفرصة عالية.',
  'Ramadan is the highest-selling season for perfumes in the Saudi market. Competition is intense. Opportunity is high.',
  '["خطة حملة: الأهداف، التوزيع الأسبوعي للمحتوى، توزيع الميزانية، مؤشرات النجاح"]',
  '["Campaign plan: objectives, weekly content distribution, budget allocation, success metrics"]',
  'الخطة تغطي 4 أسابيع رمضانية + أسبوع عيد. راعِ الحساسيات الثقافية والدينية في المحتوى.',
  'Plan covers 4 Ramadan weeks + Eid week. Respect cultural and religious sensitivities in content.',
  '["الخطة تغطي الأسابيع الخمسة", "مؤشرات النجاح قابلة للقياس", "المحتوى يراعي الحساسيات الثقافية والدينية"]',
  '["Plan covers the five weeks", "Success metrics are measurable", "Content respects cultural and religious sensitivities"]',
  'أرسل الخطة كملف.',
  'Submit plan as a file.',
  4.0,
  '[{"id":"coverage","label_ar":"تغطية الأسابيع","label_en":"Week Coverage","description_ar":"هل تغطي الخطة الأسابيع الخمسة؟","description_en":"Does the plan cover all five weeks?","weight":2,"passing_score":1},{"id":"metrics","label_ar":"مؤشرات القياس","label_en":"Success Metrics","description_ar":"هل مؤشرات النجاح قابلة للقياس الفعلي؟","description_en":"Are success metrics actually measurable?","weight":3,"passing_score":1},{"id":"cultural_sensitivity","label_ar":"الحساسية الثقافية","label_en":"Cultural Sensitivity","description_ar":"هل المحتوى يراعي الحساسيات الثقافية والدينية؟","description_en":"Does the content respect cultural and religious sensitivities?","weight":3,"passing_score":1}]',
  'published');

-- MC Level 3 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l3, 2, 'تقرير أداء حملة', 'Campaign Performance Report',
  'بناءً على بيانات وهمية لحملة منتهية، أعدّ تقرير أداء احترافيًا للإدارة.',
  'Based on mock data for a completed campaign, prepare a professional performance report for management.',
  'قياس قدرتك على تلخيص نتائج الحملات وتقديمها بأسلوب إداري احترافي.',
  'Measure your ability to summarize campaign results and present them in a professional management style.',
  'الإدارة تريد: ماذا حققنا، ماذا لم نحقق، لماذا، ماذا نفعل لاحقًا.',
  'Management wants: what we achieved, what we didn''t, why, and what to do next.',
  '["تقرير: الأهداف مقابل الإنجازات، تحليل الفجوة، 3 دروس مستفادة، خطوات مستقبلية"]',
  '["Report: objectives vs. achievements, gap analysis, 3 lessons learned, future steps"]',
  'لا تُقدّم البيانات فقط — التحليل هو المطلوب. اجعل التقرير قابلاً للقراءة في أقل من 5 دقائق.',
  'Don''t just present data — analysis is required. Make the report readable in under 5 minutes.',
  '["التقرير يتبع الهيكل المطلوب", "التحليل يفسر الفجوات لا يكتفي برصدها", "الدروس محددة وليست تعميمات"]',
  '["Report follows the required structure", "Analysis explains gaps, not just records them", "Lessons are specific, not generalizations"]',
  'أرسل التقرير كملف.',
  'Submit report as a file.',
  3.5,
  '[{"id":"structure","label_ar":"الهيكل","label_en":"Structure","description_ar":"هل يتبع التقرير الهيكل المطلوب؟","description_en":"Does the report follow the required structure?","weight":2,"passing_score":1},{"id":"analysis_depth","label_ar":"عمق التحليل","label_en":"Analysis Depth","description_ar":"هل يُفسر التحليل الفجوات لا يكتفي برصدها؟","description_en":"Does the analysis explain gaps, not just record them?","weight":3,"passing_score":1},{"id":"lessons","label_ar":"الدروس","label_en":"Lessons","description_ar":"هل الدروس المستفادة محددة وغير بديهية؟","description_en":"Are the lessons specific and non-obvious?","weight":3,"passing_score":1}]',
  'published');

-- MC Level 3 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (mc_l3, 3, 'بناء خطة تسويق شهرية', 'Building a Monthly Marketing Plan',
  'أعدّ خطة تسويق شهرية كاملة للعلامة: الأهداف، القنوات، الميزانية، التقويم، المؤشرات.',
  'Prepare a complete monthly marketing plan for the brand: objectives, channels, budget, calendar, metrics.',
  'قياس قدرتك على بناء خطة تسويق شاملة قابلة للتنفيذ.',
  'Measure your ability to build a comprehensive and actionable marketing plan.',
  'هذه الخطة هي عملك الأول كمنسق تسويق. ستُقدَّم للمدير التسويقي في اجتماع الاثنين.',
  'This plan is your first deliverable as marketing coordinator. It will be presented to the marketing manager in the Monday meeting.',
  '["وثيقة خطة شاملة: الأهداف SMART، القنوات وتبريرها، الميزانية التقديرية، تقويم المحتوى، مؤشرات الأداء"]',
  '["Comprehensive plan document: SMART objectives, channels with justification, estimated budget, content calendar, KPIs"]',
  'الأهداف يجب أن تتبع صيغة SMART. الميزانية تقديرية — لا أرقام حقيقية مطلوبة.',
  'Objectives must follow SMART format. Budget is estimated — no real numbers required.',
  '["الأهداف على صيغة SMART", "القنوات مبررة بالجمهور المستهدف", "المؤشرات قابلة للقياس الفعلي"]',
  '["Objectives follow SMART format", "Channels are justified by target audience", "KPIs are actually measurable"]',
  'أرسل الخطة كملف.',
  'Submit plan as a file.',
  4.5,
  '[{"id":"smart_goals","label_ar":"أهداف SMART","label_en":"SMART Goals","description_ar":"هل الأهداف تتبع صيغة SMART؟","description_en":"Do the objectives follow SMART format?","weight":3,"passing_score":1},{"id":"channel_justification","label_ar":"تبرير القنوات","label_en":"Channel Justification","description_ar":"هل القنوات مبررة بالجمهور المستهدف؟","description_en":"Are channels justified by target audience?","weight":3,"passing_score":1},{"id":"measurability","label_ar":"قابلية القياس","label_en":"Measurability","description_ar":"هل المؤشرات قابلة للقياس الفعلي؟","description_en":"Are KPIs actually measurable?","weight":2,"passing_score":1}]',
  'published');

-- MC Onboarding Unlocks
INSERT INTO onboarding_unlock (role_id, unlocked_at_level, content_type, content_ar, content_en, sort_order) VALUES
(role_marketing_coord, 1, 'company_context',
 'أنت في فريق التسويق لشركة "هالة للعطور" — علامة سعودية راقية تجمع بين الأصالة العربية وأسلوب الحياة العصري. نستهدف المرأة السعودية الواثقة بنفسها في الفئة العمرية 20–40 سنة.',
 'You are on the marketing team at Hala Perfumes — a premium Saudi brand combining Arabic authenticity with modern lifestyle. We target the confident Saudi woman in the 20–40 age group.',
 1),
(role_marketing_coord, 2, 'tools',
 'نستخدم Canva للتصميم، Google Analytics لتتبع الموقع، Meta Business Suite لإدارة حسابات إنستغرام وفيسبوك، وSprout Social لجدولة المحتوى وقياس الأداء.',
 'We use Canva for design, Google Analytics for website tracking, Meta Business Suite to manage Instagram and Facebook accounts, and Sprout Social for content scheduling and performance measurement.',
 1),
(role_marketing_coord, 3, 'kpis',
 'مؤشرات الأداء الشهرية: نمو المتابعين +5%، معدل تفاعل لا يقل عن 3.5%، 20,000 مشاهدة على محتوى العلامة.',
 'Monthly performance indicators: follower growth +5%, engagement rate minimum 3.5%, 20,000 views on brand content.',
 1);
-- ══════════════════════════════════════════════════════════════
-- ROLE 5: Data Analyst
-- ══════════════════════════════════════════════════════════════
INSERT INTO role (title_ar, title_en, description_ar, description_en, status, is_active)
VALUES ('محلل بيانات', 'Data Analyst',
  'جمع البيانات وتنظيمها وتحليلها وتقديم رؤى قابلة للتطبيق تدعم قرارات الأعمال.',
  'Collect, organize, analyze data, and deliver actionable insights that support business decisions.',
  'published', true
) RETURNING id INTO role_data_analyst;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_data_analyst, 1, 'أساسيات تحليل البيانات', 'Data Analysis Foundations',
  'فهم أنواع البيانات والإحصاء الوصفي وقراءة التقارير.',
  'Understanding data types, descriptive statistics, and reading reports.'
) RETURNING id INTO da_l1;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_data_analyst, 2, 'التحليل التطبيقي', 'Applied Analysis',
  'العمل مع بيانات حقيقية، الجداول المحورية، ورسم المخططات.',
  'Working with real data, pivot tables, and creating charts.'
) RETURNING id INTO da_l2;

INSERT INTO level (role_id, level_number, title_ar, title_en, description_ar, description_en)
VALUES (role_data_analyst, 3, 'محاكاة دور المحلل', 'Analyst Role Simulation',
  'إنتاج تقارير تحليلية متكاملة وتقديم توصيات مبنية على البيانات.',
  'Producing comprehensive analytical reports and delivering data-driven recommendations.'
) RETURNING id INTO da_l3;

-- DA Level 1 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l1, 1, 'قراءة تقرير مبيعات وتلخيصه', 'Reading and Summarizing a Sales Report',
  'زُوِّدتَ بتقرير مبيعات شهري لشركة تجارية. لخّصه في نقاط رئيسية وحدد 3 استنتاجات.',
  'You are given a monthly sales report for a trading company. Summarize it in key points and identify 3 conclusions.',
  'قياس قدرتك على استخلاص المعلومات الرئيسية من تقارير الأعمال.',
  'Measure your ability to extract key information from business reports.',
  'التقرير يحتوي على جداول وأرقام مبيعات لـ 6 أشهر عبر 4 مناطق سعودية.',
  'The report contains tables and sales figures for 6 months across 4 Saudi regions.',
  '["ملخص نقاطي: 5–7 نقاط رئيسية", "3 استنتاجات مبنية على الأرقام"]',
  '["Bullet summary: 5-7 key points", "3 conclusions based on the numbers"]',
  'الاستنتاجات يجب أن تستند إلى الأرقام المقدمة لا إلى معرفة خارجية.',
  'Conclusions must be based on the provided numbers, not external knowledge.',
  '["الملخص يغطي المحاور الرئيسية للتقرير", "الاستنتاجات مستنتجة من الأرقام مباشرة", "لا افتراضات بدون بيانات داعمة"]',
  '["Summary covers the main dimensions of the report", "Conclusions are directly inferred from the numbers", "No assumptions without supporting data"]',
  'أرسل الملخص والاستنتاجات كنص أو ملف.',
  'Submit summary and conclusions as text or file.',
  1.5,
  '[{"id":"summary_quality","label_ar":"جودة الملخص","label_en":"Summary Quality","description_ar":"هل يغطي الملخص المحاور الرئيسية؟","description_en":"Does the summary cover the main dimensions?","weight":2,"passing_score":1},{"id":"data_inference","label_ar":"الاستنتاج من البيانات","label_en":"Data Inference","description_ar":"هل الاستنتاجات مبنية على الأرقام مباشرة؟","description_en":"Are conclusions directly based on the numbers?","weight":3,"passing_score":1},{"id":"no_assumptions","label_ar":"غياب الافتراضات","label_en":"No Assumptions","description_ar":"هل يتجنب التحليل الافتراضات غير المدعومة بالبيانات؟","description_en":"Does the analysis avoid unsupported assumptions?","weight":3,"passing_score":1}]',
  'published');

-- DA Level 1 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l1, 2, 'حساب إحصاءات وصفية', 'Calculating Descriptive Statistics',
  'زُوِّدتَ بمجموعة بيانات مبيعات يومية لـ 30 يومًا. احسب: المتوسط، الوسيط، الانحراف المعياري، ووضّح ما تعنيه للأعمال.',
  'You are given a daily sales dataset for 30 days. Calculate: mean, median, standard deviation, and explain what they mean for the business.',
  'قياس قدرتك على تطبيق الإحصاء الوصفي وترجمة الأرقام إلى معنى تجاري.',
  'Measure your ability to apply descriptive statistics and translate numbers into business meaning.',
  'هذه الإحصاءات تُستخدم في تقييم استقرار المبيعات وتوقع الأداء.',
  'These statistics are used to assess sales stability and forecast performance.',
  '["جدول الإحصاءات الثلاثة مع الحسابات", "شرح مكتوب: ماذا يعني كل رقم للأعمال (جملتان لكل إحصاءة)"]',
  '["Table of three statistics with calculations", "Written explanation: what each number means for the business (two sentences per statistic)"]',
  'أظهر خطوات الحساب أو المعادلة المستخدمة. لا تكتفي بالنتيجة فقط.',
  'Show calculation steps or the formula used. Do not present only the result.',
  '["الحسابات صحيحة رياضيًا", "الشرح التجاري واضح ومبني على القيمة العددية", "خطوات الحساب ظاهرة"]',
  '["Calculations are mathematically correct", "Business explanation is clear and based on numerical value", "Calculation steps are shown"]',
  'أرسل الجدول والشرح كملف أو نص.',
  'Submit table and explanation as file or text.',
  2.0,
  '[{"id":"accuracy","label_ar":"دقة الحسابات","label_en":"Calculation Accuracy","description_ar":"هل الحسابات صحيحة رياضيًا؟","description_en":"Are the calculations mathematically correct?","weight":3,"passing_score":1},{"id":"business_meaning","label_ar":"المعنى التجاري","label_en":"Business Meaning","description_ar":"هل الشرح التجاري واضح ومبني على الأرقام؟","description_en":"Is the business explanation clear and number-based?","weight":3,"passing_score":1},{"id":"steps_shown","label_ar":"إظهار الخطوات","label_en":"Steps Shown","description_ar":"هل تظهر خطوات الحساب أو المعادلة؟","description_en":"Are calculation steps or formulas shown?","weight":2,"passing_score":1}]',
  'published');

-- DA Level 1 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l1, 3, 'اختيار نوع المخطط المناسب', 'Choosing the Right Chart Type',
  'زُوِّدتَ بـ 4 سيناريوهات تحليلية مختلفة. لكل سيناريو، حدد نوع المخطط المناسب ومبرراتك.',
  'You are given 4 different analytical scenarios. For each, identify the appropriate chart type and justify your choice.',
  'قياس قدرتك على اختيار أدوات التمثيل البصري المناسبة للبيانات.',
  'Measure your ability to select appropriate data visualization tools.',
  'نوع المخطط يؤثر على مدى وضوح الرسالة للجمهور المستهدف.',
  'Chart type affects how clearly the message reaches the target audience.',
  '["جدول: السيناريو، نوع المخطط المختار، مبرر الاختيار"]',
  '["Table: scenario, chosen chart type, choice justification"]',
  'استخدم فقط الأنواع الشائعة: خطي، عمودي، دائري، مبعثر، شريطي أفقي. اختر واحدًا لكل سيناريو.',
  'Use only common types: line, bar, pie, scatter, horizontal bar. Choose one per scenario.',
  '["الأنواع المختارة مناسبة للبيانات في كل سيناريو", "المبررات تستند إلى طبيعة البيانات لا إلى التفضيل الشخصي", "لا تكرار للنوع نفسه في جميع السيناريوهات"]',
  '["Chosen types are appropriate for the data in each scenario", "Justifications are based on data nature, not personal preference", "No repetition of the same type across all scenarios"]',
  'أرسل الجدول كنص أو ملف.',
  'Submit table as text or file.',
  1.5,
  '[{"id":"appropriateness","label_ar":"ملاءمة الاختيار","label_en":"Choice Appropriateness","description_ar":"هل الأنواع المختارة مناسبة للبيانات؟","description_en":"Are the chosen types appropriate for the data?","weight":3,"passing_score":1},{"id":"justification","label_ar":"جودة التبرير","label_en":"Justification Quality","description_ar":"هل المبررات تستند إلى طبيعة البيانات؟","description_en":"Are justifications based on data nature?","weight":3,"passing_score":1},{"id":"variety","label_ar":"التنوع","label_en":"Variety","description_ar":"هل يوجد تنوع في الأنواع المختارة؟","description_en":"Is there variety in the chosen types?","weight":2,"passing_score":1}]',
  'published');

-- DA Level 2 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l2, 1, 'تنظيف مجموعة بيانات', 'Cleaning a Dataset',
  'زُوِّدتَ بملف Excel يحتوي على بيانات مبيعات بها أخطاء. نظّف البيانات وسجّل ما فعلته.',
  'You are given an Excel file with sales data containing errors. Clean the data and document what you did.',
  'قياس قدرتك على تحديد مشاكل جودة البيانات وتصحيحها بشكل منهجي.',
  'Measure your ability to identify data quality issues and correct them systematically.',
  'البيانات غير المنظفة تُنتج تحليلات خاطئة. التنظيف هو أولى خطوات كل تحليل.',
  'Unclean data produces incorrect analyses. Cleaning is the first step in every analysis.',
  '["الملف المنظف", "سجل التغييرات: نوع المشكلة، الإجراء المتخذ، عدد السجلات المتأثرة"]',
  '["The cleaned file", "Change log: problem type, action taken, number of affected records"]',
  'لا تحذف سجلات دون مبرر موثق. أبقِ على الملف الأصلي.',
  'Do not delete records without documented justification. Keep the original file.',
  '["جميع المشاكل الظاهرة معالجة", "سجل التغييرات كامل ودقيق", "لم تُحذف سجلات بدون مبرر"]',
  '["All visible issues are addressed", "Change log is complete and accurate", "No records deleted without justification"]',
  'أرسل الملف المنظف وسجل التغييرات.',
  'Submit the cleaned file and change log.',
  2.5,
  '[{"id":"issue_coverage","label_ar":"تغطية المشاكل","label_en":"Issue Coverage","description_ar":"هل جميع المشاكل الظاهرة معالجة؟","description_en":"Are all visible issues addressed?","weight":3,"passing_score":1},{"id":"log_quality","label_ar":"جودة السجل","label_en":"Log Quality","description_ar":"هل سجل التغييرات كامل ودقيق؟","description_en":"Is the change log complete and accurate?","weight":3,"passing_score":1},{"id":"no_unjustified_deletion","label_ar":"غياب الحذف غير المبرر","label_en":"No Unjustified Deletion","description_ar":"هل لم تُحذف سجلات بدون توثيق؟","description_en":"Were no records deleted without documentation?","weight":2,"passing_score":1}]',
  'published');

-- DA Level 2 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l2, 2, 'إنشاء جدول محوري وتفسيره', 'Creating and Interpreting a Pivot Table',
  'باستخدام مجموعة البيانات المقدمة، أنشئ جدولاً محوريًا يُظهر المبيعات الشهرية حسب المنطقة وفسّر النتائج.',
  'Using the provided dataset, create a pivot table showing monthly sales by region and interpret the results.',
  'قياس قدرتك على استخدام الجداول المحورية وتحويل النتائج إلى رؤى.',
  'Measure your ability to use pivot tables and convert results into insights.',
  'الجداول المحورية هي من أكثر أدوات تحليل البيانات استخدامًا في بيئة الأعمال.',
  'Pivot tables are among the most used data analysis tools in business environments.',
  '["ملف Excel يحتوي على الجدول المحوري", "تفسير مكتوب: 3 ملاحظات رئيسية من الجدول"]',
  '["Excel file containing the pivot table", "Written interpretation: 3 key observations from the table"]',
  'استخدم Excel أو Google Sheets. الجدول المحوري يجب أن يُنشأ بأدوات البرنامج، لا يُرسم يدويًا.',
  'Use Excel or Google Sheets. The pivot table must be created using the tool, not drawn manually.',
  '["الجدول المحوري صحيح ويعكس البيانات الأصلية", "الملاحظات الثلاث مبنية على الجدول", "الجدول مُنشأ بأداة برمجية"]',
  '["Pivot table is correct and reflects the original data", "Three observations are based on the table", "Table was created using a software tool"]',
  'أرسل ملف Excel والتفسير.',
  'Submit Excel file and interpretation.',
  2.5,
  '[{"id":"pivot_accuracy","label_ar":"دقة الجدول","label_en":"Pivot Accuracy","description_ar":"هل الجدول المحوري يعكس البيانات الأصلية بدقة؟","description_en":"Does the pivot table accurately reflect the original data?","weight":3,"passing_score":1},{"id":"observations","label_ar":"الملاحظات","label_en":"Observations","description_ar":"هل الملاحظات الثلاث مبنية على الجدول فعلاً؟","description_en":"Are the three observations actually based on the table?","weight":3,"passing_score":1},{"id":"tool_used","label_ar":"استخدام الأداة","label_en":"Tool Used","description_ar":"هل الجدول مُنشأ بأداة برمجية وليس يدويًا؟","description_en":"Was the table created with a software tool, not manually?","weight":2,"passing_score":1}]',
  'published');

-- DA Level 2 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l2, 3, 'بناء لوحة بيانات بسيطة', 'Building a Simple Dashboard',
  'باستخدام البيانات المقدمة، أنشئ لوحة بيانات بسيطة في Excel أو Google Sheets تعرض 4 مؤشرات رئيسية بمخططات.',
  'Using the provided dataset, create a simple dashboard in Excel or Google Sheets showing 4 key metrics with charts.',
  'قياس قدرتك على تصميم أدوات بصرية بسيطة لتقديم البيانات.',
  'Measure your ability to design simple visual tools for data presentation.',
  'لوحات البيانات تُستخدم يوميًا لمتابعة الأداء ومشاركته مع الفرق.',
  'Dashboards are used daily to monitor performance and share it with teams.',
  '["ملف لوحة البيانات: 4 مخططات + ورقة بيانات مصدر"]',
  '["Dashboard file: 4 charts + source data sheet"]',
  'المخططات يجب أن تكون مُعنونة بوضوح. لا تُعيد ترتيب البيانات الأصلية في الورقة المصدر.',
  'Charts must be clearly titled. Do not reorder the original data in the source sheet.',
  '["4 مخططات تغطي مؤشرات مختلفة", "كل مخطط معنون بوضوح", "لوحة البيانات يمكن فهمها في أقل من دقيقة"]',
  '["4 charts covering different metrics", "Each chart is clearly titled", "Dashboard can be understood in under one minute"]',
  'أرسل ملف Excel أو رابط Google Sheets.',
  'Submit Excel file or Google Sheets link.',
  3.0,
  '[{"id":"chart_variety","label_ar":"تنوع المخططات","label_en":"Chart Variety","description_ar":"هل المخططات تغطي مؤشرات مختلفة؟","description_en":"Do the charts cover different metrics?","weight":2,"passing_score":1},{"id":"labeling","label_ar":"التسمية","label_en":"Labeling","description_ar":"هل كل مخطط معنون بوضوح؟","description_en":"Is each chart clearly titled?","weight":3,"passing_score":1},{"id":"readability","label_ar":"سهولة القراءة","label_en":"Readability","description_ar":"هل يمكن فهم اللوحة في أقل من دقيقة؟","description_en":"Can the dashboard be understood in under one minute?","weight":3,"passing_score":1}]',
  'published');

-- DA Level 3 Project 1
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l3, 1, 'تقرير تحليلي لقرار أعمال', 'Analytical Report for a Business Decision',
  'الإدارة تريد معرفة: هل يجب أن نوسّع عملياتنا في منطقة الشرق أم الغرب؟ أجب بتقرير مبني على البيانات المقدمة.',
  'Management wants to know: should we expand our operations in the East or West region? Answer with a report based on the provided data.',
  'قياس قدرتك على بناء حجة تحليلية مدعومة بالبيانات لدعم قرار إداري.',
  'Measure your ability to build a data-supported analytical argument for a management decision.',
  'البيانات المقدمة تشمل: المبيعات، النمو، الحصة السوقية، وتكاليف التشغيل لكلتا المنطقتين.',
  'Provided data includes: sales, growth, market share, and operating costs for both regions.',
  '["تقرير: الإجابة المباشرة، تحليل البيانات الداعم، 3 افتراضات أو مخاطر"]',
  '["Report: direct answer, supporting data analysis, 3 assumptions or risks"]',
  'الإجابة يجب أن تكون محددة — لا تقل "يعتمد". ابنِ موقفك على البيانات ودافع عنه.',
  'The answer must be specific — do not say "it depends." Build your position on data and defend it.',
  '["التقرير يتخذ موقفًا محددًا ويُبرره", "التحليل يستند إلى البيانات المقدمة", "المخاطر أو الافتراضات معترف بها"]',
  '["Report takes a specific position and justifies it", "Analysis is grounded in the provided data", "Risks or assumptions are acknowledged"]',
  'أرسل التقرير كملف أو نص.',
  'Submit report as file or text.',
  3.5,
  '[{"id":"clear_position","label_ar":"موقف محدد","label_en":"Clear Position","description_ar":"هل يتخذ التقرير موقفًا محددًا ويُبرره؟","description_en":"Does the report take a specific position and justify it?","weight":3,"passing_score":1},{"id":"data_support","label_ar":"الدعم بالبيانات","label_en":"Data Support","description_ar":"هل يستند التحليل إلى البيانات المقدمة؟","description_en":"Is the analysis grounded in the provided data?","weight":3,"passing_score":1},{"id":"risk_acknowledgment","label_ar":"الاعتراف بالمخاطر","label_en":"Risk Acknowledgment","description_ar":"هل تُذكر افتراضات أو مخاطر التحليل؟","description_en":"Are analysis assumptions or risks acknowledged?","weight":2,"passing_score":1}]',
  'published');

-- DA Level 3 Project 2
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l3, 2, 'رصد الشذوذ في البيانات', 'Detecting Anomalies in Data',
  'زُوِّدتَ ببيانات معاملات يومية. حدد أي قيم شاذة أو غير مفسَّرة وصف طريقة اكتشافها.',
  'You are given daily transaction data. Identify any outliers or unexplained values and describe how you found them.',
  'قياس قدرتك على رصد الشذوذ وتوثيق منهجية البحث.',
  'Measure your ability to detect anomalies and document the investigation methodology.',
  'الشذوذ في البيانات قد يدل على أخطاء أو احتيال أو فرص — كلها مهمة للأعمال.',
  'Data anomalies can indicate errors, fraud, or opportunities — all important for the business.',
  '["قائمة القيم الشاذة مع إحداثياتها في البيانات", "وصف المنهجية المستخدمة للكشف", "تفسير محتمل لكل شذوذ"]',
  '["List of anomalies with their coordinates in the data", "Description of the detection methodology", "Possible explanation for each anomaly"]',
  'استخدم قاعدة الانحراف المعياري أو IQR لتعريف الشذوذ — لا تحكم بالبصر فقط.',
  'Use standard deviation rule or IQR to define anomalies — do not judge by eye alone.',
  '["الشذوذ مُعرَّف بطريقة إحصائية لا بصرية فقط", "المنهجية موثقة وقابلة للتكرار", "كل شذوذ له تفسير محتمل مذكور"]',
  '["Anomaly is defined statistically, not just visually", "Methodology is documented and reproducible", "Each anomaly has a mentioned possible explanation"]',
  'أرسل القائمة والمنهجية كملف.',
  'Submit list and methodology as a file.',
  3.0,
  '[{"id":"statistical_definition","label_ar":"التعريف الإحصائي","label_en":"Statistical Definition","description_ar":"هل يُعرَّف الشذوذ بطريقة إحصائية؟","description_en":"Is anomaly defined statistically?","weight":3,"passing_score":1},{"id":"methodology","label_ar":"المنهجية","label_en":"Methodology","description_ar":"هل المنهجية موثقة وقابلة للتكرار؟","description_en":"Is the methodology documented and reproducible?","weight":3,"passing_score":1},{"id":"explanation","label_ar":"التفسير","label_en":"Explanation","description_ar":"هل كل شذوذ له تفسير محتمل؟","description_en":"Does each anomaly have a possible explanation?","weight":2,"passing_score":1}]',
  'published');

-- DA Level 3 Project 3
INSERT INTO project (level_id, sort_order, title_ar, title_en, brief_ar, brief_en, goal_ar, goal_en, context_ar, context_en, deliverables_ar, deliverables_en, constraints_ar, constraints_en, success_criteria_ar, success_criteria_en, submission_instructions_ar, submission_instructions_en, time_expectation_hours, rubric, status)
VALUES (da_l3, 3, 'تقديم رؤية تحليلية شاملة', 'Delivering a Comprehensive Analytical Insight',
  'بناءً على جميع تحليلاتك السابقة في هذا المسار، أعدّ عرضًا موجزًا من 3 شرائح يُقدَّم للإدارة يُلخّص أبرز الرؤى والتوصيات.',
  'Based on all your previous analyses in this pathway, prepare a concise 3-slide presentation for management summarizing the key insights and recommendations.',
  'قياس قدرتك على تجميع رؤى تحليلية متعددة وتقديمها بشكل إداري فعّال.',
  'Measure your ability to synthesize multiple analytical insights and present them effectively to management.',
  'هذه المهمة هي الخطوة الأخيرة قبل اللقاء المباشر مع صاحب العمل.',
  'This task is the final step before the direct meeting with the employer.',
  '["3 شرائح: شريحة إجمالية (الرؤى الرئيسية)، شريحة التوصيات، شريحة الخطوات التالية"]',
  '["3 slides: summary slide (key insights), recommendations slide, next steps slide"]',
  '3 شرائح فقط. لا نص طويل — نقاط رئيسية فقط. يجب أن يُفهم كل شريحة في 30 ثانية.',
  '3 slides only. No long text — bullet points only. Each slide must be understood in 30 seconds.',
  '["العرض يتبع الهيكل الثلاثي المطلوب", "كل شريحة مقروءة في أقل من 30 ثانية", "التوصيات قابلة للتطبيق ومبنية على التحليل"]',
  '["Presentation follows the required three-structure", "Each slide is readable in under 30 seconds", "Recommendations are actionable and analysis-based"]',
  'أرسل ملف العرض (PowerPoint أو PDF).',
  'Submit the presentation file (PowerPoint or PDF).',
  4.0,
  '[{"id":"structure","label_ar":"الهيكل الثلاثي","label_en":"Three-Part Structure","description_ar":"هل يتبع العرض الهيكل الثلاثي المطلوب؟","description_en":"Does the presentation follow the required three-part structure?","weight":2,"passing_score":1},{"id":"readability","label_ar":"سهولة القراءة","label_en":"Readability","description_ar":"هل كل شريحة مقروءة في أقل من 30 ثانية؟","description_en":"Is each slide readable in under 30 seconds?","weight":3,"passing_score":1},{"id":"actionability","label_ar":"قابلية التطبيق","label_en":"Actionability","description_ar":"هل التوصيات قابلة للتطبيق ومبنية على التحليل؟","description_en":"Are recommendations actionable and analysis-based?","weight":3,"passing_score":1}]',
  'published');

-- DA Onboarding Unlocks
INSERT INTO onboarding_unlock (role_id, unlocked_at_level, content_type, content_ar, content_en, sort_order) VALUES
(role_data_analyst, 1, 'company_context',
 'أنت في فريق تحليلات الأعمال لشركة "رؤية للتجزئة" — شركة سعودية تمتلك 12 فرعًا في المملكة وتسعى إلى تحويل بياناتها إلى قرارات استراتيجية. الفريق يتكون من 3 محللين ومدير.',
 'You are on the business analytics team at Ru''ya Retail — a Saudi company with 12 branches across the Kingdom, aiming to convert data into strategic decisions. The team consists of 3 analysts and a manager.',
 1),
(role_data_analyst, 2, 'tools',
 'نستخدم Microsoft Excel و Google Sheets للتحليل اليومي، Power BI لتقارير الإدارة، و SQL لاستخراج البيانات من قاعدة البيانات. التقارير تُرسل إلى الإدارة كل أسبوع.',
 'We use Microsoft Excel and Google Sheets for daily analysis, Power BI for management reports, and SQL for data extraction from the database. Reports are sent to management every week.',
 1),
(role_data_analyst, 3, 'kpis',
 'مؤشراتك الأساسية: دقة التقارير الأسبوعية (هدف: صفر أخطاء موثقة)، وقت الاستجابة لطلبات التحليل (هدف: أقل من يوم عمل)، درجة وضوح العروض للإدارة (هدف: 4+ من 5 في تقييم المدير).',
 'Your core metrics: weekly report accuracy (target: zero documented errors), response time for analysis requests (target: under one business day), management presentation clarity score (target: 4+ out of 5 in manager evaluation).',
 1);

END $$;