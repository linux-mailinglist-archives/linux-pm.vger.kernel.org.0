Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F65A30D7CB
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 11:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhBCKl6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 05:41:58 -0500
Received: from mail-eopbgr10096.outbound.protection.outlook.com ([40.107.1.96]:34791
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233090AbhBCKly (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Feb 2021 05:41:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6by5E/38jH3x9aWz1V2d9tWmmpyImfOa9HGdBzkwcc3aSHnbhLP0GpHbqlNscKRxqEs6xo1zGdej0sVUgY/HmZKXO+tbrM50TKqCjie7jk4OXbG86Ta6cbzJgjnXHXpD/UP7jd51g75dfTi40B7/euqbF8n6MPIRQAI6PUrCaua2NiXnWmXIQqGTeWHDm6A6ncLTiPc1b3sqdpLkxd5kw6xoBQ0fYRWqhQkuDh71wQ9ywm/6DQQVntkbsSZ+F2RYkGx0rMrae/1bf82n7NtTkSEq2VAllfN5Bk6c3ZzpG17Pr3nDvgodcrZKtq0js0YZyOVqPTSqeCCXKFbja3CPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kF0PFIhl03t6SPOky8umjrW2TV4baLj/a1d2FkcDhQ=;
 b=DTSsmKEo9O2L0yBEFnRDsQ/3U0IRx+mw7OZYuxBi0QUW3k9GUKkGrr2RutTzUF9pjycnFIUqaKguoqMMcPXqRIIlWpaFay+hixX3UUAjLVomBpbO3eJVlrMat1ce2y7FvE7hRr4Tzrm6aMLbXxJyOAAAEhUY06Uqq1IhyBYg9mY42XIIJfLgVlGILCRQpH5EJTWPeEZlcULu0lBzogvSI2akuBqDHIoRpOgRMSOspWb2XjFiQXOCqMaXVlk6jrxbaJNSYH8+jnrZI1ANxJhW66QyLGTKRPh+wvXjNDscHM5KKsXcUCknQJLULw2Qk6ZudAPNcdkMNirMjmw7JjSCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kF0PFIhl03t6SPOky8umjrW2TV4baLj/a1d2FkcDhQ=;
 b=C6OkERkSMl5lLyBrQtyzB1KbWNWr7g/gP/JU5NvfvDWuszv+UD+HqK+upzrU7jnho+WftfANDnUHSnRrHdcNOB3+SfUESN1KXg7NaYBPhyb3CQCuhCM6JRGhgojKhtuAkoUONBiJbmArlQvVFzQyiJ5JaGgKvnQcNgOe7MShckY=
Received: from AM0PR07CA0016.eurprd07.prod.outlook.com (2603:10a6:208:ac::29)
 by DB6PR0601MB2663.eurprd06.prod.outlook.com (2603:10a6:4:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 10:41:05 +0000
Received: from VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:ac:cafe::15) by AM0PR07CA0016.outlook.office365.com
 (2603:10a6:208:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.10 via Frontend
 Transport; Wed, 3 Feb 2021 10:41:05 +0000
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
 15.20.3784.11 via Frontend Transport; Wed, 3 Feb 2021 10:41:04 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V3 0/2] cover-letter bq27xxx: BQ78Z100
Date:   Wed,  3 Feb 2021 10:40:58 +0000
Message-Id: <20210203104100.17143-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d32a3aef-12c6-4e4a-eeab-08d8c8303526
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2663C0F165A87D0E772A5B25D7B49@DB6PR0601MB2663.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlechXxBh/HqFg04wKO9IKUSPZ6w0IGUpx13hkuILB3aHMxsOMxa2ymaUFkdiSF+NJ9T/mdrpwL0EQyj6oyinq3d8C9OmSR8XL0ZN0a2rVudWuyGigTc6PfYfLj1dxUUXDh9VjDDKcuiH+COLN72S3KxIN+uxdocV+To99vyO3by+s4RtK/0TENw36A/GaHlVvpDhYXqc8ktaLOUMovW2WnvnTEDsGU8AYpau+GkEkRGOQWA8+4BPGoo7Ba/YjAGv2xmrtidbcNlzteQawPUetj1JzfJo57zkLFImhYpOqK/uOeqGnu+d9N6Rxv7QvSf7umh1c2QKM7SUEE51kQjAdOeOGMvjNDSkOp9UND1heavekYYv0cnETFHKgwB5M9dr02QdaXoi4LfjVERuPoCsUMlEWXOye8Ve9MCp6VWCvg56tELDAWGdDIp0hwRrnLKKYNK9aDVEk3Hc8AyBxnsTTg/ecfNnGNJ9rGl1znm8K4ffwtixlozPZX6ajCT9a9PvSL0BSb4lu+N/boHIDxt2VVOwu7Jf3+cYBJ6itXAaHKiKh6PoFxA+vlxnJk9u+Xw+iXyMUvUSseizfRqHi0w9iQiTxYzVIqWhcqTcDoM9MuzZ9y2MfmEiROy7uuw0zze4ycmCYBvX7LNqepxow4Tcyja0wiFcD4DuY9+eteJj/YJUSnPVSDZ3g4SRjLyIVvB
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(34020700004)(36860700001)(26005)(36756003)(6486002)(186003)(82740400003)(86362001)(6666004)(336012)(1076003)(6506007)(70206006)(956004)(82310400003)(4744005)(83380400001)(2906002)(70586007)(47076005)(8936002)(5660300002)(107886003)(6512007)(118246002)(478600001)(356005)(81166007)(316002)(2616005)(8676002)(4326008)(36736006);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:41:04.5955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32a3aef-12c6-4e4a-eeab-08d8c8303526
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2663
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in V3:
Delete comma before "and" in commit comments.
Reorder commits to sending the bindings as the first patch.


LI Qingwu (2):
  dt-bindings: power: bq27xxx: add bq78z10
  power: supply: bq27xxx: Add support for BQ78Z100

 .../bindings/power/supply/bq27xxx.yaml        |  1 +
 drivers/power/supply/bq27xxx_battery.c        | 46 ++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
 include/linux/power/bq27xxx_battery.h         |  1 +
 4 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.17.1

