Return-Path: <linux-pm+bounces-33399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0ADB3B62B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 10:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F6B3AA7C8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE0285CBB;
	Fri, 29 Aug 2025 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aNkitTGc"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013034.outbound.protection.outlook.com [40.107.44.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432928BAAC;
	Fri, 29 Aug 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457099; cv=fail; b=FyrJny74Mo99sv0reegPoW3HC6AZjKbu9jmA6vvuuCIczq9CbcbyvMGoID+hSZyacSgdmdRtLi2mYgskaOo7v9miFNKcJs6cSC8lH8j12SyV/C5jkA7z9dz373E8ji4nUnzRYjqtWBUXwTqjL2RSbefjIOCK6H9dCtu1xz4i5rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457099; c=relaxed/simple;
	bh=lmNQMjHHK66BQY4xZ9T3nc1C4WIp4399hSLXHGRwqeg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EFuu2QkHNApQJDlzdzH1fVt/vxBnBQCuiN+aOunM/A7UFa3LVTPpChobJGUYU5eFZLlf8u7drvSL89zT4GJecflwXR2CLKOuWyzgIs98vnTm94KTegtVvOlUIB38ofq02Y40xZAJk0kik1zrL7OZjVO6o7D+OwDcHWVQ/OST4Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aNkitTGc; arc=fail smtp.client-ip=40.107.44.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpkgWK0WCN2vuTkQr+ktW3cJ6gxLZMCVg7JNbSFe9fujoXWPAmlFwlLhwqm1Sx2XRJ5qTr5qJodd+DjfgTJnZqJ3zkZVCXY6DZ4hxM7M/3+oWUXkD6eAZxlhwtVQB2VRQ78aiKVBkskpsOFDxqjVtZpJqtmewbLtTCWwbyHwjNleJNT8929RApvoKWRuxMsmePYEnQChqX33GSoYcVE0u7z4GdHVYCP2CKgU2WQ17xfeu7AmP4mJKeDZmlGSdL5/4sC5wUT9cQk5ahJy2W1ftlu3U2hgWDqDwF/t3d9Sk8pjza+qSQ1Dzwn1KM/cvS5n3YhSL7cc3IiSczOPDWPvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CFhiGzj6CtwWcJkf2pTXzOe/JqpGrN7OShdU2SMQhQ=;
 b=ILVJ4JGl9PemAg3QRee4hViTACyzC6vz7wn0Qnz60e3r9MkqwouN3nwx73+w/FKPOQUArnPsU2t1WNE+rzkWX29d7PwSCWfYqRgFBCTsz9/y6J8dan6TvFpZEu1fu2mjYEyjA16iY2CteHiYunfB+/gQzb2On7qLTB75XARDBcg2ZJSZq4yrtXd/VICeuQ5zNbQdkxsoTZZuJeFT+oNrOjbNzGR9MG3CM/wbp0TUxSqoyd+hTcl4LQ5nrJJBPvk7EmruaYCxoc+J3+frDWkyNpJUIQnRsEEuVzs3TvF0yaaz5q37vo9jFxi4vfvPSoVq1PNsFUJ90ayOjWwlRyHkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CFhiGzj6CtwWcJkf2pTXzOe/JqpGrN7OShdU2SMQhQ=;
 b=aNkitTGcMwjbhMh/xYLpHykmrmHY2zrKsxZpJSxlj6C03vpeNFTH2ri2hSN4PRpxYNHm+sZfHv1fXvRmM6Pm+/zG9jZG3hGDYEGecFpt17zdRzEiW0K3K0tkrsZoBwQhBqh+31Qy/FAFu4SKihNEwE1DMFh85/CVkWGSRubOdHwIkTZ9qlQOPggPuY3T2A1NqNpynwqiQGO7upwcOn49hQZJqmvc1GhH2kTmfIMu6zKKNLISnUvu09WNS85yhRUXadOseWBZfzy3lfwc4q/o6fFI3npsAD/WSg9E2KSWZsaWgoPObS3isMqCQXC/tnO/pYe90MUQgtWWek2Hzu0LyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6951.apcprd06.prod.outlook.com (2603:1096:101:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 08:44:50 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 08:44:50 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] cpufreq: Use int type to store negative error codes
