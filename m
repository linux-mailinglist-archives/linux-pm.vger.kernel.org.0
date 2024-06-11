Return-Path: <linux-pm+bounces-8959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC00904021
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273EE1F22999
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D239AF4;
	Tue, 11 Jun 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DFPflMBA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A728E37;
	Tue, 11 Jun 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120158; cv=none; b=PuT4IuY5V/lmChm8iy0HfIQVgDbKaL3t21Pk5Fvc4W7AsvF/nx0zu8e9TJkuPf26zc+B0ACbBkqueeL+fxpDNR5wa3+qoHYAkWDnbhsFPwCCpaD6Hj6XBj6WsfC2sYSdkp84mQ7wWu9Dg8bWxvcoESK9nB9Tq1VxCrnCe9n5P5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120158; c=relaxed/simple;
	bh=r2W9hBBuzHr8ffEtWbMtajPDnHUbNaMD1oXvVo7/DkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g5RcQ3GncJyX8LX9L4aDGGgjY2a+ylcmp8ZTyb1ttFzz/wKgtELeavbb2rLq8a/pULPaW94xRbNtk9NSerNrJKNGaM1UIdwjkNWGBf4VHU6da9NmxLS6GQJf7Y6Ai/8elPNoxSmh3QTV/MH373UpFel6MTbW6ZnuuycEO8b3Cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DFPflMBA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BClVmT008099;
	Tue, 11 Jun 2024 15:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DwjzWhH35icmXsfSnCPveRL+UKxheUIZAHNugEuUPKc=; b=DFPflMBAsEgYs/iV
	ZKD9Q6KlJy9RT8Ls3dUHAwlpL0dm06mCWz1sJb1rZR1LRTQlvcC8awaIbz6LV283
	z/ElVQOCg1kA++l6KOVIXu98VT4Hp+jt4SNIx1+0q/6uuyhRPmUT35u6koquGKDw
	mL1uOSX+Wj+CqBLU9WZqNj9Y8/xZxKfiRMht6hKguoWEYguuo1NvazNUwA0pfJ0U
	6I3d51ed8ERZtjaJUALrl8uZIB7WozvFs6vnFWKFPvKxHzNrS3mONbPR4s5dRr41
	taifiiUt+Ap5l1jyLzr2YNW90kqXreHbhhY481U0rfGth+7wdfjBctqEsZNEE2hT
	8/SHug==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmxqwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 15:35:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BFZVb5028484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 15:35:31 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 08:35:31 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 11 Jun 2024 08:35:15 -0700
Subject: [PATCH v4 3/4] firmware: psci: Read and use vendor reset types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-arm-psci-system_reset2-vendor-reboots-v4-3-98f55aa74ae8@quicinc.com>
References: <20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com>
In-Reply-To: <20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TbN0oA8vbUOpzY1F6JDa2SungnfmfKDH
X-Proofpoint-ORIG-GUID: TbN0oA8vbUOpzY1F6JDa2SungnfmfKDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110110

SoC vendors have different types of resets and are controlled through
various registers. For instance, Qualcomm chipsets can reboot to a
"download mode" that allows a RAM dump to be collected. Another example
is they also support writing a cookie that can be read by bootloader
during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
vendor reset types to be implemented without requiring drivers for every
register/cookie.

Add support in PSCI to statically map reboot mode commands from
userspace to a vendor reset and cookie value using the device tree.

A separate initcall is needed to parse the devicetree, instead of using
psci_dt_init because mm isn't sufficiently set up to allocate memory.

Reboot mode framework is close but doesn't quite fit with the
design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
be solved but doesn't seem reasonable in sum:
 1. reboot mode registers against the reboot_notifier_list, which is too
    early to call SYSTEM_RESET2. PSCI would need to remember the reset
    type from the reboot-mode framework callback and use it
    psci_sys_reset.
 2. reboot mode assumes only one cookie/parameter is described in the
    device tree. SYSTEM_RESET2 uses 2: one for the type and one for
    cookie.
 3. psci cpuidle driver already registers a driver against the
    arm,psci-1.0 compatible. Refactoring would be needed to have both a
    cpuidle and reboot-mode driver.

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/psci/psci.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..e672b33b71d1 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -29,6 +29,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#define REBOOT_PREFIX "mode-"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -79,6 +81,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 
+struct psci_reset_param {
+	const char *mode;
+	u32 reset_type;
+	u32 cookie;
+};
+static struct psci_reset_param *psci_reset_params;
+static size_t num_psci_reset_params;
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
+static void psci_vendor_sys_reset2(unsigned long action, void *data)
+{
+	const char *cmd = data;
+	unsigned long ret;
+	size_t i;
+
+	for (i = 0; i < num_psci_reset_params; i++) {
+		if (!strcmp(psci_reset_params[i].mode, cmd)) {
+			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+					     psci_reset_params[i].reset_type,
+					     psci_reset_params[i].cookie, 0);
+			pr_err("failed to perform reset \"%s\": %ld\n",
+				cmd, (long)ret);
+		}
+	}
+}
+
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
+	if (data && num_psci_reset_params)
+		psci_vendor_sys_reset2(action, data);
+
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
@@ -748,6 +778,68 @@ static const struct of_device_id psci_of_match[] __initconst = {
 	{},
 };
 
+static int __init psci_init_system_reset2_modes(void)
+{
+	const size_t len = strlen(REBOOT_PREFIX);
+	struct psci_reset_param *param;
+	struct device_node *psci_np __free(device_node) = NULL;
+	struct device_node *np __free(device_node) = NULL;
+	struct property *prop;
+	size_t count = 0;
+	u32 magic[2];
+	int num;
+
+	if (!psci_system_reset2_supported)
+		return 0;
+
+	psci_np = of_find_matching_node(NULL, psci_of_match);
+	if (!psci_np)
+		return 0;
+
+	np = of_find_node_by_name(psci_np, "reset-types");
+	if (!np)
+		return 0;
+
+	for_each_property_of_node(np, prop) {
+		if (strncmp(prop->name, REBOOT_PREFIX, len))
+			continue;
+		num = of_property_count_elems_of_size(np, prop->name, sizeof(magic[0]));
+		if (num != 1 && num != 2)
+			continue;
+
+		count++;
+	}
+
+	param = psci_reset_params = kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
+	if (!psci_reset_params)
+		return -ENOMEM;
+
+	for_each_property_of_node(np, prop) {
+		if (strncmp(prop->name, REBOOT_PREFIX, len))
+			continue;
+
+		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+		if (!param->mode)
+			continue;
+
+		num = of_property_read_variable_u32_array(np, prop->name, magic, 1, 2);
+		if (num < 0) {
+			pr_warn("Failed to parse vendor reboot mode %s\n", param->mode);
+			kfree_const(param->mode);
+			continue;
+		}
+
+		/* Force reset type to be in vendor space */
+		param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
+		param->cookie = num == 2 ? magic[1] : 0;
+		param++;
+		num_psci_reset_params++;
+	}
+
+	return 0;
+}
+arch_initcall(psci_init_system_reset2_modes);
+
 int __init psci_dt_init(void)
 {
 	struct device_node *np;

-- 
2.34.1


