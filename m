Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F0576E06F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjHCGn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 02:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjHCGnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 02:43:23 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA031982;
        Wed,  2 Aug 2023 23:43:21 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3736hCap038902;
        Thu, 3 Aug 2023 01:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691044992;
        bh=db6Q2CiFr4T/Bymb0zBQ3cBID7qnYqEuVDhfoao++nw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bb82tHn7zdms17HN2Bu6rx7eDFQFp5WOGEDw5ZjuIA2/UILwUcN5Sp89yp0Azlpz/
         szKwzGcaVqD4KfJK6sliBul0vrq2guhYWOHVl/zGOu/M6WkbwMPBkwHObEzk7YS2RK
         obmLDlIoc7p8gAz0dR2hI/XPNCa9gjsbBKPabPmY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3736hCu2024857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 01:43:12 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 01:43:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 01:43:11 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3736hAop057666;
        Thu, 3 Aug 2023 01:43:11 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Praneeth Bajjuri" <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH V6 1/4] firmware: ti_sci: Introduce Power Management Ops
Date:   Thu, 3 Aug 2023 12:12:44 +0530
Message-ID: <20230803064247.503036-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803064247.503036-1-d-gole@ti.com>
References: <20230803064247.503036-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Introduce power management ops supported by the TISCI
Low Power Mode API [1]. These messages are currently
supported only on AM62x platforms.

1) TISCI_MSG_PREPARE_SLEEP
Prepare the SOC for entering into a low power mode and
provide details to firmware about the state being entered.

2) TISCI_MSG_LPM_WAKE_REASON
Get which wake up source woke the SoC from Low Power Mode.
The wake up source IDs will be common for all K3 platforms.

3) TISCI_MSG_SET_IO_ISOLATION
Control the IO isolation for Low Power Mode.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
[g-vlaev@ti.com: LPM_WAKE_REASON and IO_ISOLATION support]
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/firmware/ti_sci.c              | 175 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  64 ++++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  44 +++++++
 3 files changed, 282 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 26a37f47f4ca..31a71613ca54 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1664,6 +1664,176 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_prepare_sleep() - Prepare system for system suspend
+ * @handle:		pointer to TI SCI handle
+ * @mode:		Device identifier
+ * @ctx_lo:		Low part of address for context save
+ * @ctx_hi:		High part of address for context save
+ * @debug_flags:	Debug flags to pass to firmware
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
+				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_prepare_sleep *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
+	req->mode = mode;
+	req->ctx_lo = ctx_lo;
+	req->ctx_hi = ctx_hi;
+	req->debug_flags = debug_flags;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_msg_cmd_lpm_wake_reason() - Get the wakeup source from LPM
+ * @handle:		Pointer to TI SCI handle
+ * @source:		The wakeup source that woke the SoC from LPM
+ * @timestamp:		Timestamp of the wakeup event
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_msg_cmd_lpm_wake_reason(const struct ti_sci_handle *handle,
+					  u32 *source, u64 *timestamp)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_msg_resp_lpm_wake_reason *resp;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_WAKE_REASON,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(struct ti_sci_msg_hdr),
+				   sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_resp_lpm_wake_reason *)xfer->xfer_buf;
+
+	if (!ti_sci_is_response_ack(resp)) {
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	if (source)
+		*source = resp->wake_source;
+	if (timestamp)
+		*timestamp = resp->wake_timestamp;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_set_io_isolation() - Enable IO isolation in LPM
+ * @handle:		Pointer to TI SCI handle
+ * @state:		The desired state of the IO isolation
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
+				       u8 state)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_set_io_isolation *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_SET_IO_ISOLATION,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_set_io_isolation *)xfer->xfer_buf;
+	req->state = state;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
 static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
 {
 	struct ti_sci_info *info;
@@ -2806,6 +2976,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
+	struct ti_sci_pm_ops *pmops = &ops->pm_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
@@ -2845,6 +3016,10 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	cops->set_freq = ti_sci_cmd_clk_set_freq;
 	cops->get_freq = ti_sci_cmd_clk_get_freq;
 
+	pmops->prepare_sleep = ti_sci_cmd_prepare_sleep;
+	pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
+	pmops->set_io_isolation = ti_sci_cmd_set_io_isolation;
+
 	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
 	rm_core_ops->get_range_from_shost =
 				ti_sci_cmd_get_resource_range_from_shost;
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ef3a8214d002..e4bfe146c43d 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -6,7 +6,7 @@
  * The system works in a message response protocol
  * See: http://processors.wiki.ti.com/index.php/TISCI for details
  *
- * Copyright (C)  2015-2016 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C)  2015-2022 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __TI_SCI_H
@@ -35,6 +35,11 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Low Power Mode Requests */
+#define TI_SCI_MSG_PREPARE_SLEEP       0x0300
+#define TI_SCI_MSG_LPM_WAKE_REASON	0x0306
+#define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
+
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
 
