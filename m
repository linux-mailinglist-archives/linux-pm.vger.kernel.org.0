Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B7331B66
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 01:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhCIAGK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 19:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhCIAFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 19:05:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7BC06174A;
        Mon,  8 Mar 2021 16:05:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l22so525739wme.1;
        Mon, 08 Mar 2021 16:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hszomIttq+lgO1NdDWgXz/ydcZ0/je2SdJj7Ee9LH58=;
        b=YBkwuJSRLoh8BFOqtZGbOXRNbMH/fFPVGZ62uOdVNf7o0/VmaOLge0e19hmAW5sqAa
         FGARHPNcJRtW3Wbfh2UgyFbCzXUV5WvNjY2kGwCN0HiD7uP1XHjNiIbTmfTNGJs7vRC9
         yBJdWSAHCr3IaKI9K/qGbYE6DneqxMhTkTpK8KpOaKABUaiCYR9bCiuOWZOsMqxT4t+k
         mkMVBGB2rE+dqL+QpW3H05i4qTAGLdS3KubpleP6El3POoysCubt4tDPuBhj+ZFlyWm2
         0Mi+qD/Ztsd1lfkJ1AoJGrJP6a5Mx8vxqxkule8CPTaLgw7NtDVW+daMcwJp58k82aaP
         Kj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hszomIttq+lgO1NdDWgXz/ydcZ0/je2SdJj7Ee9LH58=;
        b=gljxPJqtwXblfoThdET87gAyyjHciI+YVFcw0DG6jf1YIfBeeLFGqmAVwm8kvCUj/e
         Pf5su7Rhj96KTtZ/UFDbcyWRMtVfs46wwsnQThrxxgAid9fkRDUH6ZgU0lbVo28e4N2d
         1kJ2PZrHW15KjtVBJg7VA80/Pzo4sQjs/pR7MMhfCM0gRh96yEyf9PXWs7EG0w+yTcSN
         XseHFrp5Tz/BvVWoFc1/nhakFrZGd0yngIU0sYEdf3u92pCG9ehel4DmwVHiUNc+fgw8
         PWHjuChATPNm58KM/7wN6AZ8h3zvaCCjquclXNorC+eA6kHduDUAvgSxxkPlqzS5OWQO
         dnyA==
X-Gm-Message-State: AOAM5329yUHnsM8GgSYn2iNS0nppMc+SCbYqSXXw45SOPvxABrkaHW/N
        zZn8XkKclgkreE6JIpEG4JU=
X-Google-Smtp-Source: ABdhPJwgiBaQwXqEQmmgMdimoIkQuQYO40VuhxkKe/SlwAil3ck6mLpwMCnadB5KRlQVf6ODY8gTYA==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr1082406wmk.123.1615248340468;
        Mon, 08 Mar 2021 16:05:40 -0800 (PST)
Received: from xws.localdomain (pd9ea322b.dip0.t-ipconnect.de. [217.234.50.43])
        by smtp.gmail.com with ESMTPSA id 75sm1333623wma.23.2021.03.08.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:05:40 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: Add AC driver for Surface Aggregator Module
Date:   Tue,  9 Mar 2021 01:05:30 +0100
Message-Id: <20210309000530.2165752-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309000530.2165752-1-luzmaximilian@gmail.com>
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On newer Microsoft Surface models (specifically 7th-generation, i.e.
Surface Pro 7, Surface Book 3, Surface Laptop 3, and Surface Laptop Go),
battery and AC status/information is no longer handled via standard ACPI
devices, but instead directly via the Surface System Aggregator Module
(SSAM), i.e. the embedded controller on those devices.

While on previous generation models, AC status is also handled via SSAM,
an ACPI shim was present to translate the standard ACPI AC interface to
SSAM requests. The SSAM interface itself, which is modeled closely after
the ACPI interface, has not changed.

This commit introduces a new SSAM client device driver to support AC
status/information via the aforementioned interface on said Surface
models.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Note: This patch depends on the

    platform/surface: Add Surface Aggregator device registry

series. More specifically patch

    platform/surface: Set up Surface Aggregator device registry

The full series has been merged into the for-next branch of the
platform-drivers-x86 tree [1]. The commit in question can be found at
[2].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=fc622b3d36e6d91330fb21506b9ad1e3206a4dde

---
 MAINTAINERS                            |   1 +
 drivers/power/supply/Kconfig           |  16 ++
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/surface_charger.c | 296 +++++++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 drivers/power/supply/surface_charger.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f44521abe8bf..d6651ba93997 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11867,6 +11867,7 @@ L:	linux-pm@vger.kernel.org
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/power/supply/surface_battery.c
+F:	drivers/power/supply/surface_charger.c
 
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index cebeff10d543..91f7cf425ac9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -817,4 +817,20 @@ config BATTERY_SURFACE
 	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
 	  Surface Book 3, and Surface Laptop Go.
 
