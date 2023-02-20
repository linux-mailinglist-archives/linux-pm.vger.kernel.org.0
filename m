Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B049B69D146
	for <lists+linux-pm@lfdr.de>; Mon, 20 Feb 2023 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjBTQYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Feb 2023 11:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTQYf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2023 11:24:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA61E9CE
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 08:24:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o14so1660537wms.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Feb 2023 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLUnfNdm2yVAS1wkgyhep1P3VK/E8L4MHqepWzvtV2A=;
        b=HXj+Ml/IOsNGF70NWfV0sWjyRPdtg+qSFDpNq96Cir9HFptYInAcn0q3RP6WJRrw+B
         /vL8Omzi3+v4hHI+wjKJTi+GiYjpWaDiGrbhWPR4RQJpl2uGCKsbpDm3iVTe/52yMvJ2
         wvTCF4sQ23ca3R7LJxZx5QcFiBiZj4rVUMXvhqsLvLUqz/Pir484juQvI42Uo2txdReO
         xouHE8GkaS9vC7T0lHM210oNA2un/im6s57TkF6sPkcE9ymQyQ1sbBuEzAwG3s70oObV
         LjWVWRoJgZ73YUYiWzS4kaodWoxFsZ/RXq1kuHyKv0F2JSEjhfmiHx1KDiIRfraHDzFD
         2d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLUnfNdm2yVAS1wkgyhep1P3VK/E8L4MHqepWzvtV2A=;
        b=splOnXk7vffo9dseiYPEHLrzW4J3huCxdxAn3B4F9Jn8mDO5jM/IZ+0xUhsNvE0iMz
         UvlrMbvVhByWA1foE+NNXy4XCKXaHdE1MZQrPskSb0FEqDDnDN9Rta/JdJbXZ/OCpeNb
         N9YXkxTM5T6qySyetyXaPSLIWFs8Lhm/9044xxnxCKIHoP0AKDi58DY0H6F5/vkRKxmn
         l4ZQ4WGzyndrMaEw0jROBCdDxbHL0CoZH+hb9LPO8C8CnZ33k45nBPvoN4owuxnAWg3b
         l4WVNq0MAurMmPMHE6xYNxAfAhhh5skvuJT/hxHnQOgAl3/qdsdVGAivgO84vAHoyTmd
         ufBg==
X-Gm-Message-State: AO0yUKXzBA8NdrzS3yrro0BAg8ol6ySbjHy1bIjeosqX4z5AtbJWFSpi
        4OInE85Wo+9IhI+3doaVT1vTZA==
X-Google-Smtp-Source: AK7set80kti+P68q37zOf6HqC7R55YpEo8WsMlPbL2NUZgrVJwnhPKkelSrV32R3Pe4yUuV5QO7fyQ==
X-Received: by 2002:a05:600c:1c9c:b0:3df:fc69:e96b with SMTP id k28-20020a05600c1c9c00b003dffc69e96bmr1017185wms.5.1676910271790;
        Mon, 20 Feb 2023 08:24:31 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8d87:e6b4:7d0f:3fdb])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c348600b003df5be8987esm10136587wmq.20.2023.02.20.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:24:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     Sujith Thomas <sujith.thomas@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:INTEL MENLOW THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC] thermal/drivers/intel_menlow: Remove add_one_attribute
Date:   Mon, 20 Feb 2023 17:24:19 +0100
Message-Id: <20230220162419.1276952-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver hooks the thermal framework sysfs to add some driver
specific information. A debatable approach as that may belong the
device sysfs directory, not the thermal zone directory.

As the driver is accessing the thermal internals, we should provide at
least an API to the thermal framework to add an attribute to the
existing sysfs thermal zone entry.

Before doing that and given the age of the driver (2008) may be it is
worth to double check if these attributes are really needed. So my
first proposal is to remove them if that does not hurt.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_menlow.c | 193 ---------------------------
 1 file changed, 193 deletions(-)

diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index 5a6ad0552311..5a9738a93083 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -230,174 +230,8 @@ struct intel_menlow_attribute {
 static LIST_HEAD(intel_menlow_attr_list);
 static DEFINE_MUTEX(intel_menlow_attr_lock);
 
-/*
- * sensor_get_auxtrip - get the current auxtrip value from sensor
- * @handle: Object handle
- * @index : GET_AUX1/GET_AUX0
- * @value : The address will be fill by the value
- */
-static int sensor_get_auxtrip(acpi_handle handle, int index,
-							unsigned long long *value)
-{
-	acpi_status status;
-
-	if ((index != 0 && index != 1) || !value)
-		return -EINVAL;
-
-	status = acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
-				       NULL, value);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	return 0;
-}
-
-/*
- * sensor_set_auxtrip - set the new auxtrip value to sensor
- * @handle: Object handle
- * @index : GET_AUX1/GET_AUX0
- * @value : The value will be set
- */
-static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
-{
-	acpi_status status;
-	union acpi_object arg = {
-		ACPI_TYPE_INTEGER
-	};
-	struct acpi_object_list args = {
-		1, &arg
-	};
-	unsigned long long temp;
-
-	if (index != 0 && index != 1)
-		return -EINVAL;
-
-	status = acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
-				       NULL, &temp);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-	if ((index && value < temp) || (!index && value > temp))
-		return -EINVAL;
-
-	arg.integer.value = value;
-	status = acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
-				       &args, &temp);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	/* do we need to check the return value of SAX0/SAX1 ? */
-
-	return 0;
-}
-
-#define to_intel_menlow_attr(_attr)	\
-	container_of(_attr, struct intel_menlow_attribute, attr)
-
-static ssize_t aux_show(struct device *dev, struct device_attribute *dev_attr,
-			char *buf, int idx)
-{
-	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	unsigned long long value;
-	int result;
-
-	result = sensor_get_auxtrip(attr->handle, idx, &value);
-	if (result)
-		return result;
-
-	return sprintf(buf, "%lu", deci_kelvin_to_celsius(value));
-}
-
-static ssize_t aux0_show(struct device *dev,
-			 struct device_attribute *dev_attr, char *buf)
-{
-	return aux_show(dev, dev_attr, buf, 0);
-}
-
-static ssize_t aux1_show(struct device *dev,
-			 struct device_attribute *dev_attr, char *buf)
-{
-	return aux_show(dev, dev_attr, buf, 1);
-}
-
-static ssize_t aux_store(struct device *dev, struct device_attribute *dev_attr,
-			 const char *buf, size_t count, int idx)
-{
-	struct intel_menlow_attribute *attr = to_intel_menlow_attr(dev_attr);
-	int value;
-	int result;
-
-	/*Sanity check; should be a positive integer */
-	if (!sscanf(buf, "%d", &value))
-		return -EINVAL;
-
-	if (value < 0)
-		return -EINVAL;
-
-	result = sensor_set_auxtrip(attr->handle, idx,
-				    celsius_to_deci_kelvin(value));
-	return result ? result : count;
-}
-
-static ssize_t aux0_store(struct device *dev,
-			  struct device_attribute *dev_attr,
-			  const char *buf, size_t count)
-{
-	return aux_store(dev, dev_attr, buf, count, 0);
-}
-
-static ssize_t aux1_store(struct device *dev,
-			  struct device_attribute *dev_attr,
-			  const char *buf, size_t count)
-{
-	return aux_store(dev, dev_attr, buf, count, 1);
-}
-
 /* BIOS can enable/disable the thermal user application in dabney platform */
 #define BIOS_ENABLED "\\_TZ.GSTS"
-static ssize_t bios_enabled_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	acpi_status status;
-	unsigned long long bios_enabled;
-
-	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enabled);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
-}
-
-static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
-					  void *store, struct device *dev,
-					  acpi_handle handle)
-{
-	struct intel_menlow_attribute *attr;
-	int result;
-
-	attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
-	if (!attr)
-		return -ENOMEM;
-
-	sysfs_attr_init(&attr->attr.attr); /* That is consistent naming :D */
-	attr->attr.attr.name = name;
-	attr->attr.attr.mode = mode;
-	attr->attr.show = show;
-	attr->attr.store = store;
-	attr->device = dev;
-	attr->handle = handle;
-
-	result = device_create_file(dev, &attr->attr);
-	if (result) {
-		kfree(attr);
-		return result;
-	}
-
-	mutex_lock(&intel_menlow_attr_lock);
-	list_add_tail(&attr->node, &intel_menlow_attr_list);
-	mutex_unlock(&intel_menlow_attr_lock);
-
-	return 0;
-}
 
 static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 						void *context, void **rv)
@@ -420,12 +254,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 	if (ACPI_FAILURE(status))
 		return (status == AE_NOT_FOUND) ? AE_OK : status;
 
-	result = intel_menlow_add_one_attribute("aux0", 0644,
-						aux0_show, aux0_store,
-						&thermal->device, handle);
-	if (result)
-		return AE_ERROR;
-
 	status = acpi_get_handle(handle, GET_AUX1, &dummy);
 	if (ACPI_FAILURE(status))
 		goto aux1_not_found;
@@ -434,27 +262,6 @@ static acpi_status intel_menlow_register_sensor(acpi_handle handle, u32 lvl,
 	if (ACPI_FAILURE(status))
 		goto aux1_not_found;
 
-	result = intel_menlow_add_one_attribute("aux1", 0644,
-						aux1_show, aux1_store,
-						&thermal->device, handle);
-	if (result) {
-		intel_menlow_unregister_sensor();
-		return AE_ERROR;
-	}
-
-	/*
-	 * create the "dabney_enabled" attribute which means the user app
-	 * should be loaded or not
-	 */
-
-	result = intel_menlow_add_one_attribute("bios_enabled", 0444,
-						bios_enabled_show, NULL,
-						&thermal->device, handle);
-	if (result) {
-		intel_menlow_unregister_sensor();
-		return AE_ERROR;
-	}
-
 	return AE_OK;
 
  aux1_not_found:
-- 
2.34.1

