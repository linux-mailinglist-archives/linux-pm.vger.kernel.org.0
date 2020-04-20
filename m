Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEC71B03BD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 10:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDTIEC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 04:04:02 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:19936
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgDTIEB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVtTDYNUskNSUogcYwpp361OsymP/NnmMFdqb5xWl2MMKj+qa2do9OCBmTrZgVg21+T7M2nN5+s+M2h18FtwQwBfzHOZPFAopLPtFU3wKDbNtjF1OMKFrOt39Bnhx9BqK/OoQ8qw2046KBgOFPJEwESmujnzPtCKSPChwUCfRRfe9GzMBO3HQOGVXLq1oAzzLMNfL5v0e+tCOFnIv9/dcOzObfBEaG2XZRetN8EOz8geTPCHhQj5zYld4Jr9G6R9x2zXFsVaQHGLXMfyisCEHR1u22v7ar3dpe74DiciguUs90r9LERqs8CndNMVz12PC89Srs47KfUAeWIV1Z3A3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZVzJtDeecM47f2Kbeh8sNK7fT2YUPYaHfUu5Qd9TYk=;
 b=O016CTPubUyk7gY3trGhHF2OgiE7ljU5Yxeg6tS33mBQe3tIGORQc5UvVifAnsljphTNl56kCcBau0o5qZkilhb6/fOo3KauKP7TXLuC97WQAi98ma4NtmmfldPPw2dCFSX5kgF5jdcSQZaJXoUMG6EPNhOmCTzptSMd+j3QCnViL+fn3R2RCkIYUhQhzWnLX6TSHwgV8icbAw360BCcUxc8h/GJ6/6ux1EaGZ73qMd9bQMuNvHl2LSeQ+IVuCa3OH8YVLto8GZQOX1IBF0y7E4eOjJbFQhZKwPCjUVJ4DhcJrgjRij8nxOuT3qe1QdNllC4PsEfwxYgh6b/9PDCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZVzJtDeecM47f2Kbeh8sNK7fT2YUPYaHfUu5Qd9TYk=;
 b=G3JHkn/QRz7d4nJNK6fv6EZwchQUN0sKSG1/p4Ir4RZuegcROeW2/HX0Iw1QROQtyuQ6UkOegYBys4GPSt98GnQ6zCU94Ys0CCH+6F8NGpXgZIOhMGuLWe86eEXDc1yT8Bv2wkNl/Q5ppvc0mKYL0e5vvShZqtMwAwDvhpEsoec=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2709.eurprd04.prod.outlook.com (2603:10a6:4:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 08:03:54 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 08:03:54 +0000
From:   peng.fan@nxp.com
To:     viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] cpufreq: Add i.MX7ULP to cpufreq-dt-platdev blacklist
Date:   Mon, 20 Apr 2020 15:55:13 +0800
Message-Id: <1587369314-23452-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587369314-23452-1-git-send-email-peng.fan@nxp.com>
References: <1587369314-23452-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0010.apcprd06.prod.outlook.com (2603:1096:3::20)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR0601CA0010.apcprd06.prod.outlook.com (2603:1096:3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 08:03:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2bfb7059-703c-4a2f-5724-08d7e5015ec8
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2709:|DB6PR0402MB2709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB270909ECCCAC5E82B95AC28F88D40@DB6PR0402MB2709.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(956004)(2616005)(36756003)(316002)(186003)(86362001)(4744005)(16526019)(81156014)(8676002)(8936002)(6506007)(26005)(69590400007)(52116002)(6512007)(478600001)(6486002)(5660300002)(66476007)(4326008)(66946007)(66556008)(2906002)(9686003)(6666004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c89TquuaTbZk3SshPaCJrLGq6+IUwc9yFCYgGmhPLBp8D4Ko1d9P/T5zO8sESQh4HJ35ID3uVUEzN75sg2tShgmEqPdsBjn8PFDSEHKCg5L4WoHU97yea2J3DZqPZHGz/EyRPNFjNKJpYi+fGglGu722DI40iM9gvAUhO+L5yv8mPefMx3ynfmanbu3am2DlxmOqS7PQe6qqzjH5wI6NZOvP6DF1ni5t86kIBtsJdZZFyx0/LEsqTfXz/0sjphTInm2k4McYQENCYjV4ZEbDux1sXs/6JyhjXCBUOKdjZTQJ3Swk7qBTEGLia+jhVMhgRD/M0rYaB7WsTWm+oKvq9aRaAquwS2jCRT5gBpqNKWQTSW/Oq7jC0nptqzQSfHrIWgnd489+K45H+5+w/3yVdosVc6JZJnZPL7ZWMHD8n1k0v+aCE67Q4v4wIJjcf6/tpgp16b/any2ej/beY8YIP5bm24KN1dcNZ+3mR/DLh6+5CEBEg7eF+SuVUgznUAMu
X-MS-Exchange-AntiSpam-MessageData: krs6bbcoYkQUbLQ07uhVdaQJmDGTegObHss+zEC7N0g355dHEGi/Ylh0XBDC5112k8iChlg8hvY9or+m8Jw0xwPwUig5/zTR+pqF+ZvpLA8D0EoSon7BwnyDMcwOTsLL0+bl3tJANhj/DG2325rWIw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfb7059-703c-4a2f-5724-08d7e5015ec8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 08:03:54.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSGa+A7u0tU3dFic/J2pDXXHPSMT61CebVqYee242vc6y8xyjjpmWt05EZFtVTI0Go9f+/t3VL+LyTOhugMopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2709
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX7ULP to cpufreq-dt-platdev blacklist.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index cb9db16bea61..5c8baf603e05 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -105,6 +105,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
 
+	{ .compatible = "fsl,imx7ulp", },
 	{ .compatible = "fsl,imx7d", },
 	{ .compatible = "fsl,imx8mq", },
 	{ .compatible = "fsl,imx8mm", },
-- 
2.16.4

