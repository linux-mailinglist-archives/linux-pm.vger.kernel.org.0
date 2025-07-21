Return-Path: <linux-pm+bounces-31227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70FFB0CA75
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B0C546A52
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49D2E1742;
	Mon, 21 Jul 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+DFY3Kr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC352E2EE8
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122559; cv=none; b=IGRWQZkyyTzLjNYI4YolQq3J3JD1il/EkWx/m8OuHNpeUquyvTFfmcWjP2v1ztFT91C77haZlzB0ULkyAqFo+GoEffVw/a89hujgcTEHHBztpGTi2hwiEoVjtSoeFnzU/6dz2pUcjEj8oJHIJk0a8xCDGAmFx6qvLor0tK03s1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122559; c=relaxed/simple;
	bh=ZyOHLYhozG6V8PN3U/0QHQPmjuZ8gOT3WNXbJbdwhzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmH3J5+wTpaTMD8MhH2bUjVqeI4Euenj1z18nglnCRvOsr2cXtdoe2gwi5JeyTRESjhs5ioP/WUTLuiEMV0OOxGrx6xiXZaMaBsx7DYoKwuPsEZQXfIsCy+GvMAFGDyOKq3GEQrv/iRSyIW5RkVyrs2HAonyUP0mSSH3MTIAuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+DFY3Kr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LG4u1S016289
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rG45QmRI9+iBqNCinCJQTKzCsl1+wtsDTxp0VKROmY0=; b=N+DFY3KrKYEQTf10
	IOll9qIyYOdXsk8tbVQ+zsB8byxO9bfpS4MgnaoiNCnHbsmIc1qnh0kA4unf0ain
	x2q6O6JM/MFzVdQMyc8wQUnUDGrrFFqVww+dbvF/uYy1UtxaXR8zWUGVgYmPU+Po
	1V1vNZhL0WpFoCtzby3UGPozbxUfP6J+HykvVKSAc4xmzrlrg4LF77D5pmnYh+VB
	phvZc56K/jx0fIEzoHKY6NNvwp/zcJeVbCbkwvmBJeViMksBHr3TDaEWHqEgRRiZ
	cEedjqxO6+odjJ6otUdQQ4EGAi9GNQyXOGaR1sp9AxPB7KRLrJg3GNfbESGXapit
	L3wh9g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rxuvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-237e6963f70so74912465ad.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122555; x=1753727355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG45QmRI9+iBqNCinCJQTKzCsl1+wtsDTxp0VKROmY0=;
        b=Z0zrcMryV9AJa2CwzVLoWbyMA9gmkwXkNqFXfWerG1cOtg9s0W0evSEXWTZYfzHSHM
         mIa+pjmGYtL+mO/iYeSDZ3mM2a5YQGfBTLHLiPjuopWysfaZPpdgX8uoThK0nATxOLNQ
         v7tPmwCp1SsFB1VssHzpjuI/myvLueQPxoJBV0sAXZJrIluLp4xXNv8XzSj43lSd8efU
         XiMavV6n3g3/AYbvLZ5TboJKGefdP/kMzTWZxJon+z2VRaMFpY5Dou0kQreIm2K9+bQf
         zyLcip55q/a8pcmUn1/e9D5A+n3aGfjod1beZQu/W6/C114eT6eqwVCxaHK7LYWGpFZp
         FFVA==
X-Forwarded-Encrypted: i=1; AJvYcCVBY7BccbfpUCySazXyXYaEnY2sWjOsXidZCwG7ItE0yEqzxJ2IopfzyzKA8sgGVjLfQgC2GzVqyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqqqQd6aEETbXqXP7P6F5dhcAlAItkiB6Z6ARnCwhMiC2SJRpY
	DerPPwTIbppSKJT/DlUblCXEZkCAii5Jg7xKy8afVx1UAkXLWW/zdS0Tevt4pN295+juwqKAXqt
	gNIVjYda6YIKtmcn0SML8KpJaoB0Qjdy0v2bFZUA2jURiMuM7T42lNzfuWstaBw==
X-Gm-Gg: ASbGncvzdLUYnOVxCEm9BcX2lVzKNLOs4wi21rrfGiaQjW5jLHq2KLrGJ05eqP6p5qI
	PVphE1a5RWR3BS/7ahKnRxE6ZDguoOXYM6gAnOKHMOnmQ07TGdnbVX1KCnQ2uDY2W/Vgapny7A9
	d0e9n6YxP4XzwAt41uFNGr4YXRNuLRKyN3ilPQMOkk4E+UFeC0q55G+MIzvakZ8BA5pJt8BR1DS
	gxa0Erxj3TqjjHtX8sigfEz5ln0rEDMA/NryQkeVrg8AaPUL6ENspoCtKj/fg93aytugNR90/KL
	cjfvM6/9oOLSBS1R6Hea8elvgSvHnxialOAbLDazWtw5/p3lxP+b/ygvNrnrKfxmNsJDwm8wpPN
	C
X-Received: by 2002:a17:902:e743:b0:236:748f:541f with SMTP id d9443c01a7336-23e303381e2mr198330145ad.33.1753122554979;
        Mon, 21 Jul 2025 11:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpAzVNLaCg2Gv77/iRs3fyWlqjCLVrcaPExqG0knuGIGBMl7og87zCiNVJnrLBQrLtETRsRg==
X-Received: by 2002:a17:902:e743:b0:236:748f:541f with SMTP id d9443c01a7336-23e303381e2mr198329695ad.33.1753122554498;
        Mon, 21 Jul 2025 11:29:14 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:29:14 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:48 +0530
