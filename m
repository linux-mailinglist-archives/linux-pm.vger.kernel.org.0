Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE66292185
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 05:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgJSD5u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 23:57:50 -0400
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:23270
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731306AbgJSD5u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Oct 2020 23:57:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2rImMGgp64rq/S4xGqOYFNS4r8fp7meh66LTg6v3k9GVyllmyOSHce9XoVfMRiwlzKU0RLcLHCWkubZASrQ6F6DJwZ3a8CjgB6xU1NvyWGS8TPnUst0mm5GkZ4pdwYzVOWc8g20SjW2h4TdIKFqSXhyw3K2ZxxM23gqG/fqnkDxTqLb7XZhXzE3p7BX5jFULqBFZhGPLhHDdEcX+qvSZBFK1jeiBpT6ZZ4mNwQ1ZxDwdnNbStAJDLV+9VS0FJuPaQsIXed/ZoTn3tFD+pgw1Ayu4i+X1diocZem70/6psgiY46rD3+VTxDduoAmRLrZFUif1816za7uUYZbUp6jeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K++z5fZs3R5Fml2jcGbd9OQSuUE85RyehS2f9Li+tPU=;
 b=dXWgCqz4UP3qMpLKuQWI9qGdgucKqxKTjDRoClC9ODw4wfHN+YCQB3I+Sc182Oyd3LW43+9PvXR73A6Gt5/wtXqU7mgPwzdztU906L059B+um3ik2aK+VOwrouP+TfuJCHkxy9NhJ7XVv8rsjtMcE7p1IT2uwB+ngEZ/UpcDS2hLof3U2AZrraeIkgij1lzXQesmivUkR48cTA5+m1VCAsGNAL36GGikK19KLz1O+MR5IJ0mQ+wO2WHa1MO+QWtVgOX8Aro2Yz03vjNDOUM8+7SgTLeSrLcEb+XvXI7MQ2SXvBtxHaxaH23a0TvTN+XB9y2hp81dQ8KX6geK8TtKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K++z5fZs3R5Fml2jcGbd9OQSuUE85RyehS2f9Li+tPU=;
 b=tYaAGREhgELSfX/oxkowQ0O/8+3xWNNFhZsH1opSyawod6p/jjfbnDudWRCisIZ2lBvDgw/u9pm8q3rMir4ULC8F5DHa9vwx01FFwNyEQSdDGraA4BfX5GOnU3pW7OAP9CI/8m63D1YodIKyqpt71S6DfGiKlqr8vupV8eJKKP8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1800.namprd12.prod.outlook.com (2603:10b6:903:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 03:57:48 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 03:57:48 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, rafael@kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, wei.huang2@amd.com
Subject: [PATCH v2 1/1] acpi-cpufreq: Honor _PSD table setting in CPU frequency control
Date:   Sun, 18 Oct 2020 22:57:41 -0500
Message-Id: <20201019035741.2279043-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0601CA0011.namprd06.prod.outlook.com
 (2603:10b6:803:2f::21) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weiserver.amd.com (165.204.77.1) by SN4PR0601CA0011.namprd06.prod.outlook.com (2603:10b6:803:2f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24 via Frontend Transport; Mon, 19 Oct 2020 03:57:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0237e8b2-7ae9-44b2-122b-08d873e3247e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1800:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1800F9B3B1C46B7947C38446CF1E0@CY4PR12MB1800.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56dJZU3xODsI9mZw1VcLIe3mFyMKbX9I5lXlZstKWngNjY3p4pYnNZUq9BZs/0thZHOC9DYr4yq2bMIeRqNFogvKhco4V0RaNTauUhB1ejZCKNdNMpd80AuWu1da5oTwzB6J/RzOrHM2Td8vtOofq3crGoFihramLB+xuZM/aM9HCzoz5fKQKd7RH8jxcOExnG6iUHBlCpAL7pPxlYpPDf9iEGJ98XawDNymnRIgXcYPoiQytMBdb4+fGlwpfUTZRgqVkoLkrtnUqLQBw/lbPPy3GV/nuZR/clIIoY0MhkbfoC7t+9a8bMh3eG9BargBnUpd7y3ArHwN6BNifkacgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(4326008)(6916009)(6486002)(2906002)(66476007)(66556008)(478600001)(5660300002)(83380400001)(8936002)(2616005)(8676002)(316002)(6666004)(66946007)(36756003)(1076003)(186003)(16526019)(7696005)(26005)(86362001)(52116002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Pa/pD+1+wp/V0z1R+O5PYfA4vNfgl7sp/3ICIe87Fm4LLiDJwLivMuqmck6GySQWFN3W8Ki7e6y8X+h8NUIoDTeq8UwNt4FIAAWxHiP6H1ldBIHjF6O2Tu8rBDHVhrlXYlk4PUnOyL6IKMUDwRVqAHiihmIYjrLIuI7VXEJq43vmw+LUichKlRzKEBnhkDyzMgCk0g5L6Xx5nkWj1sUKMI+DvzUgN58BxXbMmKNO/pDee7F7kMrIQtc9eoj9Xk6Pw3ChDGxbSQyETF2Wrnnjn6kw46loB4VTriLtD8/ev1JX8chlehUy5BYX0rWt8HEdnYllJxPdhml1oZ3uyK3ZRPFL9YSwM0daDf8yZaeOTstATp7XHzU9KG3vQb45FaK5x7vme1iroSjPAnmF+wAVVGplAMLeQVbA7mgskH2wtFSSZyVYhieZdyfP4TUMp+QeKn6RyP506R4U81QQsQa7rmyCJ7kcuaGZlKGYIyc8sqYnSH8hX8pSUMjsy/9cmXOYpzCZwo2KPUwHGZ2Z0DGIqRSoYcBoisrOyFnqyTeV24g2jEygUZIul/3cy6nRm6rX4yNzhP/AnRNkmhmCXESpoZLNzGNsAEWDnjNHybNAm6IyzQSkL/Mh+dvcpOeYdtUIrY6vj0iaMu50qDvbcfLFkA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0237e8b2-7ae9-44b2-122b-08d873e3247e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 03:57:48.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEJ74lohoKHwWnaNta8Lp/7Kuglksq+2os93orul1xgQsMXOngwU2myN9r51hH8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1800
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

acpi-cpufreq has a old quirk that overrides the _PSD table supplied by
BIOS on AMD CPUs. However the _PSD table of new AMD CPUs (Family 19h+)
now accurately reports the P-state dependency of CPU cores. Hence this
quirk needs to be fixed in order to support new CPUs' frequency control.

Fixes: acd316248205 ("acpi-cpufreq: Add quirk to disable _PSD usage on all AMD CPUs")
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index e4ff681faaaa..1e4fbb002a31 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -691,7 +691,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
 	}
 
-	if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
+	if (check_amd_hwpstate_cpu(cpu) && boot_cpu_data.x86 < 0x19 &&
+	    !acpi_pstate_strict) {
 		cpumask_clear(policy->cpus);
 		cpumask_set_cpu(cpu, policy->cpus);
 		cpumask_copy(data->freqdomain_cpus,
-- 
2.24.1

