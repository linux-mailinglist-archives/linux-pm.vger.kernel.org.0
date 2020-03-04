Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED7179027
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgCDMUD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 07:20:03 -0500
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:25568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728969AbgCDMUC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 07:20:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNn3fohiq72FyOHlUipE8WtKRo6WeJZL1KwcKE+HXTKKwI+7w7gjG3seJeGB2rGWv3pBu/rUTFj8YwwVApHKdiGIChFKS0IFs/QKOMfEva2AQSf+Ytu/qpS9HZORaGt4eDtZsYntfLycH+OQnZFv4f0F8Bo4GUYrXAG57PG58Hytt/ZKmHsPhytLDEApO3TO7KFLgci+qvOHZ0xTkEd5/m9v4z0Tg7/z9DDtfHjAZVul8GVQFy7flc+ADj72JA+5tuKWrNiwymva4h5/o2ruN0/vbAmpKa/uqcDP7uwhufZ+lP9oaKWHY9juy3DO5ErH/g1EWyXl89Im2bcVkXT9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hCQ/yLfh3IVXbwdiCjaJDBLWbM1rlfRHO/crOYdzTo=;
 b=OL5gHU8ZvLxpj4t+ofKLekw6PejuOHBV89y2zNv/vyr3ziEbu87Rrmin40RFx04LvhVJmc94QoRq7DkrXAXdlV4/iD88mO8NCHL+f65h0AwXm0/uwD7hsrZkBI9mI9j5V1KSGQ5cvMIFGS8VHH/7LgMjcbwaeuDYgBx5+isgbXEwmXVZ3vy17yTURACUMybuDKVSNpsvbxIV2CCGTxf5rWE16s5xZ1wdh2ggry4JjPGEbElGEiRxF4/SmEoR1qE1xJh9Ieb/oHkF64CeaBbYiL/cJc1ZsfCEnp0fV25VkxWSONno8yyNZ1V2F/Ng1NP6L/SiuWPowzLMNL3Mnf7fSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hCQ/yLfh3IVXbwdiCjaJDBLWbM1rlfRHO/crOYdzTo=;
 b=SnxbP/uycoDHpbkJ3UpSLf+t4h68g22ewlgZVB8p2HfL5mtsDZHgcQPyn2GOftKCxgl6hJWTsazaJvT/rYYooEjimWpZd7TOLftqSLeIyzDPw0H1JGa74VWkTRnRf79beBrwEMufuEgx+5Ft1e/gD7TnBubDzUqZmVErMGDLTCU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB2718.eurprd04.prod.outlook.com (10.175.21.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 12:19:59 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::35d0:31bc:91d9:ceb0%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 12:19:58 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     rjw@rjwysocki.net, len.brown@intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     daniel.baluta@oss.nxp.com, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
        khilman@kernel.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
        paul.olaru@nxp.com, linux-imx@nxp.com, kernel@pengutronix.de,
        shawnguo@kernel.org, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 0/2] Introduce multi PM domains helpers
Date:   Wed,  4 Mar 2020 14:19:41 +0200
Message-Id: <20200304121943.28989-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0701CA0034.eurprd07.prod.outlook.com
 (2603:10a6:200:42::44) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM4PR0701CA0034.eurprd07.prod.outlook.com (2603:10a6:200:42::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Wed, 4 Mar 2020 12:19:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bad6d9a5-522c-4d15-d77f-08d7c0365af0
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2718:|VI1PR0402MB2718:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2718D56F4A83B488800F0070B8E50@VI1PR0402MB2718.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(6666004)(1076003)(6506007)(86362001)(2906002)(81166006)(81156014)(52116002)(316002)(44832011)(7416002)(8676002)(8936002)(4744005)(5660300002)(186003)(66946007)(66476007)(2616005)(956004)(66556008)(16526019)(6512007)(26005)(6486002)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2718;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
Received-SPF: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNkjiwT3QP+Cnd0OABpMtcn0aRKub8no6+hazqm1vk/HJEfE+QMgi63/RCoOoJmf1XK2p52W0HIwpLp73LwiRwJGhxy9eSkAmwZ+ULASsofA5Rzcehlx2YVoRzUVO4m1eyBJYy3lPG3NA6J5Rz0UEMArwCeeCP3/UliRT2R+vP1H+cpd7rfUgeX5nzq11HIc4PKAvq74Er/RDDT/mplnSIGjI89hlfMI46p+/PKHo9dhyDsMRU42iuHCQKwnOktgVYW/w2lLudgvu50fel/cXxEzgpuwL1JYqUWeiJXFEDAk80RbtV0ZysEEcwTBheilvYIroKzCFhzl+0ac+CTH81oL2n63HurUAGu4uixnO23eui2mmNxwSKVyIOzmHdM9WUQZKzkwH4mk7oWK+5oCIL0XDsjMCPFecGHF09fwABuwVmjV7K1ed9K68gsLBRQx
X-MS-Exchange-AntiSpam-MessageData: m5/Vm+PAOT0KZWvHHY+ruupJrlQ5tbFpulVKT4/AtNxKfpod5AilyFHP2dSs4QzpzBfW49jf/F/KCaABwvQ9DwpDrgp2zxB5K8XaZtP1ugofOq7EABkNCaZJI9RPh5zr3cUUlsJfKFvcPIE4qm/OoA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad6d9a5-522c-4d15-d77f-08d7c0365af0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 12:19:58.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFX15cKXRgDkZnQoQdDgaIR9xycDXzmrenuUXctzVfx8kzNAa8SUtN1wnuXhGUZjW85NLEDrDO5pLZos+q+3MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2718
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

i.MX8QXP/i.MX8QM has IPs that need multiple power domains to be up
in order to work. In order to help drivers, we introduce multi PM
domains helpers that are able to activate/deactivate multi PM domains.

First patch introduces the helpers and second patch demonstrates how
a driver can use them instead of hardcoding the PM domains handling.

Changes since v1: (addressed Ranjani's comments)
	- enhanced description for dev_multi_pm_attach return value
	- renamed exit_unroll_pm label to exit_detach_pm

Daniel Baluta (2):
  PM / domains: Introduce multi PM domains helpers
  ASoC: SOF: Use multi PM domains helpers

 drivers/base/power/common.c | 93 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 19 ++++++++
 sound/soc/sof/imx/imx8.c    | 60 ++++--------------------
 3 files changed, 121 insertions(+), 51 deletions(-)

-- 
2.17.1

