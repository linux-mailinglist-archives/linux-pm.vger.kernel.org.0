Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93A3D0DA8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbhGUKsX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 06:48:23 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:40544
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238579AbhGUJhC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jul 2021 05:37:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw13rjvFuAaqDasBrQAu5GmJ4RyaSf2oOYIpQa14JItfMPc/8ydVZ2YEF2jsQ168VomhUGfqsio8bHl2bY5yK/FK2MR6i/HIa7dWGUtK+yPXpz+67h6WVScw+WIFmAEuQCg3zEsgNqq66EnrEpohZo5ZVrOZ+4oDxh5OOcyOnVkyisDaaZ/Ik8Z1E5QpRdH4oMVnIqc42SdzhYLw1e8dOUBzY7pkzuaMC9BZqmHXcU+2ds7tbYRyIa7EuIhGWbz1p25o5u4G9T9MYUnUHHNow4WTLPPp1lHWnpLY9NHqoTmeKMpcnr/pVfQijtVKnfpxWNMz3FPxM7jlBv146Icl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L64Py8DlhmfSHP5APjGi86A02Js8z0qXNYsaJMio7V4=;
 b=k42u31FUVzjqPhf0U+nBKep4zJCNSuDvxVenWbHhRzQAytTgWPt8Z4eSPGIyBuqhw2aQTTdVdGuOdKJhOE4hgADZBEAPfdv0KZEsSNTXIoVrdzOeuZahPOqrAvBSZSR1yeAT/CjVXEwo2uR3RT60s89ks8VdBL+AX1iuCyJZYKdbYdTCve4KJiHDrMl+huKhi7I4qOZGoLf/dAvNq+piMN0pduGv2KcHQgdF1hJttaEEJqRFSW8oGGHw4MUIykgFTwg4RJCvu6tEkWlXTlXNw5YDiiWk4qyn6btr+VluXnODAp6RPNJj2FJCB8GIJjLOIa+bITSQykX64WlDNbv6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L64Py8DlhmfSHP5APjGi86A02Js8z0qXNYsaJMio7V4=;
 b=ZiFW99mPDEiciHO0U4yrh8xvp+BuR7qEaF2+ItNWKkcrvHh/4r7zz8L5AB027lxUqwKrVW+NghaD4DVrPPTSjXOoQ+HlTkUb7VK0TuwbVgqLFJANbsaw7UEnWq1JTDCBSo/4sYdJLmErC9nbHvBnsbP+b2wc+6O7R/rPDd+sZZY=
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 CY4PR12MB1255.namprd12.prod.outlook.com (2603:10b6:903:36::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.25; Wed, 21 Jul 2021 10:17:32 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::c) by DM6PR06CA0057.outlook.office365.com
 (2603:10b6:5:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 10:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 10:17:32 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Jul
 2021 05:17:30 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Huang Rui <ray.huang@amd.com>
Subject: [PATCH] cpufreq: enhance the sequency of governor change
Date:   Wed, 21 Jul 2021 18:16:58 +0800
Message-ID: <20210721101658.9235-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f9a6a13-fcaa-4810-d304-08d94c30c088
X-MS-TrafficTypeDiagnostic: CY4PR12MB1255:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1255F68C901AABBAB22289BFECE39@CY4PR12MB1255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLOTn1RPWuq22phX+TxkZ/eTQbI+wbx9oekSgf+E5lsesqxa2Lx45xu9qAjQKK27EhtdT4vGmyOWl+fqbAj5/iruWhBP8CM8GoBk7XcdZH7TWRwaXk3EDljvHhTie5QcJi83uYASWCfY3ujWY2tun7bMBXv4Xh8Edn9zKDqSSFZx6MZjkAm8p0/I52YbtP32+SZOyGWF7wIH0yu7ygzdxOVa4V832P1G7eEI9k8242Hhv9K50Entk7r0euupBlMz/m1NqyLmHt4MIQsaara0YjCevarYs09XXBfy42SA4mrdHpRsTknHg7eHJmvA3vLNH6kzpuZYoxxHnCYILAVE04/1QRFF5SndvdNjq7PQ0FaAn2rMBBTAoHNN//+JSYIf5VBzY4Fhwu4c6YQ2vS26uNjI9aHPq13YjCMDe+ao35laitUkDUSG3AhopAJXCP76IYAgUhNNZP93e5oThPVJq24is65ihQrdexAaoWGMD8NxEoyCgNuuJ7UYRbgoEVWbSBi1+Uu6S6g/paWkq+4jMQFrCsVtvCorTZJgyYXQ9gRZTiXpV3U3i2jLaY0tLST3Brfks2nILd3GuVG3/nvuUFA93NOuSjMkSFfohnkCa0mGpslWA8J8kor72icHGtczb9EQYTq9BUY9dUZcK22sG34EEuz00dnp5c2DTlleCATB8p/wzhBLiU/BQu3o528euQ4BXIcQnJtOqFumFVmaLLtnJkMT+W1sAA7pkivI7+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(47076005)(478600001)(426003)(82740400003)(5660300002)(8936002)(336012)(83380400001)(36756003)(8676002)(82310400003)(1076003)(2616005)(6666004)(81166007)(186003)(4326008)(70586007)(356005)(26005)(316002)(110136005)(7696005)(70206006)(36860700001)(16526019)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 10:17:32.0860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9a6a13-fcaa-4810-d304-08d94c30c088
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1255
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Keep the "success" case of governor change in the mainline of the
function not in "if" case. And using restart_old_gov flag to indicate
the fallback case to old governor. This is more readable and no function
change.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc925b2a..4f7005ddb70c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2545,18 +2545,25 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	/* start new governor */
 	policy->governor = new_gov;
 	ret = cpufreq_init_governor(policy);
-	if (!ret) {
-		ret = cpufreq_start_governor(policy);
-		if (!ret) {
-			pr_debug("governor change\n");
-			sched_cpufreq_governor_change(policy, old_gov);
-			return 0;
-		}
+	if (ret)
+		goto restart_old_gov;
+
+	ret = cpufreq_start_governor(policy);
+	if (ret) {
 		cpufreq_exit_governor(policy);
+		goto restart_old_gov;
 	}
 
+	pr_debug("governor change\n");
+
+	sched_cpufreq_governor_change(policy, old_gov);
+
+	return 0;
+
+restart_old_gov:
 	/* new governor failed, so re-start old one */
-	pr_debug("starting governor %s failed\n", policy->governor->name);
+	pr_debug("starting governor %s failed\n",
+		 policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
 		if (cpufreq_init_governor(policy))
-- 
2.25.1

