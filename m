Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFA70E8AA
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 00:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjEWWNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 18:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjEWWNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 18:13:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A45BBF;
        Tue, 23 May 2023 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684880021; x=1716416021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ichJgs+7zKZfwJkcA9fRNmOEw3/bn2Q1hi+gXlXeQ+Y=;
  b=Xh/9QEwHwRCMhfq06O37YpU7UJ3biaaXt6oyOWSLETcVoiZ9nkyeG43v
   DhO/jdyDIEiPXdrzkVt5aAhguTi2IE99eA9nadNp368o+hLwr9A/iNDMH
   KpcvXg0RtWewM/176skiXei3xyLD5YqyEItgFId04Sm1P+w5e0uXXKyb2
   xDjOHaziU3TSlQ1r2BAoF02tJhrLZDu/aVvyUYduCWUJwVqbspiUyaR0O
   eTiQA+rRgDY2JEs43H5QEXDUhBgYl8BY0+VRgrRjtP9Ra5Y71yBK7D/FT
   I8oykeGa+tPsfjVB+OiyxWDk4Ncw7A0fZUcfjRBFQYb5LazxY+b3b8SHU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350887528"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="350887528"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="734896376"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="734896376"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga008.jf.intel.com with ESMTP; 23 May 2023 15:13:40 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RESEND][PATCH] thermal: intel: int340x_thermal: New IOCTLs for thermal
Date:   Tue, 23 May 2023 15:13:39 -0700
Message-Id: <20230523221339.2377625-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Export Passive version 2 table similar to the way _TRT and _ART tables
via IOCTLs.

This removes need for binary utility to read ACPI Passive 2 table by
providing open source support. This table already has open source
implementation in the user space thermald, when the table is part of
data vault exported by the int3400 sysfs.

This table is supported in some older platforms before Ice Lake
generation.

Passive 2 tables contain multiple entries. Each entry has following
fields:

Source: Named Reference (String). This is the source device for
temperature.
Target: Named Reference (String). This is the target device to control.
Priority: Priority of this device compared to others.
SamplingPeriod: Time Period in 1/10 of seconds unit.
PassiveTemp: Passive Temperature in 1/10 of Kelvin.
SourceDomain: Domain for the source (00:Processor, others reserved).
ControlKnob: Type of control knob (00:Power Limit 1, others: reserved)
Limit: The target state to set on reaching passive temperature.
This can be a string "max", "min" or a power limit value.
LimitStepSize: Step size during activation.
UnLimitStepSize: Step size during deactivation.
Reserved1: Reserved

Four IOCTLs are added similar to IOCTLs for reading TRT:

ACPI_THERMAL_GET_PSVT_COUNT: Number of passive 2 entries.
ACPI_THERMAL_GET_PSVT_LEN: Total return data size (count x each
passive 2 entry size).
ACPI_THERMAL_GET_PSVT: Get the data as an array of objects with
passive 2 entries.

This change is based on original development done by:
Todd Brandt <todd.e.brandt@linux.intel.com>

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Resent with the correct series. Sorry about previous posts.

 .../intel/int340x_thermal/acpi_thermal_rel.c  | 218 ++++++++++++++++++
 .../intel/int340x_thermal/acpi_thermal_rel.h  |  57 +++++
 2 files changed, 275 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index 01b80331eab6..c6c4c6ef9e32 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -203,6 +203,151 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
 }
 EXPORT_SYMBOL(acpi_parse_art);
 
