Return-Path: <linux-pm+bounces-9014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDEB90518D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 13:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A4AB218DC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099716F0C6;
	Wed, 12 Jun 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="QgHqU6Gq"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2045.outbound.protection.outlook.com [40.92.98.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582D1420B8;
	Wed, 12 Jun 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192809; cv=fail; b=gKnQRo8uYsjDfi5+Isbs+vs/3qQxIVr/qHetqGQHITrTNt/Ck9W0stPlcHq/F6XYmF/fWhz+S1/F4tanUGhHNgNSecmtNsN7dv2WZNiWPg7ZmD6dj/cxfc3L70vJGxXPnti05jeCC34bFhgqjzfF7FjjTlAPIIVe5Ga3nO8vs90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192809; c=relaxed/simple;
	bh=371w9SdY/LgERS9vsGZTB02Hyrt4G97gFhGKSPt+To8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p3QmHEptNgfPnzTf+ap8/I2yHMEnf2yMP88Srsgu50ZT67vvSztkr9eHh6wTEaswJLnpmZN9JkJkCjEP/Hjb0YKZnI+zK3t9ABKcNdVYEFVwkBPqMhCIM0l3iXGmNFZrJSQH+WlQ/SsrEd9kqOIc0BtvbVkR86QFsPg3If2Y8AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=QgHqU6Gq; arc=fail smtp.client-ip=40.92.98.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXNi2CYlCMu6mZdeCfqa53Q4dXiddxwrqS3jD7nEjuXN1StCj8g1DJ5A2hPfscYugOJCNdwmkVDtS7C0KUGnMxi8JNJisk4Gk19iRm+Zm7wmREBA+Uzp2wtpBrq99vJTBMHeOC1ZRHeauS/bDNZ500MYLgOEeSUHXRm9YPV2bIRcB9Ew02RIxhZtmEHuqA5AQ4G/souNb14u0QEWNADZ9sNAyzN8QMm/HqjwuVK5YWG0ovJS2pC+ZGgPyHTPQO/xeyges0ik4paPUr0q6W+1qemPb6/L0wBi71VRFcdoDRW3gyUXvH3TrlODC5SehiKfnlmNbw0zu3ltlC8mc+g6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC21JaJ2n6Pe/WYWNSmF6uK8gaerwNtBKyme4hE2AHc=;
 b=hrn2nkkwcoU4eevW/YOlQItta3h4CeqDjpR3dT00DcAG6I1zDklSD6FgYelvtm9zkTzmazA6meGy9Cj1UyXwb+u8Mx2Uaq4MiwsBNhBVvo3YBs6VPe8SenDkMsm4v2I81m2NbZgrCwr1vWqYBzUqASmdauzzUzaKmu/eWMAwiBit6wFKcOaYdIDJNJNwOwsk3xeH028kd4iB6F4z7Tp14RxSIoSV+pofiehjj2jaeYWkOaEWP2K1z+NpdCV9rztzpqOi23BMohq3spC7tVGZHezpVvrvetvgOEMKYk73jty6GDgMgvENxdci9NYNYy0faZgx87At/kp9CHzGahm4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC21JaJ2n6Pe/WYWNSmF6uK8gaerwNtBKyme4hE2AHc=;
 b=QgHqU6GqkiimKiTpJArcwMWRzDTZhOWZJhuNho6tCo1vmmxGCnhCXHBFA3pf8joToUIjkbWDun7LiHFNBArmGl7HpyPu7h7BPLkohTBRJTzJXrgvEqKs615dtRrwGs42mPgKtVujXmxPRqv5JPoX6WyGvJz2U0Tzd1NhFPcdYymXuNfYRhsKNacemti7pEAEH+Phe04PFXMpPieNN64bvNZ8LMG+efVy93hDRxhjfS2NLcvDFJK0nsyAs1G4Zn/irJVo8QS0k/2QU6TRTbTx0uMeBEpbONXYqJsodGePYXb1l7UJNvnOU+kNmo8rZPc1oH76zw4XGkpSkp6A1vzG1Q==
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f1::11)
 by TYCP286MB2574.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.38; Wed, 12 Jun
 2024 11:46:43 +0000
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef]) by OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 11:46:43 +0000
From: Riwen Lu <luriwen@hotmail.com>
To: viresh.kumar@linaro.org,
	ionela.voinescu@arm.com,
	rafael@kernel.org
