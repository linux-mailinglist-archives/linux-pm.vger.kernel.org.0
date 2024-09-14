Return-Path: <linux-pm+bounces-14246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71D1978F40
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88C71C21A97
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 08:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586C146D5A;
	Sat, 14 Sep 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="i1e2FRDC"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2048.outbound.protection.outlook.com [40.107.255.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D415D1;
	Sat, 14 Sep 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304071; cv=fail; b=nKvwxrkP4Ma85C8ehYmUDq1hVh9XoUfVS98ZCihcDkidxoRprfjHAsARXaADRq4saAlEYxefQrQXOK/kdwbrzXUTxvoM5z2xvrD4xfjinv7ChrqnTgelhvuvX9aE6hB2dWWNDvGB6BqVkcGtZUeJrglsBx07hGxc03gkl3yp5Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304071; c=relaxed/simple;
	bh=kE9vhrZycHR4Cuc1dqWB/8QmbLWEOzYotz8DgVK2K4U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kG5xD1HFEpqSlVcHCosAGitpW87xdsb3r8YZRxtcO2g9Q7Qj8WjdwQz3ClvYcT5HW2FyUFkIj8BqdpcZV3l6nV0KVzan2C5LKxLibhR7sJh1o9y0Av2gEjMnAJT1C7rAeU0EFSZUYD9vvxAOn/iGGj+0d4XLOYEsyLs2Z+9Jrjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=i1e2FRDC; arc=fail smtp.client-ip=40.107.255.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF+I0KE6aMvPcvZYIjxqhLk0N7UMa6Rc+BFfmWLQXQm2u/O3BPK5HND5uLRRFxfN1d6eMCvUaWWzLjg4oi9LwVsPiyprwvobbQ1jgb27DH89GVzWVc1PbRU3UGcVayX6FGJ1xenEwd/C1iRBkq6KmY1bipKoUAwTjxuhT9HgVH7vn0eo5SBg/RrH7Vt2UrwhfWG0oTcEFtqID+BwosETctUCzPJtDMjO/YUMmqFlfXaOVl+k3T49PYswnoCgdNU/MIBxLyuurYbvMTsNehOPyAXUhAoOMGqAQSMRvHYNjHY8HaLtElSGjlsAA+hIJR/sKxLymJwPdDotK75DPBhmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvpS3ANjPGsOqBiJswsePSqAsLzNmrzQFMyknB3IUXM=;
 b=Pz61Ft7a+iy4qGLwHkom94kwVsjauvcWJ3pyp6lMF+Wailp+igtF+CuWMkB5njltmS1BNKBntP7vvI2sz0uGiszFfPXT5FQlfBYEhYZBo/EQPBg8HAYdaiIB7/kRmBlqIHFJwaIHF83cJnThVIKtOTNEDSflP+y1nJqyjz0kIdbeT9FOnvzIkXl7pbLtQJn5V+6T+zM3oRDj/Ldv8dxLO2vlWtVFtDU2FIEBesUPrpYTna8PsdbTHB8v89rAo14vRhJqnXw0VnDKuRu65x8yInX3rdWugT7XrmeAgyvZFmU3i6T1sx0TudqXEyBRIfvu/UX17g3ndDb3PJCnzOLxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvpS3ANjPGsOqBiJswsePSqAsLzNmrzQFMyknB3IUXM=;
 b=i1e2FRDCmuuSy6aWpRjlvvo9lLG5ch2fu/5LV1haFehBJcoDbaC9C2zOS+znwoWaUvJQ+PNbRhBS8c0haiYr4O+oDljoqYdyzUdnNHnXw2cqbkzN1MgKCxHHJP/FPspV4RHoNmvmcLtujzTPEduX3CXOZYawh72x2Gff0eY2MTIKRjGpb+VpaMk92JUp7/Hg19IguLUZfVoimHqLNOB2RDJqBlMeJFlRfPeWcxiiJZuAc0uztAKHjdqAPmkH9/SGNvXHl1HeBc3UH+4gtWJJKgjroUCUPQzSMQo/xgVgD8thdcr3xlrdv56oP38C5emS11UgzJfDPm+dfop9Lth3EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYZPR06MB7281.apcprd06.prod.outlook.com (2603:1096:405:a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 08:54:25 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 08:54:25 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: sre@kernel.org,
	linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] power: supply: Correct multiple typos in comments
Date: Sat, 14 Sep 2024 16:54:15 +0800
Message-Id: <20240914085415.3886-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYZPR06MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c5ad62-5aaa-4ae2-f537-08dcd49ad59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IbgnW4Y2SWyhSzg3lOPKv2ALJ+OESEUSVdTRK2QkJIp/r0XPyLoV0Xi+ocib?=
 =?us-ascii?Q?QZEeN9NXNDywH7CG1P2xw5M47+xRAVfTGm1Ck3o5W7VZrkPRktZ5upoet3dZ?=
 =?us-ascii?Q?Yf3SL0IZctuzN8bJOgpueDyXHUUOKCrY+q610ujgBPAMMBe0gKSQ4YrYOZ2j?=
 =?us-ascii?Q?tLhWJRJw4T2GEqTPfxsFx1NCHAkI6Km5AU2vgXgYoXFbalCmpqgS/bDaiQZo?=
 =?us-ascii?Q?OBqnK2pGzDZwlYWl7DW4grt56KxSQayQGMOnDeawU63G4tStpQlB/7fsxn8/?=
 =?us-ascii?Q?maYKTv7yD5pRml0tg3tdTYawRNMuYKQ0ADlesK6Px3uPMv/neB4pKDrYo890?=
 =?us-ascii?Q?aUK6i7tAHrEHOzmN9ou07XpTpoH305le99tn1eE0gcyM4IpyAzMQRgw1qP6p?=
 =?us-ascii?Q?HA2N9qfBV2Qq0AqWN/CTy3BjwizPPhx1a7XAVGBQQbzwT6vBwxjHMlPr9Dy+?=
 =?us-ascii?Q?JOZoX8/03CPitfaNZpOaQlE/OnQi5REeKbfzjZtCSDX9XvcVPdGMO1vu3kCr?=
 =?us-ascii?Q?lltRf4OfFAVdhIoqfo9zxN32gskk24iYfBAZAY14jyIp4+bSXVDbUdcRNMGl?=
 =?us-ascii?Q?dcxnqwejDcHLAhDNBYYMrcjbjToE1TLkEuRcGs8QumQQX9rUlkvg820wku2b?=
 =?us-ascii?Q?RONiNXb0wpHhH/SsUyPgyWd2/4T57NIfJkgQFmNmTqyc7YjcfzMfWkrdDelq?=
 =?us-ascii?Q?P8G0NkDnqAtB9Uxaw1KbMASaEu8jvkvA5jeLMUDJI4WbaGeWd7TXgarITii+?=
 =?us-ascii?Q?1IgljxBLrua3SprRNKTQq7+T9+pMLCzK6TM9a8h3jTWSYX46ACdNzRly5+yc?=
 =?us-ascii?Q?qTNE72lg2PZZNOUhvqV4FOLUlXBIGZzCVE9zR455Dn2/lS/IWHK2NP5ebXdZ?=
 =?us-ascii?Q?6y4HKVVhxUiqSuwyHjibJpllJNdlzDD70RqNLcjAXBZNBh6ztPDsDWA1IfAY?=
 =?us-ascii?Q?8MNq164znVe6wkHb0Zvo/l5jdslUwauOacFPZ/nJ9rLv1gMflU/j4fGe3q+H?=
 =?us-ascii?Q?8MDP/LCIwAAoCo2VMZoGsWjnax/zfzxYPw4uGheaB0yRubGCycGKnfyspou4?=
 =?us-ascii?Q?AApWsztnWQp6uRws+2e2vd/EDgPvKs7Sg2UkGFv7F/YDMbNy3/QtLGO8ZBwD?=
 =?us-ascii?Q?eOpAQdQAgvxrOmxnFmfpIJQ6wtWxgXiI60wWzOOw1v0HNOUY/iNAfy2JINmf?=
 =?us-ascii?Q?AWpSuJxq19yNAYb5UzHx1dcNjF5dD8960u6DdNyFsOlhJ/62RKXG64AHYHX1?=
 =?us-ascii?Q?DeEZUSg442ghIPtLHiBKpaUMlBA0Nd0c+LjglLxdKbl1WnbU0hLao3CDGhGv?=
 =?us-ascii?Q?aOOtB3jfiZiWovP3yv5qUumsZ1NKlqoeaZkS6uzaHUO9AZ13x+4rrtGn60tS?=
 =?us-ascii?Q?2/oeHwSQaavIfS/wU6g/NyxcRXLeL46I6mz7mTKxzEb2PsjipQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XxXO9D/z7Q3IJmNZoEAztrAjQiFUcmgelfeWsPmUk2+7E+zrNyvbGIyA3I/P?=
 =?us-ascii?Q?d1O3UaZE3cbYHQv2yvdX+ejtNPAIcV4rMWANzZG195RLrvXmrJDt72b8Rmdw?=
 =?us-ascii?Q?RmIQN1Et/cK8DPx8AEQPN5Vshfnb7621Ojo3UcgChMhYMWXG8ZRcGDYLkGLM?=
 =?us-ascii?Q?o/16flsweQ0HVIimySDtm274jExk/5/JX/w89TaaMAaq9EPOMcpx6xXndLXw?=
 =?us-ascii?Q?mbtGNRQ6YoPloFBpVk6TVKKs/T8IR056sh0dpS3qhMt5a6TJANHgfkU7Aw4y?=
 =?us-ascii?Q?hvSuzqERSG1I60fpncphYYL+Q3OwIJdKZLVqqcOJ248BtB4lGJIvStSS9meo?=
 =?us-ascii?Q?AhG/DKgDNBy7mS9krm/3hYzAKlfvByuNdZombd5MTuZy5d/NHclkj9ObPRbx?=
 =?us-ascii?Q?l7WZfwmymlg7xYZK97Tt6g2stwSm13AM0s8jHqGwuLohA2yn14JXoq1ba3wJ?=
 =?us-ascii?Q?vybJGAYrkbCL6CtFJWZ4H9ucL2M4hsYRSpuzecLUxP1EAk5Clo7eS+ce/I/U?=
 =?us-ascii?Q?FAOrEBNbv4MXC2jvKvI67zx16kkHbZltu/5LynuKLIExuAgNwPUQ+cvYm12i?=
 =?us-ascii?Q?3c2RQiqM9Q1RxdXv6/TXfg7MqHUvPsn7EePcwTqxfQEGWRe5I4BkhlyCSZ1h?=
 =?us-ascii?Q?8oORGYat/ipVgOCNu1P4yhpjgpu7B8ihAtQaHwdMCH26DfbZSVzhe4Y9BLhG?=
 =?us-ascii?Q?h5wKM2bTDxXJfcVvQ8eI+eZqP4iv/BTViblej57LE7dV1UZwebAIZVWf7a6E?=
 =?us-ascii?Q?vZ8BVRNObcVSoaJmsQISrdDwk32Cg4aLJzMarJosg323wwkTEmz2IpEY+rRn?=
 =?us-ascii?Q?1gkKhwihQEYDt6g5uCXDNuXdtjLxDybf3D7HiyOX3Wj4eT3mw8SG8hygOdoB?=
 =?us-ascii?Q?TMcYsibIIXPBtaoiIPzY9e+SELX4nicQ+D7JYmvZKzMa8yvEPxXn/BvzmWC+?=
 =?us-ascii?Q?aC16zlUCrSfsejpRd1WNhY2SyshJmPiQp4gSEbl0DuV/hFkT5RCyAFQYoAdd?=
 =?us-ascii?Q?1dkgxkXyYm3bvlMcCp2qw6qYWo2HoKuabTJzCbO9Zb0VJAx/29V5o5MS3B5E?=
 =?us-ascii?Q?7nLRej3WcORqkPS6XsAg2nUU33Nt0DloTQybNYeMfi+4ewbEI4KQQwfMQAt5?=
 =?us-ascii?Q?bW6Q9i44kj5k7X0qQqcpULb6dsmj5qxOhpFFO9JsRAbBiMZJ1tmi79ZBpxpF?=
 =?us-ascii?Q?Sok+GHiEcX9fdwATK+xbphYoAauZOSiuHns8KSeMjXL2325qAN3CZHngQUu+?=
 =?us-ascii?Q?TIstiH+uNrdlHXPoJoX4QrAPhm6fvAklmeE8PRh3he6WFivC734glrLVSqKc?=
 =?us-ascii?Q?UOjuNamzZlS3WfdgCkzpwRyF/9Uhcho4ZJ4BuOtadKkYZ5Hwvk1z8cvrtIzD?=
 =?us-ascii?Q?REsXrHB+Vd9EYQHrtjFEYb8clIQVVE9iCTIlJQ6IiLHZ/JGJMEQCMcm/Hn4L?=
 =?us-ascii?Q?8UeINII2rvLOKq1nu7iMwgDN6E6QvN63HiMTjupxRPh6FcD0u3R9tmADY2w0?=
 =?us-ascii?Q?Apt1JAhWNKIrxJVY/20W0z/abaB7C3HFTaGH2ctWwn6OAI+hV/MDLWE8RpyS?=
 =?us-ascii?Q?k83o84cAem8XL+13ffAFua7xKzKWwGa6JUjCADOn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c5ad62-5aaa-4ae2-f537-08dcd49ad59d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 08:54:25.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVbiQwuowKfIlY3C+A/RGRf5lZVq0aT4O3xrIZ3tqFwWJFHKWCZnSupWun4+HOxuYew11HONTkYYMUkB90HhVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7281

Fixed some spelling errors, the details are as follows:

-in the code comments:
	dettached->detached
	meausered->measured
	meausurement->measurement
	sholuld->should
	Tempreture->Temperature
	measuremnts->measurements
	detecing->detecting
	persent->percent
	Parallell->Parallel

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/power/supply/88pm860x_battery.c     | 4 ++--
 drivers/power/supply/ab8500_btemp.c         | 2 +-
 drivers/power/supply/charger-manager.c      | 2 +-
 drivers/power/supply/da9030_battery.c       | 4 ++--
 drivers/power/supply/max8925_power.c        | 2 +-
 drivers/power/supply/qcom_battmgr.c         | 2 +-
 drivers/power/supply/qcom_pmi8998_charger.c | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 34619c4d4ece..2b1783834d0d 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -422,7 +422,7 @@ static irqreturn_t pm860x_batt_handler(int irq, void *data)
 		info->temp_type = PM860X_TEMP_TINT;
 	}
 	mutex_unlock(&info->lock);