+/*
+ * acpi_parse_psvt - Passive Table (PSVT) for passive cooling
+ *
+ * @handle: ACPI handle of the device which contains PSVT
+ * @psvt_count: the number of valid entries resulted from parsing PSVT
+ * @psvtp: pointer to array of psvt entries
+ *
+ */
+int acpi_parse_psvt(acpi_handle handle, int *psvt_count, struct psvt **psvtp)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	int nr_bad_entries = 0, revision;
+	union acpi_object *p;
+	acpi_status status;
+	int i, result = 0;
+	struct psvt *psvts;
+
+	if (!acpi_has_method(handle, "PSVT"))
+		return -ENODEV;
+
+	status = acpi_evaluate_object(handle, "PSVT", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	p = buffer.pointer;
+	if (!p || (p->type != ACPI_TYPE_PACKAGE)) {
+		result = -EFAULT;
+		goto end;
+	}
+
+	/* first package is the revision number */
+	if (p->package.count > 0) {
+		union acpi_object *prev = &(p->package.elements[0]);
+
+		if (prev->type == ACPI_TYPE_INTEGER)
+			revision = (int)prev->integer.value;
+	} else {
+		result = -EFAULT;
+		goto end;
+	}
+
+	/* Support only version 2 */
+	if (revision != 2) {
+		result = -EFAULT;
+		goto end;
+	}
+
+	*psvt_count = p->package.count - 1;
+	if (!*psvt_count) {
+		result = -EFAULT;
+		goto end;
+	}
+
+	psvts = kcalloc(*psvt_count, sizeof(*psvts), GFP_KERNEL);
+	if (!psvts) {
+		result = -ENOMEM;
+		goto end;
+	}
+
+	/* Start index is 1 because the first package is the revision number */
+	for (i = 1; i < p->package.count; i++) {
+		struct acpi_buffer psvt_int_format = { sizeof("RRNNNNNNNNNN"), "RRNNNNNNNNNN" };
+		struct acpi_buffer psvt_str_format = { sizeof("RRNNNNNSNNNN"), "RRNNNNNSNNNN" };
+		union acpi_object *package = &(p->package.elements[i]);
+		struct psvt *psvt = &psvts[i - 1 - nr_bad_entries];
+		struct acpi_buffer *psvt_format = &psvt_int_format;
+		struct acpi_buffer element = { 0, NULL };
+		union acpi_object *knob;
+		struct acpi_device *res;
+		struct psvt *psvt_ptr;
+
+		element.length = ACPI_ALLOCATE_BUFFER;
+		element.pointer = NULL;
+
+		if (package->package.count >= ACPI_NR_PSVT_ELEMENTS) {
+			knob = &(package->package.elements[ACPI_PSVT_CONTROL_KNOB]);
+		} else {
+			nr_bad_entries++;
+			pr_info("PSVT package %d is invalid, ignored\n", i);
+			continue;
+		}
+
+		if (knob->type == ACPI_TYPE_STRING) {
+			psvt_format = &psvt_str_format;
+			if (knob->string.length > ACPI_LIMIT_STR_MAX_LEN) {
+				pr_info("PSVT package %d limit string len exceeds max\n", i);
+				knob->string.length = ACPI_LIMIT_STR_MAX_LEN;
+			}
+		}
+
+		status = acpi_extract_package(&(p->package.elements[i]), psvt_format, &element);
+		if (ACPI_FAILURE(status)) {
+			nr_bad_entries++;
+			pr_info("PSVT package %d is invalid, ignored\n", i);
+			continue;
+		}
+
+		psvt_ptr = (struct psvt *)element.pointer;
+
+		memcpy(psvt, psvt_ptr, sizeof(*psvt_ptr));
+
+		/* The limit element can be string or U64 */
+		psvt->control_knob_type = (u64)knob->type;
+
+		if (knob->type == ACPI_TYPE_STRING) {
+			memset(&psvt->limit, 0, sizeof(u64));
+			strncpy(psvt->limit.string, psvt_ptr->limit.str_ptr, knob->string.length);
+		} else {
+			psvt->limit.integer = psvt_ptr->limit.integer;
+		}
+
+		kfree(element.pointer);
+
+		res = acpi_fetch_acpi_dev(psvt->source);
+		if (!res) {
+			nr_bad_entries++;
+			pr_info("Failed to get source ACPI device\n");
+			continue;
+		}
+
+		res = acpi_fetch_acpi_dev(psvt->target);
+		if (!res) {
+			nr_bad_entries++;
+			pr_info("Failed to get target ACPI device\n");
+			continue;
+		}
+	}
+
+	/* don't count bad entries */
+	*psvt_count -= nr_bad_entries;
+
+	if (!*psvt_count) {
+		result = -EFAULT;
+		kfree(psvts);
+		goto end;
+	}
+
+	*psvtp = psvts;
+
+	return 0;
+
+end:
+	kfree(buffer.pointer);
+	return result;
+}
 
 /* get device name from acpi handle */
 static void get_single_name(acpi_handle handle, char *name)
