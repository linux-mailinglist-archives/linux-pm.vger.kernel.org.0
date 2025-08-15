Return-Path: <linux-pm+bounces-32438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D0B28206
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 16:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E841884500
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAC1238C39;
	Fri, 15 Aug 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMHDQ+fe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363CF23505E
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268609; cv=none; b=urHO/HuDC0qcxgZq3jpS73bDDPTkn13HIVJh2BS4FPCIFNyJFGbXMhpJgaCYkpbcnsxPicgPwUHzpe1HGBiGTMEqZvbYCgeKBJyYIwU11/HF0huJltemG7yj27EIpkDJCwYaFVyacKl01/+dXua7lEzfJn3I3VLpu6s5GptdXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268609; c=relaxed/simple;
	bh=BzWfToJE3ECxETuJZ3k/sBp7q/SRF/jEhj86+u2O1rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzMrB7yE6hOEBjq2SUHZDgMQjxAg+ci0FIKCHPhB7uxRwGz8pBfqUv9sM/BIkYYypFv//zejvF72GmqD/O6bUPABOBfqxkAOUdFRNzUgVrnf/3zWB4uGp/S0lOrtAjJcaMHTUtYR7jB5YNGZ1Xc7Hi3qEIUa4YlHmeIbt5qpAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMHDQ+fe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIhwe027521
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDqwUezYGa9CZCaFbdXED7PEdoZ055Cwe3xHxx1ns7M=; b=bMHDQ+feRetjFTrc
	m5JlDNqAhot64rJRTsRRmgf7cf42kyAgR1V+l7Y5D0ECygAxX4/yeec64BsqKnlY
	YbDiwkw7JnoKjaykTWPb4/xiIxDtwRWb7v3OmOOG6xxAbQZBxLLAd+vdmrfjKd58
	BcfrdO21VrJvSfRqBiGzNHKrs30CIfgpmwi82btpa+9v4qyVrNIWuivMx/TBmhVD
	upp0jI3exh1jVPrg5Kj+c9k32yJPhbZienJxS+Oi9N/hKcYwSan3SSZnHvcpAuFN
	sCUpMqtH5WUAFL4CVbXZYrIqQulAhHSOkM4WvjmhhspFX+4NmbY91pUpcVOoE+Wp
	5VqMzQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjy3jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:36:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32326e09c5fso2060673a91.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 07:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268606; x=1755873406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDqwUezYGa9CZCaFbdXED7PEdoZ055Cwe3xHxx1ns7M=;
        b=EGpMI90vhcnFmSqJ06NrHOjJIfYT5Zo6/kRZ2NLlu9n2NXI4M9tuymoVKpmTpxzGHn
         wcFdLGVmU7vcGpXSx7hF+zOVptgHa3k1crPG0VZdw4Ok90dge7EjPSWA7t7yxiL1Yeyc
         ik0e7RzmjphPnvqLhPEmIAFUUAga/TiM4Y/6pW+7D9q46sIcdT2fjbrzhUDtV+OTHFVD
         dpsvq5Jk/xfeQKBdGlj/JCvDYB7bXE4dG617PknneVhP33bCBFTNxTY0iwWKbDWKksfo
         87vl42BsgR9hPXaOPpW74JCKT5zjD6vFFw1X/8gXE8Jv+YHNIEGCpd2hasi5Jj4Jo4Sy
         BL2A==
X-Forwarded-Encrypted: i=1; AJvYcCVoxfEq+gwiLGgXA5D8ceo8MlaoOrEdk6lI2iAK2iuWMxIvI8hi0eRSoUUAmS+cCNjoAeh4oq888w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tHqNU1VzvfpsS8RARtgrMxhbPoBYiTGx778t7kOoC3+fcq1E
	VOkc+CkG3PECSjmijdERFbHfjE12PLkfQLUXsE+HL1jEzTccFgIJWasAT8JAOEKUT1pJh+2Mo9l
	PMANsmfp2E0XZcxw0whEuGAlDXuOc17DbWoDYzOCxIzdGydA9GUNwAVTiyXxt2w==
X-Gm-Gg: ASbGncuQ7I1PCPFI1mItEJ+TqdtKPwbqjmYm9AVrL4nIYUc7s6fWyQz2PTodfpB8Poy
	WKQweOcYUGq2CZ/4yG9SxR1Wevi0T6D27wwRNoqNcadCtXzCW6SfwkeIQrowzp9suqGIyn+KGvY
	XlANthEBY8X6NT9zpU2R371o4E5eUDegd7biNF5BmDOkFKaiZyEkm8aTZUBI1aDr1M8KEFlOEkL
	Xz/3aVHWztL9AuLx1JcjpflcGGhnGRlKjbKHTj22NNY1i+e/vZX8TAWOg2YdkqDDwvU3BOK72Yb
	i5lXQz+8QXjlucPHHQKRWJwUCtGuufEo3TObr7bdknCRJOi3Dp1UsY57fWVpaBXZ999Mn6i+M80
	B