Date: Fri, 29 Aug 2025 16:44:39 +0800
Message-Id: <20250829084440.579727-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0205.jpnprd01.prod.outlook.com (2603:1096:403::35)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: da3ea0c9-e1fe-42d7-c985-08dde6d850dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qF64vkJsoZwmBIWZnltDeAGwW1IpK4rMm4fI0rLTezCVtMxmUJ8gkr4McNw?=
 =?us-ascii?Q?x9FIXHio5gfHAiMW0CD780u1wCfDDSiRqiyF9Bm6+gagcLvkqtrb2OmC6FHt?=
 =?us-ascii?Q?WJWlf33frg/IVeEuwjvKaQvyL9cmNVMBw6LzLBsfM3yW2EGa4s6dXsdnIoR2?=
 =?us-ascii?Q?zh+a3lIVbhVKvAYJc7aHLWgWV2rr2fLBIutvhUx8egpItJxcloOegDDooXEd?=
 =?us-ascii?Q?1B1VB4zXGpDycyAdSm8Rp2PdXBRvFTspbljh5yHwbS7zJytyXM9tSSKURtGP?=
 =?us-ascii?Q?/DmDqS81mkYD5SdVpOx0MBo39CgPMrCog0A463T/Bq45zVcV20Z0yAYQHwME?=
 =?us-ascii?Q?rfzeck+wRdjnzUNwEd27FmBudg4ZPzP0jF4i8JXMBAMnCkiusJAwv1Wks4eZ?=
 =?us-ascii?Q?8q/AaXuZy9vRS3FiS7ZIcSsiF9FcK+Y7kVnzWMo4nZB+35xbeDZ2hWEI2AbN?=
 =?us-ascii?Q?XDWdEtn9cji2ztnGVLrA/GPuUvs1AgfQcfM+T2Yas0VVL0ubd2FX2wju+btf?=
 =?us-ascii?Q?ygHZ+/+dOeBEelauHH2Hf9C3il5wykFmhFA7sS02IknuLhPoa12p+D662EUw?=
 =?us-ascii?Q?jqr1dx7rR0Q0gtLGXghRPJjkNWJVdjbAju8Nzc7TRUhm8lNSTgti8gq4Ki4g?=
 =?us-ascii?Q?0rWQGwEu8JybFoPNjc/Q52XW0jxEM8h7RxtHdKJa5P/IUxF7a4u/5DVpVtFt?=
 =?us-ascii?Q?2KdVKqm8p6NbZ59ZjlwvJABwyCtOWNqDCeS9kCpu435iU7EsPsUgkZS9M7PR?=
 =?us-ascii?Q?IBaGW1f1EmlBmHUHCk+EjHVlY0jRkT5nXBmCWu27ibW+JLbly1W3Q9Mz6ctX?=
 =?us-ascii?Q?xDpKa9XRdf299pymaA49sM2oBaeBcM/CTuDGFdm83GtnprKjyLKSxVxgcI2o?=
 =?us-ascii?Q?Tn1YPmYGGETM5sytJk/7IdKYgJGJk7UR8RR8iVkGpC9chHjBucMvGft9OJ0F?=
 =?us-ascii?Q?eMPSlSW9C4CMIuGYsIMrfIbEVZTF4Gr4sjC2XgFmi2XtMS3rilDytXBi63T4?=
 =?us-ascii?Q?ZK/mtxoMZOcxFW9KrjeYQ/x1L2hsVmeNIiFNaLKarP5NxTUQrrFx9Ge5Ly33?=
 =?us-ascii?Q?cxUitUChJA21E+lzm0Hn7Q9PF8EuMjnocMC7vtpviYTJxuAr50L4Uz+K/owQ?=
 =?us-ascii?Q?FD4VGaRyy1FbDessQ0779PvL4OSQvXQE9GjXwYmOnfCbXKvQ/MXdMh6pa6sl?=
 =?us-ascii?Q?RVzFwKX9jJj/el2vDI7Cor/E3rxjBu+qiaHtkHxQwxet5PHPr64ipCOuUots?=
 =?us-ascii?Q?lOM2WpIkL6JzZ1X+b69NOzsXncYD166SO4lAhijSyBEfk4N/qEU2XVAj+xTV?=
 =?us-ascii?Q?23lCDxiKsnmCOCP+bJ+0wKOEiaGvxB0xJPE/7Modt4Ss6QqHfECTz6O8YAh7?=
 =?us-ascii?Q?ZeHxg9Btnnge6Eovt+8VbJ5i92kqiJKly3OSntm8dGv3h23vDRGOiqZ14GFg?=
 =?us-ascii?Q?bTsuARWxoXVNZ5DVptMKKdKY6+8nylhsTtkkmiYH6+PX2CMBuTbK4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0okEHPVstd4JIuhwxy17y8ui4kgNK3N0zxolw+OtY0+ykG9wRetgYu/iYbW?=
 =?us-ascii?Q?c/nVIVCRPtAx5IyTNMT5KX0WCBHmu5Ba1MzmPHKcm81/ebdJp0xb3tFN7rhf?=
 =?us-ascii?Q?kpCAmD6L/JJEtT3Ff8/Hrvt4kwc8PTUi2uPXcADVV03ubh9SuitoaaSFgDXd?=
 =?us-ascii?Q?c02s+QmbxvlFBr3SbDfncyM5CQDaqemB0QeWlL7HsxXAXqfIu5/03eMcVPJA?=
 =?us-ascii?Q?zRBQp7fvZ1KhlNYGgA1elYG//Ni7TJMHrh2wfAuW9Qcg4o+BiSc0uLtzQpU2?=
 =?us-ascii?Q?oG1ZcNJop7d4E5OLO7mDvcSusQUu37Dd9FQ0gzo1FLBx7y0anjS+Uj8H1NVV?=
 =?us-ascii?Q?k9o3F9r8HRwD8kQ1j3+yqrRmJf9PXL2AcdzdPdWNqrxZzmaIyQDVX/MCMc0r?=
 =?us-ascii?Q?c32CsJNDEALb2thul8tabzDbcUhapy4I+jXcSm/Ehd67ZrgW70erUSfXzEKK?=
 =?us-ascii?Q?/0geDAE277zdAFkC8jeMRZWtK7gzEC4phV6+qnSilChWBDRpdj7yx7ouhE1t?=
 =?us-ascii?Q?5Gim5JQy348O7YSGUAPKHIbpJBQ5i0lNXKQe0+uJ830Z6zX6JczojyePnvj8?=
 =?us-ascii?Q?4Rvi1065bPp3DAI8R1TQRYwFXZ4+G4H2SSTYAItmRnl54ZWm6hPJJ0fEDeES?=
 =?us-ascii?Q?X6SNZwqh+2oBBVK6oJAOputOeAuz690kewFLBzgpU2j6m2mtAW9rnjN10RiL?=
 =?us-ascii?Q?P0GWHLJzqQUNRDjYALHK3foPuez50KMqCR6trDYp33m19FSUDEwxMVIg6w+I?=
 =?us-ascii?Q?K313wAziJouIrcAIWAODwdw8K+SJHfCZk+UNtMby9rCt1zARsXafTiRkRjHI?=
 =?us-ascii?Q?Zz58iV+ydVSz+A9FSzF1Y8VurjglajKuHQfGMNBnzbe12F1htW168k/KHOCf?=
 =?us-ascii?Q?0SCT2EmEuYa9baX9yr2I5aClzrx2vfRtj14P97SFPk//Voh88WkO1Qe0AdZw?=
 =?us-ascii?Q?Rb1/nFzXWK3ZOUa1P3LyNvncLQvmW73A17gnUgNaofxpi8H8mV3zApiO95BN?=
 =?us-ascii?Q?F4V5KvCjxWGAEFvfLkhp0qB11hK/1Tv4F93m10tJAjCKhaL0jMCEKTHRVOuJ?=
 =?us-ascii?Q?7dZXioXacbnpH+BY0BavqoGod7N5sKotSQppaJN1pVAqJDEwiYBs2HAlGkDG?=
 =?us-ascii?Q?82BZ02CDlbNflizaKq8LFv+hZOa/thCdCtqG9ynGGIUO6QhZ8ZyItgGDb7BH?=
 =?us-ascii?Q?ceCHl43Xz45lGMR4fPTMadwsk2wwsI8aC/DF06gLhv1tqan6vZnqYtIxmsfU?=
 =?us-ascii?Q?RYP1/gJXxa4ikf4YlfUzQakmv17nGQ56PshrNWWPW/V0/FCvVSpyAxFqEXy/?=
 =?us-ascii?Q?Rgz/f2Q96iDfvUSVo1sHbZzWQz7q6B/SW74emFJiwoLu+cWtKNdS8nwO72d6?=
 =?us-ascii?Q?8Mu4NMt+lt1DEyBt70mTpA0258w66qO/zL5nY/9c7ySfqSkr8YwYW/Pp29Ei?=
 =?us-ascii?Q?tX2ExG0PRsVmWd/tMrFxr219xl2Todh1GTfaPsqfLFrTlKgY+nHqleAU0KZk?=
 =?us-ascii?Q?caNjJqMGOAZyjW3L7LyAcKJLF+jHjRoQTOQd+ll+IypUW2QdDeyVsKUTPNQJ?=
 =?us-ascii?Q?cwVm+ja4dOvAX+n+1NybklMKh+pZEJAV//GuG9W1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3ea0c9-e1fe-42d7-c985-08dde6d850dc
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:44:50.3680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2DfPL7FEt0YD9Q9v38fT/fVuwpA/lxvNeJ8gj9mxZy50ejJHraFTtbAhxBx2SPtcRm1kbeqtQcesKjIqFbALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6951

