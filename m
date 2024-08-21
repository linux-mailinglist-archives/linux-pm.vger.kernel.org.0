Return-Path: <linux-pm+bounces-12606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A8959696
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B6B20A94
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3C1C1ACA;
	Wed, 21 Aug 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E+tDFaio"
X-Original-To: linux-pm@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010001.outbound.protection.outlook.com [52.101.128.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98191C1AAE;
	Wed, 21 Aug 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227191; cv=fail; b=ATh+6qzp5Aba7e47nu1B098etZ4PVQKtiWUVnffJj9GuHzltNJY03aPfjuQ0MQAxNg8R+UnGKazYg6vz8/xDqL6X336tqHVDtHKJqDw42PORJBlfCym3XVaTawtjhKgRhatH85fQrx3aqW1LvtBvekdXraEDytM6MaH3eNECIQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227191; c=relaxed/simple;
	bh=kTZv58CcSmLO6yR1k2nm/+TM+E5lyG6k4NwrwqUmd8A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qBAF22Gb5QUGRfGhu17qmqnhG0XlZgccN9fjdEglURTpgcbCXF70k+L3SEv523na/gyCrRTBfNhIDUy2uPquruaAAlgTpKgeHDYeAeW4FJl2vsZ7FWUVwua4KyVBgmwqfj5/5zH8qX6za+iF7GFeYX0vYgl+79e1HvRLkfCZKIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E+tDFaio; arc=fail smtp.client-ip=52.101.128.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geqi6MBnfZoRZndy/rfk/QkI3D9sVZxNBfWLvutm2yyAodjMJZ3EHLFJfAGhHPmvM16sEIyUBMSvu6b8RS7tOOhHFQ2lX6hLs7PPCRQ3HKiG3vEopHiD+Dmcp0nj1jzp8XONssuRRB8ccrrVAkdbvglPH2CLmlugzq00uYU8zC4OcCh7Py/nl3bk2yYQ0lFaH/3zYnEbkmd5gAQamXW21iR4zoIaHEVBV5/EJafazeJ72Y1R+dvHCUGBtTeNEkvyF5Yi8IYhIiESw109UB/WqVvrmyW0xqMtPvqxsax5snnP6Y2zxHY8dENZyxzGW1RqHhsr0C4+gAX7VbOrVYHRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPzNi7mK2FGvm98oYxCa7yuCLqkvYMEjfASQNYU3a3g=;
 b=EJGvx68Eruc7qTCpi3DLeFzamt6AmJ8B3LedzjDKPzZ2vaiN6aCL9RvD3T8hZUq2kEqFPMD7k3Y4KNJjjsi/36EuukBoMkGVSYymLfznFNu/ulUVYIp+xk4B2xCCqNGxEy0vCOqPmV5pqa586rksJNxpgDwoynlYplUMCNU8ykbPukxueFptOcwrB76+xzvAikiGIZMvd66F5nW7BUtfaqA9mYG2IfSDbwysSfQH7Q7psSygAF+MHzdFyTghSV3AtXGLPQ79fUnO5YM7cs1ZyV3jAJVJ1aqaaPgq46u32vaMhK7UMsGogxL9yhVG6Q2gppBa9vf/6HD6UEWJNgho5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPzNi7mK2FGvm98oYxCa7yuCLqkvYMEjfASQNYU3a3g=;
 b=E+tDFaiogeEQqROwN7gzrmVx0hPCetTUDy6IfH/uPfxKvcSTEZ4+hipUxJkB2YQOJDrH09eVfjtDutmBsaPJng+1tuPonqZP7DdmW0ThQ/apXkhTj3jwAWaJ9uB0tWdXxulkmZ7dkZxdg+Zs8ezZ2a3gxDDWBripOdB08DJZjWsyPdxctBXYwDi9i9j+Jyte4vyeeU9ULHORngeTnVKEKf4Ci4fb45ZU8mkz+S4Z/h1afuxPmuAE0nA+c41HD09RCV3HacVDk/AKWht4SFIdhmfIEYkTxrIOV2ccdKngyHY1dRAugx5lwesdWQY2EL3TRaO5T5Cx6btVWIDgXuAvFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYZPR06MB5976.apcprd06.prod.outlook.com (2603:1096:400:33b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:59:46 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:59:46 +0000
From: Yang Ruibin <11162571@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:thermal:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 03:59:33 -0400
Message-Id: <20240821075934.12145-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0284.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::15) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYZPR06MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 646e1cb9-c854-49cd-0612-08dcc1b73917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tkVVFXGMMRdT7KFx60EszE+2DSpYs4I85xFOer6ANEZ+WbXwP1AnddoNLDyY?=
 =?us-ascii?Q?UwHmmWlJIvO8wELC8pNHaCUMtL6zdgqJs8GE2dq09VdAZ9rRopYIYYfLd8No?=
 =?us-ascii?Q?XVkgy5Pa6YLsZh1NpbyRB7ooZFr3fsk0ZE25z98BnRpNLG+i2DOt7a4ZaHBm?=
 =?us-ascii?Q?mTTX89V8x6EZY+R4zh/mOuQdDUTdMGbb4tHmnbkeAsH9C4Ji0L0X002OM+R6?=
 =?us-ascii?Q?NTnncnhAmRPN2fGevPgQ2DoS2Duhk/NdOt/DrztukYf+ahF7v4NZBnVH/Qxw?=
 =?us-ascii?Q?enD//ZFM+ddENucY2qbV91SdV7eHcKJ60WKmvgUsk7nMe/CZFKHOxW3konCw?=
 =?us-ascii?Q?yAmGJeoH7jHwBH6WQkEZBX1mcq0Bl03V1NAuD/YzrW05yZG5NHRKHW5ncCjF?=
 =?us-ascii?Q?1hGdd7HxFcG9Vkfkjqiv73nAcpFhl83RzBVymiAiII44zdKBi2NKELau7RzY?=
 =?us-ascii?Q?FFCKjSTxzuf7zKP4ksj69Yt1jLVM53lSEPLPdhbA0lUsQmaPQJ7dQVuL5CPg?=
 =?us-ascii?Q?5lerou60q1j03DD7lrISChjg7JFQsZs4Tkqn7Dt6GszD3kumhjHvUgyC5fgE?=
 =?us-ascii?Q?b8mCpiOFGxwfNXtYnWaPk40Q8hCUl6aqBdBc6ZWUXjDM9uw8dQv4akOf4t1L?=
 =?us-ascii?Q?xzovoMf46YfX70KR312PjbRfhjY+cErCVALVtL51JqzMBJEuaBciitVbuiHR?=
 =?us-ascii?Q?xAP5OAp7F/v59MnJRTuOFgZhoVPT3b8ne8p18NKuKkoUDhlx6+bZKttKQgv9?=
 =?us-ascii?Q?NdEpoj4JdJkTS0Y4p+z221NzXUY/PsRaGM6z8iUYfHEmYBPJUZruPGcffjpn?=
 =?us-ascii?Q?Vla/ZZZfVHXQeUkTQ4Ejh8wfVYfGtCYD5163Sj4uXwXTfIM/wzFpptoX7oft?=
 =?us-ascii?Q?/M86wJIIYsHCxI8qT4O1vCoJHR2bulluOIwM9KAf1q6CnpuRXYW0rSm2Lj/b?=
 =?us-ascii?Q?1VmL+u0x1x1l23bxS3MtlLPRPkzPPKn9vmJUDF4CJo567LijXIX4xobMI4qR?=
 =?us-ascii?Q?zgptW7YQCDokCJNOd8g5OyRXRVZtHq6qR2CVfXXPaLOTxhROR6TybN5pumHL?=
 =?us-ascii?Q?GpqNG8IiZ6RlLX2+a/WgFmq4m0yLMFzrfYDD/n1Ep/LCI3Fe9pEdo4KEdKjW?=
 =?us-ascii?Q?AHxzEMXrT7dCD/dzqSKFmZxacYTXIV3Wa5TN1XX2L3DRWhkFhUPHri4JUOMu?=
 =?us-ascii?Q?OIMn31+6Ti8buoI7bsIpToFp0dd6salBEzvX75ifyk6FrchfnGBemblO40fp?=
 =?us-ascii?Q?Uu1JYqayK2m+IIq9TP7wmcpHjabmYnFuwzB2dbsH0f9z4RoraVVBZecb9JN9?=
 =?us-ascii?Q?V3EXusUjcFFN+0VtTzQONIybr9k1xgOyFpMk3g3sXRsIFppcAYyJql6/BOxb?=
 =?us-ascii?Q?Uf5XE1ISqaYwhzFIBpO8oOcEu0b2BTkOE65P/XbA+zdKPpJ9Q5jIxe9lR/6d?=
 =?us-ascii?Q?vcdShPRQXT4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jMRA69VJhVLH3bNhzMJpyfAjNelBsPfnYnCHVdvoPQRkhyaNipGTAf0CxlwD?=
 =?us-ascii?Q?AJw2Rkiu6IRyRg9+ycdRWTeVEBh3GU3ebJ1HKEyf0HTIidWWnROvFPcwuIc3?=
 =?us-ascii?Q?GKEsP1+AA+E02E7KwBTMr4XBPPwkEu9M4UyONKRX/rDDi/dZQcS6rxrHZvBZ?=
 =?us-ascii?Q?rQp/vI9zo9XrUPAJW430SNZOPiNWWtymfNantMhq28Vk/ReCgoAes50jnUek?=
 =?us-ascii?Q?oN+LrwF+sTbq+nGN+a3GGFHJQS5w2BRdRGtvCeBGIg/Pl5lsZjH/NuMLalJl?=
 =?us-ascii?Q?cMYj2R5QnAPwVeibQz9xH1z9YcfiN3Q+OOBLhUg1Ep3lO2VYVWY5pbNwYEDS?=
 =?us-ascii?Q?+xnd7m9RkJ8L00T+sBIkg6SjMyAnDU+X5V+VpsujXveTMxEmhO3tU44MIDpK?=
 =?us-ascii?Q?rE3pTrblqoKwAQAluDIJ4kLeQPGmLFz0lnFR5QKbp3rRiPC8RlMpo68ibJrs?=
 =?us-ascii?Q?JrYllbxKWq6W0WxyR/PG0FQWi1NNSwuOvc/HkI7IhLAak4ngLhH0NchTIHtd?=
 =?us-ascii?Q?IZUE5tu8Jq+4h+4f+9D+u7bPwYBMmNRlxdIdN5bKUEF8wILTZ11EZjgKSU5R?=
 =?us-ascii?Q?kSjORi/Q+inrzUfT6lwJinRYFSc6ltiDc88JmO2fp8R1BqFuaJ2IKT4UJlzh?=
 =?us-ascii?Q?Yb/fIbx6YqCRhrzbbf4S2kkU0GdsmrQENDoSNE+995lCt0lkB+5KAQVBia2b?=
 =?us-ascii?Q?s14ZvFTv4KQodwfxptLaXGXzHZ6/U2OQOVYB6hNBuBW/YaOOUHpK7wN0hKYD?=
 =?us-ascii?Q?Mq/iEpUVJxRWOSm/wdooKs5oDOx6KzdNySZibNKzk+RzXFKFsYbL0487Qidz?=
 =?us-ascii?Q?hbkm0Oel+ggx493FVnSprOi/MF711+ufbx3q1DzdeStaUpKlqT7f4ou8/rAY?=
 =?us-ascii?Q?mks5aiSTgnwjSXWvcg4f6iaVatZHULrn2VIFhq67ydUnKWbdP2HisjIAnKrE?=
 =?us-ascii?Q?5bVBUn15zCHSiDeCTrNxyfpcqq90Ix0mTHdIIG+dboQCRE1mIgWFx3moakXB?=
 =?us-ascii?Q?CgCjKoJEoo/S1B1Y84IaKSN0Cg8Hpih+QRc8AGMBamdm1gdJua8mWeQoDm5L?=
 =?us-ascii?Q?JspnLGRpBZA9IY4enlpEIldTkvudY1ZMJPJmDzYLuV9Rij7/4qzxVMJDI8aD?=
 =?us-ascii?Q?gVy+Myj/21AIqAzZPc+T4oRi2j7VcpFJeHQ/QoldIknoM4NZpm7j3EPaYWrG?=
 =?us-ascii?Q?UsSzbe33/QYMNavtkn6yVI1IyNgZFpHe0THPn9m2zC6IxO0cJorOsJ1R3zSO?=
 =?us-ascii?Q?dd1RVKtlo0jUYBQOprJi3ETyJjP/UhuSvEDlgIerCXz27r6eaMtwejNL9uH+?=
 =?us-ascii?Q?BbGBBiaEE6ymuXR6Ssgy3SU0Mkk8Lyx12Z5rsQWvF8CwuTQOaUqN9Bpiicpb?=
 =?us-ascii?Q?8LuwELZK3XYNGYZdBfHwXW1mMCHnIS92K5Ch8AwaqJtHE6v7BvNdDNJk8NYC?=
 =?us-ascii?Q?8d+Nl0/Qna1YN48qxgdNj/LED7gMhyW4TxbS1Xtvh3HtEh3jjpJbIIeupZIy?=
 =?us-ascii?Q?S0WyfIKSBa4k7pnXk+lx9MxuA6zzWtp2hM5yZ7GdDM28JPeVg0xKZET6WI3Z?=
 =?us-ascii?Q?9TWIMmawk5u+X6G4Chve4vf7wUiG8hD1wVIz9SZ5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646e1cb9-c854-49cd-0612-08dcc1b73917
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:59:46.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLq1wKC44CSEaDUy8YdESg8PIX3gkdGq1Nwlqo6HgpyiVr0xvXX1RC3co6s8fCpRecBoWkaXAzsNKIzNCnPP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5976

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/thermal/thermal_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debugfs.c
index 7dd67bf48571..939d3e5f1817 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -178,11 +178,11 @@ struct thermal_debugfs {
 void thermal_debug_init(void)
 {
 	d_root = debugfs_create_dir("thermal", NULL);
-	if (!d_root)
+	if (IS_ERR(d_root))
 		return;
 
 	d_cdev = debugfs_create_dir("cooling_devices", d_root);
-	if (!d_cdev)
+	if (IS_ERR(d_cdev))
 		return;
 
 	d_tz = debugfs_create_dir("thermal_zones", d_root);
@@ -202,7 +202,7 @@ static struct thermal_debugfs *thermal_debugfs_add_id(struct dentry *d, int id)
 	snprintf(ids, IDSLENGTH, "%d", id);
 
 	thermal_dbg->d_top = debugfs_create_dir(ids, d);
-	if (!thermal_dbg->d_top) {
+	if (IS_ERR(thermal_dbg->d_top)) {
 		kfree(thermal_dbg);
 		return NULL;
 	}
-- 
2.34.1


