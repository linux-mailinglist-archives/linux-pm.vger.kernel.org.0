Return-Path: <linux-pm+bounces-17096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8C9BFD04
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 04:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD7A1C21D7A
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1D185B73;
	Thu,  7 Nov 2024 03:37:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72416426;
	Thu,  7 Nov 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950652; cv=none; b=ddozZJgyS02cu/eLPdSVHXG3heGFyoKwFUSHN20RQUGfWpg/twZiYj5u77B5rDcSUjjeRP090+0BbDnq3UcdYj76c/Wyf40ivJpXYGFRvxDer3qvbZR7fFnC/9YSt/IX9DfqVg+g0HFNEW1Grd6HGGWckEf3RCfW6ZQMVvKJJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950652; c=relaxed/simple;
	bh=IDtzZOHG5JBqnfrcxS2T7mLOiushLLE+N5GaCFCFo+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAtVvV2kWHvTrSACBz/RzPsn1ciLPnJsm4eQxZoSfG/Tvxe6oc3eJfwiasPQthxiz6UxEREqu9czfKQELgAUjWpHELVnGFP+cJjcILRyi6NAOyBm74IoPIS/n6f8xDdrkhtT0Dj027Q5MlgriLKqe3HPTWd6P49x4tRfDQlxuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XkSQD20HszpXwb;
	Thu,  7 Nov 2024 11:35:32 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 49AA21401F3;
	Thu,  7 Nov 2024 11:37:26 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 11:37:26 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 11:37:25 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-pm@vger.kernel.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 1/2] ACPI: thermal: Support for linking devices associated with the thermal zone
Date: Thu, 7 Nov 2024 11:26:25 +0800
Message-ID: <20241107032626.16682-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20241107032626.16682-1-lihuisong@huawei.com>
References: <20241107032626.16682-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)

As ACPI spec said, '_TZD' evaluates to a package of device names.
Each name corresponds to a device in the ACPI namespace that is
associated with the thermal zone. The temperature reported by the
thermal zone is roughly correspondent to that of each of the devices.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/thermal.c | 114 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 78db38c7076e..398195a5d42f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -119,6 +119,9 @@ struct acpi_thermal {
 	struct work_struct thermal_check_work;
 	struct mutex thermal_check_lock;
 	refcount_t thermal_check_count;
+	int num_domain_devices;
+	struct acpi_device **domain_devices;
+	struct kobject *holders_dir;
 };
 
 /* --------------------------------------------------------------------------
@@ -589,6 +592,103 @@ static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.critical = acpi_thermal_zone_device_critical,
 };
 
+static void acpi_thermal_remove_domain_devices(struct acpi_thermal *tz)
+{
+	int i;
+
+	if (!tz->num_domain_devices)
+		return;
+
+	for (i = 0; i < tz->num_domain_devices; i++) {
+		struct acpi_device *obj = tz->domain_devices[i];
+
+		if (!obj)
+			continue;
+
+		sysfs_remove_link(tz->holders_dir,
+				  kobject_name(&obj->dev.kobj));
+		acpi_dev_put(obj);
+	}
+
+	kfree(tz->domain_devices);
+	kobject_put(tz->holders_dir);
+	tz->num_domain_devices = 0;
+}
+
+static int acpi_thermal_read_domain_devices(struct acpi_thermal *tz)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *pss;
+	acpi_status status;
+	int ret = 0;
+	int i;
+
+	status = acpi_evaluate_object(tz->device->handle, "_TZD", NULL,
+				      &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_evaluation_failure_warn(tz->device->handle, "_TZD",
+					     status);
+		return -ENODEV;
+	}
+
+	pss = buffer.pointer;
+	if (!pss ||
+	    pss->type != ACPI_TYPE_PACKAGE) {
+		dev_err(&tz->device->dev, "Thermal zone invalid _TZD data\n");
+		ret = -EFAULT;
+		goto end;
+	}
+
+	if (!pss->package.count)
+		goto end;
+
+	tz->domain_devices = kcalloc(pss->package.count,
+				     sizeof(struct acpi_device *), GFP_KERNEL);
+	if (!tz->domain_devices) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	tz->holders_dir = kobject_create_and_add("measures",
+						 &tz->device->dev.kobj);
+	if (!tz->holders_dir) {
+		ret = -ENOMEM;
+		goto exit_free;
+	}
+
+	tz->num_domain_devices = pss->package.count;
+	for (i = 0; i < pss->package.count; i++) {
+		struct acpi_device *obj;
+		union acpi_object *element = &pss->package.elements[i];
+
+		/* Refuse non-references */
+		if (element->type != ACPI_TYPE_LOCAL_REFERENCE)
+			continue;
+
+		/* Create a symlink to domain objects */
+		obj = acpi_get_acpi_dev(element->reference.handle);
+		tz->domain_devices[i] = obj;
+		if (!obj)
+			continue;
+
+		ret = sysfs_create_link(tz->holders_dir, &obj->dev.kobj,
+					kobject_name(&obj->dev.kobj));
+		if (ret) {
+			acpi_dev_put(obj);
+			tz->domain_devices[i] = NULL;
+		}
+	}
+
+	ret = 0;
+	goto end;
+
+exit_free:
+	kfree(tz->domain_devices);
+end:
+	kfree(buffer.pointer);
+	return ret;
+}
+
 static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
 {
 	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
@@ -602,8 +702,19 @@ static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
 	ret = sysfs_create_link(&tzdev->kobj,
 				   &tz->device->dev.kobj, "device");
 	if (ret)
-		sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+		goto remove_thermal_zone;
 
+	/* _TZD method is optional. */
+	ret = acpi_thermal_read_domain_devices(tz);
+	if (ret != -ENODEV)
+		goto remove_device;
+
+	return 0;
+
+remove_device:
+	sysfs_remove_link(&tz->device->dev.kobj, "device");
+remove_thermal_zone:
+	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 	return ret;
 }
 
@@ -611,6 +722,7 @@ static void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
 {
 	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
 
+	acpi_thermal_remove_domain_devices(tz);
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 	sysfs_remove_link(&tzdev->kobj, "device");
 }
-- 
2.22.0


