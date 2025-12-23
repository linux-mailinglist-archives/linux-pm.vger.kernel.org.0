Return-Path: <linux-pm+bounces-39880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1488CCDA0CB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 814D0302650F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A05033C193;
	Tue, 23 Dec 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eaSiNtgJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUsTf0Zl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D8346A01
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509705; cv=none; b=FMWSinvqcw4n9ducj5K2f9oSs3Sk84H1BzY9zyk98RGaEZG+BJJ+GSJ5CZw2W6dBzkBw7rI5l6rWxSPgF0pvEVAnRhxQyzadagR5WzQWqHt7tG6j4cVrJyKVpc78M3ltQdEPAOpE2H1P9ULKz0Wywd/R6umJtAPYI0jCz3bgze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509705; c=relaxed/simple;
	bh=LHOC90yAoiwemIEAKL3+u1kkTKM+A1ZqtQ5uNG8qwD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLLrFXKRseRdMfA7S6fxUtg+cQIjMw3qnzKTOLy3OtP0lmq6uyeNtNiqzlFLFjMacGkMfXxDx27xWw8Tp0pTDfprAv9dinzzOFk9aeQqOwU76irVkcEFp7RQ5YjbCCKv33hTlGaaESWxCC1n6pUKW1lsL4oYx2C8RUD4u9VfS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eaSiNtgJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUsTf0Zl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNEmw952116374
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IVcTn3KqGR/L4VgGa1zjn9+vt8y24OHnRTPtAi2BpJg=; b=eaSiNtgJDlycVQhV
	X864m3O1qGZG4dgcW40DVaZCLClXe8nItZxOImLijanlTPZffDsM3yLMCgQUmk20
	+PJfa2bpCVtHlB2GUhdgaMEwhBOdqgfIjNH6xrXkw6lqcCQ61+MKz9CFzQ7GqZuR
	XwTAtnwkJAFT2IS0uRK/nkJryOzDALooUm1vAibwr+Rtl38RCbkX+2sKxWc+7eV/
	CYn24VR8thvP3bSZgh/xNxKn34c8l02xhd1eFGJCMaEjaE47vrqczpG5EEXTQLK5
	Z09bsd7v0hJN/rZskLbKtxBUi7gMZTWk0jWfdfrGmX0rTCCoZ7g1YTJW/9rW6dK2
	8ETyrQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7cudkfa4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f4822f77so136591505ad.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509701; x=1767114501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVcTn3KqGR/L4VgGa1zjn9+vt8y24OHnRTPtAi2BpJg=;
        b=JUsTf0ZlXk3/jtRon2tpMcp3aWswuZD1livneCqIgi9Uzv8jmmxm00msM4R2qZGwuO
         9o98J/hhOfXJ61kg7XVN6O4wowKLK7YpTkF6z3wmRMZHzmCH3mHghLmW6ebJ/fpDW+6Q
         XeCkItM3HZOEVJ5/49V8HRzmeskkIrJY4bFakpPoaroNdVR+9f+fVI8uZv1VD0kE5DFO
         P0vVb8K/3/vqRgThOkyu+pU9Tn/IE9Q6LJn9XG6YZ+hTmyWdggp+GxkQe9sbNvWo5OAu
         wvpEzVMd5ZdKc71pdYltZBzz/RGK/OhTP0bkXLPpYVThj0JE+SB4ATxdriKKG37qU0tw
         MU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509701; x=1767114501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IVcTn3KqGR/L4VgGa1zjn9+vt8y24OHnRTPtAi2BpJg=;
        b=ukiLPLmZVIztC3cig1KSqJMoIgTh/Hx4m2EJ78owkNtEOIyOvEq6xJOGZlc1MVfJ9R
         DhOABOUxQ7XpmzdGzCaLfOhqeg1cA3l+zktfZLttJILl+9VJhPyLxdLSrWCuC7lCmzOg
         TrBnRKq6uzEryWAWalHMVKbP/hbXf/yT2dqDXl8//ppiVeWKgPaJ+HQeuhGptU4oPR+z
         q0MKOQ0MDf8EvjW9xiOg4evCxnV7oIexew13zcyKCu52A4jaMe5pNMs6XVPwX4haHbX9
         ecQFItFRuERk/YlgmNTPFU8u6VhL+nhZ/oCZ2XIQdUZLyChquNSbXt9VlnWzwhto2vvM
         wuCA==
