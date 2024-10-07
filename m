Return-Path: <linux-pm+bounces-15248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C30E992438
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 08:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409A4281934
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3230165EE6;
	Mon,  7 Oct 2024 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JOIYIZ4Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE1154429
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281393; cv=none; b=F86EZdEZfGsgYtvACDfWq8kO5Z+gMIhdxxj1UqFkOdL4Qrc1ANgdeIObHVR/tKQgaojgAYqTTTfCf46nRhWToqDKaDJQ4DzO2lYmuEap/UIDejHc1vNqWXXCHm+RCtXHncL9oUdLeF4jj3zuW5G0mKIW1lqVAicw48hmkQm/6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281393; c=relaxed/simple;
	bh=YnIgYzCsjv4YsOx/PH6zDO7Z2Z02UNLocUsPwMksgvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnMWn8RBt75Y4+ZsEiWJuP+ApiDCGDfd9LMz4b/voBxWtNQ8IYVdQatEzSx+B1lk0at4o4z1gSCqvG8nsnY3NnRSsdk+add26xdgX6HpAx8XbAkIdLH5P7zDO++27bpJs0/AvI2NPzPam/pJb3YRbXFmx687xgtLa1ih6yD20yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JOIYIZ4Z; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso51480871fa.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Oct 2024 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728281389; x=1728886189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNCyieTZONeCqAD/uOy5xYBZvQq35ipUwWyUbw1u/v8=;
        b=JOIYIZ4ZHZwn8fIEJtx9s5bjlXwHDTFn42o6GtNOFC8oNrOxJyo94smuGWxjKdaRvE
         D8USICMfoFBAbxo+YnbJNKxiDb42x4WqFwkzI5YfCckCyZPAa0ZUblbyw0m2LmoiJXL8
         DOzzSUvL/EIOXEMQ+PKReAqTjRTsxbKY1olWS2/4AlF5YRTyIlfCAmI3I8Tr+Al2af/O
         NJYjj4scUcDanVcUIaYBgOqb0z0oQ7XwxPYkkR6yLW6ANPktD2VWOgSaPFtuJz7R4QN9
         6Y3c/00Ug5bH6fpmxOL5MvsMR/13zt2+9S7UQxwO6xRGNEA58AsfHRsz5XcvvAlcwx4s
         pwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281389; x=1728886189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNCyieTZONeCqAD/uOy5xYBZvQq35ipUwWyUbw1u/v8=;
        b=xVP04scmQ5dA53j6SHUoF742KVPqKvC0hp9t7DN6a0zh84fWdaRGnqVMQolvH5TiOO
         5vHG1qS7RYLwvj0tA7/WW9xkL3+Q7i3DV2r1Eykrzb/RTcUS/dFAJEcrU9WoB20bCfnJ
         SMgkzJAJYIvN6QzkP6iNTHlDSTpHXSmn9bbjMcnj50ZtZ12ngtCxJH+qSGlNyL5El/ZB
         L0N7PEvSYS03A6/PQcu+Sdws5p5Bh6Q97dGCSORuekxpzQYv7D5/uRayoMV/ehhPiFyY
         M6VxGDaTvMhAh5oFlaE2mvUP+4o3qQBi3r98k2B/Wwk7Z4M53czvzlTJr+m67+CeUy7I
         IWZA==
X-Gm-Message-State: AOJu0YyIW74eCk4Pk/TfCnPAqlRkJdjiLzXNuJ0dbnIDeSpm3TYkFeCb
	zdZdPFbN53wnsSH6CNWKtKOXv5NjE5W+x7E3AxICEiSlWy6KkGYCFhvOAapjeeM=
X-Google-Smtp-Source: AGHT+IEplPh3COtqRonvHHnDgfLDH5/rqAXvmukelBMAmz/GNWJDq8g2mMi+RGSTv7G9ssQLlQY3qQ==
X-Received: by 2002:a05:6512:31c8:b0:539:9510:2b8a with SMTP id 2adb3069b0e04-539ab9e6d07mr6734487e87.53.1728281389015;
        Sun, 06 Oct 2024 23:09:49 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994c956b2asm170493566b.0.2024.10.06.23.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:09:48 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 07 Oct 2024 08:08:57 +0200
Subject: [PATCH v13 4/5] firmware: ti_sci: Introduce Power Management Ops
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-tisci-syssuspendresume-v13-4-ed54cd659a49@baylibre.com>
References: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
In-Reply-To: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14376; i=msp@baylibre.com;
 h=from:subject:message-id; bh=2CW4DkhiaXDsgq9VGgtcLmFraQDSNnnAQzB+OkkiVB4=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNKZq2U2xvjG/Zgy4WWUftCL6giJyN0TLZN2fUw6Fnnjv
 E3H6+tbO0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJ8Dxh+O/GrXap6bBI0O9P
 dltml8ZpfXgzf3cCT3zgG0+rumUzFxxlZDgmKhg5eema7nl3HviYWVqJtV5LsWpQkWwL9z54WU2
 cnQEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

