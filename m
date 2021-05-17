Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF85B382437
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 08:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhEQGYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 02:24:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:34734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235059AbhEQGYK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 May 2021 02:24:10 -0400
IronPort-SDR: 7qJUwtA9Uaz5RAzBb2aImJUBNLXn44+KHWVi5VGY2sT7xHWlNhtGN3xmRpZ94sZOEw26+gXrqs
 0gdnHx0GLIwA==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="197306273"
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="197306273"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2021 23:22:54 -0700
IronPort-SDR: S/3PXjdjnMfHkaMCBcTuZpdrVDUa60Qwuw+4IH4WQBnCWf4UdfvFW/Ppx79wW4Z7aZOLsn3yhF
 mzzIZbTTZznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,306,1613462400"; 
   d="scan'208";a="393388427"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2021 23:22:53 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] thermal: int340x: processor_thermal: Export additional attributes
Date:   Sun, 16 May 2021 23:14:41 -0700
Message-Id: <20210517061441.1921901-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210517061441.1921901-1-srinivas.pandruvada@linux.intel.com>
References: <20210517061441.1921901-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export additional attributes:

ddr_data_rate (RO) : Show current DDR (Double Data Rate) data rate.
rfi_restriction (RW) : Show or set current state for RFI (Radio
			Frequency Interference) protection.

These attributes use mailbox commands to get/set information. Here
command codes are:
0x0007: Read RFI restriction
0x0107: Read DDR data rate
0x0008: Write RFI restriction

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_rfim.c  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index aef993a813e2..2b8a3235d518 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -190,6 +190,59 @@ static DEVICE_ATTR_RO(ddr_data_rate_point_2);
 static DEVICE_ATTR_RO(ddr_data_rate_point_3);
 static DEVICE_ATTR_RW(rfi_disable);
 
+static ssize_t rfi_restriction_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	u16 cmd_id = 0x0008;
+	u32 cmd_resp;
+	u32 input;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, input, &cmd_resp);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t rfi_restriction_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	u16 cmd_id = 0x0007;
+	u32 cmd_resp;
+	int ret;
+
+	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", cmd_resp);
+}
+
+static ssize_t ddr_data_rate_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	u16 cmd_id = 0x0107;
+	u32 cmd_resp;
+	int ret;
+
+	ret = processor_thermal_send_mbox_cmd(to_pci_dev(dev), cmd_id, 0, &cmd_resp);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", cmd_resp);
+}
+
+static DEVICE_ATTR_RW(rfi_restriction);
+static DEVICE_ATTR_RO(ddr_data_rate);
+
 static struct attribute *dvfs_attrs[] = {
 	&dev_attr_rfi_restriction_run_busy.attr,
 	&dev_attr_rfi_restriction_err_code.attr,
@@ -199,6 +252,8 @@ static struct attribute *dvfs_attrs[] = {
 	&dev_attr_ddr_data_rate_point_2.attr,
 	&dev_attr_ddr_data_rate_point_3.attr,
 	&dev_attr_rfi_disable.attr,
+	&dev_attr_ddr_data_rate.attr,
+	&dev_attr_rfi_restriction.attr,
 	NULL
 };
 
-- 
2.27.0

