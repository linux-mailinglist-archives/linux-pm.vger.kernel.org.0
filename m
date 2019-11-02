Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A56ECF55
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2019 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfKBOzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Nov 2019 10:55:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfKBOzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Nov 2019 10:55:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so8263565pgj.12;
        Sat, 02 Nov 2019 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thMGiWtPotBrPzDcwNB43U0hWmRVdlpTgozjZolFM50=;
        b=Pb4hjB1Hy0RJIHZMjfzigpr5wF6tmqmtxVqjfmaQ5JztMvVW47hqxokNeSptkmRBG6
         Nfu5KnZvVUT33J78V53d8uCuoHTm5nE+eGPNbXRQR3FcATKnaHWLbjhnKD2ScpUIiLlw
         NNY8R3XFcNfi+JC/dD0tjwGSsJIuyCI0kSpVffzxYAVqJxQADPe6Na5kq5ui9vN4Qq5G
         wuSlvSkcMqUoMKQZgN0dbsl92jtp+FC81McbPt5WKrjiiTblbPscKcN8i7JRZ1zKPv/b
         xmVMFGr6OW1nbF4+PiT+wsgM5n4AIkXmp0UmMlSJG9ec8Y/iTwvSi6YLxrQu5onJZEWn
         PTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=thMGiWtPotBrPzDcwNB43U0hWmRVdlpTgozjZolFM50=;
        b=cv+flDu61Mszl6oT9gApSguYQVZq2noxeORzHQxI9X2XtfFl38198zDY38JGymIZyc
         7zxi6Py5D3DSEOG+u4e2lDI0d+6gGHZmjgVpw3u9mg+tGHH73NI6XdWK725SKHn8tGoJ
         7VqOXsJZrpic/wyYZbkcHAaj0qVRSdaX/oWiL9lcT4Wd1t7ccVelqH+HDkWzfuXzYyvp
         YUNxm0lTx2C1yJHvNw2GK11wy2GnhjjudC5NSkf81oK0hTYuzRlzKpCl1M4tSWb3vl9G
         fhFGaTxEbBbfoTSHoDVbsK9zfbd0j2vqG2DvmipZxUNdtmeNrX60g9aM0ZtQRCvHSZ7X
         /mDA==
X-Gm-Message-State: APjAAAXELPOHAWR6kBGizfAyDHdFAXIS957YsvdxV6An88p2a/kRv/he
        KaEjchDockho4cDYZlSGv3aKzfmf
X-Google-Smtp-Source: APXvYqz3AcS9YgLMPOLwFF/ppQIwJgrkw00mSOE7E9RLWB0lCnCpgDmRKNfyOetfHmcqwfabXoQJig==
X-Received: by 2002:a62:2686:: with SMTP id m128mr20762874pfm.143.1572706533632;
        Sat, 02 Nov 2019 07:55:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8sm4345861pjp.10.2019.11.02.07.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Nov 2019 07:55:32 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Chris Healy <cphealy@gmail.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4] nvme: Add hardware monitoring support
Date:   Sat,  2 Nov 2019 07:55:30 -0700
Message-Id: <20191102145530.16104-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

nvme devices report temperature information in the controller information
(for limits) and in the smart log. Currently, the only means to retrieve
this information is the nvme command line interface, which requires
super-user privileges.

At the same time, it would be desirable to be able to use NVMe temperature
information for thermal control.

This patch adds support to read NVMe temperatures from the kernel using the
hwmon API and adds temperature zones for NVMe drives. The thermal subsystem
can use this information to set thermal policies, and userspace can access
it using libsensors and/or the "sensors" command.

Example output from the "sensors" command:

nvme-pci-0100
Adapter: PCI adapter
Composite:    +39.0°C  (high = +85.0°C, crit = +85.0°C)
Sensor 1:     +39.0°C
Sensor 2:     +41.0°C

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Attach hwmon device to ctrl->dev instead of ctrl->device
    Use "nvme" as hwmon device chip name

v3: NVME -> NVMe
    Call nvme_hwmon_init() only once, when the controller is first
    identified
    Protect call to nvme_get_log() and reading the log with mutex
    Convert error return from nvme_get_log() to Linux error code
    in nvme_hwmon_get_smart_log()
    Don't read smart log for reporting warning and critical limits
    Use get_unaligned_le16() instead of le16_to_cpup() to read the
    composite temperature
    Use #ifdef CONFIG_NVME_HWMON instead of IS_ENABLED(CONFIG_NVME_HWMON)
    -EPROTO -> -EIO for generic NVMe level errors
    Tab-align '=' in data structure initializations

v2: Use devm_kfree() to release memory in error path

Tested with the following NVMe drives:
	Intel SSDPEKKW512G7 500GB
	Samsung SSD 960 EVO 500GB
	Samsung SSD 970 EVO 500GB
	Samsung SSD 970 EVO 1TB
 drivers/nvme/host/Kconfig      |  10 ++
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |   6 ++
 drivers/nvme/host/nvme-hwmon.c | 181 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h       |   8 ++
 5 files changed, 206 insertions(+)
 create mode 100644 drivers/nvme/host/nvme-hwmon.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 2b36f052bfb9..c6439638a419 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -23,6 +23,16 @@ config NVME_MULTIPATH
 	   /dev/nvmeXnY device will show up for each NVMe namespaces,
 	   even if it is accessible through multiple controllers.
 
