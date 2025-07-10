Return-Path: <linux-pm+bounces-30547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B30DAFFDD4
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 11:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76D216B91D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2179296142;
	Thu, 10 Jul 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KoMnbHJw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AD295DA5
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139048; cv=none; b=Px3AbKxL467jcnZweN7GCR0zoLy1xCDbG6h8vbRJfv2BqcYeYl9XwC7oDwMuxvfQ/gXpox11luzd3KtRyiiIG2sSQvN+JdEzOTo4WkuVBMbRDxjoVeUSkAFwTda2+57DCv4ilhWqvUS1OlRHV5Brz0HHYyn6AI547sGfrJGLr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139048; c=relaxed/simple;
	bh=uCGaHKxMyCT6Fr1GicW0dawysRNXieqTwFGMzz+YiHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTauCzBmscQioXnUHadw07hv1xzOZpsURkDq9RnlJe6NQvwsNO8Jxhj7hED32Lymkg+HZKsN06DbHkyjf/pzP6UG3U4nF3GQnox0Zz2XFZQv2WDzmWAFlPJu7U8V7VQte7Z0W7scmQyR9+9yLb1JXkopDSp06qu4B1DHzhU/I7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KoMnbHJw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8cIM1023193
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i1S0YgYBWkNzPgMtsFsB7pmoBXpykrq3h9FvayJsue4=; b=KoMnbHJwHusbb1Qt
	y2PFwsxuIQm6zGmnPcpqg+sVft6aVH0zNR7Yy9ShnB3fA+GXaB0BHbyRG7zNPdgg
	nuhvYKJK01osK5kPqkawUTY6mADECTNdPwcsys2xUYV1Wunoo7ZVGAIT5xyx8Yo0
	vNFjzoAcU0U4L8RWM//QM1jVVyl+ryExg3Rom5uSHPZ4oqiCZBPKauSZUmaejCAE
	MTVA7+SGRVuBGcU7HBnoU/fOVwaEVQQSDo7oAQL31zditLY+7kLpZF4Motuj39Tp
	U7m/fVN3hkmhaDq6gUnvwABeYLVLYOyyTXbt84iDbECpQHUQSoU3eHoSM71hWA9z
	QS3T9w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbemc5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 09:17:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b31c38d4063so643787a12.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 02:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139045; x=1752743845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1S0YgYBWkNzPgMtsFsB7pmoBXpykrq3h9FvayJsue4=;
        b=oWTomfZg/gyVGn2Ico/suszb0qxR9n/WurwBlZJFWJ1t638Zve86EnqFMT9Xjev6JA
         vonwqPUmFmjG/6cCeqJX6UKFtE3WA7q3Rqm3SkLI00GvjDRYaTIMAoJDGkYOQrduw8Mv
         Xw/Qj1e43otUCjHHTg/Mzhn7nqvoFDJ99pS7IpSi8D6gX0fnsCRu3UTE/ubHOFVFNX8W
         n7Mkc/7zWyS+dxvi1hbsoMKm1TbGWafHdeTR/21S/6GomoIsJU5QJMeMhHLksihg8WfI
         ih5J04mQHKnWI0zvZJlS494z1VX6Ijqee5UftWCa7sDD3ayyfMtrLeILDb2am3NmBRSy
         zkeA==
X-Forwarded-Encrypted: i=1; AJvYcCUmAU+tAffpWmjRXekQ1YbtzWjXrP7b2lA58OZRVPdQETf+AxVAH9UNtMigwnJ9DSAp1LB1D/DhwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cKnFek0iuy9jLwh/kYQCODeVJ8KnI/V/5P9cfSijH6pnfwf9
	yWCxan92eZaibzYe+dnXv/mC7yl45JQLmo9Kgw34L3BK7BhVH2uw34id6Nb/W8uJoCgQEPyk2AG
	SanETVhvEE1y/cdDtcBZmrU6+neDSxPKWEgRuorcLUn6Z4Pd5Xr/16rHW0RkXRw==
X-Gm-Gg: ASbGncvykrnbIV+woYJjSNxPbWPQpesabkRb59mfMb6Qip3FcT44NRlYj5QmyaxApzi
	QFZ7IVKYy/WciaV261ZKP7YwqjSXePjG2YVfHoy5VtjaqjWELjTgH/qy+sROGelfv/QWqqtseMl
	u2gn/3FZnTLiTS2YFhLH23CN2wJ+e0dmXnisdnDy2nfvnc2Wz/UYpqPZEPVFQ5sEPzH0+ufMssc
	8Na2nlnNLFrBqKcyTcz/N//ozqPG13aIiHoyg7gRUqNpCKyZ6Vwhnyj50jBohn5fIs6T65hvYiY
	yQ/D6U1M6DLlH0T1gklp7QBJzZmoxyVizKzFdBepX0LrPm5ShUDl5U/grEE=
