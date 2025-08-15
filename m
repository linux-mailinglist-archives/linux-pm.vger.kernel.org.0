Return-Path: <linux-pm+bounces-32439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3892B281FC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D23A5E088F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E61623D286;
	Fri, 15 Aug 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o9l+JPgq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279B21C9E7
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268616; cv=none; b=BBHFAJvMw38+1eUslTN72CVedaxTSN/KuVWwcjAPM01TIOpGQNziS+hOdGeig6wDLYAEr/kUhlNdo+5VWRnTMcp3SKILlF/eIZ0nnztZuV+OWbNVLGJuKObZup4abBfLcD7xTuGUn+b0mGdHK2IukqpNo6ZPlqw+WxB22V4mBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268616; c=relaxed/simple;
	bh=RHatRDIyZlkowVAM219pHMxjJ5gZoVq6CrecsaGvXwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKk9GY7ibyNK+dhl9FrhmOi/8r98MTLLiPx21+BDdBinZ/TgJaLHgh7dvwvIK/q72jEFC+O15JE0Hfh8lIwLUt0gR5SkD8ZRgWcDd8IcyVttMkYp9Hl06WjTKiXI8nDIIadNzsnqw2Z3tOwJe5JfM7cd70ka7OG2tfalqrZiTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o9l+JPgq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEJE8d027558
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nz/boegyCEkxuIz7kRr7NgSo8XrC5KjpUvLZlqKGYvs=; b=o9l+JPgqVevviFZf
	7h8ErX3zGgmrd+xazm9yhFlsTZDt9jRsBvDz4YsPdnKyEUQu3Ko3h9uluDMQaVVQ
	0w/F23gOQCRNbpsVMVCPEfjWjIHMxEZ2uVJm17/LdWS8EvjQN91fOaZqJgXDQuZl
	4TU9nwH3pG+oX+WEPDXgXwa5S/AfLh//HWYFUE7NdFpM71y+g476MRaJGT8/e7Jy
	mYd0WJ2mJZOUDpVrfBc2s7eIV5eLC5L5LJGKbenm+RqmSAl5ngMfO3pe5vTkNxHL
	X2IrfDfJaoT//jJsa12zJ5htSlY88pqxJfTkPLTNq9PVkRncRwAde2cnM4ORGrJ5
	RLQPLA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9t3g29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 14:36:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323267858edso2107642a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 07:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268614; x=1755873414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nz/boegyCEkxuIz7kRr7NgSo8XrC5KjpUvLZlqKGYvs=;
        b=flk2+jar6kpc0D19fv6axWC4gOd+vUoxYbO2tZDnOMSoMxhlUmxtFksKe60BJ50NO8
         Yp0nEH3KD70B4B+mCEQuw4fLDWbM85ZFR1Jg+tkWmAo0UBBcPsypXXZq9QMXK4XfjZ2o
         DS2WVnF07uYMcIEGeiSKduDxxggXEdv2bST09OpmgAKe1Q6mZ9wW1I+LqGrv9lxt+zce
         Szoct+J60z/lB4fCXCp6jqaTY8xhiRyWSk4HjP9yoyVvbYHjUF4TJBjNqZhGwpRe5J2T
         APVDWDfzGcaEvQt+M6076Y7b6xC7u9SDoLZNoY6w9Nl3fcP1wsoz+f32MKwJkk2eEzLI
         Zg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl3Mo1yUGj6tYG/59XdoY4Vt84h28gv/PUciTloB/cwIDT3vw8haz2LUx3eizwB0dpwiSYpHBrrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOQQdYM4YrdtM8IYPg51GnxoyfjSO0eboMvgb73L1h99f8w0h
	djI1akAwcETr4xvxn1Fogb44qUMjjECxH2wu8jHq22Y2knZVQ9FIk4UumjCwucKdLdEzm2BAWP9
	5eQF7jI0+R9yxGL2gtXh59UDM2outhEtnzMACQ31lwz/bF5DBlGuPYRCKjUr8+A==