Subject: [PATCH v12 1/8] power: reset: reboot-mode: Add device tree
 node-based registration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-1-87bac3ec422e@oss.qualcomm.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=5726;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ZyOHLYhozG6V8PN3U/0QHQPmjuZ8gOT3WNXbJbdwhzc=;
 b=KOFzSAWzGKbv+M79egz/GChhgHU6xfaA5O1QqIxVw6CFdGzR5PYARtR//aW/C6ryBSPhMCl/x
 gkyK0fDoyYgA9Q8BCmazAW1z4mUnbbRJq0MZuXwYtmoqTpHggSB0btB
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX7cWtZWXYJXfi
 nDxmn+0C3RKc+WC0NNiPLfwTcAeJEpJjEFxVa8yua7Pvut49PKXdH5C5j0IOPZJtSV7GqDghEfp
 cQPbDmcJg3/sS+j58KKEYr16HYYuXso41cbbRZPJgVkia7EeiB9BHu2utPRjFPYdV85z4ODHsW7
 cvBgq1MOb7FnizRUjUTZU8VZfE7/ZSlb75T93eE4F2E48pFYnC6EKB5wVrlXKXNuiD1Httpeu+B
 tb4t+3poK3rlLtbCMZJEJ4NM/mRvVcDezDmSVrpigxBUqdXZHZnZ9N67uAkwPSRgsMfa+niIBnJ
 ajfTZ4lULWLv+AbijJmQrlFcE43SIFy18yPKSp0Mf7wenebiHNV8QRucAmRyjgo7pVua2JkDJGD
 E7IM3KPizUvk++172w0Fqn3VDDE4x0MHgjBwa2JwVspJ7oPs4IPQaUmLspJC83/hSKT/m+lK
X-Proofpoint-ORIG-GUID: -ngPMrEN-OoajdEp_Gfq-_XVLasnts80
X-Proofpoint-GUID: -ngPMrEN-OoajdEp_Gfq-_XVLasnts80
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687e86fc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=239sejjMsMoxT4pUUhgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210164

The reboot-mode driver does not have a strict requirement for
device-based registration. It primarily uses the device's of_node
to read mode-<cmd> properties and the device pointer for logging.

Remove the dependency on struct device and introduce support for
Device Tree (DT) node-based registration. This enables drivers
that are not associated with a struct device to leverage the
reboot-mode framework.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 45 +++++++++++++++++++++++++++++----------
 include/linux/reboot-mode.h       |  6 +++++-
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index fba53f638da04655e756b5f8b7d2d666d1379535..5dd3f06ca88cb28606d9fd2100ce03383c14d215 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -3,13 +3,17 @@
  * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
  */
 
+#define pr_fmt(fmt)	"reboot-mode: " fmt
+
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
+#include <linux/slab.h>
 
 #define PREFIX "mode-"
 
@@ -55,7 +59,9 @@ static int reboot_mode_notify(struct notifier_block *this,
 	unsigned int magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
+	mutex_lock(&reboot->rb_lock);
 	magic = get_reboot_mode_magic(reboot, cmd);
+	mutex_unlock(&reboot->rb_lock);
 	if (magic)
 		reboot->write(reboot, magic);
 
@@ -65,45 +71,51 @@ static int reboot_mode_notify(struct notifier_block *this,
 /**
  * reboot_mode_register - register a reboot mode driver
  * @reboot: reboot mode driver
+ * @np: Pointer to device tree node
  *
  * Returns: 0 on success or a negative error code on failure.
  */
-int reboot_mode_register(struct reboot_mode_driver *reboot)
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 	struct property *prop;
-	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
 	int ret;
 
+	if (!np)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&reboot->head);
+	mutex_init(&reboot->rb_lock);
 
+	mutex_lock(&reboot->rb_lock);
 	for_each_property_of_node(np, prop) {
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
 			ret = -ENOMEM;
 			goto error;
 		}
 
 		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			dev_err(reboot->dev, "reboot mode %s without magic number\n",
-				info->mode);
-			devm_kfree(reboot->dev, info);
+			pr_err("reboot mode %s without magic number\n", info->mode);
+			kfree(info);
 			continue;
 		}
 
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
+			kfree(info);
 			goto error;
 		} else if (info->mode[0] == '\0') {
 			kfree_const(info->mode);
+			kfree(info);
 			ret = -EINVAL;
-			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
-				prop->name);
+			pr_err("invalid mode name(%s): too short!\n", prop->name);
 			goto error;
 		}
 
@@ -113,12 +125,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
 	register_reboot_notifier(&reboot->reboot_notifier);
 
+	mutex_unlock(&reboot->rb_lock);
 	return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 
+	mutex_unlock(&reboot->rb_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(reboot_mode_register);
@@ -130,11 +147,17 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
-	list_for_each_entry(info, &reboot->head, list)
+	mutex_lock(&reboot->rb_lock);
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
+	mutex_unlock(&reboot->rb_lock);
 
 	return 0;
 }
@@ -162,7 +185,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = reboot_mode_register(reboot);
+	rc = reboot_mode_register(reboot, reboot->dev->of_node);
 	if (rc) {
 		devres_free(dr);
 		return rc;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..98f68f95c9e8460be23282c51ef7fcbed73887bd 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,14 +2,18 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/mutex.h>
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
 	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
 	struct notifier_block reboot_notifier;
+	/*Protects access to reboot mode list*/
+	struct mutex rb_lock;
 };
 
-int reboot_mode_register(struct reboot_mode_driver *reboot);
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);

-- 
2.34.1


