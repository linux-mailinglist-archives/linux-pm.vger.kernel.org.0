Return-Path: <linux-pm+bounces-37686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBAC440B8
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB234739B
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253E2FF670;
	Sun,  9 Nov 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbiVJZUi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVsQdTd6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37D2FF166
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699149; cv=none; b=Sehkgu/TCv8BerZh/aS1rKbq6UBQGXR+eggK+I1JwrZBpH+dhg3shPECQPKje2tdyvyfomeUWky20yY2sutHLjjYLS3NPa4PpvuDJRGYN08MsgpTyXJy8YoR8rZtZG59K8a8RW/Whlxwb5ON30pu/aY/JVdfCE3yv25kTAnZUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699149; c=relaxed/simple;
	bh=gOqHkjWgXv2eEhKUz/L3I9ntPxQxM5L+0g6CBUJNCec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XdA1EQe0C5SPirmgHYFyHlFMMdiblZm3liTf7wq6+9A21I6GcidMjPVJm2yCD7YmlU3wsLn/2eI40JndzeUialuxo/Vjyct1q0/VfZijdWVY1JwMdj2WpbYGSeskbPQun4ZgT/USjPtU9oJsXlFSwnIp64VIVaDUu/3Jv2K+Q4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbiVJZUi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hVsQdTd6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A99cLn1275435
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WbnFer6ISvtTqu+4JwESaso5mdco91wCeNffONil714=; b=BbiVJZUilltEG8Zc
	zmeH5i0vVOBoNszLCBD+ywS+JOkyzqGKzC9CKLGZcX8UtHhIIU/96uZnxyccgB50
	Qap65XzJST1hRFANY2I+lFfNSyQVBfwH8tVJktlMWdfGLFk4SLPtvuXUTkl1uwV1
	yp5z50RTpfju9/Iv4rQMXpq+DUjkvAvIndzAedaEDpsJV6qaYP2hYvJ5dDJOmJe8
	8vyz/aKX9Z381xUf+YZmwFa+Wqkwql/Wbm+m0hAM4eup0tU4Bvrgcd7ZpM1ThXNh
	LPcUZP3jhn/kpo/q2nubUjtMgYX9PFVfR9DMLcDIwVy/Fpx3swEFKiMCGCgKAVnQ
	BlxHuQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuej7w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:39:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3437863d0easo732433a91.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699146; x=1763303946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbnFer6ISvtTqu+4JwESaso5mdco91wCeNffONil714=;
        b=hVsQdTd6220shS/D2Pvg0l14wxhyVe1dqKPVgzfK7c5WWukdR/4pBA3R78mAz+ZU4C
         YNpxJqgIK0DQzyKwI+K1ZywHMcvK+zrwBsUXhRJIig2l39aqJvBsKwf26dwC0Cll/0ok
         5X3PumURCtZz/zy6+1l2jNlLV0IIdukO+cfZGjoCM8XwmHUHVjSQYYUowE06HffnM2+w
         ecX4GlyE2lANqspgeW7m+s28RCjOsMAQiX9P34t9heOHVP+PU5u9Ws/D/UEWbi5jV55z
         MBi+CYlKI6SZjlGT2AcUnRc67/KFDgoGAkrZKxmK5BZhvIXIbciDJVDJskYC/w9L9VKY
         7e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699146; x=1763303946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WbnFer6ISvtTqu+4JwESaso5mdco91wCeNffONil714=;
        b=itxnu4IlVxmfBPV4Zfws8E7+hg2XvlWrN/Fhh1TnEtzdv//H+nIudPUUC386kAd5vQ
         LCYufAGVtV6P8WTQuCJ+78KOkBoSUg3HpRqJmuMRF58pKSM3PsZaQc9dhkrg4F8+bhBq
         HsBqWcN8d0WX/2ZOTPAxMB9vhYrh+0U10zyUPQItQvYcFVm7Df6oHVTWjJ1sRToRx7re
         U0e0sm0yAlZsDbt/agF6Tiu71thRcLVIszzgZlylJHMLKh4ehNOW75Zidu0MYeoyvzE7
         6PigjzJWOQRTDnUhBEzy1bA/ll2PKr2jywsn0b0GyybGRQfpMjQRiyw02M7TFNNKef9+
         RpjA==
