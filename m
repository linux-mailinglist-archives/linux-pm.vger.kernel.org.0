Return-Path: <linux-pm+bounces-39743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C49CD382A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D75D300FFA1
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44222DEA9B;
	Sat, 20 Dec 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eYuVl2YJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C9258CDF
	for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2025 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766269878; cv=none; b=ZUAO2oQHcoU/0QH5l2sJeefgC9RdA0r4W8hO+GMtd9jG3kUlkeHqucuqAaWmLbNZujG76RCSBS7XT8gxprcp0UXJPLtPOee6YTOqvYEDRZVzxxjEy/RPEotmOKHVpMDIYA7OuzNkpRDKeLqMZWJpMKEQ6T7w32aycsm7Zsqh3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766269878; c=relaxed/simple;
	bh=kV63Zh38H+VacC8DXVV2Z2Ta6d9kCNbdvI6mFsSmHCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8eIq85JwdZ9Mg+NFYOZPIagNSvYeZg2Xj4yshBjh0vuVoYagkRCVcSrH36l9cnp7m68g5Nw+RNwrR3MRzHlstimVgWRgumCK5mc++0BoL0D26heBcrb16/UUocjzKyH7Kh6DafH9i1HmzVLgG6CEwtiHuGlnwozLB1c/G/tjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eYuVl2YJ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766269864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ATSohVrDsUPFERPnSjtnwMUfGmihgrPoXzJtDALVRVo=;
	b=eYuVl2YJOWEt9T14aR0Rf4ggxeiqN6+YhJSqikZmgJaV+ArxXWxB+Y5YVwVkANx5njkdrk
	N4t0FQ6aohZAQdlWVYInxiRWwifpGo9PYn+f+1eCJriWRfDCp5rXhSwISeCP6cQl80rRm9
	yQLlEW+4IMwQ8priDYppR/VL/uCX2b8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Xin Li (Intel)" <xin@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: int340x: Use sysfs_emit{_at} in sysfs show functions
Date: Sat, 20 Dec 2025 23:30:11 +0100
Message-ID: <20251220223026.125678-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
functions. sysfs_emit() and sysfs_emit_at() are preferred to format
sysfs output as it provides better bounds checking.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 .../intel/int340x_thermal/processor_thermal_device.c     | 5 +++--
 .../intel/int340x_thermal/processor_thermal_rfim.c       | 9 +++++----
 .../intel/int340x_thermal/processor_thermal_wt_req.c     | 7 ++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 48e7849d4816..f80dbe2ca7e4 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/sysfs.h>
 #include <linux/thermal.h>
 #include <asm/msr.h>
 #include "int340x_thermal_zone.h"
@@ -23,7 +24,7 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 { \
 	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev); \
 	\
-	return sprintf(buf, "%lu\n",\
+	return sysfs_emit(buf, "%lu\n",\
 	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
 }
 
@@ -143,7 +144,7 @@ static ssize_t tcc_offset_degree_celsius_show(struct device *dev,
 	if (offset < 0)
 		return offset;
 
-	return sprintf(buf, "%d\n", offset);
+	return sysfs_emit(buf, "%d\n", offset);
 }
 
 static ssize_t tcc_offset_degree_celsius_store(struct device *dev,
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 589a3a71f0c4..bb9398dfa3c1 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/sysfs.h>
 #include "processor_thermal_device.h"
 
 MODULE_IMPORT_NS("INT340X_THERMAL");
@@ -211,9 +212,9 @@ static ssize_t suffix##_show(struct device *dev,\
 	ret = (reg_val >> mmio_regs[ret].shift) & mmio_regs[ret].mask;\
 	err = get_mapped_string(mapping, attr->attr.name, ret, &str);\
 	if (!err)\
-		return sprintf(buf, "%s\n", str);\
+		return sysfs_emit(buf, "%s\n", str);\
 	if (err == -EOPNOTSUPP)\
-		return sprintf(buf, "%u\n", ret);\
+		return sysfs_emit(buf, "%u\n", ret);\
 	return err;\
 }
 
@@ -398,7 +399,7 @@ static ssize_t rfi_restriction_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%llu\n", resp);
+	return sysfs_emit(buf, "%llu\n", resp);
 }
 
 static ssize_t ddr_data_rate_show(struct device *dev,
@@ -413,7 +414,7 @@ static ssize_t ddr_data_rate_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%llu\n", resp);
+	return sysfs_emit(buf, "%llu\n", resp);
 }
 
 static DEVICE_ATTR_RW(rfi_restriction);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
index b95810f4a011..2372f5202019 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/sysfs.h>
 #include "processor_thermal_device.h"
 
 /* List of workload types */
@@ -28,9 +29,9 @@ static ssize_t workload_available_types_show(struct device *dev,
 	int ret = 0;
 
 	while (workload_types[i] != NULL)
-		ret += sprintf(&buf[ret], "%s ", workload_types[i++]);
+		ret += sysfs_emit_at(buf, ret, "%s ", workload_types[i++]);
 
-	ret += sprintf(&buf[ret], "\n");
+	ret += sysfs_emit_at(buf, ret, "\n");
 
 	return ret;
 }
@@ -85,7 +86,7 @@ static ssize_t workload_type_show(struct device *dev,
 	if (cmd_resp > ARRAY_SIZE(workload_types) - 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%s\n", workload_types[cmd_resp]);
+	return sysfs_emit(buf, "%s\n", workload_types[cmd_resp]);
 }
 
 static DEVICE_ATTR_RW(workload_type);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