X-Received: by 2002:a17:902:ce91:b0:236:6f5f:cab4 with SMTP id d9443c01a7336-23de47cd652mr30055675ad.5.1752139044988;
        Thu, 10 Jul 2025 02:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg4RsjrMw/RBbJfUGCCXCUR+6pZ/OBaJOmKg8tfZNS55C/Jm0lOpHvhHWh1xVUlIOgo8dYHw==
X-Received: by 2002:a17:902:ce91:b0:236:6f5f:cab4 with SMTP id d9443c01a7336-23de47cd652mr30054705ad.5.1752139044303;
        Thu, 10 Jul 2025 02:17:24 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm14837765ad.189.2025.07.10.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:17:23 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:45:47 +0530
Subject: [PATCH v10 05/10] firmware: psci: Implement vendor-specific
 reset-types as reboot-mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250710-arm-psci-system_reset2-vendor-reboots-v10-5-b2d3b882be85@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752138982; l=4973;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=uCGaHKxMyCT6Fr1GicW0dawysRNXieqTwFGMzz+YiHM=;
 b=L6QqHX1809AdVxBa+yUIqV+KzAjQCF49Na14f6bM9oifTFAaCspHqvngk9jAg+lDYE0q+ZxwI
 FcFtJ72BHDNAXJDB5RiTwPW/EJPMBTS9YMfKspKEOgWPjTlQJLQUjhd
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OSBTYWx0ZWRfXzA2qlGUYU8N1
 A5ZWMQWj1nlRMZGHeQ50SQ+Gup0L8phOb7YcV39Mq79tjNm+pK18ok+l6DrcYyYBVws9PdbKesD
 Sj9KxlcRAhq6uFm8lnd1S5bpay/czBc49oPtWiqoLSF9sANpxFBEW1NIlzqJgj3dA6vXvOJ4XYL
 nCG02Zsq5YgUfPwCHSObwuuiJSpQ9+Cdjojtt5/IR0cO+CUJrvxddr9ulPjuXT6gY0FE3zO3yWk
 wLgLcihtau8Iy92upo9V/0Qu9vZAtmEoLGUxkySOp7DLYZwq5cRl2PYHfxLiuXN65Lq8ZrVkxWI
 TmeICOxqzgR5oxWAh+1PtWTdCJy83PfFLPo5WZfD9wI95iZba70ltikqgNMGu5dPJhl3fpXzlLH
 +dFFh8HvXDSAO8RH8twWRV1oGK6TQLmTJsO2AO+hCaDmLn0ZW9h9Mm2vTSiwAgYOJAOn1+ck
X-Proofpoint-GUID: aBVLzYjScp3sQXH5b96CnyoHnhOqGFjh
X-Proofpoint-ORIG-GUID: aBVLzYjScp3sQXH5b96CnyoHnhOqGFjh
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=686f8526 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=eXBxmsxbH67dAx2arOIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100079

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
as reboot-mode arguments like reset_type and cookie. For a SoC
where, PSCI vendor-specific system_reset2 is supported, the
appropriate value gets filled to reset_type and cookie during
this reboot-mode hook registration. If the secure firmware
supports PSCI system_reset2, restart notifier will make secure
call to trigger appropriate requested reset type.

By using the above implementation, usespace will be able to issue
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
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..87293f78ed83eb33ba67ded73728729811693ea3 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -13,10 +13,13 @@
 #include <linux/errno.h>
 #include <linux/linkage.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
+#include <linux/reboot-mode.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -51,6 +54,14 @@ static int resident_cpu = -1;
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
@@ -309,7 +320,14 @@ static int get_set_conduit_method(const struct device_node *np)
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
-	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
+	if (vendor_reset.valid && psci_system_reset2_supported) {
+		/*
+		 * if vendor_reset.valid is true call sys reset2 with
+		 * the vendor_reset(reset_type and cookie).
+		 */
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor_reset.reset_type,
+			       vendor_reset.cookie, 0);
+	} else if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
 		/*
 		 * reset_type[31] = 0 (architectural)
@@ -547,6 +565,39 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };
 
+static int psci_set_vendor_sys_reset2(struct reboot_mode_driver *reboot,
+				      u32 reset_type, u32 cookie)
+{
+	if (psci_system_reset2_supported) {
+		vendor_reset.reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | reset_type;
+		vendor_reset.cookie = cookie;
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
+
+	np = of_find_node_by_name(NULL, "reset-types");
+	if (!np)
+		return -ENODEV;
+
+	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
+	if (!reboot) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	reboot->write_with_cookie = psci_set_vendor_sys_reset2;
+
+	return reboot_mode_register(reboot, np);
+}
+late_initcall(psci_init_vendor_reset)
+
 static void __init psci_init_system_reset2(void)
 {
 	int ret;

-- 
2.34.1