X-Forwarded-Encrypted: i=1; AJvYcCVzo3uG1t/7ybSzjoj5mFA4O+0ggNvJ/eCdTC1x6xBb6evBFWga1K+Gk0iTzRltoXWNnvptSI4njw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJlH2j9L4VNPtOIV24wvmDmT6fBF5gN5Si0k7SfUOVmMJcyip
	cAhmcypv3lrcryl9qwkU4AAij/IgEBttK8iLx3RfE5fKSBCrIkQkJNySaa5vtuvtXbZTp3ph/zD
	tJFtRM4+ZLmwVSqbNZYIW08Bd42RWbrEKNcVDoiH0VXOsxz5TGsht2Nx4HrHwfg==
X-Gm-Gg: ASbGncuZj5JmmaqTifvHKPjpKgyiU1pGNxLpKX9/BCc5zquuV82Up1R3y1cXDbKNmKF
	fGzIle9NDEvPjLbvvLWWl8Dk68HnSUtRtO9czW44zQnx9ebFTuI5tB1J5WjeAtXzY2bdKedWxDl
	5+jATW/9e4nhg1T5pE/oy57mq4Z1K4Tk8/6bk4wFdek/JJ3912/nG2HSWBGZLPUg2po3FjhnCWE
	a1XiBt7ScX5Ok1rs11GBaxOB55ttDaQnT6mmk864ip6lvqNQee23AXINyxEIQgdtxshVgp6iQZV
	/p9eDY1L0iPL3PDtS2c5b+tV16eaKHMvEoYNpv2+g7M+OJCOF1j8NuCL2xnXiLEg52AzXTiIKDv
	qpCrwrlnAOq4uiqT/oCfM5k3j96fWSXjevNc=
X-Received: by 2002:a17:90b:3d90:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-3436cbf7dd3mr7770308a91.17.1762699145564;
        Sun, 09 Nov 2025 06:39:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+2hAPMgXntUQ8yQpAM9+0XRennk8O6s10oC9AfbkmsdbrsxlwJ+Ti99rsp24Oev9CA5kAPA==
X-Received: by 2002:a17:90b:3d90:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-3436cbf7dd3mr7770256a91.17.1762699144992;
        Sun, 09 Nov 2025 06:39:04 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:39:04 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:20 +0530
Subject: [PATCH v17 07/12] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
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
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=6623;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=gOqHkjWgXv2eEhKUz/L3I9ntPxQxM5L+0g6CBUJNCec=;
 b=gAySl5Mi53Gi7nfTHC/n9Cy9cFjThjpNi4Fl76P3IZkKi+5Z7ZEaKFx674fCUd4LmoI19chi8
 GMsh0cHnyyTDm+EsnJOkw8XO1J1k3Z06hT0DJbRueMK1Sw/ND3+PFyc
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX7ahgbD97iSnJ
 quZKWVJvuQJh+O9hItFjJlwQtAUkTfDItHOLvOs72Wu0f0JDggJgKd5ei3FYify1217j3ZFotGQ
 SN1reShQDDQTQ1gK7VCYWUWwBzZT8tfR+hY0PYgZ/tMCzoqZzuc3pic6ey+EcfM+5TEIKGXzGuC
 QT0D+wBjxSr6HYBELXz4JHrIXaX81yJzKnsitgMzesHTOa+6T/DZ6+QmHL7i3rmLmFc9OT/i5tk
 XMaR/n6zKj/piYssneLZmCEEJF5W4xGdyKhKGStchXCBiSmDILi96NvTVed5mcIKQ9iM5uugzV4
 yP80JC6zSjKWTiBtASSoRJtD6PgtPUk50pIOgfKGR6wU+FFwZ7xW6nYb7k5I1R5MF2uRzZasZ/R
 HhUGh/GFC9cc51dY3LxLhQZoUV97kg==
X-Proofpoint-GUID: VaYuYzldrbNGgRkz2vxbDuILPsJfHZu9
X-Proofpoint-ORIG-GUID: VaYuYzldrbNGgRkz2vxbDuILPsJfHZu9
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6910a78a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1Y-8vuCXXADn_sFn8ogA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

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
Reviewed-by: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/Kconfig |  2 +
 drivers/firmware/psci/psci.c  | 92 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

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
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..ff82e7f4c27d1609a75cedc3a9790affaf839801 100644
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
@@ -547,6 +571,72 @@ static const struct platform_suspend_ops psci_suspend_ops = {
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
+	of_node_put(psci_np);
+	of_node_put(np);
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