+config CHARGER_SURFACE
+	tristate "AC driver for 7th-generation Microsoft Surface devices"
+	depends on SURFACE_AGGREGATOR_REGISTRY
+	help
+	  Driver for AC devices connected via/managed by the Surface System
+	  Aggregator Module (SSAM).
+
+	  This driver provides AC-information and -status support for Surface
+	  devices where said data is not exposed via the standard ACPI devices.
+	  On those models (7th-generation), AC-information is instead handled
+	  directly via a SSAM client device and this driver.
+
+	  Say M or Y here to include AC status support for 7th-generation
+	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
+	  Surface Book 3, and Surface Laptop Go.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 134041538d2c..a7309a3d1a47 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -102,3 +102,4 @@ obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
 obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
 obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
 obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
+obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
new file mode 100644
index 000000000000..fe484523a2c2
--- /dev/null
+++ b/drivers/power/supply/surface_charger.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AC driver for 7th-generation Microsoft Surface devices via Surface System
+ * Aggregator Module (SSAM).
+ *
+ * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/device.h>
+
+
+/* -- SAM interface. -------------------------------------------------------- */
+
+enum sam_event_cid_bat {
+	SAM_EVENT_CID_BAT_ADP   = 0x17,
+};
+
+enum sam_battery_sta {
+	SAM_BATTERY_STA_OK      = 0x0f,
+	SAM_BATTERY_STA_PRESENT	= 0x10,
+};
+
+/* Get battery status (_STA). */
+SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_sta, __le32, {
+	.target_category = SSAM_SSH_TC_BAT,
+	.command_id      = 0x01,
+});
+
+/* Get platform power source for battery (_PSR / DPTF PSRC). */
+SSAM_DEFINE_SYNC_REQUEST_CL_R(ssam_bat_get_psrc, __le32, {
+	.target_category = SSAM_SSH_TC_BAT,
+	.command_id      = 0x0d,
+});
+
+
+/* -- Device structures. ---------------------------------------------------- */
+
+struct spwr_psy_properties {
+	const char *name;
+	struct ssam_event_registry registry;
+};
+
+struct spwr_ac_device {
+	struct ssam_device *sdev;
+
+	char name[32];
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+
+	struct ssam_event_notifier notif;
+
+	struct mutex lock;  /* Guards access to state below. */
+
+	__le32 state;
+};
+
+
+/* -- State management. ----------------------------------------------------- */
+
+static int spwr_ac_update_unlocked(struct spwr_ac_device *ac)
+{
+	u32 old = ac->state;
+	int status;
+
+	lockdep_assert_held(&ac->lock);
+
+	status = ssam_retry(ssam_bat_get_psrc, ac->sdev, &ac->state);
+	if (status < 0)
+		return status;
+
+	return old != ac->state;
+}
+
+static int spwr_ac_update(struct spwr_ac_device *ac)
+{
+	int status;
+
+	mutex_lock(&ac->lock);
+	status = spwr_ac_update_unlocked(ac);
+	mutex_unlock(&ac->lock);
+
+	return status;
+}
+
+static int spwr_ac_recheck(struct spwr_ac_device *ac)
+{
+	int status;
+
+	status = spwr_ac_update(ac);
+	if (status > 0)
+		power_supply_changed(ac->psy);
+
+	return status >= 0 ? 0 : status;
+}
+
+static u32 spwr_notify_ac(struct ssam_event_notifier *nf, const struct ssam_event *event)
+{
+	struct spwr_ac_device *ac;
+	int status;
+
+	ac = container_of(nf, struct spwr_ac_device, notif);
+
+	dev_dbg(&ac->sdev->dev, "power event (cid = %#04x, iid = %#04x, tid = %#04x)\n",
+		event->command_id, event->instance_id, event->target_id);
+
+	/*
+	 * Allow events of all targets/instances here. Global adapter status
+	 * seems to be handled via target=1 and instance=1, but events are
+	 * reported on all targets/instances in use.
+	 *
+	 * While it should be enough to just listen on 1/1, listen everywhere to
+	 * make sure we don't miss anything.
+	 */
+
+	switch (event->command_id) {
+	case SAM_EVENT_CID_BAT_ADP:
+		status = spwr_ac_recheck(ac);
+		return ssam_notifier_from_errno(status) | SSAM_NOTIF_HANDLED;
+
+	default:
+		return 0;
+	}
+}
+
+
+/* -- Properties. ----------------------------------------------------------- */
+
+static enum power_supply_property spwr_ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static int spwr_ac_get_property(struct power_supply *psy, enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct spwr_ac_device *ac = power_supply_get_drvdata(psy);
+	int status;
+
+	mutex_lock(&ac->lock);
+
+	status = spwr_ac_update_unlocked(ac);
+	if (status)
+		goto out;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = !!le32_to_cpu(ac->state);
+		break;
+
+	default:
+		status = -EINVAL;
+		goto out;
+	}
+
+out:
+	mutex_unlock(&ac->lock);
+	return status;
+}
+
+
+/* -- Device setup. --------------------------------------------------------- */
+
+static void spwr_ac_init(struct spwr_ac_device *ac, struct ssam_device *sdev,
+			 struct ssam_event_registry registry, const char *name)
+{
+	mutex_init(&ac->lock);
+	strncpy(ac->name, name, ARRAY_SIZE(ac->name) - 1);
+
+	ac->sdev = sdev;
+
+	ac->notif.base.priority = 1;
+	ac->notif.base.fn = spwr_notify_ac;
+	ac->notif.event.reg = registry;
+	ac->notif.event.id.target_category = sdev->uid.category;
+	ac->notif.event.id.instance = 0;
+	ac->notif.event.mask = SSAM_EVENT_MASK_NONE;
+	ac->notif.event.flags = SSAM_EVENT_SEQUENCED;
+
+	ac->psy_desc.name = ac->name;
+	ac->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+	ac->psy_desc.properties = spwr_ac_props;
+	ac->psy_desc.num_properties = ARRAY_SIZE(spwr_ac_props);
+	ac->psy_desc.get_property = spwr_ac_get_property;
+}
+
+static void spwr_ac_destroy(struct spwr_ac_device *ac)
+{
+	mutex_destroy(&ac->lock);
+}
+
+static int spwr_ac_register(struct spwr_ac_device *ac)
+{
+	struct power_supply_config psy_cfg = {};
+	__le32 sta;
+	int status;
+
+	/* Make sure the device is there and functioning properly. */
+	status = ssam_retry(ssam_bat_get_sta, ac->sdev, &sta);
+	if (status)
+		return status;
+
+	if ((le32_to_cpu(sta) & SAM_BATTERY_STA_OK) != SAM_BATTERY_STA_OK)
+		return -ENODEV;
+
+	psy_cfg.drv_data = ac;
+	ac->psy = power_supply_register(&ac->sdev->dev, &ac->psy_desc, &psy_cfg);
+	if (IS_ERR(ac->psy))
+		return PTR_ERR(ac->psy);
+
+	status = ssam_notifier_register(ac->sdev->ctrl, &ac->notif);
+	if (status)
+		power_supply_unregister(ac->psy);
+
+	return status;
+}
+
+static int spwr_ac_unregister(struct spwr_ac_device *ac)
+{
+	ssam_notifier_unregister(ac->sdev->ctrl, &ac->notif);
+	power_supply_unregister(ac->psy);
+	return 0;
+}
+
+
+/* -- Driver setup. --------------------------------------------------------- */
+
+static int __maybe_unused surface_ac_resume(struct device *dev)
+{
+	return spwr_ac_recheck(dev_get_drvdata(dev));
+}
+SIMPLE_DEV_PM_OPS(surface_ac_pm_ops, NULL, surface_ac_resume);
+
+static int surface_ac_probe(struct ssam_device *sdev)
+{
+	const struct spwr_psy_properties *p;
+	struct spwr_ac_device *ac;
+	int status;
+
+	p = ssam_device_get_match_data(sdev);
+	if (!p)
+		return -ENODEV;
+
+	ac = devm_kzalloc(&sdev->dev, sizeof(*ac), GFP_KERNEL);
+	if (!ac)
+		return -ENOMEM;
+
+	spwr_ac_init(ac, sdev, p->registry, p->name);
+	ssam_device_set_drvdata(sdev, ac);
+
+	status = spwr_ac_register(ac);
+	if (status)
+		spwr_ac_destroy(ac);
+
+	return status;
+}
+
+static void surface_ac_remove(struct ssam_device *sdev)
+{
+	struct spwr_ac_device *ac = ssam_device_get_drvdata(sdev);
+
+	spwr_ac_unregister(ac);
+	spwr_ac_destroy(ac);
+}
+
+static const struct spwr_psy_properties spwr_psy_props_adp1 = {
+	.name = "ADP1",
+	.registry = SSAM_EVENT_REGISTRY_SAM,
+};
+
+static const struct ssam_device_id surface_ac_match[] = {
+	{ SSAM_SDEV(BAT, 0x01, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1 },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, surface_ac_match);
+
+static struct ssam_device_driver surface_ac_driver = {
+	.probe = surface_ac_probe,
+	.remove = surface_ac_remove,
+	.match_table = surface_ac_match,
+	.driver = {
+		.name = "surface_ac",
+		.pm = &surface_ac_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_ssam_device_driver(surface_ac_driver);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("AC driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.30.1