X-Gm-Gg: ASbGncsmpricAt8Qxk9ltRct52iD3FrAWoPjCvwLaX05fM1/CHmiobwNpvzoFn74j9a
	Qad8qxiyjFz11ZCOvz6gdpK7vnldri0i2GafY8Fr8lij4+ReLj8uF2HdFIwsNczH3ptoKF7QxyU
	0Lgdw5FyIGHW0xXRyVK0yzWbXPBM/8K8K32+9DKZj8Cu8mcUb8EOBijH3xQzSfa03PME++19TRL
	kXww18d2J/Dk3ZoI932Vh3eJlWr1gQSY4hMwaR4iNA/Ua/3fegbq/W9mpLV4+RSz3himcaIZsfY
	QrmS/X/bbfXUTg0Yq05uGmdqS1+5mAII4RRpFn4EdfKo+LbcwnNDeQFDtdJQhAe+nvpm/aR4V4c
	Y
X-Received: by 2002:a17:90b:2d4e:b0:321:157a:ee73 with SMTP id 98e67ed59e1d1-32341e12d67mr3916414a91.6.1755268613477;
        Fri, 15 Aug 2025 07:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj835wE+DH1Bq5Gb7SwvlsRfgqjTmxMNFT2lHi97z0/St0F54cIRT60UpOAXEzfTFojVrzMw==
X-Received: by 2002:a17:90b:2d4e:b0:321:157a:ee73 with SMTP id 98e67ed59e1d1-32341e12d67mr3916341a91.6.1755268612916;
        Fri, 15 Aug 2025 07:36:52 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:36:52 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:08 +0530
Subject: [PATCH v14 03/10] power: reset: reboot-mode: Add support for 64
 bit magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-3-37d29f59ac9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=6956;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=RHatRDIyZlkowVAM219pHMxjJ5gZoVq6CrecsaGvXwc=;
 b=KeKthTtaeCctuQ5sIvZNIc3NH+m5E9prhiXDQPj7r2yZsLv9zM6Td/2W/u4clW7QOvHnGfH3u
 zYfoe8If4sJBfB4nhnSm6KdYLNV8APXtDp9dd5jFoRhk+ZZt7gklgo8
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689f4606 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bqVjg2-MoX4cBg1ZSeQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 2hbUW5zmDM8FkjHOavKxGx8Hw-gkCmV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX7/qThOhMpSca
 crinPq1saUD582HZy38oB8ot+459xz9Svp6/R3fMcWlMjPrbJceM5PlW7g2xixdPkWT7h5eeg6P
 CentZU4a3St5ldZQEDJTGG4X2RGGKpFqfaQv3kqhd3PF2WsuiM1/6rFiMQtTorZA0LUK5PPuGXy
 sedXJcn8YycDKWD9OJVxoN3OteUWN6KBBPZ5ROO2k3oMdYZD5YbhU+GLP9MQ0O8kLWXeID+QmcN
 G0OWxTQq1RDbj2KT6Y9XK+7krdgIv4M4wyf51pi3iMcAbr7Tch8G3nzYCTS8sN0fdvpMZwrO/7J
 OLwJHlbzSWbDcoVwYz2RcoQ2RuJhvkGLSAmF5doGnq/pvLtfr3QRhj8+R8FnnujOK3YU8ibhusK
 KNVVrgSn
X-Proofpoint-GUID: 2hbUW5zmDM8FkjHOavKxGx8Hw-gkCmV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

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
index 9bb97bcd33cd3d58c75c791e9b568024e810e5b0..ac81b8b0a9b7fc31f8ef21024333a050087ce90f 100644
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
@@ -66,7 +65,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	u64 magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
 	magic = get_reboot_mode_magic(reboot, cmd);
@@ -89,6 +88,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
 	struct mode_info *next;
 	struct property *prop;
 	size_t len = strlen(PREFIX);
+	u32 magic_arg1;
+	u32 magic_arg2;
 	int ret;
 
 	if (!np)
@@ -108,12 +109,18 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct device_node *
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


