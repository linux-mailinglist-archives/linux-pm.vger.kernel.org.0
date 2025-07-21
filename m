Return-Path: <linux-pm+bounces-31228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E956B0CA79
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2171C219EC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656142E2663;
	Mon, 21 Jul 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaLj7WZq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C22E1738
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122567; cv=none; b=nS4Q4JahIUPEB56Mq8Yh8ZHJnzq4k/V07qSQI7Xbh+aXTInGFRS7XvMam2F31hgkF7R3SJD4eUhVXPmY7DGAgZ0hTx7WAPUKT0VbrOAJEJUmkZXdTSzC7ryRVeoyAw9T0teqi22d1aTkMP2llGr0NOw+/IUiYeWFtxlR1Yh5Mc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122567; c=relaxed/simple;
	bh=DBN6sGXRUVDpd7vqCXSG71Zl1opGNwqmNgNJo0YmBCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6qUZIkrejAN7/2y9oPIwxc4yoRTNiCKiFZjgWUrZg04aYj60i1irOZOrOMqmdeCFQi23lC8azA2D/gmt0zL4OXuyJ0XcyNYfLeju7s3ScxO/ABLrmSDF0G2rol3r2KDSIT+RV31G4PdX8Rzzutl1sBF8nvwuifOuoeSeveSON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaLj7WZq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGg5nZ005532
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	12+JhUW7UCD4bGTJEyOuS62N8dw9v5aLX1IdtuqMxic=; b=iaLj7WZqcuEZrYAP
	gP3J2/3cfqhfT9rP/S1IxIZZi4HcSR4xvtBYn4t8J0jgP0EDzFlOeRwS3qWdKW09
	eYSNoSM88tHsZtx5Cp0/pm9/eWZtPs87iIo8atfc7AdoPwuU2/koSGUgzoreyor/
	/OiqNdyKJ4Sp8CG8s614/yK6qQVNrCmcnrrc2VumaxewG+Iz6V/7MwKXAmS9wjF8
	vA5bT3KirgfK8FURcMify03vG+6sN8Kw3k4Yd/eL8X87Lyy7R3Zn5mIPkso7hxdf
	/8ut3G8RUa2RsTA8nEkOx0eJTwtn+19Gd6OkYUeimOE/o7rz8pxEsvKVUOVL4knA
	LglsoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q6v14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 18:29:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-237e6963f70so74913755ad.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 11:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122563; x=1753727363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12+JhUW7UCD4bGTJEyOuS62N8dw9v5aLX1IdtuqMxic=;
        b=S+H9XjTvHHqGkiGGipYq/o1t3pq6mTAdatGrlI2snAXagNmiayizJ6pbemCBe6bewF
         5Hr8EpiVIYPvggZkTl053LGVyj+3yJRtFs61DKls2eok5jst0aJlSLxZb586knKSzBgX
         Ka5isUASohCTNV2keBM3meVTpK9OuBe60T7WvW0VguWVTlVMxTFrvGiLtv5Fn6LfXqbv
         LKfn/X/gDeYKLXeukQ+quBZYTX8BFBEWKMHUZ9PFCryrClhRNPJzS6Ja6dJ/3ZhsYQph
         fWN9aLCgzbr9b0ADfW1uvEXudTIXxe7biCmfJD1ke1cwHivDQ9v24HC44DnHPYsIH2QC
         AsSA==
X-Forwarded-Encrypted: i=1; AJvYcCVu3+ep8O5xEnALQGQtZKPIh38hxhjrVI/8ZbaXJsODk93futPSXrtvrwKR4aDM/48b/wEOWvMOYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk8qb3VOxcM66yN7jdtnMyX+kMgTx+9WsUkhrduKra2OV1+gG
	g9JsihNgWMJYOUaaZy2DSKmwQwrQKbaWegByH7q/VY5r9xFcMv/u8r9RcCDA9bk4wP1/TFPmEFo
	HOeG84GZtcNSM/S0+EKJPw7Tecjc9/tyBwAj+5GX52afuFjSOPq3iG4jsVLSFbQ==
