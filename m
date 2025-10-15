Return-Path: <linux-pm+bounces-36116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2523BDC814
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB66218A7697
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE22FF171;
	Wed, 15 Oct 2025 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNQA2pX2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04892F7AB0
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503185; cv=none; b=eQbf/M8xgeWxgYccWR6BZn+DCRm+S4FyQ0ebzJeEJ+gPmqWvwbYYDXit8OK4RWbUm67WQtENKXekBCRMEWQ8iJqd7rMnMEMwue4n6zL1Y1GyBvbDxBujR/BBgMbd7OOGOHwhSf4ACpB6mXBnx9/ssjQ85h+oFpRGzKM0Rj4uQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503185; c=relaxed/simple;
	bh=mujdORVMR0YarIWF+tp2a2NDsOcx2HXXqSZCJYJwx5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBKfXjdQEMLM6JBR/GdD2zNqfzmO6aRLPR9k90WPnuAGxJQjzgOw1LBlIekbk7wKyoQyoktUG0pwiZ8l7quQUv5UbyQFSf/vKUomr/jkWJLta1jqsNEmAfkwA+N3PBPCglzguIs+17L7bTARe3E+jYOFNWjXy6+eweXz0UkyWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oNQA2pX2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sX5p016057
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+Slv6Z73CYGuBFbnhI24GFvm6YLUmIexclaD/f6th0=; b=oNQA2pX2gZel9qJD
	icgDauj7caaXue7+WVIzCwb8+WZ5TrdMIIOSEoASY7HN674SufIVV9D4IvE4+Fon
	Hvb0iMhLU3iGLyCFTWQo1dvRbgg/m21pWml2R6gtCys+DcoXTzReCl5Wy6yxC/wa
	fV585H7uzxXcSCBiRKhGF+RQ1yEuhWtmCa+7mPAYm9q7yXzbq/Pah9FxtPvk1xNd
	5NYdh9ewmfTVLDxmAAtfU/NTR/TywPxUcQa3uQUHO8qWDswSQ7p/KbuSGJmdl6G1
	/3RHkKwUFR+PJfzwwQpFjvIEUG/PbwNWN8Z1rh+56ZAkeus19c0MRRIz1S+Ynjrt
	q+sRFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5k5fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:39:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33274f8ff7cso14168930a91.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503181; x=1761107981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+Slv6Z73CYGuBFbnhI24GFvm6YLUmIexclaD/f6th0=;
        b=tiDys9rHkL8sPO3gbN/7QlbRFEcsrgc172QtfoAal1br2VUFmupX70TOaiNMOK5vLM
         AECgUbVulA3jT0aTqSlKQEY1UuAFLvg3AmS36z7D0+9y/Tdfpm4/6aOuFiFSIlp43x2y
         xZ4bj+DpwccujR+vvmIlKcwPHkKjY/4cRpangaadM1qQ+UH3kkKLjZI2C5BaknKMg5hK
         s/6pMX9COYJn/3BOopOeKL3Nc5Lm5XvxMp014JF5iTdc8ryk5bl/YPxEMWyjNfRr8ZRR
         113Hcc7AvuOGkFDsBCJMEAGUhr6oMj+tQH5m1wG+76gK+yvrYwo0zN5RMzxrGvXH/v0M
         RgzA==
X-Forwarded-Encrypted: i=1; AJvYcCVR8mUQmp0PRf6XA4OeiqTAgkCmIn/h0UQEp8Cd0B9mLTtYN7FU4Zsr1OZibQhhpc+Wc8TOzOrpWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzND/NYdglvqawyB3+xC6lNpXc5f8oluXo7lpG5XJEX+IrVq/cw
	RuRXydgsP4xRcaj3cWz3P2RKGTWT9SpvO3w7BcmZS20zBMOBuBvVG01zdjwtZOL6Eglbm0dxRSX
	bT6bav53c793nXUwOofCJ3HSBok5z6LCrABYkKRYR3FDPkueLGZSLNEftO6VM2g==
