Return-Path: <linux-pm+bounces-23332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67AAA4CD3A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 22:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365841891489
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBF238D21;
	Mon,  3 Mar 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HFRx1Byk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B0232377;
	Mon,  3 Mar 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036179; cv=none; b=lXwSl+SK02eFoUBNDcWFe9tilhHA8Q390eC7dypKItrQBGfYZZoqZBodU08uKJVTlpeKzV/J9uwIerwWnymB83FbhcFgytjtiFQYVAUIEjZ0sU56G8+AtlSHDhgQUuXP8LRBLPNlDYecru4Nra3QOQ6lfI9TgXgUi36g8bApgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036179; c=relaxed/simple;
	bh=CAXWKFHwjaIxynG2xy3z553OsR4G0S3YgrQQyTeZNKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d0quHvzQVajBELgPC9pOF8RFUyH9JkaMreugbsx1D1u9L5zVd0RloXmsyc2MBi2biE/U2/KDT2N26S9wj6Fwg725kvuo3BIqupwg62/k6eZ7sPfnus9AvjaSb+ufPiepS/BC8+P2bdmsf7Wykw4bdnqb7HZ8aJtbzCdkaMDjIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HFRx1Byk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AgD5e018511;
	Mon, 3 Mar 2025 21:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9WYk9WH5UqhI3UWfOW+ZU1KgCABrt7zl9az8arnH3TM=; b=HFRx1BykORp9gsZY
	moryCvYT7+i7odP2K07l4l00T0/crR2zH7sEMFD0WvOIzSH15/XAYgbHgI+8Vqhh
	3N4Fk13edtACkSGllv6VtlSK1YdKfOIqfXz42Jlgc3jq7LZ+sXhjSXfT8ycwC4gT
	ZdWIcwVAr0tSWJyGUC88n/4lFkBBn2zYL/gNPjOPJP85IgfdLrFThH2RbjEK/u0x
	pbNHAlYsZQmLLbhTm+rGj8bDvtUjty/M+S/Yyv4bfCfMgFdGxaPAdoMPGgFnsWAj
	XRtlR++GBdlG8dCCKFYK5ZtrX0MK1Y+KCAoersx0wMqvIfKbcWR41GS2hGq5t04B
	rHiJEg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tase5pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 21:09:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523L9GuS007733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 21:09:16 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Mar 2025 13:09:15 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Mon, 3 Mar 2025 13:08:31 -0800
Subject: [PATCH v9 2/5] firmware: psci: Read and use vendor reset types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250303-arm-psci-system_reset2-vendor-reboots-v9-2-b2cf4a20feda@oss.qualcomm.com>
References: <20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com>
In-Reply-To: <20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com>
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
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Satya Durga
 Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera
	<quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, Elliot Berman
	<elliotb317@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Elliot
 Berman" <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dy0srntGd2FtcRzeb990AFSn2yysLBEJ
X-Proofpoint-ORIG-GUID: Dy0srntGd2FtcRzeb990AFSn2yysLBEJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030163

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

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

Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
---
 drivers/firmware/psci/psci.c | 105 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index a1ebbe9b73b136218e9d9f9b8daa7756b3ab2fbe..6f8c47deaec0225f26704e1f3bcad52603127a85 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -80,6 +80,14 @@ static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 static bool psci_system_off2_hibernate_supported;
 
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
@@ -306,9 +314,39 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
+static int psci_vendor_system_reset2(const char *cmd)
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
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
+	/*
+	 * try to do the vendor system_reset2
+	 * If there wasn't a matching command, fall back to architectural resets
+	 */
+	if (data && !psci_vendor_system_reset2(data))
+		return NOTIFY_DONE;
+
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
@@ -795,6 +833,73 @@ static const struct of_device_id psci_of_match[] __initconst = {
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
+		num = of_property_read_variable_u32_array(np, prop->name, magic,
+							  1, ARRAY_SIZE(magic));
+		if (num < 0) {
+			pr_warn("Failed to parse vendor reboot mode %s\n",
+				param->mode);
+			kfree_const(param->mode);
+			continue;
+		}
+
+		param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
+		if (!param->mode)
+			continue;
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