-	/* clear ccnt since battery is attached or dettached */
+	/* clear ccnt since battery is attached or detached */
 	clear_ccnt(info, &ccnt_data);
 	return IRQ_HANDLED;
 }
@@ -566,7 +566,7 @@ static int measure_temp(struct pm860x_battery_info *info, int *data)
 		ret = measure_12bit_voltage(info, PM8607_GPADC1_MEAS1, data);
 		if (ret)
 			return ret;
-		/* meausered Vtbat(mV) / Ibias_current(11uA)*/
+		/* measured Vtbat(mV) / Ibias_current(11uA)*/
 		*data = (*data * 1000) / GPBIAS2_GPADC1_UA;
 
 		if (*data > TBAT_NEG_25D) {
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 56f136b2d071..87c9b8e744b3 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -283,7 +283,7 @@ static void ab8500_btemp_periodic_work(struct work_struct *work)
 			dev_warn(di->dev, "failed to identify the battery\n");
 	}
 
-	/* Failover if a reading is erroneous, use last meausurement */
+	/* Failover if a reading is erroneous, use last measurement */
 	ret = thermal_zone_get_temp(di->tz, &bat_temp);
 	if (ret) {
 		dev_err(di->dev, "error reading temperature\n");
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 96f0a7fbf105..858e2b77ee5b 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -221,7 +221,7 @@ static bool is_charging(struct charger_manager *cm)
 
 	/* If at least one of the charger is charging, return yes */
 	for (i = 0; cm->desc->psy_charger_stat[i]; i++) {
-		/* 1. The charger sholuld not be DISABLED */
+		/* 1. The charger should not be DISABLED */
 		if (cm->emergency_stop)
 			continue;
 		if (!cm->charger_enabled)
diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 04e0f4162d42..b89604a8c019 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -269,7 +269,7 @@ static void da9030_charger_check_state(struct da9030_charger *charger)
 		}
 		if (charger->adc.vchmax_res > charger->thresholds.vcharge_max ||
 		    charger->adc.vchmin_res < charger->thresholds.vcharge_min ||
-		    /* Tempreture readings are negative */
+		    /* Temperature readings are negative */
 		    charger->adc.tbat_res < charger->thresholds.tbat_high ||
 		    charger->adc.tbat_res > charger->thresholds.tbat_low) {
 			/* disable charger */
@@ -470,7 +470,7 @@ static int da9030_battery_charger_init(struct da9030_charger *charger)
 	if (ret)
 		return ret;
 
-	/* enable auto ADC measuremnts */
+	/* enable auto ADC measurements */
 	return da903x_write(charger->master, DA9030_ADC_AUTO_CONTROL,
 			    DA9030_ADC_TBAT_ENABLE | DA9030_ADC_VBAT_IN_TXON |
 			    DA9030_ADC_VCH_ENABLE | DA9030_ADC_ICH_ENABLE |
diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/max8925_power.c
index 621a006d52a9..fc24a6d3b63d 100644
--- a/drivers/power/supply/max8925_power.c
+++ b/drivers/power/supply/max8925_power.c
@@ -73,7 +73,7 @@ struct max8925_power_info {
 	unsigned		usb_online:1;
 	unsigned		bat_online:1;
 	unsigned		chg_mode:2;
-	unsigned		batt_detect:1;	/* detecing MB by ID pin */
+	unsigned		batt_detect:1;	/* detecting MB by ID pin */
 	unsigned		topoff_threshold:2;
 	unsigned		fast_charge:3;
 	unsigned		no_temp_support:1;
diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index f0a64c00ddaa..47d29271ddf4 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -151,7 +151,7 @@ struct qcom_battmgr_message {
 			__le32 capacity_low;
 			__le32 capacity_warning;
 			__le32 cycle_count;
-			/* thousandth of persent */
+			/* thousandth of percent */
 			__le32 accuracy;
 			__le32 max_sample_time_ms;
 			__le32 min_sample_time_ms;
diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index 81acbd8b2169..3b4132376649 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -832,7 +832,7 @@ static const struct smb2_register smb2_init_seq[] = {
 		  AUTO_RECHG_BIT | EN_ANALOG_DROP_IN_VBATT_BIT |
 		  CHARGER_INHIBIT_BIT,
 	  .val = CHARGER_INHIBIT_BIT },
-	/* STAT pin software override, match downstream. Parallell charging? */
+	/* STAT pin software override, match downstream. Parallel charging? */
 	{ .addr = STAT_CFG,
 	  .mask = STAT_SW_OVERRIDE_CFG_BIT,
 	  .val = STAT_SW_OVERRIDE_CFG_BIT },
-- 
2.17.1


