Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB11A70D1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403954AbgDNCKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 22:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgDNCJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 22:09:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D0C0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 19:09:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l9so11688681pjq.8
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 19:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IV0jCGjY4W6KdLiLfKem198qqlhSCntJsgHYVO+E6jU=;
        b=TxNzwdteXcO+NRa9KnMotSGqrmb+EL1atf38W0J3wvYcY7GgEB5sus+/a9qg1s9Udb
         +8m7LQ5nGne+dQgSixQv7noFYCtyk/x8RxwatcAz+RA6zLOijOQLMGrsBuJ5wBl3hjYq
         UdTmGWDeU6Ec99alAJY2Xv6tnXUFjkIy1N+hRnUUNu33i8l7qzig95xa9ZwX5eVxN/nT
         ulQd1Swx6NMcnk/IgRlsxpazPUfDTYva+S01mPs3/MYPif2JSsqmkdzIQCviUfBnqeE2
         vIUM2F72DrOZJWRvc9UZpnA0w3ecNieqF/WCq5CqivbDz9PKkvTahpctWYh8DrlKQc6W
         exzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IV0jCGjY4W6KdLiLfKem198qqlhSCntJsgHYVO+E6jU=;
        b=NlRpJmjI7b4RjZVTfErsLTHDODAkcxM67Odx/shRGXMQ4n/l5LueI133n0w38WRZ3d
         r3Tco5ktsyC0NLsAovj0YtUkVdA5isQegKm6+cenBrxvrRFvqLSnF7Q0Sq/8/6RbNEnh
         2c4xGu7Y/7r8YRKQCg+YV9cXLrrmIsQ4wPn7CM43CUVwaGa7hcqWLMwE78PBn4DuVayV
         98WRWDnkvq1ZfG4X/McNBQZkKv45CHjCGNwC/HkhED+6EDCTV2+L2nVwiiY90iOUeYXK
         5FNF6oz3ce6zm7BJQdmERdezRJlefOzfUWxHR8i4dLwW8xizowYi0MApNpbyw7duTgb3
         5ctA==
X-Gm-Message-State: AGi0PubkVjtY8Mr43MLreVqrltDCZuKizyNvM08rcApCTHPxlZcSVNhE
        LMjGT6+ec77ivfsAFwo2xl6bZzMVx6SYPfxOJgzzGw==
X-Google-Smtp-Source: APiQypLZxejCoedLS04Fm/dwUgsisYLaXmBRSDsYUFCAZ5QZm+9qNaLFSxtw39HBkcqQkBLTbco0bJaIviWsMUgyTBNfsw==
X-Received: by 2002:a17:90a:3707:: with SMTP id u7mr24168900pjb.182.1586830199089;
 Mon, 13 Apr 2020 19:09:59 -0700 (PDT)
Date:   Mon, 13 Apr 2020 19:09:51 -0700
Message-Id: <20200414020953.255364-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com,
        nisha.aram@intel.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

Implementing DPTF properly requires making use of firmware-provided
information associated with the INT3400 device. Calling GDDV provides a
buffer of information which userland can then interpret to determine
appropriate DPTF policy.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index ceef89c956bd4..00a7732724cd0 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -52,6 +52,25 @@ struct int3400_thermal_priv {
 	u8 uuid_bitmap;
 	int rel_misc_dev_res;
 	int current_uuid_index;
+	char *data_vault;
+};
+
+static ssize_t data_vault_read(struct file *file, struct kobject *kobj,
+	     struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	memcpy(buf, attr->private + off, count);
+	return count;
+}
+
+static BIN_ATTR_RO(data_vault, 0);
+
+static struct bin_attribute *data_attributes[] = {
+	&bin_attr_data_vault,
+	NULL,
+};
+
+static const struct attribute_group data_attribute_group = {
+	.bin_attrs = data_attributes,
 };
 
 static ssize_t available_uuids_show(struct device *dev,
@@ -278,6 +297,32 @@ static struct thermal_zone_params int3400_thermal_params = {
 	.no_hwmon = true,
 };
 
+static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = acpi_evaluate_object(priv->adev->handle, "GDDV", NULL,
+				      &buffer);
+	if (ACPI_FAILURE(status) || !buffer.length)
+		return;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 1
+	    || obj->package.elements[0].type != ACPI_TYPE_BUFFER) {
+		kfree(buffer.pointer);
+		return;
+	}
+
+	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
+				   obj->package.elements[0].buffer.length,
+				   GFP_KERNEL);
+	bin_attr_data_vault.private = priv->data_vault;
+	bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
+	kfree(buffer.pointer);
+}
+
 static int int3400_thermal_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
@@ -309,6 +354,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	int3400_setup_gddv(priv);
+
 	int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
 	int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
 
@@ -327,6 +374,13 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_rel_misc;
 
+	if (priv->data_vault) {
+		result = sysfs_create_group(&pdev->dev.kobj,
+					    &data_attribute_group);
+		if (result)
+			goto free_uuid;
+	}
+
 	result = acpi_install_notify_handler(
 			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
 			(void *)priv);
@@ -336,6 +390,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 free_sysfs:
+	if (priv->data_vault)
+		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 free_rel_misc:
 	if (!priv->rel_misc_dev_res)
@@ -360,8 +417,11 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
+	if (priv->data_vault)
+		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	thermal_zone_device_unregister(priv->thermal);
+	kfree(priv->data_vault);
 	kfree(priv->trts);
 	kfree(priv->arts);
 	kfree(priv);
-- 
2.26.0.110.g2183baf09c-goog

