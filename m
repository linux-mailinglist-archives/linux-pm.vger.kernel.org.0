Return-Path: <linux-pm+bounces-9574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C551590EB62
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD5B284D2B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4B1487F1;
	Wed, 19 Jun 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfCrnNG9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B8145334;
	Wed, 19 Jun 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801173; cv=none; b=YLjpp6CMa+k+84Vo0LyoX/mwyMT2tj0cu0uSdsSySK8ZAQSyahOqrKuRaBVFXwJVHErHsym0FndbQWopUFrVT70Epem8eSaUVG8GIu8uZixn7aMKpkhglJYPLKvVWe9xl4cLd3tGPzWHPakXC9xOpQcwAfxfG6KtY+r9/MduXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801173; c=relaxed/simple;
	bh=aiGo3rcf2uo+eDhr9xR5stSoVwaMZ13XXsXjohIC9K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqNZ4AF+1/lo+PV/Cx21EzTjsZNISvX5zJVfJBpSCo8Y9lL7sxtG9Aj4buM/BimCGAbJxebp1u3WPc2xFFO19WX5GRSF/iZI1Vpxf2GV53q7feKwPs/ffmDsZA6ib2b09zPxAxylcqAga4I2LcnR5OBLW3KWKjOKANc67Jqas/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfCrnNG9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718801172; x=1750337172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aiGo3rcf2uo+eDhr9xR5stSoVwaMZ13XXsXjohIC9K0=;
  b=DfCrnNG9A9uTBn2M1VkXZs7Bj3QcCjyn0wWs/0ELFtHzegOmkZmtUpvK
   emWWoQxkSP3x2iFGLru6PvXBYW4dikgUcB0Dsrne/NBW7nxsZdJz/wxZX
   V3h19RNNuD/ZZwo/t2j2S5BGrxH8AEPrfFPa3cpDzE86nEWO933aK8vZO
   +O9KqbPVvha2M33i5wqil1pTPmwQEVv+lC0J29bx2P1rNCLTty5OLCWof
   pClaWLLs5Qwkj9JkMBWEIE4iyWIn/LAN1UjmYGesBFRvGc0yBdd8Lb+fr
   Iu2sip4L/p4E78E1YIMt+P9ztHn/8/5RZU+37pueVFGpwsfiPSLoB0kIf
   A==;
X-CSE-ConnectionGUID: 81fivVMSR8OWmZrKhcBPoA==
X-CSE-MsgGUID: nrlHzopmTD+pUjbxQM/LaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15449939"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15449939"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:46:09 -0700
X-CSE-ConnectionGUID: cpwbqXB3QQed3i8AjUIhsQ==
X-CSE-MsgGUID: we8JRXOpSKS3fHZJwipsdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46344344"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005.fm.intel.com with ESMTP; 19 Jun 2024 05:46:08 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] thermal: intel: int340x: Capability to map user space to firmware values
Date: Wed, 19 Jun 2024 05:45:59 -0700
Message-ID: <20240619124600.491168-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
References: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To ensure compatibility between user inputs and firmware requirements,
a conversion mechanism is necessary for certain attributes. For instance,
on some platforms, the DLVR frequency must be translated into a predefined
index before being communicated to the firmware. On Lunar Lake platform:
RFI_FREQ_SELECT and RFI_FREQ:
Index 0 corresponds to a DLVR frequency of 2227.2 MHz
Index 1 corresponds to a DLVR frequency of 2140 MHz

Introduce a feature that enables the conversion of values between user
space inputs and firmware-accepted formats. This feature would also
facilitate the reverse process, converting firmware values back into user
friendly display values.

To support this functionality, a model-specific mapping table will be
utilized. When available, this table will provide the necessary
translations between user space values and firmware values, ensuring
seamless communication and accurate settings.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_rfim.c  | 80 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index e56db75a94fb..c9c77bca2014 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -19,6 +19,12 @@ struct mmio_reg {
 	u16 shift;
 };
 