@@ -289,6 +434,57 @@ static int fill_trt(char __user *ubuf)
 	return ret;
 }
 
+static int fill_psvt(char __user *ubuf)
+{
+	int i, ret, count, psvt_len;
+	union psvt_object *psvt_user;
+	struct psvt *psvts;
+
+	ret = acpi_parse_psvt(acpi_thermal_rel_handle, &count, &psvts);
+	if (ret)
+		return ret;
+
+	psvt_len = count * sizeof(*psvt_user);
+
+	psvt_user = kzalloc(psvt_len, GFP_KERNEL);
+	if (!psvt_user) {
+		ret = -ENOMEM;
+		goto free_psvt;
+	}
+
+	/* now fill in user psvt data */
+	for (i = 0; i < count; i++) {
+		/* userspace psvt needs device name instead of acpi reference */
+		get_single_name(psvts[i].source, psvt_user[i].source_device);
+		get_single_name(psvts[i].target, psvt_user[i].target_device);
+
+		psvt_user[i].priority = psvts[i].priority;
+		psvt_user[i].sample_period = psvts[i].sample_period;
+		psvt_user[i].passive_temp = psvts[i].passive_temp;
+		psvt_user[i].source_domain = psvts[i].source_domain;
+		psvt_user[i].control_knob = psvts[i].control_knob;
+		psvt_user[i].step_size = psvts[i].step_size;
+		psvt_user[i].limit_coeff = psvts[i].limit_coeff;
+		psvt_user[i].unlimit_coeff = psvts[i].unlimit_coeff;
+		psvt_user[i].control_knob_type = psvts[i].control_knob_type;
+		if (psvt_user[i].control_knob_type == ACPI_TYPE_STRING)
+			strncpy(psvt_user[i].limit.string, psvts[i].limit.string,
+				ACPI_LIMIT_STR_MAX_LEN);
+		else
+			psvt_user[i].limit.integer = psvts[i].limit.integer;
+
+	}
+
+	if (copy_to_user(ubuf, psvt_user, psvt_len))
+		ret = -EFAULT;
+
+	kfree(psvt_user);
+
+free_psvt:
+	kfree(psvts);
+	return ret;
+}
+
 static long acpi_thermal_rel_ioctl(struct file *f, unsigned int cmd,
 				   unsigned long __arg)
 {
@@ -298,6 +494,7 @@ static long acpi_thermal_rel_ioctl(struct file *f, unsigned int cmd,
 	char __user *arg = (void __user *)__arg;
 	struct trt *trts = NULL;
 	struct art *arts = NULL;
+	struct psvt *psvts;
 
 	switch (cmd) {
 	case ACPI_THERMAL_GET_TRT_COUNT:
@@ -336,6 +533,27 @@ static long acpi_thermal_rel_ioctl(struct file *f, unsigned int cmd,
 	case ACPI_THERMAL_GET_ART:
 		return fill_art(arg);
 
+	case ACPI_THERMAL_GET_PSVT_COUNT:
+		ret = acpi_parse_psvt(acpi_thermal_rel_handle, &count, &psvts);
+		if (!ret) {
+			kfree(psvts);
+			return put_user(count, (unsigned long __user *)__arg);
+		}
+		return ret;
+
+	case ACPI_THERMAL_GET_PSVT_LEN:
+		/* total length of the data retrieved (count * PSVT entry size) */
+		ret = acpi_parse_psvt(acpi_thermal_rel_handle, &count, &psvts);
+		length = count * sizeof(union psvt_object);
+		if (!ret) {
+			kfree(psvts);
+			return put_user(length, (unsigned long __user *)__arg);
+		}
+		return ret;
+
+	case ACPI_THERMAL_GET_PSVT:
+		return fill_psvt(arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
index 78d942477035..ac376d8f9ee4 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
@@ -14,6 +14,16 @@
 #define ACPI_THERMAL_GET_TRT	_IOR(ACPI_THERMAL_MAGIC, 5, unsigned long)
 #define ACPI_THERMAL_GET_ART	_IOR(ACPI_THERMAL_MAGIC, 6, unsigned long)
 
+/*
+ * ACPI_THERMAL_GET_PSVT_COUNT = Number of PSVT entries
+ * ACPI_THERMAL_GET_PSVT_LEN = Total return data size (PSVT count x each
+ * PSVT entry size)
+ * ACPI_THERMAL_GET_PSVT = Get the data as an array of psvt_objects
+ */
+#define ACPI_THERMAL_GET_PSVT_LEN _IOR(ACPI_THERMAL_MAGIC, 7, unsigned long)
+#define ACPI_THERMAL_GET_PSVT_COUNT _IOR(ACPI_THERMAL_MAGIC, 8, unsigned long)
+#define ACPI_THERMAL_GET_PSVT	_IOR(ACPI_THERMAL_MAGIC, 9, unsigned long)
+
 struct art {
 	acpi_handle source;
 	acpi_handle target;
@@ -43,6 +53,32 @@ struct trt {
 	u64 reserved4;
 } __packed;
 
+#define ACPI_NR_PSVT_ELEMENTS	12
+#define ACPI_PSVT_CONTROL_KNOB	7
+#define ACPI_LIMIT_STR_MAX_LEN	8
+
+struct psvt {
+	acpi_handle source;
+	acpi_handle target;
+	u64 priority;
+	u64 sample_period;
+	u64 passive_temp;
+	u64 source_domain;
+	u64 control_knob;
+	union {
+		/* For limit_type = ACPI_TYPE_INTEGER */
+		u64 integer;
+		/* For limit_type = ACPI_TYPE_STRING */
+		char string[ACPI_LIMIT_STR_MAX_LEN];
+		char *str_ptr;
+	} limit;
+	u64 step_size;
+	u64 limit_coeff;
+	u64 unlimit_coeff;
+	/* Spec calls this field reserved, so we borrow it for type info */
+	u64 control_knob_type; /* ACPI_TYPE_STRING or ACPI_TYPE_INTEGER */
+} __packed;
+
 #define ACPI_NR_ART_ELEMENTS 13
 /* for usrspace */
 union art_object {
@@ -77,6 +113,27 @@ union trt_object {
 	u64 __data[8];
 };
 
+union psvt_object {
+	struct {
+		char source_device[8];
+		char target_device[8];
+		u64 priority;
+		u64 sample_period;
+		u64 passive_temp;
+		u64 source_domain;
+		u64 control_knob;
+		union {
+			u64 integer;
+			char string[ACPI_LIMIT_STR_MAX_LEN];
+		} limit;
+		u64 step_size;
+		u64 limit_coeff;
+		u64 unlimit_coeff;
+		u64 control_knob_type;
+	};
+	u64 __data[ACPI_NR_PSVT_ELEMENTS];
+};
+
 #ifdef __KERNEL__
 int acpi_thermal_rel_misc_device_add(acpi_handle handle);
 int acpi_thermal_rel_misc_device_remove(acpi_handle handle);
-- 
2.34.1

