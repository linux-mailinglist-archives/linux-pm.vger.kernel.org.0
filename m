Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F461F907D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 14:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKLNVh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 08:21:37 -0500
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:7264
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfKLNVh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 08:21:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzRdDmSRYYv8DDHuHECIxPeTc9gCyOYOsmaMJRq/HYOrhIGTk0Tm2T6ttrPoJIRZtfAJ7LNN1VhiTwQqj0hn86S1Artv54wsicduGakZfTW/nYZst+2aCgF8Dvr7yzyduhUvODybBZSlBZEJLYImLuwDPjRZ3vjPtr+Gx7uGYzh4yMClcyf8c3YjzKnBOq4HyqpTbsFi0EKbbNmgIv7O+mGP3np2hDjxrk+/KwhNH9+jCkK4IhIawE2Cvr7COpJGeTBE3e1yNb2gMwFmBCx0VPivFp+KOKr2EyodUlBJwsBNyLdQyBYaXOfosLa9jF1ZdjC1OC313K/wUxFgYFfqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgqxPs4s049Nu3VOR1et90OOfPB4rIKPyCovfxt1jI0=;
 b=H0xjpyBTlUspGK0vgUOlJj9PwfodBPGzwODBRQ7ihBcNEO9nXB7GvDNci7kpV4KzYg7i0W7yAirdX41bb0DIJTTADRMFOxrhiMhSELBFXvp9/YJgHRnCTsWG/NNrkChay571mnaGZgxn0RMGo2wrMIaVsOwar//dMRCYBWw26SabKJS5vkQxja7uuPgLVIdzwpXdY0/GiBSyHElr1wdSMOBeRFDBZvVLyZyE+DejSz+canxy7TdH0ki4KuqhswKN3nc2jw692tLQiN82EzSb7OL8GCqVxejRbj/4NeXEXC9v0DKBwIzN31flq3VmdEzZjzsVyqMhiPAWTTt2lDccXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgqxPs4s049Nu3VOR1et90OOfPB4rIKPyCovfxt1jI0=;
 b=C2/xdRaPMvloeMhIpjGsBl5FZ3K95Fe0o8UzHMH7OiRrq0NJNUTvCTOPRXUObvwSeI+mS2XIdIwAKKhkO1nlVv+vzF7gsuX51D8FNFyrDTASlklVndRwZqvYkSaC73eUtlGXk/mp0P/r/Mj7jB0uvMuphhIZYw28yzO7kjwNSJs=
