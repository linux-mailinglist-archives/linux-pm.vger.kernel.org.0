Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5B1A6DC2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbgDMVG4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 17:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbgDMVGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 17:06:54 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6213C0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 14:06:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s19so262742pgq.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 14:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5YCqTBP5K2PN6mZ2OCe5wiMOpXtvJ48+Gdsr/3Jn0Y4=;
        b=JDqXIxNwPCmICqv0wsuTvKAuqwhtovNaeTjajcd30ZRMx/M9NpuVnxKu4l+BwyJDMD
         Sxm4gDM9xuRaZKHPNzBySB5qlkU14KnEFhsxi1guJOTQiW4rNQNlUGcUxVeD4vp47F9K
         sf/7tpiD8xdiaKLqSlWfpx9uGUYm8RGK0ce+STF2c6RBel6PUTZNgpoQogr7w6SIjKq4
         kiEDnusnR222jGjGgtebAUXGPvpMkwuYB/vQs/8jKgjRxu6amt5pcQDD4VVHJGs6bpuJ
         a+AHtUJFjlB8hF0xPUMIPWBmOtSQojCY9CQhmFnaC68M995iBKq/orVOeDbCHoLoN/e+
         2o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5YCqTBP5K2PN6mZ2OCe5wiMOpXtvJ48+Gdsr/3Jn0Y4=;
        b=Hwb9oTrbs906/z62yy80eh7v9+r4YU9K9CCyvVf/ZiBQt+MrdJ836JbDMIFGWjSGVL
         WhjczsZ5RX+MfWq8OHb2qxTX9K+DcB3pFegtjD6RoVWh8GMCabjrjRL1/2zTlBQyXyjL
         tbpX/qWHMPQSMFRX8RoOBLSOIZ5gXg9ZQ2Rgm5x1Ue7z2c/GHA1JTklD3AcIlOVXWfEy
         Ytr8AboAOFgcSQgdPAUcRI+GDjiMeVSETJsBlnVlLmqORRmelU8dJQhWxt1UyHl7C3SP
         G5FAlDk9GoC6DYtvdmD6SJ1sKFOLqHfQkCVH1gT0pboVMEdntQHLcki+0rdG4Mx57ETo
         BynQ==
X-Gm-Message-State: AGi0PuYTV3sl0ToC61nwvRrIxKHjnzneYPmBShhgYSUFvZ97aQuTuczQ
        2DDJAxkhVikkReSfzl+fwl4m65Nu5EGqzPjji49Ikw==
X-Google-Smtp-Source: APiQypJNdv10Jq0jwXqhoBKSFdxmVPBJJ1Mo0D3jceJ/qxk7LWisMRsbF5yd6lUE+pJTLP+/CKvM0QKbtZnNoyqxtMx6pQ==
X-Received: by 2002:a17:90a:2170:: with SMTP id a103mr24300989pje.181.1586812014151;
 Mon, 13 Apr 2020 14:06:54 -0700 (PDT)
Date:   Mon, 13 Apr 2020 14:06:43 -0700
In-Reply-To: <20200413210644.201801-1-matthewgarrett@google.com>
Message-Id: <20200413210644.201801-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20200413210644.201801-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 2/3] thermal/int340x_thermal: Export OEM vendor variables
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

The platform vendor may expose an array of OEM-specific values to be used
in determining DPTF policy. These are obtained via the ODVP method, and
then simply exposed in sysfs. In addition, they are updated when a
notification is received or when the DPTF policy is changed by userland.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 132 +++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 00a7732724cd0..f36e3e9d246ea 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -13,6 +13,7 @@
 #include "acpi_thermal_rel.h"
 
 #define INT3400_THERMAL_TABLE_CHANGED 0x83
+#define INT3400_ODVP_CHANGED 0x88
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
@@ -41,8 +42,11 @@ static char *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
 	"BE84BABF-C4D4-403D-B495-3128FD44dAC1",
 };
 
