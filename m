Return-Path: <linux-pm+bounces-38932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E454CC95357
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5F554E147E
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1C2C0297;
	Sun, 30 Nov 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbR+JrrF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gccRMDBs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E392C1590
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764526898; cv=none; b=q4bTUmT519nwCRGB81GCfp3skqRYFavOmBGQbdb0U3nrzsYIdAXo+jIl01GrUBgeOHPSeK6le7MMXa/6KFB6QemMJsjNzC7MxMVGayqotGCH/AdZfg85CVADXXWt+aDQ+KMUzxV+Ko3jn07NlRu0s/v3Kgajf8dyPmJqJ1bJHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764526898; c=relaxed/simple;
	bh=GjHr08OI8SMYl4NydKrelbyGCFRyP6KQP0VnxDcuQW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZL8b+ovWp0fPTVK1KpSJQLKHs8YwEX+upCP683voZtfx94ZB7zMINYRPke9QEM4e0nfa98xcNcQ6voCW4qdI3xrLPIxd9ypRyw6Bxk8RGA7dIVy87pdv/8UoO1KkNX3zm7xQH3egUZnCe2KqUWO2jW6ZxtSXnfnM+A4sEorwp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lbR+JrrF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gccRMDBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AUHtkKc2705273
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 18:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZF4ZAclZV2cEPBSJQt65Ys2E158j2iEit5MIaKN8fmA=; b=lbR+JrrFJ2C2+dG7
	WQvTKorbLUsmZF01ipykQEboy8x4ta3KiSLZFJGnVUHmO7xadzCcec52i0kG40Do
	8wHs/0d04GDCVvwSjR41Ydn8DNn88wGdxpDEmUavXoSSPuCBF9YQlunb0UeC3xpk
	kmF3RNetHqJAtpw9ykhADclUjtIbyjErBBUnWHB9PJnYxygLyqJkc+nWM5Ci5/7G
	xE5ZPm4fbW9tQH4nqcwvJH0/WfIaa8RD0eQgjZbadirAx4VCGz4nZkJFubPbGceV
	Imn0GdTxmQe/iLLObfkYFh15oTmbza0mz9BCH5OI2VdEU1f/2PGdtYlyElal7B9n
	xl2gHA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqqu62p92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 18:21:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297fbfb4e53so49776845ad.1
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 10:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764526894; x=1765131694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZF4ZAclZV2cEPBSJQt65Ys2E158j2iEit5MIaKN8fmA=;
        b=gccRMDBsq+oGUl04IrDQMR3Y8nFRN1kkMvaHWF3dBqhQ57ho8YQ9QsI3uv/BRM4IGs
         IuWvxP0Sv61SuKfhin0/ULoUAPmbtNyriQfwP3e5MjWg+A8xoE1RnSNmnUsR+RZPUceW
         OfazlrOxV8KJkXWJqwXu8Qs4C7Y+saEw7hv7W8ZEH+o5P2YXE98txMg+aw4v0CZFPITZ
         t+gnM0OKqVLu1s2Hl12CUF8e/fqCJMmqvlmcWJJnQ7Kn1vhGMWATf+mmPR9MkDPd3bIJ
         hJD8LMoPBvgJz7uD6moJn6VBupNuwtKeR1ICEC11rrLatZ4St7vJTw1KZEwLPS2fzMtO
         qOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764526894; x=1765131694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZF4ZAclZV2cEPBSJQt65Ys2E158j2iEit5MIaKN8fmA=;
        b=FPd7T3DO1tt6m+4RaEoe8BQxCjkteAKDNTNkeevwaDmQdWlMQDNSKjXJcNbEc7dI3t
         vKM1uGp11/wTa6yYMWpJJhmxPYmMrxuGxm2Uh3tLPyeHMFwOCcEjQVvRm7JMFCAqTWfM
         htw/lhF7stLm+rfmrJQB1OPsUYnUNiLPyDomrE4+kOMaa7oIi5z2F39M7jlcBT2i5wqP
         0Zoh5ZslY04LntmPZUwQ/p9ndpg/VQCdWG+pmb9y+UD7WnrfwM+IwVvuGbc5J29QXIgp
         uK4xJMchkXIe/QKDUfOjWwQrc1NetXT+kzUEBaIY2dpSl3LZtH/siv+AEWodF7eczLQc
         zjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIKJ1iBU01kqwJCrrdHiON7ZfaH4T5BMdQIDnKmY2KyHZ6IzK+g6X4e0MRrgSa1Z7c9D+5/oCe+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrePAT0L1nM1tKXZy/E58xr88ToM8gBJCi9536ybFQTMx4NNl
	NMLQPGigDxv1HFIqKUFTsam9zkv0qq61MIqAO57RThRFVaQ0LpfNCfpO8Hh4uu51ZcP5zuWxxtv
	LSydaWjLkbAgFGeKz6VlXXETGHLwv6LvegUeIdI1Wm31HaoNGbJ3j8/m0nfRc0Q==