Cc: pierre.gondois@arm.com,
	beata.michalska@arm.com,
	hotran@apm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v4] cpufreq/cppc: Remove the desired_perf compare when set target
Date: Wed, 12 Jun 2024 19:46:31 +0800
Message-ID:
 <OS3P286MB2490EB027398DDB852BE2169B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fL/b5AnrMUO6x/EbJEbIzKsgFV+nQeau]
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f1::11)
X-Microsoft-Original-Message-ID:
 <20240612114631.1055832-1-luriwen@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2490:EE_|TYCP286MB2574:EE_
X-MS-Office365-Filtering-Correlation-Id: 55540659-f0c0-47a2-9070-08dc8ad554b2
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199020|440099020|3412199017;
X-Microsoft-Antispam-Message-Info:
	pob0l01bs8mi0MjViUqRksOqLGTs/7G5wLrTx2mP+eulTbF934fnEUGqDjExgIKxNEY3saQtKTwYXd8fWY/PdjKOgk5vOuSJcepEMFMZCq9zYyV5dKlkB2PucEWXA2jWjKwXpJF1fwo/Yxw72BynW5bKxAbExGXwYVdBLMRGX9N4MJl1JaZ6CyvROwqtBYY+WQ/rRerMdI53JOhPd4dl5s/OA3x4daGMjuR4u+87Xw9eUz64yelFiyjDvj7Gfw/+JpAiUHqsgUkIEgXWwz8yQ/dgCflXoHPGAHCtJtnNF4tPRqL5YQQ1cGb3nQCvubN4j4sXD1JHNYDYIWUIieMmZ1cfxlbuG+RjcM+KbLUxA4PzlIJQqp02pYeKzxfyy2btO03+0Y34SNtmSdP4x4TMUm4AVqoQSzU5QmGhVr6Rez+ycDwCmFnmqpmRzucEkqELuH4u8AM8KX3RuVszeoaf1QDTzu9HZv4WSJ5JU0kvBN4Kx+XhkSUlLBaqsFhL/Dqu8o30tam65tWLr1LskVXlaAr5X98FIrgkI3d+qcu3VScMhQjcrRNZKi9Z1rXX5uPH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gxs2jGkLvvXbNCFsarU4uQ1fomXH1HUy/8fmJDaN5SlR/lBRAqjEKFivpkZd?=
 =?us-ascii?Q?CW/mqq1iL0uUaUjtm7SE5h+Luu66upmJ59OSqRId2Mzc44t7FvL0/+K9xykf?=
 =?us-ascii?Q?miO3lntYuK4UqEnLiUEFDExZkpZwzBLTmFo9Def7KNWvM32mryjYELRMzBKe?=
 =?us-ascii?Q?Grpipn8n86aUAVk/pyaH+FTrwIRDnxqgvxpRe1g+IrDZ1eJxHqmdnCAvt2PZ?=
 =?us-ascii?Q?JDs/IuezECo7Lja4k3w4iO1hVcyeoaxZPX4ik/Bu2ck3iXXLT4hJw+UmZo5H?=
 =?us-ascii?Q?GznNP29c1eqFBMCHtqG/lt6wpj0g8bNZDZPDcKebhGtRlZq+O4ipkXKAkipq?=
 =?us-ascii?Q?UPBvP1/L89Fm9tztPYWBUXH1QBJjgLAI2hsyt+miBOayQBjtFegZLpp5acjB?=
 =?us-ascii?Q?KZSPbEOb/OZ9gaju4m1g/CbIu+BozIZoyi0G3j7I1AGIahKqmk1M6tw3MaKj?=
 =?us-ascii?Q?KSfIL5KxozPH9k3x6jvAxtfZk9LfYIHXG1jUUVjWRuN0OiuhXWUCxG2RUosg?=
 =?us-ascii?Q?EiF4eIHh2DPMwbzMGXAM0QQxkT6Yc6Dy0HPoHfOp9VbPw825kErnm74DYqGt?=
 =?us-ascii?Q?lhrrAhXzeqFomf5CpWw2rpuZbS6U8f75O2RwBY8orLW9E3SDrZ5BdryUIFd9?=
 =?us-ascii?Q?f7dLUPeBWoGkGBU50jnQ66xjmPfBr/R7r8rC7xJmAa98IBW7gw1RimdMUmhq?=
 =?us-ascii?Q?FsYdJET2wCgwxR3SFeEFijftBH/qqpMCbtzINodaC2+YaniEILYTeJtLoPtJ?=
 =?us-ascii?Q?3xM6iLqTOCqu9Mse1Sfmwu/mYxq424BJ8q+Ie/LjSw8xFrrd8e42lZeCKxjz?=
 =?us-ascii?Q?z2O73Ed0o5sE/dkURAzTxoHmCt1O9t+pIr4mVivZfTGQFgL7bABNWt31sL3i?=
 =?us-ascii?Q?FEc5vKNFoY1dQL5RW3YzkLTVFBZl/wYDGAnJy+Hp4kSX+OQCYLU8eSjbRpot?=
 =?us-ascii?Q?d5UgP05KUuj7erqFyATSeaH+oXy16lSkZBITsx0PRtmM4RNcdggvItmsi2zg?=
 =?us-ascii?Q?hueAyeHNy+20BZ7r8G0zwlWGImwkPBDBLu/U+iSLVPs5sMI4CO9V6dhgIF0H?=
 =?us-ascii?Q?2UmHWXrooEY3KiHlw4RasYFx2md8Cw+0M6USGhmp+I6HDsQ2m7wLoxkRxz3e?=
 =?us-ascii?Q?cF1+UDrlR0nK0+RIiFuONGe+kkFPfalxk+moG+8QIKrCYDSn7jrfA3Jmj+Z3?=
 =?us-ascii?Q?/kaax5jQylV3T7BIBJpts8dNlhWN9Z1c+03Pzw6utFHCe+9gH9hGyus96p8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 55540659-f0c0-47a2-9070-08dc8ad554b2
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 11:46:43.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2574

