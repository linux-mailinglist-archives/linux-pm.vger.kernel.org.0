Return-Path: <linux-pm+bounces-35162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4022B9177A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 15:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5890F1798B2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B93101CD;
	Mon, 22 Sep 2025 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrmfMML3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DC30EF99
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548500; cv=none; b=dAINIPlOyvu05iUMm3UKa5Nn0KdbkQq6ZzMwzfrbBdk72R2iT19QBuNOvUjyu//7BLATE1xSXJEf5D6HOEwFD1U1dCSrVzMiyCSOus2ULT+GLgN5iIG90cyr720iMVT/nOqaPZQ8Ip+Jo+70emKS3N6usBrIZhKZ+m/+euAQ+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548500; c=relaxed/simple;
	bh=csuodKKOIftmMdPH0xW7mPcZsY63rR80pB6PrZ4SpoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INmC3gUb9DXAybwmQYO+mOHM8HbCFlQtE1YEf215CxnS/YkK0n0hVg0qtsI4JOknhjDjpg5Pkp1mLrX1O0TCSp2pBcADseK2nUJReYWx5kg6llJhDoi9JtoZhmeKXn/xgX3EoCiDUnwsoIcGm/062x0PEyNlMgvy+Z1+NGi78gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UrmfMML3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8iRoG007448
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PQ5CkjpDV5GdiBCvwUM/d/pADry2aOxsx1xtl/RbIcE=; b=UrmfMML3FdOErJQT
	DxUFr4j2GLejeXVvZiUlaUCkhytXodnETtRiL+9pbk3utln5iC6L4Q4iyX15bejt
	B18c6ENsWjgznAvPcYQo5ZkPo140bzXi5ERmbmqrvb+aN62HairdgCuJtbxU2HxA
	D7bl9VK+ZEOXrsBT58OKagLUKuINORDoYQT3taMDIfyluZuqasZHS3weTl+Dnwj5
	RE6NcpYVUlywYahsbeBB98nNAHBO1qMJ8IMYcxXHZL/p+O3xZ1p0RmXzB0rJHaa1
	sC3MVM7bo4q1Fp4rXH0ccVcPBFoFccsu2V8fQ4FeriHzKjCxG28JMBkUNZRDqRxs
	7zFjfQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyen62h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 13:41:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458274406so90500815ad.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 06:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548496; x=1759153296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQ5CkjpDV5GdiBCvwUM/d/pADry2aOxsx1xtl/RbIcE=;
        b=r6siMFbE+eUT/wYk2K/CTGDZx3FCAWJv7DW6I3bTfpsLXaxicxMzZ9ScmE8TorXlla
         iNJAAYPg01osxtRJBucfHaHC0HWyXJEUO5DijIHSzgv3Q0uQ2rsmDQ6zwGZlfQyvv1nT
         EDqAYTdsdQ+dM8f5V86eFU9/mVdKkaCapnkiCKAGV2YvCx0lditGgh2RMKFUsbDQMArT
         DAb+xzvC7BtTVGXzZMbNV00dS6WDNMjS316RhK1wMcULp5YktnWcv0o0iTkRzM1TEW3o
         TQkIlSjIy8AIt3q2MmCT1TY9pC72mXGgXgayFeIDTpS8cZZjxN4oEuZlnsSujCEoeLVW
         /2ng==
X-Forwarded-Encrypted: i=1; AJvYcCUgtKIrB4iKHkHrfI1EY+kW6SqFMPrZaUG8US81TJ+7fownuuUQSzjMIcW1wGivDdJoREizC33kvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpHBQJWYZH7cpYrpBZfZ0yLpWcLtdVbmRjKZOYH5xot5QmpLm
	Hn9j/vR9SeVMJQR1C/4abHLspd2mnIhiIuhIJSrKBYZ5z2BPJExY+jpTic2tozGWAq1DXhnr/LD
	2LLnsZ9YKHg3hQI1IBAaTKKDulDmJaKTkePUzNDr94SzNXCGm1TWeyZ+V/Di6uA==