Change the 'ret' variable from unsigned int to int to store negative error
codes directly or returned by other functions.  Change the return type of
the speedstep_get_freqs() function from unsigned int to int as well.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/cpufreq/cpufreq.c       |  2 +-
 drivers/cpufreq/powernow-k7.c   |  2 +-
 drivers/cpufreq/speedstep-lib.c | 12 ++++++------
 drivers/cpufreq/speedstep-lib.h | 10 +++++-----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a615c98d80ca..f47096683abb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -914,7 +914,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
 					const char *buf, size_t count)
 {
 	unsigned int freq = 0;
-	unsigned int ret;
+	int ret;
 
 	if (!policy->governor || !policy->governor->store_setspeed)
 		return -EINVAL;
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 31039330a3ba..88616cd14353 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -451,7 +451,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
 	unsigned int i, j;
 	unsigned char *p;
 	unsigned int etuple;
-	unsigned int ret;
+	int ret;
 
 	etuple = cpuid_eax(0x80000001);
 
diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 0b66df4ed513..f8b42e981635 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -378,16 +378,16 @@ EXPORT_SYMBOL_GPL(speedstep_detect_processor);
  *                     DETECT SPEEDSTEP SPEEDS                       *
  *********************************************************************/
 
-unsigned int speedstep_get_freqs(enum speedstep_processor processor,
-				  unsigned int *low_speed,
-				  unsigned int *high_speed,
-				  unsigned int *transition_latency,
-				  void (*set_state) (unsigned int state))
+int speedstep_get_freqs(enum speedstep_processor processor,
+			unsigned int *low_speed,
+			unsigned int *high_speed,
+			unsigned int *transition_latency,
+			void (*set_state)(unsigned int state))
 {
 	unsigned int prev_speed;
-	unsigned int ret = 0;
 	unsigned long flags;
 	ktime_t tv1, tv2;
+	int ret = 0;
 
 	if ((!processor) || (!low_speed) || (!high_speed) || (!set_state))
 		return -EINVAL;
diff --git a/drivers/cpufreq/speedstep-lib.h b/drivers/cpufreq/speedstep-lib.h
index dc762ea786be..48329647d4c4 100644
--- a/drivers/cpufreq/speedstep-lib.h
+++ b/drivers/cpufreq/speedstep-lib.h
@@ -41,8 +41,8 @@ extern unsigned int speedstep_get_frequency(enum speedstep_processor processor);
  * SPEEDSTEP_LOW; the second argument is zero so that no
  * cpufreq_notify_transition calls are initiated.
  */
-extern unsigned int speedstep_get_freqs(enum speedstep_processor processor,
-	unsigned int *low_speed,
-	unsigned int *high_speed,
-	unsigned int *transition_latency,
-	void (*set_state) (unsigned int state));
+extern int speedstep_get_freqs(enum speedstep_processor processor,
+			       unsigned int *low_speed,
+			       unsigned int *high_speed,
+			       unsigned int *transition_latency,
+			       void (*set_state)(unsigned int state));
-- 
2.34.1


