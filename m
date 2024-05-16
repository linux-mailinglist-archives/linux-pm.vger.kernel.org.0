Return-Path: <linux-pm+bounces-7888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDCE8C71A7
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 08:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC300B20EAF
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94752F3B;
	Thu, 16 May 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gf3YsIP3"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2022.outbound.protection.outlook.com [40.92.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE776249F7;
	Thu, 16 May 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841085; cv=fail; b=A70J8WzhEY3JAuJvGc6sDRdo+/PU0QVl12L7rJEKtP/iqt39uGqYuKbpPW/14EI4OqeSbKDsPVxhrAsx0KxGVZxIoNhDG1IuJ0UB87181UTmS0QJFIqJ+JCQ570PDDMJvtqHLpzg+i9RBlsnZV/Vlaf716n3HPBNTPOS1z2Ned4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841085; c=relaxed/simple;
	bh=mg9LK5E8arpRzuntSzUD23+A4wrpv38IYIuexGQgy0A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=So8McXZqdfnuU4yNJamgCOv6eL5qNfWV9QI9wZTzVPdPIum9d/579vg4GW6nCjd0uNERNsEW3qBnYbUBOFlrhnp5AuqT0YpzNdpfBA+akvJZzu0TzLzEx5VAOd4N6xKXiJCrxaT/8VgLqURSEqLL1CWRABUlbZfHoxB6e3jnr0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Gf3YsIP3; arc=fail smtp.client-ip=40.92.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOVDVVLa7rox/i6Aii5XO0m1Suyich/4uYstLHBjyszChtcehp88+EVyC6L/z3aAnsal+2S7iAzBAZrUV9E5QKBqxWdXCL6Wq0JnZXLlgqbE3rkItK48K5hLBY8oU0v4TYa/uaH2CYJl5M4TNyQ7efRGzbnKXJ4nYuJp8ewuD5fbsp5M2lMFTk1OOw1+NAJKSnCeh/IGCDuFW9+7USbi9qYcZ0vg62hNiGO90jm3I6JA14STjA3aW+1cZt8iZHE85zysxaSCCS+ldU9PSLCN4xX4nqQ6B8RIArtofFNUwSvSV0OKYqWxdZl8kh7n8k3rZc2D2Ofv/TnBolfZwIpNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa2VERR4mp9uAE47rBzsUUrUySBsgd8Lx3lAkLh1WWU=;
 b=jlHIb10h6HrgcHgSjCSXBSeuxRWu85lKMnSR1VutPSVZgUWM03JeRFjgR5Y8P5DBWAqM7oi0Det3dYfAJjA+kO1Em+qJ6DN/R8VAfIPhcd4O+cwckrpCDg5GfD2vz63g39N6yM7hhiHHU64eX9K5PKtyZ8mMAP5W1uBmGBMpBb/AG+Wrfoe4RJ/czhQYXE4pBoDJCnDMASNaBKoeWuZTrmZXdhqxsQjiMnBDSsKgQKEUsZqzA+YnIwR0ftdig7xedlMBQ4YPvQGUCVCDH9+oHTMh0ePDBaHv+uLj4+mDtfYg/a/Tdhv/OYnk9RVxFSPH/+m8Zfu7VstZEQSaJNXhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa2VERR4mp9uAE47rBzsUUrUySBsgd8Lx3lAkLh1WWU=;
 b=Gf3YsIP3EzyvhZ2pSgLuyLt6xypnrTse3rQ6bQUmzGg6AxCGSrVV6uQpM8cRTG3Q+rrS/EutDo04FttGRSjyhFotlpXNvtoe/Ne+gpFLUXp+eH63K5HX5NoNLBZEOte0jjoJWh9ziZ/5IwQZB1r5EqwaqUdviTZMStiuRJR729Oht0ay2WNyYjuyEpcN1RCExW6aqFQFlalF5aAIDOwSiIzb1KC4RMUbaOZOddzyFHtgg3pdve4104YAQoh42mrCr9x7lOsC9B0BfFc/Pim3oFj9K+D+sHxkXbDVdsF2Om0xX9r08AfCQCaNWNRoEBgWIjjjF0d4x9JjvZbsRrGw/w==
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8) by SEZPR01MB5631.apcprd01.prod.exchangelabs.com
 (2603:1096:101:133::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 06:31:19 +0000
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd]) by PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd%7]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 06:31:19 +0000
From: zhida312@outlook.com
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: Peng Ma <andypma@tencent.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after epp exist
Date: Thu, 16 May 2024 14:30:42 +0800
Message-ID:
 <PUZPR01MB5120A03DFF0EA1CE70E7334E92ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [FJq1E+vmtPpi4bHJd2zwQlENxYiAS/IO]
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8)
X-Microsoft-Original-Message-ID:
 <20240516063105.1167452-1-zhida312@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5120:EE_|SEZPR01MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da696aa-a3fc-4134-f789-08dc7571cbc0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3420499023|3430499023|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	h0P7PnGR38AHDFjqpMFOcssxBILATwipyVbyTUZxS93OSntWi0ZidyY5phXc7rEzFalpRVQW75VWA6WSvsw9mlzUvfTeE+Gq+jqxFXDXrVMW8awB6nku38ZFE1eOwc27z/badYYZo/8nxQNWQZHvgbFAeso73qwPdXj9y5K4ouv5//naJQp3AgzP+aeebaARKCbg6pXZ4x1AXbz6WFn4+x72imUXS8eAqW8eZvtE+3NbIh4CL8adHcS0+sD/F85VYjDujxDucSntd4A9LdvWsjn9DkIWhHDE7btpJ1D+FwyFxqb6Vh4GEIKw+niZBzV3wUXXr+IEDhR9B7X+SHR2bFcHdH9kUdAuuUvVoAIGRyGMY659H3P62OuwrJhqQ0mNrmUru+jgRNAPTMPClOsaZ+4ZW9GSxYsLEco2u2eIUayvTvlG7ni784fNfNP5RxRWH48Hu4IqTTuzIfCkZS6JoYgWc0er8++DAmAwLkBQuZpTp84OVadMCGs18BPjrxGsGhC2V7RN2JglK479CXN+LRXeJ76NOal+IA8PJ5iJDoXcS+tOXPIXAcEDH+38aPi0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xs+bLdftHqayGpIcRp7K+9gZ/rmuwL/6SaejWVWzifs5Kv+9g7NVtMVdCrSN?=
 =?us-ascii?Q?xbH69up2QKdW+TEvp0QGGtXge6XPkEfizBRKP4SjBeo0uBMPcFl38pACfFO9?=
 =?us-ascii?Q?NvnO3zEz+qQtk7vH6MU5Qa/dieFMLjUARtAgPGssAaY7gGbfcDBDgQCBw6op?=
 =?us-ascii?Q?gaqleRJd/+pspSU+qdZ/NJKJJ+96fGQ1punhUJGjnykY9ijNj9NMWG8BYALQ?=
 =?us-ascii?Q?r/VvdFMjVMxH1bFqPgezQshb8E2pyEjbuDecow58DCy4a5ISttIjOAmlxhCQ?=
 =?us-ascii?Q?yBs7C849t/hHQ9uyoj/Yak2b1F/6jSyQdZ0s6W84gXRjbaTkc1atMJCMad3y?=
 =?us-ascii?Q?hWwzx8lUE7BGuoE/HQ4M8avaT/Prv7c9RHRtV5WOWQeZO7f1vx8suveiz5eH?=
 =?us-ascii?Q?XyEroTr87waLupQOebbJoyYYtA10ZldeSACWh4j//uA1nMlBnyPOsWX5Vx1A?=
 =?us-ascii?Q?oys+HI80iMOHoXBfpAznKUAUa+GOC0QBdu5GOJtfhj81uty+ai1wy96L88tl?=
 =?us-ascii?Q?Q+4Y/jmbUcU24mWPNr9cENHaNOStfJO6riF+Yj+W6utJoyDzGzz3WyrHfVju?=
 =?us-ascii?Q?taqbgNpYod5k0+lFTBL8tWLMVY2q7SbbmHpD5wl7GgLnuYQx3QquHvumECbM?=
 =?us-ascii?Q?lVuv9SYb5oTbsIvJAIp3DWb7pxEW+3/XFt1+kLPZehkQ00VwICqg1hSnbZSj?=
 =?us-ascii?Q?C1K8kPcwRlhz+VV73QenSctiZ6XZwo/myYTScsN9QziRVgOqVW9AZ3H/Wygq?=
 =?us-ascii?Q?quEeRTeysIh4jRQrmI5KWUMN+Ojnu93rMnD6yxPjAUsWk3pV8lDY8lgxTxBs?=
 =?us-ascii?Q?gXMJwhQijbkc1gIfmIpvlqLjglIBUbdEvyAT100oPKzuRvHi42Lo5Xex0siE?=
 =?us-ascii?Q?wr6hv+2aWJhKl/Z4hB5DPA1oFDIETVtG12CW9bl8K1IueBrLMXMI+mxYgKhB?=
 =?us-ascii?Q?hpP9U4zyyGaTVOEYDgmQBhXz0CeKBhkqCzeIeS+oMnOrq9hO4oFeFC5wYP3Z?=
 =?us-ascii?Q?Lane9hgEsxtIP45njgXHMdR3r+JvWXGJZdiuaZS/c+Y77hzEWBGaMyvj2vfM?=
 =?us-ascii?Q?YAZMrZImHp/VXTYbPNfPw4Klj5ckPTeQ34zkK15R8eJ/yt1mOK83HZcsObX/?=
 =?us-ascii?Q?g/rcXFikuCube6RmR0SNEZuvf5jUjsrtK/dfKBfsC8vRN6hBis7lFcBIa6l2?=
 =?us-ascii?Q?Xs66cE4C+W5uaSPNSPErE0wRFXoXxoq+myso9+Sk2UA8fO6MMFXbXH5hHEY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da696aa-a3fc-4134-f789-08dc7571cbc0
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5120.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 06:31:19.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5631

From: andypma <andypma.tencent.com>

the cpudata memory from kzmalloc in epp init function is
not free after epp exist, so we should free it.

Signed-off-by: Peng Ma <andypma@tencent.com>

Changes from v3 to v4:
	update subject used git command "git format-patch -1 -v x"

Changes from v2 to v3:
	update Signed-off-by to Peng Ma <andypma@tencent.com>.
	set a space between if and "(".

Changes from v1 to v2:
	check whether it is empty before releasing
	set driver_data is NULL after free
---
 drivers/cpufreq/amd-pstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6a342b0c0140..1b7e82a0ad2e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata) {
+		kfree(cpudata);
+		policy->driver_data = NULL;
+	}
+
 	pr_debug("CPU %d exiting\n", policy->cpu);
 	return 0;
 }
-- 
2.41.0


