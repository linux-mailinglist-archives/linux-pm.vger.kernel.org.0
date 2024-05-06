Return-Path: <linux-pm+bounces-7524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125608BCBD8
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F3C1C212D5
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF1142E75;
	Mon,  6 May 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y2nLoeQt"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C70142629;
	Mon,  6 May 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990834; cv=fail; b=rNOK4MVJWUnx1afm+7HV/sH1yklyYShI08xWktv3XBAE2CUUUmLIRIfAu8cscAFGs+ybE8eVDwSj7TZ4SprcoB1Wmv+d3Z/AxSUTNpoxeKsDJvQmeMZhO6vTGNZppYkI4Fhpcn+Bs4PzdHlEqJdssBK9RUruke5Y5okYpcahZnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990834; c=relaxed/simple;
	bh=SPtaTKhKS4kBximrAAIVyLl++Y6fmD1XuYHuKP4/3TM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbT8vTYG4peDVosAyERAS2QG6W32TcdTFsCfb2TKEqHfMPhVvzUmGXheaAKVDCSL52okLozPjkl5kRxcZzbGUmq79nyt/O1fEW4BAB8F1RJ4WUbWl8E75cLRzFNmtxNs9aI+4SZxgCv8aYsUh9fATdMhNu4pMGYE3L6K5fP1cPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y2nLoeQt; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKI1wZMBltJJoRm3Yxbe7TP83LmwuwYGeS3yr3xfm0DbGYC2+G/Nj7WEauBy0bAF2tO7OTr/pPWIqKOwal059KQGcf8npjfVISlrZNtXRrV+IdxCsiHV+/QUJDlPyhJqdPBNt1ZX/wEPJDH8DiDtmodv7f8n+9bcvkXmk/nUITYl7JSonhceWxk4fI3DmcBlroE3sltz7rMLTl9xChgct8aPmn7klY84EbKWgE9NoesTJA4fObTd7ucT0Qtial+Wx2ssVsFUjOKmylmzwj2xW9fDudA3ycgZlc31w6srLrnmHupYlYSI6DkkjB06OF2xYVB3RXpdOx3fL3vVodN8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwGsNws72j0bUsX8RT3yzn8iKBZDTYed2C6LZvdY94k=;
 b=dJs7PdmFUdyb1UYjsI7WHackDP/Hlc1nkZ5ZJ6uNKpwztTDZJseE6blpvUK8DwEj4PhLVjcLqvJkfuEb3KhBY/Zha8a41z21MDw6QKq2vaeZff7Bl+nLEYXK+Zhw54kzHr0yoXxnCWi2g/oLD/ai+68kY+okL0ZYa07l69zA+CT2CDo2Jf3fcj12qLcX1u0QrTPhoyZzh1AdhU9is9AejUd/gL5eD712Rai0E0gKX91OTWk7IIP2WEgmGCprZzBGAQiJ/CUDGbivj1OabeUAm4Upp1Kx0v2QpgSZecIL4htxrlk+v9elW7Xiioa7sDcolO7izyEFAaeCNY+92gS1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwGsNws72j0bUsX8RT3yzn8iKBZDTYed2C6LZvdY94k=;
 b=y2nLoeQtFTD1SQ5v4eniLN562tklxlwXrwIDQKwuZ/PyzgT0yDCkxYjhH5mHj0CEhAUwRB2jk66qLzMkU5x8A9dSKGh1rltPEuq1Qq6dN3CKZ4/TH5NT2fp3DhOy1Pp21m9vhHTGUncMAFDvRjOYct8LsuUEHelBiXXGnT1Pcdo=
