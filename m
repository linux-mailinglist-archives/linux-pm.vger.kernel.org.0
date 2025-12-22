Return-Path: <linux-pm+bounces-39771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ACFCD4A2E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 04:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFD8F300AC50
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 03:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031F7326934;
	Mon, 22 Dec 2025 03:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ig2gXhCo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f3xQ8//9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F4326929
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766374426; cv=none; b=iOsHOL9hqInHj53Uh8nJsVVVbTSs38TLgd1le8NXxAUXm4xbc6vbdOT66zOND5WD9AHZ/+jPrgfKrLYs0jFoTWNGZvWDP8talanK0PBgyZFCpmzdBHl9zo7PmK66vn3EuWQaxRwhb2ktjkd572AAmkmGvjx5GgsD6kbmfRYwdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766374426; c=relaxed/simple;
	bh=pcTB26BjM0rgTg/rlf4hOonrUJ2aLbG6b6bsNAnmxco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wq8TXmkTS6LWvWUGem+KnjZhnsTv6fdthvhsdgX80tYcqyIHxGioFZYI854DwYweNv3PbfAXegERYkIfh4NY+82ulh8oMv1S+I7Wje4Xr7uRdm3KHA0+6ev2Mo7NpMv3xmsuJkf5FOgUOirRrhgjBFOqXd4kojFBuViuEWIB/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ig2gXhCo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f3xQ8//9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLLbIqc3234134
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 03:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1p9CxVLMaIHOlUHd9JiMY/BtnRL92iMP9Sy0KYtGHdg=; b=ig2gXhCoMxXIUJyJ
	KTrgKK94kmZaQVHrmyTFXs1f89JCKk8aqYMWJjq4xDHXyVTbt+xChTZm+gpFETn4
	jyFICobKR30+M5c7M+F9dhDiPZ9q9FRqHAL3vp5Lt3nm9WkfD3A3LHJNuJYAdjVy
	sPjPTLFu98azChBX8SV/c/XS9jM5lHT2IuuvkCI095n+5ylbbnSSZpX7AAKWi8q7
	3GLZoCEx4bcs3q56u6zGikCkNpHjNTQ1i5BRdjq2QQRclITmLZaG+m7B/MPJbuPE
	vqhg7jSkiTX+Nrd/1FVgtQbutk1RaM4DCzx9fpBzKriGF35MESoNezvz+OsHnOcU
	zCh8HQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mtqkf5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 03:33:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7f21951c317so2877418b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2025 19:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766374423; x=1766979223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1p9CxVLMaIHOlUHd9JiMY/BtnRL92iMP9Sy0KYtGHdg=;
        b=f3xQ8//90SezhEqjuu2s360BhE58UWnQZFFvRzKZfw1jcqgErixjjZkP+Bn+Rfmjl4
         6Kg25Zbuuks+G+PFvwkHfu7H50PUDorXqPM+cdOU/7D+UKPHPhjyTkRhSs6YqR+/GOE8
         BmYWtv1tkQ5661vSEbLrBIY81r/UaRPZHbOMaDCYFgrUP8dxG7DP2m0zj1Uwa/q5ZTXp
         vWuKhChTYE8rA8HTlVGFM+8qDz0wORINBexp2+P5yxnBTRPrGLdO7VmC6lhbRQFqiYV2
         Ki9BbGdHrgTvi4+zkEfsJ+MOAYI+wW6DqtTGMFZjxOl//EyEVCnlvUw0GaL0oI39SL5g
         A0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766374423; x=1766979223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1p9CxVLMaIHOlUHd9JiMY/BtnRL92iMP9Sy0KYtGHdg=;
        b=d/t+V3R9Y///5b7rxn/LQfyPs6iiELbfH2rgiw4iNUFNVKsO164iVfyYQ5bePk0XbZ
         OG6EF4DBVnth4NoXlSCNNyiwj3hunrihVG1PcCxvR3cBqZei6lWb+9bc2Hkl9BEYH+Iv
         6G6l6fuiOADPeKpGF9wMbqgQojTcoGJdkXdoBmDFv9dAOk47UiE92iMZKeCV/fpq63xo
         S4RLsBNEeeL5oHm1QpHuJ4yXyruiHmHk++afIhEp6S9/hgjiIzzkVEcSCAu7zz4DVo8B
         LNmTXLso2bNOj4L558Maa/mzDw6SR5LRdr3lGC8YKQJJCwBh0bQ+wk3nnJccwLrMmMIE
         bQag==
