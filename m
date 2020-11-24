Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5C32C22D8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 11:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgKXKZS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 05:25:18 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:29187
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730944AbgKXKZS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 05:25:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuS4YaiqbNeedXC6ypA93VJXR/ixfvG4hMRC/SHveKBu6MjTOge5h9D1cwTHrQPYrFsgPeKSZDOuP3I5tw4kLWIrCVlAJ/am/FKthQ/NI77IU3JQE18lUwZNcvW8FIdh8s3e5YAFOzwUccw2cdEiCFNQYVR07RyP39x5X6KQeAo+IrVCJxwGRqAM1EvrxTVER0z+z/TBejCk+8IMYgcsiWFEQyiHIJpDLXaV6eTCPWmheNG5TpgoN2A2JRwOuR576jfxGGLKCfRrkwFNlXDTlg//dEupLphKuQ76j6b2XtVjy33f2+ST4rtxNLtVRobRj03qp9v+2GbTM/eOO/iQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmboxmljomqoekr7YZh5YF5wZUV4D3w6XE3LOEYr4Bs=;
 b=lD7nzA9HP/a8I+ZQk9Lqdzh+EBDwy93ZZ4ppxvWx8ZCnUNnBoU+Idhkb1SUALT5Dz0B+Gb1nPmTPuMWl2157U9n8HvEcXyo7lXZxj8H/yVOtaP4f2+Qwcl4PfydWWBnR8TIASxXE6yUA1fagAjLlfuFM/Ui+uVA641FRWwW1MfJp5rKAb8lSEIptYa7kBdb7ZhIa662JYM0RMnBGJB2olWNma8hsScCuYPslxFXpQeCYCbgICo3pAFukQ3xusi664JtuhSxb4oRiQ/ppOEhvA68IlzPi5uHiiyVTYlsour2PdQBQnD8BKOslHrQ5UyxE7f30Ld3OP0qhLaQPygjYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmboxmljomqoekr7YZh5YF5wZUV4D3w6XE3LOEYr4Bs=;
 b=BP0kg5LoUWLk3H+TTWuMM9lxwWKeD8w9eAOgZwiNnUq5GTmTAVdP1bUGOW+GQCezYY+GUvGwQULVerTRZ19w4CxC078vYXEWwgZHpT5rnabX1EIwv8vr5Ja4CcwEtiCALZH786+FW1iimpBfdCKI5A0KKgIU4qMfBccOrX9fPpw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6648.eurprd04.prod.outlook.com (2603:10a6:20b:f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 10:25:10 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Tue, 24 Nov 2020
 10:25:10 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        sudipm.mukherjee@gmail.com, sboyd@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 0/3] clk: imx: scu: support defer probe properly
