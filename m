Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58402C22DE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgKXKZZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 05:25:25 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:15428
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730944AbgKXKZY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 05:25:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9GnD1cvP8eL4fUnZKSsr6aiQRc22l+zzer6GNF+6yPkLjRKNph0IkrrkknEwIY4qFq6UKFeg51FzfsQlVhWithqK1HATcsajuBjilHNq8dlt0tOk62h0uJaQCMqzY/ZMcg5SzYzcESZ5iSu8ya/7w3aZEISpGoYUuuAqqdGiFdQ1aT5J0gBv3bt2HBMqf8ESB6g16sP9CXSerpbLHx6L8Z6IdvoOaCMonzxOc+L/m+ipkpwVMfNXHyii4dG0Xx4MNO36E9vZIMcWbW9TJc3y+S0bC/u/5O0uWjgLeTloKkXfsAZosTDndg1y+xD+qoq8P339Ra2/OAoNCLS071Nnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvMRkDCfeNlAPS7G0tVx4+aMw2Oy3sipAg+1vj9PMxU=;
 b=m7H5W1vOrnlNSWd8O1pIDY92MgxiW6oeDCCbWakcogG+A7dZ+6xcFlKrFA4RFIwPZIJH3byIUM4OjQduOywYAh0xkgZYZz0Cs7vVloO/uTAI+cTv4pCpkFR1JWslZcV5I/lwqgfAqUwkewtZBcfRlwmRb4RF9wgBJSAQVNlarv0ZgZbB+l7B+A7R+d1lEt1SAylU/TO3QIzFDiIHfqFiGdmdgfNRxlut/flgfp002+rBNlVdw1OlsiEOhE2+/pt6+4XiJepqL5D5a/uC1PM0+gHHPphAuPc/7O0zlNrUGQ7OyJQCmxjgGwcp8aFtFu8mp5uOLWDpqYXbA9BOUE6JXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvMRkDCfeNlAPS7G0tVx4+aMw2Oy3sipAg+1vj9PMxU=;
 b=hKr6Dho5ZyBUzrHPnzVhAmJkGFvZYNsNCHLfViuZN1k2/b0AIEWqP5hgWxbwejgzEGeAH9g+Y1HHg3HdEvyzrr/+CqVSyOQzcMs5gJXh4J3gidYTkp3LhIKoehBgYLatcxYsMBtFEBSUokUfs6LbMnz6YlG6a4Uia/0vDH4fAD0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3669.eurprd04.prod.outlook.com (2603:10a6:209:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 10:25:20 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Tue, 24 Nov 2020
 10:25:20 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        sudipm.mukherjee@gmail.com, sboyd@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 3/3] clk: imx: scu: defer probe if scu pd is still not ready
Date:   Tue, 24 Nov 2020 18:08:02 +0800
Message-Id: <20201124100802.22775-4-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201124100802.22775-1-aisheng.dong@nxp.com>
References: <20201124100802.22775-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 10:25:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1370c00a-911f-404d-51c9-08d890633e60
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3669AD1C01162238AB02906080FB0@AM6PR0402MB3669.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayva5iHH5q3OHbJcC7NstcgaOCO7AfOe1R5W1cUf4FPDTzbDI6RP8yGamtBzRAYzgDZgpEKU6v3BP4dKyK6YCX7Gp2HkO2PMYbN3DKxJcsfsDiYQtuRNW3GgWDEieeaGxMeERtsOVaZ7d0nIdCwKQwx7cbpkmbnPteJXguFmUqr6amGfyuPKX3HJg+PqrVD3zCtcicOzInbp01up8RAIRrBWqlBmJw8zEr+uUUJ1e6SP7M1rjL7pXFmyqo/3bhUWVj/egyGy31igVh0ghNiF1tUTuq/Zu5hSfTPD8PhfGNV3b7QqxAupIADWPINGUjxWqnIqYsugdDvBf1CJczf08g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(36756003)(2616005)(8676002)(52116002)(6486002)(6506007)(86362001)(1076003)(8936002)(956004)(6512007)(4744005)(478600001)(4326008)(316002)(186003)(6666004)(83380400001)(5660300002)(66946007)(66556008)(2906002)(6916009)(16526019)(26005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IXsyb0y/WwzbS/wh59hjDQ/W0mXPM7c73Ik7f2LNjKG1YsLFN5qRr63pAcAjAP6/TwRdX8CB3/KEzrrXd9LCebYbCZUELLwpRbxNrSwFPX86hz87Lz43pfim1hg49A8+3X96mzGtYbzVayQF88L/sv2MypV3Sbq0JinXw/4R8Rw/q7KWM02y8PPIYagZUx8XLsXmWWz9BiH3YZdqanB4yQePsHpnf1ttuc4I+FRjV2yCNNRWVksRKXmRKPxCO0glnsxkZvnM2vNL5SN10l4fcBgVsCG76mfN5ciXLWcPxhsQ7hIMa5924gcPn9gwOp7tx+uyL6D+16+/uXzj7ntfR3EHoFB7KE3bbX/WY4o1I0RvxOTSSbuPCQ/fD/6acdX6oFLhmoIIV4E0U4X3kFrJG7n7oBMIqyt3oEHy7DnQ1o9lnAklUj9haJIMiu7KDIBdPPhyt+LNu1vwzLT9U77HCaOfWNBjhJ562XIuQo3Dr+iyC+SHlGqvvUThP9DxJiup1xqCxxY/4WO9VQs9XrfYeQYRGi1T4lKgkFT//OfPrn6SXNYbV79CYDzNc1SWhDwSOwy8ZaNTxn9XPlPCAVOMDsz4wM+D+JgDKVjEGuAVH4NSFeLVdMoz39Gnlt/gWzPAqJT9r61YR/gb/NJyPp6wY/rGy0fSoTuYBTSOZpf7A2gKAnfn/XQgR49OnjAh2XYS04JUJSBRcDlp4z2M/8jp8pHbt2sH0l4e0sQHK8bKNBeCpaUiRc0UG0e59ViRS4qWHLLVm3WqQVYPiddj4yGUNySiDhciqdk/b6JPFgMte5shUP+MuFOTbsfw3aiIMSZfLpO0Mw4xBEQZeq3muvbyDQ2CQxiwpKwfquhqcSpkFc56Bw4l8e4LmgSrsMiBJf/GH6pWgC86aS6Sqbzge9JHlA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370c00a-911f-404d-51c9-08d890633e60
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 10:25:20.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw31xd8vPBxRWLAS4Egwqq6835Ji2jfC2hb/qtEyzopT+O+sIsLXSvn2TdFmQJh+hOKC8iZyj8lcm0lzfuBSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3669
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clocks registered by SCU clock protocol driver requires power domain
to be ready first. Query the SCU PD status to support -EPROBE_DEFER
properly.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-scu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 1f5518b7ab39..846201f9b72d 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -163,6 +163,9 @@ int imx_clk_scu_init(struct device_node *np)
 	of_property_read_u32(np, "#clock-cells", &clk_cells);
 
 	if (clk_cells == 2) {
+		if (!imx_scu_pd_is_initialized())
+			return -EPROBE_DEFER;
+
 		for (i = 0; i < IMX_SC_R_LAST; i++)
 			INIT_LIST_HEAD(&imx_scu_clks[i]);
 
-- 
2.23.0