+config NVME_HWMON
+	bool "NVMe hardware monitoring"
+	depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
+	help
+	  This provides support for NVMe hardware monitoring. If enabled,
+	  a hardware monitoring device will be created for each NVMe drive
+	  in the system.
+
+	  If unsure, say N.
+
 config NVME_FABRICS
 	tristate
 
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 8a4b671c5f0c..03de4797a877 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -14,6 +14,7 @@ nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
+nvme-core-$(CONFIG_NVME_HWMON)		+= nvme-hwmon.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..d039e392de36 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2796,6 +2796,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
 	ctrl->oaes = le32_to_cpu(id->oaes);
+	ctrl->wctemp = le16_to_cpu(id->wctemp);
+	ctrl->cctemp = le16_to_cpu(id->cctemp);
+
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	if (id->mdts)
@@ -2895,6 +2898,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
+	if (!ctrl->identified)
+		nvme_hwmon_init(ctrl);
+
 	ctrl->identified = true;
 
 	return 0;
diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmon.c
new file mode 100644
index 000000000000..28b4b7f43bb0
--- /dev/null
+++ b/drivers/nvme/host/nvme-hwmon.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVM Express hardware monitoring support
+ * Copyright (c) 2019, Guenter Roeck
+ */
+
+#include <linux/hwmon.h>
+#include <asm/unaligned.h>
+
+#include "nvme.h"
+
+struct nvme_hwmon_data {
+	struct nvme_ctrl *ctrl;
+	struct nvme_smart_log log;
+	struct mutex read_lock;
+};
+
+static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
+{
+	int ret;
+
+	ret = nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
+			   &data->log, sizeof(data->log), 0);
+
+	return ret <= 0 ? ret : -EIO;
+}
+
+static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	struct nvme_hwmon_data *data = dev_get_drvdata(dev);
+	struct nvme_smart_log *log = &data->log;
+	int temp;
+	int err;
+
+	/*
+	 * First handle attributes which don't require us to read
+	 * the smart log.
+	 */
+	switch (attr) {
+	case hwmon_temp_max:
+		*val = (data->ctrl->wctemp - 273) * 1000;
+		return 0;
+	case hwmon_temp_crit:
+		*val = (data->ctrl->cctemp - 273) * 1000;
+		return 0;
+	default:
+		break;
+	}
+
+	mutex_lock(&data->read_lock);
+	err = nvme_hwmon_get_smart_log(data);
+	if (err)
+		goto unlock;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		if (!channel)
+			temp = get_unaligned_le16(log->temperature);
+		else
+			temp = le16_to_cpu(log->temp_sensor[channel - 1]);
+		*val = (temp - 273) * 1000;
+		break;
+	case hwmon_temp_crit_alarm:
+		*val = !!(log->critical_warning & NVME_SMART_CRIT_TEMPERATURE);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+unlock:
+	mutex_unlock(&data->read_lock);
+	return err;
+}
+
+static const char * const nvme_hwmon_sensor_names[] = {
+	"Composite",
+	"Sensor 1",
+	"Sensor 2",
+	"Sensor 3",
+	"Sensor 4",
+	"Sensor 5",
+	"Sensor 6",
+	"Sensor 7",
+	"Sensor 8",
+};
+
+static int nvme_hwmon_read_string(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, const char **str)
+{
+	*str = nvme_hwmon_sensor_names[channel];
+	return 0;
+}
+
+static umode_t nvme_hwmon_is_visible(const void *_data,
+				     enum hwmon_sensor_types type,
+				     u32 attr, int channel)
+{
+	const struct nvme_hwmon_data *data = _data;
+
+	switch (attr) {
+	case hwmon_temp_crit:
+		if (!channel && data->ctrl->cctemp)
+			return 0444;
+		break;
+	case hwmon_temp_max:
+		if (!channel && data->ctrl->wctemp)
+			return 0444;
+		break;
+	case hwmon_temp_crit_alarm:
+		if (!channel)
+			return 0444;
+		break;
+	case hwmon_temp_input:
+	case hwmon_temp_label:
+		if (!channel || data->log.temp_sensor[channel - 1])
+			return 0444;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info *nvme_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+				HWMON_T_LABEL | HWMON_T_CRIT_ALARM,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops nvme_hwmon_ops = {
+	.is_visible	= nvme_hwmon_is_visible,
+	.read		= nvme_hwmon_read,
+	.read_string	= nvme_hwmon_read_string,
+};
+
+static const struct hwmon_chip_info nvme_hwmon_chip_info = {
+	.ops	= &nvme_hwmon_ops,
+	.info	= nvme_hwmon_info,
+};
+
+void nvme_hwmon_init(struct nvme_ctrl *ctrl)
+{
+	struct device *dev = ctrl->dev;
+	struct nvme_hwmon_data *data;
+	struct device *hwmon;
+	int err;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->ctrl = ctrl;
+	mutex_init(&data->read_lock);
+
+	err = nvme_hwmon_get_smart_log(data);
+	if (err) {
+		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
+		devm_kfree(dev, data);
+		return;
+	}
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "nvme", data,
+						     &nvme_hwmon_chip_info,
+						     NULL);
+	if (IS_ERR(hwmon)) {
+		dev_warn(dev, "Failed to instantiate hwmon device\n");
+		devm_kfree(dev, data);
+	}
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e8401352c2..cb3b242a214e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -231,6 +231,8 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u16 wctemp;
+	u16 cctemp;
 	u32 oaes;
 	u32 aen_result;
 	u32 ctratt;
@@ -652,4 +654,10 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 	return dev_to_disk(dev)->private_data;
 }
 
+#ifdef CONFIG_NVME_HWMON
+void nvme_hwmon_init(struct nvme_ctrl *ctrl);
+#else
+static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
+#endif
+
 #endif /* _NVME_H */
-- 
2.17.1

