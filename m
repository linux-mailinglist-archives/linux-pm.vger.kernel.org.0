Return-Path: <linux-pm+bounces-9548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2390E553
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 10:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652781C20A7D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899C6F308;
	Wed, 19 Jun 2024 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LWG4Sb5r"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091D5FBB1;
	Wed, 19 Jun 2024 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784947; cv=fail; b=CLSJSRuuyzsHSanPG08g474KLkx7I05fl2IcsL2hFJX4ANW+oYqI66SQV1iPi0LPKoWCXu0ipDU8jIAZ2leWX2p3Yghxf26Cch0N44oDHmiSK5ChxVn9kXuSt5A5RsAlwMcuV6kYXl9y8mMwwuyuvN8vCRG2/D5KuNRlG4YrMuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784947; c=relaxed/simple;
	bh=KOsAxgeGSbn2hPVJlTYvYprpIO7E9smoa2kPBb1//q4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTKLOJrQ/1Z++tanV5NZv2fmlaxs00c9tzEbcUn+a8PFMtquVaXx1dH0wC23k3bsrH2cx+/f3GCY8F/4NhhzM0BbBWGHp1eV+m4BYKuzb/OBGPrHiQxSaoGIys6pyI+iOZV75qvAwbGA09lwimiOYZQyq5WakdbeQtcJvmuiB5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LWG4Sb5r; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPy346cfYzU0OmVeRYWman9dKmr16jXnfkzBNAlJqbQQyTSSWOCDWkOd4ckDJGciBHYAAEe9GLK3248Gp5Yn+1ZdWGHAp1Cp6agMzXwU7DbtMtGbe8A7mLYgdXOJplIi89AeylCx3SNiQyBT3GoXC5bH791Ipvk3POfNXGV4q5WL6+DoBHXBIvFPut8+RhTo9JqmvsUDFbhhNV7QkK0sT3UxB97W2bO5IjVL7OQJS+Nn6KXD1PEKi8eTDtXucT+M8yW9s7XSol2JD1g/UI19J+VFlfuwalTmzgk2e7gaevRfl2IVqOG/6YwvS6vOWwmJzebUWHs8vgBr7Gnes2n3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nKy5vToy5yYpsCc6fuKuRAY75nATL9LF5kq3/nNn1I=;
 b=KGwLbNGwpdv55qU/pE+4D6X1cWtFtWpN2U94nHRIAHh3MZ+QuaQVZqmj5XMxUL6umDGH1lylsP5U0NEphuUjTt3LF/XFMCrqRIx5vDLDpn0VSarGdcoDiJK5LMoEgxLVS5qNIdcRaGto9LLTTXlOq3WIEMpX0qdAfF/DqG34yRjejI/aOkLtmh60Tvxc/4IIuUYJRihfCSshlGRdoeDiyLtzr+wg+1YKXgpH+f73/cV9rQ3jjH9dHDPdqXBPXWes1eWUvdmsQAweM7o8FH11qi+H46AuQ0qe+S0fmA0cUyIUKPScgcg+uGqAeTmmQHBu5DogBIuh1wTtoYZW9XlNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nKy5vToy5yYpsCc6fuKuRAY75nATL9LF5kq3/nNn1I=;
 b=LWG4Sb5rfyXLXGV6pkKMiK03zA1NuujhW3aEEniJNluvFYdY1f6y0bk+wWMohgRvbpKL7S+gSdq4q5EUHv/J4nAeYJaq7SIqGsnO+SW0LgCm7bYs73YrWtLFsZ68vsXLiXFI8zkjF2KB9mWt//X4ENNp0f7QNtRC/+QdqTDZK5c=