+struct odvp_attr;
+
 struct int3400_thermal_priv {
 	struct acpi_device *adev;
+	struct platform_device *pdev;
 	struct thermal_zone_device *thermal;
 	int mode;
 	int art_count;
@@ -53,6 +57,17 @@ struct int3400_thermal_priv {
 	int rel_misc_dev_res;
 	int current_uuid_index;
 	char *data_vault;
+	int odvp_count;
+	int *odvp;
+	struct odvp_attr *odvp_attrs;
+};
+
+static int evaluate_odvp(struct int3400_thermal_priv *priv);
+
+struct odvp_attr {
+	int odvp;
+	struct int3400_thermal_priv *priv;
+	struct kobj_attribute attr;
 };
 
 static ssize_t data_vault_read(struct file *file, struct kobject *kobj,
@@ -210,9 +225,110 @@ static int int3400_thermal_run_osc(acpi_handle handle,
 		result = -EPERM;
 
 	kfree(context.ret.pointer);
+
 	return result;
 }
 
+static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	struct odvp_attr *odvp_attr;
+
+	odvp_attr = container_of(attr, struct odvp_attr, attr);
+
+	return sprintf(buf, "%d\n", odvp_attr->priv->odvp[odvp_attr->odvp]);
+}
+
+static void cleanup_odvp(struct int3400_thermal_priv *priv)
+{
+	int i;
+
+	if (priv->odvp_attrs) {
+		for (i = 0; i < priv->odvp_count; i++) {
+			sysfs_remove_file(&priv->pdev->dev.kobj,
+					  &priv->odvp_attrs[i].attr.attr);
+			kfree(priv->odvp_attrs[i].attr.attr.name);
+		}
+		kfree(priv->odvp_attrs);
+	}
+	kfree(priv->odvp);
+	priv->odvp_count = 0;
+}
+
+static int evaluate_odvp(struct int3400_thermal_priv *priv)
+{
+	struct acpi_buffer odvp = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj = NULL;
+	acpi_status status;
+	int i, ret;
+
+	status = acpi_evaluate_object(priv->adev->handle, "ODVP", NULL, &odvp);
+	if (ACPI_FAILURE(status)) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	obj = odvp.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	if (priv->odvp == NULL) {
+		priv->odvp_count = obj->package.count;
+		priv->odvp = kmalloc_array(priv->odvp_count, sizeof(int),
+				     GFP_KERNEL);
+		if (!priv->odvp) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
+	}
+
+	if (priv->odvp_attrs == NULL) {
+		priv->odvp_attrs = kcalloc(priv->odvp_count,
+					   sizeof(struct odvp_attr),
+					   GFP_KERNEL);
+		if (!priv->odvp_attrs) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		for (i = 0; i < priv->odvp_count; i++) {
+			struct odvp_attr *odvp = &priv->odvp_attrs[i];
+
+			sysfs_attr_init(attr->attr);
+			odvp->priv = priv;
+			odvp->odvp = i;
+			odvp->attr.attr.name = kasprintf(GFP_KERNEL,
+							 "odvp%d", i);
+
+			if (!odvp->attr.attr.name) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
+			odvp->attr.attr.mode = 0444;
+			odvp->attr.show = odvp_show;
+			odvp->attr.store = NULL;
+			ret = sysfs_create_file(&priv->pdev->dev.kobj,
+						&odvp->attr.attr);
+			if (ret)
+				goto out_err;
+		}
+	}
+
+	for (i = 0; i < obj->package.count; i++) {
+		if (obj->package.elements[i].type == ACPI_TYPE_INTEGER)
+			priv->odvp[i] = obj->package.elements[i].integer.value;
+	}
+
+	kfree(obj);
+	return 0;
+
+out_err:
+	cleanup_odvp(priv);
+	kfree(obj);
+	return ret;
+}
+
 static void int3400_notify(acpi_handle handle,
 			u32 event,
 			void *data)
@@ -236,6 +352,9 @@ static void int3400_notify(acpi_handle handle,
 		kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE,
 				thermal_prop);
 		break;
+	case INT3400_ODVP_CHANGED:
+		evaluate_odvp(priv);
+		break;
 	default:
 		/* Ignore unknown notification codes sent to INT3400 device */
 		break;
@@ -285,6 +404,9 @@ static int int3400_thermal_set_mode(struct thermal_zone_device *thermal,
 						 priv->current_uuid_index,
 						 enable);
 	}
+
+	evaluate_odvp(priv);
+
 	return result;
 }
 
@@ -336,6 +458,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->pdev = pdev;
 	priv->adev = adev;
 
 	result = int3400_thermal_get_uuids(priv);
@@ -356,6 +479,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	int3400_setup_gddv(priv);
 
+	evaluate_odvp(priv);
+
 	int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
 	int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
 
@@ -390,8 +515,11 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 free_sysfs:
-	if (priv->data_vault)
+	cleanup_odvp(priv);
+	if (priv->data_vault) {
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+		kfree(priv->data_vault);
+	}
 free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 free_rel_misc:
@@ -414,6 +542,8 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 			priv->adev->handle, ACPI_DEVICE_NOTIFY,
 			int3400_notify);
 
+	cleanup_odvp(priv);
+
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
-- 
2.26.0.110.g2183baf09c-goog

