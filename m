Return-Path: <linux-pm+bounces-15091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AD98EBD1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02C11C2131E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51313D502;
	Thu,  3 Oct 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1i+Xw5pp"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CE2232A;
	Thu,  3 Oct 2024 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945065; cv=fail; b=YzbPSORekMjDDkl7CUU9YlIM+IPsCqHinsNyLysDFmMOOW6Ak3k41KnN/Y/qsSLJx+mgGSO3m8xqcEdCUaOz3pTgJURrr3vXxuAKIJizVcRSOLkN9IChw2Zeu5QauRj3sucOHbZ/lc8Vhpta4Ga55n9MiLAOzyr84AwoZRUXxJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945065; c=relaxed/simple;
	bh=MLZjQpjJnF8ZG9AmnC0nMR4qa1qq081eaYw0+LqCrLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTyT2/8I02uaKZiArsYTA0UvuzZHuRlKygqUrhkG+Y+UBISSBTcn0E8UKlb7zpmL5PEG+puzDI6vK02RP5pmO4aDrfs5WHOf76KttV4BFx3gZhmXVXFmHLfI3leZ+ZDZcBZVD/IbOLMcto2BkUzFdKTI4iv0QRBa/YytXy133dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1i+Xw5pp; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdZX11LVCu01A4G9qVE5KPevoQlh3f3VQdiU3vOVMNz1pdSXYi/Z75ukJEBEBFemp1V5h0+ReLOAEu1sibwE9u+m0nrvHVC1/66vdXf3X44VoT8gyBvnHiMoqr0g27fiwMtOcoFQLsbr38gDsvuPasnAe1iow819Cxwi0uWFycVfS/Of17Kbp9JbUrlRysoFng26q/MYt3OkzIoQZjPP13eBgoYjD9UrOEPeXiXMb4LIiR6LKIt+A8PMBqW7LVU52dn1WeC1VE+HcWA+0SS2crxHrtqNONaDLlTePcn6Cd8YzzkwG+c53hajR8Ul5q0u84zZcDusjuu8m0WwK+JJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpdU2YjvH87ZsHFGogC85X3ne5AfGIrGwKcUYR0D/1A=;
 b=GQQ4XAruRKRyiie6F5dNo5Do/EVsGpx5SA93yZZRhAldJFtNgFVC7WYjQX3ZxDO9GeDGYsJynpw1gfrlU9iowyoKsBzvUfpH3ssTpRdpycX2AFezQoUKW67qLL7CYQxsPDdff9qw6aUzhWVqY8Xjv3cYZCzJb4nkhSUu0gmoj07r7ovNzDVt4rNVI7YS+egqPMMm+WBZ2FHMnaCFrtfRNCCwSZpRTLD+C5tJLOqbClMM/Ai5i7FEYJJ3fZ1U12Nbn5NiOrZb4q0xonw5eMcoyc828SbrFyS0fmleih5N1nEeLatOyhZyqJ0+fyYqpUscax6Eq1AKhwnQ9vnE6ustsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpdU2YjvH87ZsHFGogC85X3ne5AfGIrGwKcUYR0D/1A=;
 b=1i+Xw5ppsLp2FVn3n0HiwOcFqilxSM5N7ifBz9TcWgJmkqPjyqCOIQx/mfzv+NrnanNU8V1EmyCqeRbU+fVYX7FDg7JDhB71BrKwMcJtnpa2/YGLo5uQby/tVClR13JNvlAcJD596oJOmf5EnswrG1a/a60AGoWBTfR0jO94IqI=