Received: from BL1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:208:256::20)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 10:20:28 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::c8) by BL1PR13CA0015.outlook.office365.com
 (2603:10b6:208:256::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 10:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 10:20:27 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 05:20:21 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <gautham.shenoy@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Perry.Yuan@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
Date: Mon, 6 May 2024 18:19:55 +0800
Message-ID: <d69d52290ec7ab4073b266348b3d7c0adf13ee30.1714989803.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 707a6e0e-ba27-4f8a-1481-08dc6db6269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FAdoHmAHZNvVC8DdRxb0REP7dYHyOQLU9eUrIaRUIvyjLCwyGYyC5B2cRJfg?=
 =?us-ascii?Q?/GkUF3jss4PGF94fYRVdjFFNfigVsWFVcMJppMhPIFgG1UVN0MDyERB/XXKi?=
 =?us-ascii?Q?q1ZziEY3tL9j3PSC+EvkzvccU/2r2ocjTabn/zevU7u4AaScoxTjC0jkBOSM?=
 =?us-ascii?Q?B4XW1ou9X+z7IBj14lvF0/1QSGVy2MPtdACB+Hw5xcy80rfrnOFVcqefY/Uk?=
 =?us-ascii?Q?OXD+cwaBrFwsN6T2EChY79S2IcUh9lYuDv8OqXYNzLfH2kObJqm0jo0FES08?=
 =?us-ascii?Q?UgRohBY/JS7NauDy4bhr4XhT1mcaKQNclGALi7qFrvBGBSJEWIpulGSHbHIr?=
 =?us-ascii?Q?tWdkowFv4/8hxDNfNpo4O5UoBUueXVhXOQ85n94lWWdaTczUhWJQTD0to8B6?=
 =?us-ascii?Q?9Hscz/2bLTxxSuK0ljyDLMz2l+mP0+FSoLiDq/8TPCgGrfyMJ6mlVQ+z6VJS?=
 =?us-ascii?Q?3XEnjpyF27lyEG/Pz8OuaRrQ7iLGH9etsdPGKIHHiacx75ChM286jUwxMaDR?=
 =?us-ascii?Q?RNvZKIfesJR/9vMwvvFtnNCjDXVBi6E5w7PcPxLc+pN2YKonojM8jvOTIoSC?=
 =?us-ascii?Q?ZSp5Fn7OWrHICKRUqx+2i6KR6bl7XqgOWwwONcHmzw2WN1Il7s5nbkZlUVTf?=
 =?us-ascii?Q?d7XvXCs7/fdZF7KaHQh5U6TfI94R8z3CFMF+Wq9putcj9Ga+ond8iYa+vSbk?=
 =?us-ascii?Q?2l9ULMVY6YEKOHy+GuExBG4W1sFFqYU7ZSWO0l9sxQUktL0G/Zv2AftILxvq?=
 =?us-ascii?Q?AocjB5GaIBCy3PSfNbvTjq4sSi1uWuCF33AecAQpncRBAoUc07330Ilo35xL?=
 =?us-ascii?Q?HZBhG7NS9gBOXwv0OxpBSlOjFBAixYVBNhiQNe4IqOjMFpfBqASAJeKl01mh?=
 =?us-ascii?Q?SsESzR23PLLwJm8fYZKhN7XfXjsETSUThIZ04h4OopLjeqK/0RkXdKiNGRCh?=
 =?us-ascii?Q?asvxkhTMzqHvspkYS8dlkYSlHAUKkonSzJqB5vRFoZ0VXt4YmxnM+C9r2GsU?=
 =?us-ascii?Q?y5iEKWi0JTkMGZCxHuQw4d0v5sqb0m/T8pbLlUSuG8MK6BiFSwEodi1SFFmf?=
 =?us-ascii?Q?gnmGC4vVNIPeJQthp1ABCvxu+mfzrW12JkLm0XLnkdjDJYXIP6x/D9rxesEK?=
 =?us-ascii?Q?9+9PWoXHXLq/suBqsrbnErOHXWoGFbLCXX7X4NXIfq1WN3EVinlHsnzUNZsx?=
 =?us-ascii?Q?VtQOSov8AdNagYY2Esiwdm4wRxlmcbnwgf71nAvJDydeupzPH5ExLGIBZQ0q?=
 =?us-ascii?Q?kugZgMPS/pbwDQx0oEobZYGdkTXNld2kSRZJ8RgliWqXxYhmXe/W0PUhLT6O?=
 =?us-ascii?Q?5Ex9wl9ZNz4C9iSzMp7YoYu6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:20:27.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 707a6e0e-ba27-4f8a-1481-08dc6db6269d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646

From: Perry Yuan <Perry.Yuan@amd.com>

With this new sysfs entry `cpb_boost`created, user can change CPU boost
state dynamically under `active`, `guided` and `passive` modes.
And the highest perf and frequency will also be updated as the boost
state changing.

0): check current boost state
cat /sys/devices/system/cpu/amd_pstate/cpb_boost

