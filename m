Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014A82956AE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 05:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895321AbgJVDVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 23:21:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:7623 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443456AbgJVDVi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Oct 2020 23:21:38 -0400
IronPort-SDR: 9ph1gteUXu2hpeelS5YSlshI3jECgdkZENqL9h0iMtgyU7MfdVmUgHyfdh82/+0x7k+ty3E29E
 DBa1mR6zXIqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="154418920"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="154418920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 20:21:37 -0700
IronPort-SDR: zVq9ZMmOMBwT1s+CtuqYsuoILt9sZOJdDNBiF4scm8qMmDbyRHIhtys6CJz6iXMwHUACl+8gy+
 73Hppwtn9ExA==
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="302212891"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 20:21:35 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] PM / sysfs: Expose suspend resume driver flags in sysfs
Date:   Thu, 22 Oct 2020 11:23:24 +0800
Message-Id: <20201022032324.25308-1-yu.c.chen@intel.com>
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
 drivers/base/power/sysfs.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

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