Received: from DM6PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:40::26) by
 PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 08:44:21 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::a9) by DM6PR03CA0013.outlook.office365.com
 (2603:10b6:5:40::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 08:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 08:44:20 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 03:44:16 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ray.huang@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req from drivers
Date: Thu, 3 Oct 2024 08:39:52 +0000
Message-ID: <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bfa2c1-6d52-4577-0595-08dce38792ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIprc10Kg1ONxMaanef+boy2xSQmaOWhM8vsVE178+QBVseabFViODCnIw2p?=
 =?us-ascii?Q?bhjJFBQM66HshE662RhZhas+kealUg08JOkDHp/XfvI4Ot28TrH0oMuuIfOf?=
 =?us-ascii?Q?p3eqdJy8GPeYNsULWSpGcJ1dfvVopo/+2uwUAn8iVybXko5jE2a7qFCoAM+g?=
 =?us-ascii?Q?UT+MxbfuBlVFADnskq+gprQOXRL3DLcV2FwcwlcC44U2EYT4/yJImiGZIPom?=
 =?us-ascii?Q?DxHsdVzJYIjQaLbH0cEc3yLl1nCEMDmSUYXsEG2EPlHhxdUO/zY2Kyt5lsMc?=
 =?us-ascii?Q?6lNA4hvVlShdujCKzGshk9sTN59460eaOqg3YcCwmwsKNMfROW10/mDOhzEG?=
 =?us-ascii?Q?Cu1TPu3gXhBIInwRosKjNwc+C638QgYc98ELmA3L09l+a8wvYKTAzMgrsQth?=
 =?us-ascii?Q?p/xhcYd1FVaijjXIBrazvPuXOQe4MN1gGsoWDjVNXHF8dcBhmOyJHnBuuIUd?=
 =?us-ascii?Q?ZL8oycvbnzYH1ILtqnjRFuFVhN/yV6QG9Fx9jrzgw2JByGJH+jZxhzCmnqnd?=
 =?us-ascii?Q?mpa7uNmqxbBOoRviXzU9IETPFFsC7DIxOaE+X7nF3ckX3PHhbOSgWnmVhKlJ?=
 =?us-ascii?Q?LuY4rfvDD/kwhCXXS3YwWSRpj1AD7A2iB/uCf87azF+cWiiLNQqEaSsPtBKZ?=
 =?us-ascii?Q?OOyUxC0zi1fOo1xieBOIiLAcPbToSOz+iZx1oXkQL7xskk2pyrRYKb/rFjVY?=
 =?us-ascii?Q?DwR7ioW3dIFTIAZmrh9Oh0mnvLgbFDqD0xqeheh8DZy8u5J3WMgteUzbuJ7D?=
 =?us-ascii?Q?k5ugYH6WvJTSPFUKx601Rx8tYz7mbTDtkG95EW100DKFUQ2hCdriHHFRIhgP?=
 =?us-ascii?Q?8LgR5nxhG1VlP+DqYU0msJ+QHK/nHPivOfbGCXBmP3+gyaLzrGRIJjjSqmrX?=
 =?us-ascii?Q?8VSp88dYWx5zDMz+0T1dwN5op50DMUXLtX+DpO7P2EtHj9h22lqnaCfvJNvS?=
 =?us-ascii?Q?IVSgZHklmrSBqCJenDqgCM2I/onC6sDeEZdKA2S6ab3Bph9RKk8uMhf0ZI2r?=
 =?us-ascii?Q?esWYjq/Z84xqiDZPU0gcHRCzJjy/jShFYdKdDx7SpiFAO2VfX4BTMg/f+j6i?=
 =?us-ascii?Q?wJMIsYOk0pCpTUegBAq0/4mTd2Q0/LYwDL4GNQB0zM5t5jLWxss7XgdKsCoH?=
 =?us-ascii?Q?nxidXRZX0Sl+iJMsg1kVQGBqR8GkpYsqkznI1Xjwaw/F8c+BnAuzBPTJsHha?=
 =?us-ascii?Q?3dq5+M2MCxk3l8H0mPh5lHsjGcJtQPAcWm8sPfHZF8m7mjDqOvBo4h0/HGRr?=
 =?us-ascii?Q?2gf+l+Vw4BSi7144rK3pLxsnpBr0kF5+8x67cITchs5gvYGt8K9bLu4jnOrC?=
 =?us-ascii?Q?dhA8NsiAWPLCnsrENhmHGqhLS8zbnD8SitG077qi4gVeCj32na2acmrItY99?=
 =?us-ascii?Q?1uxINJV00xLde4v3zvG5UqQRvDrx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:44:20.2793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bfa2c1-6d52-4577-0595-08dce38792ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

Currently, there is no proper way to update the initial lower frequency
limit from cpufreq drivers. Only way is to add a new min_freq qos
request from the driver side, but it leads to the issue explained below.

The QoS infrastructure collates the constraints from multiple
subsystems and saves them in a plist. The "current value" is defined to
be the highest value in the plist for min_freq constraint.

The cpufreq core adds a qos_request for min_freq to be 0 and the amd-pstate
driver today adds qos request for min_freq to be lowest_freq, where
lowest_freq corresponds to CPPC.lowest_perf.

Eg: Suppose WLOG considering amd-pstate driver, lowest_freq is 400000 KHz,
lowest_non_linear_freq is 1200000 KHz.

At this point of time, the min_freq QoS plist looks like:

head--> 400000 KHz (registered by amd-pstate) --> 0 KHz (registered by
cpufreq core)

When a user updates /sys/devices/system/cpu/cpuX/cpufreq/scaling_min_freq,
it only results in updating the cpufreq-core's node in the plist, where
say 0 becomes the newly echoed value.

Now, if the user echoes a value 1000000 KHz, to scaling_min_freq, then the
new list would be

head--> 1000000 KHz (registered by cpufreq core) --> 400000 KHz (registered
by amd-pstate)

and the new "current value" of the min_freq QoS constraint will be 1000000
KHz, this is the scenario where it works as expected.

Suppose we change the amd-pstate driver code's min_freq qos constraint
to lowest_non_linear_freq instead of lowest_freq, then the user will
never be able to request a value below that, due to the following:

At boot time, the min_freq QoS plist would be

head--> 1200000 KHz (registered by amd-pstate) --> 0 KHz (registered by 
cpufreq core)

When the user echoes a value of 1000000 KHz, to
/sys/devices/..../scaling_min_freq, then the new list would be

head--> 1200000 KHz (registered by amd-pstate) --> 1000000 KHz (registered 
by cpufreq core)

with the new "current value" of the min_freq QoS remaining 1200000 KHz.
Since the current value has not changed, there won't be any notifications
sent to the subsystems which have added their QoS constraints. In
particular, the amd-pstate driver will not get the notification, and thus,
the user's request to lower the scaling_min_freq will be ineffective.

Hence, it is advisable to have a single source of truth for the min and
max freq QoS constraints between the cpufreq and the cpufreq drivers.

So add a new callback get_init_min_freq() add in struct cpufreq_driver,
which allows amd-pstate (or any other cpufreq driver) to override the
default min_freq value being set in the policy->min_freq_req. Now
scaling_min_freq can be modified by the user to any value (lower or
higher than the init value) later on if desired.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/cpufreq/cpufreq.c | 6 +++++-
 include/linux/cpufreq.h   | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f98c9438760c..2923068cf5f4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1361,6 +1361,7 @@ static int cpufreq_online(unsigned int cpu)
 	bool new_policy;
 	unsigned long flags;
 	unsigned int j;
+	u32 init_min_freq = FREQ_QOS_MIN_DEFAULT_VALUE;
 	int ret;
 
 	pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
@@ -1445,9 +1446,12 @@ static int cpufreq_online(unsigned int cpu)
 			goto out_destroy_policy;
 		}
 
+		if (cpufreq_driver->get_init_min_freq)
+			init_min_freq = cpufreq_driver->get_init_min_freq(policy);
+
 		ret = freq_qos_add_request(&policy->constraints,
 					   policy->min_freq_req, FREQ_QOS_MIN,
-					   FREQ_QOS_MIN_DEFAULT_VALUE);
+					   init_min_freq);
 		if (ret < 0) {
 			/*
 			 * So we don't call freq_qos_remove_request() for an
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e0e19d9c1323..b20488b55f6c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -414,6 +414,12 @@ struct cpufreq_driver {
 	 * policy is properly initialized, but before the governor is started.
 	 */
 	void		(*register_em)(struct cpufreq_policy *policy);
+
+	/*
+	 * Set by drivers that want to initialize the policy->min_freq_req with
+	 * a value different from the default value (0) in cpufreq core.
+	 */
+	int		(*get_init_min_freq)(struct cpufreq_policy *policy);
 };
 
 /* flags */
-- 
2.34.1