From: Riwen Lu <luriwen@kylinos.cn>

There is a case that desired_perf is exactly the same with the old perf,
but the actual current freq is not.

This happened in S3 while the cpufreq governor is set to powersave.
During cpufreq resume process, the booting CPU's new_freq obtained via
.get() is the highest frequency, while the policy->cur and
cpu->perf_ctrls.desired_perf are in the lowest level(powersave
governor). Causing the warning: "CPU frequency out of sync:", and set
policy->cur to new_freq.

Then the governor->limits() calls cppc_cpufreq_set_target() to
configures the CPU frequency and returns directly because the
desired_perf converted from target_freq is the same with
cpu->perf_ctrls.desired_perf and both are the lowest_perf.

Since target_freq and policy->cur have been compared in
__cpufreq_driver_target(), there's no need to compare desired_perf and
cpu->perf_ctrls.desired_perf again in cppc_cpufreq_set_target() to
ensure that the CPU frequency is properly configured.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1 -> v2:
 - Update commit message and email.
v2 -> v3:
 - Update patch subject and commit message.
 - Remove the desired_perf compare logic.
v3 -> v4:
 - Remove the desired_perf local variable.
---
 drivers/cpufreq/cppc_cpufreq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 15f1d41920a3..9095fd5f8c2d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -291,15 +291,10 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_freqs freqs;
-	u32 desired_perf;
 	int ret = 0;
 
-	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	/* Return if it is exactly the same perf */
-	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
-		return ret;
-
-	cpu_data->perf_ctrls.desired_perf = desired_perf;
+	cpu_data->perf_ctrls.desired_perf =
+			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
-- 
2.25.1


