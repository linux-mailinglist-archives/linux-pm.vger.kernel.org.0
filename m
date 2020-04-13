Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B855D1A6DC0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 23:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbgDMVGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388723AbgDMVGw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 17:06:52 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3F7C0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 14:06:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id d11so11292858pjh.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IV0jCGjY4W6KdLiLfKem198qqlhSCntJsgHYVO+E6jU=;
        b=FNC5deBelKjQu9FQsxeDOLK8dE9RzOssihuoDJkcERxLh1LBzR9As37XDqlykamblH
         H6sOT/wtr0SQv9/3+IXDT1GHWnoT8ecRaYNvy//giJCXMGeGJ3wd/7Ya/Eq3ppTD1a2u
         f8iT3ZcSVqBTzNOvszdjAIWlt1GukNnhAZdmCbEevZXhG6s7079smKzUzbX90zSv8gY0
         e7iwZNYwqtAPweHkrfy9hVFLEl5xw4Pjklvq9cgZrAJMoyr8JDFXl+txh8YK22uDEaXE
         1/3oxX/THgt0KyBGSXepiXq+nLDgl8LqoQ0tTPoUh87+rgezNp/GZkhbggIfvZsNhVKO
         u5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IV0jCGjY4W6KdLiLfKem198qqlhSCntJsgHYVO+E6jU=;
        b=Hu34RaHFuoNSJ3LIGaCG1llWkGBOBcf1OdK0JPo98b08OPKPkUBekKw6ZfaUL/dETd
         weqLh/XPAQTbyP8i0qhX3cD33PYrqjLhvIrg5ltBbHtUzqq8X0jcoai5jNZPdYDmAzPz
         4epUH3AOIbeohmTnxHOcoAGmi4C9AX799CjWc4o3i8JfgrNY32ei1eCpHh6cWqv7B6Ie
         gu0wP62lH77anQPeBimTzBHGG9evxjDKMLB8LuhzhOLJgk3jLPKZfE1l/6s0gA2W9B4n
         gyajCjtBn6mQeWNDgFFfErq2EoHFDUf8p73TBi1m6xN8+cn6bdOg8TD7NbTLZzOArghR
         nkaQ==
X-Gm-Message-State: AGi0Pua5nPhCroL2wLrQ5z2OhaGn1Rfs1aIwgink9p36rUSsi7sOH+Lj
        1V/tGws6uquAqA2oQgXHj+dsXCDVLxtKTRUQRzMfqA==
X-Google-Smtp-Source: APiQypIJh3M/I5cOHqVYEHsnkdDtigtwOiciiePxgVDuJ8OG5dy1ncDxT6Fx/Pgv+rzuviXoXgvVVwmVfpKywghiEC6XQg==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr23517001pjs.156.1586812011717;
 Mon, 13 Apr 2020 14:06:51 -0700 (PDT)
Date:   Mon, 13 Apr 2020 14:06:42 -0700
Message-Id: <20200413210644.201801-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 1/3] thermal/int340x_thermal: Export GDDV
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

