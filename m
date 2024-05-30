Return-Path: <linux-pm+bounces-8422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECC8D4A0D
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 13:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35171F21FAC
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543F16EC02;
	Thu, 30 May 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="SyL7ZB1q"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2094.outbound.protection.outlook.com [40.92.98.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE112BE91;
	Thu, 30 May 2024 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067315; cv=fail; b=WxErq2Ry6a3Cj8URweOsXSSZ3QfVS3JJtT4U8I01JZZJEdi/blvao62x0QkoSLgbRYnMIUZzOMaSpsHBJ9BGfFeOPx+SEeq4tS1fBggMokrjlmWYL4ZQQBiDxdc7FEDiuD6SR18tSUkSpi5lftJY8WeHHAsQx2FAEwAljW/i4QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067315; c=relaxed/simple;
	bh=tNOhYuCilkpJ4guqtujb+Wjf3RdX8WZASUsh3AL0g1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WY2PPPNnfQ6FqHfwcBw9ZTuwP8zWyXF5DU7pHgZveVOKqoswSuoPHr29bKvUm0qsq6CfjegrQJaRW84FXAP4gzJX0GFiEM+KKEly2qCyFNe291WNibVnuUWJuCBxHmXSQQir7hXgzE6sgTJooycIMj1q/C3YhFZVvSEO6pocksg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=SyL7ZB1q; arc=fail smtp.client-ip=40.92.98.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRDdFGDZE2u8OADTbknj2Lty6fKvML9Sll7Z+ohcU1G/DPGoEJParNd9BLUZMOBy0YZplDVLLMFGiM0wawVSVE1K4XLI6pA3IDUMCeZNDMBK51A4V1IePHcz9qnmioRg1IpSiBQvyPIlUwcXDlGi72JV/tlF02YoMCAvTGnhiY61oiXhlq0nwZE/atr22QET0Vb8E9pO/IY47MFaW8V//RYFeVmebDmveaocx7lKf48j4qjgwRla2RQEWaivSXuqFx2cXuv19sJNUkLq4g8wlYx8A1pLUCyhjGD0CAT5jDjtHQ6K9se+fQPk9N7Ot84pUzlWoKPzPT39z0iqWqtgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uLONIGm63D+1JtXq+GIaNlRgWOx+0L4JfavbHexVdA=;
 b=lZOLN4BZyXaEifxZiBv6Lzkj/iBnY+cEGDS8uVGy0gmbWSa30o5lK0+4u6nP99SCKUzo7Bub5ATzi9HEpkQpJxaGXga8QtCs4edbhQgB8vVaDPZTKsRrPaMZ/2e6LE2ojm1y7xah/4zb0PTR9vZaUkzO3nVYy9++olQPiywtqrYVLoqXCtGrFNgvrYIVesZpkG1r/tQZUG/IhAAfdiukYhoeJw88SQkMMLAyiaDbqj7ozRdQ8ZwS7Q5WDUoWE94BfGukdMGhL3slj/HhyVOlP1JLkmyYhQR16iM6tfToj8Y1becy0Uqy6aet7e2sPjfbCLWUVHIMtcUSthD7jEplBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uLONIGm63D+1JtXq+GIaNlRgWOx+0L4JfavbHexVdA=;
 b=SyL7ZB1q2S8bzaMuGZbP8D37VF23yq7J0xQmUSFxRsYaCFVYM5+Rxmd7NH7s/Q/rd4shyHTbGGMJcdiOPXCP3bDjwBlaDdkJkPko1RpNu0taFw/XlI4kD0L3vsQEiCZy5UgS8d2oSircihqKA4tt2Arkl5zFe3hKmUmkTS63omuwYwl5oc8k2xvE1nzZVhDp3ePSAx9KRbHaUXlP0ohzEt8lhD5xCeIEZ5VNr2dWI0ZwadB0C1UdZ32JbdBjb01cHXHoEgCEm4bHKaAG4wDUQcVaO+Vk51iLW/qtqlrcJC2ThKaJhtSVm1tLeZ1AmkLArxYxtl8hm6qn04U9Q8Ly1w==
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f1::11)
 by TYCP286MB2383.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 11:08:30 +0000
Received: from OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef]) by OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1167:655a:7fa5:5cef%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 11:08:30 +0000
From: Riwen Lu <luriwen@hotmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ionela.voinescu@arm.com,
	beata.michalska@arm.com,
	hotran@apm.com,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when set target
Date: Thu, 30 May 2024 19:08:15 +0800
Message-ID:
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [eWhWgUQ/6M0+OlXuupQk/mXK8IWIaI4i]
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f1::11)
X-Microsoft-Original-Message-ID:
 <20240530110815.3124449-1-luriwen@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2490:EE_|TYCP286MB2383:EE_