@@ -545,6 +550,63 @@ struct ti_sci_msg_resp_get_clock_freq {
 	u64 freq_hz;
 } __packed;
 
+#define TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP				0x0
+#define TISCI_MSG_VALUE_SLEEP_MODE_MCU_ONLY				0x1
+#define TISCI_MSG_VALUE_SLEEP_MODE_STANDBY				0x2
+
+/**
+ * struct tisci_msg_prepare_sleep_req - Request for TISCI_MSG_PREPARE_SLEEP.
+ *
+ * @hdr				TISCI header to provide ACK/NAK flags to the host.
+ * @mode			Low power mode to enter.
+ * @ctx_lo			Low 32-bits of physical pointer to address to use for context save.
+ * @ctx_hi			High 32-bits of physical pointer to address to use for context save.
+ * @debug_flags			Flags that can be set to halt the sequence during suspend or
+ *				resume to allow JTAG connection and debug.
+ *
+ * This message is used as the first step of entering a low power mode. It
+ * allows configurable information, including which state to enter to be
+ * easily shared from the application, as this is a non-secure message and
+ * therefore can be sent by anyone.
+ */
+struct ti_sci_msg_req_prepare_sleep {
+	struct ti_sci_msg_hdr	hdr;
+	u8			mode;
+	u32			ctx_lo;
+	u32			ctx_hi;
+	u32			debug_flags;
+} __packed;
+
+/**
+ * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
+ *
+ * @hdr:		Generic header.
+ * @wake_source:	The wake up source that woke soc from LPM.
+ * @wake_timestamp:	Timestamp at which soc woke.
+ *
+ * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
+ * used to query the wake up source from low power mode.
+ */
+struct ti_sci_msg_resp_lpm_wake_reason {
+	struct ti_sci_msg_hdr hdr;
+	u32 wake_source;
+	u64 wake_timestamp;
+} __packed;
+
+/**
+ * struct tisci_msg_set_io_isolation_req - Request for TI_SCI_MSG_SET_IO_ISOLATION.
+ *
+ * @hdr:	Generic header
+ * @state:	The deseared state of the IO isolation.
+ *
+ * This message is used to enable/disable IO isolation for low power modes.
+ * Response is generic ACK / NACK message.
+ */
+struct ti_sci_msg_req_set_io_isolation {
+	struct ti_sci_msg_hdr hdr;
+	u8 state;
+} __packed;
+
 #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index bd0d11af76c5..f2d1d74ab8fc 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -195,6 +195,49 @@ struct ti_sci_clk_ops {
 			u64 *current_freq);
 };
 
+/* TISCI LPM wake up sources */
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_CAN_IO		0x82
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_INVALID		0xFF
+
+/* TISCI LPM IO isolation control values */
+#define TISCI_MSG_VALUE_IO_ENABLE			1
+#define TISCI_MSG_VALUE_IO_DISABLE			0
+
+/**
+ * struct ti_sci_pm_ops - Low Power Mode (LPM) control operations
+ * @prepare_sleep: Prepare to enter low power mode
+ *		- mode: Low power mode to enter.
+ *		- ctx_lo: Low 32-bits of physical address for context save.
+ *		- ctx_hi: High 32-bits of physical address for context save.
+ *		- ctx_lo: 'true' if frequency change is desired.
+ *		- debug_flags: JTAG control flags for debug.
+ * @lpm_wake_reason: Get the wake up source that woke the SoC from LPM
+ *		- source: The wake up source that woke soc from LPM.
+ *		- timestamp: Timestamp at which soc woke.
+ * @set_io_isolation: Enable or disable IO isolation
+ *		- state: The desired state of the IO isolation.
+ */
+struct ti_sci_pm_ops {
+	int (*prepare_sleep)(const struct ti_sci_handle *handle, u8 mode,
+			     u32 ctx_lo, u32 ctx_hi, u32 flags);
+	int (*lpm_wake_reason)(const struct ti_sci_handle *handle,
+			       u32 *source, u64 *timestamp);
+	int (*set_io_isolation)(const struct ti_sci_handle *handle,
+				u8 state);
+};
+
 /**
  * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
  * @start:	Start index of the first resource range.
@@ -539,6 +582,7 @@ struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
+	struct ti_sci_pm_ops pm_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
 	struct ti_sci_rm_irq_ops rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops rm_ring_ops;
-- 
2.34.1

