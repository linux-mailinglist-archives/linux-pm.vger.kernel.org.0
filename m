Return-Path: <linux-pm+bounces-13769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB096EF84
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3587284932
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600A61C8FA4;
	Fri,  6 Sep 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="odK1zfRV"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B090241A8F;
	Fri,  6 Sep 2024 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615485; cv=none; b=mk3EVNmIt/22+/Tnt06z8kXfg2teQKGBBpFoeYO02lj7m8KOzF9vljJSG0VtXV7iME9EKMpBKYIr8LyJIjZM3x0uDgdYmgwCtSqy5B3+3QXBv/mujMNOHR8DBWpz+/x7jqz3VmEnbBE4xhYzN4nuiHh4i9tvj/eL43is7lWLPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615485; c=relaxed/simple;
	bh=oPYISi4yWVVYfDy1Yeg0W4Indj3Ueaj5PNzpCrS28AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnJ7kMAyKRrKXk12fVVYG247zCscCxOqEQCNETuV3mBB4FDTkOY3rAebL8Xh9eWXvBQ+jh2XijzLiaogXrSm0kn7Gf15F1iWkU4IqS2Gh/EzNIk/gsVkBRSgsYzi56s6WTFkoz9tpNjalIuHuWxDFzlBhjNixW6sj84z/ircjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=odK1zfRV; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id D5E59789FF;
	Fri,  6 Sep 2024 17:37:53 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn D5E59789FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615480;
	bh=omzsCObrmYZvdo+jXnzf7Q5rY829DumQmkjYVM1togY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odK1zfRVawuaSL7Yi07Hi04IpTcHWwpSPwHBGPl6zLICo2WQTuZ0777tFF0eHD0rw
	 wh1mfT3MOUiOkgb8Vb/xhGr71gosNyALABrXlYh8kLAleDmnKEM/lYxGbHm6VFTjDw
	 pbfKkWdzLvTZqclzX8bTMlK9HczwlrkKX2I1ku1I=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>
Subject: [PATCH 1/9] mfd: Add driver for Photonicat power management MCU
Date: Fri,  6 Sep 2024 17:36:22 +0800
Message-ID: <20240906093630.2428329-2-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906093630.2428329-1-bigfoot@classfun.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for Photonicat power management MCU, which
provides battery and charger power supply, real-time clock,
watchdog, hardware shutdown.

This driver implementes core MFD/serdev device as well as
communication subroutines necessary for commanding the device.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 drivers/mfd/Kconfig                |  13 +
 drivers/mfd/Makefile               |   1 +
 drivers/mfd/photonicat-pmu.c       | 501 +++++++++++++++++++++++++++++
 include/linux/mfd/photonicat-pmu.h |  86 +++++
 4 files changed, 601 insertions(+)
 create mode 100644 drivers/mfd/photonicat-pmu.c
 create mode 100644 include/linux/mfd/photonicat-pmu.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index bc8be2e593b6..5fd339aa0f9a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1135,6 +1135,19 @@ config MFD_PM8XXX
 	  Say M here if you want to include support for PM8xxx chips as a
 	  module. This will build a module called "pm8xxx-core".
 
+config MFD_PHOTONICAT_PMU
+	tristate "Photonicat Power Management MCU"
+	depends on OF
+	depends on SERIAL_DEV_BUS
+	select CRC16
+	select MFD_CORE
+	help
+	  Driver for the Power Management MCU in the Ariaboard Photonicat,
+	  which provides battery and charger power supply, real-time clock,
+	  watchdog, hardware shutdown.
+
+	  Say M or Y here to include this support.
+
 config MFD_QCOM_RPM
 	tristate "Qualcomm Resource Power Manager (RPM)"
 	depends on ARCH_QCOM && OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 02b651cd7535..25872850f216 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -223,6 +223,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
