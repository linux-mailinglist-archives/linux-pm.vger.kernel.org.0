Return-Path: <linux-pm+bounces-14853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD998800F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 10:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AE81F24BBE
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C694189524;
	Fri, 27 Sep 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="C+Lqo1nt"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF217DFED;
	Fri, 27 Sep 2024 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424635; cv=fail; b=pUz0nPal5c/Nirn8FXZl+wVJnD8HPRjE3nQzHUdQnRALbBoKxwOEPLPCvYtKdGJMwvGjWK1Au36wYwdyTNvCGwAYpqvfqippQXEov7P5geDZFc2Bjnc7eEAsiBUJ7DKXUXAwiuhnS1p6608GG5Y4cucGoa2v8ygCsMx6A9uXTTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424635; c=relaxed/simple;
	bh=Ra4Tc54VLwuatRKRmuN3eaF7POoEua3EFMJajiDtVdw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GwBzCALIHC8tf4wfbK8D8xeicWi6uGCWX28GAg+vqicgoDhi3IIiIbj/82tGh1pyo0khPxFK+BRSXzXJOj//inHNkRjTLa1EMPJtphV/hyAsjnCc0+v1smuewFG/I3aLy9hyANecyviyWB1DrkXHojJ6wo42I43rVYaVR77JKZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=C+Lqo1nt; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=macPicPXIs5UHxaFiLmjm2dAH8doFaxYaVyx8kq9zHddnLBL5dDi0wlKgFRNjHxYYbyFG4rGM1BWBo7/682q8MV3OUqdfN3OLTL3N4gS7qIKHoexRREgmU+ZgnNFY4aFG9E1CYZZ1fA05rcSjeA5xOYgfGh8bdqyUVnpQ4eKEIGrssAQnns4TRMaqfH2cOFUmEHdsaZjC2FM07Pib9Gjc1ld8SMXijH1mhDLqUvtHt1nbfQ7rwooMZ4Q+EDGwd3cCplEuFcEvDoZanP9pY6thrLKIu+NS8KrylCHgAbkig7M7/8ru8dizGakKSAArh8z80Ndj1c3sLf2kjW3MZqTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNvPam3AEldQ5+L7uIfHep+I0L7vUi9G8VAFr6PrVt8=;
 b=YjBMnsOCx3oo3pSPa+msXiHECiS5TvqzQaeSRgiijJmY55Ajmcs5f5xY8XUcodFpX9itFLbj+YQGngl6pY2WCntwS6WTf/fU1NF/fa1ocNaCXewfLLzkbBsv4qB4nEsAaPtYSfZfZckNlgt1ma8cGRxB5yMSXNKIrTtnKs36jhqPNTF8r+sstLK8jP2uSas15lCuz873116upVX8OIfo6ptj+wQfLNcem4bOV+HxeY5X6rZ52iV98TeMoWavryAVHaoW9Ye8zc+lxWNLlNmdum7Xpih/SvfJw3dARbzpenVkglWTnQ3mo6xVwR9X/6qAEuu8pt0wb+VAXhK/MpxRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNvPam3AEldQ5+L7uIfHep+I0L7vUi9G8VAFr6PrVt8=;
 b=C+Lqo1ntBdgnIOFyJEdhVOW+T3rIr6WlpYRjzS0hH7AN1PFg2wO4TQPf1VApPwP+ZKJvDgZMj/A/NdlhpngF/+CZJXEilZqU6xoUPzLtJYXBe2c53oWPIPQ+fgV5vMPxg85vBHp5kUP1HrJY4cIFdoalf7RKDKokVi9SITdwvBLO5Hlzdg+xEfG+/6MdheH8oO/7kEEYo1jH/GFjIqaTgcPc3HHYKxbTS+Yft22KLHnMV8ecbGjjE2FF7oB7SMV2D0UFSCk8agE1FW64g/TjHxtZW6Qoc3/GwCxbcyWPFBBVFBFy5qMosSKKdUlfLw1k9WwpgdMxd2gxJM4dpSvXgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TY0PR06MB5683.apcprd06.prod.outlook.com (2603:1096:400:273::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 27 Sep
 2024 08:10:28 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 08:10:28 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] cpuidle: Correct some typos in comments
