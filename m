Return-Path: <linux-pm+bounces-17159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287839C1292
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 00:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D05B1C224BB
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 23:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7A21A4A0;
	Thu,  7 Nov 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CUzNq7Qg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB7198E99;
	Thu,  7 Nov 2024 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022739; cv=none; b=IQdLRWkb3OTDFNS0UIyv4D2XWKz0B/s2BMiWvQyIBrbvyyTDPtH0CMct8ViRLfquXdP0xlnLsSUro9KnFd8Q6wm837b8JxOpOFfEShRGJVlxHMBgsh5WZyMruG1i+AIFv31d1Kp8tb0qyVJMqvZHCs2Ya1azHS2wpIcOv4Asj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022739; c=relaxed/simple;
	bh=UvIBqvOu1X+VXL8CJcPTJQuOWo2CyVpboy2Ngf5M+s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JKRLUYmu2sZ8n8UHglV/JXmTuU7bcxhakJe+r/Y1hYipq0PQJc7+tsWAZK9YmgyCoSJYeW36zC7SqmGx7mEv9A+bjtqwHERghtXp9myA4YXlYkHmrTTH/gybhLw7Z/t4jkEriqxpsMbbmF/6wZ/O9LzmMfGydD0xOu1YJhOoLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CUzNq7Qg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Mao7D014240;
	Thu, 7 Nov 2024 23:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zsx7v6mZz0Yust6nOGUIR9FH41kMyWKZVOzppJtcOVE=; b=CUzNq7Qgsb9Lte1I
	Y5CUB5kIbzyJ6tyaOnHlN//Z7+rbVCYlprnLcUOUIpjdnVUfLl7kxjO/gsAvWvd+
	34+veVwN3hX5/QtNridlN+VeDYNemqNOF/mAftdWYFDeaFKG8+L0WG681DzosNAV
	0Tyjt+6+kSlYS4VEv0Vr08DqMRZIQ5QTrwHiJvv5J97mwiGJcDWT/8WZcXb9h8DS
	sa8cxktkA1XlliCG1fPP/uxyQIFuy1ZaG+omA4S8PGip+BeTcbpw1+dCCBMGS1wv
	p3iUxVRqULHpVIUewDCTWekqcmq+vWLlCQaTlFbEtA0JHkMWCldbmhBVcScpzeMM
	JD5kmQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42s6gd03vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 23:38:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7NcbS6025285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 23:38:37 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 7 Nov 2024 15:38:36 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 7 Nov 2024 15:38:27 -0800
Subject: [PATCH v8 3/6] firmware: psci: Read and use vendor reset types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-arm-psci-system_reset2-vendor-reboots-v8-3-e8715fa65cb5@quicinc.com>
References: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
In-Reply-To: <20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, "Olof
 Johansson" <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will
 Deacon" <will@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G0K7UiDRRX9KFTNJHhfxQRMH6gAwCaz8
X-Proofpoint-ORIG-GUID: G0K7UiDRRX9KFTNJHhfxQRMH6gAwCaz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070184

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
 drivers/firmware/psci/psci.c | 104 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2328ca58bba61fdb677ac20a1a7447882cd0cf22..e60e3f8749c5a6732c51d23a2c1f453361132d9a 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -79,6 +79,14 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 
+struct psci_reset_param {
+	const char *mode;
+	u32 reset_type;
+	u32 cookie;
+};
+static struct psci_reset_param *psci_reset_params __ro_after_init;
+static size_t num_psci_reset_params __ro_after_init;
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -305,9 +313,38 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
+static void psci_vendor_system_reset2(const char *cmd)
+{
+	unsigned long ret;
+	size_t i;
+
+	for (i = 0; i < num_psci_reset_params; i++) {
+		if (!strcmp(psci_reset_params[i].mode, cmd)) {
+			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
+					     psci_reset_params[i].reset_type,
+					     psci_reset_params[i].cookie, 0);
+			/*
+			 * if vendor reset fails, log it and fall back to
+			 * architecture reset types
+			 */
+			pr_err("failed to perform reset \"%s\": %ld\n", cmd,
+			       (long)ret);
+			return;
+		}
+	}
+}
+
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
+	/*
+	 * try to do the vendor system_reset2
+	 * If the reset fails or there wasn't a match on the command,
+	 * fall back to architectural resets
+	 */
+	if (data && num_psci_reset_params)
+		psci_vendor_system_reset2(data);
+
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
@@ -750,6 +787,73 @@ static const struct of_device_id psci_of_match[] __initconst = {
 	{},
 };
 
+#define REBOOT_PREFIX "mode-"
+
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
+		num = of_property_count_u32_elems(np, prop->name);
+		if (num != 1 && num != 2)
+			continue;
+
+		count++;
+	}
+
+	param = psci_reset_params =
+		kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
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
+		num = of_property_read_variable_u32_array(np, prop->name, magic,
+							  1, ARRAY_SIZE(magic));
+		if (num < 0) {
+			pr_warn("Failed to parse vendor reboot mode %s\n",
+				param->mode);
+			kfree_const(param->mode);
+			continue;
+		}
+
+		/* Force reset type to be in vendor space */
+		param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
+		param->cookie = num > 1 ? magic[1] : 0;
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