X-Forwarded-Encrypted: i=1; AJvYcCV8JqyqOt3Bz8bS9ccPDr5mPWAh2SV444XpYtVSnmjivphklcbfVyVvw6/G+T0/P7CTkHNBJU9FmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7m52OeJZmuVYizvGFvskAQC3Nsj5mhF4tyIKQMws2I47siuj7
	ea+IL1AbHgrZ4/yIP5Wi+emcVnQo3vY+j62a/c8auV3rkwVbaKNZ+CFlZwmcSoOp/k1Zu4nrHYS
	znr7cgJ1TAPZ6c2mSc5vR/NxTk12ZUgaa5EgV46u4GFEpU1Nv6rnmMoVQfzP1Zg==
X-Gm-Gg: AY/fxX5/6taFBoy2oJc+4nUofjCG0DL86+uFr8HSML/uaunuyjdQKmdLOLwmleRygJ6
	uY9zG1yDkBgbr5dEvaTzXExQeQVgph0rAN1HqO6J1yZiuanOPiGfsO3lP2S7KXqeHaTrxHKrD6v
	FchUfgeLHHRirc9GQ+ocyDcskRsITqeDe5fg171ZrsdX8lB+J0nPtsngnDIk72N+ezJkGHQQn/U
	tMQS+dnKJzZYXgGPtugX6xp/nHwZat+4oWUSnHupfCJmkkoizt9M68vbsaE8ueuH9q5Vt4GCSYY
	S1BVsldKMlOPrHvIwSWxi/b0AMqnTeMRt9A4VBHY7d+MWLrrjhL7EYIhonLkcWwnjVOFzTr8Gat
	q3fb1IFB/dDI4OXur8JVucaUMXBhFZw/OleAn6OxmtgT7xQ==
X-Received: by 2002:a17:903:22c8:b0:295:425a:350e with SMTP id d9443c01a7336-2a2f220d13dmr134701835ad.8.1766509701393;
        Tue, 23 Dec 2025 09:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk26fhnYgDTEBsdmUUC/AAEsrc3ujLIZgh5oYX7oAw9+/sEzso+1u3bhLOC4iE24161w5pTg==
X-Received: by 2002:a17:903:22c8:b0:295:425a:350e with SMTP id d9443c01a7336-2a2f220d13dmr134701475ad.8.1766509700852;
        Tue, 23 Dec 2025 09:08:20 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:20 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:35 +0530
Subject: [PATCH v18 04/10] firmware: psci: Introduce command-based reset in
 psci_sys_reset
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-4-32fa9e76efc3@oss.qualcomm.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=4358;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=LHOC90yAoiwemIEAKL3+u1kkTKM+A1ZqtQ5uNG8qwD8=;
 b=G2fEOckFFDds6XCzFZhwADptUUMnJ0eihB+skHyOzPygTJJ3xdGdKn34L+Hlizn54f63bVHQz
 E+QxO/wmQH4CxHYMORTMG69KwQN1FeBJPNFCbu3mRinGjzOiMVdoFHb
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=ebkwvrEH c=1 sm=1 tr=0 ts=694acc86 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=eczEI0HPkUfQIoTEgvMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 6wuDHIRW7vjt2z0ApVtbfFyogPsUyUIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfXx6A8A9H7ssyJ
 7b0YxtU1mLJEIr4BkL7ugrtU/mjghnI1QIKWoEyRtFmtYw3ANhb3rSGGpnP555QhpXg+17W9Sl+
 aOTZMdAo2S4dZjaLOUtqPv7QhI8o0b203qkoHrSSkGpxVhKae1z4KR4DIke45hxfv3X1RUQuQW5
 x5lFLCuFyyH06k2xSfrV7ZK8Z7RBJkA4SsbEQQQgh1BN/GkIOEB/2UaIsicf2SsbUg/Pb0vSgyH
 z2OQQZBKgA7Rhv/eObzO/EMtuAm/xip5k/+ncPgGvl/N5gr16MDJHtTmcuwVDYnquRLfozIGkzL
 zzgthIpaFgJVIvGnX+6OG950DXpsBnDVOQmnN/g/wsB81NFB1ALfUrEXBStX4oeXqrRSfZhH5I8
 sTCkJTjMaCEkmUDR2WwrGcfelqKs2ZOOMDItA5s8EBnKXhOP05eSZf2wJ2Gio369g5d/AHvoLpr
 6nMAiu+Yv7wsiM6QoNQ==
