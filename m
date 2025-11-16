Return-Path: <linux-pm+bounces-38097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F3C61760
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5B71A28D5B
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78330CD8B;
	Sun, 16 Nov 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YpNVlsUS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjQc+ku1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42130C622
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763306417; cv=none; b=NvggRle5oZltDiSWnS+9ZlmjgYAClERZ3778N1+eZnNyiPK6tLM14xYaj629svKBT7HsJTCR3Pi9dqwN71JyUnDfGCUt1hIPDDq3JVVlP4jf339bKlqTfDeUUNZ6wedewfGznxcCcUA0dkua8HVmgvoGRm+umUM4A/w2YGC6H2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763306417; c=relaxed/simple;
	bh=ZtBepfXNfP9Vd9Fvqol0mLMn32NO2zO+JnUdEY5QW14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qa5cTd2DE2/VukWPY8vPZeQdV34GkjE6aGVgHVS4tMwwATRKcKYReLRc3YkE4w9fcGpT50t3yiN8venh6GDij8xQuPrjl/eAsB7gKuDScENirxe1cBaEsMPUCFgBWaUHKDBnXr4+k+cVEw7k9B5898kMb5rEj72pPUifMFUgeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YpNVlsUS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjQc+ku1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AG9qtmK514863
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ewpABGkpKfdAof+4lPAMR//vcQEzIZ3zsrx2TmN8ivU=; b=YpNVlsUSMn1If3wz
	8bD5cHkJqPqVnT8BPQSQw76luKcEpvxaO8nAXHznBLeHG6f2O7EJmKsEQoWGd6yg
	fXjEd2h2g1I4pq3EUJAQYDPKCO/buqKAk4cVCT3KC3Qv2IchhZdrSe5pV6HyHwHa
	06I7bxSl8DfAmK8kS+NE9WP9IcXf13b4enXJkjk5V2rHbo+QbY19s6pq/52+6W1y
	H+nA1KKVaVcBBPkagVIBL9t5PJBWUM2YF7CPlMVdibpEHWBMkWCfzhE73EZkEh3f
	t5wovxi4HpUsjhIGTPDn8JYOopVjoMsxBBvEdP81G7OM00g0tGyekTYYo74EDlNY
	UWJSEA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejkat9bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 15:20:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f48e81b8so57458495ad.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 07:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763306415; x=1763911215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewpABGkpKfdAof+4lPAMR//vcQEzIZ3zsrx2TmN8ivU=;
        b=IjQc+ku1USblPJtM8ZTFnPoMWFOLIRnMtHvF8LqrpPO1u632JV+alIXxuLf38NrS1+
         yCbrmTFblUSXSPuBEWIx45re2lMHFZupoegiesa+taVGe6TQYfCicwQrgAYbQGEzFCLa
         aNxv6RwhkhohSqw6qQlwU0hHkuGHcIps9kSS11YSkhK7Z/KonRUCKCmLQtb71Bxp0Ntv
         YGt/JGplTi60mavoXCs12sneEqp9wpjLxLaFrI1xE0YLx7A9Mg/vAAbguuqNBscgeaVy
         VZo/8qJw/h56lsMU1ly5AG6BGds8c5aTWqqyLf0Tl3chZLDDDWAJy3xcS4ws1bjvZWSp
         7Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763306415; x=1763911215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewpABGkpKfdAof+4lPAMR//vcQEzIZ3zsrx2TmN8ivU=;
        b=OWaL+hov57a5omSf9keEXDQeCWvXgTcgRSVKf3cCaVFBqztH+28yd/1hsvZPaOjFT1
         xeRzqOWtdGhlULrWL0ooiEXlNzg65i4whrRmakgI8nV5lbNknIWSSJqqj2kLGzg4UvVH
         p7zl4EeOtoEx9ApW+VgaDWVHNWqXcY+TzA4xbwK3svEyFjMk2mN9hcNQ2S+RuRRSdlZ5
         B73j0eGXvSGxQBcxDB35gCsIpuodkvwStDhRlx4k3hDZs7viZQRtngshhbt2jHUgxpk2
         1+4ngTCdQnkqgPXx4nGFGW32L6UuYQiMD89aLhMf+A1WhsjL4O/w2VOwtzRDFJuOTDD0
         R1+A==
X-Forwarded-Encrypted: i=1; AJvYcCVIXTh1YMfUn3IsMaAnMUaCJlN516AMVTG3q8M1Hgg01L3OB/KEzGC59WkD2SgnUDML6Xdxu5Ks7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OVS4lD4vSrbLnTgV3B50zIMwkdothMKcGoHq6eRqqdIlz1y2
	46lNn2aX+ccwaDnkPi3cMr6Wh0/kiyBDj5r5Ef9DC/8vQJJgIwMul7eRafm+0PVTNATiQu9WyFT
	VxSBMyIvpR62SiKK9MqZ1MEVxR8YdbSMDv4TQ77v1yMBtg3kSYQ4kL3S4vbB4RQ==
X-Gm-Gg: ASbGncuf1LKUv/CuT5eo2rE8TCzCc4sjKqdAZLmekMKdQOBiqVZ/GZhLxiJA9tLYfWD
	uLtHYXdXcsWWaLV8a398kEqSdEx+YftPQ+jqytOzzb5rCk/YDv/qBOWl658r6tvt6bZuRqy7HqA
	kMMOg5ZBsGbdMJUnr5dlEGgH+w1FHGQPeKABVrdKyw4Rn/alDfaXHywz/xLE4KQYOrlbD5OUpXQ
	fC82ztrpMAge2rrA01+ioGUSUurjaHqli0zi6gLwWKxaFpDigiy6j2iiqAQiJAyeRA5Oe5KTrEG
	ZzCFRPBIibliOnaBTvq3rxEDtKASEO8e9ogr/cDILfN0j3fEvzCmANHojk/SR9eXJNr4B8K4dtw
	NRToLnhfYGd434UYjpa9LC1Ngxh2uikxTig8=
