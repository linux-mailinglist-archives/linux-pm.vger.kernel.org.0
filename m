Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE632E281
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 07:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCEGuB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 01:50:01 -0500
Received: from mail-eopbgr80111.outbound.protection.outlook.com ([40.107.8.111]:53025
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhCEGuB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 01:50:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njtTPqAu1wb9zm6OUm30yiaQLFw/+Ge1n8YgC4mFYR5yNU7irfyjN9wsDIQqKDENe8f2uaqR+qaDD4bktIubKNZFKnSCgBQoyQjip/RTsqJoCCquZkRhA/JlhAxRKdfnr/+gljTQOANoXK+6FzavcshxBKrnkCOI9JenSB91dwkLYOS+bP180km4AOCRGcu6Vs8lxKdKhfhmxMJrpjDOGTqnnWDkL1wGEfJM9YSW7HfUfhx6wKKEUv5srcUOAtu2KxTO7tOvu8cI3BiDgjqHSsB8uZJo8HJaxrCYybvLQsBvUxJN0M63otaa/byHf0vD1HDOUtTTCVam6di5xqTjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE9+g9hN2IiubGClb8wgUDvHoI3ElbQWxxdk/CDCKaU=;
 b=XlILcr5N4oAo0z73qWRl592N6ramIT3FTWugNR6zPF0lfR6lNnamiuJzR0jhLZ47PA/CLc+L5yhVnRKHp5kHiQwDd5fIAMPTGfMzEObPE7ZgECuqKuaR7AW6LT/Cld+SzpKgfdINbx1P2lGJxBsMd5vuT6mXRxfpwgOOcA6QNSW196+Rym/ty2gbvvGgcsZIy1lit3WHT3ZoGVDCz6Llyi/c09kQqAkQ3Z7fnt6AvT8gDh4q5ikCFVy6NLSSDAmHkj49VRB2OW//DFEDNLmIiv0WqPtFGnflFEQpkth7LiijHn4+aUDsM+x17DopodkScMg0vHqpiD0nUQYPYFUNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE9+g9hN2IiubGClb8wgUDvHoI3ElbQWxxdk/CDCKaU=;
 b=SVlb8/OVNTrrB7qLEpMF3p0UDGY3Mt8wzlW2lWe1XUyb5ysGvKPjHoHv7DW8I5BxQPh3nMxBCfB3XCP8rTye2z6HDjzA2xWe20TkKeJo2K4AkuoD8mAXHfgdtgqmwxVL4qHXVhUz0eaXcBJHQx9Yez6g7FkvSidIzCt+s0Xy/xs=
Received: from AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::11)
 by VI1PR06MB4477.eurprd06.prod.outlook.com (2603:10a6:803:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 5 Mar
 2021 06:49:58 +0000
Received: from HE1EUR02FT024.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:17c:cafe::8b) by AM0PR10CA0001.outlook.office365.com
 (2603:10a6:208:17c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 06:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 HE1EUR02FT024.mail.protection.outlook.com (10.152.10.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 06:49:57 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, afd@ti.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.reichel@collabora.com
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V5 1/2] dt-bindings: power: bq27xxx: add bq78z100
Date:   Fri,  5 Mar 2021 06:49:48 +0000
Message-Id: <20210305064949.2680-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6052818e-9fbb-44b3-562f-08d8dfa2e3fa
X-MS-TrafficTypeDiagnostic: VI1PR06MB4477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB447718FBF00AD7BEA1909E0AD7969@VI1PR06MB4477.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTMKehSHCxEuQwdNcBxivetetm9uf5SFhhPpohigOweT4/Kg5Gs0I0U3xhP0+h/W6eUQZ7eRyDwau0g2kY/3Ka1zseMrR+ZyrTXw9WhKvhowIphqh4tizWrXZgXNmS9L7HLfbS3ZWoNuCHaGyOsqkwSPuDjvuibyuBXAO0o6a3wcWybTpAD1XUY+WRwcIdJkCkC4cDS9NQeduQUsI2iwtcjw9lLWlDg6Y9317+qHxhNjE2CLWfaBoMGuKzmdqMVxAhAhlgyTOHd36dW0wONCUCKU/HrJXFEBa0QcG2ykjA7jm2CAUAPs91xVd2Tta6aDLwJm6QYlp0KGWx6YvsFU825VmoZ3lSy3S36ybOsraqRcMBHW+0f5iOs3T+A9Ms1AQGuvgGGh5j6Ktl+lsBhrVpMylBZ7c4XdVRnks+2wizCpkpdxVuMzJBsmmU/VsyeKkloGnckNqrFzrmJn63PweQVkaMa/dszDY4LdmPo4ehjt+UH0Dh8uj4otCNqJzIDP5yD7vGdHP5NfqI0FcRHx571ZXIe2K2DllULSE8f8VG4UoDOz8bpeGhX0KEZ/wEzfIU9liBfHQhOBV3R3c/+FEAZrooBH1d7rg/6pfMJzxOtrCVhAwq7nQkmsUkOkZ0hNDfMA1XTgeCwIZU+6E92qqU0kPdi33jqdu8QPxRERJBFLcS8GjZOqyNZavAcB3WAdt25rYw2Y24T6ibZS1LTJyg==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(186003)(81166007)(82740400003)(34020700004)(1076003)(5660300002)(118246002)(356005)(2906002)(6486002)(6512007)(6506007)(107886003)(4326008)(2616005)(8676002)(82310400003)(36756003)(86362001)(316002)(4744005)(26005)(6666004)(47076005)(956004)(8936002)(36860700001)(36736006)(336012)(478600001)(70586007)(70206006)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 06:49:57.0557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052818e-9fbb-44b3-562f-08d8dfa2e3fa
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT024.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4477
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

