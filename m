Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FAA341AD9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSLCy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 07:02:54 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:10978
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230239AbhCSLCp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Mar 2021 07:02:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obBEzdo6fQJG6vt6oxvDg6+vkWNC7awfYqloBdONys0huQRIcLKZImiI6wELStCao9KrAqVVor5Mprr2VcvvN+7mvojFmcrYEt85zCLcIpNFGmt2uPbKE4mhz7b7qboP6CBw0wTjwYvaz8Vjmpyi0WpCyaOd3d4M9TydAXph46JYtc0fWRSnROROCjNHCcl+6rFKhVoq3U1giz5YByFHjpdiPXwnSksnX5Zi5bky+aOMBsdfmFuMEpmarPM1kRgm7LUQfCPrvYfjT4qzRzgOWxDVKTAWrO0u8FrTGgh4/ucqs8hD13D2FTz015ux2Ddmqdwj3I4lPbxN4QQygQKS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlUcXP0O81iYRQCyc0SaUBgNvimjKpEgJzg8VumYR74=;
 b=AhJzxnVTUoDDvd1juSJoQYry9P9LebPcqWZ6yJvNu0AgnyZa6Qfgwj5Rd7rLcTdd9pTsgIdzifK+WDzMG0A2fLtd+/W5Uf3X/l0FFe8/rZYRlnQn9v6RhyjRP9bnRVop/wz/JiqJ6tzQCXuh9ROX/hG0F6iUMaDpjYWTuMSGF/57nM49gj87AsJrpBPPMYbb+u0B6jbAKEHvuoIz38L+MzSdwcc2s1S10oKhsjHTs8VorPBlkKqCJ2FlT5VPztU7oZd2BoCXVy9SHlodPTZR4oxosHOIeLN1YLYjdJiNYRT95eSg/qrRFlMism1Dj0YHL9uV/g9SvIIMDvN6Wtaumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlUcXP0O81iYRQCyc0SaUBgNvimjKpEgJzg8VumYR74=;
 b=xf1LcsFARlmWvdpnOgsDPu0FFF8ktEp+GLoF5iiGFL960se2QL8grktSDiQWEg262BWJO4lhaTM7ReIT59rbkO3LH3+Eq2ZrG7JJGRQYlysHwvMWXBUZWxuWhGNqCJdYdBi0PLrWEferhUTXrnzZOLM7r6lgjxw/4zW96vlfy0A=
Received: from AM6P193CA0075.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::16)
 by DB7PR06MB5340.eurprd06.prod.outlook.com (2603:10a6:10:7d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 11:02:42 +0000
Received: from VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::85) by AM6P193CA0075.outlook.office365.com
 (2603:10a6:209:88::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Fri, 19 Mar 2021 11:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 VE1EUR02FT060.mail.protection.outlook.com (10.152.13.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.19 via Frontend Transport; Fri, 19 Mar 2021 11:02:41 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V7 0/2] power: supply: bq27xxx: Add support for BQ78Z100
Date:   Fri, 19 Mar 2021 11:02:34 +0000
Message-Id: <20210319110236.4353-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 169f50de-bbf4-458a-1dfe-08d8eac68483
X-MS-TrafficTypeDiagnostic: DB7PR06MB5340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR06MB53402CEA066F2F47817BAA0ED7689@DB7PR06MB5340.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7u/1dcvTvJpDrYbnT8PbAL5Ig+itWmxezy05A9yTggzkRn/UjnTGeetfohrofUAFHCbFc9iV4ySQkAYYecpRv/Gg7t8IdD5tlDMIolnbG4/ayE9pOXHlnUWCZ7NIkQEMkqFZTu9MhCmZJGQ9kyw6EsCKOligpAPzf1LJUHry4LEZBRqlUuSA6n/Zr6QtEWLhkSCVQZIYaWYLA8n0NxmoONMPjRm2riavECkNS3UreFYxeOyH5dpLCfc2MI3ndq43bGarYI7jnuDK4RPfPGUa3ad1XJ+dK6YTS9fGOlaLHF3vCBZ8Zn1qdV6FuAgYsZonuCnLQsJy8kGCTEHWhjVNJTy+3q57Y/79CBLj4loZP+ydMIh4wO3P62wK4sPqukuebxdhE8Y7HcsOe8QojZloiEotiHKuhLtyIGuto/qURokFI4mzoAkpNZYkPq/yTGDi/gJeRdAsLPYVZj0EV0VH3BqMxMpZLQWaXPLKvwi5F4tGBaCWGeFZCAEprwUmMXTj2J6tpqIFW2LulT1V1+3236HQP+pyv0GYPskJTEdv/PFJU0pb3Jl0/QIvKmqBhLJ289tschkMCOTdQkdziNkZ2y8JG19eBRFnsDD521rb1MHXPwiHMIB007+p6xBn3YfLt7wcVcCF+Yef5+TmaMpzfeV8vzeN6G3YB/rbCoUXnfaclvNORrTb2hifvGGcV/Ti
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(36860700001)(336012)(478600001)(36756003)(82310400003)(186003)(118246002)(2906002)(956004)(2616005)(5660300002)(34020700004)(81166007)(6512007)(36736006)(82740400003)(70586007)(6486002)(26005)(356005)(70206006)(4744005)(8676002)(8936002)(6666004)(107886003)(6506007)(1076003)(4326008)(86362001)(47076005)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 11:02:41.8215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 169f50de-bbf4-458a-1dfe-08d8eac68483
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5340
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in V7:

Add    POWER_SUPPLY_CHARGE_NOW
Remove POWER_SUPPLY_PROP_ENERGY_NOW
Refresh result of dump uevent


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