+struct mapping_table {
+	const char *attr_name;
+	const u32 value;
+	const char *mapped_str;
+};
+
 /* These will represent sysfs attribute names */
 static const char * const fivr_strings[] = {
 	"vco_ref_code_lo",
@@ -62,6 +68,59 @@ static const struct mmio_reg dlvr_mmio_regs[] = {
 	{ 1, 0x15A10, 1, 0x1, 16}, /* dlvr_pll_busy */
 };
 
+static int match_mapping_table(const struct mapping_table *table, const char *attr_name,
+			       bool match_int_value, const u32 value, const char *value_str,
+			       char **result_str, u32 *result_int)
+{
+	bool attr_matched = false;
+	int i = 0;
+
+	if (!table)
+		return -EOPNOTSUPP;
+
+	while (table[i].attr_name) {
+		if (strncmp(table[i].attr_name, attr_name, strlen(attr_name)))
+			goto match_next;
+
+		attr_matched = true;
+
+		if (match_int_value) {
+			if (table[i].value != value)
+				goto match_next;
+
+			*result_str = (char *)table[i].mapped_str;
+			return 0;
+		}
+
+		if (strncmp(table[i].mapped_str, value_str, strlen(table[i].mapped_str)))
+			goto match_next;
+
+		*result_int = table[i].value;
+
+		return 0;
+match_next:
+		i++;
+	}
+
+	/* If attribute name is matched, then the user space value is invalid */
+	if (attr_matched)
+		return -EINVAL;
+
+	return -EOPNOTSUPP;
+}
+
+static int get_mapped_string(const struct mapping_table *table, const char *attr_name,
+			     u32 value, char **result)
+{
+	return match_mapping_table(table, attr_name, true, value, NULL, result, NULL);
+}
+
+static int get_mapped_value(const struct mapping_table *table, const char *attr_name,
+			    const char *value, unsigned int *result)
+{
+	return match_mapping_table(table, attr_name, false, 0, value, NULL, result);
+}
+
 /* These will represent sysfs attribute names */
 static const char * const dvfs_strings[] = {
 	"rfi_restriction_run_busy",
@@ -93,12 +152,14 @@ static ssize_t suffix##_show(struct device *dev,\
 			      struct device_attribute *attr,\
 			      char *buf)\
 {\
+	const struct mapping_table *mapping = NULL;\
 	struct proc_thermal_device *proc_priv;\
 	struct pci_dev *pdev = to_pci_dev(dev);\
 	const struct mmio_reg *mmio_regs;\
 	const char **match_strs;\
+	int ret, err;\
 	u32 reg_val;\
-	int ret;\
+	char *str;\
 \
 	proc_priv = pci_get_drvdata(pdev);\
 	if (table == 1) {\
@@ -116,7 +177,12 @@ static ssize_t suffix##_show(struct device *dev,\
 		return ret;\
 	reg_val = readl((void __iomem *) (proc_priv->mmio_base + mmio_regs[ret].offset));\
 	ret = (reg_val >> mmio_regs[ret].shift) & mmio_regs[ret].mask;\
-	return sprintf(buf, "%u\n", ret);\
+	err = get_mapped_string(mapping, attr->attr.name, ret, &str);\
+	if (!err)\
+		return sprintf(buf, "%s\n", str);\
+	if (err == -EOPNOTSUPP)\
+		return sprintf(buf, "%u\n", ret);\
+	return err;\
 }
 
 #define RFIM_STORE(suffix, table)\
@@ -124,6 +190,7 @@ static ssize_t suffix##_store(struct device *dev,\
 			       struct device_attribute *attr,\
 			       const char *buf, size_t count)\
 {\
+	const struct mapping_table *mapping = NULL;\
 	struct proc_thermal_device *proc_priv;\
 	struct pci_dev *pdev = to_pci_dev(dev);\
 	unsigned int input;\
@@ -150,9 +217,14 @@ static ssize_t suffix##_store(struct device *dev,\
 		return ret;\
 	if (mmio_regs[ret].read_only)\
 		return -EPERM;\
-	err = kstrtouint(buf, 10, &input);\
-	if (err)\
+	err = get_mapped_value(mapping, attr->attr.name, buf, &input);\
+	if (err == -EINVAL)\
 		return err;\
+	if (err == -EOPNOTSUPP) {\
+		err = kstrtouint(buf, 10, &input);\
+		if (err)\
+			return err;\
+	} \
 	mask = GENMASK(mmio_regs[ret].shift + mmio_regs[ret].bits - 1, mmio_regs[ret].shift);\
 	reg_val = readl((void __iomem *) (proc_priv->mmio_base + mmio_regs[ret].offset));\
 	reg_val &= ~mask;\
-- 
2.40.1


