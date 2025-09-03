Return-Path: <linux-pm+bounces-33684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF45B41690
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 09:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0ECB5E0512
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 07:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEC62E1C6F;
	Wed,  3 Sep 2025 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Bxm/ARtn"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013003.outbound.protection.outlook.com [52.101.127.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DDE2DAFB7;
	Wed,  3 Sep 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884596; cv=fail; b=bc5ICO7XSkxYS7jxA2tykOt2yycTPNoX8ragxlFr+ZhjhJrRIuEc8hJ1J36PVehC4nAvnVNnFpeT8sQ9KLxc6qRO8fMCOU4ShgoAARuopkZQJb/NivQABXnFK6iBkHpiu/lq69dLA5tFeHN5wVSVZQMdWkJmSbnUwkYH0nGh1s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884596; c=relaxed/simple;
	bh=8KT0V0GAeEro1FYMAi9JBNBcRkRQSAvNUO/KcvWFScU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LCUIGSsm7oTnb8QjSYSX1VxGRV/59XWqX6IcGyAkZ+QGq6/50YhI9yKMsnf5VfRdsIzPCYxxCyd/0u+rtA9Fu13MoNFmAoKBBAj/KQFj8S6HZJgfVpP8zWXducuolL5v/WJdCWYCY0pG9HBPH1tergipuBHTuUD1ha7PhUXU9VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Bxm/ARtn; arc=fail smtp.client-ip=52.101.127.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGjURbfZTGwJQLkHP2IDxyiUgWiK5IdMHBwr7PJgGC+v+qzIrVPxHsy1CLy5hNFAfKpoSJty9HcRoGb7IOmW2Xb5LmSaESc8bdy+pXkfpw3gtNiSUJeTh9fHISFAwCJeBoK1lw0GjYrG8vDU7m9BprJNTbdxqVyGiENx0pH6kk1kjAUYQrQgSl+1qLK7OaV6GyZGOkT6KudHuJWMfRzYlGJRWxbq/qJdJs8AgjffAhsDaAGpmLLdyOYR6jmD25gd2qd7gEKQzNaC+/M+QVvXghJKm/6ck9mFpCE3XfcyfjkN0DChx9Mhks/UIbdOK4WLl1fKoYGCGyLILOFvE2vLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcNmUQ4yuACiSHeaW8Z8t2hvPoQcqT7G9GLkBVNwmtE=;
 b=KnbPVVRabsJ7tJzueOlWFSOJFUjSM1whFgj9UPh5GPAYCcvKQ85edHPOu4SzqA4JR83AFHXo85ed7M5g+SGv7E7Z10kWXNZktEVwfi29Wp9xfgN4Pwn8YO2dk7H+t2EbqfxQceJIrpiFbnR60uNCDbTkRSRh2kONYrztNBn8en+3aFVN89ynZXycTsdPCqRb3Nv26nXzunHPeNCsqfQMv9B5KoVa/MRTiAIT4mMNtEfP4kqe56lrDNb3tK7vPA7/eaaaenG1+KWSwbVzoIaiF9V49P5d47J8Jh6KpoIDRTjiBvpZCAAJrKP2EkowFiWmrn75fAnPhZdtNSz922NuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcNmUQ4yuACiSHeaW8Z8t2hvPoQcqT7G9GLkBVNwmtE=;
 b=Bxm/ARtnVRfZxpGW4F2ozSdzPNMae+MyNmM8LTEVN+OJETIZyotxPKovWph8/IzAz2Rrr5DUr2ds5itP+3pHpJiuDDqGlKcCSPgVdGnP4IhTN20NFT67ebSILpF4ZC6lSfTGbZ3Ts4I/FA4PK6BWQG/QLZ3ymZ9iaev9wLMV3Y/PlFuTmnfFQtBdxkCDcrCEFdA63nZJM5FkJ+VWyzV4yWORiPJd+YtQogmKtFjxtoDKZqSqr7v9VKQpYQ+xh0ny+FN9zOkPqrg6DjejWzPYHTpXlHRqQRzDvNkLF2o+c9n2V9J6wEzlXx1yi9ABwkeP20+3XNBd1KKzTAqSA1s7Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5184.apcprd06.prod.outlook.com (2603:1096:101:89::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 07:29:49 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:29:49 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] cpufreq: powernow: Remove redundant 'ret' variable in powernow_decode_bios()