1): disable CPU boost
sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

2): enable CPU boost
sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c |   2 +-
 drivers/cpufreq/amd-pstate.c    | 114 +++++++++++++++++++++++++++++++-
 include/linux/amd-pstate.h      |   1 +
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..b3601b0e6dd3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (amd_pstate_global_params.cpb_boost) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f7dab0f7b452..f81fd61dd2a9 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -686,8 +686,10 @@ static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
 	}
 
 	amd_pstate_global_params.cpb_supported = !(boost_val & MSR_K7_HWCR_CPB_DIS);
-	if (amd_pstate_global_params.cpb_supported)
+	if (amd_pstate_global_params.cpb_supported) {
 		current_pstate_driver->boost_enabled = true;
+		cpudata->boost_state = true;
+	}
 
 	amd_pstate_global_params.cpb_boost = amd_pstate_global_params.cpb_supported;
 
@@ -1293,6 +1295,114 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls;
+	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
+	int ret;
+
+	if (!policy) {
+		pr_err("policy is null\n");
+		return -ENODATA;
+	}
+
+	highest_perf = READ_ONCE(cpudata->highest_perf);
+	nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
+	max_freq = READ_ONCE(cpudata->max_freq);
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		u64 value = READ_ONCE(cpudata->cppc_req_cached);
+
+		value &= ~GENMASK_ULL(7, 0);
+		value |= on ? highest_perf : nominal_perf;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	} else {
+		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
+		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
+		if (ret) {
+			cpufreq_cpu_release(policy);
+			pr_debug("failed to set energy perf value (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	if (on)
+		policy->cpuinfo.max_freq = max_freq;
+	else
+		policy->cpuinfo.max_freq = nominal_freq * 1000;
+
+	policy->max = policy->cpuinfo.max_freq;
+
+	if (cppc_state == AMD_PSTATE_PASSIVE) {
+		ret = freq_qos_update_request(&cpudata->req[1],
+				      policy->cpuinfo.max_freq);
+	}
+
+	return ret;
+}
+
+static int amd_pstate_cpu_boost(int cpu, bool state)
+{
+	int ret;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (!policy) {
+		pr_err("policy is NULL\n");
+		ret = -ENODATA;
+		goto err_exit;
+	}
+
+	ret = amd_pstate_cpu_boost_update(policy, state);
+	refresh_frequency_limits(policy);
+	cpudata->boost_state = !!state;
+
+err_exit:
+	cpufreq_cpu_put(policy);
+	return ret < 0 ? ret : 0;
+}
+
+static ssize_t cpb_boost_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
+}
+
+static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
+			    const char *buf, size_t count)
+{
+	bool new_state;
+	ssize_t ret;
+	int cpu;
+
+	if (!amd_pstate_global_params.cpb_supported) {
+		pr_err("Boost mode is not supported by this processor or SBIOS\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtobool(buf, &new_state);
+	if (ret)
+		return ret;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	for_each_present_cpu(cpu) {
+		ret = amd_pstate_cpu_boost(cpu, new_state);
+		if (ret < 0) {
+			pr_warn("failed to update cpu boost for CPU%d (%d)\n", cpu, ret);
+			goto err_exit;
+		}
+	}
+	amd_pstate_global_params.cpb_boost = !!new_state;
+
+err_exit:
+	mutex_unlock(&amd_pstate_driver_lock);
+	return ret < 0 ? ret : count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1303,6 +1413,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(cpb_boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1327,6 +1438,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_cpb_boost.attr,
 	NULL
 };
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 8ba5dd4d3405..56f616a5cd0f 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -106,6 +106,7 @@ struct amd_cpudata {
 	u32	policy;
 	u64	cppc_cap1_cached;
 	bool	suspended;
+	bool	boost_state;
 };
 
 /*
-- 
2.34.1


