Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D410830BA47
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 09:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhBBIuV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 03:50:21 -0500
Received: from mail-eopbgr40129.outbound.protection.outlook.com ([40.107.4.129]:13956
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229466AbhBBIuJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Feb 2021 03:50:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjC25kUnRf/3YKXhpDD/lA9OyLw3p4RFGqg1bHVD/LlAiuRbd25+/RF+MTKniSkDOiPMu79hLgt6KeSBBT8LeXDYws/d141+JMgHQ+DAA0HPHDaM/P7RZ1rFRizrbQeRmKB6nDABRsjgmIC8Xhe5gQZ/Wru8taoIUaAZzFQkYwKfeyWxzBITnI3Kp6xlWJ/3UdZvj97O+2VMa8Yfjf7rqy2ulpOZcomvF4b32/yMtzg0OYNUP+84r0ZyK2/bp1P8D7cRvq5RHL36pOUwgfV7FncpUYTAPqjzicoarHDivK+sqkYvyK9jvsHrZIjRYqyUy4Mg9Gf2BObUZAMfRqaD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqNGi5jQXd9nHwbz43sbBaLKwN5DMxi6XaPTmIGHHxY=;
 b=TioJ2/jXeZ56TjVBlwpmyC0v3xOL5RTcKDlrfuYWJlGEn8CLacI5czgGOaYPG+Qs0wFM6bERy980Ml7sOIsyHc0OC9RbxGCOB5ehwkCPFhv6/2PLZZxQhfCJIx20P1+BjcRuiXxf+atTEzxUn+lmjyWKUil3AeoMmdxSanjsWYbzmHrzz5NfMxB59wn6j3ofD29aoDeCS/edTIjBiQ2sdM1r0ZJLmohP9yC9UD9e1RrTUkC1kBN9XYVp0UjmmgeuK0hRnDvPp6psr1DTHB4LdkXrWSBF3Q011IRMnslARqXoCJuaFAZw+VNVfHwcdrBOYHk12GfFI3D+tOZ3MN4C5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqNGi5jQXd9nHwbz43sbBaLKwN5DMxi6XaPTmIGHHxY=;
 b=RmgIhB70R2/EEgU0rH4x4YW/dDetHfkY7MAvSqYhue543YhERhWYBISRv/sspP/aCiuRL13FBhZganzCIm3XxyvqvYsvascl3o8SsZljHTOzkrsP2rnTwmX4eXuqIlYfhOov68g7QQ7Z78RfMjShL3l8FfqwZnTvF9Unm607sQk=
Received: from AM5PR0601CA0037.eurprd06.prod.outlook.com
 (2603:10a6:203:68::23) by VI1PR0601MB2384.eurprd06.prod.outlook.com
 (2603:10a6:801:c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 08:49:19 +0000
Received: from HE1EUR02FT042.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::4f) by AM5PR0601CA0037.outlook.office365.com
 (2603:10a6:203:68::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Tue, 2 Feb 2021 08:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 HE1EUR02FT042.mail.protection.outlook.com (10.152.11.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Tue, 2 Feb 2021 08:49:18 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, afd@ti.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V2 2/2] dt-bindings: power: bq27xxx: add bq78z10
Date:   Tue,  2 Feb 2021 08:48:58 +0000
Message-Id: <20210202084858.2944-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 40dcb66e-7071-4646-03ac-08d8c7576da2
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0601MB2384C7D9176F7511B5F08502D7B59@VI1PR0601MB2384.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCwLqso34WZl+TN/6zkkm3rSKe6Tsz9pV7Jc3NhqKM8hWTom3T2CtwcnYkT0iVIZjnkGoEPCJlaDD64j8Y1YO2TrQ8+VmPBPToKsGlyVI3VXlByDIT21iryIu5oleg3SDv1TYIqRVUsNJrV4Akl452/8MC7kp6NAF3RO7ZSrGmOcI4TmsAne1Q4KFtBhTWUEW/CgmW9dytxFu1xMmi649sDX5gpAUE4AgcwTKQUZ8etA/+YsDwAqNjLwAHURkQg+JRVEI1QLCfss2RNbYO7CRB9xochMbR7pxmpNxSSPZEYqM3dWUVl7XiNAWEU+zyqdFCFAx7NMvrPqZcKmnR/d699QfW3YL0Yan9kDw+a/APyeQjwXVfp5rzMNa5TkUDFqtqKAJmH/lTria88MqgD28K6NlwiyFl/UhXHMXtFtvpZvcwXNALsqSHvDqhEXq/ngYM7ahGSIpwkOPqe4v4QYVP3gMrf4HP66YyzwnYLtrx0WZ6tXxoPfekCZZJnX9Ka/RpQ6x5BLhVKLJ49DluOPD44lZM3INz+Eru/94Xk7ZRThY0gLOgKPW3JLPKuPTfoL5rSVEES2+iAWgrBgxjKSmtXJsmf324MChEa6HWoAI9l3QH9VSsICT4rNB9ZPD9vnx+4yOYImZ1+Q9CkXxaTDWKhWSL4X3SDzYZinoQ1JJbOjG24I/CIBC14jXnPbSFKqNhsKlRe5bwlKmS2kxn6l3g==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(36736006)(107886003)(316002)(478600001)(8936002)(86362001)(2616005)(5660300002)(34020700004)(36756003)(82310400003)(956004)(47076005)(4326008)(118246002)(186003)(8676002)(6486002)(2906002)(70586007)(6512007)(1076003)(356005)(82740400003)(336012)(81166007)(4744005)(70206006)(6666004)(26005)(6506007)(36860700001)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 08:49:18.3623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dcb66e-7071-4646-03ac-08d8c7576da2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT042.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2384
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for TI BQ78Z100. An I2C interface gas gauge.
It provides a fully integrated safety protection,
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