X-Gm-Gg: ASbGncuLGl2PbLBeLkEC3TXYIzEw0RnYex26vfNUUxz3+kCD/gNVy4RLKbjdiRUtnuN
	BBhkg2YEgjlWleAR4amEtNZnDVZ6O8O7SNQOAqs76HU8nhgLFZkFW0IceIYzaA0+WUde79T7ebw
	U7/qDWKNtedYBf5jKNlc+uNiPZ2XB0ptAfGdUzM6IUD3tqlLQzrrph17/9l7jUh+3FgaiVZHV1I
	0mQjU46RVCBtV9A32lAla4rkEg+DWwIPtXbLyo5coMSVj5vlQat6Wd7YDvam/xLdRhLIZFJST3x
	RMH85Qpp6s7U9odeqgRVkqUObILJACXCOa7omXqtWqSErAPfc6mAFDTeeti6KK7TCfh1xGTFov9
	Exao6CSbv/C+xrkvhJoXsO7hA45l4Fx+4vy6qD+92btRk3A==
X-Received: by 2002:a17:903:2302:b0:295:5d0b:e119 with SMTP id d9443c01a7336-29baafb3c4amr249119465ad.26.1764526894469;
        Sun, 30 Nov 2025 10:21:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSxjT8vEa4CkjtBA3yxMMRy3T6tN07pxv0m/44ola8jHlqpFYU7nsBHcjtQ6mtEUZVvhJkUQ==
X-Received: by 2002:a17:903:2302:b0:295:5d0b:e119 with SMTP id d9443c01a7336-29baafb3c4amr249119305ad.26.1764526894016;
        Sun, 30 Nov 2025 10:21:34 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb27691sm100911385ad.64.2025.11.30.10.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:21:33 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 30 Nov 2025 23:51:24 +0530