X-Received: by 2002:a17:902:da81:b0:295:96bc:8698 with SMTP id d9443c01a7336-29867f92114mr109667695ad.19.1763306414888;
        Sun, 16 Nov 2025 07:20:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUR8jLj88wIIf0FT51OOczIH022Q0TKoHXMgGFMRInkMbIf18ICcoUzzrUCfhXd/Vb1SfmUg==
X-Received: by 2002:a17:902:da81:b0:295:96bc:8698 with SMTP id d9443c01a7336-29867f92114mr109667545ad.19.1763306414430;
        Sun, 16 Nov 2025 07:20:14 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c241f89sm111166205ad.28.2025.11.16.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:20:14 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 16 Nov 2025 20:49:48 +0530
Subject: [PATCH 2/2] power: reset: reboot-mode: Expose sysfs for registered
 reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-next-15nov_expose_sysfs-v1-2-3b7880e5b40e@oss.qualcomm.com>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
In-Reply-To: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763306406; l=5218;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ZtBepfXNfP9Vd9Fvqol0mLMn32NO2zO+JnUdEY5QW14=;
 b=SmkzVXNdbmQwayygGGczzgYkY8viIOj8rWoujItwOjAczz/dhPZ4nONtj5ROCcSIfOFr3PFJC
 rkIyuNjHWysAf9ydKpcP/VWbqusFWtCH/qUdP1DBKpFZaw8mK7E/NFy
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE2MDEyNyBTYWx0ZWRfXx58B4+xGyTXH
 iy5cW4Xjb3J6gHKocHqDAh6jtNkbt/N+UDwr/fglko4Gyrwz+5ohCq/S8tRK6qaNtWLKFmymcua
 e3ARbYD5R8bChW1B7j2qMi/zVhdvO6l5Xg2pABNygNan9pYdWrPI/JESiEiqlvIakmaOI+cmZno
 DVVW6zhfcI3UwnL31DtINDAsLFZ9d62XFKTGPCBJRuBwFnghtLTzSHXiATznnlvSAE/AzB2F9Wj
 brgxZLls/Yxq6UflhJL+oIkC3op94WN8sc5lEC3tvmECS2DVMoiZMs/Gb0zz8cp9KgOryvIZKYi
 TYwtgjrD/y2etRQqIn5VZ0+gSZfRu70u2GlGf2VwVaOl425G/GfSUs4SXXK+z2yZMnejzw59P2H
 U0Q0HafkuPDK2dwUv45S9OuZsXG2pA==
X-Authority-Analysis: v=2.4 cv=UctciaSN c=1 sm=1 tr=0 ts=6919ebaf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_IXiiBmLcBuSsypf6xIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: riZ6s6Z13L0s4awWI4sUUHOgDS9FXlRn
X-Proofpoint-GUID: riZ6s6Z13L0s4awWI4sUUHOgDS9FXlRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511160127

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
 drivers/power/reset/reboot-mode.c | 72 +++++++++++++++++++++++++++++++++++++++
 include/linux/reboot-mode.h       |  3 ++
 2 files changed, 75 insertions(+)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..062df67735c4818cfeb894941e537f19ea9d4ccb 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -7,18 +7,77 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
 
 #define PREFIX "mode-"
 
+static DEFINE_MUTEX(reboot_mode_mutex);
+
 struct mode_info {
 	const char *mode;
 	u32 magic;
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
+
+	list_for_each_entry(info, &reboot->head, list)
+		size += sysfs_emit_at(buf, size, "%s ", info->mode);
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
+static void reboot_mode_create_device(struct reboot_mode_driver *reboot)
+{
+	static bool is_class_registered;
+
+	reboot->reboot_mode_device_registered = false;
+
+	scoped_guard(mutex, &reboot_mode_mutex) {
+		if (!is_class_registered) {
+			if (!class_register(&reboot_mode_class))
+				is_class_registered = true;
+		}
+	}
+
+	reboot->reboot_mode_device.class = &reboot_mode_class;
+	reboot->reboot_mode_device.release = reboot_mode_device_release;
+	dev_set_name(&reboot->reboot_mode_device, reboot->driver_name);
+	if (!device_register(&reboot->reboot_mode_device))
+		reboot->reboot_mode_device_registered = true;
+}
+
 static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd)
 {
@@ -78,6 +137,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 
 	INIT_LIST_HEAD(&reboot->head);
 
+	reboot_mode_create_device(reboot);
+
 	for_each_property_of_node(np, prop) {
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
@@ -119,6 +180,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
 
+	if (reboot->reboot_mode_device_registered) {
+		device_unregister(&reboot->reboot_mode_device);
+		reboot->reboot_mode_device_registered = false;
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -136,6 +202,11 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 	list_for_each_entry(info, &reboot->head, list)
 		kfree_const(info->mode);
 
+	if (reboot->reboot_mode_device_registered) {
+		device_unregister(&reboot->reboot_mode_device);
+		reboot->reboot_mode_device_registered = false;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_unregister);
@@ -162,6 +233,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
+	reboot->driver_name = reboot->dev->driver->name;
 	rc = reboot_mode_register(reboot);
 	if (rc) {
 		devres_free(dr);
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..400cfde0e029aef14ff90a11b9d12d0c3ce8dee6 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -5,6 +5,9 @@
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
+	const char *driver_name;
+	struct device reboot_mode_device;
+	bool reboot_mode_device_registered;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
 	struct notifier_block reboot_notifier;
 };

-- 
2.34.1