Date: Fri, 27 Sep 2024 16:10:18 +0800
Message-Id: <20240927081018.8608-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::20) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TY0PR06MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7ed0d3-be38-43d9-67f3-08dcdecbd91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/VpSk7rl+PB0m2y0IeaKR3GhFmMgEQIeohgqhHoMYHro/Rvyt41fwAqqmjt?=
 =?us-ascii?Q?OHrfh9u/jNGYQWk8RHR8Ry2zRxnI+rw1VLhc7Hgt+ADo+4K7u6TxNc5QACOw?=
 =?us-ascii?Q?Nr0vPd+WJEScBD2k7/p9+rzaPWUASvXmyhVhTrzLE9ggZUQLztUMTk6yGUW5?=
 =?us-ascii?Q?zjUPIYCqxM4ElbPZcT826fuEgZqRAUQTK1jfXrA7z2FaDdWIjL4mcehVFGmf?=
 =?us-ascii?Q?OoicDTDOYK2+3wD8zHLuRD7aMdoPEoNI9WCsbD+BFcgw8vvJyqfKFMHHuPpI?=
 =?us-ascii?Q?eWJxr5gKK/kylxF+FpviGpckgRoM2vGS597dXFzxpvGLwvCG1uUwYP789BDG?=
 =?us-ascii?Q?iRhdrqawLfnp7GmblsFRfvWtg9vyHnzK8wQziKBOaScnNAJq4MKmy9uSZg8H?=
 =?us-ascii?Q?RRiTInqzzL0/AkTEQA48S5Y2ezj+ayqqcgJ7ktn/Is5zxOA3Mr/cH9DzqDsp?=
 =?us-ascii?Q?HTpEr/lSCC2KrBLP22R3gVRZb7nRbdnuMFscB3JzI9R3Cn0le8+qql37PxYb?=
 =?us-ascii?Q?JjwHsphi7VNvEJie0JdBsFtsSf2HwMWG4gxOpEqfI2txv4sP1VCLZFdlwVf2?=
 =?us-ascii?Q?cScXkkE+fpuHF3RgP6BR76IR9Us43ONfaNGNSVfTfn5A/14nbpwpcw9s/duA?=
 =?us-ascii?Q?vRh7LluUlYVkR2iZqOOvOIG4vTJnKQ+LU/jxV81wl7xnhQ7BD7T6Dscm1z6a?=
 =?us-ascii?Q?beUXsmMLIGEiPQnYFgI/nx+O3Eir3Ge+yap/Dymc9JPaMmoXA3jd/B0zvTEH?=
 =?us-ascii?Q?VY3Ln3eR7lOR3h8D0rkhMm27etwkQsi3WSMTvXWs/wy3ok0mhAWHSsxFBSDG?=
 =?us-ascii?Q?JyKEE/OPoPualvpSuy2f6/HlVTfP5EA/YxbwphS1Ap6eAXOxgtZWQVTH+/aX?=
 =?us-ascii?Q?Ux5D5uE9G5O/jeP700zxx3tqut+nY+7su9il/+6MM4RUzJGsNEo+tpyZ41yJ?=
 =?us-ascii?Q?ypECZ2fD5nEVt2vppUGYHFdIhqE9AuffCKrBl+Qp8xc9f2NPmX2Rpu5xs83b?=
 =?us-ascii?Q?snVo+rXd/VCQdxSBihAI3Nm4L3LkmMpmmemdTmR6xBllAg0vtGFSywXWdmyY?=
 =?us-ascii?Q?E6+XFoUK3lCdjRinn03xs0OIZDEZoaFgrDm68HGg3TehRe99N1YJSoVovz62?=
 =?us-ascii?Q?z8otd6db9IestyXxAvYpls4/vsT0DIJTFMomjvsl3Tnw4D/td12ovm11RnNc?=
 =?us-ascii?Q?D4+U53KbgWCnE79fQ7v8qKc5EoatNTkCC/XZ8WGWJbvMwauXyaNPvtT9QMAg?=
 =?us-ascii?Q?MaeFg/XYh4bgLHYvzQoAqNZDqQ7huMkaioVPnC+1tL2aN1y3zaUqWQ1ME1qh?=
 =?us-ascii?Q?D5c7VFmvXP4pPOnw25iDqCEx/N1b6jLhdzJYEgTitHfU7wdEPZEiay9VA1Lw?=
 =?us-ascii?Q?RteTJSq/NXVn3pTqzLzjLvdpC9XLnuHnpp5qs4EJAzRPF++Pug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUOERfKnlxLc289QUafnUIPd+Z/e3L/xVfFpvofz4LRE4KndCNNN8/HaxMrl?=
 =?us-ascii?Q?JuxfjGinQmduK3LriROLFhWYTXwfEaLa98OMfF0fUvdtcB4w5S6PV53f7Ed7?=
 =?us-ascii?Q?BcMuQSvwP68M9fkO044+o7YyJvQnG5b6JVGtQbqajrp1GFc5ZfcwSvaMlW41?=
 =?us-ascii?Q?QGdQ3jODIuryb7ln1x0eqYGBrmxM5xzsxwF0R2oZgASt4wyxgyJzWkksfYT1?=
 =?us-ascii?Q?2bi1Nm6TrVNgGHp9J9wBdFD5RYk+w2ZkJRsLj84n5WRNdL9h6JPOA4ny6LRP?=
 =?us-ascii?Q?spgKXr4df+LFCxjV4smNOKnz7ukrJLbZ1NvqYKhvrvKlPUYl2uCQfxp1oR02?=
 =?us-ascii?Q?77tKv1NL1rImkoCvajCJKj/XL0ctJpaCASGWR5w9K4FIvXLglGq6h/W9DqUm?=
 =?us-ascii?Q?oWaqI/jW0Zu8WsFqLw/qyb8kk8yaGpPp3Iyf+iwNdKRQ9+r6ZF3t4iPuqMy/?=
 =?us-ascii?Q?iytq6fcFEvkhFDz8Bn2+lGnMd9GjjHuk+lJhp+n6shVBR7Wuocx299azj7YA?=
 =?us-ascii?Q?rIeeMiOZgGSjTPeBlK/Djz7Ciu8diFQcGXFGRY528LnS5ZKHP1RUcx3J4Xjc?=
 =?us-ascii?Q?b71fnzZy30XBukjKps5IO6IiF6BK00USgzbkEGqAl+X1zf6fxLQVNxuQjKK3?=
 =?us-ascii?Q?2iaCEuUr7zOw6czMiaukuwnqUMoatEqlKJBx9iN+Ad4zfNcm9bFuhv62CJFE?=
 =?us-ascii?Q?g5fY5oVruhwD4txL7eszzszNNp/3870+m8RtHmLY2QsqDh8ItTEwWaI+TMn8?=
 =?us-ascii?Q?RvjFcHJ9ZyL4ADoxqFyq1gkJxseuBWRaC0DqpRjzSZH4Fa91FTvFD4GUhnHc?=
 =?us-ascii?Q?rYNqE+c3MYPZ2+OOiYWQsMHn+ayVH9KIS+BMO5ySw0ToUiE2F70y0CZZlNvP?=
 =?us-ascii?Q?olEZ29k2o3EQmiCAgbWvsiKG5XYOb7D8frJa+m3ujqN5UpS5SQMqkrMFWw/q?=
 =?us-ascii?Q?np+qmDTaIWdzlHDQs0cm8+bb3z+wYdigsAPZJCkv3V0UL8xOUBFSjKKRar3q?=
 =?us-ascii?Q?+3+eC/6npC7H5/NtlfdBVfinXQ5dodIkgE/2nI77JNcK1/VXK+M8bjo9IQ06?=
 =?us-ascii?Q?hCnZtd+/KM+lcYqt0OmYy5M0cgrq5ucwD4v9USbmo6okGzj8aAg0Sj2MG5t3?=
 =?us-ascii?Q?Zt8i6eD5NXJea6FTmSqLyvvXoo+O4m1RTuadUo8lGscCtAIuDaXlw6idUr2c?=
 =?us-ascii?Q?CibBscUQA8oz70/FtKcJ++PEgcJlDkBXPCZcKS40H2+reZe3oy3/ff5c8k6x?=
 =?us-ascii?Q?zHW4+FIB/n4WD+Ceva+r44/D4VGRkt5xfzTztB5smVCk2K0JybWfM1WmSYTz?=
 =?us-ascii?Q?PnAPZUj9kuWDO1MSmA3oCo3vQdM+NVZ+4ZebkbSHw+FqKKbxsT89eb7e/oCU?=
 =?us-ascii?Q?5CA6OHmQdcdykZwRavY0SWZzAMfhF6/6CG8qgn9kVtMZ0XryBPo6EVw6Qc3D?=
 =?us-ascii?Q?OTwPnOApD4KSI3HdLSx7WawlovaqM8TABjuH8+3bT/MBYXUmkVsqq12s15BT?=
 =?us-ascii?Q?g1SiwkmHCq5tVIEspeJYnmRCT6D/snKKGxAyuJ5kkAETm+p7hph7CUNMcpaK?=
 =?us-ascii?Q?5Lpo8yhbrHxA4451PQk18UJJgB3Srszoy057gpD1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7ed0d3-be38-43d9-67f3-08dcdecbd91d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 08:10:28.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wYN0zLLoLevwR9HHBYfXMI/PrkZWqXA/m961FP0Du8eiPfTcZvWkSUpmc2TKEF4146K7zXXQBCGLjJ6EiW8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5683

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

