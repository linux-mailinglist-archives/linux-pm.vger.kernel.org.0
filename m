Return-Path: <linux-pm+bounces-33461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8336B3C9D1
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A91717B59F
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710E2258EE8;
	Sat, 30 Aug 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AXCY3s3D"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012013.outbound.protection.outlook.com [40.107.75.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775641EB9EB;
	Sat, 30 Aug 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756546514; cv=fail; b=gIxKssEEMP66tWT5s7CI6bmm0tRViBWWDpn+PjJAw+Q9/X63e+F6P5R0zP1s/uKFW6kxBFHYro0tU755gaKlLuLwoue00rIOWK4EljK9PnTWziI8pJXOAo7Bep+RyjgEoJLet5L4aQPasTNocb9OGdKNGZu+GYTQ+ZDRcUVmWOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756546514; c=relaxed/simple;
	bh=L8/3ZzAZ71jGHWbMcrfOHjyiloL/JEQDWlBLpTrjFVY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b9FH2OifIbq50AKaooABuZW+DE9P4AM5m44GDTfvtOjWsUgABs420gJ37G5fFzwrvp4fS/poOywq1wqv7lm0BpEbzLJwslA47IKtbXdE07xb4JYq7sV40NsCny/FWxy0n1J5LLwxdnWgg41oAqwGxMXSSVXLGSHE/GJusAMtI5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AXCY3s3D; arc=fail smtp.client-ip=40.107.75.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe2QDksnqps5yLiUa49yWo80mrV9yT6eniDnq+hG1BDbXOVd1F/zX+hkaH0eAQ9HYsuzcQCdgqPnpZ1xywOB6Omj5D0uqfmM4TvfMPn9deNU+K045EZM6ZHL9F0hnVJorJCAVbb5EFF+FXWBLFaKJzDlV0M9/8qgf4bgw8ZpLTPnK8evrND92qdpEgbjJfA+od8PXRvMUgaBatiB9dOlj3HrbifGAwnqVgdlQ5lfy5BEzaacjFFCYHrFE6W+y5FdJr2Ln7mc217QRBhYzrggOiwn0ztEZI7WUBwAtbMByKMIWF9xaWStohb2/NzuPrprODOEChzhzACvL8Ow5TsmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRA4pwEBPQBMXs3+DNIpMHsJajXO+pShKR94muzeW2w=;
 b=zNppV/8pdSJ/AxLggpk1JRKX9oy/ntpOM9wqrvgXIGWbi1vi6hbH/zEYvuJA6U7JM6o788otlIgI9sYzRom5tQbOe3+8BueRliQVcL1PY6RI0Uu22F8raFXJIJe3OusU+AAgVEn6xS0FsQz01EfHXy1NLQm0/ejs0rG9DvAA/OSyxZ3tIrFPIMaTTgh1mPGptjbs+fKWPpEjCYyQBs1geEnrv/OQoZs9PsLjXEibE56AVhInPNhseEJ0ODv/NovdzCTr5nXwAZDOlOSC0H2b7wmc6Bd7W4L3WBUARHUfvp5UcToEyZQTnoL/ZZZsynoiBaWHNPcUXFafPH2g68N2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRA4pwEBPQBMXs3+DNIpMHsJajXO+pShKR94muzeW2w=;
 b=AXCY3s3DxckjsS/S7m75C5G+FE93ncSgIE3ZRBoLD99UVlhVAXv79qmwBIlBb6r2CEwF/6i/dR/SbXcDrqPHeOFYyYh5332aAbTzTkLan6gwnfhWzMf7RZ9zwO3QRM0yssTpM63fqYrOCbBOyDgHTqyTVcNEAGfWl4m/Qya+d+xocyfLL3BzQyolvXU4/eD9BuvJ0MI7s6pTzFBd+1yGLWSKQ1bG+Q5eHGDXLM6Cc9zjSzxAnYK6PvVXT3edwYxeeX9PodRh0CDPUiSzdj/O7i1qsyjHg+9n/nVVSLWH+l0FqhP7VyiIdOEsIGXL4+4wh6BmlhjnG3gx1xAWaF1b+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6235.apcprd06.prod.outlook.com (2603:1096:820:d9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Sat, 30 Aug 2025 09:35:08 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 09:35:08 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] cpufreq: Use int type to store negative error codes
