Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF05E295AE9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 10:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508535AbgJVIui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 04:50:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:30334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508497AbgJVIui (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Oct 2020 04:50:38 -0400
IronPort-SDR: UvAAUllRhEM831SIxhc+F4MLsjYhRrW/vpv6XKYULxpiHWZOtdgLBKas6MGPE0jW8SjX5K29m0
 gbOOHYjihl0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="154447989"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="154447989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 01:50:37 -0700
IronPort-SDR: 5ZpNDfdJ6tu9t74RkPWecGI8aTOQuWNnicvSXQI2xssfu6SJgX68ueNh0t17URA95tdf7VjO9I
 OC5KdTQR6Y0Q==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="466609054"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 01:50:35 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v2] PM / sysfs: Expose suspend resume driver flags in sysfs
Date:   Thu, 22 Oct 2020 16:52:44 +0800
Message-Id: <20201022085244.1860-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently there are 4 driver flags to control system suspend/resume
behavior: DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME. Make these flags
visible in sysfs as read-only to get a brief understanding of the
expected behavior of each device during suspend/resume, so as to
facilitate suspend/resume debugging/tuning.

For example:
/sys/devices/pci0000:00/0000:00:15.1/power/driver_flags:4
(DPM_FLAG_SMART_SUSPEND)

/sys/devices/pci0000:00/0000:00:07.3/power/driver_flags:5
(DPM_FLAG_NO_DIRECT_COMPLETE | DPM_FLAG_SMART_SUSPEND)

Acked-by: Len Brown <len.brown@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Adding description in Documentation/ABI/testing/sysfs-devices-power
    according to Greg's suggestion.
--
 Documentation/ABI/testing/sysfs-devices-power | 11 +++++++
 drivers/base/power/sysfs.c                    | 29 ++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1763e64dd152..8ea68639ab3a 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -269,3 +269,14 @@ Description:
 		the current runtime PM status of the device, which may be
 		"suspended", "suspending", "resuming", "active", "error" (fatal
 		error), or "unsupported" (runtime PM is disabled).
+
+What:		/sys/devices/.../power/driver_flags
+Date:		October 2020
+Contact:	Chen Yu <yu.c.chen@intel.com>
+Description:
+		The /sys/devices/.../driver_flags attribute contains the driver
+		flags to control system suspend/resume. The flag is a combination
+		of DPM_FLAG_NO_DIRECT_COMPLETE, DPM_FLAG_SMART_PREPARE,
+		DPM_FLAG_SMART_SUSPEND and DPM_FLAG_MAY_SKIP_RESUME, or 0 if the
+		driver has not set any flag. This attribute is read-only. If
+		CONFIG_PM_ADVANCED_DEBUG is not set this attribute is empty.
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a1474fb67db9..48313a1040a5 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -607,6 +607,13 @@ static ssize_t async_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RW(async);
 
+static ssize_t driver_flags_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x\n", dev->power.driver_flags);
+}
+static DEVICE_ATTR_RO(driver_flags);
+
 #endif /* CONFIG_PM_SLEEP */
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 
@@ -691,6 +698,20 @@ static const struct attribute_group pm_qos_flags_attr_group = {
 	.attrs	= pm_qos_flags_attrs,
 };
 
+static struct attribute *pm_driver_flags_attrs[] = {
+#ifdef CONFIG_PM_ADVANCED_DEBUG
+#ifdef CONFIG_PM_SLEEP
+	&dev_attr_driver_flags.attr,
+#endif
+#endif
+	NULL,
+};
+
+static const struct attribute_group pm_driver_flags_attr_group = {
+	.name	= power_group_name,
+	.attrs	= pm_driver_flags_attrs,
+};
+
 int dpm_sysfs_add(struct device *dev)
 {
 	int rc;
@@ -719,11 +740,17 @@ int dpm_sysfs_add(struct device *dev)
 		if (rc)
 			goto err_wakeup;
 	}
-	rc = pm_wakeup_source_sysfs_add(dev);
+	rc = sysfs_merge_group(&dev->kobj, &pm_driver_flags_attr_group);
 	if (rc)
 		goto err_latency;
+
+	rc = pm_wakeup_source_sysfs_add(dev);
+	if (rc)
+		goto err_flags;
 	return 0;
 
+ err_flags:
+	sysfs_unmerge_group(&dev->kobj, &pm_driver_flags_attr_group);
  err_latency:
 	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
  err_wakeup:
-- 
2.17.1

