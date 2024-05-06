Return-Path: <linux-pm+bounces-7527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A8F8BCBDD
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543BC281097
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9D143C43;
	Mon,  6 May 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i1lcAJaW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD35143895;
	Mon,  6 May 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990841; cv=fail; b=cdE+PqN/BmtCjcReziTQmlvYHQdgYD2i/ySbNYLB6pti6Z77jbDBRldiz+bGf6pfpdlysc10xo42c19T94pm5pRiAlvNkFNoQdWEfUKR/sQ6Ok9SY5JDmw+Jp/izJU6ya4ciXun5kNXZd3wtZmI4R+fTUSreh4dWEwffazK+oVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990841; c=relaxed/simple;
	bh=isFPpUyJnBR/hRlNSj+NGC9cdEnzRVEQ+T9uTQv1ywI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmuLMVQx8OZSE/Qki4yGfO9w629Ua8mxNbFxrqWVg0amXT64XdVYfQtmXvnIKK6ZfYJI3mkrbB/OB3SHBIKNtSQ/y+zMvP6fg76LyD/Mi7CzpeHluy6g/cqjnIbSpNQlGcowRyJRsycnweg3o7vwgLqDMewLIeR6q7EHI+nQCs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i1lcAJaW; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayEByxG5Et33rALjf4UJYfSeNWDNoJlKzbgGLg/3nFHAfRgzHa4h8iUg4jsW7ao03nJmqS731gxi87icmRi0Ic5uAo8C5l8ec5Xi1pipM/1/cvSwrUfLXHXouzsi3BcU7AFn6RYMve3Gpo3e9W5+wrSe/YW7EJRF6LkmeKngVFbbty7Yy4AXadPaJgzRLFGP6VNEpLV4/26CA3rIphCD9rtVvOywMuQ6LEu2c8gTdMcITibAH0Ryhljp6ygjy37POOwURvAFLVnBUQeQIDKUz9ERo3CuMnIJnscJLUGp07KO19BiUya2GUqNqc6bm228+YqOQIZTCms30L+9Pitw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RApvOUKP2rbFICnNhXz7wnpAt1U9csFWck8V6TnnDo=;
 b=ksDeRiwczrzMImebTyYfYFphDDZQ0rDPHjaLI1KzhT6JCvsxrpRxLwEsg1vRTBbB7McQFVFYYHJ0Vtf+pq25yKOFSuKtgKzWUnros0ATyhe1OlYw476d+WjppwsUlht/cepBrmF/5nbLD+JN5b1GjvEmDPcn9e1Cv7iVNQ/CDlDgyw83HwX0BcoVms2X9qkVDwoz/sF1icOwvLnCaBb8VLr7lMIArKfnALFqMHb914qhIF17sd5G+o8yqXK8BiAi/KwNYqHfqzjyX8WAvR2AuPqNQDcrNj/GF0OE/RfzBLZg+diFdvcRV3NDrL+j7+/sVmqxfYut9qH9X0H8obm5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RApvOUKP2rbFICnNhXz7wnpAt1U9csFWck8V6TnnDo=;
 b=i1lcAJaWc5AEkhILnv6F2cy5wVzG11DWF+g9+tD5f/yMZ7WteZGCQuoHYPYSO3e5CfAL1/MEfh/B0d1YDfrc/QtClPa3hfPIurEwzxCr1MdRyg2KoKcWdoSV5iypyH77D17vXHqFSPZ4mi6IxA6dTV/ZeurJJDOKehdVAAuMic8=
Received: from BN0PR04CA0205.namprd04.prod.outlook.com (2603:10b6:408:e9::30)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:20:36 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::b7) by BN0PR04CA0205.outlook.office365.com
 (2603:10b6:408:e9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39 via Frontend
 Transport; Mon, 6 May 2024 10:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:35 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:32 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 6/7] cpufreq: amd-pstate: introduce per CPU frequency boost control
