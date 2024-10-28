Return-Path: <linux-pm+bounces-16614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5F9B3973
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 19:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA7E1C21F14
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B5B1E008D;
	Mon, 28 Oct 2024 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QmYwtrTC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AE1DFE0B;
	Mon, 28 Oct 2024 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141131; cv=none; b=jnWBRSxthu5Flw9yvfrqVIdlq4jICvdkWg2QJa948XR18ramPg6/5PLPAQGKDZ+6iExLSrJy5g5RkM57Kxni3vxuF29OThnXFTbifn7oDySjjVHPUzJEMacV1U7gc7sHlgIXJFx7n1EdjwoukjI4WO+Zt0nd1o4XhCQ5KedGIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141131; c=relaxed/simple;
	bh=cUkBEdrTSKfJnh55BiESktGrAnUgoJe2ay0L0ERWxk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WKGLwR9TmPZqmYcqqKHnoFXdokh+HRYhfJR6CW2M9aW6M6rYMkXZBlMCXn/3DyHtwJ4Wso5Y+XHghzf2G5iCoEpfSYGv3xi0Mq33fOHmwu9zTqdm//5rR49uRJepWn3M4TF0A+drN6okr6ojP7juksjZEjKeCbHRo3uTRB0mIak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QmYwtrTC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SAWsTX031602;
	Mon, 28 Oct 2024 18:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QezESXxHqBez0fhuBmP1of7VV/80rnDoCk4pnfhP+14=; b=QmYwtrTCwyrtMWoY
	6luxXCp+njCCtwlReb2W/0q41/jEDMCZxoiBC5bHN66huZe4JNif7QXalu2fsmOT
	wftDsBccfpEFc0u1sVKPfA7vNfcweutOz5jt/FnNkvE8Zi5rJZyngg6fkn+Mccxt
	smKV2gyZj7whetbo09jEy5z5mRKs+fr937IkqT4cexIhqjOhbA999y5kR0rvladp
	EtBZwJEoRhrSsHJrYEtJmeQraPBBcd7JmHnEPFpNg+1aC64HALS/2INj/HuXFIlq
	EXUzAc8sypz8sxfDr6R9SUzgcJP/v2ljJa2Sb/DDsrYJ9DnLXFrYiM41BcoiwQMd
	t2sxLw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8dyun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 18:45:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49SIj25w027569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 18:45:02 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 28 Oct 2024 11:45:01 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Mon, 28 Oct 2024 11:44:57 -0700
Subject: [PATCH v7 3/5] firmware: psci: Read and use vendor reset types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241028-arm-psci-system_reset2-vendor-reboots-v7-3-a4c40b0ebc54@quicinc.com>
References: <20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com>
In-Reply-To: <20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com>
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
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zz7cm5HOTG31oEA3rQNNnz8V0W4_KbHF
X-Proofpoint-ORIG-GUID: Zz7cm5HOTG31oEA3rQNNnz8V0W4_KbHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280147

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
index 2328ca58bba6..2d7b6efc8743 100644
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
+static struct psci_reset_param *psci_reset_params;
+static size_t num_psci_reset_params;
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -305,9 +313,38 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
+static void psci_vendor_system_reset2(unsigned long action, void *data)
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
+			/*
+			 * if vendor reset fails, log it and fall back to
+			 * architecture reset types
+			 */
+			pr_err("failed to perform reset \"%s\": %ld\n", cmd,
+			       (long)ret);
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
+		psci_vendor_system_reset2(action, data);
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


