Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF82333EEBA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 11:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhCQKtx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 06:49:53 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com ([40.107.8.93]:40223
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230204AbhCQKtX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 06:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg4iGGiHev+okxIw4+cLrSEDkQZmGJWXwDhfrLht6Lt6O2Ksdve7uhz/FShBKprkD2rBCPpwTJKICjOSbCbYtt1hen+qR83mWgzavDPaXIZVfx1lZHPcvGUUdm9Dq7Yhje4bC6DMVL9BiygKniww/sqj8S4ukmzW/fcghsL1OTGYB9tNrRTjD2Tay4ygHrLgD3KE8WGAEounn21HvJCfyEKXpJfCpAGxuYjg8KheJnpMDC3D2qXRtfnD1qI4nUAwH2cppVDBjwbdSTqm/jUL0ryazfZJjE3uK0xFX51V1RP42sNi+IlTem6rkbfzWyNCuO6FOPz4y1WjLYMQJ4KEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbC2OegmYwdefQLx81b88zz3zFthmv+7pbQLoxOC4HE=;
 b=iJrFnv01/E/NVJVNeKHI2ft2+yEsW4emvzf2rK57IKSKTFF7TY1TwpNkVIZlJoKXd+Fg0MuSrERi9T1mnMB/9XWP0Fq7WjTciYmWyX6/XWPst4zcHqQ2CWECC5+BfcvTUuuWlamZ4xyNqv2kNES1LdTig/XKDre6NwflTetjocseTHTmU0X5i8NupA0KyDdwB4U3KS+SNdD5cTb2e4DpI7efvytKSRnl8Ug2jZSuCNjgKgt2ZWtH0J4KtHae2giJxoNik/lrviHfPOz4pmXntVB1ohIs8A8/DBTK8H2jBIBuv2tgQVEUi6SH00eRhQRlFe9vxm2KRmoZ+77zf0qHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbC2OegmYwdefQLx81b88zz3zFthmv+7pbQLoxOC4HE=;
 b=aBsFpKB9UQG0f6olFgiIapC1DEM16DUXqE34Ow7ajMtLTcTM4+YeQNDRqq/vSexlx0zF93sj06f/GyvRmjiXIiRhZsdlrjLHiJo93Djiygt/hZLKUQUG3HtPGqI4YCeKIkZPXak/8kiBZQA1tAIlrUu0eHuER8r9XtE0YEC6FSc=
Received: from AM3PR07CA0082.eurprd07.prod.outlook.com (2603:10a6:207:6::16)
 by AM9PR06MB7249.eurprd06.prod.outlook.com (2603:10a6:20b:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 10:49:21 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:207:6:cafe::25) by AM3PR07CA0082.outlook.office365.com
 (2603:10a6:207:6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Wed, 17 Mar 2021 10:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Wed, 17 Mar 2021 10:49:21 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V6 1/2] dt-bindings: power: bq27xxx: add bq78z100
Date:   Wed, 17 Mar 2021 10:49:17 +0000
Message-Id: <20210317104918.12323-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dc0e6857-2d4a-4b6d-04ec-08d8e9325286
X-MS-TrafficTypeDiagnostic: AM9PR06MB7249:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR06MB7249F7F2A958327353A9F04DD76A9@AM9PR06MB7249.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OTscO+LCbzA/QzTIDQ1bJttl9WLgLZVQC0xpP++DY2Xz+DT3bOMFxFiUHjBfVBwNweeS1+fQzj4wXZGBI7UZFyO4WXoNhyPQI+sDSgNRZA0nP6kheMCnQ1b1rcfgoshvBDfxQLR6uc5nX8XXvurYdPgoYplLz34HORx8UjY3v+20yIZkNAO6RRL5k1qhlaV/vZLup98Epb+woq0+3nSSF80vwmsiJwHqUePFUvC3pP6X3Lzy5qP4OiQRktLZDjR51QPDoaP6Qjt39+WzqYhBD7cJuxveRJsKU4b5UcRUhQXscLoDKWGm1KNy8qIlHzl7+LcVaOOU3pXGLd2cYGD9sunZAbBzCIWtOHne2J8hjQmPyezLHLMuV040dcDeOfsabRoUYgt4uq8GRf4TgtoUBK2VAuET+4Vdk/47tZbB8MU0P6wJLlhmnTA4baSKJROVh0sloiBSByWtN5IKfCcY8jmXX8Ao35dB2jthF9HrrS2gaZr1mYqAmhsdS7S7bKi1WON6pJSctWsMk7qKPOZl7UDaKtc0a1kqnXtzYHBoReoyN5xYQudl3OP/hXhM77+vm5BIrrGZEE88QuBH4pAttFV63SA6ghwACa9bZcx9gz9LQ9z8y+xIOW3DwUIg8i8pA7EE2bISpvYmPQWhc9CvjPJUPhIiKLheFpkhaIaaCBY+XsULTFb9LfVAU3j0nim
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(186003)(81166007)(70586007)(336012)(316002)(6506007)(82310400003)(26005)(1076003)(36756003)(478600001)(70206006)(8676002)(47076005)(2616005)(36736006)(4326008)(118246002)(5660300002)(107886003)(956004)(82740400003)(86362001)(356005)(4744005)(6666004)(8936002)(36860700001)(6512007)(2906002)(6486002)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 10:49:21.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0e6857-2d4a-4b6d-04ec-08d8e9325286
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7249
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for TI BQ78Z100. An I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 45beefccf31a..712e974b28b6 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -52,6 +52,7 @@ properties:
       - ti,bq27z561
       - ti,bq28z610
       - ti,bq34z100
+      - ti,bq78z100
 
   reg:
     maxItems: 1
-- 
2.17.1

