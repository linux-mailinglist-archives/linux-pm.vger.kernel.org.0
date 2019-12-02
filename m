Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E410E905
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 11:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfLBKjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 05:39:20 -0500
Received: from mail-eopbgr790087.outbound.protection.outlook.com ([40.107.79.87]:35107
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbfLBKjT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 05:39:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5LxV143S87RASgROc92OYAs9P0NxU+szfqsV8VMscZxNzVEb0psW46Vi0TPyM3KPkQP8Av69TppXpx4nZ5xCmc912dFFcd5psfqK6znXR1uWKSTAAi84JFhbDf/FgB6q/64XFuNhnkKqB+hwy9OmewFqL5q+/btUnqRkHr6dV7ZopPbuW4nvXneGOIB/Fj9YL034IfIaWP/XEZuBZ3lAoghzicpuZG06gpD7qkxijJDu4/6P4VYAoSRtyBSVCDVrhpnEcb0gfqmzVZKlZSmAf/zF74P0zS1jQbBHePFvv1NFy8iUS4L3TWfH5SF74hOK1OFjh3XikpCkBM4HE0iEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbW5qmuZpE0vb0VbAd065kFssle8WMsvW/FZ6bjSd8E=;
 b=IScu5nOUK48vOA13oqRc8ynK1v38PTbzXemCquJ4j7+xR9FGLvMq+Hz3yyzM3U3QUzFMQ13wWxzff3ge9f7QfufVpa+69W2tQhKApW0FaQYSGt3UvF9fntO5mW7eSxhgkdv862eCy3gVoFiw30I9uUv+Vdy7F+uX+E+FoFGXbflqU+VKxoMfDaaeIddyk15tckW2NL0GBfNKTe2Wal+ddguMzizWlCHPOeE4y7jqtgt8IkMxgGppZwe3+QZ1jYxkh1yFKg4sYYSVQ6eT92OM6OFS83KEUo+6mLmZbUVkyYRNKwzwQR0hPd9HOJWM5IE44o0+l7qcuvWMyTcWk66VYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbW5qmuZpE0vb0VbAd065kFssle8WMsvW/FZ6bjSd8E=;
 b=PpuYkxkXzK4QLHcDg7CRk8fydxLZOwDxxHf4FUHjyLwP31QqFwUQOfVleD9GSjH8ZNG7Pe+yaHJhq/VwgOYJMWTiURvrCMGZhcklXtNy84hZu6DHmIdkXcfL4pCznbtUghPk3nJdnD9JUk6DsnR6jboiqaVuZbAlQpQr4ieCcrI=
Received: from BL0PR02CA0101.namprd02.prod.outlook.com (2603:10b6:208:51::42)
 by BY5PR02MB6625.namprd02.prod.outlook.com (2603:10b6:a03:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Mon, 2 Dec
 2019 10:39:16 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BL0PR02CA0101.outlook.office365.com
 (2603:10b6:208:51::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Mon, 2 Dec 2019 10:39:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 2 Dec 2019 10:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ibj6p-0006yn-8i; Mon, 02 Dec 2019 02:39:15 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ibj6k-000826-4w; Mon, 02 Dec 2019 02:39:10 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB2Ad5Rk020943;
        Mon, 2 Dec 2019 02:39:06 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ibj6f-000805-DK; Mon, 02 Dec 2019 02:39:05 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jolly.shah@xilinx.com,
        tejas.patel@xilinx.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3 0/2] drivers: soc: xilinx: Add support for init suspend
Date:   Mon,  2 Dec 2019 02:38:49 -0800
Message-Id: <1575283131-9339-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574412258-17988-1-git-send-email-rajan.vaja@xilinx.com>
References: <1574412258-17988-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(81166006)(47776003)(4326008)(36386004)(446003)(48376002)(44832011)(14444005)(8936002)(51416003)(2906002)(107886003)(16586007)(50466002)(426003)(336012)(7696005)(76176011)(11346002)(2616005)(26005)(186003)(9786002)(316002)(5660300002)(106002)(50226002)(8676002)(81156014)(6666004)(15650500001)(478600001)(36756003)(356004)(4744005)(6636002)(305945005)(70586007)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6625;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 545f8ccf-89d9-4e8f-5a05-08d77713e0e9
X-MS-TrafficTypeDiagnostic: BY5PR02MB6625:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6625172E52B0C35E565870BDB7430@BY5PR02MB6625.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZE7MjVLjE5z1jhBwuJYw81NLnHTd9NeaKpe6Yc+cpTsu/RPSxMpPeKHyha1oM3eHH3E97QQreCzJvBr73W0Q7oJBie1A2DUpXy5tUIM4LNfB6Il3FUZjoo1K4LLc0Oz/gTdPCk5yvzroVMce3ALk3gz9I1vTRVFGCgedaxhPcMywpILJxnII6E1K3O/fJPFg2Ou5QQgk+vUJph0seXaFMBm1/v+AMKWnA07PMkEUkWiBMvOMGyRaMhbOSbE+n/MHi4Rn6AudbtYPimEaSfNqF+McJ7ISJmZ2Tu6Dad9OtUC8ZzXCsvQiZY0TWcV6AgSwpFNnIT+l/RcI9/uJjSU00U4Z8mMnA240Pzc7tCm7leg6Yix3odN7bxtZrT6yaTrLWLl7A5lO6lT8RiYrdbM2wK/NGOlffIvi77kkoR0Z9K0GUiyl0WBth67X7HCswPEr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 10:39:15.6536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545f8ccf-89d9-4e8f-5a05-08d77713e0e9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6625
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for init suspend in xilinx soc driver. Also update
documentation of zynqmp-power with IPI mailbox property.

Changes in v3:
 - [PATCH v2 2/2] :
   - select MAILBOX and ZYNQMP_IPI_MBOX as it is required in zynqmp
     power driver.
Changes in v2:
 - [PATCH 1/2] :
   - Correct order of tx and rx in mbox-names property.
   - Add interrupts property in example.

Rajan Vaja (1):
  dt-bindings: power: reset: xilinx: Add bindings for ipi mailbox

Tejas Patel (1):
  drivers: soc: xilinx: Use mailbox IPI callback

 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  43 +++++++-
 drivers/soc/xilinx/Kconfig                         |   6 +-
 drivers/soc/xilinx/zynqmp_power.c                  | 119 ++++++++++++++++++---
 3 files changed, 151 insertions(+), 17 deletions(-)

-- 
2.7.4

