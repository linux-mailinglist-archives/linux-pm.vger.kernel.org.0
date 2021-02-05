Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364BC310596
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 08:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBEHLL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 02:11:11 -0500
Received: from mail-eopbgr120108.outbound.protection.outlook.com ([40.107.12.108]:63216
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231280AbhBEHLB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 02:11:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6ubhRxxWFSduavFrtRg5O+5rNI/D6DZ5DfL2+BWoPr/kgti4DlZRW+y6BIhZTMi0bXaq8+HbK0r7cQ9DCdluZ7wdf1IY1mLsNdYzhjh/ttjuBZ2MAqO1sYQOvAFXTAr1mI4h2QqTIGnhSDYrjZePVYF6w/3LCVLGTM8E3dkl559FS9xzFQawqJQY97x81xwb4Lcq/xrZYyL5YhKshaeYdTBoLXOU3zS/JqgV2SFFtZPfW6KqnMOTmve532PJUVm3X/qlT6NhT6lvrEkPBibcuuV3BwjOivhsq6PBXlt0rvpjLFgXwx6Zj9X5xVZxjlFY3plJNo+A4CZVIF+6PKukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqwOKEx6IU9HiUwRket33pSxEPsYi81KppD7xitkyhE=;
 b=c91SwIuq6Ni9grHFTbbE1DEluj81NJqqjXzha48MyacC4TbwUlTeIfeihW57NR5ANz9YlY3DObnm7YNhIi/x4sHbNcIidquiPsGpD+a9aVk++3yFwdUreul2Ndr9iyTBHOvyvWVEdT77IgPKvoI6WBmC5syb06VJmcwu/QEKWZPhOt4C2VZ4kQju/YPs6y6vA+qcXEu5EfswFMF61Dyt0AhIchZzxq52+73IqzFRt7vdTfc9G1uzzygSiewAwoh2bzwQWLiw6BYwXK2kniSA+0egDCI6xpUrRt4N9J8HiRcMF+rkI5U3SRoSTCf3Lc0NymqLSdhAFQ2UGXBcSgDL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqwOKEx6IU9HiUwRket33pSxEPsYi81KppD7xitkyhE=;
 b=wHjVLJXH3v/0rBhMWIjdwxjya6QKDwCuZ3iD12YftNitCKiD0kbUtRUnz880GsGN3XD6XxzN+Kjc/giqFYxEu3sjHUvCmfsN9vDHqV4v6UhJThQ5W70FD2NwEuxAtQUGktAHZSUC5TQOGJ4p+knB6W1VJV4MfmJag4KcVQ0oYG4=
Received: from AM6P194CA0100.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::41)
 by PR1PR06MB4714.eurprd06.prod.outlook.com (2603:10a6:102:6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Fri, 5 Feb
 2021 07:10:09 +0000
Received: from AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::cc) by AM6P194CA0100.outlook.office365.com
 (2603:10a6:209:8f::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Fri, 5 Feb 2021 07:10:09 +0000
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
 15.20.3784.11 via Frontend Transport; Fri, 5 Feb 2021 07:10:08 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V4 0/2] power: bq27xxx: add bq78z100
Date:   Fri,  5 Feb 2021 07:10:02 +0000
Message-Id: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e74e9f1-cc80-4f45-6fd4-08d8c9a5124d
X-MS-TrafficTypeDiagnostic: PR1PR06MB4714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR1PR06MB47141BD2EFBC9847C0F4695BD7B29@PR1PR06MB4714.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yjhwNtCha2nXaWluSAcYkdqvySQSStjQqVUOTXycX0NuPCcPWpZaY4+L/pcZDw5HE9uLjdWc1fI5hiRpxHdjl4QT7COIXhbO5Uj4Jw8dvlqkurLP71cl7X6D2zUSlTBLgO2B9VGX9+MExr+mS+5PlAI/geT+hYb/sAUuViQcFycGFZIUJmXFGUlqC9Ck4NaF7MKv2MvmN0tfVvtdcLhbN9HC7ULod9ejZgCWW4M1Gcobiwrf7kUCF7ecb7731+glejTTqdWYQLqFhafhuLIDy+glRj6uLvMiZGtg+M80Di7KI61h4Es1fnuZ9UI0r62iuMDmmGOzaIWY4Wo6DPbgjz8C4GhCSVPnN+2ewBZs97Fvsw2PCRN/atfOdFkJjhEGuhbHoXj39guyN12viJI5Rnzvseo+gmarVxE6Aba2x6ErJ7LgUgTV5hv5FahUUprnVVUeCDP4ObAsAS8k2D5Rg+fV6eenp30gwUxBnxLNE4VI1y+9bdIlTAVJSx1vVgqGJHGLrBtkv/wUa3k/wrcySM7UWvbpGSfIiwl//S+NN1Rm9fepV2eMeUlADS2h0QkS0gbcXNmCsB66JsK+QJ27kO6c3aTihwYaLtGwmntxSUsOOYVEIZvB7eyqzSsMnywbAT5JaxpoXMjXLIEbcBPm/solnBGzqbAmHTpi9HqHzHTf1Palj7UFYKj+CJYDsz2ww+3lZDeoNX7BXPV6qvISg==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(70586007)(36736006)(6486002)(956004)(8936002)(47076005)(36860700001)(6512007)(34020700004)(2616005)(6506007)(336012)(1076003)(2906002)(186003)(356005)(82310400003)(26005)(36756003)(82740400003)(316002)(83380400001)(478600001)(8676002)(107886003)(5660300002)(4326008)(86362001)(6666004)(81166007)(118246002)(4744005)(70206006)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 07:10:08.4587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e74e9f1-cc80-4f45-6fd4-08d8c9a5124d
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB4714
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in V4:
Correct the wrong part number in the subject, bq78z100 instead of
bq78z10.


LI Qingwu (2):
  dt-bindings: power: bq27xxx: add bq78z100
  power: supply: bq27xxx: Add support for BQ78Z100

 .../bindings/power/supply/bq27xxx.yaml        |  1 +
 drivers/power/supply/bq27xxx_battery.c        | 46 ++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
 include/linux/power/bq27xxx_battery.h         |  1 +
 4 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.17.1

