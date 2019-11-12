Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECFF907B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 14:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfKLNV0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 08:21:26 -0500
Received: from mail-eopbgr790079.outbound.protection.outlook.com ([40.107.79.79]:6064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfKLNV0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 08:21:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZJk0Sgst9KVQHf8Zz//aXqEMConfEDOgNXGAUCaY4nw9r9Emn1HAA9D80Acv5tiLzu7z5PsgqzlOM13jMtYiEbWqt6DllGJpIlhpwgjZMBvMMIOMh3sX3uFILWBsc8oYGlFxaV/nlsiRTSQBAuxWqfAWuuPXQ5Ze8jcQnpaEX66jc3UN4k7JP29NT4sYcsyB5Va9+oYaIfvrucP84vHKFhtVG12iPm92k8yvofBpq2KB2asFHuRJoAImtkHGItiTOrdq+KeVpqzb6oM1cwaVViVstbVbpK9ivd7DjMY8YnrTfE98iyOiKLoKdD6KjyejRSWhkm7qcMulAjXircuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic+szegcMXmRV+L8BIyV5McFHgsPGogwbqd2F48xxZs=;
 b=bxX2GubOa7f4G+uqvOrwJyz2kvo/ZMp3gc5jqAeV4ymNP0epUMXFAnixoFvwvyl3G/BMC1MUCYjEjTVp7OwXEn0vnwBZKgWEVKNWEGBq0JUB2kQfs4yi7UhGkSb4CF1VG5CL+cQtMagqz4qsyKCKMZcEYI/9PeF5g789gB+zgP+sAwJDNbnmh814q0jPu2zpfSsvcjeL6csd9mbATh+fwefvN0aQiPtzGNmM2GDwrnHOaA2YFuOycpvtmqoSb0rRwwNRn3qBeCYnJ6yzdVP+LWIHsdhJxs+QuOB+tY16JRnU+w8FFSiCxXVOWLKBeNfATWetF0MJizK6Xot4YS72Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic+szegcMXmRV+L8BIyV5McFHgsPGogwbqd2F48xxZs=;
 b=P+vDv5hNYGXCzv3c221StUDex7lhuKzS7Nqpf43phaf7ddbq5tbezEJdY6ZOsLnzf4ZrpAIYf+tQ7Gnt4GDpPdhWIRQPXFfY80trlPHcyt/rfJ7BpP4i6pfix4DB8a5+q5U1Ox/RLDpfTg0VqznWr6rLC5NLglO+BPqf13IBDPI=
Received: from BL0PR02CA0098.namprd02.prod.outlook.com (2603:10b6:208:51::39)
 by BYAPR02MB4678.namprd02.prod.outlook.com (2603:10b6:a03:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Tue, 12 Nov
 2019 13:21:22 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BL0PR02CA0098.outlook.office365.com
 (2603:10b6:208:51::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24 via Frontend
 Transport; Tue, 12 Nov 2019 13:21:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:21:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW6i-0003ux-Mf; Tue, 12 Nov 2019 05:21:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW6d-00058k-JJ; Tue, 12 Nov 2019 05:21:15 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDLDSA012481;
        Tue, 12 Nov 2019 05:21:13 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW6b-000578-9l; Tue, 12 Nov 2019 05:21:13 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jollys@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH 0/2] drivers: soc: xilinx: Add support for init suspend
Date:   Tue, 12 Nov 2019 05:20:49 -0800
Message-Id: <1573564851-9275-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(6636002)(186003)(81156014)(8676002)(81166006)(8936002)(50226002)(4744005)(356004)(6666004)(15650500001)(106002)(2906002)(36756003)(36386004)(478600001)(336012)(316002)(486006)(305945005)(16586007)(5660300002)(9786002)(126002)(48376002)(26005)(7696005)(426003)(70206006)(4326008)(51416003)(476003)(2616005)(70586007)(44832011)(107886003)(47776003)(50466002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4678;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1371a3d5-0f44-4fc2-06ad-08d7677335af
X-MS-TrafficTypeDiagnostic: BYAPR02MB4678:
X-Microsoft-Antispam-PRVS: <BYAPR02MB46787F2BCF6BC2D46D2FA487B7770@BYAPR02MB4678.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTVjn0c9stNcGH2OdhxGO0qkTgFWAjg0YsIdqDWRZxvXr55vOAsU4uVN7rvrrcKxo+3LniQ2Xlf5pnfy7jq9FpiFwQETKjeBUeCurDyCIMa3Pdiar7WoxcFzDmUxlyFVQfcht30oocxQQaipIPC/d3t4KELMjfMEOYuHI29JaHClHv5ST3xmMEApebS+kv8P1OzXxbQkYKoLiY+U/MVNJKaCuzEAWbZT8FPIcxQWE82C5IyUar8azAlaDYBzGLTCTvY5DlXCGs1GfKJK5I5w/BozDn8jpmQNHREIhy2S06HWgT2vz1eTeu7ZcirVDtBxK74DxJ19+y4u+869vRSa9SrB4zIOdpA9kNPArlwLqtsERbMWg876Zw9hoqXlowKPdbl76TzVXAdbu/sQ3tmH+cH9BkQJsHQUerPFESCTkSVBotx5XIX74gXIwzNUJb3D
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:21:21.4306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1371a3d5-0f44-4fc2-06ad-08d7677335af
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4678
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for init suspend in xilinx soc driver. Also update
documentation of zynqmp-power with IPI mailbox property.

Rajan Vaja (1):
  dt-bindings: power: reset: xilinx: Add bindings for ipi mailbox

Tejas Patel (1):
  drivers: soc: xilinx: Use mailbox IPI callback

 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  41 ++++++-
 drivers/soc/xilinx/zynqmp_power.c                  | 119 ++++++++++++++++++---
 2 files changed, 144 insertions(+), 16 deletions(-)

-- 
2.7.4

