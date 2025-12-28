Return-Path: <linux-pm+bounces-39991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E79CE53E3
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3BD2300D904
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED5C239E7D;
	Sun, 28 Dec 2025 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L96jH8/S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eV5B+Wc0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F061D5CC9
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942483; cv=none; b=e4ZW/pNUstih3d1XlUYgabdIeE/4VNJHS1jAL2env0D7EmyHSsCkkurr95CN4ny0/iP9QzItlCwDpo7m5PzR8GFpi/hyUGyM4EapvaeGL8lU0dMzU6+XRTHyGGzQ3uk0EQOhnsyUe6W8Jikv7cs/RSjXL85z6dGRrGLFBZ4qaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942483; c=relaxed/simple;
	bh=r+dClbF+NRAB6/JduYUiH5LaoOpV4jm0Feyp3PXQ6Ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYjta5wqMOkyfL77OQu/Bm7DRhs+0fuNf1/OXRL7l/q3Th25EqEAOxmQtL3vxshAcRaAKtYqKqeK9z3UwgGmWCEPRTtfQ3YnvZ86Tk5fiA8Unu2zBcoe2ZHZAvPBfbOsTMcmruW0OD7L0LjbL2O/jjJrY13T/Ngo6l40ozu/UQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L96jH8/S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eV5B+Wc0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BS9j2pa4030471
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r831Wd4WfqmDnI6RCOW6V71GyT3JAOrlUY36xWWaPTo=; b=L96jH8/Sle24++tD
	fyembebuOrw6A4GhBp6YSQIuHXcRkDGbSf49XttFBM+noF1CJYkwHCc908lsdBHS
	GIsZ54T/SPOlOwe8kSG5i5zMOouO5lFkaCbDAGCdjcVcDXD19xts7yYZy++c6stb
	6Mnq58t1JhDxA/LNEd9OSqiGILMG+Gu+F0SORnmNo+FSYHBBZz9yoD43m7CReUfK
	XYWwYLmdpAJ7KndowWlMmYV9FbaEq3v6g470QPdVpytHbcBAcTc+zbsoUE8/+98H
	xSSAq1SKWjec++v7LwDBxgsXCIsg7fdR5FHKpc6abMem1nj+zIyKrj6AWlNMS9JH
	Oj0Pyw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bavrj0w8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:21:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f29ae883bso125686495ad.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942480; x=1767547280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r831Wd4WfqmDnI6RCOW6V71GyT3JAOrlUY36xWWaPTo=;
        b=eV5B+Wc0YzNb6ZSorySH5hLY9QEqRHXt8aUr1q0BrP7RxThF0LMfbLO/+kuJVfegT5
         B4txUDnCWWyIlb64bkDUWHpX6zxgyHe3J8iFVNccg+NdtgHuKz4cuAVInqmzrLym3tjG
         hDYczNDMzAX7khrfPlwWwwmdTC130SaHsnmfKodH8Dm9SMp1GaGylG/N5mIdrqNprlaI
         JhkbQpee9AqTOaXwv4vsPI9kqZ7QYQGpmaVvA4mXfvTsOJ44gy6LI4hpVbU2Bq0d9stX
         osAsmg4CUF2nhsb9RhQwSS4fVtsNvupmrrddjSRkG5vCIxQkuYSRxKyEz2eWietd+FLt
         lgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942480; x=1767547280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r831Wd4WfqmDnI6RCOW6V71GyT3JAOrlUY36xWWaPTo=;
        b=YEZW6dNjN8JRYDbs5wtHstPONVLY11dFhDsfbzL11AQkm67+5vWZlWPDMUk8QihAnh
         n3uhDUAUihNSJBW9pOKClJRR+e0/oRcfF2sQsghZqllBYNC7Zp8Qwt/PCfFf3RyopCzz
         VeAB9FSxZDnPlEgqB1WdwMX55XpmOu9Ktd4XbBXBdntTWtbDJLeYlh67f4/9EgJLRF0W
         ZSmpXkUjy9Cbko0B5y8mhKixZfjkzHX1XgTsYRFnp6J0fpbC05gdH4UvKd6DPyZ5wdjc
         +ReZeQ/WAN/75E/eEleqSBxanWuupWnf/VjWAS51LY0RW78NIncA+2STDzSC3Qcq51Md
         8LbA==
X-Forwarded-Encrypted: i=1; AJvYcCVBcevSPudSzPNVBJkQ5SpMzNaj9pmGn4q45+w30Ea7Safr3uswFn9emw3C5y0+WIpa/ULamjUZAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaAt5WVoP30l+IVr78dParQsvmJxe10LJAk7BGD7SaNE+QzvM
	fkz0YYyE5Yy1aTVBd9/xjztP9fqAPwpYBHIQdgpUmViwqptcqAX5GaJeRtH4pg4UWWUGqNqaf6Y
	Pgg8XmLeRpnTxOMSj/XCgEbY6GhD9ENkvmuy78OK97YdbLUHp5MeO69BjHQd/7g==