Date: Wed,  3 Sep 2025 15:29:36 +0800
Message-Id: <20250903072936.4067-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0202.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::10) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2ef075-5d46-44e0-6c1b-08ddeabba9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nYqeKWSMp7snnvmcHWbaOgp0jYU/wxrI77sl0JTuN5qse+tbkDkZca1tcXpM?=
 =?us-ascii?Q?zkdF7xmJnh6lczlpFwiCwuqmuIRICPdo8FkTVua9wy2C3p8asKPHWX7hdyLF?=
 =?us-ascii?Q?HCu4zb7xbqwrOmSJ/a+94zxmkxeFbsEVUhLDVaHJEBcJ8JF6NziU8xc8TVHi?=
 =?us-ascii?Q?XVNhL5XBme/iNEzI93W/7ua83DdJtVUL4Z8BBfEDsit8Kp9G57Idjdhai9j0?=
 =?us-ascii?Q?eWOqyr2VAemHZGdYBteGtkvRzxqHKHfxa5VyBWUobHZKYqXOmQHgdN//LzZH?=
 =?us-ascii?Q?XnsCbNbv8evkkDXMwSNG6XYmOhTdH1aLDKn7Z7B8EuS6oZ72iAKNTnvvXSML?=
 =?us-ascii?Q?swp4aibuvITfWERI9DtfvIH3f48BEt3IK9c2jJdM93dbVTjMyBevqdZo60/b?=
 =?us-ascii?Q?nIwjvKYaaJblKor9OK8RfA3TzGxqRyX/bO0huhAn1ZZG7e5WyjoZaQXnQXDR?=
 =?us-ascii?Q?AqJcXXCA/khE5UQzEZXy6nFKd1Ly4JU7P/j3ru8Tl0/N8zx85aD3aNTriIqz?=
 =?us-ascii?Q?5m5RUajUP96/ph94mlzc+1KB4FvpR2bwqj8og5Y90iacc57zIDzM3ucEtLv1?=
 =?us-ascii?Q?/yc2HtW332UFV/kkKNuuhoH/MTCIn5D5hbDYMS1eIBNbggsckmfSl+mvzqlW?=
 =?us-ascii?Q?zocL1u+chw+xaY+YLqjLeeUG/NoYoIh4fb/cVKiwZ7FW4cH00FVLBX0qdtDN?=
 =?us-ascii?Q?PZEs29Icmphaiqu9/gH027v42e49DcGpPwor0xz1nN2+AKaidaAjvnxB3MVM?=
 =?us-ascii?Q?DuE2DgQYtEQpebBJIapGMimWtBwpg3iUDyleZNgJ0j52e7urgU3doiUOcld5?=
 =?us-ascii?Q?E5w+13pZ1YIvHtyHofMH5bliBKrug7kmMafIUPmZIkvoNz6w4ZoemaozGzU9?=
 =?us-ascii?Q?ks96VgKUFteTy+WwCKj2oFITT2DW5LbBzKZZF7M3vFOQqH+oVloYfmsyKlUo?=
 =?us-ascii?Q?ja+dfNAjile49woIxeM2mUMzAoxLfZHGaVjIYwbi9UChdq66ki9x7CfKTS76?=
 =?us-ascii?Q?OQ59OVCg2AVYlxOPxnoiwDFPmbLStX5fIf3JiEnTCQ/YY0mViAg2A0zKP5rN?=
 =?us-ascii?Q?dHzqmuKxYFevfMX8+sC+9xl63fCaTHWyViP5iFnZNY3tWsZG74y+5x3MsI3o?=
 =?us-ascii?Q?n2mfD+Ih/Ls9qQThtnvpUjKu7gaGsXPvjjkUC7CnQw3vMItnVcDX1rAO2AKs?=
 =?us-ascii?Q?TMtHIWDCnpiZL4zWZNKnxTH7pLWr47ateROoz2dphvkW3pXu7TwgrDTaX+dB?=
 =?us-ascii?Q?iq1p2RPPDL+IikW3siefCEWdxlpqi3FnE0g3mj0cJfToG5BZwx7eTfrby+DM?=
 =?us-ascii?Q?Z7rgMhwTvBRBFIOo8fi2HCPb4nLpXdpRq6BUiD46tfpp7Uu0mkFPpfRiqfql?=
 =?us-ascii?Q?coklOSSscdgCVQ3jy9FYsarb8JNsRJKNCpIcPkGfFXOghCFiAI0KCCondRfx?=
 =?us-ascii?Q?hC2O7sKNSghe/CBbls+zwg/gE/EXgd9Zgd3IecfJEpw7jZWRnpnDSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lc86mjAssQ36Jt/BXHa8si+vaM1+J3EIoMmBy0ZfWGakEtj1G7oZHIJ1fdM9?=
 =?us-ascii?Q?6vItvUVnnWV7Y31SWTkLCU4FnZnqtranq7IqaX+fCceCvdQhC9GYKKsJ+Ryo?=
 =?us-ascii?Q?WEycbSsSgaB3fQU7s+wwLVUPKvwrbS7ITQIgqjfrf1DOtsbVQOc+tiflEPiy?=
 =?us-ascii?Q?82O0KLZECUnEelx2UQ9RzcT0KW6UZf/li2qoo/zmx7g909YEx+1tzviz+XA0?=
 =?us-ascii?Q?i2qlJ4VP5OiQytfvyCg1JT3GN7yoLIDaQU27m9oolq/7cgum93x3VYaMRdym?=
 =?us-ascii?Q?cYu6wHcJM2whHFS3JGRUFbb/JVKuFH0XSv55mvCTXqakCogzkqa98MO2a3qM?=
 =?us-ascii?Q?RmoFkWjLi4htp20fidShZy/bOD+Ds5MFE27ElIqxRpzDMiWhGGj0+T9FKonA?=
 =?us-ascii?Q?l/NDt6K53/6/yIULnaxRcnlbYzEcB3Wmpi9kJdMybKnGEo/m/zbzgJ6/zzns?=
 =?us-ascii?Q?stXVaW2n4DNy86IkjlSJ1cov2aIBeFjO39PXYdjgm0NFYEA72k1+C5OPsDKn?=
 =?us-ascii?Q?YQa3gnuIm4iK99rn1+A/scL2r+A/gSEhVmo3h3q4+KZMYUrHieLFM1Fz/VWy?=
 =?us-ascii?Q?XtChfCMjvYjrv/UxYtGS2ebW7gfeo76NrTsUiiQfVM6x2FFEjf2+Z99URPlK?=
 =?us-ascii?Q?arlLX1nBsXo88GQoTxLicngoe7fnpZxUN70UrZU+LTFdPa58TVhoC4xLV0L3?=
 =?us-ascii?Q?JqEmlRb+D/KNWE9Gb+TYcvbFUcY2V3F0Xr4RLABoZDIHIJZunR/4cBdX9vs/?=
 =?us-ascii?Q?nBYCMfil74xJCZB76j+gTrZ4U/5q/jeMFX6ZY5ISYSd5KgHSfuVvMPdSE9eS?=
 =?us-ascii?Q?Xr56xJa0WQTrrd8j4M9krxboSyhWp8SEKn0UTTFSAQ4+1igLIheopK0+Vzxb?=
 =?us-ascii?Q?OEVxGe2vbC34Gu7lD5PTD2OWX1+q64u/gtyUbHoJoATMmmKHmhyXG/4TpYuc?=
 =?us-ascii?Q?cBh6HgHRxgB69Ul/9grsS6SNRfz8k5spL1KC0C+6Tzsly53yvM36fv0qo6GO?=
 =?us-ascii?Q?1aGd8np5axLgj6x4/KT6JQbfYZT3tNR3k4VHy7d5znPrJ2stVZRKuevEiXx3?=
 =?us-ascii?Q?6bmj+qDoYOlKdzHfDCyVTpy/XWCjCwZ33pWjWu9GTUTbLkCQ4OVVyW4Y6sWI?=
 =?us-ascii?Q?WGhASGKzPvbjrew2Aq4X6aqrXYkgRlv0bXyPq2AWvesTPuuCkhdn3QkSa0SV?=
 =?us-ascii?Q?8q0fxSqLdIlQAFlArKkSkjVpOW428qyQg/CP3pYb7SZBR5oOqxmMg8bvhOS3?=
 =?us-ascii?Q?u7Z57ktO1eNGC/1wKNjqeWHVlvq5lOiH0MD3PUwcgasHBE3GXbuAk0uQtGds?=
 =?us-ascii?Q?sRwUr/QrF8weMpp3hMeQqAsnrmIZC34D6DEl44E78wlMFB6DUyNkwbjVgtqB?=
 =?us-ascii?Q?WUsqf0U7Xltao5KMbngzhQYKYFmbZquErwmm83jlpxFxAonVqJ3JUanvjQcq?=
 =?us-ascii?Q?CC5Wg9Df25KwwKD9ya1QF2KlMCQvhutXTVYNx9YJmKsqRMlw+J9qJ6ntqXKM?=
 =?us-ascii?Q?PHptPCwmpK62D+7kVYsjWsWioH1SAUQMHPSgZtylrGoq3u3R5UXY/B+2+5DK?=
 =?us-ascii?Q?mABs8/+Yq5eWEtHK8Rj5FG1jHl4jDUDAloLg+6Z2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2ef075-5d46-44e0-6c1b-08ddeabba9e1
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:29:48.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNi7LtwClRRH70SscZmdQ5Gn2SYgF39YT7AdfwSnUnbKIWgsXHWnHodXNk9NrQ5wfNgsSi0307hEXnLtDLnTIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5184

Remove the unnecessary 'ret' variable from the powernow_decode_bios()
function. It is only used once to store the return value of get_ranges(p)
before immediately returning it. Simplify the code by directly returning
the result of get_ranges(p) instead.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/cpufreq/powernow-k7.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 31039330a3ba..72430c3c5500 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -451,7 +451,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
 	unsigned int i, j;
 	unsigned char *p;
 	unsigned int etuple;
-	unsigned int ret;
 
 	etuple = cpuid_eax(0x80000001);
 
@@ -500,8 +499,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
 				    (startvid == pst->startvid)) {
 					print_pst_entry(pst, j);
 					p = (char *)pst + sizeof(*pst);
-					ret = get_ranges(p);
-					return ret;
+					return get_ranges(p);
 				} else {
 					unsigned int k;
 					p = (char *)pst + sizeof(*pst);
-- 
2.34.1