X-Forwarded-Encrypted: i=1; AJvYcCVI5znObYfhnZzQk3fL0CGGd38yoJLRmdvDJHAgBXawmYwKUB0d7FAiwiHE/b0oqza2dJorZzuK3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPdRIN9qX4d18Xp2ZGV3BzWjWUdKF+XARsuzZ9XEpvHQsHrSk
	2IR3bICFHIUkaYaIZ8VR9Kfe4gkym4yZNm8H+HMTV7J4t+j+9gPVFjdqryKZK+zGnEAiMLRQBwQ
	Hqvj8wA+A734qYhey91N+iZWckf7pJ5cLKwoKkWTyT30kDBWPcIQPWtB7HZeQIw==
X-Gm-Gg: AY/fxX4v1jpzsDArtftb8Y4+j6z2lNdmB4HsCCR2HYqwoxu76VRuGrD1ab4giS4VhEB
	GZVBso9qIoJ5e0CS4dedLKA6c+CkH7Z9tHQrfPEdCupiHTZog+E6cWhaBf8CAHAWdDDHeOnJaE/
	xdjUFYqVNgIM38TkItMQWHXIJfwHtSfipbMj5J5Q0LlIVwW/c7eWxEHLqqKwt2voOmv2ErH1Lqe
	sIVKRUCgzozM8SNFsWNmY3646vySwYPeHaQmr0kUsRHSPm08co0QKO+qV28urcoCEZmqerafbjw
	WnUFziOglasXBbckLN3ZbA+VkrI/6aLZbRj4Via4pMK4M4fqp836new3vlm5Xbfh3j5g8uf9pGI
	fLkF815AyNlWyyAoVn6C9oN+jPxGEFvBVzA5+svaLgWCflg==
X-Received: by 2002:a05:6a00:e11:b0:7ac:9d93:3efa with SMTP id d2e1a72fcca58-7ff6420d8b0mr8174493b3a.7.1766374422926;
        Sun, 21 Dec 2025 19:33:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkdPKKN3e/I+ctbjjSdQlAcyU5+N72pFYLUi8N3ALlJSQEhn0x1h7LUw3IYPEc+jDJpKSrBA==
X-Received: by 2002:a05:6a00:e11:b0:7ac:9d93:3efa with SMTP id d2e1a72fcca58-7ff6420d8b0mr8174474b3a.7.1766374422376;
        Sun, 21 Dec 2025 19:33:42 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f30bsm8633837b3a.48.2025.12.21.19.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 19:33:42 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 09:03:23 +0530
