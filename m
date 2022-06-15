Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32854C3DE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jun 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiFOIqE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 04:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbiFOIqD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 04:46:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564D94B841
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 01:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhlKKHWf54HsIuhAxBI+Grv33kU8zPBcQ8x5XhjkR9KVhg8rT6UOBKO3A0Fl2fBGAVeAiW6VWJkYSt7UzULyANWzNOGczeisjUHVmQurZcBQBR/3lz5TtHR1u1ym8nXWRINK589DHpNJ0RseB+S3Mu2i5n0UR/fv4h9W5u0vbpY0ImPQejFZNf3wnlaGGuTpozT+uRqJPN81vjke73rWDLOyjpDvOuTU+gZf2lw4ZfbwJI2+gR5223IYRteCV9k7sJoGcviqIHUG242D457D2mbW/fHdK9qeNNrFllsxko+t6eTt8+v6iRmVfz08aPpOkrYLl6IuUqx4HxYVxPwkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDBUUY59FaaOMVGxItpc4YaHpKgD2bEU5hz5qETnIGU=;
 b=BHjjRSOoktLtNCWjKf81HSHa6RrB0o4nFXzaCCPyx4XOsL+NjiKXHA1ypG2bQvQ0Q5FOokTgcbc31rBfcYhHaa8vA/aXcfMYDvvEKxBnQZBAaZaw+Ge3oMLBymevUCass1rzPToHR0xkKIq9wAubT2ZRm41eItFWSJWXpHwpWJTG+rkmSk/CayD1coAUnLLqhmopTj+tegMzQ8z3icAx0cLLNnM03EJ6GyboWE33hY7GkcB0BHanDeGGe1/A13oEi6LjV07BPDv8BUEjtxZZf/KHDZDv+dpRqOp3vmIzHb0I6lOjJChvUiKlTTCpv03wLl9K+az08wv5u7FOcTRAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDBUUY59FaaOMVGxItpc4YaHpKgD2bEU5hz5qETnIGU=;
 b=Kfq5rMYgVZh8yHpgcZTxb7peaGJVfEHEuusLceOTSbygOvf6tav4QVjf+nPZijI0n7OwKNHO4PiaW0QE0bqXWOjTRYivL0QdFqL0eezPBrHb/YHYC1Z+x7H556bu7Nlyqq63exdVRmZa6xZL+ysr1z2VfsUdoIossA0RwRHidrw=
Received: from MWHPR08CA0060.namprd08.prod.outlook.com (2603:10b6:300:c0::34)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 15 Jun
 2022 08:45:59 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::11) by MWHPR08CA0060.outlook.office365.com
 (2603:10b6:300:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 08:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 08:45:58 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 15 Jun 2022 03:45:51 -0500
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>
CC:     <ray.huang@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, <richardqi.liang@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Add resume callback for amd-pstate
Date:   Wed, 15 Jun 2022 16:45:26 +0800
Message-ID: <20220615084526.54685-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d5f7dbf-9197-4b8b-9ace-08da4eab77e6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279AF28867EE72C12D58B2090AD9@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsNZ19Oa50VYfIK5GGZ+nu4aNwkDZrXNV99YCgqwgNWaCNJ47ScH+vpyd+sw40a+wFo54Fh6ICBTcE2pN5dW+JMqWH/d6w5XZtLhPkZRiWNI7jIdfIEqBeGF8tNHC/0M1SZgsQMWLEk5DDedd0ze8a6vP7UZXV3d/6HKWNXkjwyQqRP/PrnbpEaqDOk8XlE/hlx/IsRcCS6aAai476B5KmhA/g4bjO1zXlvNehIgM6k0nbN1QEH8bKpPuxISHDlbsxf/qZ8nDUulqM4H3YDH3vrR3pBjgdtcGWEAlhpB8f2ikZRMezl6iK42f0+c8PZSzrhs2rDdaWgSm3wIXxGkTPNpEOuG1iDi5wZOUOCEL/vcO8XcSASipQcjeGBm+4D8BLVNU5X3PRmSDlI9RGqWLVKItm1OfD2BUf3W3j2GLq3+SAOPMCiNL43DIea1BBX552F4G1Aj26zYhYb87ptQe4ugv9rk+qXlwN9UtnMTrcSwq3ilfoBNuMcClLGE5qlQVDaFRYOqRrSyE3AVhI2XABRO3IMh6hjO9Zau8Oi/afKBqFJifANXYBog+j0imcJk2MswW490yxuv94qimyrZNro7q08YTZ+6lo7O5AN3ZGRqm6nLrQgO7qMvTPIXKj1U8bGlXHuL0feiiHmWoHnSBqdJ6PvVcse1VSkdgE7h+emqVe6wMjPg0401klANi9t9Fnfsy34sHYYsiDfhqUcaKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(186003)(16526019)(508600001)(8936002)(7696005)(86362001)(1076003)(2616005)(26005)(336012)(47076005)(81166007)(356005)(6666004)(2906002)(54906003)(70206006)(316002)(70586007)(426003)(36860700001)(82310400005)(36756003)(8676002)(40460700003)(110136005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 08:45:58.2447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5f7dbf-9197-4b8b-9ace-08da4eab77e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When system resumes from S3, the CPPC enable register will be
cleared and reset to 0. So set this bit to enable CPPC
interface by writing 1 to this register.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7be38bc6a673..e60dd51264a7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -566,6 +566,17 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	ret = amd_pstate_enable(true);
+	if (ret)
+		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
+
+	return ret;
+}
+
 /* Sysfs attributes */
 
 /*
@@ -636,6 +647,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.target		= amd_pstate_target,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
+	.resume		= amd_pstate_cpu_resume,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 	.attr           = amd_pstate_attr,
-- 
2.32.0