-in the code comments:
drivers/cpuidle/cpuidle-arm.c:142: registeration ==> registration
drivers/cpuidle/cpuidle-qcom-spm.c:51: accidently ==> accidentally
drivers/cpuidle/cpuidle.c:409: dependant ==> dependent
drivers/cpuidle/driver.c:264: occuring ==> occurring
drivers/cpuidle/driver.c:299: occuring ==> occurring

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/cpuidle/cpuidle-arm.c      | 2 +-
 drivers/cpuidle/cpuidle-qcom-spm.c | 2 +-
 drivers/cpuidle/cpuidle.c          | 2 +-
 drivers/cpuidle/driver.c           | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 7cfb980a357d..caba6f4bb1b7 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -139,7 +139,7 @@ static int __init arm_idle_init_cpu(int cpu)
  *
  * Initializes arm cpuidle driver for all CPUs, if any CPU fails
  * to register cpuidle driver then rollback to cancel all CPUs
- * registeration.
+ * registration.
  */
 static int __init arm_idle_init(void)
 {
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 1fc9968eae19..3ab240e0e122 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -48,7 +48,7 @@ static int qcom_cpu_spc(struct spm_driver_data *drv)
 	ret = cpu_suspend(0, qcom_pm_collapse);
 	/*
 	 * ARM common code executes WFI without calling into our driver and
-	 * if the SPM mode is not reset, then we may accidently power down the
+	 * if the SPM mode is not reset, then we may accidentally power down the
 	 * cpu when we intended only to gate the cpu clock.
 	 * Ensure the state is set to standby before returning.
 	 */
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 9e418aec1755..06ace16f9e71 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -406,7 +406,7 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
  * Min polling interval of 10usec is a guess. It is assuming that
  * for most users, the time for a single ping-pong workload like
  * perf bench pipe would generally complete within 10usec but
- * this is hardware dependant. Actual time can be estimated with
+ * this is hardware dependent. Actual time can be estimated with
  *
  * perf bench sched pipe -l 10000
  *
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index cf5873cc45dc..9bbfa594c442 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -261,7 +261,7 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
  * @drv: a pointer to a valid struct cpuidle_driver
  *
  * Register the driver under a lock to prevent concurrent attempts to
- * [un]register the driver from occuring at the same time.
+ * [un]register the driver from occurring at the same time.
  *
  * Returns 0 on success, a negative error code (returned by
  * __cpuidle_register_driver()) otherwise.
@@ -296,7 +296,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
  * @drv: a pointer to a valid struct cpuidle_driver
  *
  * Unregisters the cpuidle driver under a lock to prevent concurrent attempts
- * to [un]register the driver from occuring at the same time.  @drv has to
+ * to [un]register the driver from occurring at the same time.  @drv has to
  * match the currently registered driver.
  */
 void cpuidle_unregister_driver(struct cpuidle_driver *drv)
-- 
2.17.1