Received: from SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::14)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 08:15:43 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::e3) by SA1P222CA0046.outlook.office365.com
 (2603:10b6:806:2d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 08:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 08:15:36 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 03:15:33 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: update to sysfs_emit for safer buffer handling
Date: Wed, 19 Jun 2024 16:15:20 +0800
Message-ID: <20240619081520.259971-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a13c9c-4a04-47d0-3745-08dc9037ffd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fcUj6xADy4xC8WYmQmYzZqfcYa+lHFT8X9ni0cHMzOwM3mpTe5pQK3unzxMe?=
 =?us-ascii?Q?r7syMyBEir6+oLCkUO2ZpI75vxq7AvSPhdZxDzQiW0Tyu0dSM1YVkokEChro?=
 =?us-ascii?Q?6GzVHs7npQ541AOz2H2G6pR06GZtm4rQEaxxL/CIoEBulxPnII/WTIHrUFBB?=
 =?us-ascii?Q?RR/7beUJdlwkHm9zTYXmtP9i4Mohhmj692uS20zS33lnPK8lzW292qqj04GS?=
 =?us-ascii?Q?pGS7YYuIgjC08bXxuG6MIG4vHgp4hIxbfmE1V5nfKu0cz+25CKcqoWu7cfqH?=
 =?us-ascii?Q?AwJqXEWSk7QOTJtSLXWJigH0jbI17JhwlWdFg8rH0vv5hYRioSgSckSRotfz?=
 =?us-ascii?Q?Dn4Rjz5uXfZZtSctSdS3fCAgXqlJa8l4wLxeYNCWDP6vssgkVUqiCuVq3AoY?=
 =?us-ascii?Q?24PJUFuIbWMtanpY4xc4CP0cu1yAihBOhklPatQpms0nB427L7xwiSEYbgiC?=
 =?us-ascii?Q?b62mW1jnyCGLXJtLLYiZs7yUKQvR0a/rVOKJbNSpo7D0eFVu+HTcViIE+ZWv?=
 =?us-ascii?Q?l0QFQ/MYttH4uDAOIXaZ5D9NpmlTPqkeK6Ccote+gdCKL4akt3LgvztD15Mg?=
 =?us-ascii?Q?6pdhQtZGzTaeEUJ21MoDfDQS6MxAk/Y8kMZUQzGdcfW8X131uwv41vYosZUN?=
 =?us-ascii?Q?JfrnwT4zcXcIEF5VzUwUL8e3OpuOtP7sderS+FOrtRCKWMEY8pYSvAmoV7rf?=
 =?us-ascii?Q?yujrAzFL4I2kd0k0wpU5cUMAtC0N9bWN+rk/v3Qj6e+yWQOkTuvMuD+KgV72?=
 =?us-ascii?Q?0kGejUfIND37L9O0C2B/zjdxAjUENNOqeHeOhTigOZHXmbRVhXiH29IvENB5?=
 =?us-ascii?Q?01jsLnt0TSq5UywqegLmPWJ0YK6McUGq+iEsZasBQ6TwHfy7RIN/qhdNOPFX?=
 =?us-ascii?Q?LHwVUYN1SyoR4KxU3KuoZSGMDbwm++nRRCnHStjOovy5g0GDuqy47iacGGwu?=
 =?us-ascii?Q?TQnBJWxYbJN+QgmiK9yRqMsWDgbVud15EFiLwIxU5+WUKFmaOugNIpiRIUFr?=
 =?us-ascii?Q?+wbmKV02jtClsYfwev5l8Mh2e/wqh0Do0VwB3BTAOvj3UxT4UHcngUM4EtcA?=
 =?us-ascii?Q?tIiSOlLZrEmIeHzd8cREWqgA13n/lbBnmWK41JKOdqcysxArw+EywOIxvpV7?=
 =?us-ascii?Q?O60nFMfFn9E/fcecna0P+TLmojY3v1wU8cB2h9sEQQJpuVT/Mmcp5PlpZe84?=
 =?us-ascii?Q?yZ4FaaVFCCIgApM4RjUCT8ot8i8a1a35jJM7Ep5ewG32yB+i6CzlwV2rgJio?=
 =?us-ascii?Q?98+2zMOdiS9LowPgTmNSJYteoYmAD53O6BT9ql/G2/7qBPyosSKOo68zLkXi?=
 =?us-ascii?Q?YWzuBpkxN5oQ+Ztz56d7yXxm6bg6cTqQpq28pbobA0u8cTnNBALEbEx3NEPp?=
 =?us-ascii?Q?g0ELPi+4bcXId/XtFRPmkLK9JgIgVKUSsURmHm2h+FvIS+/DPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:15:36.8530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a13c9c-4a04-47d0-3745-08dc9037ffd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506

Replaced sprintf and scnprintf with sysfs_emit and sysfs_emit_at in the
cpufreq driver. This ensures safer buffer handling and consistency with
sysfs interfaces. Updated show_scaling_available_governors and related
functions for compliance with the new API.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/cpufreq.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e1a4730f4f8c..e76d8e2b4c87 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -608,7 +608,7 @@ EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
 static ssize_t show_boost(struct kobject *kobj,
 			  struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
+	return sysfs_emit(buf, "%d\n", cpufreq_driver->boost_enabled);
 }
 
 static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
@@ -738,7 +738,7 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
 static ssize_t show_##file_name				\
 (struct cpufreq_policy *policy, char *buf)		\
 {							\
-	return sprintf(buf, "%u\n", policy->object);	\
+	return sysfs_emit(buf, "%u\n", policy->object);	\
 }
 
 show_one(cpuinfo_min_freq, cpuinfo.min_freq);
@@ -759,11 +759,11 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 
 	freq = arch_freq_get_on_cpu(policy->cpu);
 	if (freq)
-		ret = sprintf(buf, "%u\n", freq);
+		ret = sysfs_emit(buf, "%u\n", freq);
 	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
-		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
+		ret = sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu));
 	else