Date:   Tue, 24 Nov 2020 18:07:59 +0800
Message-Id: <20201124100802.22775-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 10:25:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52ba2753-4786-41bb-45d0-08d8906338a5
X-MS-TrafficTypeDiagnostic: AM6PR04MB6648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6648F77AEDE7A0E7D358096E80FB0@AM6PR04MB6648.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMBuuh5anXKJK0Ne9Y2rBLQB1acP/uA0hzRRdiVZehc8x71SG8PUFmMDr1VPqSWUYxbXswyHQHYE6L9X+/HiTTtfh3eVen+vYnd+5RO/EJgSAqWiv2U4lO05B++j0kco+fBCa4w4yiReGzbOjyPh4xgFJJl9OZmbIb0bGT9WOq7zypOjWTsbWr/INHaI0KXyTHELi0PI9luVXbKaAaV0p0RjOv8t8eM3RDmN0qtJDCq429t7BbpKm+i7SyjYU0V63/RIMpGVkMMbqMriknYflz/ygi2X50hTRbFjUCB3qBznddPnqPPd5XngioEEgqPBOi0DODOe4+yT8WDBXiYFDIa80gDF4iq8AU1SvZHJQKYD4UmH5DhB1wnLml4+CjL23Wxb+jtgoMXb0igh+UQhtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(66946007)(6512007)(66476007)(186003)(26005)(83380400001)(16526019)(966005)(66556008)(6916009)(6666004)(4326008)(86362001)(36756003)(316002)(2616005)(478600001)(2906002)(8676002)(6506007)(1076003)(5660300002)(52116002)(956004)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GxLf/TyaF7jtY1g1gMX5zqCH4eC29Ou7nLSEA7Ipygyej8hbBf8rq2K+YL7DVrBiwD8DzkXqwP/R+moNLclTztnrhemWdZN+y/bGiGqBYghDBoo6nfscOgLs+mh/Uy04sfInpIg5q7EWOrvMtT/VGsIcY+Q6hQtSa3q3ySbcO8dJSf7k6G1omvH2Ic9SpXw4OC7CFpj7x5SICXWArIMjpBE/9rvgC7tcQvs0TUB2ryFsQ5XtnS1gV4GnS7KOePTlp9oD+OnGWd92D9XnBMLWB9rrhoTmVDVC+lzuL2e5ESnwBWSDOFKzD7Waa6w2gADU0PTi50XGkSj0t5GR9wKQaHbgY2we5t+YxGF20KqxOolY/XSHNwlIlu+fPmCyupxWY8fuEExxMdIbRbPopoMp05njzqly0a9qMymCq2BH6dq2SmAvplOgtSqQtVsRqGUqfCReLintUgdG/+mB3JbEj3tIaKQm57MV0slJLSdnKbGyoO46hZI4fu3PCTySM5vmNflUEqmguZ0GJ8D7egU7pViu2MYpvs/seW0pusukKvkk64nn0A2EDth9fU6YMP2yW46ahs95UP1dMt2EfcoZvZ6iiGuMtuE8lQ1QYcAciP3u0kgll3cnj9MKC5jpeo8KFGQb4oiKuClv2HNZS/pqKS33d9fXmVz6/t8kZ2WVu3rpDaUmBP1IjyWqKfZ5NPVvOw/yD6I5oIyRE1nvdivOxY6Znedz8qs9lYSw6pLAG/E1Z3EgOAQnoy1t+nah3m7M/p9NWfm7FOS/laNnBwhS4cydnwqkaKB3YEPI1mzh0X36R00xoL9pCeXkzF4QsUaTJexVEq8cZ2h5nDJax76g9sFqS2dcon8CeTWVC5EnpG09ThEqqwmOigYVRFqGk9OOEbDHE8VBcMaeZCjqwYS1GA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ba2753-4786-41bb-45d0-08d8906338a5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 10:25:10.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ylg9s02POudX/IAAvQyHS7YAv+Wcnj2+UmPnXkkxvJt6NNodbpr8TbE4t7WIgdTSfBGNEdodjAGo4r3kQX7yqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6648
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series is a continued solution for the issue discussed here:
https://lore.kernel.org/patchwork/patch/1334670/

As kernel doesn't want user to call device_is_bound() which is removed
https://patchwork.kernel.org/project/linux-clk/patch/20201119114302.26263-1-aisheng.dong@nxp.com/

Because SCU clock-controller (SCU clock protocol) itself does not have a power
domain property in DT as it does not depend on power domain, but the sub
clocks registered requires power domains to be ready first.
We export an API for SCU clk driver to query the status in
order to support -EPROBE_DEFER properly.

Dong Aisheng (3):
  clk: imx: scu: make scu clk driver depend on scu pd
  firmware: imx: scu-pd: export SCU PD register status
  clk: imx: scu: defer probe if scu pd is still not ready

 drivers/clk/imx/Kconfig          |  4 ++--
 drivers/clk/imx/clk-scu.c        |  3 +++
 drivers/firmware/imx/scu-pd.c    | 20 +++++++++++++++++++-
 include/linux/firmware/imx/sci.h |  6 ++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.23.0