X-Gm-Gg: ASbGncszsDuSHhFX67+yUfxl/kZ5epyR7xWeGqWJ8rE79IHKgwYM0Mer4kSCyutaIUP
	kBfzWAY4OZpqyW3fAwwmzhCK8ZkC7BnaUIXEff4KRxhf4ZQSJFcbtVn2BodhdyH5VJkjT0Bjo5Z
	7mvMYnz4DaH0HHKFBJcLbMGrk56X2yCYOufZZk3ffIrQR8eCDOVaUXK+Jra3r6Q/CDsgCOs4ggJ
	LGlSmX6tJ0ftlMGsfgiGI5gohULxkWOBfRtNHZEg75eatKNG1BnPvXkz6c9dRuUfncJt+voQtID
	shdNSk1rCUXgZtYptk7lzNERijIaGqE00yKMTnnuPAWf6dWWbGOlEGgXjXqndXYHkDH15IxFqmY
	4
X-Received: by 2002:a17:90b:3b8d:b0:332:5349:279 with SMTP id 98e67ed59e1d1-33b51148b30mr37048923a91.3.1760503181217;
        Tue, 14 Oct 2025 21:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBw65NlxBKWvgcFdfd4dOvK6U24Nofemaxqj65Y+NgroOTNJyTNGRj5Csi0CXUY+t5xFilOg==
X-Received: by 2002:a17:90b:3b8d:b0:332:5349:279 with SMTP id 98e67ed59e1d1-33b51148b30mr37048876a91.3.1760503180700;
        Tue, 14 Oct 2025 21:39:40 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:40 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:22 +0530
Subject: [PATCH v16 07/14] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-7-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=6511;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=mujdORVMR0YarIWF+tp2a2NDsOcx2HXXqSZCJYJwx5c=;
 b=p6iM2MrWS5PEsHbQ61Zs5nOtL9wTJJ1jfj/KcIZz8/n2ynAp2Pi6XLpRplO9DnBDEHSiqFwR2
 OnvsABBfO+fCnrHClY+YB8XOrU0Ut5pN5Xw74G1jKzTxY7wykeQPstd
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: OeBZA7-kk4PKpu5cL1vSLHrlR88geEdT
X-Proofpoint-ORIG-GUID: OeBZA7-kk4PKpu5cL1vSLHrlR88geEdT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX3JnDAPioYW1a
 k3ilTVKrIDXt3Ob0Ry9Dr+0o/xgDfcseFsKV1vgn04KLykgOuJqHpUYxsUU6UyMEeYT+YPI9CnJ
 NTK7bt2j1C7k+14V+KaO1fXOZE7LrCLdGNG3Dsw/mbSo/a3fUqKTpef1Si2wqnPOf7Ej5bKqUj4
 s3ovTUyBAYPWcIscHFAKNiaGonNMphZFUWDKJK7ixdK9MmTY7VQBPZtPPkCmzHoO9mkXuYxREqc
 cUr1ec7pzzF9mQkL9QXNdYVKtDq80bVYAYhbLyRusdNEs+yUUwa05P64enu+kZGgcuiNlfE7acB
 uZpYgHezsCvE4HixT9k6SfxzPyKUsFbZuf0l7RPIBJS+7lex4b4zwBQOSh/39PDvu9W7Ouzk+ge
 TF3mcvKvhyb55+6G2D186frcDrFWVQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ef258e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=1Y-8vuCXXADn_sFn8ogA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

SoC vendors have different types of resets which are controlled
through various hardware registers. For instance, Qualcomm SoC
may have a requirement that reboot with “bootloader” command
should reboot the device to bootloader flashing mode and reboot
with “edl” should reboot the device into Emergency flashing mode.
Setting up such reboots on Qualcomm devices can be inconsistent
across SoC platforms and may require setting different HW
registers, where some of these registers may not be accessible to
HLOS. These knobs evolve over product generations and require
more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
reset which can help align this requirement. Add support for PSCI
SYSTEM_RESET2, vendor-specific resets and align the implementation
to allow user-space initiated reboots to trigger these resets.

