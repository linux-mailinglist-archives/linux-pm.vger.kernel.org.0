Return-Path: <linux-pm+bounces-12692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4F95ABA9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 05:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D0C1C25F8E
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A9757EA;
	Thu, 22 Aug 2024 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jsxj/5EI"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBF1CA9F;
	Thu, 22 Aug 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295592; cv=fail; b=lekmuUwY0t/hQGLiHXFarZnVOYIIt4XFDVYuBIdPdwEkagcedytmtFLGbhTER6AblMlUxqHlGftgYlzMyTyM2wVniYUSQGSmdGagz0QuMVJkRB9OKJdXE9AnSi1sJaIlbqjeo/y4p6QJwqShUnZ0NAwdq1qjfzYOZizEvA7PTeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295592; c=relaxed/simple;
	bh=yHLG89D8Ydj1oQcixYVTFCfv4+o/E3AFBB0mRWW+gcc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fr0dWqEctKHG9AQHY7duMpjX1VJLQk1FpWIoznbMTQB6nC9W/IehHkIEIDH1xlZ0E/Oz4cUr7tfCitYIymxSrusbtaMIAed1ur10Zrt8FAtfAuWquCzrPq5EueGd3f4Z4y71XfLG1tX7ZPZjnM6mLJ0aX+u+TkkeZ10kZesgqcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jsxj/5EI; arc=fail smtp.client-ip=40.107.255.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOKalOLOWCVKjaxbMCsfkMoGvOYUBTnSKwsPXiIsvyDyEndpyHlgNnjjZcMLgMNxwVq7/+L4fpweW7ImaWGgxwB5ZL1esjlmFHaGAz53KC+JQ5PbSENdYgiaYkTIMyd6Xix1cTu+WWGtI+v7LAQZ16OY9oOf564BEzror1zCvvWPzkkE83hmUqk2xOlaiQaIoM6i0aIFFn6aP43eKV1LB3jdWJe1iSNlxbDDqawxETUqyklrvJGDpq2YrjAtPYOQsGSVkanV4wsIuEfTG2fMM8ZiEEZXXmp7F4LfefqCVfsfN0ST/o2h2W1x+5M76RC22IECroBRj4L/QBRE/FArcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZOUbSHFskD89YaWWjWsl3E6nMfsh+q4/qRNr0QeRFg=;
 b=DED0iyK+/jcALQBubgVtiUYoteXJ7aNwhXaP9qKn19tWeDyJ1AT5ShtJEUB1BH/R63q+2ulwNNsHPPSnVzGtzJRPoLYOJY9Wgm9REotqjrhT2ZKvivGCXsVOPxeit42iuwneIuOU4QZfDS0SBRsGZRLBfZfDpiEmCPE/zZqAFtIqdS8X5FZHXg8cZ1i82qkzMw5sRLZ1MfNSzdEutTp3W1fD1+iwpVQ4yyt3EpbLD9q46sutl2EUw6R3TCF2ZaxxK/DgnvukDm2dQTbK54PITPfBkGqGqZzDYJ3GvGSVhp/pFDjtOkQWDnwYqKm6ozd07nWljH41Fhm6dWYjxfV3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZOUbSHFskD89YaWWjWsl3E6nMfsh+q4/qRNr0QeRFg=;
 b=jsxj/5EIEqkWuvMHaFKrJKqaG79HPVgA77Dabz09QKEZ4PnpfUe/EjOjKrVRCkA29cXe0Vi5iP4gFQuh6q2BgMvzJiHpTM5j1o7ueucaKXwnoripmQsOPqPgvVA5DOUBJGHfLc2jfejPKsmuYNt96YmzS8vfBdufnC98IuDrcPAz05HgbFgTaCy46Rs0/1V34N/HgQNc5E5mGDkWME6rYcedWQtRf9bV776wKo72BQXIkOG0+lHAdvFDDUnWzmNnhsA0ZIvDx4N2BSgcrPsAH1LAM963e2Z28yN2BfDrZL7UPgYaSqTTKyVoUY3xa9KUiWko0N7iuka+O6St3Dznlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by JH0PR06MB7180.apcprd06.prod.outlook.com (2603:1096:990:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 02:59:45 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 02:59:45 +0000
From: Yang Ruibin <11162571@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yang Ruibin <11162571@vivo.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:testing:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 22:58:54 -0400
Message-Id: <20240822025931.3455-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0224.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::20) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|JH0PR06MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b52c22f-c1d1-49af-14be-08dcc25679e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVRO5SNSxSRcKDygOIbuuMNkAF2J3Lxc/Byc+6AIkIwFCM3ZzjmSjalmZCLN?=
 =?us-ascii?Q?wP3nCL6lUC9QsFe+ZRjDqSuesIY2Vy+9VasZuy2LSQKpmuOhGSQH++Pgvc37?=
 =?us-ascii?Q?1Mxl0o+sG+l2vZbYHM15yHui+KUrwLlKkHKSOrnvL+QCMyx9o7hkFVOtkvAd?=
 =?us-ascii?Q?oOjuFooUnEAMVRY8aLfTQaB/uFfIwfRyoAjgTzWgcI2yz1tQzSPk561UQ0mj?=
 =?us-ascii?Q?3TD7FOvy/gjKH9yLLE/Os8bCdvt6mq8EawRbmbjDv4wwfRo+VPPMd42mxIAH?=
 =?us-ascii?Q?pAs5izOfiBVdogOdm8gdu1Ll/XwdMOfhYjMvRX84t2ZSypbDzQPCVI86ygZM?=
 =?us-ascii?Q?Dj32E5Hackifhn1dRnDQbLneZZswudK8Plv1AYrzPm3UMBt11oN1OAKfUQ6O?=
 =?us-ascii?Q?YhahuLaxLC5ocuO0czAueccyVGwPqQTXuhcTA7ngMyZOT2QbbQd7S/C3QI+O?=
 =?us-ascii?Q?MDVJSQvNy83IyTeXnCQlfQ6pW2JRMk4tpxtXSA9D0hX+MSMfPuzzqTzrYh1K?=
 =?us-ascii?Q?UiIfSYHBztvvt4VFzXhma03zdkach20B0O5iLtNQsJrvlyYIb/N7oucMmhed?=
 =?us-ascii?Q?y+/lP/KkktRq8467ItO7Egf8HUqt1o3WKO6w7RBAfKcQecdYs9MxAlt7n5lg?=
 =?us-ascii?Q?YwPJHLEkenZRBFr0QQIUXXI3yv9FZMIOc8k4rgDX2bll1NUe+dfaymwaalLq?=
 =?us-ascii?Q?RSQmjDTqw8tQSGHaTiY5voHPc24BLDbcEejvSuKZO9qTJmYfd++ibdwrEbEi?=
 =?us-ascii?Q?1ikek47/U+K8xqZVdcwMDoLOvDew7bRgSHg6WAs1whi+Pe+QPB43xo2k2130?=
 =?us-ascii?Q?KiUxWf3TsRqC2ClzLthE0Lh4tAd2dBPX8srsedZjPO+POgOmB7hmABR6YSIn?=
 =?us-ascii?Q?mxvxe/U58Lof6u81C7wL2wFhJMC6j+JiO+lrxUTyhN9NgLCBcEPf/IO5fq+p?=
 =?us-ascii?Q?/BKCcwH5MTCY/pE2Z8L0rdltqknHk6Nd7L+0cN1+pprOZMm4o9/T8N/EVLgV?=
 =?us-ascii?Q?Fo+OomIDb6BOywxoayMhYArwhsUcQYaRatG7PGYfKY637kxhaPqmG7Ai/4tA?=
 =?us-ascii?Q?PgfGn6Xwjj9oztwPLA9b8f9B8SG6jfc634KHvCsWv+2YUZeAPF8+2q0E/UOq?=
 =?us-ascii?Q?gMsW/TKjnD4s3bIlT0YYGqWwGVnQdKAj12Rm/n5+TXmmjMvG95jungzKm7bR?=
 =?us-ascii?Q?KZtb0gSqJIj9GFFMmX/ryHB8Ne366T3lS+uTBustOWaQ6JGQOBZ7JwZhXBUY?=
 =?us-ascii?Q?guVw2O9dmsUIjFlNqwVbo4mA66XI+ZlmW0O5pf5TlSMQp+pUPpG/IDjrotAY?=
 =?us-ascii?Q?6q9j8vdV5A1fbrIIkr/DN7im5BvhmD1wHXYgUtca1g9ychxrYghaHkTwbslG?=
 =?us-ascii?Q?NGU/cZV6yuuciSDEb1NB1tlKYVb1YERwVyglPuAGAOjV0i38VOi9ijBsppux?=
 =?us-ascii?Q?pQ/v0H9GhlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MpOQvTGWNdGmOcWhUUf4FvQhxObgEX+pNu49Cse+zH4ohKuETHXgJGX5CSVP?=
 =?us-ascii?Q?EYfE2PpuiuYV7zXUqfftVDroXW877ps2+BUVJ0pFvzNXnycFc7gI6AN3mlpk?=
 =?us-ascii?Q?q8IZQufs83nvftwrx3mnQ4NM9pu2sA6Tc4BlCD3P7G5+syv8G9WRkgjU+OB0?=
 =?us-ascii?Q?sa9dyIAT2t/yfNZFBAce2jTurOc0h2CRbc78heVnjm/8PK5daBlgZba57PVt?=
 =?us-ascii?Q?ktUYP8XbGzQ85wIessZybQcwZPyyzf+ggzcWsHnmU+2HGVajAXTrobgEVT+x?=
 =?us-ascii?Q?YcIbdXw1OT7KpWLniErQTqx1l7SgueV1LXrzO3pwwzPkcohQCsx4grQumw9+?=
 =?us-ascii?Q?R9Yq7dGooJaYarDxpZOjTBA7gQqckszt3DAD/A9DdT5VaDQ5bec7lKpI1HDN?=
 =?us-ascii?Q?exrRwklN8O2FFPiHZV9qhnxA9jA+HQzvRPkB4YXyFnccR+rWTuNNQP4mGzD7?=
 =?us-ascii?Q?ewvwC3eOba/2OGyTNTgWsY0oEmcGutPSzBPVvCCzbahCXDi8V2FDP7yuuycP?=
 =?us-ascii?Q?jS+aZZvx3Wg+WyGp92jD9sUCVH85/PxD7PPC6Dy2i1tsurVylJClpc29R6a9?=
 =?us-ascii?Q?Q6xtVt+IRu1VbG8ZgEIb31FVEPmh5pdMtVF2dNfZemZZBHPrxTUCQj41vWa1?=
 =?us-ascii?Q?lki/ULp5PtrpAmuS2ZK1W/fjMhPle8gVTbZntG/qXylcoXiHgQtS8Zp+pMNY?=
 =?us-ascii?Q?vL/v9TZXiUq08iLuZvFOHf/G4WneHwJsLpXRx927lBIDWdKWjrkzJBUjPOjT?=
 =?us-ascii?Q?NJRWy6ldUB6W13xi5094iBQOXQRftpUcd+Jlzd2I92m+8ubJnvt1Xkp1Z45U?=
 =?us-ascii?Q?9OA0LyzkHBN+dpg/39MFRB/1AooKZOpAE9XeVBMdoHXT/kc47oBekk3RRGLa?=
 =?us-ascii?Q?6CBXv8gOl9jfPC6dIFbgAyO6LAESmrj1XZa3kwvshGWhScHZgo2rWnh69397?=
 =?us-ascii?Q?HyJIzhmakczQTFPFj0KHxRvYsv5aWGB1zjOSFdvqXS6bV2ZJpGO5MQXwPD99?=
 =?us-ascii?Q?hMj0HV1UEERkA1Pwzu+DDbGp7L2kVPr23Qy6YQA+6PEcvAUrlGd7ptQxAuNE?=
 =?us-ascii?Q?/w5YK/zirrU3jRDpij80RJ1zEVFcMOisR6DW3pij7QSoT3Nx70akuyRhrWXA?=
 =?us-ascii?Q?gm71FMXvRvM7WRFIQaICKWQ5/xLY+Lb6Fqwymyn6oWa0i11ejCXWl2MY7eOh?=
 =?us-ascii?Q?uYZeUSjTVPtFUlAJTM3q4+uQU/ofg+RQw1BiAcaN+RI/jurCWhPDWCYbvHrE?=
 =?us-ascii?Q?0nOP9YN39gBOC5CqfTloc1ifKHcD9XjIvzY9DvZP4LT/Xp0NmMJxnWhNaTZN?=
 =?us-ascii?Q?6UT6qxkbW/eGe6UPabBujvz8AQBABUx1UHtuyQHJ7N2JoH7csB91YB3KOzrb?=
 =?us-ascii?Q?6xYcq6VYFGhkAFT7X08Nm1AnLgxj8dm37mTs6TkviaWxTbsR7MY1RmfyUx/B?=
 =?us-ascii?Q?axvKrT6GgInAC3yQBe/oOlV23q+4wrOeD8RtMVnAj9OU0Tf1knMOnv+B6gH+?=
 =?us-ascii?Q?LHOlV55T53WMkRh+jGwPfYEe9TTO+ZWQ/j1UlSZr3JTmE9yJyQPbxH5tPWfS?=
 =?us-ascii?Q?i4fPnfGSTXpWCDbDIcoZboqTDY2ZerRquJ7w3MLk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b52c22f-c1d1-49af-14be-08dcc25679e0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:59:44.9876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU2ElYgT8pqQWZQ2cDvpcmFoF4qWwUzUg6fQrNjxQAD6rlImWaozO68W79fXGg2WYbkaooh+GzrVwRBuxEKchw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7180

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/thermal/testing/zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zone.c
index fcee12b152da..26f0f80a6a5d 100644
--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -167,7 +167,7 @@ static void tt_add_tz_work_fn(struct work_struct *work)
 
 	snprintf(f_name, TT_MAX_FILE_NAME_LENGTH, "tz%d", tt_zone->id);
 	tt_zone->d_tt_zone = debugfs_create_dir(f_name, d_testing);
-	if (!tt_zone->d_tt_zone) {
+	if (IS_ERR(tt_zone->d_tt_zone)) {
 		tt_zone_free(tt_zone);
 		return;
 	}
-- 
2.34.1


