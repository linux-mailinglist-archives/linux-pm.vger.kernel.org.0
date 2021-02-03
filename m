Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE2730D7D1
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 11:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhBCKmK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 05:42:10 -0500
Received: from mail-db8eur05on2108.outbound.protection.outlook.com ([40.107.20.108]:1189
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233684AbhBCKl4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 05:41:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpCz3piaJxcK93CuT1Ym9WxIw9o0kzKnsIMDJx1kSEZjX7rwr09kdmB/lbLkl2YF02iXlZT2JWJJlAz/jQXZh9wNKmkSFinhviU5B4EVulUaE0il/AUy4zFhoY7cMx8i+JuWFexlcbhl97R92MCvx6orlTX/fH7aD839qgze5CRjuyD3W4xnFZKg5g2YBfQyj/KuC1fqgpf1kl15dnFhJVMcbuvT7KO59VXcs8Rg+fzzUq/tCa7ZcHP7yy1NbxG+wIkeM26qPqwwCW0Lyt0u21FekfM1SsrTU9eJue8kLh6koQ/xgJRoOUIxXqNRgaG6+z9QWirwUuhcnA+G484XOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfCXh+RcYbFuEIQ61QZQQk+FIG++foXKTyK96xJM3n4=;
 b=oYDhGQwTLLCuMKcG4Kqwg2jp7fbeYP9TdbdO3myQPE2n4ncLQEM+bSRzfyAuVy59jGsnwDcpqG/FFu1VTumL+HfTnHwLT+MXkUdf49jystlidIU7RAjM+JXnsqakZzhmp4/hkZPakl+whMQG33nMtKx+pnFgdI7SzBzLHXA/qpiWKefuqsFqfwqvPIOm6UWhucfCnjUwSZF8mQvZgXFmqjbgEOT6LFd8l20qhO/oAjlSt8mWZ5548BkUO0XkKO8+1N1EouA2RNIK43CFdTaaiOcaadxVsp5UVg24DymVFEbDqMKoJdJ1Ybn7v6JxKlu8GiEg4wVmUTwgnVPIMqmSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfCXh+RcYbFuEIQ61QZQQk+FIG++foXKTyK96xJM3n4=;
 b=VNQuyWFA70JN5UKngKMZU3UhJvg0Lc6vC2MoHeTsnpk2bR/yPixW1Jn2uLEsNilkxo0jK2mVAPVWkyu+3DS1TPcpx2HoZ/y/5BG6Veugi48K++8VdfobAGYf0Dnhj8hbM8ECSOglReU7RnyItLaFHl58wxEVlhlvnqFpsX2+abw=
Received: from AM0PR07CA0019.eurprd07.prod.outlook.com (2603:10a6:208:ac::32)
 by VI1PR06MB4382.eurprd06.prod.outlook.com (2603:10a6:803:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Wed, 3 Feb
 2021 10:41:07 +0000
Received: from VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:ac:cafe::5b) by AM0PR07CA0019.outlook.office365.com
 (2603:10a6:208:ac::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.10 via Frontend
 Transport; Wed, 3 Feb 2021 10:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 VE1EUR02FT043.mail.protection.outlook.com (10.152.13.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 3 Feb 2021 10:41:06 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V3 1/2] dt-bindings: power: bq27xxx: add bq78z10
Date:   Wed,  3 Feb 2021 10:40:59 +0000
Message-Id: <20210203104100.17143-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203104100.17143-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210203104100.17143-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba730599-8970-41cf-67b2-08d8c830367c
X-MS-TrafficTypeDiagnostic: VI1PR06MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB438280C7E2913E81A4B8FF24D7B49@VI1PR06MB4382.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +t+pXFJUpjrqx5yr/OXXmt7pacwMN0fjymyen6aylMbg57K6KOr3ZFKCVyOQm4+Yytp3CsIl/lcI6obswcEX3Lu2lW4gRvV7bd+wfWCBMAnrzM/ssCNVHPfFatoVgkPqR8xu85nAIqo6D21i2Xv1f9Ay0rddUpVqWAywPM/Wb2blBCYTbRfAArOqnTceo8KHtazLevFu9nWmYScOjpBrxIp6EGk6GNhLTcvJfOh8kdZq39Q8NyHvQmjqzvzuyYVgf7qhUb9SZc3eRY+ghlGECOPh1uLLHm7nVxT2EkDVjyXNaOcqUKfXu2W4HmNjVxhRoUxyXovXHPkLrxOmRftoE1NDkcPbDzR1X77lwXtXe2DduuFPiRQIGIVWMdMGHPe363b6FVji/yg2cPmuVeCh7ISJ0hpp3M0Z8nBLk92dnYb9MR7tltWcHlS2V8kq3ofoWXyl1f7RZniNrQC7H+DoXwlDiixGegiIThrbHhLrNHDnbnyNj/2zZ6F91yCAgmb2wSXauRofDK/V2dT/ubF+JvyukatWg7p0/MkRf9+4k5FmlzOI8+ogTLfdFYmqzN7j91J7GTIvbYObwXMSIDUKMyZqoFewo7t+IIf0uxKRCAh18xvenbQ+Xr9tuzfT6IXIXtw9iKPOtA+DDfWRaVIqA5bJM17luh2pb3uKHOW4vxDLW3ewWlyG67N2TDwWCzrLtIkX8oHnqQWOWYOAhj6WgQ==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(36840700001)(186003)(70206006)(26005)(47076005)(36756003)(82310400003)(4744005)(5660300002)(316002)(34020700004)(70586007)(2906002)(1076003)(956004)(2616005)(6666004)(478600001)(81166007)(356005)(118246002)(8936002)(336012)(36860700001)(8676002)(4326008)(86362001)(6506007)(107886003)(36736006)(6512007)(82740400003)(6486002)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:41:06.8434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba730599-8970-41cf-67b2-08d8c830367c
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4382
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for TI BQ78Z100. An I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
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

