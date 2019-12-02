Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FCB10E90A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 11:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLBKjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 05:39:20 -0500
Received: from mail-eopbgr800055.outbound.protection.outlook.com ([40.107.80.55]:15632
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfLBKjT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 05:39:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxC2qoQpgRmqxREsVqFTc66oCoiwAfM6RIi5yWcekKXmlwIZe4eVFYLiV+NXwhHZdahns8T9nRKuCX6Lfcm42ILTVxg/Maq6fEyek678oaqwJeM0AS6B3EOT2SLnoVgt2fWAg6a4DOCmmVESCXBMMNpXnfT1f0ce2OECgJHzE0nwb786UClijHMMGbTL5nBq92GQPAYuEyyFqbUAzrIF2mpee/EMiYsZegKdj9MHlr9jGmXbQXR/7p850Cj1NbAIkbq2OTQmrAKDl8WqiM6wi0gjy1FVHMu5WB2ejiLlSj7CiW4mm+lswcj9lJ9ZN4pGb084m+9vUQtqAl64eb5hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5o1GoiCcCJJs+e6K1pD7kRBxhh36pLZAOpy1eL126k=;
 b=mvqUQvTvU5EQkT3PLKUYiXNTNK6jAn5qR1aL+EunYApMmFHkvRTok8hHb+E7eJof5RnfAqcY7HJCHD6OjJ29tZejVn3+hlneuLJG3KXOKNT/HKVtsEUK20EeybqwDy1AJyorD+VnnPJsZFjNfRswgfHeQ7fe0NWu7tS5ZrNVb/kkzMJeXi95eeIpaiC4BKKW7GdZ8ZoS48BQnKFDz2Vcxzh3J3UYGYBuquxh75GK79glgIzdLfMfVkwd+UG3VuxYQ4VZdtiKjrxA4KwSOemQlxDgWbkNM8Pkm1MmJokonuaKCbZpnqqcdiUFJ5GY0gsuqiq8AqjB9Nm7r7ZYnG6B3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5o1GoiCcCJJs+e6K1pD7kRBxhh36pLZAOpy1eL126k=;
 b=N3GH0ilqEl39bEwAlqTXSUNDS/OxtlzwjSdy61KsH1L/T8a8pEVU4fQTRf8axmV3ZGeqxHZoiIoAgQu+NtlIWp7yVgxEyuKyZ/HRLZxPvnX770pJE+dJiGOQroTcFhEnXHcDseXuDUJ3zk6GQxpbztB76+RYf/+Ir2YRK37tob8=
Received: from CY4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:903:18::25)
 by DM6PR02MB5228.namprd02.prod.outlook.com (2603:10b6:5:46::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Mon, 2 Dec
 2019 10:39:16 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CY4PR02CA0015.outlook.office365.com
 (2603:10b6:903:18::25) with Microsoft SMTP Server (version=TLS1_2,
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
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 2 Dec 2019 10:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ibj6p-0006yp-DZ; Mon, 02 Dec 2019 02:39:15 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ibj6k-000826-9l; Mon, 02 Dec 2019 02:39:10 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB2Ad5L1009757;
        Mon, 2 Dec 2019 02:39:05 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ibj6f-000805-FY; Mon, 02 Dec 2019 02:39:05 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jolly.shah@xilinx.com,
        tejas.patel@xilinx.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3 1/2] dt-bindings: power: reset: xilinx: Add bindings for ipi mailbox
Date:   Mon,  2 Dec 2019 02:38:50 -0800
Message-Id: <1575283131-9339-2-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575283131-9339-1-git-send-email-rajan.vaja@xilinx.com>
References: <1574412258-17988-1-git-send-email-rajan.vaja@xilinx.com>
 <1575283131-9339-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(4326008)(5660300002)(426003)(50466002)(48376002)(478600001)(305945005)(2906002)(106002)(8936002)(81166006)(16586007)(81156014)(316002)(50226002)(15650500001)(9786002)(6666004)(356004)(47776003)(44832011)(26005)(6636002)(70586007)(186003)(76176011)(8676002)(70206006)(2616005)(51416003)(7696005)(36386004)(107886003)(336012)(11346002)(446003)(14444005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5228;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85bf9250-e590-46fa-8e34-08d77713e0ff
X-MS-TrafficTypeDiagnostic: DM6PR02MB5228:
X-Microsoft-Antispam-PRVS: <DM6PR02MB52282B9A9C5B0971689D4D5AB7430@DM6PR02MB5228.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0239D46DB6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gJ5LuJngTxpmF+0j5vItteHe78nRPAhHtCpvgdv5Mq9/wYWCrNczvzwUm88Y6ecf/Ch6YIbaP4brbD7l3eYm2ub2fTg24RJkbTtS1heD9RT/0jS00xpWuGW5l4sOBXvnG0aoQkPQdKb3kRNefvpdGTQ+q3I/f788AL+XZRyDFKaJPwhh5zUkegjwEXQzGb+hFX8p3illPN5bdKGCqG8WPAq/QTu3J3LUShnABXTrJ8YVTNcEDKpHUkIQDvJ3ma/w73EZjKTD/1gr+uzCaQTCnutiCH0g9DOXfLR+3jQz3FF5VEybJ9HqMeEDHhEitR+ZecEOJmlukfAiXQWEpculEm/fGOamBNTyF1pV/VAMd3VRuXAVSEgqBtMmU9F/TzvitZeM0GUiLYRg+Q2C3Rie2LMPkgFleJw8nQx9i/gn70ahl7BJvj5AIkPyIykFayL
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 10:39:15.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bf9250-e590-46fa-8e34-08d77713e0ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5228
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add IPI mailbox property and its example in xilinx zynqmp-power
documentation.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
Changes in v2:
 - Correct order of tx and rx in mbox-names property.
 - Add interrupts property in example.
---
 .../bindings/power/reset/xlnx,zynqmp-power.txt     | 43 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
index d366f1e..0d74987 100644
--- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
@@ -8,18 +8,55 @@ Required properties:
  - compatible:		Must contain:	"xlnx,zynqmp-power"
  - interrupts:		Interrupt specifier
 
--------
-Example
--------
+Optional properties:
+ - mbox-names	: Name given to channels seen in the 'mboxes' property.
+		  "tx" - Mailbox corresponding to transmit path
+		  "rx" - Mailbox corresponding to receive path
+ - mboxes	: Standard property to specify a Mailbox. Each value of
+		  the mboxes property should contain a phandle to the
+		  mailbox controller device node and an args specifier
+		  that will be the phandle to the intended sub-mailbox
+		  child node to be used for communication. See
+		  Documentation/devicetree/bindings/mailbox/mailbox.txt
+		  for more details about the generic mailbox controller
+		  and client driver bindings. Also see
+		  Documentation/devicetree/bindings/mailbox/ \
+		  xlnx,zynqmp-ipi-mailbox.txt for typical controller that
+		  is used to communicate with this System controllers.
+
+--------
+Examples
+--------
+
+Example with interrupt method:
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		zynqmp_power: zynqmp-power {
+			compatible = "xlnx,zynqmp-power";
+			interrupts = <0 35 4>;
+		};
+	};
+};
+
+Example with IPI mailbox method:
 
 firmware {
+
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
 
 		zynqmp_power: zynqmp-power {
 			compatible = "xlnx,zynqmp-power";
+			interrupt-parent = <&gic>;
 			interrupts = <0 35 4>;
+			mboxes = <&ipi_mailbox_pmu0 0>,
+				 <&ipi_mailbox_pmu0 1>;
+			mbox-names = "tx", "rx";
 		};
 	};
 };
-- 
2.7.4

