Return-Path: <linux-pm+bounces-7633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BE8BF6F6
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2451F213C8
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973E45024;
	Wed,  8 May 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2G574uGl"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893272BD0A;
	Wed,  8 May 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152915; cv=fail; b=YLlx2TVejFZFMW7vLdUWCDoKuCsZYWBdNQkdUBqX0g+6Lm7gYyfd+4MmWQFNjBmerc8Gv3tVzejRRsfnM1IRNE3sy6wyDiuNQz3DGhbQ/qL0LxYXbitsXTHwqdJ1nlnpFI+UDHM4OQpfxaaTLWjC4xTK2nnYV5qh5GE2bTE/tPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152915; c=relaxed/simple;
	bh=/sengyBBcEetjyVwAF227oEGabix+LBc90ltd+7c/M4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaiHDKsI0jHQYr3v4FskpFyGmHAclKUErJ9hlPHoKRjSljHHk8l2PkCNJLEgUjedp7q4dF+KLewZoi5q7t40RXcj0qOOckwMnjG84AGfykDridUGW6/THdZKDquaqo/wFxx2UCEr2/Jn7sxBOXizY6SkgxGBxFzP0PBLsRsNu8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2G574uGl; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkWLbMaLQ256qc0N9XPqM+xwXrCjtzs0lUCAD9kaNFLX10s1gQ03cvmgOYsTJqiQ7W48VzmIi1J5+isrLGtypW7DKswY/Ydt79gyyj7MANsap6akQuEDBPGmYAkuQUv0Uomv+2nyN/76XwUwa3cTxN5zIvsYIBf0JNwrWR4eoI8Q6bhmoLBxFN0Wks8TLl8emLTd3Yu7M7vNg9vDqAkgvwCyM3LMQg/mTWfgyXlXk8Q27KPxu0yV45CwlvfihhD2KQfsWd7+cpF3nkyNfGgNe7n98V+UKxV4MBrER1I1rRk/d+oR6ivjHh4R3jJcI1Bs26V8uWkwXxSSZQdAblX2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApJQMiodT5Ffcn0Ypzad1MSiZQFEnT5Q+zHkF5SGRB0=;
 b=HHhHpr6DrtXAKEqfUP2lpc4uL9V+zVm9ugOqDC3YrSgmsLz6J4k6BysqxGTevK0UXdspQts7M+4tK52nFH4FUfML9X/Fs6ol31K0GE58P10lkMfVg6rHiw+72DJz0zIKHxY5KY8YpGG3cj8cJYjEm2+qlNU7GWskdk+LrP2SmeZZJJeUFdne8ryythXCx+uysM5hKO3jp3mWelMWDRfvHbOhOQnDVueFmzx5ucTbn2fS38rK3yF8smBWi2j4Lsrnb4DOq/5jBAiTaampb8hCRddDM8ARlGR9laa5ORHpTOcn5lwjTD1L1v1vzSSGzI3WnQ6Cw+rSiCVc12iNPqGmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApJQMiodT5Ffcn0Ypzad1MSiZQFEnT5Q+zHkF5SGRB0=;
 b=2G574uGl6lUxg1p/n3PDFBT4KKKphtFvYlIcC2MIkv8FcDZJOrfj9ywT8WtFR9PntRPIKDhO+8BeSVStWJEZ7+hc9eBefg6C1PtpnKV3voHhQ751fEKoR6JlyZytv2WSa7sLNDEH1VKFuwFs5BZ+XY2X6ML5FQLWxbVjvR6HL+4=
Received: from BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 07:21:49 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::2e) by BL1P222CA0018.outlook.office365.com
 (2603:10b6:208:2c7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 07:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 07:21:49 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:21:46 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 6/7] cpufreq: amd-pstate: introduce per CPU frequency boost control