X-Proofpoint-ORIG-GUID: 6wuDHIRW7vjt2z0ApVtbfFyogPsUyUIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230142

PSCI currently supports only COLD reset and ARCH WARM reset based on the
Linux reboot_mode variable. The PSCI specification now includes
SYSTEM_RESET2 for vendor-specific resets, but there's no mechanism to
issue these through psci_sys_reset.

Add a command-based reset mechanism that allows external drivers to set
the psci reset command via a new psci_set_reset_cmd() function.

The psci command-based reset is disabled by default and the
psci_sys_reset follows its original flow until a psci_reset command is
set or a kernel panic is in progress.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/psci.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/psci.h         |  2 ++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..ad7a3267276f9e26740aea99c11f171ac715f9ba 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -51,6 +51,15 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+struct psci_sys_reset_params {
+	u32 system_reset;
+	u32 reset_type;
+	u32 cookie;
+	bool cmd;
+};
+
+static struct psci_sys_reset_params psci_reset;
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -80,6 +89,29 @@ static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 static bool psci_system_off2_hibernate_supported;
 
+/**
+ * psci_set_reset_cmd - Sets the psci_reset_cmd for command-based
+ * reset which will be used in psci_sys_reset call.
+ *
+ * @cmd_sys_rst2: Set to true for SYSTEM_RESET2 based resets.
+ * @cmd_reset_type: Set the reset_type argument for psci_sys_reset.
+ * @cmd_cookie: Set the cookie argument for psci_sys_reset.
+ */
+void psci_set_reset_cmd(bool cmd_sys_rst2, u32 cmd_reset_type, u32 cmd_cookie)
+{
+	if (cmd_sys_rst2 && psci_system_reset2_supported) {
+		psci_reset.system_reset = PSCI_FN_NATIVE(1_1, SYSTEM_RESET2);
+		psci_reset.reset_type = cmd_reset_type;
+		psci_reset.cookie = cmd_cookie;
+	} else {
+		psci_reset.system_reset = PSCI_0_2_FN_SYSTEM_RESET;
+		psci_reset.reset_type = 0;
+		psci_reset.cookie = 0;
+	}
+	psci_reset.cmd = true;
+}
+EXPORT_SYMBOL_GPL(psci_set_reset_cmd);
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -309,14 +341,24 @@ static int get_set_conduit_method(const struct device_node *np)
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
-	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
-	    psci_system_reset2_supported) {
+	if (((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
+	     psci_system_reset2_supported) && (panic_in_progress() || !psci_reset.cmd)) {
 		/*
 		 * reset_type[31] = 0 (architectural)
 		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
 		 * cookie = 0 (ignored by the implementation)
 		 */
 		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
+	} else if (!panic_in_progress() && psci_reset.cmd) {
+		/*
+		 * Commands are being set in psci_set_reset_cmd
+		 * This issues, SYSTEM_RESET2 arch warm reset or
+		 * SYSTEM_RESET2 vendor-specific reset or
+		 * a SYSTEM_RESET cold reset in accordance with
+		 * the reboot-mode command.
+		 */
+		invoke_psci_fn(psci_reset.system_reset, psci_reset.reset_type,
+			       psci_reset.cookie, 0);
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4ca0060a3fc42ba1ca751c7862fb4ad8dda35a4c..d13ceca88eab8932894051e7c86e806c2ad8a73a 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -45,8 +45,10 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void);
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+void psci_set_reset_cmd(bool cmd_sys_rst2, u32 cmd_reset_type, u32 cmd_cookie);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline void psci_set_reset_cmd(bool cmd_sys_rst2, u32 cmd_reset_type, u32 cmd_cookie) { }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)

-- 
2.34.1