-		ret = sprintf(buf, "%u\n", policy->cur);
+		ret = sysfs_emit(buf, "%u\n", policy->cur);
 	return ret;
 }
 
@@ -797,9 +797,9 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 	unsigned int cur_freq = __cpufreq_get(policy);
 
 	if (cur_freq)
-		return sprintf(buf, "%u\n", cur_freq);
+		return sysfs_emit(buf, "%u\n", cur_freq);
 
-	return sprintf(buf, "<unknown>\n");
+	return sysfs_emit(buf, "<unknown>\n");
 }
 
 /*
@@ -808,12 +808,11 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
 {
 	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
-		return sprintf(buf, "powersave\n");
+		return sysfs_emit(buf, "powersave\n");
 	else if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
-		return sprintf(buf, "performance\n");
+		return sysfs_emit(buf, "performance\n");
 	else if (policy->governor)
-		return scnprintf(buf, CPUFREQ_NAME_PLEN, "%s\n",
-				policy->governor->name);
+		return sysfs_emit(buf, "%s\n", policy->governor->name);
 	return -EINVAL;
 }
 
@@ -872,7 +871,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 	struct cpufreq_governor *t;
 
 	if (!has_target()) {
-		i += sprintf(buf, "performance powersave");
+		i += sysfs_emit(buf, "performance powersave");
 		goto out;
 	}
 
@@ -881,11 +880,11 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
 		    - (CPUFREQ_NAME_LEN + 2)))
 			break;
-		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
+		i += sysfs_emit_at(buf, i, "%s ", t->name);
 	}
 	mutex_unlock(&cpufreq_governor_mutex);
 out:
-	i += sprintf(&buf[i], "\n");
+	i += sysfs_emit_at(buf, i, "\n");
 	return i;
 }
 
@@ -895,7 +894,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
 	unsigned int cpu;
 
 	for_each_cpu(cpu, mask) {
-		i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u ", cpu);
+		i += sysfs_emit_at(buf, i, "%u ", cpu);
 		if (i >= (PAGE_SIZE - 5))
 			break;
 	}
@@ -903,7 +902,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
 	/* Remove the extra space at the end */
 	i--;
 
-	i += sprintf(&buf[i], "\n");
+	i += sysfs_emit_at(buf, i, "\n");
 	return i;
 }
 EXPORT_SYMBOL_GPL(cpufreq_show_cpus);
@@ -946,7 +945,7 @@ static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
 static ssize_t show_scaling_setspeed(struct cpufreq_policy *policy, char *buf)
 {
 	if (!policy->governor || !policy->governor->show_setspeed)
-		return sprintf(buf, "<unsupported>\n");
+		return sysfs_emit(buf, "<unsupported>\n");
 
 	return policy->governor->show_setspeed(policy, buf);
 }
@@ -960,8 +959,8 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 	int ret;
 	ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
 	if (!ret)
-		return sprintf(buf, "%u\n", limit);
-	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
+		return sysfs_emit(buf, "%u\n", limit);
+	return sysfs_emit(buf, "%u\n", policy->cpuinfo.max_freq);
 }
 
 cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
-- 
2.34.1


