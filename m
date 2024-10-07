Return-Path: <linux-pm+bounces-15246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33B992434
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB601F22CA1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757AB155C88;
	Mon,  7 Oct 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DST6YJZs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43F145FE5
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281391; cv=none; b=e+OKHeYqNUmRYPS1bqQpsBlzC1uDCbiR3ddjzagN37U362rHxO4hNJnC6qkH7mDUl8sUp80/J38gYRHjghM1VtM+flPofszs6qCH8M66YQoQuJP+yYlUZSVhWwXkgbkq0T4aSNzhh5yepBIxvhrEaXnsA3+ZPgUdggx9YNQfKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281391; c=relaxed/simple;
	bh=EGwzc5Owsx+/bhXk0PXhY0C7yU90OavS7hMS3djDrBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stoli1i2aSVX45yz4BSg9MwzY1/GG648PxzuoiC1EaaKMMT/+aYah+LPmIlgbTvR3nfmpQ1+tsLhwX13MtMy2YxlXIG+UxU0Lio94apAUy9qdfl/FZ61kNgcTq6qlaTA/gJ3uPxND4l74p0EomvEhf3mltFw6U7LIVAVqjz/JO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DST6YJZs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so6551105a12.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2024 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728281387; x=1728886187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbLe30orUJnLewx69pgAOzw2IbndS0py8yVdX7I2BLo=;
        b=DST6YJZs7e8+7B93cxQCiBp5FXjss64Imke+MKIXbUT08fNH8anMB9LsjRgW2wJIli
         tSurcSfYycmx5zQm0n/NbUjKOWgawoJjiDl+h2w4InpEnh7kSjZASZnk6A3gB1tfUN9k
         V3hN5yvgF3UZ1HnqbXxJ9ST+lq9MLBXKJENeGHrsSHNzdLPJth+jw5kh1gDmCwfEduPs
         P1RGVXzmdbHEVDQwrS6btOcvYgEHs0atx9xjvNIm5rAkyXwvq8bhVaYRG4E4amgE6lgs
         nXST7F/YDLC4To2uzee+e2gBRnZISOP2MNtKkobP1e6JF4N9FQNf9lmq3MllunifXyxF
         eL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281387; x=1728886187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbLe30orUJnLewx69pgAOzw2IbndS0py8yVdX7I2BLo=;
        b=EWCR6K8sHvtD7zo3WQ4zaCYc15awCoHoqbRVnS/ATdGL+6JGIMYnA7d5/rgABI+p0n
         fpBKyBnGsdrKItUvaYKs0Hg3Jn/qVdLpId6o2BYnivjQSazoOGNWY3ZOQiPefPx+a3iV
         qWhsiJ6oLxyBFxoskJUWg7UDNkwi0G9kqj+aFDbYD4Ju3AdreS2Kp0HyDDDQPHrpzoY5
         C2DGgUUsQVyLYLy3C6rUjUoL0/6kGNN50ngx2B4G/VuYZSPeE6a2cRiKO5uTgMnwz0up
         0FjOcWyu8fwWXC6v/iXWbNlPVXjJA27Y/q5a0BF6fQcAbVcyrFHEYzBLYRoyFsKLsA9V
         8TXg==
X-Gm-Message-State: AOJu0YyIvSB+7VqOupbTX9WAin3Ll7rTfbTDzJ/4lm+Ju7irY8lKR9xX
	6Yu32/eMAnFShicVmCDC2PdmpAjE4sQrQaSuMCeI6MfkE1Cqz1E8VUsyXes8lN4=
X-Google-Smtp-Source: AGHT+IEN+KwoLOFHpFSpg/JH01HwsgZgHyg31disEZr/iuiHpcFj3zR3tdPPH2bqouBr2wcVZllMZg==
X-Received: by 2002:a05:6402:90b:b0:5c5:bda7:c839 with SMTP id 4fb4d7f45d1cf-5c8c0a83ef5mr17222386a12.17.1728281386737;
        Sun, 06 Oct 2024 23:09:46 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f3b8bsm2784431a12.89.2024.10.06.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:09:46 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 07 Oct 2024 08:08:55 +0200
Subject: [PATCH v13 2/5] firmware: ti_sci: Add support for querying the
 firmware caps
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-tisci-syssuspendresume-v13-2-ed54cd659a49@baylibre.com>
References: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
In-Reply-To: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6798; i=msp@baylibre.com;
 h=from:subject:message-id; bh=vd+yKE3a6fH3kGb9+/6lAhLX5D8QyxAs3GjZFq/gpzA=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNKZq4WKHzRt5y6IuT0r3XZJ1+32ZRPi9s4sevl2wkWhL
 RJVZYc+dpSyMIhxMMiKKbLc/bDwXZ3c9QUR6x45wsxhZQIZwsDFKQATuabOyPDXu8J+09Temaon
 hCeY/cw89Gyj3/fFsyWuLWZL2/ffdp08wy9mma/H3Avvxp55oF5ve/PyynpTje8L+Fr3Nf3ZvFv
 +XggTAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

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
 drivers/firmware/ti_sci.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h | 22 ++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1fbc4142c18a10048aaa933e4b9c91..d53192607709c1a4773c6210a238505e5849f775 100644
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
index 5846c60220f50c82a66ba268bb44e6d0e76382b1..73ca9503606b345c08b9b543f2d3474ad1d5f698 100644
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


