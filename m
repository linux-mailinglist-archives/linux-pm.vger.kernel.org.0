Return-Path: <linux-pm+bounces-31006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7858EB08D6B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6856E1639BA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8442D77F2;
	Thu, 17 Jul 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IV7TUvDR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00342D8379
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756500; cv=none; b=QdP4yWMDvBUXb2UObx994YMM63/+rnOBMLojDbe3NU8OHWsIIUY7I1AOrv8iH5ipm2t+AjZmnkEdxmKrhidvVYbEWPEPh/iOGAvtlZsL2Lfm71hqCGpPxhw5C4kvzQJ/2SkTJGwu7e31qBCh1LuPIlWqmLIheeSFOA4LCIbEng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756500; c=relaxed/simple;
	bh=vRGudR+4lCF/CFjdEfDPgNRqqgAfbw6WDOCEN0Ok4b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlctP2jvYhlELAPPtNxQBXS+Egn1vqLYgxjCvt/z7Qt0YslMh9FNj+dw9hmepwDzSaiaBLiYzMe1BLj6n9AeeGDjPxZtrlDmpFwvmcnZ6isBNz9SdPX4BRVhautsvtiHd5JNHvFFuRrh2ID6EQn3a8/oEx5Yvvqf/5rDVY9VW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IV7TUvDR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCeNY8008788
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R1G5wt+CsWrcVcnaihKm5UaXqpfLNEFUHyU0bAvOqxE=; b=IV7TUvDR0s+V1EGx
	kraaD4KbPyxTSj0RoNvIiReG4qMA8GXBCM3mMZrqAICtuFzpEqKHZReV/VXHxCVK
	coM+YWcLgMwOrIJ4DtXsp+2AQGb+8+mMztTpyE3ouHHNaDOa2cYDJro/uRE3R84V
	I6QkQgeNJ2CwPl9ePb12P8ugKangaZJ18HN/d7wfBg7KvED8ih5QBnrE9/YgYNEA
	a4FW+PLV0yACunjuAkahEHN+lmkmQ01V8oC+LFk2CEiwX1h1KhUdmN90dm7UZ0xb
	r45RVK6NXjMZb/N8Wcuu7bxvNZTDYPwlhUNZF9B2ura1YcJDBedTwLB8r+vb9FyQ
	PrWjkw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb7nu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 12:48:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso1062371a91.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 05:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756496; x=1753361296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1G5wt+CsWrcVcnaihKm5UaXqpfLNEFUHyU0bAvOqxE=;
        b=FawIAszXA+WWI/6+ID25g7F97lqxrmhxSPwq//XhC3MPALN1yXq+xlHEemTpePx0Se
         QRbVtIsQ9Iu5GG6wlJE/8Gm0+1oeOhWhiSO/4oQhsJ/QEfjYOu7OysDpqaVLpHrTVrq5
         5iO9yiNdA+e/ooqtLmzY5A0zi9O7H+xC2WrIkynnaftqRcYYNz5jj0DSzjLcgfsvW6Gn
         spFEdPAStBD/G0YeeH3ASxP5zLjY5kFTkXiHVHWPcXLMuxJy02abrS8vpOhmBD0KXn3m
         VUW18WLY1Oaj5zDG8gMnroyC1zv7tJDGsMNt6j87vx32lJzAMYI/yue5iJ8ay3eG3qeS
         Nfmw==
X-Forwarded-Encrypted: i=1; AJvYcCWvLXIhv4lM7RyYFVf2+TLlb7NwPZscxtThBhhTMHKyeX3IsI5fg/cmmbP79wDSQuOrn6xNazL/ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOKaO+9hmNZjwZsqJOFfXr1J3DRnfA+5i0wJD/ffrTCVgY7WF
	FjF60kTC4nG7aNwbqoPtqRAfVJMrY7HuByjoyvMmMRymwATprMf2XuOjx0kfNb2L34m4GIQcFtF
	bd45QwTPp2uygBG6IRNcZEYslT6njckRIr1Sd5g50RawH4eLy9YGU0D1TmkORfg==
X-Gm-Gg: ASbGncvI0mlDYoBhEfuEtdqQMMMni4Kw+V4hv+Z0a8+E3wAhgeibsVgAnw93LNweZi9
	CpaVOQi4MhiM5fwoaHmMbWAePBxwAsmtUqtI/sNM+/hWMIvu6H5PQcfjFDcZtDjkJhpPrQgVCc8
	hWbw4qOWBDQQVo2Vw/ysLPh7zJMqoMaTUASuDzjxwQT3YkQTHUXkgZbjiLosWctkI0DAD21FszV
	31CyapXG08JoCfmewHeoTTF31IDGi8ojAYmBok7pF4TXJpRmjHvbTOLQS+UOqj5lLp4rFGEeRcv
	hiRc0lnZUlYFfsNKpIaRgZ1WHkhIQd0A8GYgw1tIqY7uzyY+CRFMHO8sToa1VoPnbnYIltU3P6P
	6