X-Gm-Gg: ASbGnctdC7fDohnTuZQBjKOaLYLqOaXiP9nCWXM/jra5xMRziYbXpQXWm8VWEH8rhMy
	frAHUNp8fODDBZ3Z7qmuruhWxhOkBTrL5dNKwjAujZBq+tbDj+UInTJLP6uoqo3f36V/TCh268j
	1KmJiK8shGLPpdqoOXGa+3hVSwAX3m7xM4Opo9pROa7JYBwwPqvtY/+m0l5fTX+aEuRLqM/Xrnn
	fPKGsqxCTrOrkP8L+glsNQtvyGY+hmXXudtT4gHvnXPCl/Vg/HMvv0g4toxGOMB66cNvt2HNwWq
	czeGGdCo5J2OWQOs33QphkWcGrQvfm2vndbY00HXciHGVRmUDIS2h1b7U7wQrvwxi6yQXxr8xeA
	e
X-Received: by 2002:a17:903:183:b0:268:1623:f8ce with SMTP id d9443c01a7336-269ba40dccdmr148298415ad.10.1758548495723;
        Mon, 22 Sep 2025 06:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeYpL83hvZcT0ZSaAkASpo+P2NbTj4vkGQKYjOTOfv1/iaI/NLo1r5L5RQ2zZQ/05PnYOT5w==
X-Received: by 2002:a17:903:183:b0:268:1623:f8ce with SMTP id d9443c01a7336-269ba40dccdmr148298045ad.10.1758548495287;
        Mon, 22 Sep 2025 06:41:35 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:41:34 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:17 +0530
Subject: [PATCH v15 07/14] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-7-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=6219;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=csuodKKOIftmMdPH0xW7mPcZsY63rR80pB6PrZ4SpoM=;
 b=C1BsyRmsmmPO4kKpen0/8UPvJNM55hRlZuhyu19tdHSZW4BLLJnL5P6opj0haHTxaIoKilW1Z
 QVdD+Ga9tSwDm0AWXam0oX1WFBFPV3xbTtY6gKbVWC4Ygr6NRRGiXJV
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: hTFA01Duh9VfBA6Y-HCgb_wmDUnJHbqN
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d15212 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1Y-8vuCXXADn_sFn8ogA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXxGN5trrthnp1
 ZISCDMPXuufkUFBLvlJ74DihY/47Z/AZWzkIXwrEVor1M5M+6pHTr46oYDqXdYiP6lm9fyKzfet
 yUK9ZQ829MNX1LIhZl2TR2FPh9bOMQi4u5cnEuHVJ3pSyAxKVZ71xIh80+9toKBKv6Oc0DTjqSN
 B5T00ivjbhz4grMnepp8nZ7yH7KDq1ww4Jw6s+N9jUsV4N9erZZyzSzKwI3UBJLwdaUFkc3zZTY
 eKRQ+eoVJF0P6moqe2si8bB5G0a0QK/usG7b3TkP1hVKu2ZbqI/JlhpB2T+HmDr62UG9IW0IhXy
 hFbhkvlNVh7eVp+KDmsTj99xOUX6gu/O2Kft4jTmcu7qUyW6RiVNgDJI7wqX586nF1IkLpaYmow
 3+dZvPYR
X-Proofpoint-ORIG-GUID: hTFA01Duh9VfBA6Y-HCgb_wmDUnJHbqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

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

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/Kconfig |  2 +
 drivers/firmware/psci/psci.c  | 89 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

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
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..40a27bc2cc3a3393acc14c7b2314155540ed06c9 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -13,10 +13,12 @@
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
 
@@ -51,6 +53,24 @@ static int resident_cpu = -1;
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
@@ -309,7 +329,10 @@ static int get_set_conduit_method(const struct device_node *np)
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
@@ -547,6 +570,70 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };
 
+static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
+{
+	u32 magic_32;
+
+	if (psci_system_reset2_supported) {
+		magic_32 = magic & 0xffffffff;
+		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic_32;
+		vendor_reset.cookie = (magic >> 32) & 0xffffffff;
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