+obj-$(CONFIG_MFD_PHOTONICAT_PMU)	+= photonicat-pmu.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
diff --git a/drivers/mfd/photonicat-pmu.c b/drivers/mfd/photonicat-pmu.c
new file mode 100644
index 000000000000..e6bbaf256c50
--- /dev/null
+++ b/drivers/mfd/photonicat-pmu.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
+ */
+
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/crc16.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/photonicat-pmu.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/serdev.h>
+#include <linux/spinlock.h>
+
+#define PCAT_ADDR_CPU(id)	((id & 0x7F))
+#define PCAT_ADDR_PMU(id)	((id & 0x7F) | 0x80)
+#define PCAT_ADDR_CPU_ALL	0x80
+#define PCAT_ADDR_PMU_ALL	0xFE
+#define PCAT_ADDR_ALL		0xFF
+
+#define PCAT_MAGIC_HEAD	0xA5
+#define PCAT_MAGIC_END	0x5A
+
+struct pcat_data_head {
+	u8 magic_head;
+	u8 source;
+	u8 dest;
+	u16 frame_id;
+	u16 length;
+	u16 command;
+} __packed;
+
+struct pcat_data_foot {
+	u8 need_ack;
+	u16 crc16;
+	u8 magic_end;
+} __packed;
+
+struct pcat_data {
+	struct pcat_pmu *pmu;
+	struct pcat_data_head *head;
+	struct pcat_data_foot *foot;
+	void *data;
+	size_t size;
+};
+
+struct pcat_request {
+	struct pcat_pmu *pmu;
+	u16 frame_id;
+	struct completion received;
+	struct pcat_request_request {
+		u16 cmd;
+		u16 want;
+		const void *data;
+		size_t size;
+	} request;
+	struct pcat_request_reply {
+		struct pcat_data_head head;
+		struct pcat_data_foot foot;
+		void *data;
+		size_t size;
+	} reply;
+};
+
+struct pcat_pmu {
+	struct device *dev;
+	struct serdev_device *serdev;
+	atomic_t frame;
+	char buffer[8192];
+	size_t length;
+	struct pcat_request *reply;
+	spinlock_t bus_lock;
+	struct mutex reply_lock;
+	struct mutex status_lock;
+	struct completion first_status;
+	struct blocking_notifier_head notifier_list;
+	u8 local_id;
+	u8 remote_id;
+};
+
+void *pcat_data_get_data(struct pcat_data *data)
+{
+	if (!data)
+		return NULL;
+	return data->data;
+}
+EXPORT_SYMBOL_GPL(pcat_data_get_data);
+
+static int pcat_pmu_raw_write(struct pcat_pmu *pmu, u16 frame_id,
+			      enum pcat_pmu_cmd cmd, bool need_ack,
+			      const void *data, size_t len)
+{
+	int ret;
+	struct pcat_data_head head;
+	struct pcat_data_foot foot;
+
+	head.magic_head = PCAT_MAGIC_HEAD;
+	head.source = PCAT_ADDR_CPU(pmu->local_id);
+	head.dest = PCAT_ADDR_PMU(pmu->remote_id);
+	head.frame_id = frame_id;
+	head.length = len + sizeof(struct pcat_data_foot) - 1;
+	head.command = cmd;
+
+	ret = serdev_device_write_buf(pmu->serdev, (u8 *)&head, sizeof(head));
+	if (ret < 0) {
+		dev_err(pmu->dev, "failed to write frame head: %d", ret);
+		return ret;
+	}
+
+	ret = serdev_device_write_buf(pmu->serdev, data, len);
+	if (ret < 0) {
+		dev_err(pmu->dev, "failed to write frame body: %d", ret);
+		return ret;
+	}
+
+	foot.need_ack = need_ack;
+	foot.crc16 = 0;
+	foot.magic_end = PCAT_MAGIC_END;
+	foot.crc16 = crc16(0xFFFF, (u8 *)&head + 1, sizeof(head) - 1);
+	foot.crc16 = crc16(foot.crc16, data, len);
+	foot.crc16 = crc16(foot.crc16, (u8 *)&foot, 1);
+
+	ret = serdev_device_write_buf(pmu->serdev, (u8 *)&foot, sizeof(foot));
+	if (ret < 0)
+		dev_err(pmu->dev, "failed to send frame foot: %d", ret);
+
+	return ret;
+}
+
+int pcat_pmu_send(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd,
+		  const void *data, size_t len)
+{
+	u16 frame_id = atomic_inc_return(&pmu->frame);
+
+	return pcat_pmu_raw_write(pmu, frame_id, cmd, false, data, len);
+}
+EXPORT_SYMBOL_GPL(pcat_pmu_send);
+
+int pcat_pmu_execute(struct pcat_request *request)
+{
+	int ret = 0, retries = 0;
+	unsigned long flags;
+	struct pcat_pmu *pmu = request->pmu;
+	struct pcat_request_request *req = &request->request;
+	struct pcat_request_reply *reply = &request->reply;
+
+	init_completion(&request->received);
+	memset(reply, 0, sizeof(request->reply));
+
+	mutex_lock(&pmu->reply_lock);
+	if (request->frame_id == 0)
+		request->frame_id = atomic_inc_return(&pmu->frame);
+	pmu->reply = request;
+	mutex_unlock(&pmu->reply_lock);
+
+	if (req->want == 0)
+		req->want = req->cmd + 1;
+
+	dev_dbg(pmu->dev, "frame 0x%04X execute cmd 0x%02X\n",
+		request->frame_id, req->cmd);
+
+	while (1) {
+		spin_lock_irqsave(&pmu->bus_lock, flags);
+		ret = pcat_pmu_raw_write(pmu, request->frame_id, req->cmd,
+					 true, req->data, req->size);
+		spin_unlock_irqrestore(&pmu->bus_lock, flags);
+		if (ret < 0) {
+			dev_err(pmu->dev,
+				"frame 0x%04X write 0x%02X cmd failed: %d\n",
+				request->frame_id, req->cmd, ret);
+			goto fail;
+		}
+		dev_dbg(pmu->dev, "frame 0x%04X waiting response for 0x%02X\n",
+			request->frame_id, req->cmd);
+		if (!wait_for_completion_timeout(&request->received, HZ)) {
+			if (retries < 3) {
+				retries++;
+				continue;
+			} else {
+				dev_warn(pmu->dev,
+					 "frame 0x%04X cmd 0x%02X timeout\n",
+					 request->frame_id, req->cmd);
+				ret = -ETIMEDOUT;
+				goto fail;
+			}
+		}
+		break;
+	}
+	dev_dbg(pmu->dev, "frame 0x%04X got response 0x%02X\n",
+		request->frame_id, reply->head.command);
+
+	return 0;
+fail:
+	mutex_lock(&pmu->reply_lock);
+	pmu->reply = NULL;
+	mutex_unlock(&pmu->reply_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcat_pmu_execute);
+
+int pcat_pmu_write_data(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd,
+			const void *data, size_t size)
+{
+	int ret;
+	struct pcat_request request = {
+		.pmu = pmu,
+		.request.cmd = cmd,
+		.request.data = data,
+		.request.size = size,
+	};
+	ret = pcat_pmu_execute(&request);
+	if (request.reply.data)
+		devm_kfree(pmu->dev, request.reply.data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcat_pmu_write_data);
+
+int pcat_pmu_read_string(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd,
+			 char *str, size_t len)
+{
+	int ret;
+	struct pcat_request request = {
+		.pmu = pmu,
+		.request.cmd = cmd,
+	};
+	memset(str, 0, len);
+	ret = pcat_pmu_execute(&request);
+	if (request.reply.data) {
+		memcpy(str, request.reply.data,
+		       min(len - 1, request.reply.size));
+		devm_kfree(pmu->dev, request.reply.data);
+	};
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcat_pmu_read_string);
+
+int pcat_pmu_write_u8(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd, u8 v)
+{
+	return pcat_pmu_write_data(pmu, cmd, &v, sizeof(v));
+}
+EXPORT_SYMBOL_GPL(pcat_pmu_write_u8);
+
+static bool pcat_process_reply(struct pcat_data *p)
+{
+	bool processed = false;
+	struct pcat_pmu *pmu = p->pmu;
+	struct device *dev = pmu->dev;
+	struct pcat_request *request;
+	struct pcat_request_request *req;
+	struct pcat_request_reply *reply;
+
+	mutex_lock(&pmu->reply_lock);
+	request = pmu->reply;
+	if (!request)
+		goto skip;
+
+	req = &request->request;
+	reply = &request->reply;
+	if (request->frame_id != p->head->frame_id) {
+		dev_dbg_ratelimited(dev, "skip mismatch frame %04X != %04X",
+				    request->frame_id, p->head->frame_id);
+		goto skip;
+	}
+
+	if (req->want == 0)
+		req->want = req->cmd + 1;
+
+	if (req->want != p->head->command) {
+		dev_dbg_ratelimited(
+			dev, "frame %04X skip mismatch command %02X != %02X",
+			request->frame_id, req->want, p->head->command);
+		goto skip;
+	}
+
+	if (completion_done(&request->received)) {
+		dev_dbg_ratelimited(dev, "frame %04X skip done completion",
+				    request->frame_id);
+		goto skip;
+	}
+
+	memcpy(&reply->head, p->head, sizeof(struct pcat_data_head));
+	memcpy(&reply->foot, p->foot, sizeof(struct pcat_data_foot));
+	if (p->data && p->size > 0) {
+		reply->data = devm_kzalloc(pmu->dev, p->size + 1, GFP_KERNEL);
+		if (pmu->reply->reply.data) {
+			memcpy(reply->data, p->data, p->size);
+			reply->size = p->size;
+		}
+	}
+
+	complete(&request->received);
+	pmu->reply = NULL;
+	processed = true;
+
+skip:
+	mutex_unlock(&pmu->reply_lock);
+	return processed;
+}
+
+static int pcat_process_data(struct pcat_pmu *pmu, const u8 *data, size_t len)
+{
+	int ret;
+	u16 crc16_calc;
+	size_t data_size = 0;
+	struct pcat_data frame;
+
+	memset(&frame, 0, sizeof(frame));
+	frame.pmu = pmu;
+	if (len < sizeof(struct pcat_data_head)) {
+		dev_dbg_ratelimited(pmu->dev, "head too small %zu < %zu\n", len,
+				    sizeof(struct pcat_data_head));
+		return -EAGAIN;
+	}
+
+	frame.head = (struct pcat_data_head *)data;
+	if (frame.head->magic_head != PCAT_MAGIC_HEAD) {
+		dev_dbg_ratelimited(pmu->dev, "bad head magic %02X\n",
+				    frame.head->magic_head);
+		return -EBADMSG;
+	}
+
+	if (frame.head->source != PCAT_ADDR_PMU(pmu->remote_id)) {
+		dev_dbg_ratelimited(pmu->dev, "unknown data source %02X\n",
+				    frame.head->source);
+		return 0;
+	}
+	if (frame.head->dest != PCAT_ADDR_CPU(pmu->local_id) &&
+	    frame.head->dest != PCAT_ADDR_CPU_ALL &&
+	    frame.head->dest != PCAT_ADDR_ALL) {
+		dev_dbg_ratelimited(pmu->dev, "not data destination %02X\n",
+				    frame.head->dest);
+		return 0;
+	}
+	if (frame.head->length < sizeof(struct pcat_data_foot) - 1 ||
+	    frame.head->length >= U16_MAX - 4) {
+		dev_dbg_ratelimited(pmu->dev, "invalid length %d\n",
+				    frame.head->length);
+		return -EBADMSG;
+	}
+	data_size = sizeof(struct pcat_data_head) + frame.head->length + 1;
+	if (data_size > len) {
+		dev_dbg_ratelimited(pmu->dev, "data too small %zu > %zu\n",
+				    data_size, len);
+		return -EAGAIN;
+	}
+	frame.data = (u8 *)data + sizeof(struct pcat_data_head);
+	frame.size = frame.head->length + 1 - sizeof(struct pcat_data_foot);
+	frame.foot = (struct pcat_data_foot *)(data + frame.size +
+					       sizeof(struct pcat_data_head));
+	if (frame.foot->magic_end != PCAT_MAGIC_END) {
+		dev_dbg_ratelimited(pmu->dev, "bad foot magic %02X\n",
+				    frame.foot->magic_end);
+		return -EBADMSG;
+	}
+	crc16_calc = crc16(0xFFFF, data + 1, frame.head->length + 6);
+	if (frame.foot->crc16 != crc16_calc) {
+		dev_warn_ratelimited(pmu->dev, "crc16 mismatch %04X != %04X\n",
+				     frame.foot->crc16, crc16_calc);
+		return -EBADMSG;
+	}
+
+	if (pcat_process_reply(&frame))
+		return 0;
+
+	ret = blocking_notifier_call_chain(&pmu->notifier_list,
+					   frame.head->command, &frame);
+	if (ret == NOTIFY_DONE && frame.foot->need_ack) {
+		pcat_pmu_raw_write(pmu, frame.head->frame_id,
+				   frame.head->command + 1, false, NULL, 0);
+	}
+
+	return 0;
+}
+
+static size_t pcat_pmu_receive_buf(struct serdev_device *serdev,
+				   const unsigned char *buf, size_t size)
+{
+	struct device *dev = &serdev->dev;
+	struct pcat_pmu *pmu = dev_get_drvdata(dev);
+	size_t processed = size;
+	int ret;
+	size_t new_len = pmu->length + size;
+
+	if (!pmu || !buf || size <= 0)
+		return 0;
+	if (new_len > sizeof(pmu->buffer)) {
+		new_len = sizeof(pmu->buffer);
+		processed = new_len - pmu->length;
+	}
+	if (pmu->length)
+		dev_dbg(pmu->dev, "got remaining message at %zu size %zu (%zu)",
+			pmu->length, processed, new_len);
+	memcpy(pmu->buffer + pmu->length, buf, processed);
+	pmu->length = new_len;
+	ret = pcat_process_data(pmu, pmu->buffer, pmu->length);
+	if (ret != -EAGAIN)
+		pmu->length = 0;
+	else
+		dev_dbg(pmu->dev, "got partial message %zu", pmu->length);
+	return processed;
+}
+
+static const struct serdev_device_ops pcat_pmu_serdev_device_ops = {
+	.receive_buf = pcat_pmu_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+int pcat_pmu_register_notify(struct pcat_pmu *pmu, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&pmu->notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(pcat_pmu_register_notify);
+
+void pcat_pmu_unregister_notify(struct pcat_pmu *pmu, struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&pmu->notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(pcat_pmu_unregister_notify);
+
+static int pcat_pmu_probe(struct serdev_device *serdev)
+{
+	int ret;
+	u32 baudrate;
+	u32 address;
+	char buffer[64];
+	struct pcat_pmu *pmu = NULL;
+	struct device *dev = &serdev->dev;
+
+	pmu = devm_kzalloc(dev, sizeof(struct pcat_pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+	pmu->dev = dev;
+	pmu->serdev = serdev;
+	spin_lock_init(&pmu->bus_lock);
+	mutex_init(&pmu->reply_lock);
+	init_completion(&pmu->first_status);
+
+	if (of_property_read_u32(dev->of_node, "current-speed", &baudrate))
+		baudrate = 115200;
+
+	if (of_property_read_u32(dev->of_node, "local-address", &address))
+		address = 1;
+	pmu->local_id = address;
+
+	if (of_property_read_u32(dev->of_node, "remote-address", &address))
+		address = 1;
+	pmu->remote_id = address;
+
+	serdev_device_set_client_ops(serdev, &pcat_pmu_serdev_device_ops);
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to open serdev\n");
+
+	serdev_device_set_baudrate(serdev, baudrate);
+	serdev_device_set_flow_control(serdev, false);
+	serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	dev_set_drvdata(dev, pmu);
+
+	/* Disable watchdog on boot */
+	pcat_pmu_write_data(pmu, PCAT_CMD_WATCHDOG_TIMEOUT_SET,
+			    (u8[]){ 60, 60, 0 }, 3);
+
+	/* Read hardware version */
+	pcat_pmu_read_string(pmu, PCAT_CMD_PMU_HW_VERSION_GET,
+			     buffer, sizeof(buffer));
+	if (buffer[0])
+		dev_info(dev, "PMU Hardware version: %s\n", buffer);
+
+	/* Read firmware version */
+	pcat_pmu_read_string(pmu, PCAT_CMD_PMU_FW_VERSION_GET,
+			     buffer, sizeof(buffer));
+	if (buffer[0])
+		dev_info(dev, "PMU Firmware version: %s\n", buffer);
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id pcat_pmu_dt_ids[] = {
+	{ .compatible = "ariaboard,photonicat-pmu", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pcat_pmu_dt_ids);
+
+static struct serdev_device_driver pcat_pmu_driver = {
+	.driver = {
+		.name = "photonicat-pmu",
+		.of_match_table = pcat_pmu_dt_ids,
+	},
+	.probe = pcat_pmu_probe,
+};
+module_serdev_device_driver(pcat_pmu_driver);
+
+MODULE_ALIAS("platform:photonicat-pmu");
+MODULE_AUTHOR("Junhao Xie <bigfoot@classfun.cn>");
+MODULE_DESCRIPTION("Photonicat Power Management Unit");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/photonicat-pmu.h b/include/linux/mfd/photonicat-pmu.h
new file mode 100644
index 000000000000..1bada5efd83a
--- /dev/null
+++ b/include/linux/mfd/photonicat-pmu.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
+ */
+
+#ifndef _PHOTONICAT_PMU_H
+#define _PHOTONICAT_PMU_H
+
+#include <linux/notifier.h>
+#include <linux/types.h>
+
+struct pcat_data;
+struct pcat_pmu;
+struct pcat_request;
+
+struct pcat_data_cmd_date_time {
+	u16 year;
+	u8 month;
+	u8 day;
+	u8 hour;
+	u8 minute;
+	u8 second;
+} __packed;
+
+struct pcat_data_cmd_led_setup {
+	u16 on_time;
+	u16 down_time;
+	u16 repeat;
+} __packed;
+
+struct pcat_data_cmd_status {
+	u16 battery_microvolt;
+	u16 charger_microvolt;
+	u16 gpio_input;
+	u16 gpio_output;
+	struct pcat_data_cmd_date_time time;
+	u16 reserved;
+	u8 temp;
+} __packed;
+
+enum pcat_pmu_cmd {
+	PCAT_CMD_HEARTBEAT			= 0x01,
+	PCAT_CMD_HEARTBEAT_ACK			= 0x02,
+	PCAT_CMD_PMU_HW_VERSION_GET		= 0x03,
+	PCAT_CMD_PMU_HW_VERSION_GET_ACK		= 0x04,
+	PCAT_CMD_PMU_FW_VERSION_GET		= 0x05,
+	PCAT_CMD_PMU_FW_VERSION_GET_ACK		= 0x06,
+	PCAT_CMD_STATUS_REPORT			= 0x07,
+	PCAT_CMD_STATUS_REPORT_ACK		= 0x08,
+	PCAT_CMD_DATE_TIME_SYNC			= 0x09,
+	PCAT_CMD_DATE_TIME_SYNC_ACK		= 0x0A,
+	PCAT_CMD_SCHEDULE_STARTUP_TIME_SET	= 0x0B,
+	PCAT_CMD_SCHEDULE_STARTUP_TIME_SET_ACK	= 0x0C,
+	PCAT_CMD_PMU_REQUEST_SHUTDOWN		= 0x0D,
+	PCAT_CMD_PMU_REQUEST_SHUTDOWN_ACK	= 0x0E,
+	PCAT_CMD_HOST_REQUEST_SHUTDOWN		= 0x0F,
+	PCAT_CMD_HOST_REQUEST_SHUTDOWN_ACK	= 0x10,
+	PCAT_CMD_PMU_REQUEST_FACTORY_RESET	= 0x11,
+	PCAT_CMD_PMU_REQUEST_FACTORY_RESET_ACK	= 0x12,
+	PCAT_CMD_WATCHDOG_TIMEOUT_SET		= 0x13,
+	PCAT_CMD_WATCHDOG_TIMEOUT_SET_ACK	= 0x14,
+	PCAT_CMD_CHARGER_ON_AUTO_START		= 0x15,
+	PCAT_CMD_CHARGER_ON_AUTO_START_ACK	= 0x16,
+	PCAT_CMD_VOLTAGE_THRESHOLD_SET		= 0x17,
+	PCAT_CMD_VOLTAGE_THRESHOLD_SET_ACK	= 0x18,
+	PCAT_CMD_NET_STATUS_LED_SETUP		= 0x19,
+	PCAT_CMD_NET_STATUS_LED_SETUP_ACK	= 0x1A,
+	PCAT_CMD_POWER_ON_EVENT_GET		= 0x1B,
+	PCAT_CMD_POWER_ON_EVENT_GET_ACK		= 0x1C,
+};
+
+void *pcat_data_get_data(struct pcat_data *data);
+int pcat_pmu_send(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd,
+		  const void *data, size_t len);
+int pcat_pmu_execute(struct pcat_request *request);
+int pcat_pmu_write_data(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd,
+			const void *data, size_t size);
+int pcat_pmu_read_string(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd,
+			 char *str, size_t len);
+int pcat_pmu_write_u8(struct pcat_pmu *pmu, enum pcat_pmu_cmd cmd, u8 value);
+int pcat_pmu_register_notify(struct pcat_pmu *pmu,
+			     struct notifier_block *nb);
+void pcat_pmu_unregister_notify(struct pcat_pmu *pmu,
+				struct notifier_block *nb);
+
+#endif
-- 
2.46.0