Subject: [PATCH v21 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-next-15nov_expose_sysfs-v21-2-244614135fd8@oss.qualcomm.com>
References: <20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com>
In-Reply-To: <20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766374413; l=5490;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=pcTB26BjM0rgTg/rlf4hOonrUJ2aLbG6b6bsNAnmxco=;
 b=7wRCltWmycbntB7GGPJA6W/+/Q9mdQFAOn4w0kRJ0Rc7EsVG95srR6IrawaVe050b5eSRHoQl
 uWiXuKTuvUGCetUNG7JM9+FGEFRlCAkEkJV+nmSDZ9vNUOPOEueUgBZ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: 9x4d0N7OUrYDAXI6z4K9jPKi0yo05P9d
X-Authority-Analysis: v=2.4 cv=dPWrWeZb c=1 sm=1 tr=0 ts=6948bc17 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8
 a=0ofMVug2fDiiE6i26csA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: 9x4d0N7OUrYDAXI6z4K9jPKi0yo05P9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAyOSBTYWx0ZWRfX91UIimPWG+bg
 CcAycSVe7Xs8QwwB6NQEgU0HHH8sWMylo0TjvPuDFyK762WbBiCleV4pqTdVQmSsyxI8s4OGWHi
 1luLm33Qe72DBMYvGEGnL18ujwA+ZXvlVJCnQ7spUytuERWuDZ5Q+mrZAWCIhseQcW8LwD8RcpP
 0WO/8Bvfp+fumZfMlyjTq5oxig7UBEPD7Z9tHCSQ9MHoIif4JOyD+0cwiChuS7cM+1LOnaQxemg
 GPn0bofsdJ69dCV23wZsvF3RR+rYjWp+XQipTSDc3F/sEw1pfq8kr6tYHJ0Z4On4D8nnyGrpC0N
 wjb6O+W5nOt4Pm0flqC97S5LrKG5Y6qmI9B0pd+TDK3Ynccfs7pJqi5bkQ37dkgFM5vkzH0z0pC
 wR4CUSdqRhImI++ZIAGiaOeCO02rnre9QSzW8xaDuEPGv8/10UwbRdiGtCt+e1Sw43jjolEmaWk
 Fuq7TOnXp8utAd4t1XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220029

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
 drivers/power/reset/reboot-mode.c | 75 +++++++++++++++++++++++++++++++++++----
 include/linux/reboot-mode.h       |  6 ++++
 2 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..28d1fe09d685a7422027fafc9d6a3db97a6aca18 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -19,6 +19,39 @@ struct mode_info {
 	struct list_head list;
 };
 
+static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	ssize_t size = 0;
+
+	reboot = dev_get_drvdata(dev);
+	if (!reboot)
+		return -ENODATA;
+
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
 static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd)
 {
@@ -76,6 +109,15 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	size_t len = strlen(PREFIX);
 	int ret;
 
+	reboot->reboot_mode_device = device_create(&reboot_mode_class, NULL, 0,
+						   (void *)reboot, reboot->driver_name);
+	if (IS_ERR(reboot->reboot_mode_device)) {
+		ret = PTR_ERR(reboot->reboot_mode_device);
+		reboot->reboot_mode_device = NULL;
+		return ret;
+	}
+
+	mutex_init(&reboot->reboot_mode_mutex);
 	INIT_LIST_HEAD(&reboot->head);
 
 	for_each_property_of_node(np, prop) {
@@ -107,7 +149,9 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			goto error;
 		}
 
-		list_add_tail(&info->list, &reboot->head);
+		scoped_guard(mutex, &reboot->reboot_mode_mutex) {
+			list_add_tail(&info->list, &reboot->head);
+		}
 	}
 
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
@@ -116,9 +160,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
-
+	reboot_mode_unregister(reboot);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -131,10 +173,17 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
 
+	if (!reboot->reboot_mode_device)
+		return -ENODEV;
+
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
-	list_for_each_entry(info, &reboot->head, list)
-		kfree_const(info->mode);
+	scoped_guard(mutex, &reboot->reboot_mode_mutex) {
+		list_for_each_entry(info, &reboot->head, list)
+			kfree_const(info->mode);
+	}
+	device_unregister(reboot->reboot_mode_device);
+	reboot->reboot_mode_device = NULL;
 
 	return 0;
 }
@@ -162,6 +211,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
+	reboot->driver_name = reboot->dev->driver->name;
 	rc = reboot_mode_register(reboot);
 	if (rc) {
 		devres_free(dr);
@@ -199,6 +249,19 @@ void devm_reboot_mode_unregister(struct device *dev,
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
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..d7141a1a609b62bd3185642ecc1478fdd3555037 100644
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
+	struct device *reboot_mode_device;
+	/* protects reboot_mode list */
+	struct mutex reboot_mode_mutex;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
 	struct notifier_block reboot_notifier;
 };

-- 
2.34.1


