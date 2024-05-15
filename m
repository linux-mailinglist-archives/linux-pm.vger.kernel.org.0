Return-Path: <linux-pm+bounces-7861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FC8C5F49
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 04:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35B71C20D2A
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 02:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7021536AE0;
	Wed, 15 May 2024 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ryKXF19d"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2028.outbound.protection.outlook.com [40.92.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1438385;
	Wed, 15 May 2024 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715741717; cv=fail; b=KzWTMKAgDEDZI1GS2hp+LgPbEGkfzrB1tkNzBi9eGECKQEtN0uGQ9XcT8G8gzViBZzeGOkWk1dEryPC47MbKDLfDNx5pl55HSxwc+Uk//7M3yJsyX9l0xK4KY350VmIstntMw7CxNqi5pPof7DsVWLazH8NIt6/CszfqNlR+OVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715741717; c=relaxed/simple;
	bh=kyJlg4JUwEmQYBrVEJpwYB63H2EZl0q7oIv/SZ727uk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FzCkdYMkN4qDYO2mItb8IcVuhp6hJAhNpRQv9DT581a4+QtOoAGlb6Frgtp61z9S4dbatF7a+WRCTy6uBSTMyK4Utl28b4rrO/vhdUc4UI9Y/JRtRGx+AemilNV5VjN0jR+5YsVpzBLuBnvGx9heECGvN/fmHwJifYsc/JaO0Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ryKXF19d; arc=fail smtp.client-ip=40.92.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buAWRL+1o/A4TCUk61k8DNqJHLGKad6DTRGmHBMfLTkOY5fXDlZabMiODwhbuoPc/Kuah2VnU1adIxhreeZjy4wzNOMZy/XE9pjXvTvDdb9pFrWyblCI1WAtrzQ6aOk5UoVOQF/QJG/whMPMWE/BXvi03FHzPEd7/oUxJG8/OtFtVOzCc3icEGlLzybZGd7I7iwj5Sz3nqzH8Mr8FsDbP0oVpnvp6DYFq/sNj3B/TlRS9jcFCrxn6vwOzwgLCfSyXxGU7tOWo2i4awD3v4AKtkJ/pYlgGBi4E2y4mbmFNmjQFPHeJ+1sif8E8z+VIAHVecK3ODMp5CUeq3BRXMmPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QZMsI6jnor+JmmOWb80Z8HmBTj8MCv4/OX14oy1U0k=;
 b=LhoArpCN5eqU6FyayMTOl2MDhKLt6fhV9pgBoU4uhKk2QaLLMIsRV3I2p0/jhB/um4htPXJz5tsYoSdcDIClofL7z8THxPwt9Qzi5ZB7GLLp7SewpuHXMdpyvJWq3pgn/E64IJC68m3ECCzget8VAc9Mc6r75g/T4VrFrla4GGtpSAbFEJfVO66fgBaHbhSPt4JanSHU/naaoQNI1qrrlgxDHqJpqLM73BOzQwtZKh1P0s9ibsuDtdlLCnjK1IZqyn/4uG1wlUz9+rVAl1hnHDy5/Ccs1GEZJDzXz/3djJRJcGMc1SenCzsiYxA37zG3je+KGyGr39onyx/hGjuHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QZMsI6jnor+JmmOWb80Z8HmBTj8MCv4/OX14oy1U0k=;
 b=ryKXF19dY6xmDgT62GlsuZT9o6o04nBShe1IQ46ImDKu2USSy5817DZmmUriM7LqaYgv45ZumyOyD25I0+Du0RlBfN4dL7uOfBlyYmdqbPju0ncNqQj3F21ODGqAOq2CPUII3BWPY9fGoG4MiCloEuLQZ5PrrRe7YIh3GQvG98jLUr0NPoxS2e7dZxygXHTFSOQV2OOt6YdgGIYy3vG2knHx6MGLbMSr2wHC6AS7pz1P/pUJYxMFvc/3f/g1lSdtETGPsMKDYelw1KvquJ4W/ifyYtBZfc0jnEwoBCpmB44qZg0Id9lMf8hZxQVgoMrbY412ZFdbqWcLBcUjIXgrlQ==
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8) by TYSPR01MB5905.apcprd01.prod.exchangelabs.com
 (2603:1096:400:467::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 02:55:11 +0000
Received: from PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd]) by PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 ([fe80::c050:3818:262f:8ddd%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 02:55:11 +0000
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
Subject: [v3] cpufreq: amd-pstate: fix the memory to free after epp exist
Date: Wed, 15 May 2024 10:53:30 +0800
Message-ID:
 <PUZPR01MB51202786825AA6A93383B7AD92EC2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [KrhcK4SszUvuw2vhH4AaRUuYLGES3Mt8]
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To PUZPR01MB5120.apcprd01.prod.exchangelabs.com
 (2603:1096:301:110::8)
X-Microsoft-Original-Message-ID:
 <20240515025446.507310-1-zhida312@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5120:EE_|TYSPR01MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1eac8d-69f9-4959-97a0-08dc748a6fe4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|3420499023|3430499023;
X-Microsoft-Antispam-Message-Info:
	fOuOcF1NUWd2SeSNR6+BtlY+mt1SEjPTatoh7NxzRpKMzvfT4roVi8QIBEs/nGlab3XyieyKndfDP1c5BOzhEw/xebYLW1ose9FsIRZw5ICrgTJbexqtvqgPbdcmKWgY/Id25/nqXL0FVfaD98rO2xSoZrB7qEQWGTGfDQtGjIKAka7p+IX7sUWJDetUWGJ3X82I2czISsWRleHntUuATaLSc8qU0fbw+HSWpR30Wz3H6joOm6sQfrJzDNZihrmyVSpWaArssZ4DQ63hgBHZdX9i08TKykDvnpjH/XlY9AUgj2wHi90usRiwxaFKlJJke/0ZFrpFORiyEb4+cexSPYNY1g1o1nUmRpHAo2gmLAA7SzaD1pYSsKXKWD5b1XQTmHZybSJ0vABTRHs8v6Q+HAcqJdgg4ohlNIR43iazaG9DE68BgpR8PYKiInp1voEJuaL35Z5kejvsMAOGjU2oqhqaWVz65dhduNvOFZ3e/NasLmwuG7dz7gYXaiUM8lE2Qnx5NGLyGAVeQ18MWhGIwrrWhYF0MEeg+EbutCdNUxtPjHV1iLwb8YhpfxRzGTWF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYIF6nLAbJlxDvMJp3TSnCONjXTZddJZZhiZG1rhVlTpsw2denEp3StSsL6G?=
 =?us-ascii?Q?9O4hTtbT377n8TehcKOkrkkgWfs0LvIqOqZfMrPZmTeKZgJe9oruR3Zawj9a?=
 =?us-ascii?Q?VMof7b2Iphxs27Zcas+vv/Q31iyNvSMgXIcA3kg53nOAjbGlC6AD1lANaya/?=
 =?us-ascii?Q?+/80jlLEp/yb64RMLLP5j9f4v6FVg21aJAAK/nDm5zSKXXkhRvd3PyGq47se?=
 =?us-ascii?Q?P2MGU+/Hijf+mc/Eyr4ZsLHrLm31AKLgOVOla5GqiOLZ1z45KmrtprGsFzaZ?=
 =?us-ascii?Q?1Xcg+dGiHWynVnNspLrsQzVS3sjgqZvnlSwUCpG2ahGhIQOyIZcYVIyHz7rM?=
 =?us-ascii?Q?zYTQ5Y9vWASEbXyu1iEmXgtmkNP8U/WF/w5l1KJIZES+zqVZElb7jLy5udSx?=
 =?us-ascii?Q?yrqF80f6QeFuauNnRWsLIDYZ+rODh+KQVdUAP+13wDB2GtGIlio5V1vCUvJq?=
 =?us-ascii?Q?06/9CF7RLsNfjuHUCX+hH5IZOx4zrzCg1Q6/bJlfnWlMeUba2cGbthaw8gZ7?=
 =?us-ascii?Q?BnZ85jjq2QJmR57dqAlWINGnan7+8p3EvUaM3jJNsL0hzxXHZxs840DE68fj?=
 =?us-ascii?Q?qobZA5H4yCHhmbUesuoG8tjjrxLB2eCqCofohyGLfStu9kLKIxNZaki0+Uwg?=
 =?us-ascii?Q?EWPm5PQA8f9K/QygI1tVonJBjWd3KfEVyeE3C1RjeCWsAwh6o39SPvYzbiFE?=
 =?us-ascii?Q?uXbAzbeiqdXF1MgnnwcnxGYfazhMZ78M65ny+PQ/Pe+AJWCeu7obr1Zx1QKP?=
 =?us-ascii?Q?nKVrEYwO/LQJAf+FN3EXz+NThMQKWwnghrAoC+58K67/zmeW7i5z1seHo9tm?=
 =?us-ascii?Q?4OLkFXzjaKTot8Rgtc++ufIO5wzmT6KA41nhyhZmODqCf55szeXIVoMGeb5n?=
 =?us-ascii?Q?+fkDoXQq1z86CKEoRLls6EqvZcAwoBQpH790LSDr9uHoc5vqOhefKlGvYBK1?=
 =?us-ascii?Q?1OMmaP6EbwPUQ5oZ2rSXh1mL5QoxmwRfuS/9v+JCjao2fz/7juI1Dc4j7j8o?=
 =?us-ascii?Q?yEQz9PDLh7PNkOiV1cyCSPS6i7Il03DlmoQI21NW4J5vtbfmufG018KQn80X?=
 =?us-ascii?Q?ih/ql0dVuEuFr1s7+wOJSKhbme7r71/ahisLduJO1O3/1Qj6+c03H6JtpxHE?=
 =?us-ascii?Q?pgUqoifoVamxd0E3JDL5/dVmoreCkuBhK/jGO6Rls7NUyjROU/cUth6rhGyO?=
 =?us-ascii?Q?CqxzsvwBVntaje9Qogqt5o3qT1tMV4eA7cDVc9R9kbkU035uZya1WPfIti0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1eac8d-69f9-4959-97a0-08dc748a6fe4
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5120.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 02:55:11.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5905

From: andypma <andypma.tencent.com>

the cpudata memory from kzmalloc in epp init function is
not free after epp exist, so we should free it.

Signed-off-by: Peng Ma <andypma@tencent.com>

Changes since v2:
	update Signed-off-by to Peng Ma <andypma@tencent.com>.
	set a space between if and "(".

Changes since v1:
	check whether it is empty before releasing.
	set driver_data is NULL after free.
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


