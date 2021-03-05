Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011AF32E27E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 07:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCEGt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 01:49:57 -0500
Received: from mail-am6eur05on2139.outbound.protection.outlook.com ([40.107.22.139]:18529
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhCEGt5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 01:49:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBJ+kkVN7HPbIcdonWD/MCR6moMBiNzPXv6+Oefd9wK9LV/EZpiLGuAMBpmLsHPB0gaNI2CkIeUqIOqjGfGwBFEHQeo2dVYUrtT5PUnKA4ossAjaqAWhmuR9JiabgY4ADucBHC0M3uz9s3mYdaPa9QpzNGy0zvQXQyJM4TmRb1HuqtU5do7c24EBvHA+yN0Pp/bPhSJD0MqSlhWvZIEZHwy8AYfWRzj7QM89NS4+J+cQ+8y2BVc1iIxViUnbIi7YAXC1vBTOr/0hY72X6WaPUVrQvI097uj1QxzNd4Y/rLxO6pfe+v/mezGKaFXezUlNB3LtmXRz6wtBZyTbP47PWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D4Y6A3L1b/4fDlF8P/+IlLyYruim6Cgd+1WVK4h9Zs=;
 b=JdpUYIq2haFl8JCjqSsKZWUuQuRGcCYd7T6ZuIS2ivsUTfFBZdyyC9MEsmzHLy20X9b+Z19jzFl71Or5KbVctMp7oVL2OHGO3GPPLgk73PxzDdHGGTuyrS6wbxzKUJsmKepy9T2z1O7SvdcMCLsNgSWkXm/sF0MgH7pQeqyiap/RJIGvC2SUVy8Qw0cpqUC9Wlp+vAZcBKsBFQuUOzVWkEaYEpKULOYYZffRYCZvFRy/vKm1i9VJvLzJBebrFMUjO2Iz6Ff9xVCYkhqJZIvAPNxpo+WJ1WCNMh6q219Tp+ZB/ZiE9hFoIcdtZ0/928yUpqP8Uz/OuQvZjPehWH9sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D4Y6A3L1b/4fDlF8P/+IlLyYruim6Cgd+1WVK4h9Zs=;
 b=vQAI/cPAgLlMAsgsorf4fFQYV2rF0uvWC/y5oAehnOUXfz2D9g32Q/JH30QfMNMyx7PaXYU2muc79WsRIL8voEETMaEXtcgIogExJw9E1J/SZjy5HF5Hpw+Jc9s9L+f+8SnCvtJsUkxQQWHBTSHIzJwoeVIxpvab7yJ/QHwm09s=
Received: from AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::11)
 by VI1PR06MB6461.eurprd06.prod.outlook.com (2603:10a6:800:121::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 06:49:54 +0000
Received: from HE1EUR02FT024.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:17c:cafe::db) by AM0PR10CA0001.outlook.office365.com
 (2603:10a6:208:17c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 06:49:54 +0000
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
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 06:49:53 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, afd@ti.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.reichel@collabora.com
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V5 0/2] power: bq27xxx: add bq78z100
Date:   Fri,  5 Mar 2021 06:49:47 +0000
Message-Id: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a51c346c-cff7-4acf-f8ef-08d8dfa2e1bb
X-MS-TrafficTypeDiagnostic: VI1PR06MB6461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB6461FAD529A3B8DEEFC5B939D7969@VI1PR06MB6461.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2Y/Oni/fqB11M6dlDud2Wh3H92NarKHL9WyGMmFncX6fwjEIGiZuXbUDpAXEFVM+QgpgM8rnLNMJ9spbtd60BSUAbkqbYXNsFQF1VOVnB/ZNVpNi19VeSLM7EA6Ky8jyWAnN2Dnp9/5St6iVnzi25drV0/s5fb87Zyef20eNMEGkDMIQJrsa9pURr3be5itEmJBMp8Hta9kjYW5pQ1CgMpg/smdwEAcwrC8xt6tzG1Q7bSa6GkUmxNjDDuq3Lwc3+2ekuy38WfRdZTv5pzg5OfFhDcwiYqjdxHg5HaCkB2SsziPCmxT9gbQSbs6xoE0ibxhl41Rxqn/Q2jRrQG16aSEct+mZm5uxe1OfD0C1YHRoKElaahU9FK6hV8ytH3/lEscVlKQ0ZrL87FoP2N943fJ3KWGa41c5Trrmr6s9ERK3st68FeumVomR3rT2GN41q2lhQc4/uHr/1ALh6ZRxSn8c+d490ncefA9MU2fCe6tnOmRO3RoUHVlOes4zu03VMvX/iPPBbgRaLt0/4/uDr9qHqsQOrUFgsh9Ezq0jr+YuyfAO57AoWwNmmHkNrDmFV6Q71FwHC7AhH770GoDRFnbYExDU+4//EY2q9YI7680SWSXnIC42WjNzrbh7n520nhlsznAQNe7/zFVzi2jn1Xg5A76KY99SNUFde6rVbjHB5ulmOoos2eq75MQdjFnc/p2Jvg3fM28lZAeBWJSiw==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(316002)(36860700001)(47076005)(6506007)(8936002)(2906002)(36736006)(6486002)(8676002)(81166007)(118246002)(5660300002)(82310400003)(70206006)(2616005)(336012)(86362001)(82740400003)(26005)(107886003)(186003)(83380400001)(4744005)(36756003)(956004)(34020700004)(1076003)(356005)(4326008)(6666004)(6512007)(70586007)(478600001)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 06:49:53.2926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51c346c-cff7-4acf-f8ef-08d8dfa2e1bb
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT024.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6461
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in V5:

1. Change [BQ27XXX_REG_TTES] from INVALID_REG_ADDR to 0x1c,
the StandbyTimeToEmpty command of bq78z100.
2. Add [BQ27XXX_REG_RC] = 0x10. the RemainingCapacity command of
bq78z100.
3. Set [BQ27XXX_REG_AE] to INVALID_REG_ADDR, support by bq78z100.
4. Delete property POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, not support
by bq78z100

LI Qingwu (2):
  dt-bindings: power: bq27xxx: add bq78z100
  power: supply: bq27xxx: Add support for BQ78Z100

 .../bindings/power/supply/bq27xxx.yaml        |  1 +
 drivers/power/supply/bq27xxx_battery.c        | 44 +++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
 include/linux/power/bq27xxx_battery.h         |  1 +
 4 files changed, 48 insertions(+)

-- 
2.17.1

