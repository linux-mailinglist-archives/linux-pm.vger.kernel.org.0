Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1343FCF7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhJ2NGo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:06:44 -0400
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:48737
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231810AbhJ2NGf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtSQ6CP4NSDHY47fmrwX8iOrdtJEI7NyNUcFdz+5Da4UFgLfoyq4PLdELIUwTDvIcemkTDsfPn9u1qRzcAMjigauctJINGxLb5hBUWkfg+VEJu5P0vC6hdUeGi0PeGcaPW+3vNf2FcKIH+icw6FgXGzPqUej5+2O/z4lc89wWRghJ0DtbY/o0GT8e1jpGLjH8nAANRKUMZfa/h0v6Ig5gD9MphIpPDJG239pISmDEe91z9WLV7ZASAkexEx5ivSV7tEPkTUl0fk+zjA0mg7DsrAwfjrrKvhvRvtwXMzaIOS+lwVaDunQXt6YuJUI9MAO98RDDFeYO4/Ww3JZwzPLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pYsyexvQMa8hZ+5vlnmrH05OfESH/IbPZAB+4LMCGs=;
 b=Vt9QbSSn3/4ocGGE6gQlXcM1GZyUAePADdhDIRF65yEQYE9c3ePBdPZaQVpVDDe8qIavdAUPANTW15t+Y8Nmx9R/USEOtFbiMfiGgYwxNZfJSNOEG2v22hWBxOL+hQtA/IfIMPLG/NAupwt6jQUV6hdTMOKr9L0cGOmfGp3CjYLDMO9Gl9y9it0mpiwUD+8RELodUD+a6ShtUHjrxmhw2paKEKJaTMEJ5LpFFgF8ayfNoULONsuKU5QonsKGfuUX5WHmGUbKajkEIgHv4zYjLvEZcAdnr0ytv78YWG654xPMCHj9fAtDbrZ9m40a7smpQJsSrVyrplJLjLRZdpfAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pYsyexvQMa8hZ+5vlnmrH05OfESH/IbPZAB+4LMCGs=;
 b=dACiZGg1IDhUhdlB+4jzy/NuP3bVXEWyosUjDV1zYZs6CeeSDZ4qc7iIojY2GaXTCSjOrhKYAIfEH31FcL8I3LETqlJ4dKr4Ci0+yYtlPccgtoO/xeSouBIH6cr4p+D/qaQEPXB6Gw5Xd7Vz8h5DWQzsA5lbkRSSGrwRwCbwgYw=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by CH0PR12MB5186.namprd12.prod.outlook.com (2603:10b6:610:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:04:04 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::d0) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 13:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:04:01 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:56 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v3 09/21] cpufreq: amd: add trace for amd-pstate module
Date:   Fri, 29 Oct 2021 21:02:29 +0800
Message-ID: <20211029130241.1984459-10-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986ed24c-4c46-4e05-c300-08d99adc93de
X-MS-TrafficTypeDiagnostic: CH0PR12MB5186:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5186377DEB6501A5FDAE6F5BEC879@CH0PR12MB5186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:73;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQKf1MWLLiHxUsWW4PU9L6MKwah91Wg3/QZv39zKvdo6Addl16pg0ZNpiy68D64Qx5pGa1KmtVN5xsRAYOCloQItbXbEaIN7Sc0vJWacbYET7DNXSCaqIjaGAff9UBmfYsqjDVQyGjxP6DimVeQ0QVDOUxSo2z+Ft3YN1YVqamaQzWjTsHYG41/dMASICsG8XN6CwA77hato0jC93o95Q3YJwHqvofPE0l7brY3uLfq45o5vpEqbeT0t4yJPzo3izJynxoR3oaIw+N3Y1Rw3TorS5NGJ4FW98YZ7/jRhpo/7ymYnLpl5X/IHtv5icOhECPPAb06t4lcLzmKkf2TNt02L0Jcy2RVWCgonYs4CuslBAfdDjFumQEPIrv1PfyImK6+veD7ocdkJvNzbyYMt4tM+ggHjTmgUYdfw1Gn5aGMAiV4QDKtp37CU3X4EbaSDtjXxnQsV54m90PlTC0PsTEKpkuSfp2cTqNljSUboyqIPHICWwQslvmmUTzARaBEt0s77ZX3EStVh0r47Sx+OOV4QsBsOnpC617E/e+a+kyu2L7fgOiw59L37VTsDRFz5KbT/wMQmQix1t69F60uwWR05gB+OMGB5/FvCtmX1faC07zfG3MiEPvj6bQYXEePzAav8G+i37KuOL7JGoUThQzOr56KFwhnnL6Gw3lbUO66I7jSOSjTiS7ds2b94xVwaK6YiXNba5HyIbRnNYoiL1OLU/dSMvGwtEN06pjPm3NQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(83380400001)(5660300002)(2906002)(316002)(508600001)(82310400003)(16526019)(26005)(4326008)(356005)(110136005)(7696005)(6666004)(81166007)(54906003)(8936002)(86362001)(186003)(336012)(7416002)(36860700001)(426003)(2616005)(70586007)(8676002)(1076003)(70206006)(36756003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:04:01.2279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986ed24c-4c46-4e05-c300-08d99adc93de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5186
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add trace event to monitor the performance value changes which is
controlled by cpu governors.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c |  4 ++++
 include/trace/events/power.h | 46 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d399938d6d85..6037590e82a6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
+#include <trace/events/power.h>
 
 #include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
@@ -189,6 +190,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~REQ_MAX_PERF(~0L);
 	value |= REQ_MAX_PERF(max_perf);
 
+	trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->cpu,
+			      (value != prev), fast_switch);
+
 	if (value == prev)
 		return;
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..c95c0b8d443d 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -173,6 +173,52 @@ TRACE_EVENT(cpu_frequency_limits,
 		  (unsigned long)__entry->cpu_id)
 );
 
+TRACE_EVENT(amd_pstate_perf,
+
+	TP_PROTO(unsigned long min_perf,
+		 unsigned long target_perf,
+		 unsigned long capacity,
+		 unsigned int cpu_id,
+		 bool changed,
+		 bool fast_switch
+		 ),
+
+	TP_ARGS(min_perf,
+		target_perf,
+		capacity,
+		cpu_id,
+		changed,
+		fast_switch
+		),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, min_perf)
+		__field(unsigned long, target_perf)
+		__field(unsigned long, capacity)
+		__field(unsigned int, cpu_id)
+		__field(bool, changed)
+		__field(bool, fast_switch)
+		),
+
+	TP_fast_assign(
+		__entry->min_perf = min_perf;
+		__entry->target_perf = target_perf;
+		__entry->capacity = capacity;
+		__entry->cpu_id = cpu_id;
+		__entry->changed = changed;
+		__entry->fast_switch = fast_switch;
+		),
+
+	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
+		  (unsigned long)__entry->min_perf,
+		  (unsigned long)__entry->target_perf,
+		  (unsigned long)__entry->capacity,
+		  (unsigned int)__entry->cpu_id,
+		  (__entry->changed) ? "true" : "false",
+		  (__entry->fast_switch) ? "true" : "false"
+		 )
+);
+
 TRACE_EVENT(device_pm_callback_start,
 
 	TP_PROTO(struct device *dev, const char *pm_ops, int event),
-- 
2.25.1