X-Received: by 2002:a17:90b:2dd0:b0:31e:f351:bfec with SMTP id 98e67ed59e1d1-32341e5e0a4mr4204572a91.0.1755268605464;
        Fri, 15 Aug 2025 07:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqZ62D0ilw5h3pOxyKsD9atT57r02HUkM9y580UM4/h+lMlRwpO5+zb86tLI7CTdiz0ij7TA==
X-Received: by 2002:a17:90b:2dd0:b0:31e:f351:bfec with SMTP id 98e67ed59e1d1-32341e5e0a4mr4204499a91.0.1755268604960;
        Fri, 15 Aug 2025 07:36:44 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:36:44 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:07 +0530
Subject: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-2-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=4877;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=BzWfToJE3ECxETuJZ3k/sBp7q/SRF/jEhj86+u2O1rk=;
 b=RYuLdurTXlXjQtCHE5nX18yZK2e4lWHzqk3OBDVjfSP6IPXK9bBT/5bHpFJuKNoKQTKctA3aE
 EXCLcCs1FcgDo9wc3NWVVqzdZmL2XVhAsx81HO1e1vIlJH9mOiOFdu7
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX4DiJL/ATQSo8
 MIkoIF++BWg5I7B964FKT6+miKsNhwZsfdXj706yKtVufb4RZ3gOSFzcy8tsBGWHctKGNo7nP6j
 /QPP8Ij1I1GKbQ/huqAaIPIRcI2ad9b3JQSrptF3PvomCXIPyPjDV1dsF2+SYsQcUIyOvBkzDKG
 V45K+ABovw4hnW/E/U6r2yVxbLKKpp9GpV56K3ZpirT5xVOd3nLhGHSy4JKlezEtrRsSCh+BGB8
 Vq4jm0BBNZOGt+Vh9dYLKLhxY6jsQizB9zDRHPvcgWufO3vE1F0cVI1kVRzCQ0XSVYHB/FggXkT
 GnGnuA6JyBytGYGU0ZgO1hQAU+t7pvEXTB/C54wZQ8I49xRP0uiF0nfh8sRAD3XitXKJzuGQR10
 m7AmkXZu
X-Proofpoint-GUID: hEWxyvVupBajkHB3_WzS3m9IrbwxXT2X
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689f45ff cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IcmTHOqSNbDvJ54L4SUA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: hEWxyvVupBajkHB3_WzS3m9IrbwxXT2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

The reboot-mode driver does not have a strict requirement for
device-based registration. It primarily uses the device's of_node
to read mode-<cmd> properties and the device pointer for logging.

Remove the dependency on struct device and introduce support for
Device Tree (DT) node-based registration. This enables drivers
that are not associated with a struct device to leverage the
reboot-mode framework.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/reboot-mode.c | 37 ++++++++++++++++++++++++++-----------
 include/linux/reboot-mode.h       |  2 +-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 42bb99128ed3846d4bff62416dc31135ddeaeb90..9bb97bcd33cd3d58c75c791e9b568024e810e5b0 100644
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
 
@@ -75,17 +79,21 @@ static int reboot_mode_notify(struct notifier_block *this,
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
 	mutex_init(&reboot->rb_lock);
 
@@ -94,28 +102,28 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
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
 
@@ -129,8 +137,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	return 0;
 
 error:
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 
 	mutex_unlock(&reboot->rb_lock);
 	return ret;
@@ -144,12 +155,16 @@ EXPORT_SYMBOL_GPL(reboot_mode_register);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot)
 {
 	struct mode_info *info;
+	struct mode_info *next;
 
 	unregister_reboot_notifier(&reboot->reboot_notifier);
 
 	mutex_lock(&reboot->rb_lock);
-	list_for_each_entry(info, &reboot->head, list)
+	list_for_each_entry_safe(info, next, &reboot->head, list) {
+		list_del(&info->list);
 		kfree_const(info->mode);
+		kfree(info);
+	}
 	mutex_unlock(&reboot->rb_lock);
 
 	return 0;
@@ -178,7 +193,7 @@ int devm_reboot_mode_register(struct device *dev,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = reboot_mode_register(reboot);
+	rc = reboot_mode_register(reboot, reboot->dev->of_node);
 	if (rc) {
 		devres_free(dr);
 		return rc;
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index b73f80708197677db8dc2e43affc519782b7146e..98f68f95c9e8460be23282c51ef7fcbed73887bd 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -13,7 +13,7 @@ struct reboot_mode_driver {
 	struct mutex rb_lock;
 };
 
-int reboot_mode_register(struct reboot_mode_driver *reboot);
+int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *np);
 int reboot_mode_unregister(struct reboot_mode_driver *reboot);
 int devm_reboot_mode_register(struct device *dev,
 			      struct reboot_mode_driver *reboot);

-- 
2.34.1


