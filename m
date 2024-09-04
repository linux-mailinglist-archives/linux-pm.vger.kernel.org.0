Return-Path: <linux-pm+bounces-13624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D231096C7C6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D963B22E61
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65011E6DFD;
	Wed,  4 Sep 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pzXcfKn/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE11E1A34
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478957; cv=none; b=FbivNDk86H/Hxs8COekXnwT2/C7AzzuNy4F2ayq7A8z4+12Imr1VLcR4QDPWt/ipRZW0JMFWe/vJ4i9oRfO3vrSDvyE6oSsUXfmMcVptcsf6A2sn0/uNY63dThHA/Y1oxZVWfCtONitJx0xE9wvgas4VvJr+qNU9vvai4qjmMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478957; c=relaxed/simple;
	bh=FYHeT28zz4duuhpxsBx++N1ZTkN35YM7LBrBqHavKOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grslgAddnKzovQ8bAdZk/CGSJG8MDERcJzVhO1vlFD4br6eAGyy3Jz41LBMO5CKHPuj4RxJucaxf/Gy2f5yxZeHXxrzvL1qsN9xyvjH0PBhfG7q3G7oHabXhCZ7P3v/4G840XNSUMrDtIuvLymefGafnMBQTAaz3REInML2QBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pzXcfKn/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so57481375e9.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725478954; x=1726083754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO5Rgqfe+XL1ianyGMrb5IryC3voMqtp1YHgBG6UnZM=;
        b=pzXcfKn/PCSHDdSJ2/e4hQByVl7XHtOwPtPN5WYaimVrMiH1q3e3UF0QxGibs1bOXo
         RB6SXr8cx2QUDmDKHLaS6GmK5liOdB026tLpFfq2fVHe8ulo82iihxcd8RPghZIB8mds
         O31uDEJtK/Ztx5/3Ool2pd8A6Vrq57SUeYsX3LziVOBXvg4dMmSuCHF7Yu3grZfyoPcn
         iaUyKG7BpWR5gPk7+jFw2HMLu6z1vSprXmYPqW/dIvaZoUJNJRvj+tTJK3eRKezfScvc
         /hvMBHst0P7OwzLc6L1O/6HYpZDm9hnSNqTfe/C87+ozVyKNBKaXajVSFnBeg3IeUTzx
         iMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478954; x=1726083754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO5Rgqfe+XL1ianyGMrb5IryC3voMqtp1YHgBG6UnZM=;
        b=kUh+Apc/+1zWr0A2Qk/g4jva0LJRgWUAGvI3ZpS6l0VPXlHbUojlNYcveFxFHlhiIm
         uVTuaoZZicQjiFgaALA6hZF+Qjin2DtFW9SJ+JG/jv4npMPtS+AyE4KC7eTe/H/27NgX
         R1Apl7tINcWximUZhLK4vquThBZYVYY1+to6YvBDOR6TKU/UEQn8er+YeUEguycDQhLx
         bfCjzBEGg6LzJlKW7BSKFyjy0b/a8Hb8cVLa8LwTMsLa387Vfo0nEPtcNb7auVcqAVfF
         Yuf4PxauHnJxrKXxaqa9uOW8PrBE5WYCLicCwH9vMlITq0S7lCpc/qVQOobhxWmiN6qp
         qClA==
X-Forwarded-Encrypted: i=1; AJvYcCVTO6IvxsKUIwL+61R6RXiiVdCoeLuFfpZpwZtoGOxvdz0L631Fr1tsq1oZn8V+symTRWYjPjsSWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMw1lN2vAFhQcvLCsPp/rA9b1T9CunMocVtQ6qXneU+zg0GmgN
	70doC0Fne+2Rf0bok+QXR7jj8Jiqw+4P6kL/vzFDrSeR0EdYaQdinTU46/LpbjY=
X-Google-Smtp-Source: AGHT+IGkKB08aumSpzNaWW32uZif/5E30MF7X6byCu8oKAoEQjqOt0VQDnEzLiH4I7ZvQSwmirG/Qw==
X-Received: by 2002:a05:600c:1c95:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42c7b59e7dfmr97812125e9.8.1725478954042;
        Wed, 04 Sep 2024 12:42:34 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c03595fcsm12473625f8f.98.2024.09.04.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:42:33 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Georgi Vlaev <g-vlaev@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v12 2/5] firmware: ti_sci: Add support for querying the firmware caps
