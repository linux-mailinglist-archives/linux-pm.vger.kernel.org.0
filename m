Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DDA30BA43
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 09:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhBBItz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 03:49:55 -0500
Received: from mail-eopbgr130109.outbound.protection.outlook.com ([40.107.13.109]:65510
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231447AbhBBItw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Feb 2021 03:49:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay1VhbhiM1n7e0B08m7NBKfrAMu/YuQl5zRN8cY9HBPLhcYKIkp8VhFkR1FBUnMU4/U/rADdSRP1KhQIpiY8E1tWy4evD95+gmFqS1/+qEtCuRPdqa3QPsEm8c0BkGCITcA4zTvRcR3ENE++5q+X+RLDqT99ld5d4YZ7p/jGt7R7NjaPZFVq/Vb288nmfHn3A6TLnNvg2o5fgC6ST85bq98Vig7Wx2U/oGpuor4eLcu5g9ughMbXmJt5d13XuyJxaPjZPANaSrM0xczOEuh1Z85fuEzpOeK/5tler2DMiOXiNvAP3J5SzjgJ/zbsXuIe9UnfTK+B0x1zFqH18V6RgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iscDMZ+5/D15S2kTfyy36yHfWc7srhjcolXeJ9PNBS4=;
 b=D14jKg5H/w4D7XjyyQiNLxljl096GDKvGo1lAn2ILhyMot01KnLe3ZgKX2PQ7uGwMMHm7GIE7SnhpHH+3hIB/n4xA7nsSXtVKWHmBk9uHib5ZrtYY53B8/XJEGLBhfT04H4N8AFAKh7v3Md8HJBxJrOt+czezI2slIMMWkfqD9h2ZrNUrGv8UsbRfJ2yQtFDbp5abfpBa8atITM+D/mDGS/TbjdpyeACpo6RsF8WAkOQRxHCkxtwqfhUuwWpJS1vUS+HEjWRLzm+NgiTMcQxz7nWKR15DoGhFWmNreKeLypvYhoipKi45qh7W3vpMSDtEOdPKPnRMIxh0m3aglj80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iscDMZ+5/D15S2kTfyy36yHfWc7srhjcolXeJ9PNBS4=;
 b=Pn2Eob9JvhqWfuO8iEwEO9pHjDB0evD/JHkk3+b9XNZOVtLispN6EBXCd+urWE0wxBU2Qxftp10Ct+gdsw+LyZzLHT7a6t8c78CLIsxfkOffV5fh7ogVTTPkCDa9zHIGAIMBNK8GUxBfe+7fIozMtGhlBrAckpjbb2B9UjA+Ga8=
Received: from AM5PR0601CA0028.eurprd06.prod.outlook.com
 (2603:10a6:203:68::14) by AM5PR0602MB2900.eurprd06.prod.outlook.com
 (2603:10a6:203:97::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 08:49:03 +0000
Received: from HE1EUR02FT042.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::fe) by AM5PR0601CA0028.outlook.office365.com
 (2603:10a6:203:68::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Tue, 2 Feb 2021 08:49:03 +0000
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
 15.20.3784.11 via Frontend Transport; Tue, 2 Feb 2021 08:49:02 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, afd@ti.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V2 0/2] cover-letter bq27xxx: BQ78Z100: Fix Typo
Date:   Tue,  2 Feb 2021 08:48:56 +0000
Message-Id: <20210202084858.2944-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e6596653-c99f-466e-d9d7-08d8c757642a
X-MS-TrafficTypeDiagnostic: AM5PR0602MB2900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0602MB2900B588F57EF0446E5DEA07D7B59@AM5PR0602MB2900.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRiC+Zo2aB5cTdLVEI2/jFmhAo8LvBhGgp09mEtkOL1NIoPVEpnyGutpdNrRgZpD4Od8zbg7P0XRPpp8rWvdyrEt5aAcyi6LN+lx7xp0LlpJ3PVv4TsYZWsbOn26bxa85hw9BpHW/sTGD4aTmKcdQmHEPa9MHGwP71i89hrAufSPhZs9MnTezIxZaz1kF1jI7YC4cYYN2BBP2pH/0r/7Bm02U1Gigtdw8vhWeiVTYaXt3l7ppLQ+tYauXFEU7ZrXc7qBzYZnOnkgE72rd6dBISsb+827iYqrhNhrn+ffkIqrjd979PyBtvD/3DEOMQYS1RS1viM15s+3C8xxn+Nj+J97XG4xZKYil/IundVeh3+v0g31km0Vr13aibsCHwyJ1MWPji7gxyqphiXbnj2ssfQ2h4Okz5SHfvyK3851PKCpXKGW3r7zxVGnuUr6AyNGZpS/TKUAnOFoOvZB5wEXCxLkKj8+R90FgMkyv3eEty0CXUE2kJLXNQ8xoMOz3e+IKHBm4LTKtoDIdabMEtOhXKrH1y/abgGM8yBZ5idvMAdNVYb9R9X7vPFmI7IhWj6eMTSru4DaRYmNHjwMBjAwQFrKwxfHgJc2aY9UbhaiR6HOVnJZGKc0CQxRpvcnqrPNvszbBXPWL9eS1wq/cDPJj3d1fj8QO6jjnUHhCAI3ZsY6Om0SmdnMfVSW2EwZ3gzR
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(4744005)(36736006)(186003)(336012)(47076005)(36756003)(316002)(6486002)(83380400001)(107886003)(4326008)(6506007)(1076003)(6512007)(8936002)(6666004)(26005)(86362001)(118246002)(356005)(5660300002)(478600001)(82310400003)(34020700004)(82740400003)(956004)(2616005)(2906002)(70206006)(8676002)(70586007)(36860700001)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 08:49:02.4789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6596653-c99f-466e-d9d7-08d8c757642a
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT042.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0602MB2900
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


PATCH V2: Fix typo of commit comments of previous version.
 -replace "equippent" with "equipment"


LI Qingwu (2):
  power: supply: bq27xxx: Add support for BQ78Z100
  dt-bindings: power: bq27xxx: add bq78z10

 .../bindings/power/supply/bq27xxx.yaml        |  1 +
 drivers/power/supply/bq27xxx_battery.c        | 46 ++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
 include/linux/power/bq27xxx_battery.h         |  1 +
 4 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.17.1