From: Dave Gerlach <d-gerlach@ti.com>

Introduce power management ops supported by the TISCI
Low Power Mode API [1].

1) TISCI_MSG_LPM_WAKE_REASON
Get which wake up source woke the SoC from Low Power Mode.
The wake up source IDs will be common for all K3 platforms.

2) TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT
Set LPM constraint on behalf of a device. By setting a constraint, the
device ensures that it will not be powered off or reset in the selected
mode.

3) TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT
Set LPM resume latency constraint. By setting a constraint, the host
ensures that the resume time from selected mode will be less than the
constraint value.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[g-vlaev@ti.com: LPM_WAKE_REASON and IO_ISOLATION support]
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
[a-kaur@ti.com: SET_DEVICE_CONSTRAINT support]
Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
[vibhore@ti.com: SET_LATENCY_CONSTRAINT support]
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Akashdeep Kaur <a-kaur@ti.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c              | 198 +++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  76 +++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  26 +++++
 3 files changed, 300 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ebf6c0756ba450b398da82a972bd8ce79c6aec4c..b67c35c93802b50ed3ba7b97a216fb39d6c46ebc 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1833,6 +1833,186 @@ static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_msg_cmd_lpm_wake_reason() - Get the wakeup source from LPM
+ * @handle:		Pointer to TI SCI handle
+ * @source:		The wakeup source that woke the SoC from LPM
+ * @timestamp:		Timestamp of the wakeup event
+ * @pin:		The pin that has triggered wake up
+ * @mode:		The last entered low power mode
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_msg_cmd_lpm_wake_reason(const struct ti_sci_handle *handle,
+					  u32 *source, u64 *timestamp, u8 *pin, u8 *mode)
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
+		dev_err(dev, "Failed to get wake reason\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	if (source)
+		*source = resp->wake_source;
+	if (timestamp)
+		*timestamp = resp->wake_timestamp;
+	if (pin)
+		*pin = resp->wake_pin;
+	if (mode)
+		*mode = resp->mode;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_set_device_constraint() - Set LPM constraint on behalf of a device
+ * @handle:	pointer to TI SCI handle
+ * @id:	Device identifier
+ * @state:	The desired state of device constraint: set or clear
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_set_device_constraint(const struct ti_sci_handle *handle,
+					    u32 id, u8 state)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_lpm_set_device_constraint *req;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_lpm_set_device_constraint *)xfer->xfer_buf;
+	req->id = id;
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
+	if (!ti_sci_is_response_ack(resp)) {
+		dev_err(dev, "Failed to set device constraint\n");
+		ret = -ENODEV;
+	}
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_set_latency_constraint() - Set LPM resume latency constraint
+ * @handle:	pointer to TI SCI handle
+ * @latency:	maximum acceptable latency (in ms) to wake up from LPM
+ * @state:	The desired state of latency constraint: set or clear
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
+					     u16 latency, u8 state)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_lpm_set_latency_constraint *req;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_lpm_set_latency_constraint *)xfer->xfer_buf;
+	req->latency = latency;
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
+	if (!ti_sci_is_response_ack(resp)) {
+		dev_err(dev, "Failed to set device constraint\n");
+		ret = -ENODEV;
+	}
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
@@ -2975,6 +3155,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
+	struct ti_sci_pm_ops *pmops = &ops->pm_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
@@ -3014,6 +3195,13 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	cops->set_freq = ti_sci_cmd_clk_set_freq;
 	cops->get_freq = ti_sci_cmd_clk_get_freq;
 
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+		pr_debug("detected DM managed LPM in fw_caps\n");
+		pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
+		pmops->set_device_constraint = ti_sci_cmd_set_device_constraint;
+		pmops->set_latency_constraint = ti_sci_cmd_set_latency_constraint;
+	}
+
 	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
 	rm_core_ops->get_range_from_shost =
 				ti_sci_cmd_get_resource_range_from_shost;
@@ -3503,11 +3691,21 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	int ret = 0;
+	u32 source;
+	u64 time;
+	u8 pin;
+	u8 mode;
 
 	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
 	if (ret)
 		return ret;
 
+	ret = ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);
+	/* Do not fail to resume on error as the wake reason is not critical */
+	if (!ret)
+		dev_info(dev, "ti_sci: wakeup source:0x%x, pin:0x%x, mode:0x%x\n",
+			 source, pin, mode);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 8efe4d0e61fbe6c8e79671971b3ca2ddb6b2422e..053387d7baa064498e6a208daa7f70040ef87281 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -38,7 +38,10 @@
 
 /* Low Power Mode Requests */
 #define TI_SCI_MSG_PREPARE_SLEEP	0x0300
+#define TI_SCI_MSG_LPM_WAKE_REASON	0x0306
 #define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
+#define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
+#define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
 
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
@@ -610,6 +613,79 @@ struct ti_sci_msg_req_set_io_isolation {
 	u8 state;
 } __packed;
 