Date: Wed, 8 May 2024 15:21:11 +0800
Message-ID: <49204c6d4a334c0bfbc589dda79b5cd7c4c28b7c.1715152592.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: cac16160-961f-41e3-8b0f-08dc6f2f86e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mHjckL2mYsUv8qzJdKUDxvrtvl2FdPdf2ZmgbIzHyeTFAQCWWn2TlMx85gcQ?=
 =?us-ascii?Q?Hij7ipF4vZVmIWxrkNC4Mlk7JOdqF/ABfmXhk0Aqbz9D+mL95e8PCslzt/kw?=
 =?us-ascii?Q?sidvcg2rpo/vapsCEA/TfFZoI+CYahuxCqRxCQWJVS88qNi0zXiCjxA66mjO?=
 =?us-ascii?Q?/8OvGR99i17yomUuLNmcAQeRnIjpokbOPApSCbzvaqznLjnJAvIMw2OilLyD?=
 =?us-ascii?Q?ekd1houuMBrJp2IIz0u9VFIzcnkLPuZkew0RWl/9npcH+qDeOJZCzyVkwsSk?=
 =?us-ascii?Q?8ITF8iNbdVmxqeUMh2u7++iV/9ffWzryia2Y9r23B/BFnkACutUF/PDlD8Ws?=
 =?us-ascii?Q?hGVzHOr6q2ft0GC5H0JAXCOxZE0A02MvM+nG5nqJhT+z6PngDg5ox1bxbo0x?=
 =?us-ascii?Q?SNlWp9FHUCfG8Eq+m6x3yp6NsO7bULvaCfE8HtpDTVphz6Msds4A1nS9YMFs?=
 =?us-ascii?Q?2/yieD/Lx1DHbE63F3BLz5rPkATUldq18l10SNpC3ZnUUhDsbI+avb/g9yTH?=
 =?us-ascii?Q?hbMFFYYoFvHOl9yLut4AVPVY0Qke2ll9a0cQMSpbh7mKTghvbzec8hfW4N9A?=
 =?us-ascii?Q?nr5wgLia+tg0RHLxgVfWs40GrEJdwCM7s2M5IZv5Cls4vwFehBT4dai2Flkv?=
 =?us-ascii?Q?rt4exhSxAeu4VRA7GwKpmx+J0ZEKqBRNjhyyx7h1MmXcxiMxEQyhbXjPuExX?=
 =?us-ascii?Q?drIZMZMcGLaY3wzPdTzkBVsrza3SJXrrrqGBBdq+B7aDTb5stQYTV1zMawOQ?=
 =?us-ascii?Q?Y9gIhRFqAKd9ubsxucZJmrquwrefW6bB8QMRroORKM+dOKwz0mT+EseXqtjg?=
 =?us-ascii?Q?toMZHlx6MF2TPDHARLTgfnPC1s5suGzXXC2etHDIB/sdKIX7dL6m0+lIsu3p?=
 =?us-ascii?Q?b8TCcP7QYRNYsTZASyTX27wCjCNax135/RCyfzKH+ejqH1aLot2O9XYhenlD?=
 =?us-ascii?Q?asMoiN41EuiTqpNBrf+xrLNZjKzP7ORkeBSQQZz9ElXs1lUdkXVMcUAZCzLJ?=
 =?us-ascii?Q?qzslEh8ue1gPJnQAo5hWn1YIqb5lgA4fiyqjk66MIGiuB6gh6xqt+7H2ev+V?=
 =?us-ascii?Q?a+8KPO8EVa7fuLG+5Ph9VAC9S4DdbqiabhoQ+NOsIfRO4MaJtlvwrJRQYuAe?=
 =?us-ascii?Q?Igg3Aw4CN76easxFNdZQ2npkBWPEtP/no5VYXT+Iyrbkm0YsczE1Pm9n5ryO?=
 =?us-ascii?Q?ydGdqMKIYaBpyyK6y9LhEXyaqNyIVySmxkWoUDUs5J0NNRw7K6LjNHs42Wh2?=
 =?us-ascii?Q?kxitv6rBrw6knd9erjELFh/juUsxI817tEWlpWwXSkIMjQ0TZfzuMPIG+v+M?=
 =?us-ascii?Q?Scocg8eqooQE8DvCwVDZAVtWM9yiSxCouOnX6bc38z+iqy/kiIjWHCdxc6c/?=
 =?us-ascii?Q?HKRIwIE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 07:21:49.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac16160-961f-41e3-8b0f-08dc6f2f86e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

Add a new sysfs attribute file to support per CPU frequency boost
control, allowing individual CPUs to enable or disable CPB separately.

The new sysfs attribute file is located at below path,
`/sys/devices/system/cpu/cpuX/cpufreq/boost`,
where `X` represents the CPU number.

To disable CPB for a specific CPU, you can use the following command:
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpuX/cpufreq/boost"

After disabling CPB, the CPU frequency will no longer boost beyond
the base frequency for that particular CPU.

for example:
----------------------------------------------------------------------
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
  1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000

----------------------------------------------------------------------
$ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/boost"

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
index 11bce2c1db32..cb0055e7c842 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1371,6 +1371,30 @@ static int amd_pstate_cpu_boost(int cpu, bool state)
 	return ret < 0 ? ret : 0;
 }
 
+static ssize_t show_boost(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	bool boost_val;
+
+	boost_val = READ_ONCE(cpudata->boost_state);
+
+	return sysfs_emit(buf, "%u\n", boost_val);
+}
+
+static ssize_t store_boost(
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
+cpufreq_freq_attr_rw(boost);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
 static DEVICE_ATTR_RW(cpb_boost);
@@ -1426,6 +1451,7 @@ static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_highest_perf,
 	&amd_pstate_prefcore_ranking,
 	&amd_pstate_hw_prefcore,
+	&boost,
 	NULL,
 };
 
@@ -1437,6 +1463,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	&amd_pstate_hw_prefcore,
 	&energy_performance_preference,
 	&energy_performance_available_preferences,
+	&boost,
 	NULL,
 };
 
-- 
2.34.1