Subject: [PATCH v20 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251130-next-15nov_expose_sysfs-v20-2-18c80f8248dd@oss.qualcomm.com>
References: <20251130-next-15nov_expose_sysfs-v20-0-18c80f8248dd@oss.qualcomm.com>
In-Reply-To: <20251130-next-15nov_expose_sysfs-v20-0-18c80f8248dd@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764526885; l=5715;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=GjHr08OI8SMYl4NydKrelbyGCFRyP6KQP0VnxDcuQW8=;
 b=e2/pBNsmYq7oq3yNoHjl3YOTJeCc6SO5NdfK/nIrddZ+G37TD5M7WbEB9DvCB7JBuRMmPbVq8
 R9W3Z0KRwT7BpWV9s16Jx2wTGhXaxCgfQPTB3MgeUdyDpGSDuq6SInN
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: zRYDib6bFAcAMDJPbwwFKyAfDUhaJLiz
X-Authority-Analysis: v=2.4 cv=CM0nnBrD c=1 sm=1 tr=0 ts=692c8b2f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8
 a=239sejjMsMoxT4pUUhgA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: zRYDib6bFAcAMDJPbwwFKyAfDUhaJLiz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTMwMDE1OCBTYWx0ZWRfXygFPAzEhBFh4
 teespB81uO8mhxCvtMuyCrdvHJ2Sj3lr5+HbZAQbNCAXJ46vVGrmkrC+DrLSBTMa3CCoAknYnpv
 Hd0Yt+zVnp7mWwU0PxqaPxaHsLy3PpUQtAK9Sn4Wk7yT8+aMkP4gJuRe7Rmh1QbMeERMK8GLK4S
 QjRu2P/swUDDvZIbPhmyGj/N5ztc/isvFO1S/+ZI6dpoWJ33OTFGH+j9v4ny0Zf0P4AvVQSSLvM
 S0HAHj9pORcQZ/SIf14aqTRnYd5ERrww0TpJcg2cdyswgIa82iMtMkHZ9dGMi7SVglc6j4r6Mxr
 PXmW/v3HvWZ3NBhVZRzwMHYv0mbI9riBb6ADAG3QgThIQztuNOjPYOuzO0C1PinPYrHAKi1KLq7
 EjuElHD0JnV72Q+Lfp6Yja+LRNcj0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511300158

Currently, there is no standardized mechanism for userspace to discover
which reboot-modes are supported on a given platform. This limitation
forces tools and scripts to rely on hardcoded assumptions about the
supported reboot-modes.

Create a class 'reboot-mode' and a device under it to expose a sysfs
interface to show the available reboot mode arguments to userspace. Use
the driver_name field of the struct reboot_mode_driver to create the
device.  For device-based drivers, configure the device driver name as
driver_name.

This results in the creation of:
  /sys/class/reboot-mode/<driver>/reboot_modes

This read-only sysfs file will exposes the list of supported reboot
modes arguments provided by the driver, enabling userspace to query the
list of arguments.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 76 +++++++++++++++++++++++++++++++++++++--
 include/linux/reboot-mode.h       |  6 ++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..ae03f2d96a84477f1e9f281bf3110911d7044a70 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#define pr_fmt(fmt)	"reboot-mode: " fmt
+
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -19,6 +21,56 @@ struct mode_info {
 	struct list_head list;
 };
 
+static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	ssize_t size = 0;
+
+	reboot = container_of(dev, struct reboot_mode_driver, reboot_mode_device);
+	if (!reboot)
+		return -ENODATA;
+	scoped_guard(mutex, &reboot->reboot_mode_mutex) {
+		list_for_each_entry(info, &reboot->head, list)
+			size += sysfs_emit_at(buf, size, "%s ", info->mode);
+	}
+
+	if (!size)
+		return -ENODATA;
+
+	return size + sysfs_emit_at(buf, size - 1, "\n");
+}
+static DEVICE_ATTR_RO(reboot_modes);
+
+static struct attribute *reboot_mode_attrs[] = {
+	&dev_attr_reboot_modes.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(reboot_mode);
+
+static const struct class reboot_mode_class = {
+	.name = "reboot-mode",
+	.dev_groups = reboot_mode_groups,
+};
+
+static void reboot_mode_device_release(struct device *dev)
+{
+    /* place holder to avoid warning on device_unregister. nothing to free */
+}
+
+static void reboot_mode_register_device(struct reboot_mode_driver *reboot)
+{
+	int ret;
+
+	reboot->reboot_mode_device.class = &reboot_mode_class;
+	reboot->reboot_mode_device.release = reboot_mode_device_release;
+	dev_set_name(&reboot->reboot_mode_device, reboot->driver_name);
+	/* Check return value to avoid compiler warning */
+	ret = device_register(&reboot->reboot_mode_device);
+	if (ret)
+		pr_debug("device_register failed for %s : %d\n", reboot->driver_name, ret);
+}
+
 static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd)
 {
@@ -76,6 +128,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	size_t len = strlen(PREFIX);
 	int ret;
 
+	mutex_init(&reboot->reboot_mode_mutex);
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
@@ -112,6 +165,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
+	reboot_mode_register_device(reboot);
 
 	return 0;
 
@@ -132,9 +186,13 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 	struct mode_info *info;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
+	if (device_is_registered(&reboot->reboot_mode_device))
+		device_unregister(&reboot->reboot_mode_device);
 
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
+	scoped_guard(mutex, &reboot->reboot_mode_mutex) {
+		list_for_each_entry(info, &reboot->head, list)
+			kfree_const(info->mode);
+	}
 
 	return 0;
 }
@@ -162,6 +220,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
+	reboot->driver_name = reboot->dev->driver->name;
 	rc = reboot_mode_register(reboot);
 	if (rc) {
 		devres_free(dr);
@@ -199,6 +258,19 @@ void devm_reboot_mode_unregister(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_reboot_mode_unregister);
 
+static int __init reboot_mode_init(void)
+{
+	return class_register(&reboot_mode_class);
+}
+
+static void __exit reboot_mode_exit(void)
+{
+	class_unregister(&reboot_mode_class);
+}
+
+subsys_initcall(reboot_mode_init);
+module_exit(reboot_mode_exit);
+
 MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_DESCRIPTION("System reboot mode core library");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..76900c1b78003559a7b7812bad34206bb3ba5f75 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,9 +2,15 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/mutex.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
+	const char *driver_name;
+	struct device reboot_mode_device;
+	/* protects reboot_mode list */
+	struct mutex reboot_mode_mutex;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
 	struct notifier_block reboot_notifier;
 };

-- 
2.34.1