X-Gm-Gg: AY/fxX4/0dBhUP98KEUh4X5Z8Y76LPReggMnGjE3Svyb/tpiapiB3AXELu1nejv28To
	BwLwcEKqJEjWaNGtQ3g4Bu9jy06VLJ5IFz12jEd/KqxE/4if5ug9/x7M4fTxt1Rfd5GnDLqZ/8L
	3OHQPGtLbTuPY1vbMUXyxMH8wFpJbc0WxIzZa2WBjb4vvvcP1QqHoFKEsyqPUk6IH6NyWnh+4GC
	5pExNkHbghg6iIg8Dx19uXFYzLpbyNMw8YuNfh0AkibYq/qKulp6ygg/DHFY3lMy9TWlGX76go3
	4ywSrh7Swjqka7NxCd65BsPZgc7olG3QkfRfrRFJbpTffAfHp2dnvIRj4VcF1gtMLmVKeoZP59D
	mb7Y9WAIEoqyuS35O4p7pFzjoNZc1HhG3CcWsBAK+af20LQ==
X-Received: by 2002:a17:903:40cb:b0:29d:6b8e:d565 with SMTP id d9443c01a7336-2a2f283116emr270372755ad.38.1766942479704;
        Sun, 28 Dec 2025 09:21:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNm8WGC06B1FKTNVYdyJiBEjBvRjJVuKyQlWvsvW6gJg2hb0zwXirKd2N8S1aHugfgFW/jkg==
X-Received: by 2002:a17:903:40cb:b0:29d:6b8e:d565 with SMTP id d9443c01a7336-2a2f283116emr270372515ad.38.1766942479191;
        Sun, 28 Dec 2025 09:21:19 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:21:18 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:50:24 +0530
Subject: [PATCH v19 06/10] power: reset: Add psci-reboot-mode driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-6-ebb956053098@oss.qualcomm.com>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
In-Reply-To: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=6151;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=r+dClbF+NRAB6/JduYUiH5LaoOpV4jm0Feyp3PXQ6Ss=;
 b=SAQAVmKond6JYVMJWPVVSbiXzghlRYtVI0aO9I3/UVBMMxZKlh9A9EHYM/50aWS7uYcgPtCYO
 FndiecgWngfADMhwW5sLopxoK4h6PDsfALXlCK56xyN1P1vxebbnwI8
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: PPrXcwPs4i0hpXfjDyFFuW8p-56oJbMV
X-Proofpoint-GUID: PPrXcwPs4i0hpXfjDyFFuW8p-56oJbMV
X-Authority-Analysis: v=2.4 cv=coiWUl4i c=1 sm=1 tr=0 ts=69516710 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=y0Vp-ry0QnGiofiFOe0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfX61Y5UfPptPI5
 +zNqmYu2qCnTamgoYKXyc6i3VV8rqmyQcM3rjPdLJ5/QLEfxSTEHpqgpyHhV8KwMsDugpKQL03J
 c+TG3at6jOhSvU+w2OJ25sXVy2pAvg/OMIEYTTAm1BKo6GJ/3v8uO6gbCPzw/i1fSAhRSow7Yfs
 9YAbgsnq6FLRQ04H3zxRkNogAWMwmrFbhwz4GaUqHGq1P5H3wmyvfrI9U0E+y+VyHAVzM8m9ofN
 VMG8AeMvD3OkGBEGXNpAx1N4drPdjN9PwxF9yOFPFjhvhzzlw8efaE3p1HghYF8D1xgfbeL1HdD
 mH2KNhVQkYteMnsxUmL8J0eZfdRWbNv5tu2pQS2sGZToow+JpTxisEMLc6TUaYVJtMG+HMTs/+m
 KIah+BlICkOpHefeFDkYhKJqrBfTdI3zU4Pew99Mca/mVakSrpS0+fsR+WNhhHpeBOKOeyT/VLg
 +sZGCUea15s0Gl5PzYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159

PSCI supports different types of resets like COLD reset, ARCH WARM
reset, vendor-specific resets. Currently there is no common driver that
handles all supported psci resets at one place. Additionally, there is
no common mechanism to issue the supported psci resets from userspace.

Add a PSCI reboot mode driver and define two types of PSCI resets in the
driver as reboot-modes: predefined resets controlled by Linux
reboot_mode and customizable resets defined by SoC vendors in their
device tree under the psci:reboot-mode node.

Register the driver with the reboot-mode framework to interface these
resets to userspace. When userspace initiates a supported command, pass
the reset arguments to the PSCI driver to enable command-based reset.

