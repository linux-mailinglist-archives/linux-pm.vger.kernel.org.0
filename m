Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D381E930C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfJ2WcT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:32:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43954 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2WcS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:32:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5so8384805ply.10;
        Tue, 29 Oct 2019 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIQgpHQQNqKvrtbA7wlDZAsuOkJqXML6v+b9jj7nKMs=;
        b=s3wdGqyy9een0o9DA40eJHB1M/nw6ZhH+vs2Mqr5VssW06RUpMG6APkNTIVjIPw+q2
         2EGphZOT8a350bxivE5aT5Cje6eHCWmCKsJMx1EveJROc/5Um4UbVcMoPEAbILqcndQS
         u6ijKl0WW3Af7/MdzlX7Lnj1As51uIO9zp7p839Py4mP8U2Z5/EVo312XEDlHRwK5Hxs
         vSIfpeCvd/S8QGxSoNFQxjlIOPa2LLwlZVJy8KiDMmbWIdhRGzJh4obC1/Hz3iYsrcSZ
         8EfRnmdK9VMSKV5UuvG9IC3aPL7gePPE/YN8gy3XwrxXaBHrO46lH0PGl/4Lhzok8wGe
         igGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RIQgpHQQNqKvrtbA7wlDZAsuOkJqXML6v+b9jj7nKMs=;
        b=soXu26zr9gJJYqR439ayLSD+qd7VArHA6kQdbQ2pSzkL8+SZDcDkb7Fkd/jy+M1j8f
         duASGGgtL9V+lJzmNAEpwQao03x8nKWGU6mTr2yHvKwlm2fRcbz6bn6Zq0TFJRzxstvG
         jqc4rCXwKfsipGQWPObFvCQD4/xnyNlsx1AttnQE1SaUZ3I+6smUxFEIZ+G0zHWaDHTd
         5KjPrNzZiomT0VI3Ym88D5AFPLgdvzt+68iuL9Ys8gdQvd/R3EuODy9svFA92qM63atu
         9RCTBJ5veIaQwZQ8RZxhHo+Z1UImaXGcqdufOvTqv4yJKjPKLd2sVRQ1QmwIU1Nw6+jq
         zvzg==
X-Gm-Message-State: APjAAAXjmBh3ZyQnNjsz3Proo5UwAPyPgkypCmn26pKc5OBuqBCvl7V+
        AwSMwj9AqYVovNOf2f/jGaU=
X-Google-Smtp-Source: APXvYqzCXxTzsqetgXNbl24YtGdPMh/zv+xWNVX0kg96cgXiQbU58sD1IuD7gQhsRqXRgNHaObMFKQ==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr1108482plp.138.1572388337863;
        Tue, 29 Oct 2019 15:32:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i71sm134702pfe.103.2019.10.29.15.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 15:32:16 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] nvme: Add hardware monitoring support
Date:   Tue, 29 Oct 2019 15:32:14 -0700
Message-Id: <20191029223214.18889-1-linux@roeck-us.net>
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

At the same time, it would be desirable to use NVME temperature information
for thermal control.

This patch adds support to read NVME temperatures from the kernel using the
hwmon API and adds temperature zones for NVME drives. The thermal subsystem
can use this information to set thermal policies, and userspace can access
it using libsensors and/or the "sensors" command.

Example output from the "sensors" command:

nvme0-pci-0100
Adapter: PCI adapter
Composite:    +39.0°C  (high = +85.0°C, crit = +85.0°C)
Sensor 1:     +39.0°C
Sensor 2:     +41.0°C

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use devm_kfree() to release memory in error path

 drivers/nvme/host/Kconfig      |  10 ++
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |   5 +
 drivers/nvme/host/nvme-hwmon.c | 163 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h       |   8 ++
 5 files changed, 187 insertions(+)
 create mode 100644 drivers/nvme/host/nvme-hwmon.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 2b36f052bfb9..aeb49e16e386 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -23,6 +23,16 @@ config NVME_MULTIPATH
 	   /dev/nvmeXnY device will show up for each NVMe namespaces,
 	   even if it is accessible through multiple controllers.
 
+config NVME_HWMON
+	bool "NVME hardware monitoring"
+	depends on (NVME_CORE=y && HWMON=y) || (NVME_CORE=m && HWMON)
+	help
+	  This provides support for NVME hardware monitoring. If enabled,
+	  a hardware monitoring device will be created for each NVME drive
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
index fa7ba09dca77..fc1d4b146717 100644
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
@@ -2897,6 +2900,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ctrl->identified = true;
 
+	nvme_hwmon_init(ctrl);
+
 	return 0;
 
 out_free:
diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmon.c
new file mode 100644
index 000000000000..af5eda326ec6
--- /dev/null
+++ b/drivers/nvme/host/nvme-hwmon.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVM Express hardware monitoring support
+ * Copyright (c) 2019, Guenter Roeck
+ */
+
+#include <linux/hwmon.h>
+
+#include "nvme.h"
+
+struct nvme_hwmon_data {
+	struct nvme_ctrl *ctrl;
+	struct nvme_smart_log log;
+};
+
+static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
+{
+	return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
+			    &data->log, sizeof(data->log), 0);
+}
+
+static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	struct nvme_hwmon_data *data = dev_get_drvdata(dev);
+	struct nvme_smart_log *log = &data->log;
+	int err;
+	int temp;
+
+	err = nvme_hwmon_get_smart_log(data);
+	if (err)
+		return err < 0 ? err : -EPROTO;
+
+	switch (attr) {
+	case hwmon_temp_max:
+		*val = (data->ctrl->wctemp - 273) * 1000;
+		break;
+	case hwmon_temp_crit:
+		*val = (data->ctrl->cctemp - 273) * 1000;
+		break;
+	case hwmon_temp_input:
+		if (!channel)
+			temp = le16_to_cpup((__le16 *)log->temperature);
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
+	.is_visible = nvme_hwmon_is_visible,
+	.read = nvme_hwmon_read,
+	.read_string = nvme_hwmon_read_string,
+};
+
+static const struct hwmon_chip_info nvme_hwmon_chip_info = {
+	.ops = &nvme_hwmon_ops,
+	.info = nvme_hwmon_info,
+};
+
+void nvme_hwmon_init(struct nvme_ctrl *ctrl)
+{
+	struct device *dev = ctrl->device;
+	struct nvme_hwmon_data *data;
+	struct device *hwmon;
+	int err;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->ctrl = ctrl;
+
+	err = nvme_hwmon_get_smart_log(data);
+	if (err) {
+		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
+		devm_kfree(dev, data);
+		return;
+	}
+
+	hwmon = devm_hwmon_device_register_with_info(dev, dev_name(dev),
+						     data,
+						     &nvme_hwmon_chip_info,
+						     NULL);
+	if (IS_ERR(hwmon)) {
+		dev_warn(dev, "Failed to instantiate hwmon device\n");
+		devm_kfree(dev, data);
+	}
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e8401352c2..e6460c1216bc 100644
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
 
+#if IS_ENABLED(CONFIG_NVME_HWMON)
+void nvme_hwmon_init(struct nvme_ctrl *ctrl);
+#else
+static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
+#endif
+
 #endif /* _NVME_H */
-- 
2.17.1