Date: Mon, 6 May 2024 18:19:58 +0800
Message-ID: <2d200d0fb4135465e81b9213de940e31a7b88dce.1714989803.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714989803.git.perry.yuan@amd.com>
References: <cover.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d5d524-4654-413f-a5d1-08dc6db62b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7QMiZfuMsYyGn/xaXLMsB/6Vsa/nIeGUnNPI7O3f4aAsWVFetZOqmOSK2Ts7?=
 =?us-ascii?Q?osEnmUb/cCNct/NPoVeKaoC/6sCql6BP5BzazQg36x02evcQ3khtmlnRt6nH?=
 =?us-ascii?Q?K889eEonVWWnUg5E5rHHYClt8TuUnAF/bspq6rX3WHpK/I91efKcUQEyVXVE?=
 =?us-ascii?Q?33ROYpgXL6wCz5uLMMUt4td0UtDqbMJkc9XUhT9uN8KjXkN/xfDTD9hUmbbx?=
 =?us-ascii?Q?6eUgBWFlz5yCVC/LbOYiocl6avmUgTMcLPdPGQeY/MpSD2nsh4xkaa9fBVAj?=
 =?us-ascii?Q?FobxnKtqvyJbfNLAt6fUiJJ+sKw9Vsvkzig6WcgZY/NkrmV7vQ2ZUcVv554P?=
 =?us-ascii?Q?vTHbDgzE2NY2/GwSyKE53UO3RCCLAby6sCqRGKg2b8b+Q/iZ14PrzUJMe9Sp?=
 =?us-ascii?Q?3QkkpZwN7D+XWtGFDjcsvS4xSD22oBDJ/uZXepjDlyqtJGMkNPUWimXfZmap?=
 =?us-ascii?Q?jms7bjL5ojSlS6qPjhuz9SY2kC0ifqz0R216g82EaA+TDjA50lJQvBagntP0?=
 =?us-ascii?Q?sw2R2ZZb6et9SPsrLwFY9iuq4P4/MdOze8shKim6F5SEN2H5dxSEXtkKWHTY?=
 =?us-ascii?Q?Nt4WQ4yj6RIVh5ZmIUlrNnRCryF94+51FItyTJQQ8g4+IKmREJKYQoIJp4os?=
 =?us-ascii?Q?qqP4BmbCgnH18zHiXRjXWqdzeKiEmZTapglgPd87sd9Y4uxY/eQeua/6gAZh?=
 =?us-ascii?Q?wUz7OEIOBsmLjIP4XWRuaY6ZycSyhgKvjRjJlA/ngdZlrBtw7+LZBxsYAPC3?=
 =?us-ascii?Q?V3gyKUNlX15Yqa9+As30FtG2PXGKjg4w809GG0otOiEtkycnZ79tCdi9tgLQ?=
 =?us-ascii?Q?sh+8KoKuZ9CoKcs2wQ7ULYNkug/3nbseXtITsXw9DhdLqYQm003aSwnIM1ee?=
 =?us-ascii?Q?2J1tuEVs/vniNmhENiKb2pnDVenVJawMp9hAAAsDHF/JENX+rNjhn4ImjDR3?=
 =?us-ascii?Q?Yiupn1v55HSbF9vNAj3ExSFTxGarR54z2acPyO7OFcQdQYhoV1X31vRqbMah?=
 =?us-ascii?Q?HRG/OAGCZW9J5eTJCc/1S4HHMmQ4Imn8s6MxHbNwH6QNX5EJICk0/tIhhlCO?=
 =?us-ascii?Q?QB/tBkrLRPZS2PX6GklYdZ6a2B4zzGDHnThTDiqniRzFSh9YqDDY1kok8Pb+?=
 =?us-ascii?Q?3JKeUCbJpQajjPeZmGnEitrPfgDKmdnUla8UJ3EHP1T52qKimtFb6aHvONEl?=
 =?us-ascii?Q?Ko4eUfyFssKpFXqtPd/lJ2TofUS6nann1wjONRAK/Gc55Tz5RM3radHRpOWC?=
 =?us-ascii?Q?8NAul0BanIUdMiLkAsZh/W70Fy1ZkjUDrRxrCJENwsoNmSCP14UtIvEEO5nZ?=
 =?us-ascii?Q?nKySSzdHyuVJiXcydT20Q9mszvqQa+iwTDaVfeD/UJ1YksOAg2bUwAK3rQBk?=
 =?us-ascii?Q?7vyqv6w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:35.7505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d5d524-4654-413f-a5d1-08dc6db62b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

Add a new sysfs attribute file to support per CPU frequency boost
control, allowing individual CPUs to enable or disable CPB separately.

The new sysfs attribute file is located at below path,
`/sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_boost_cpb`,
where `X` represents the CPU number.

To disable CPB for a specific CPU, you can use the following command:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpuX/cpufreq/amd_pstate_boost_cpb"

After disabling CPB, the CPU frequency will no longer boost beyond
the base frequency for that particular CPU.

for example:
----------------------------------------------------------------------
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
  1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000

----------------------------------------------------------------------
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/amd_pstate_boost_cpb"

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 3501.0000 400.0000 4154.3140
  1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000

Please be aware that modifying the global variable
`amd_pstate_global_params.cpb_boost` will overwrite the individual CPU settings.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 11bce2c1db32..44531711a5fa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1371,6 +1371,30 @@ static int amd_pstate_cpu_boost(int cpu, bool state)
 	return ret < 0 ? ret : 0;
 }
 
+static ssize_t show_amd_pstate_boost_cpb(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	bool boost_val;
+
+	boost_val = READ_ONCE(cpudata->boost_state);
+
+	return sysfs_emit(buf, "%u\n", boost_val);
+}
+
+static ssize_t store_amd_pstate_boost_cpb(
+		struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	bool boost_val;
+	int ret;
+
+	if (sscanf(buf, "%d", &boost_val) != 1)
+		return -EINVAL;
+
+	ret = amd_pstate_cpu_boost(policy->cpu, boost_val);
+
+	return ret < 0 ? ret : count;
+}
+
 static ssize_t cpb_boost_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -1416,6 +1440,7 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+cpufreq_freq_attr_rw(amd_pstate_boost_cpb);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
 static DEVICE_ATTR_RW(cpb_boost);
@@ -1426,6 +1451,7 @@ static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_highest_perf,
 	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
+	&amd_pstate_boost_cpb,
 	NULL,
 };
 
@@ -1437,6 +1463,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
+	&amd_pstate_boost_cpb,
 	NULL,
 };
 
-- 
2.34.1