Received: from BL0PR02CA0097.namprd02.prod.outlook.com (2603:10b6:208:51::38)
 by BY5PR02MB6083.namprd02.prod.outlook.com (2603:10b6:a03:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Tue, 12 Nov
 2019 13:21:32 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BL0PR02CA0097.outlook.office365.com
 (2603:10b6:208:51::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24 via Frontend
 Transport; Tue, 12 Nov 2019 13:21:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 13:21:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW6s-0003vM-Uo; Tue, 12 Nov 2019 05:21:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW6n-0005Bb-RI; Tue, 12 Nov 2019 05:21:25 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xACDLIkg023637;
        Tue, 12 Nov 2019 05:21:18 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iUW6g-000578-8W; Tue, 12 Nov 2019 05:21:18 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jollys@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH 2/2] drivers: soc: xilinx: Use mailbox IPI callback
Date:   Tue, 12 Nov 2019 05:20:51 -0800
Message-Id: <1573564851-9275-3-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573564851-9275-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564851-9275-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(426003)(186003)(446003)(11346002)(36756003)(6666004)(356004)(107886003)(50466002)(16586007)(7696005)(5660300002)(76176011)(51416003)(336012)(48376002)(305945005)(47776003)(44832011)(486006)(106002)(2616005)(476003)(126002)(316002)(26005)(4326008)(478600001)(81166006)(81156014)(2906002)(36386004)(6636002)(9786002)(14444005)(70586007)(50226002)(15650500001)(8676002)(70206006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6083;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6549f1e9-d29c-4b1b-583b-08d767733bbd
X-MS-TrafficTypeDiagnostic: BY5PR02MB6083:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6083B48F771C2251CDC0298AB7770@BY5PR02MB6083.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dZv0yBZ/xvbMQZURBxzP7oNMX74rI2oyt2aN81LJM58L9tpfgsFKQoVcE3YvXqncQeqHZrArSsPwd3yYnbx486XLBcuc3+7ToWDEo+0vsIUgrSkGO/UJ+R2tSeHlTsUw2TdugVnBR7XUAoqjmodW1TOvhKevxz/Sn6X2Qg+6iOMOREImbrjNOa7XtgpVYkREsolO17es4U2THpBD7SPqLvkpiaV+gdwYJmW8Cf0/EW7KO2klJCWZjv2bO1bFzwC+RfwvMkDpT1MEddiBwImWGs9R8Un/DdcBPO95NxYC/4YG9oBzBIcNQKvjky7eCgsPa9CqnWtLiZWpG7dkDW9xmL4lkrZO7JMAVI7QfFjMkE4pTN1eblI1IPgoidQc5wzCP6DMpKBKHS+lr/ELZgI0BI3j7hZheXIac7qVQ1GVeQrNESikkAcKXhWArBe3QwZ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 13:21:31.4977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6549f1e9-d29c-4b1b-583b-08d767733bbd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6083
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Add support for init suspend callback through mailbox IPI callback.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/soc/xilinx/zynqmp_power.c | 119 +++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 1b9d144..d572d2e 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -2,7 +2,7 @@
 /*
  * Xilinx Zynq MPSoC Power Management
  *
- *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *  Copyright (C) 2014-2019 Xilinx, Inc.
  *
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
@@ -16,6 +16,20 @@
 #include <linux/suspend.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
+
+/**
+ * struct zynqmp_pm_work_struct - Wrapper for struct work_struct
+ * @callback_work:	Work structure
+ * @args:		Callback arguments
+ */
+struct zynqmp_pm_work_struct {
+	struct work_struct callback_work;
+	u32 args[CB_ARG_CNT];
+};
+static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
+static struct mbox_chan *rx_chan;
+static const struct zynqmp_eemi_ops *eemi_ops;
 
 enum pm_suspend_mode {
 	PM_SUSPEND_MODE_FIRST = 0,
@@ -31,7 +45,6 @@ static const char *const suspend_modes[] = {
 };
 
 static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
-static const struct zynqmp_eemi_ops *eemi_ops;
 
 enum pm_api_cb_id {
 	PM_INIT_SUSPEND_CB = 30,
@@ -68,6 +81,53 @@ static irqreturn_t zynqmp_pm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void ipi_receive_callback(struct mbox_client *cl, void *data)
+{
+	struct zynqmp_ipi_message *msg = (struct zynqmp_ipi_message *)data;
+	u32 payload[CB_PAYLOAD_SIZE];
+	int ret;
+
+	memcpy(payload, msg->data, sizeof(msg->len));
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
+			return;
+
+		/* Copy callback arguments into work's structure */
+		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
+		       sizeof(zynqmp_pm_init_suspend_work->args));
+
+		queue_work(system_unbound_wq,
+			   &zynqmp_pm_init_suspend_work->callback_work);
+
+		/* Send NULL message to mbox controller to ack the message */
+		ret = mbox_send_message(rx_chan, NULL);
+		if (ret)
+			pr_err("IPI ack failed. Error %d\n", ret);
+	}
+}
+
+/**
+ * zynqmp_pm_init_suspend_work_fn - Initialize suspend
+ * @work:	Pointer to work_struct
+ *
+ * Bottom-half of PM callback IRQ handler.
+ */
+static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
+{
+	struct zynqmp_pm_work_struct *pm_work =
+		container_of(work, struct zynqmp_pm_work_struct, callback_work);
+
+	if (pm_work->args[0] == SUSPEND_SYSTEM_SHUTDOWN) {
+		orderly_poweroff(true);
+	} else if (pm_work->args[0] == SUSPEND_POWER_REQUEST) {
+		pm_suspend(PM_SUSPEND_MEM);
+	} else {
+		pr_err("%s Unsupported InitSuspendCb reason code %d.\n",
+		       __func__, pm_work->args[0]);
+	}
+}
+
 static ssize_t suspend_mode_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -119,6 +179,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 {
 	int ret, irq;
 	u32 pm_api_version;
+	struct mbox_client *client;
 
 	eemi_ops = zynqmp_pm_get_eemi_ops();
 	if (IS_ERR(eemi_ops))
@@ -134,17 +195,46 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	if (pm_api_version < ZYNQMP_PM_VERSION)
 		return -ENODEV;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
-
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, zynqmp_pm_isr,
-					IRQF_NO_SUSPEND | IRQF_ONESHOT,
-					dev_name(&pdev->dev), &pdev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed "
-			"with %d\n", irq, ret);
-		return ret;
+	if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
+		zynqmp_pm_init_suspend_work =
+			devm_kzalloc(&pdev->dev,
+				     sizeof(struct zynqmp_pm_work_struct),
+				     GFP_KERNEL);
+		if (!zynqmp_pm_init_suspend_work)
+			return -ENOMEM;
+
+		INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
+			  zynqmp_pm_init_suspend_work_fn);
+		client = devm_kzalloc(&pdev->dev, sizeof(*client), GFP_KERNEL);
+		if (!client)
+			return -ENOMEM;
+
+		client->dev = &pdev->dev;
+		client->rx_callback = ipi_receive_callback;
+
+		rx_chan = mbox_request_channel_byname(client, "rx");
+		if (IS_ERR(rx_chan)) {
+			dev_err(&pdev->dev, "Failed to request rx channel\n");
+			return IS_ERR(rx_chan);
+		}
+	} else if (of_find_property(pdev->dev.of_node, "interrupts", NULL)) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq <= 0)
+			return -ENXIO;
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						zynqmp_pm_isr,
+						IRQF_NO_SUSPEND | IRQF_ONESHOT,
+						dev_name(&pdev->dev),
+						&pdev->dev);
+		if (ret) {
+			dev_err(&pdev->dev, "devm_request_threaded_irq '%d' "
+					    "failed with %d\n", irq, ret);
+			return ret;
+		}
+	} else {
+		dev_err(&pdev->dev, "Required property not found in DT node\n");
+		return -ENOENT;
 	}
 
 	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
@@ -160,6 +250,9 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
 {
 	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
 
+	if (!rx_chan)
+		mbox_free_channel(rx_chan);
+
 	return 0;
 }
 
-- 
2.7.4

