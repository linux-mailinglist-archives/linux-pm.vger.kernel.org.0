Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12F026B1EC
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 00:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIOWhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 18:37:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:55545 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbgIOWhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 18:37:13 -0400
IronPort-SDR: whCXvDBSxHR95KUy3HOBjxgS1whIOcfbzD10l9iHezUG9tIbrR12ByDHcQYVnv0hD5v2neXAd8
 jyT1LSGvKMqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147112838"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="147112838"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 15:37:07 -0700
IronPort-SDR: PwmIcDhQFwZqgW2LPuXodt5U9r1JMME4azuk8p7k2G/slEZW0dq8f0pK6Ad6FeaJPiBvYdZgbi
 8VQ53j7ERqZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="306813341"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2020 15:37:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/3] thermal: int340x: Add keep alive response method
Date:   Tue, 15 Sep 2020 15:36:50 -0700
Message-Id: <20200915223650.406046-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915223650.406046-1-srinivas.pandruvada@linux.intel.com>
References: <20200915223650.406046-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When firmware requests keep alive response, send an event to user space
to confirm by using imok sysfs entry.

Create a new sysf entry called "imok". User space can write an integer,
which results in execution of IMOK ACPI method of INT3400 thermal zone
device. This results in sending response to firmware request for keep
alive.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 2ca295e6e64d..0966551cbaaa 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -14,6 +14,7 @@
 
 #define INT3400_THERMAL_TABLE_CHANGED 0x83
 #define INT3400_ODVP_CHANGED 0x88
+#define INT3400_KEEP_ALIVE 0xA0
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
@@ -83,8 +84,33 @@ static struct bin_attribute *data_attributes[] = {
 	NULL,
 };
 
+static ssize_t imok_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
+	acpi_status status;
+	int input, ret;
+
+	ret = kstrtouint(buf, 10, &input);
+	if (ret)
+		return ret;
+	status = acpi_execute_simple_method(priv->adev->handle, "IMOK", input);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return count;
+}
+
+static DEVICE_ATTR_WO(imok);
+
+static struct attribute *imok_attr[] = {
+	&dev_attr_imok.attr,
+	NULL
+};
+
 static const struct attribute_group data_attribute_group = {
 	.bin_attrs = data_attributes,
+	.attrs = imok_attr,
 };
 
 static ssize_t available_uuids_show(struct device *dev,
@@ -358,6 +384,9 @@ static void int3400_notify(acpi_handle handle,
 	case INT3400_THERMAL_TABLE_CHANGED:
 		therm_event = THERMAL_TABLE_CHANGED;
 		break;
+	case INT3400_KEEP_ALIVE:
+		therm_event = THERMAL_EVENT_KEEP_ALIVE;
+		break;
 	case INT3400_ODVP_CHANGED:
 		evaluate_odvp(priv);
 		therm_event = THERMAL_DEVICE_POWER_CAPABILITY_CHANGED;
-- 
2.25.4

