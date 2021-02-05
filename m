Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27211310598
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 08:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBEHLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 02:11:15 -0500
Received: from mail-eopbgr10096.outbound.protection.outlook.com ([40.107.1.96]:5477
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231337AbhBEHLC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 02:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD85To/HyAWFR4hsOGWLDzs+pqTagG/NJLGiYPLNLKvXJ2sZyeOZm/B9bP9efO/TPRL6mCA1W5ISL3oSUgC3P9MhvnvGTLLeKGP/lz5Z/cPuym36uxOtOPkIYZs55MvSSvHxxfIIKWhv9Qh+W57NPe/Lx/Pqf0S/xEM7wet94tKJSigOPEES1BT20SAT2F49X3Vgyp9jhShnXs4H1ldbC5zEk9bMpK+1MGMk5H4UmzqKU4TUH0ygCm2KpSqALzf4qGyqX1TD0rH4jyqLbowaOqc92IFczsI3jM/NFShJ9CRlwNDSLAykNT1J7hpzGsws2tVoOJWuVn6BO5zDUc6+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE9+g9hN2IiubGClb8wgUDvHoI3ElbQWxxdk/CDCKaU=;
 b=FN0MmYaSS8I6zX8XFJgRqYOeYVOFVxeTyuu9ebO9dy0wEYXi/ZLwjBRvmjz8Pip3vmPbaXujzj6GklNi9+MAWoKP03Xpbxz7sTCjxENE+JMogFax43yuiXLHHTzS0Xsqy98vQdISrXoy0eKkEfJxY68YNTBNqiOGFlUwkng8UTGIP0jLijYy+3sorEn+435Ztv5GhxfmM6MXFGs0CTAH5CTMFpgue0jSEaVogyL2nBriJ8ndTZ2T2qi/JVI107r3D/ujWX9XYjZQyi+XS7NmFEJyPm7wqC3c5jrbOEd4Nk/CT5PdNZp7OdHe+/VntfSlDpW/ydwvIWe9j4DUHZf5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE9+g9hN2IiubGClb8wgUDvHoI3ElbQWxxdk/CDCKaU=;
 b=MOEAx3MfjUKruCmjkm8Ba4f92VploBObmI2CiZq7PSgyHeTOegujAtsRsXGQLB9I6hntTLa2s0eIE3i+FVXEIfkhdb+I5pz0l4zBjAmzs/Y5nafikwUHE7xJfQHQOdOkVFaQ/GoIXEsy7ATQ2LXICTWmoOeHVCzHVZBVyiUg6MQ=
Received: from AM6P194CA0078.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::19)
 by AM6PR06MB5745.eurprd06.prod.outlook.com (2603:10a6:20b:36::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 07:10:12 +0000
Received: from AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::c0) by AM6P194CA0078.outlook.office365.com
 (2603:10a6:209:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Fri, 5 Feb 2021 07:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 AM5EUR02FT033.mail.protection.outlook.com (10.152.8.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Fri, 5 Feb 2021 07:10:11 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V4 1/2] dt-bindings: power: bq27xxx: add bq78z100
Date:   Fri,  5 Feb 2021 07:10:03 +0000
Message-Id: <20210205071004.26317-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d35f5b9-e89f-4b01-6f42-08d8c9a5143b
X-MS-TrafficTypeDiagnostic: AM6PR06MB5745:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB5745EDF907A085CEE6AB9EAAD7B29@AM6PR06MB5745.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUcDQ0LUbUCh24Hx8pcfzUPg8LGYj3Q8CN5EXXgZNZAHwODUcAhT2C/FS76fdGbMV0gLtU8homEpIzbEFeuiuBZkAuw8yC9tYiqhne/7UjRwcmIi7DxCUwyxVjlRSNJTGIAcc0dfigbcSfdHjX9WgXln6ws0ScVPY14DO74khzgedkoDMCxU7lT/qTN+4gjS9bja9kEvr9eqj42vf9tQjFv3HOSz3stuOMsgcfTfTVd5w8FZF9yJApoeyJ0yqdhbLSjXCyIbPrG1sJH4VIU0B9/OCLP+ntUqegK182YIP6jkVENH55AgWikIST+cufR8rqheMf4IWq3WDP5KIw1xnUbxuW8NCJyfUkcsAe559MIb+cVVMpI8B+s3j6x1WTUkXSCBBlNavcCZSvZHTz2C07zwSIux/mCs1vckIP8AbWCyvyUS/3+JpGnhHdxoDiKr/mLsuT4W3QhjPeoUMiOA6c57f7HVFWXd1WjATbXCfq3EwGlXNHlhg1Va857d0BQ6FQWUsxBz1K3Qr0QiGCaVOui6NYqdNsOD+wW0J/7YBjqp++fZaidtGIsM8vR3Jbr4kJ3L/X5pVngZHtaTkUb2IvE96qeaJVOD8vwUGfcnApX82KKOLErsg20lePH7f6rSjDCaRBKAPhvSawI2RxrUW0fykLP/Row8uzRC0BucKbpZzxPKXPz8twAgGE9DjKKQ1hb4X4NG7NKEXrhgCFFCmg==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(4326008)(6512007)(118246002)(6506007)(47076005)(5660300002)(1076003)(336012)(316002)(107886003)(36860700001)(86362001)(4744005)(26005)(6486002)(2616005)(34020700004)(2906002)(478600001)(956004)(186003)(36756003)(356005)(70206006)(8676002)(82740400003)(36736006)(6666004)(82310400003)(70586007)(81166007)(8936002)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 07:10:11.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d35f5b9-e89f-4b01-6f42-08d8c9a5143b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5745
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for TI BQ78Z100. An I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

Acked-by: Rob Herring <robh@kernel.org>
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

