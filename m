Return-Path: <linux-pm+bounces-9056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69874906501
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8FE1C21CE6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ADE13C904;
	Thu, 13 Jun 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yK3tmYxP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2358C13AA3B;
	Thu, 13 Jun 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263568; cv=fail; b=eUHqmPFx+9iPDWuzhhW9vPL13y99oPCavJJ1VG3+tH4ylprBcNaaCteIRZI/GHqTDPcgAP+9/EjUv6QEAy0QxYXKGsYBUglEnw02YpAgYcQN+H0xsFa8M1mC73EA3fGY0s+vjMDEYhp0v+Wj8Ve8YUS4R7ldhCfSVlZH4GB2I98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263568; c=relaxed/simple;
	bh=mE2nn+CwCqTiTW9TXl7X26Svxj6+Zic3iSTrKZqLNog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJ/1Xhv3JKbcGqj7suKQ/7Xs4I8TB5FOCJSLOZCg/jzPfUNLYMV0pcbx+k0j7qRT2hjs6Y6ZEQgpD5vOgSn0f0iULOokFENzYNnFmj8YvtQvLPPguvw8yayo7iL5bfOZJol0lTNekq2GO7YJS3cKAPWM2efouKvR6/Agxuy7lBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yK3tmYxP; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMJfqBHi2NK/OdNNDlFy/US0JToOjcS+bHit4G1dPwWIZutCpHbzOkbne9dbWCQVIlfypFYjKhLAgc8MfDLgJU153Em1n8DTo5CrrNeorGjGg1r44WBHQDNcs8gY4VBuQxLIIo3Y4n2/47oRnpxZWMnB4oQ3GgeaS7cWrheVPrCjL6VYY1WQ5lDq+TmxQYdp0sMfX3EbwkfMQQrKFrb8KXvKTSsxApAfqb97TgEEbRFKnzy8XYMY+jl11k8H4THaSpBL3dcOLG8sNkhwxqSuW6mnofiNq9YzeNLHN8+2r2ndBMlxPTyQDZD4C3qjG90NqIQP4lvhxnL9WJAir+fgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db1QgOx0bNleruxZYc1Y6Jv84+lko8S/bOMVSMvZW9Q=;
 b=oNAxKJ1QbR8Y+zxj7cQUT/2zx9bIsLcubzbvqSMx/N/+iUTv5MC/ZzaZJWUAxQqRNjkrlS3rdDJ1C2/zTPz7huyQiFaYfHPd3xKuZeNDcSvjqYMHbWwM856NytAZP3hLiK/Upn3bDzrnfC/ICl+LhE+pkNSZ1Z90g6hHn+jd+dXwddlXezkdLe09XE6I1vFC0v64oVLvJfyEEArafbzvnfMkqikGCHIKauSm/hJVnvfN3wEI+u/YIDUiyBeojXR5P3C/WRPDtAudDvsePIj6YT0sr2eJuXLtExa0kdl7wAlnQp/Ml1y8+8BZmXBgfvbdTNG4Ti4f6Mb5y7aFzOZlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db1QgOx0bNleruxZYc1Y6Jv84+lko8S/bOMVSMvZW9Q=;
 b=yK3tmYxPRgVF25KprfgINFYF8Ef7Ur7LJQcx0uIRR0UfCDha0YgDxFpIbMIm0KlLZvAOjcnqXCy+KHxKee+C6jjWWTtzPZJM2zOdRl+9He2CdgPoxISOVcNIKNWNc6YTuaWY6LZ+Ay8+n+sB5Xo3GzlHyJsWImhjYg6yC7EwAk0=
Received: from MN2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:208:fc::19)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 07:26:03 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::8b) by MN2PR02CA0006.outlook.office365.com
 (2603:10b6:208:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 07:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:26:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:25:59 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 7/9] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Thu, 13 Jun 2024 15:25:19 +0800