X-Gm-Gg: ASbGnctFl/9zEJ+L/JdznsCCtBFWavLtCGhNoQRR1mV29iwIU4uKPzrhs8QigDVdsKr
	HX1i+6ExGCjHwNfBjGgm9Bx5UeAj4wBVoNBfdYCqfwQu7aXPbpJ1qsKmy8aKzyWxlZfQZmuDiPB
	1Xn4eCxdnjc/JIEH+3E5J+CyQ0kjuY79UjCPsjAtk+R/miONffI7HUmU5+/lQ6TOuQWXP+Ndp8b
	98I89cd+lKBtsAM1Vxi9yfIpO7NtKD6nL1SiGdU4llSKVhpQkf1Jjx86Ar+51EOHPfha1uq283X
	degJAmYhs59/cZJtjESQVitkh4wxCyuXhRPAeBs0myVSWEEwBn1yqO6ElmTt3lmY1bkKKE6aLqy
	0
X-Received: by 2002:a17:902:e848:b0:23d:d348:4567 with SMTP id d9443c01a7336-23e302bed21mr232781035ad.19.1753122562750;
        Mon, 21 Jul 2025 11:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdol/SpmgrRISFDHgOMwYJFgwvsPFVeex1hB/4yuIO2bTcUrO01dBTuiyWXMA2+1WINN2eUA==
X-Received: by 2002:a17:902:e848:b0:23d:d348:4567 with SMTP id d9443c01a7336-23e302bed21mr232780645ad.19.1753122562167;
        Mon, 21 Jul 2025 11:29:22 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef4b8sm61414545ad.194.2025.07.21.11.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:29:21 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 23:58:49 +0530
Subject: [PATCH v12 2/8] power: reset: reboot-mode: Add support for 64 bit
 magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-arm-psci-system_reset2-vendor-reboots-v12-2-87bac3ec422e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753122539; l=6942;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=DBN6sGXRUVDpd7vqCXSG71Zl1opGNwqmNgNJo0YmBCw=;
 b=uthIovqgz1rMdV4O6xqp1c1Lo2davyxxmHP0SgklsKRbeQH8BbaMQebhR1bZ4i5Nf/1G5rwvl
 iPXmBxueTjHATm68va0+MbN1O3gmpMrXn/u2oHEr2IYgJbFrkBz7krn
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2NCBTYWx0ZWRfX0qcbJP9T2pql
 UCm303lKzLsAzPNh8F5td/+itnWK76UeZ+94cT/PRkZIgnWtvAUXOzotDd/fboGpyrHvpYqLkzK
 i3tMWjn9mm1po89eXtZroiDnKWx96moBg+2mGPRmkyvsqK1FP+n/N8rZ55qFDjWd3BUUCm8Ff2e
 IAKobnBvsNF1Ilje9+hPYidLrt2w7ctFyQTd3c2Is5R5x4A1vRAhrjnMxM6G5bgg2emInXP0mhB
 0X0rpNx83Y54U0obei47Qt1oCXSG0gBB7HS4HIYvxAKhx5TaKIvqihLnnXGgczQxk3ECGIMIrM5
 8jaqsbLitdOr+FQDsR9jAvxYYeZrmHnJMHthemGhoVaWqkkJl3HBwoWv1RQGRc1rraOQTeZ2EUR
 2NQqKgPDVscPguKwrwWm/tQ5M/vTkOuJeTGsBEgk9gHc2jGLIhynQXiNMylA3hXkdwnHJJZg
X-Proofpoint-ORIG-GUID: T3iiqApP00Jsa7du5wBk6bq-yd3LKERS
X-Proofpoint-GUID: T3iiqApP00Jsa7du5wBk6bq-yd3LKERS
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687e8704 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=bqVjg2-MoX4cBg1ZSeQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210164

Current reboot-mode supports a single 32-bit argument for any
supported mode. Some reboot-mode based drivers may require
passing two independent 32-bit arguments during a reboot
sequence, for uses-cases, where a mode requires an additional
argument. Such drivers may not be able to use the reboot-mode
driver. For example, ARM PSCI vendor-specific resets, need two
arguments for its operation – reset_type and cookie, to complete
the reset operation. If a driver wants to implement this
firmware-based reset, it cannot use reboot-mode framework.

