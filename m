Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C63106844
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 09:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKVIpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 03:45:40 -0500
Received: from mail-eopbgr730064.outbound.protection.outlook.com ([40.107.73.64]:34807
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfKVIpk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Nov 2019 03:45:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH8FyaXr0cHccTUPg6JL9bc6plruk2TcAptILPFARiZhwPC2Y0iQtZcBzmGLm9Vi1+jBfY7CcsIAuJHYbWm3xyqqQeHPMpmxl7A6jToeM1fv3BhF0Gw9toEc/UNsPs0juJjV0KSf0UfRgOD1YGcTF/cK7IuMKvrVHy77nagJDHW7nYGfaBgC3mkBMWVaJkwET3ft65oJQ/zDeanmvJeGOUCEEgx/65qTi7GAS3bts2gYwwg5Yed4Nw+kFPqrJlyMzywro3MRdP/dJsMgo9jp6QVitG+tjeXowQzGn3cONXLeYvZC9k5gVAEls9IhQd98zVIX/CL0yO/VGM7HAywM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgqxPs4s049Nu3VOR1et90OOfPB4rIKPyCovfxt1jI0=;
 b=CWHQr1S8rYChMIv04ijyCKJCopacICoZUH0ZIXzm4j7hMgkSURuPfJEgFeW8uqu8fTMwueQ+GWzMxhXEy49Q8PSq3UFIkk3e/lWBFpdL9aGBMMIRybBbvzEp/h2ZflXVX+0XwOLwWWOTeEaJgWxS7McCk9Io2/AKhLLOyraU2cju4xKW7Xdqn5YZMxPnJ6krxWRvZ1nMzjbkW86y2ZiqLcBT9iXzN8wyvIcHhSeeKzLM5G0K1JNn2c2yOue4UUR8eBTu+ivPtMNQw/iKS5UqmT+yzlpw0M12FrflDGoUs+o+rWC5jsp9O6Cu5G+ORT7bmxbl/Jsi40wdeB1U2v/xVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgqxPs4s049Nu3VOR1et90OOfPB4rIKPyCovfxt1jI0=;
 b=Xa/gfqgkqWh+ACR7Dq4m4bRq3OH/iMOPL55M9kIjgRLOWeVy5uPJ13GIbPQIXPR7eRTu8j5qhIK5AYA1UNORpLaurLw0APrAQdE8n8gzLA2kxjev2kFxoGrfl7CuOM5S/xOTH8Kxh5n3AQSZ3kPtXA52wj1ijG5IrBZlsvXXhGo=
Received: from SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) by BL0PR02MB3636.namprd02.prod.outlook.com
 (2603:10b6:207:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Fri, 22 Nov
 2019 08:45:34 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0055.outlook.office365.com
 (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Fri, 22 Nov 2019 08:45:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 08:45:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY4ZI-0006UU-Rp; Fri, 22 Nov 2019 00:45:32 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY4ZD-00053U-P7; Fri, 22 Nov 2019 00:45:27 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAM8jLUU023112;
        Fri, 22 Nov 2019 00:45:22 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1iY4Z7-00052Z-Qg; Fri, 22 Nov 2019 00:45:21 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jollys@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v2 2/2] drivers: soc: xilinx: Use mailbox IPI callback
Date:   Fri, 22 Nov 2019 00:44:18 -0800
Message-Id: <1574412258-17988-3-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574412258-17988-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573564851-9275-1-git-send-email-rajan.vaja@xilinx.com>
 <1574412258-17988-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(44832011)(6636002)(11346002)(426003)(36756003)(446003)(76176011)(15650500001)(107886003)(186003)(47776003)(478600001)(4326008)(2616005)(336012)(2906002)(50466002)(70206006)(106002)(70586007)(305945005)(14444005)(51416003)(7696005)(81156014)(5660300002)(356004)(8676002)(26005)(50226002)(81166006)(9786002)(36386004)(8936002)(316002)(16586007)(48376002)(6666004)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3636;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27ee9a99-7108-42e5-1a26-08d76f285682
X-MS-TrafficTypeDiagnostic: BL0PR02MB3636:
X-Microsoft-Antispam-PRVS: <BL0PR02MB36369AAF9E1F63AE1B9BEA6CB7490@BL0PR02MB3636.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sdblQGJjLs9ZTlpvfuux3Pkn29ZAjSYd7zG/ayBTnwwV8CS+Y3Q+SXriI0LTnGsqao3410LfkG0iLYYHCUzjDWioLJahH6r2MehZpNw2buyz6hpCi9Wm4jwx90ZpwwFL8dSTb7FONK+W59RZ87fB71d7SvBPiXUYxqQPTDOmh5fuy7+0FxzT1PaTZy39A+uE0PEOkYyac2f1+EBUqkhGhz/+i7oYKlZ69fkkIdY6LnpIZIL7889hy62CZP+F49KJ91HL1Z/5GZ7PanSRN8Yu47FmCVhY06pjCLJn+2BJAOuuj8g4QIY5K6wzd/zsJChiGf9J8JezVBCS3wAK26LXzO6wyT8lkRLV1UI9pQhKAtisycCimEmclrw2PwEYaKAxqeptp/mUvvPm6BdixRoc1VJ1bcZi6vsf29zzviSrZcok7bYSO3sYGYGKvmANBQl
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 08:45:33.5475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ee9a99-7108-42e5-1a26-08d76f285682
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3636
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