Message-ID: <6adc6408cafd36af9cd9eca063a3a061fde48fa8.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0fe608-9bcc-4be5-dc5e-08dc8b7a14f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDAmk5nnwt6KaaKjZWLCnh7IEU7ZqBxRQvGK9Q7S18KVXx+MmGXdpq+0NYeP?=
 =?us-ascii?Q?pxqzXLrt9LpYOZqhxIMCRrkZdoX8yugFphIQqJ3TswCvuVTJf3BBmWaMGthi?=
 =?us-ascii?Q?BM0+BwxTwTSwxg+7LnC5zu6PJak1f3vSYr+HbsfLrfNFhNEu082JjBdKCvAi?=
 =?us-ascii?Q?c0EMhkM/gixdcBw5njX2rbI1TjJWS8ybbj6ArsJLxyYlxojWazjbQKfNVpep?=
 =?us-ascii?Q?y+VpBxQRJKug0LGt0fFgvPnVocKwZ+/6647D9kVKLAiPAPp0W8VDoUotp/fX?=
 =?us-ascii?Q?sCfSaFXhwsp6pUIkmU4IfiFfZb1nSPF3jH4pKRpfPSuoQhRy0ZCms4dB/EPJ?=
 =?us-ascii?Q?6jqED4++dhPcpJm8i0aUa/p+S3i96YKBhx6hbCwIRhMnjh5qTOtMqstPcseP?=
 =?us-ascii?Q?ClV/0Q7kEHijL8qxOJ8H6PUkF1IDfIe165ipTHFhyp+qV9Z4x+vKQB8UUtyg?=
 =?us-ascii?Q?pKhB4x6zL6P1metBlw+wBSVZm+mwGSsP+6NrGruikEvbdpBxfTmZ98zZAYZ9?=
 =?us-ascii?Q?+jNaxbGm1kzBL5B3c2BxmwntR1yk1maAlP07Gy40xjl/OyAkOmH5hOAkd14q?=
 =?us-ascii?Q?yiGP+5EgLSY9Ty0bfFeL4Rt8RRORhKrW33E8j5YTnPNhoFwnOWlGCGS2cbpr?=
 =?us-ascii?Q?r27s+MoBL/gHedWIpBjTTTaS460V1lqNkWzb9XWD+aQ0AWVUhybkWHv3rIIz?=
 =?us-ascii?Q?ir+RuvIi8J6vaT1jGqiQ8famYsENN+zPbFmTvXsqcLBREayMxdw2lR9U+aBO?=
 =?us-ascii?Q?R2FpJ3qSD/47GoHjdMMSN6f7iO9a3Q405h6MymAXiWzwv1IDCWaQSYLLmBfd?=
 =?us-ascii?Q?T7y2EO3/5pCZL9xd8E4e4W1Ed8hZOEhXmccueh/tQvFPyC0pNNXG42eqy90Q?=
 =?us-ascii?Q?j8W0wiR41Ij/oeO9Ouqp3/Dkhja4P6MpcFGst2LfPje8vAphpE7VlheR3j47?=
 =?us-ascii?Q?+hLhDYPokt6CUSu8wFz9S9bJtvi0rgNZDOU1F6f22AZUBuy08RdUtOtd4uvL?=
 =?us-ascii?Q?meqpZ4gONu054VDo5NGDPY5PXNDQ86G0wcFKwrMfNe31BpWxqVllizFPo5UZ?=
 =?us-ascii?Q?TcOq+UiR9uXTvbY7Y6iM4aBt2ybdJaQsV+AKi48BLmClyZepXlRMxl6IhxzP?=
 =?us-ascii?Q?VCh1wzq/CvzCAkJBy0InOEqu+VZ+3+RkKSjeVd3Cr+l0c+VLNKbxQNSCldQp?=
 =?us-ascii?Q?tT5G6Nf1RPQgS89aK3BILeI1LdcxZ5cX6bHNQU3mSyjwfDPiUGQIs+kjpVrV?=
 =?us-ascii?Q?o0fSI3S4hvoIWU/mte82i8njPqrwPhTNOKzOjxZvpJobdeo7G709k2UFTE/D?=
 =?us-ascii?Q?Yizpiofi0xBbVqJp4uoP0NMxzTuLrlFlxRLyqJo1AbOjVg+Vso3GSnoY7xRb?=
 =?us-ascii?Q?LiqXxXkMQ0tnks4BSOmOQ+uH9Mk/ylhjATZELe0+PrAdUeU1ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:26:03.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0fe608-9bcc-4be5-dc5e-08dc8b7a14f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here it needs to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d07f09dd7eab..03e4cf177a5b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -526,6 +526,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -545,6 +546,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