Date: Wed,  4 Sep 2024 21:42:26 +0200
Message-ID: <20240904194229.109886-3-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904194229.109886-1-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georgi Vlaev <g-vlaev@ti.com>

Add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
the firmware capabilities of the currently running system firmware. The
message belongs to the TISCI general core message API [1] and is
available in SysFW version 08.04.03 and above. Currently, the message is
supported on devices with split architecture of the system firmware (DM
+ TIFS) like AM62x. Old revisions or not yet supported platforms will
NACK this request.

We're using this message locally in ti_sci.c to get the low power
features of the FW/SoC. As there's no other kernel consumers yet, this
is not added to struct ti_sci_core_ops.

Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability [2], where
Device Mgr firmware now manages which low power mode is chosen. Going
forward, this is the default configuration supported for TI AM62 family
of devices. The state chosen by the DM can be influenced by sending
constraints using the new LPM constraint APIs.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html
[2] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
[vibhore@ti.com: Support for LPM_DM_MANAGED mode]
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 73 ++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h | 22 ++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1f..d53192607709 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface Protocol Driver
  *
- * Copyright (C) 2015-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/sys_soc.h>
 #include <linux/reboot.h>
 
 #include "ti_sci.h"
@@ -98,6 +99,7 @@ struct ti_sci_desc {
  * @minfo:	Message info
  * @node:	list head
  * @host_id:	Host ID
+ * @fw_caps:	FW/SoC low power capabilities
  * @users:	Number of users of this instance
  */
 struct ti_sci_info {
@@ -114,6 +116,7 @@ struct ti_sci_info {
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
 	u8 host_id;
+	u64 fw_caps;
 	/* protected by ti_sci_list_mutex */
 	int users;
 };
@@ -1651,6 +1654,67 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
+ * @handle:		Pointer to TI SCI handle
+ * @fw_caps:		Each bit in fw_caps indicating one FW/SOC capability
+ *
+ * Check if the firmware supports any optional low power modes.
+ * Old revisions of TIFS (< 08.04) will NACK the request which results in
+ * -ENODEV being returned.
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
+					u64 *fw_caps)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_msg_resp_query_fw_caps *resp;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_QUERY_FW_CAPS,
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
+	resp = (struct ti_sci_msg_resp_query_fw_caps *)xfer->xfer_buf;
+
+	if (!ti_sci_is_response_ack(resp)) {
+		dev_err(dev, "Failed to get capabilities\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	if (fw_caps)
+		*fw_caps = resp->fw_caps;
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
@@ -3390,6 +3454,13 @@ static int ti_sci_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
+	dev_dbg(dev, "Detected firmware capabilities: %s%s%s\n",
+		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
+		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
+		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : ""
+	);
+
 	ti_sci_setup_ops(info);
 
 	ret = devm_register_restart_handler(dev, tisci_reboot_handler, info);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 5846c60220f5..73ca9503606b 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -19,6 +19,7 @@
 #define TI_SCI_MSG_WAKE_REASON	0x0003
 #define TI_SCI_MSG_GOODBYE	0x0004
 #define TI_SCI_MSG_SYS_RESET	0x0005
+#define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
 
 /* Device requests */
 #define TI_SCI_MSG_SET_DEVICE_STATE	0x0200
@@ -132,6 +133,27 @@ struct ti_sci_msg_req_reboot {
 	struct ti_sci_msg_hdr hdr;
 } __packed;
 
+/**
+ * struct ti_sci_msg_resp_query_fw_caps - Response for query firmware caps
+ * @hdr:	Generic header
+ * @fw_caps:	Each bit in fw_caps indicating one FW/SOC capability
+ *		MSG_FLAG_CAPS_GENERIC: Generic capability (LPM not supported)
+ *		MSG_FLAG_CAPS_LPM_PARTIAL_IO: Partial IO in LPM
+ *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
+ *
+ * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
+ * providing currently available SOC/firmware capabilities. SoC that don't
+ * support low power modes return only MSG_FLAG_CAPS_GENERIC capability.
+ */
+struct ti_sci_msg_resp_query_fw_caps {
+	struct ti_sci_msg_hdr hdr;
+#define MSG_FLAG_CAPS_GENERIC		TI_SCI_MSG_FLAG(0)
+#define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
+#define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
+#define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
+	u64 fw_caps;
+} __packed;
+
 /**
  * struct ti_sci_msg_req_set_device_state - Set the desired state of the device
  * @hdr:		Generic header
-- 
2.45.2


