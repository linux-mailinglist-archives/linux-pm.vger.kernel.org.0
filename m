Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FD341ADC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 12:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCSLCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 07:02:55 -0400
Received: from mail-eopbgr140130.outbound.protection.outlook.com ([40.107.14.130]:22499
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230240AbhCSLCq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Mar 2021 07:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB2evREO0LRKut9ZZhEWq6D3D9QJagCI/MLTcHVa+hJRNIo/fZi3u60M0RUIP36JrSpqHhWVop6a6iSzNAab++0Y04tZN7oyxLG3RT4FKvLN88uCuGEJhDC6eeo47myDut2EnbQ07E3gNGjCx2HVse0CcGt8zvC76AzG+P8jXCH7YyGkfQuU6zo+Fz8L291VXTRROc82Z/YkfAky6pEjEMm6bykjYFyrhCCXPyKqcFQ/gk5l/et0NF/m73ov6pSpaaCBbYoAKpZaZpqMVikpEtnXHUUdbyERiXjM6GS5ws5Af1q2bBFxYsp6KYhsMuvFvJd2WiMt0FInUApnisIFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbC2OegmYwdefQLx81b88zz3zFthmv+7pbQLoxOC4HE=;
 b=DvoE9bJS+aEZiEKwqicLZauXsf391Re2WJkwbBpjyqk9rH96C/kazEWRYTk0uyGT83ZKoF0hDJk8T3+mMONQ6k7Xxp+taUOWPPGOcHlPF1QOsLTnEN0ANLbflqCzUvo9XkiJc2yZEotlAiw9UXN1MX6cgUbNktH0Cl+ovSPylaxC/W87436fZd0cS9dJaCLP7S8qYXZhz8iJDo0iB36omQzIPDNnF7KRrzIZB9UVBg/NhBLRnJsvQdwToB2QRMgX0vZvmt6lamjIIjPxBowAPLmgjNKFu2a4UIm+WKvW8QVZYbiVnzzJYITCTuCEWBrVMMMlgvDR0+FZoy6nIbF5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbC2OegmYwdefQLx81b88zz3zFthmv+7pbQLoxOC4HE=;
 b=D63MsnfuGquyEieqNsT11eiu5t3Uw7M9qwyKDh2+iOTeBo9zxm/ZbVh9e/+aKgwMhiIP2zL4xKyApY0nQKybyTUAa3vE3FsXRFTYc5q0YIbRUnj2pZIij2UUgnv7mvzyPC9HGc8Dv53YrotejMNZKIYDsHk18PDiQ25nWHQF47Y=
Received: from AM6P193CA0090.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::31)
 by AM9PR06MB7346.eurprd06.prod.outlook.com (2603:10a6:20b:2ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 11:02:44 +0000
Received: from VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::e8) by AM6P193CA0090.outlook.office365.com
 (2603:10a6:209:88::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Fri, 19 Mar 2021 11:02:44 +0000
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
 15.20.3955.19 via Frontend Transport; Fri, 19 Mar 2021 11:02:43 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V7 1/2] dt-bindings: power: bq27xxx: add bq78z100
Date:   Fri, 19 Mar 2021 11:02:35 +0000
Message-Id: <20210319110236.4353-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319110236.4353-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210319110236.4353-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f649065d-d811-448d-ae94-08d8eac685ac
X-MS-TrafficTypeDiagnostic: AM9PR06MB7346:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR06MB7346E306C2F058BE908EC966D7689@AM9PR06MB7346.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T418RZyzuPsg2LasWb6BLxymilughd49z6uqlVzegx79uxVMgVzzXxd555kB0EubpF9z/EIVPhM2PTJ5ZmljZvNkzxn0zhhhJVS3G09TDNZPybj4YMblJy3bT/JgZE6hBOrW7CJYj+Zqqyv2UQvu54VN5qJINJmLeya8pox5MoLcMpluoo3LxRocuQhGjRWoGu3+nxrxT6SZahst3qjMtHl+IClCx24Rbm3mR9AJQbRwuBwHj3V5F4bP3X2PWWUTUjrxRBPZY4vO89+3lCFmHDYBXUmQFomAlCI+cahyBmkmuYnsWUKUWFVcJnh5wnlPX6aUBkLmNGzxZRnSkvQi9zzqXwS8E/rgU0PoaV9mnKZw3/6awzlUtJsRGWnaw80uGludBPTXTPF+P571T5qBXNnXWhXZreq/rJjm7yZFUvm4B3MidJYXeUf7vd8JPjvqNRhefTX/K/hDXCT5i30ms5RRRk4A87uT87Oc61/d7uGL1AzcyasYULj9Z+MWdnDuxrntthRMJSy/r89raaKD6e4nNPZy4QHiRuii68u81EspOQtLod9l2QhO0jd27IEzU9MW1l8j164TrQa9tttP8otdcA8pCS6YVN24gkh5AQ+iNFzOvLWC0XL8xhuL+k56EJlUdJyLdaOFuZJRCkDZwNbObE2qQcUsWdlzX2QCpS25X0u/Bwu3c3/pBe+AAhG+EpPZWeGNOWkk8RTU+e1A9Q==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(6666004)(6506007)(86362001)(2616005)(336012)(8676002)(118246002)(36756003)(26005)(5660300002)(4326008)(6486002)(4744005)(478600001)(107886003)(956004)(82740400003)(70206006)(6512007)(8936002)(34020700004)(81166007)(2906002)(36736006)(70586007)(316002)(186003)(82310400003)(356005)(47076005)(1076003)(36860700001)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 11:02:43.7727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f649065d-d811-448d-ae94-08d8eac685ac
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7346
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for TI BQ78Z100. An I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Acked-by: Rob Herring <robh@kernel.org>
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