This change allows userspace to issue supported PSCI reset commands
using the standard reboot system calls while enabling SoC vendors to
define their specific resets for PSCI.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/Kconfig            |  10 +++
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/psci-reboot-mode.c | 111 +++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f6c1bcbb57deff3568d6b1b326454add3b3bbf06..529d6c7d3555601f7b7e6199acd29838030fcef2 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -348,6 +348,16 @@ config NVMEM_REBOOT_MODE
 	  then the bootloader can read it and take different
 	  action according to the mode.
 
+config PSCI_REBOOT_MODE
+	bool "PSCI reboot mode driver"
+	depends on OF && ARM_PSCI_FW
+	select REBOOT_MODE
+	help
+	  Say y here will enable PSCI reboot mode driver. This gets
+          the PSCI reboot mode arguments and passes them to psci
+	  driver. psci driver uses these arguments for issuing
+	  device reset into different boot states.
+
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
 	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0e4ae6f6b5c55729cf60846d47e6fe0fec24f3cc..49774b42cdf61fd57a5b70f286c65c9d66bbc0cb 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -40,4 +40,5 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
 obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
+obj-$(CONFIG_PSCI_REBOOT_MODE) += psci-reboot-mode.o
 obj-$(CONFIG_POWER_MLXBF) += pwr-mlxbf.o
diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset/psci-reboot-mode.c
new file mode 100644
index 0000000000000000000000000000000000000000..499cf504071e88022fa5b5b32e26b7a674da8691
--- /dev/null
+++ b/drivers/power/reset/psci-reboot-mode.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device/faux.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/psci.h>
+#include <linux/reboot.h>
+#include <linux/reboot-mode.h>
+#include <linux/types.h>
+
+/*
+ * Predefined reboot-modes:
+ * reset_type(arg1) is zero; cookie(arg2) is stored in magic.
+ * psci_reboot_mode_set_predefined_modes to move values to higher 32 bit of magic.
+ */
+static struct mode_info psci_resets[] = {
+	{ .mode = "warm", .magic = REBOOT_WARM},
+	{ .mode = "soft", .magic = REBOOT_SOFT},
+	{ .mode = "cold", .magic = REBOOT_COLD},
+};
+
+static void psci_reboot_mode_set_predefined_modes(struct reboot_mode_driver *reboot)
+{
+	INIT_LIST_HEAD(&reboot->predefined_modes);
+	for (u32 i = 0; i < ARRAY_SIZE(psci_resets); i++) {
+		/* Move values to higher 32 bit of magic */
+		psci_resets[i].magic = FIELD_PREP(GENMASK_ULL(63, 32), psci_resets[i].magic);
+		INIT_LIST_HEAD(&psci_resets[i].list);
+		list_add_tail(&psci_resets[i].list, &reboot->predefined_modes);
+	}
+}
+
+/*
+ * magic is 64 bit.
+ * arg1 - reset_type(Low 32 bit of magic).
+ * arg2 - cookie(High 32 bit of magic).
+ * arg2(cookie) decides the mode, If arg1(reset_type) is 0;
+ */
+static int psci_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
+{
+	u32 reset_type = FIELD_GET(GENMASK_ULL(31, 0), magic);
+	u32 cookie = FIELD_GET(GENMASK_ULL(63, 32), magic);
+
+	if (reset_type == 0) {
+		if (cookie == REBOOT_WARM || cookie == REBOOT_SOFT)
+			psci_set_reset_cmd(true, 0, 0);
+		else
+			psci_set_reset_cmd(false, 0, 0);
+	} else {
+		psci_set_reset_cmd(true, reset_type, cookie);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int psci_reboot_mode_probe(struct faux_device *fdev)
+{
+	struct reboot_mode_driver *reboot;
+	struct device_node *psci_np;
+	struct device_node *np;
+	int ret;
+
+	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
+	if (!psci_np)
+		return -ENODEV;
+
+	/*
+	 * Find the psci:reboot-mode node.
+	 * If NULL, continue to register predefined modes.
+	 * np refcount to be handled by dev;
+	 * psci_np refcount is decremented by of_find_node_by_name;
+	 */
+	np = of_find_node_by_name(psci_np, "reboot-mode");
+	fdev->dev.of_node = np;
+
+	reboot = devm_kzalloc(&fdev->dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	psci_reboot_mode_set_predefined_modes(reboot);
+	reboot->write = psci_reboot_mode_write;
+	reboot->dev = &fdev->dev;
+
+	ret = devm_reboot_mode_register(&fdev->dev, reboot);
+	if (ret) {
+		dev_err(&fdev->dev, "devm_reboot_mode_register failed %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct faux_device_ops psci_reboot_mode_ops = {
+	.probe = psci_reboot_mode_probe,
+};
+
+static int __init psci_reboot_mode_init(void)
+{
+	struct faux_device *fdev;
+
+	fdev = faux_device_create("psci-reboot-mode", NULL, &psci_reboot_mode_ops);
+	if (!fdev)
+		return -ENODEV;
+
+	return 0;
+}
+device_initcall(psci_reboot_mode_init);

-- 
2.34.1