Introduce 64-bit magic values in reboot-mode driver to
accommodate dual 32-bit arguments when specified via device tree.
In cases, where no second argument is passed from device tree,
keep the upper 32-bit of magic un-changed(0) to maintain backward
compatibility.

Update the current drivers using reboot-mode for a 64-bit magic
value.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  | 13 +++++++++----
 drivers/power/reset/qcom-pon.c           | 11 ++++++++---
 drivers/power/reset/reboot-mode.c        | 19 +++++++++++++------
 drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
 include/linux/reboot-mode.h              |  3 ++-
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index 41530b70cfc48c2a83fbbd96f523d5816960a0d1..5d73dde585b1fd438b1847f884feb37cd9e4dd5c 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -16,15 +16,20 @@ struct nvmem_reboot_mode {
 	struct nvmem_cell *cell;
 };
 
-static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
-	int ret;
 	struct nvmem_reboot_mode *nvmem_rbm;
+	u32 magic_32;
+	int ret;
+
+	if (magic > U32_MAX)
+		return -EINVAL;
+
+	magic_32 = magic;
 
 	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
+	ret = nvmem_cell_write(nvmem_rbm->cell, &magic_32, sizeof(magic_32));
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582e8243c5c806bd4a793646b87189f..d0ed9431a02313a7bbaa93743c16fa1ae713ddfe 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -27,17 +27,22 @@ struct qcom_pon {
 	long reason_shift;
 };
 
-static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct qcom_pon *pon = container_of
 			(reboot, struct qcom_pon, reboot_mode);
+	u32 magic_32;
 	int ret;
 
+	if (magic > U32_MAX || (magic << pon->reason_shift) > U32_MAX)
+		return -EINVAL;
+
+	magic_32 = magic << pon->reason_shift;
+
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
-				 magic << pon->reason_shift);
+				 magic_32);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index 5dd3f06ca88cb28606d9fd2100ce03383c14d215..a17851a303171fd04a47e240f80687541cc85a24 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -19,12 +19,11 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u64 magic;
 	struct list_head list;
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -56,7 +55,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	u64 magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
 	mutex_lock(&reboot->rb_lock);
@@ -81,6 +80,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	struct mode_info *next;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
+	u32 magic_arg1;
+	u32 magic_arg2;
 	int ret;
 
 	if (!np)
@@ -100,12 +101,18 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 			goto error;
 		}
 
-		if (of_property_read_u32(np, prop->name, &info->magic)) {
-			pr_err("reboot mode %s without magic number\n", info->mode);
+		if (of_property_read_u32(np, prop->name, &magic_arg1)) {
+			pr_err("reboot mode without magic number\n");
 			kfree(info);
 			continue;
 		}
 
+		if (of_property_read_u32_index(np, prop->name, 1, &magic_arg2))
+			magic_arg2 = 0;
+
+		info->magic = magic_arg2;
+		info->magic = (info->magic << 32) | magic_arg1;
+
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..3cbd000c512239b12ec51987e900d260540a9dea 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -20,16 +20,21 @@ struct syscon_reboot_mode {
 	u32 mask;
 };
 
-static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct syscon_reboot_mode *syscon_rbm;
+	u32 magic_32;
 	int ret;
 
+	if (magic > U32_MAX)
+		return -EINVAL;
+
+	magic_32 = magic;
+
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
-				 syscon_rbm->mask, magic);
+				 syscon_rbm->mask, magic_32);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 98f68f95c9e8460be23282c51ef7fcbed73887bd..370228b5161963aac1d75af752ada0e8282b1078 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -3,11 +3,12 @@
 #define __REBOOT_MODE_H__
 
 #include <linux/mutex.h>
+#include <linux/types.h>
 
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
-	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 	/*Protects access to reboot mode list*/
 	struct mutex rb_lock;

-- 
2.34.1


