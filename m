Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36B533EEB6
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 11:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCQKtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 06:49:52 -0400
Received: from mail-eopbgr60137.outbound.protection.outlook.com ([40.107.6.137]:49581
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230192AbhCQKtW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 06:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCpXzr0xUWwqusrEP0y8pRYsu17H13CXmUzaQRGeh7T3VdzizSmi1OIhRWUqhd4wU7YL4fXf1j39WPfhUh3Gu/E79UjEClLfo+coi4RQXfdW18I02qQ1egH96buhvx+Kequ0wBfhRWyfjKGiDYORaryWrOfK+WrmrcyfqyT0ByeN6jhzT+ZXgRnEsJt7WXGWjhg2X68Qtx9G2J9T9oUNxJ2rCLH8+Myx1grbdaqu3vceqqF/gpjzIEvPsBGvucifhmg/zoaKaDQufBujUOaJS27leqOizX2Xd3DtQbGxxyNii5dYHdCBg/Utnceb5XHsLtcm2RhEiGe3Mutf3TY7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LybW7Cj1J6fjSdcfzN02ZeCm6HgScE2CSK9GP0XsTPg=;
 b=lx1U5acMWMuzk3lYQkm63L1qOfgvkUMwMPxCWz5xzv/9NdeI0PD7wfCpQvyQG8lyMCPsCzWB3TDYW0fGFpuf4YbSdjfyFO1urqQ5Xr7oaCu+kgVLsoNvBM1U+kBANJC0qeiT8JRU5a1gpclmp0meywdhv91aRS2lDyNHSFAh1uuFYLQ6Mr40+t5WOwmaSWT8V3Yx6pLy6Q1ohQdKgh9ne9XHgvZNaXc9OMmar/fw9FRw9mZbP1888pqGsFogKYW0TjF2j6HYWo8sQLufstT0Hj/6Zm1QPKyl9ZBkSkNCpVOx8kWfd/xT1LX/CueZ9jIcp0boICsxI+z1sIQ6KCfCXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LybW7Cj1J6fjSdcfzN02ZeCm6HgScE2CSK9GP0XsTPg=;
 b=vRvK0ePi0uy6XkJrPoz/r5BTlPkrZNJaO57N6C9wBMbcUqs1/rtNE83fP1coxGZR02mzNfFC2puUZ16GO1/QnuT6wr6wmOZ8dFgkcKS8oh9H/z1LUCDEjMuFWTuX6n7ifPUgdnGNj/5mrbIPfzTZD6OGRTj+GDsPCpp7KHgs7oY=
Received: from AM3PR07CA0077.eurprd07.prod.outlook.com (2603:10a6:207:6::11)
 by PAXPR06MB7631.eurprd06.prod.outlook.com (2603:10a6:102:12d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 10:49:20 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:207:6:cafe::9a) by AM3PR07CA0077.outlook.office365.com
 (2603:10a6:207:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Wed, 17 Mar 2021 10:49:20 +0000
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
 15.20.3933.31 via Frontend Transport; Wed, 17 Mar 2021 10:49:19 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V6 0/2] power: bq27xxx: add bq78z100
Date:   Wed, 17 Mar 2021 10:49:16 +0000
Message-Id: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 05819410-ddf6-4f5d-2d80-08d8e9325197
X-MS-TrafficTypeDiagnostic: PAXPR06MB7631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB763149B1758E278BCC47458FD76A9@PAXPR06MB7631.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9MOpdu+/AsHk4SM712+C/Pmd0vWrJ5P937ULQT10slWw3s00NHe/+ABRb5Oo8A+Fpr8VrWTscS5ZbG7MD6bu3gPV7aEO8VSv9LXmrQa4ng5R3p0tfVE7fC7kMw9LrSeQ689RVQCm9PURoUN7qzRriKzNh2ywNfQl8eliciIjLqQ7IU2nH4urbZLEcqVZPANQnTFs/apAgmATLgF/NtOg3DOncF1DsRkG3ZACOiKzT26OenipalRKfVxqrKxWw9PEjPfo0H2E1mVfYGcqMz0jl3WQ9lKjB80v2U3003PA8v5RGmSqbeLKJzH+d4SXTmclV3aNi9R8KWOPtKY78Uyk5SrRaQTAjmH5MBuJEbgILYeTW93xnQ0VRr5H2ryXqlgTgmt2hOr5MR71YF6smG/sRenV29bo5C2xtupqsmlnY/E4kP+O4OGzEf0bvCNnci30DG/pwuzKywDlPmaq+dCm0FcsHghVKuWHZeOZiTbGUsLLUQu6TuyiJJFrKyT/Ereu3S4KGGGWPWbOPaXalUOcOGpunWTbIedJSpuczpLTUqwqtHAacDn4OMzPBWf0oUSZtFh0uVGolXoaCI3uLYH6Bep9By7LbeaiUEMK0PPQf6qQdL2X6Q7Ks2JVDnqY23ZOjEACgsa/RaNzTexSB/slingB31gK+IxzkZ3Elj5hF7yH7kYg2eUMyv0q8zb+pUo
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(36860700001)(36756003)(8936002)(6506007)(316002)(336012)(86362001)(82310400003)(36736006)(356005)(83380400001)(70206006)(47076005)(70586007)(81166007)(4326008)(956004)(26005)(82740400003)(5660300002)(478600001)(6666004)(1076003)(118246002)(4744005)(6486002)(2616005)(2906002)(186003)(8676002)(6512007)(107886003)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 10:49:19.7374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05819410-ddf6-4f5d-2d80-08d8e9325197
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7631
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in V6:

Reword the commit message,
add result of cat "/sys/class/power_supply/<bat_name>/uevent"


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