+/**
+ * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
+ *
+ * @hdr:		Generic header.
+ * @wake_source:	The wake up source that woke soc from LPM.
+ * @wake_timestamp:	Timestamp at which soc woke.
+ * @wake_pin: The pin that has triggered wake up.
+ * @mode: The last entered low power mode.
+ * @rsvd:	Reserved for future use.
+ *
+ * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
+ * used to query the wake up source, pin and entered low power mode.
+ */
+struct ti_sci_msg_resp_lpm_wake_reason {
+	struct ti_sci_msg_hdr hdr;
+	u32 wake_source;
+	u64 wake_timestamp;
+	u8 wake_pin;
+	u8 mode;
+	u32 rsvd[2];
+} __packed;
+
+/**
+ * struct ti_sci_msg_req_lpm_set_device_constraint - Request for
+ * TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT.
+ *
+ * @hdr:	TISCI header to provide ACK/NAK flags to the host.
+ * @id:	Device ID of device whose constraint has to be modified.
+ * @state:	The desired state of device constraint: set or clear.
+ * @rsvd:	Reserved for future use.
+ *
+ * This message is used by host to set constraint on the device. This can be
+ * sent anytime after boot before prepare sleep message. Any device can set a
+ * constraint on the low power mode that the SoC can enter. It allows
+ * configurable information to be easily shared from the application, as this
+ * is a non-secure message and therefore can be sent by anyone. By setting a
+ * constraint, the device ensures that it will not be powered off or reset in
+ * the selected mode. Note: Access Restriction: Exclusivity flag of Device will
+ * be honored. If some other host already has constraint on this device ID,
+ * NACK will be returned.
+ */
+struct ti_sci_msg_req_lpm_set_device_constraint {
+	struct ti_sci_msg_hdr hdr;
+	u32 id;
+	u8 state;
+	u32 rsvd[2];
+} __packed;
+
+/**
+ * struct ti_sci_msg_req_lpm_set_latency_constraint - Request for
+ * TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT.
+ *
+ * @hdr:	TISCI header to provide ACK/NAK flags to the host.
+ * @wkup_latency:	The maximum acceptable latency to wake up from low power mode
+ *			in milliseconds. The deeper the state, the higher the latency.
+ * @state:	The desired state of wakeup latency constraint: set or clear.
+ * @rsvd:	Reserved for future use.
+ *
+ * This message is used by host to set wakeup latency from low power mode. This can
+ * be sent anytime after boot before prepare sleep message, and can be sent after
+ * current low power mode is exited. Any device can set a constraint on the low power
+ * mode that the SoC can enter. It allows configurable information to be easily shared
+ * from the application, as this is a non-secure message and therefore can be sent by
+ * anyone. By setting a wakeup latency constraint, the host ensures that the resume time
+ * from selected low power mode will be less than the constraint value.
+ */
+struct ti_sci_msg_req_lpm_set_latency_constraint {
+	struct ti_sci_msg_hdr hdr;
+	u16 latency;
+	u8 state;
+	u32 rsvd;
+} __packed;
+
 #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 1f1871e23f764484420a659dfcbbd7155216c3bb..fd104b6668364ced32a3406504f7d2c4afab8889 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -199,6 +199,31 @@ struct ti_sci_clk_ops {
 #define TISCI_MSG_VALUE_IO_ENABLE			1
 #define TISCI_MSG_VALUE_IO_DISABLE			0
 
+/* TISCI LPM constraint state values */
+#define TISCI_MSG_CONSTRAINT_SET			1
+#define TISCI_MSG_CONSTRAINT_CLR			0
+
+/**
+ * struct ti_sci_pm_ops - Low Power Mode (LPM) control operations
+ * @lpm_wake_reason: Get the wake up source that woke the SoC from LPM
+ *		- source: The wake up source that woke soc from LPM.
+ *		- timestamp: Timestamp at which soc woke.
+ * @set_device_constraint: Set LPM constraint on behalf of a device
+ *		- id: Device Identifier
+ *		- state: The desired state of device constraint: set or clear.
+ * @set_latency_constraint: Set LPM resume latency constraint
+ *		- latency: maximum acceptable latency to wake up from low power mode
+ *		- state: The desired state of latency constraint: set or clear.
+ */
+struct ti_sci_pm_ops {
+	int (*lpm_wake_reason)(const struct ti_sci_handle *handle,
+			       u32 *source, u64 *timestamp, u8 *pin, u8 *mode);
+	int (*set_device_constraint)(const struct ti_sci_handle *handle,
+				     u32 id, u8 state);
+	int (*set_latency_constraint)(const struct ti_sci_handle *handle,
+				      u16 latency, u8 state);
+};
+
 /**
  * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
  * @start:	Start index of the first resource range.
@@ -543,6 +568,7 @@ struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
+	struct ti_sci_pm_ops pm_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
 	struct ti_sci_rm_irq_ops rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops rm_ring_ops;

-- 
2.45.2