Implement the PSCI vendor-specific resets by registering to the
reboot-mode framework. As psci init is done at early kernel init,
reboot-mode registration cannot be done at the time of psci init.
This is because reboot-mode creates a “reboot-mode” class for
exposing sysfs, which can fail at early kernel init. To overcome
this, introduce a late_initcall to register PSCI vendor-specific
resets as reboot modes. Implement a reboot-mode write function
that sets reset_type and cookie values during the reboot notifier
callback.  Introduce a firmware-based call for SYSTEM_RESET2
vendor-specific reset in the psci_sys_reset path, using
reset_type and cookie if supported by secure firmware. Register a
panic notifier and clear vendor_reset valid status during panic.
This is needed for any kernel panic that occurs post
reboot_notifiers.

By using the above implementation, userspace will be able to issue
such resets using the reboot() system call with the "*arg"
parameter as a string based command. The commands can be defined
in PSCI device tree node under “reboot-mode” and are based on the
reboot-mode based commands.

Reviewed-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
Reviewed-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/Kconfig |  2 +
 drivers/firmware/psci/psci.c  | 90 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..93ff7b071a0c364a376699733e6bc5654d56a17f 100644
--- a/drivers/firmware/psci/Kconfig
+++ b/drivers/firmware/psci/Kconfig
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARM_PSCI_FW
 	bool
+	select POWER_RESET
+	select REBOOT_MODE
 
 config ARM_PSCI_CHECKER
 	bool "ARM PSCI checker"
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..771e164d6649f15a1f8f5ba999a24f5c04110932 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -8,15 +8,18 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/bitops.h>
 #include <linux/cpuidle.h>
 #include <linux/debugfs.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
+#include <linux/panic_notifier.h>
 #include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
+#include <linux/reboot-mode.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -51,6 +54,24 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+struct psci_vendor_sysreset2 {
+	u32 reset_type;
+	u32 cookie;
+	bool valid;
+};
+
+static struct psci_vendor_sysreset2 vendor_reset;
+
+static int psci_panic_event(struct notifier_block *nb, unsigned long v, void *p)
+{
+	vendor_reset.valid = false;
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psci_panic_block = {
+	.notifier_call = psci_panic_event
+};
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -309,7 +330,10 @@ static int get_set_conduit_method(const struct device_node *np)
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
-	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
+	if (vendor_reset.valid && psci_system_reset2_supported) {
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
+			       vendor_reset.cookie, 0);
+	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
 		 * reset_type[31] = 0 (architectural)
@@ -547,6 +571,70 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };
 
+static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
+{
+	u32 magic_32;
+
+	if (psci_system_reset2_supported) {
+		magic_32 = magic & GENMASK(31, 0);
+		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
+		vendor_reset.cookie = (magic >> 32) & GENMASK(31, 0);
+		vendor_reset.valid = true;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int __init psci_init_vendor_reset(void)
+{
+	struct reboot_mode_driver *reboot;
+	struct device_node *psci_np;
+	struct device_node *np;
+	int ret;
+
+	if (!psci_system_reset2_supported)
+		return -EINVAL;
+
+	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
+	if (!psci_np)
+		return -ENODEV;
+
+	np = of_find_node_by_name(psci_np, "reboot-mode");
+	if (!np) {
+		of_node_put(psci_np);
+		return -ENODEV;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
+	if (ret)
+		goto err_notifier;
+
+	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
+	if (!reboot) {
+		ret = -ENOMEM;
+		goto err_kzalloc;
+	}
+
+	reboot->write = psci_set_vendor_sys_reset2;
+	reboot->driver_name = "psci";
+
+	ret = reboot_mode_register(reboot, of_fwnode_handle(np));
+	if (ret)
+		goto err_register;
+
+	return 0;
+
+err_register:
+	kfree(reboot);
+err_kzalloc:
+	atomic_notifier_chain_unregister(&panic_notifier_list, &psci_panic_block);
+err_notifier:
+	of_node_put(psci_np);
+	of_node_put(np);
+	return ret;
+}
+late_initcall(psci_init_vendor_reset)
+
 static void __init psci_init_system_reset2(void)
 {
 	int ret;

-- 
2.34.1