X-Received: by 2002:a17:90b:1d91:b0:313:d7ec:b7b7 with SMTP id 98e67ed59e1d1-31caea21192mr4833780a91.13.1752756495920;
        Thu, 17 Jul 2025 05:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3rytw7zOtg7Xmx743LeMDSPzC+ugRsDIVSFqGgIoj+8yoPglIf7EpfOaxpi0dHqanWFp4pg==
X-Received: by 2002:a17:90b:1d91:b0:313:d7ec:b7b7 with SMTP id 98e67ed59e1d1-31caea21192mr4833737a91.13.1752756495409;
        Thu, 17 Jul 2025 05:48:15 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf828a0esm1505283a91.42.2025.07.17.05.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:48:15 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:16:50 +0530
Subject: [PATCH v11 4/8] firmware: psci: Implement vendor-specific resets
 as reboot-mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-arm-psci-system_reset2-vendor-reboots-v11-4-df3e2b2183c3@oss.qualcomm.com>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752756455; l=4666;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=vRGudR+4lCF/CFjdEfDPgNRqqgAfbw6WDOCEN0Ok4b4=;
 b=OKh/pjXrYEArit7zr7m33XcTU+HzHx1vsKq5fDIex79NvYaBydSHXdfZ/6HqRxS8LAxhfcoeB
 qdpS62xMdWeDv1FlHwDj6hA1ZEKsrTAid1BW/6NnYjepSdI2QniynAr
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: 7y79Mi0yn7esy6MLmFxTLS7xOzZG8nn2
X-Proofpoint-ORIG-GUID: 7y79Mi0yn7esy6MLmFxTLS7xOzZG8nn2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMiBTYWx0ZWRfXxI6cXcy0wyXL
 qzcqDsr49t6GUD+8w5Mx/h4oaq/qsCze+8++Vo19+T0FhvI4DfhY3CPd3fCcWOwQt3nB05B/XN7
 8i+SIy1XN7x9Mw6E6YrTOmuFpIzi9hKM+gf7tLrayhJ+IqArcNStZ2ppgS9kZg/eydBAuMRYc8k
 97zYPi6Op5k1GyHMToQ0YP8VEe7gmqtJQjbqLzj8W9X2AzL76tgFI6Zg4J086YDCxon/gChOKEw
 A2xwuWbHT7Ayi6siZ6lJhZFsnoFYG4LIKqGoFj9U1eQ3jH0+rt+W4XmLEYH/vh4Cz0dRoUrsDnd
 Jw7Cpwhdmje6WhLQsONR4T0w/gLCPWSoHnJYtnZgAfae++J+g8gs8jL+dVtjl2jUE3+Sjzeb0QP
 eoD26EbSPeRdf7mJfWQpkhDoscEltqIjqgTgyt5DxkEMiE7s3nauh9ub1Hls9+chFQEAt7kV
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6878f111 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ppK30-iitoQuh3faNGMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170112

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

Introduce a late_initcall to register PSCI vendor-specific resets
as reboot modes. Implement a reboot-mode write function that sets
reset_type and cookie values during the reboot notifier callback.
Introduce a firmware-based call for SYSTEM_RESET2 vendor-specific
reset in the psci_sys_reset path, using reset_type and cookie if
supported by secure firmware.

By using the above implementation, userspace will be able to issue
such resets using the reboot() system call with the "*arg"
parameter as a string based command. The commands can be defined
in PSCI device tree node as “reset-types” and are based on the
reboot-mode based commands.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/Kconfig |  1 +
 drivers/firmware/psci/psci.c  | 53 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
index 97944168b5e66aea1e38a7eb2d4ced8348fce64b..9d65fe7b06a6429de8a26d06f9384e5c93f36e5f 100644
--- a/drivers/firmware/psci/Kconfig
+++ b/drivers/firmware/psci/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARM_PSCI_FW
 	bool
+	select REBOOT_MODE
 
 config ARM_PSCI_CHECKER
 	bool "ARM PSCI checker"
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..28018c283eb627bcb4ce6223c56899a43ed56399 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -17,6 +17,7 @@
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
+#include <linux/reboot-mode.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -51,6 +52,14 @@ static int resident_cpu = -1;
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
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -309,7 +318,10 @@ static int get_set_conduit_method(const struct device_node *np)
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
@@ -547,6 +559,45 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };
 
+static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot, u64 magic)
+{
+	if (psci_system_reset2_supported) {
+		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | (u32)magic;
+		vendor_reset.cookie = (u32)(magic >> 32);
+		vendor_reset.valid = true;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int __init psci_init_vendor_reset(void)
+{
+	struct reboot_mode_driver *reboot;
+	struct device_node *np;
+	int ret;
+
+	np = of_find_node_by_path("/psci/reboot-mode");
+	if (!np)
+		return -ENODEV;
+
+	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
+	if (!reboot) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	reboot->write = psci_set_vendor_sys_reset2;
+
+	ret = reboot_mode_register(reboot, np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	return 0;
+}
+late_initcall(psci_init_vendor_reset)
+
 static void __init psci_init_system_reset2(void)
 {
 	int ret;

-- 
2.34.1