X-MS-Office365-Filtering-Correlation-Id: 60374e02-9486-4ee6-c880-08dc8098d643
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	eORXtyOVU4RRMHIfaiRVVvUSFrYwVcQqE94EDi8rPKpcO5LXGvfqnf5J2tHtxMrzCiTfVvRdw0DlZ/ufc55PgHLVM0Vxyh+eqHBvz8oE1Oh/jOgxta7O0T/0ZqpaEeFXbkXWmQkd37y+LGXq5CQ7rXgzDx5KQlUdwvn3EiiQhc4jxJA4+O6pvnScfUb6ScRYBYJ+zJBzFsSy1lDp0LylzvQOrmEch0SOiAUjgeXW2hqVP3uBx/Oop9kzpNSWgddTwL4zdagUyc4HfD9xkNS+6YwlzFbpsXt32JPE7ahF9w8dZ1i+I+NUznJ9FAi3gncvqLpv2zrLyiUNAje9mzQWiKyWItHT0ENqUdNjVd+/nV5sZyohwXNtNCY3394dORQKrjcTnf8jcoLBP5Bcyb32z5PkfpIx/LmWRxiRMZio7Bz/vKENnmJb/+5Js3vPuiHSmeE7x2Ch21sKFvsWHwwGWpojFsAW6U4bgNplRRMIEEY/mqG3T4CgZTgdpKrwHtZv2RHcyqf5PIQ8QHK9nHKsf6trHsuXvLuyios6qaC+J7ielHRR9QRUZmDVZF1TEuvQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2X75bL0Uvm/6DH1DXZPAyNbJuqJeZqa0NlzORa8LCqdfxehsszwwz/SZ+HM?=
 =?us-ascii?Q?1xgv8UQe2DZ0x0E0h8Koc4q9Eb9rZ16LmOWO0a8oIp+LtqlTak1Dt08hg6K6?=
 =?us-ascii?Q?bted255zcyJ1Fl6HsdznfSHDgtl+lrDBlnE3fVH1aApfi7AzfjLfvVLJTRxT?=
 =?us-ascii?Q?O9sJL61x6eXBDO2FtgMsBFftEoyLI3b4uQzqrA6PNz7TpalsO3F7fazp5hTH?=
 =?us-ascii?Q?3+aVxZy3DHqrDV/Fu21qYdrCogYtk/2sNUoMffErzbnHhQp8LcJDsCzSaTlg?=
 =?us-ascii?Q?J4Qwtz+eyvS6yHQt6ex/V05fUgteFz2Kbkd0cCDo7/ZO47z+AHC97QNnhaA8?=
 =?us-ascii?Q?yUYU+a1+oeauMuOnM11pyJV94gXN0AT84YQPRE4OOt8tLz34/O0RHuYUG/OH?=
 =?us-ascii?Q?tX7Uo56QHHaQS5jh1tc7U6nrFq3AwzOAY3NxmPOr6Fx4m0QmqNkwIcOAuAuj?=
 =?us-ascii?Q?oZf6hUHcMNzorEaxcdaoGKlAI2cSPyJiVURLaHqWJYFlpDWjb9ES+aVo9MHr?=
 =?us-ascii?Q?glsoDNdg9U380ZHC7ybAoUG1UbQ2S8noYqOliLSavEri6dMdoK3J+hUk8tPz?=
 =?us-ascii?Q?sDgp3NSx6/8Tvhms7r1XjjAhbxxfyE1YweOMqusfzAK2XdZ+kzJYPV7tEQWI?=
 =?us-ascii?Q?Ve6Gs42j9fAfsxgj7jFt6pcY+zI88z9kzSE2juOk80nm8huOJKpYSfgBYHfk?=
 =?us-ascii?Q?mrCRWUz5IvBohdl0NE4RDMqUQj38yWX9bqHupYxKEiHZuNq9P4XAPxt6ijty?=
 =?us-ascii?Q?Vh1sS7UNAZzCJKz0J6SOzdbTCjK1zBLuPCE+vaogwdTZeYGPag2xmDMAdUIg?=
 =?us-ascii?Q?bWb+V0t1XEEIL1AcugAtGfbWnzQ7ct20CIjhEfanqZEabt8OlPWZ+61qMZ4z?=
 =?us-ascii?Q?vH8+VeAyE/AJZ/TudeM1kEnNfT4YWVJadfkDniNizW3eRm9cwSRVNNxPcIe/?=
 =?us-ascii?Q?l7IQd25EH25UTcsNEQ58+RMyOEtJ/6SWG/hFQeuq/UVfSyU6mm4WwQOeqm9H?=
 =?us-ascii?Q?sKUpLpZ9C8Yx2gnFKaTU/DPh6vuOCs1xD7F+umq3kuAmsxljq+92TMimsjyK?=
 =?us-ascii?Q?OgXUVPcujkVgOMTD9gMAZRKEvmn6oE0PzNRe6HRvoY3jnpSAKbqlol4CetYv?=
 =?us-ascii?Q?ko6UHUzVnmvon6sutaVPKgxwece+kFaBbx5IhsHYWI37dhPIjiMU6t5ox9Tg?=
 =?us-ascii?Q?iGsAlNEYuqQLaEQVGw5+wPvh+pOjEj9Dq/j6rdbFCL9lGkrkedhyzemEG/g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 60374e02-9486-4ee6-c880-08dc8098d643
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:08:30.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2383

From: Riwen Lu <luriwen@kylinos.cn>

There is a case that desired_perf is exactly the same with the old perf,
but the actual current freq is not.

This happened in S3 while the cpufreq governor is set to powersave.
During cpufreq resume process, the booting CPU's new_freq obtained via
.get() is the highest frequency, while the policy->cur and
cpu->perf_ctrls.desired_perf are in the lowest level(powersave
governor). Causing the warning: "CPU frequency out of sync:", and set
policy->cur to new_freq. Then the governor->limits() calls
cppc_cpufreq_set_target() to configures the CPU frequency and returns
directly because the desired_perf converted from target_freq is the
same with cpu->perf_ctrls.desired_perf and both are the lowest_perf.
Since target_freq and policy->cur have been compared in
__cpufreq_driver_target(), there's no need to compare desired_perf
and cpu->perf_ctrls.desired_perf again in cppc_cpufreq_set_target()
to ensure that the CPU frequency is properly configured.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1 -> v2:
 - Update commit message and email.
v2 -> v3:
 - Update patch subject and commit message.
 - Remove the desired_perf compare logic.
---
 drivers/cpufreq/cppc_cpufreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 15f1d41920a3..337cece61ab5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -295,9 +295,6 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	int ret = 0;
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	/* Return if it is exactly the same perf */
-	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
-		return ret;
 
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 	freqs.old = policy->cur;
-- 
2.25.1


