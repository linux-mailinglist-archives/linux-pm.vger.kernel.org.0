Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27341B03BA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 10:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDTID7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 04:03:59 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:19936
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbgDTID6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 04:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7kdJ0i6CTiQRQNAgwPx+yu24JRHDRudsfAS8ZZmdXLidqfyXxyv0nI6yrMa8NDaZlUvbmCR16vaCQBtXd78BWxlGePHqbs3Egwdz25wK68yCi56qsBQXALnpiHcedP+gDqp7S8I1x0LSsogoNADeGcSBtUI1Vwy5Uq+xlF4Wzw1e0/PBiM7JC1JDHohsQammqeCKAayPQ4o5csPeF97ypIBSlKZlaGbBSs9Aa1mv3Vx4nin58lieoUm5BR68UHqL8ACg7otSOE6ujgY3h8rMZq0MAuTJqtMzuB+Kxb+9GhNLtjH1LwZsWkT1oR7lPONjbw5+u5JVdsoWyHHVaxC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot4VnWzMeLyBWwFCqFarg5c3goiOWwOCXCT8KT/LHTw=;
 b=iKYXVSOgV1lCBjTpcBlDKyizVoM50HSmseym+NJR4ig37CKWUAdOjo2odojx9WLOtPBFn3bCYw0qhwCm9iLMxXLWYUYMARp4B1yKNX9gli+0h5W0B7A0NzuRMdtRXNymCPrZAY1ZiW8O4aY2NI8nm0VBgzR2paZipc1Tg67hWhOD+dwNK24wZb7yi1D7mud4fW6SaicLqQ1110xXXVAn28uoGNmGlHRj2mtbbv4OLhVVsN4ZnMYuVMpCZYU5vaLHZazjnhakkbzaj029v9ybXdpzXstyWodqvzRFWKvsWDa3m4fD3/5cs8ErUWdni4cp/tUA7q1kyMV5i8F/FDsROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot4VnWzMeLyBWwFCqFarg5c3goiOWwOCXCT8KT/LHTw=;
 b=D6MM1qNnevCPffvEItqNe5qScZQ3ZF64zn621F/LTPns3jgsUDcBMwY96VWtb0nU/usLRtBUaG94CXGdMIBdY30NGhnOhqL8hrzs1c+uajvtSO28M4i0IBDIZxbvyiIsS49H0Y3ldc6hdMPkhUTl+yGy+jTT7of5nTgAZSXVxso=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2709.eurprd04.prod.outlook.com (2603:10a6:4:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 08:03:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 08:03:50 +0000
From:   peng.fan@nxp.com
To:     viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, rjw@rjwysocki.net
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] cpufreq: add i.MX7ULP support
Date:   Mon, 20 Apr 2020 15:55:12 +0800
Message-Id: <1587369314-23452-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0010.apcprd06.prod.outlook.com (2603:1096:3::20)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR0601CA0010.apcprd06.prod.outlook.com (2603:1096:3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 08:03:46 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e70952e2-bf20-46f6-f941-08d7e5015c36
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2709:|DB6PR0402MB2709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2709435B3FD1CCACA41FE4C888D40@DB6PR0402MB2709.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(956004)(2616005)(36756003)(316002)(186003)(86362001)(4744005)(16526019)(81156014)(8676002)(966005)(8936002)(6506007)(26005)(69590400007)(52116002)(6512007)(478600001)(6486002)(5660300002)(66476007)(4326008)(66946007)(66556008)(2906002)(9686003)(6666004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeiLpvTVECjb9DiaEpAY1/XLtcyVS0rN6Mn/4ZJKXdtcRwGgPFyY8oHbqdyPaNqXliBMhYElnn9YpJlGO3/4hwO3AAnZOiNGdm9NPTPqT8MD8u1ckRksh9nKtPdoQgBVy71uvw3NbjJJ7OyS9d9dYIY7S5SeLGTpJtnc6IMAneaZ/0U31ttcEmyGNYXTpEd0ns+JEpvG1w3rwHtGhgqOJYSeaWaqrwrgsxTwcEH8YO0wKYXVYizePEyDyIbbep16m4TXn9A/exsmXOr6xF+cv79VbKLBrAe3UZWCvtsNcTC43N7XyOy2GFS7kKEY1hFPImRWzc/444DbbTs91E3U5fBqniqUILbwlf9CwJ2nC+xHoXaMPVkD17k3pnaygvpmsxHkm8lNtl1VW/DvHKkdn22yiEQaWgGi5Qkhw/f1rWWCgkZnLVqP2u+vAsQqSNEQTwCXBC2vWbHK43yYR2oM7AeMOSTf0ElvI/Jz+g8Ohxv7DAFvMgjCwWIJIWbYDFrzrSnhk0pCVz3RJ93G3O5FeDr2URjqjW/RKVOS7yBHtYJbtgZ5KM8I5NwvLdCkmWZBS4WJCvf0wOx01+pU1VFTdQ==
X-MS-Exchange-AntiSpam-MessageData: G4z7cZ6BIcrwnEadSSMp0Dc7ZZANExKG+dCErAUyJ804LVziU2NrW46wLjAcpwln+hresF2YVTpWTX6cILFwwJH/jiy9GfRbG/RRJ9ql3Qjj40g16AlZWaA29Iuc6XK1H/mBn1S1b6x2hnJbhx+0Hw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70952e2-bf20-46f6-f941-08d7e5015c36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 08:03:50.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlEYBWWWklKrKdKu0hLy0Kd7t3tfEfpTv1ByI5RXL1vwypK05q6mLONLdw2asmSzLHe971JDXPrnfCexuT9S+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2709
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is a splited patchset from https://patchwork.kernel.org/cover/11390589/
patch 11/14 and patch 12/14 posted 2 months ago.

This is to use cpufreq dt driver target_intermediate to implement
cpufreq for i.MX7ULP, because i.MX7ULP has some specific requirements
for core clk changing.

To make cpufreq on i.MX7ULP full function, there still more patches
required:
https://patchwork.kernel.org/cover/11491149/
https://patchwork.kernel.org/patch/11390559/

However with this current patchset applied, it not break anything,
because the cpufreq device has not been registered, and opp table
not added.

Peng Fan (2):
  cpufreq: Add i.MX7ULP to cpufreq-dt-platdev blacklist
  cpufreq: imx-cpufreq-dt: support i.MX7ULP

 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/imx-cpufreq-dt.c     | 84 +++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.16.4