Date: Sat, 30 Aug 2025 17:34:57 +0800
Message-Id: <20250830093458.642881-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a912dcd-e868-441f-73da-08dde7a88211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J43OLrMtG0x4FGnn0el3NZhD+3eM9eCywItfxTp/HKxpRolPWiNR9A9BaeWB?=
 =?us-ascii?Q?Ja7OoOs6IXWuPMqc1kKVPsypF3UTI9t858GMW5UtZzZeFStDUfi5J3F/884L?=
 =?us-ascii?Q?fGM5Iaj1kQJ0xPIy73W06LNdhcOPgluma8rWw3s3278/SWODfW1MqfJXDoa9?=
 =?us-ascii?Q?HLHl5LVdqclb6shEbeulwNzwK7sd7cX9vQkSiH/WC+UbSdPjM/dJu8zy32Kf?=
 =?us-ascii?Q?lGXuKfwny2aZ/bCpGxMEgbcUad3liynPsm6M6RsHBqh+YD5ZiJv3Xc0vBZB6?=
 =?us-ascii?Q?XLesAzgU4dPvsnJFjBk0+rv0+lD943aGDa+DkijY5j2MoDGvoPUV8YFtQMgp?=
 =?us-ascii?Q?7nfYl49/lBT/lO6pYEEiNEXO0EKIjCgYeUsGi1FM0dNnfYI+VM23Vk/j7VI+?=
 =?us-ascii?Q?dt9RFTkSZvOcICUQo6wX1OVsnZN9HVytF8c4Wa1SajYbru4UHJ3nxMH9VZKl?=
 =?us-ascii?Q?yyrnws8S0LaW/VqFelLh4eBS3kAu9gRdvIcY6ej1HkdWmJZ8Q8dKcXZYnmZ+?=
 =?us-ascii?Q?58YMGcUuqOJUlq7rLNI3IVZvGYKp9puTOi3sHKCyq1rdEHbMDR9MCZcqitks?=
 =?us-ascii?Q?PUH9idOGebhPWQ1GZrA73zuXaZeTImaAODVhc+mufiDyfBsPuFeHn+2DkbOd?=
 =?us-ascii?Q?2SQJyzC7tZs7SiCdMzn8iX7vYpY557o2m4+4B11U65Ghcc0eWuaNb19PW9h8?=
 =?us-ascii?Q?Xz6bv142EHLJDkNfgDwC8xiV/YDCdNxWe5H6bfn4LxLNWhMQCsRAdnzW6IY+?=
 =?us-ascii?Q?bmUQgxQ/QMW6ypMW+9SYFJxIMoDVXDzKHCToDL87Eksjnsb2md41eiTXf5XB?=
 =?us-ascii?Q?oce9JA95gJSF+gYrtwZEkeZV6Ww3Qb/1nc5xN8HDA3EE8309/Xp3ko68JJug?=
 =?us-ascii?Q?b3O9wUon7JrHRemfOlRWzyGrSiXsEsWBahnEPDrPUginuqgiVoiWYtFDFhGB?=
 =?us-ascii?Q?nyjgqfmViQfaew/aCJeLXT/HD2FWn/Ogefg9qzYcZ+jOcQj+tTKRZ0Ik2j8u?=
 =?us-ascii?Q?GPwLBET5p3WQhxrZi8wuAWoX84yUhV6gyU/UQ5S6dhQi98z4HsGL4uQQVPMv?=
 =?us-ascii?Q?VdSJDgfBDYvone665GjkfD6hS/GzRu/ws3vfKgVl5P7Wg+0bPOd8NFoX0fd9?=
 =?us-ascii?Q?kTV3VFNOzLZUylBTvR/YiemMBDWCNc7blUeINg49fKl4ypfSLL6nV+XaHmHI?=
 =?us-ascii?Q?Dypj0Z4jg3Y+KaqiWdHEwsqAukzzzpsP/ABJ0CmUoFZ2g1H5wWMqjK0eXmrS?=
 =?us-ascii?Q?zJTzjCLgD04psQH7BhPNGBFUX9HfN0wKHcLQM4i/VXTb05PVshmRLgEi7Yq8?=
 =?us-ascii?Q?ZAOgtKAhj9jYaTbzabKRsK3zmGsbcdyWtzeJ3zu7ZVB75WOTotCdXh3HGAxE?=
 =?us-ascii?Q?vDZSAaSst/DN3VwP/hWNRD9VFOZdxZz0Ss2Ahk8YyTyPtbfhV/F6ix1L5bn/?=
 =?us-ascii?Q?cd8Qcm15MIi14+CFPdmzY/IhgyV3FCSrpCPoZck431QUYQH43CN+Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztcvOVhzGaNo2WrEToReqiXNoW1Aq1DQx4Z2C0HwE2tpSQPXgyL71K38B//D?=
 =?us-ascii?Q?tdCn+ePwU0bosK8PnwNA6aFb5Mqzw/XjjTLjBUjmyq9rX7fBQgBh4it91y4S?=
 =?us-ascii?Q?FVoRXmJaL17JrA1+Eby3iV1Df51lRNXhM0HtLp8zjUn0QQ7oPLBZ6sVFZSrT?=
 =?us-ascii?Q?JFVRXMxEapV1Icr+mhMYjsRC4YlChPPdXBUbBf4MT8Gr66O2c0AGWVIqeULl?=
 =?us-ascii?Q?D6a85cdOiwOeAdGc1GUDsusM4MaU8LCdEcpjSrnwDRRnWBkNC4hcLgL44a3C?=
 =?us-ascii?Q?qbLzF/+VaHr9FtO7hysI6yMGl0Xk8IUS92jaK+so9O73PczuP/wKZtrPFEdQ?=
 =?us-ascii?Q?uN0wf9ngFNj+YNmaRqT5HIf3c4j2WDTbo+CU3v1yFqhJMjEh/FP6DANXoKiu?=
 =?us-ascii?Q?NMGeS++8ReuimewdLxm0Ba5JhRGIe7TdrXTGTbbVSTgcKD93SguLG9L3d/og?=
 =?us-ascii?Q?FUk6j9fsDSWZc+oglaiXuy17mx/jmoHSKCYJ2hCQfCg0Q0ify6QUMQ8GwhvU?=
 =?us-ascii?Q?NOfXHrilnwj9WYtoke168R04TtOcbCSkZpHSDOHXdOWAzPnCdfcoAfbVsLAC?=
 =?us-ascii?Q?6QKtZAsNKmJAl8mSQS1ts3D8sRfW2Ui6/Whm5ExPjENZFZai4brx1yGBmMch?=
 =?us-ascii?Q?3wSpxQ8oI16PbR0RM0NFkNyOa8pvftuaAMbS3sQX4m+8EmMzUnaoQApE/bns?=
 =?us-ascii?Q?g9I3KuiM+d9p+nJv4t+YLplHEGQvki/kLrbImmgERJsLVJUKFT4f7V3S1hOo?=
 =?us-ascii?Q?4U9SaENSpLRkVd/r0Yrx/mTpTuHXLOkeE+CDcsTy5I3LdR7LJ2tZLfPtjuWy?=
 =?us-ascii?Q?j4bR2WBWV4H1KxCq0BNE9b+tSaM0ni+a4ic0QFmUpAwuyNbnR+RfKBqrMkHA?=
 =?us-ascii?Q?0DDJlY1F5G/6E8QIXawPfkGPpBTXQhWQhkR0RU4WE1ZAbN1w/gfPTIJozdtT?=
 =?us-ascii?Q?26CpjrrdX2T6pVAf1yrwa6eIR7ysufVbyh2qXlPHuWBbmaLHzBjMyWgR9SCg?=
 =?us-ascii?Q?5TMKq89Yo8NzyGY+vVxIbcP5HiEAJzpNkNV62j9zwP6AOHdX2Klz8T0YYX39?=
 =?us-ascii?Q?j+T/oaBQYSS0ZJfneZXE5GXKGpNFTcF9Lxjas3TsvJNU0y3ebAYqhbKBYpDH?=
 =?us-ascii?Q?BIz5tgxmkJ/RR+nA+Hi3CD92ye1pqynf72mgmBUfRKyP4iQYi9YtB026E1wk?=
 =?us-ascii?Q?uoO2MsiIg3pLqriRgh1spLQq5xA+89m1p4yCUydrvv+fPsq6azJG6sBMn+T+?=
 =?us-ascii?Q?PYmM7geaAdJ6DZaVwVgd0NbFD40rRnZlui1M1GgmI7uvLfL4TZ8mF2/kO+Sg?=
 =?us-ascii?Q?MpwTUIteQJQOC/Pis8ONqF988URPsy9EBfXHlE6JTNsAUm0zYiTu/AoxkjEf?=
 =?us-ascii?Q?xMdQ2b90NhJ52275mnAsIzrWF4JBsJqosKwMeV6ZU0sJj4/Qu3LeuVcw/94P?=
 =?us-ascii?Q?tRlwgFp1z304c2ssZR6d2ZICVmS/FIBuvOpW3rWld124HV5ia58gdW0Twg5X?=
 =?us-ascii?Q?TOJKz7/r3TJlFoCnyAJTaBLbWokBHqbCdVmtduP9Kg2zY+VWxy4ofBJpR47U?=
 =?us-ascii?Q?2MCqNhFlkdMXIHFLag6VXiOT7HBA+ubSXHEZ5GQ6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a912dcd-e868-441f-73da-08dde7a88211
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 09:35:08.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO8Wv5uXTUCXVayKHth83Plv7XYYdL1sRXteTVKT7ACj+3vGj+yiAR0KH/SJxTURzvaGj6xpgxKbna/y+hIFpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6235

Change the return type of the speedstep_get_freqs() function from unsigned
int to int because it may returns negative error codes.  For the same
reason, change the 'ret' variables in store_scaling_setspeed() and
powernow_decode_bios() to int type as well.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but can be confusing. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Modified commit message.
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


