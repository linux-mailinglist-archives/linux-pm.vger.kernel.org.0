Return-Path: <linux-pm+bounces-29471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A7AE7C5D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C2E1C22BCB
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4802DCC0D;
	Wed, 25 Jun 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SUQVEtQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9902DAFCB
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842845; cv=none; b=YR29/O8eU9iC1jGqbLFky9JIHzldxxMP9RK4wPrBOEXxOg3dl1qW8Av1uYza678G8DLB22IyNdr+k5IddlTZ3E1kP6evjRnT3Fppr7CM3PIpkK16UUlcqelR8eRPUYf6TPvrWHDzslMySniDo+kkqS6l6kqbCye3U7jWzj5H0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842845; c=relaxed/simple;
	bh=vrLW1qnJCDC0FLdYQbHwM+CFoiyFsyO9xdH1H9FbgME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLh2cLfY+vF4pNJvPbRP7CDNy0F2HdJXFdIOmSFpzEPEn6v84OJG4vmscUs4nU17JYsX01bDfYMYrFuIwr8LGGBflDuNIXON4Rt4MUeR7FGjZejh8VzV+6eu7Q++FAqLEsR5sMG53Mrng5QF519ffE6xqU9noa/IL6NhzX3hocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SUQVEtQJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so980349666b.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750842838; x=1751447638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0lMCXqqP8Hr9i2R969GAOm8r/yQIuE10rU6OEBHT6M=;
        b=SUQVEtQJkp2p+mxYRObaTruAMHtJL9nnq5o2C83UnHI1+Fxf7+xUCyMx0yswzylFw4
         pIa3tmxUbgVovdEnxAz3IpAVf1UP9O9NtI2ZUDBV0hiFjiiBZO/lUEoNgnzbLgQbsGZc
         yesMBmO2g30A3KdRqsp1EP8jlhP3mBNuYIHTEwhp3clxyqqtvfMjN3/96AuPyt+Lc/oo
         3frm9ksG83SU+DKoz8wlzwJ8AmVbzWyS3vkYo9ezVmPGuE4LdP2lmdR7ZUn0y7AmQxv3
         G4e8qjI5VxevkWsNR82CCuNk6pi8+xWdcELtJnDgY7HiYR18knlrKbKPGIMfQU3sR/FA
         9Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842838; x=1751447638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0lMCXqqP8Hr9i2R969GAOm8r/yQIuE10rU6OEBHT6M=;
        b=WGt8Ucehhoo0y/FiTQivDh8AJpFuX2+px3lVgv9NwVpj4pE2k7cf05id5F6iy2uGBa
         kaBS0bOzCzFcfDP45+Vu5GOFyLpakjHNb88Af4AVh3e6qvg94OoDfrj5lKUzbyg+FZW6
         PHXwlW+u+eksHtTFQD6C2HH6SR5TgFqolwvpNjIjlrUI6o7yCXFqlWBIj17Rfkrz41tS
         rbJhWYgDuw7txrR1W/3msUpdTkIHnZKqlS+LS8hJZO4jmGjOtltniQayTSwPaolqm1fM
         ArJ2TpHvf/VC/50c9E4zaRHq0mRuM9EOeEHd4K+d3UEs8fn9kaQf590duQw817h30Qrb
         pvRA==
X-Forwarded-Encrypted: i=1; AJvYcCUGJe2b5Qu5nBCYDQ4aayuP0fcbMCLP5vNyrrDu0LVNze87ZwUijdOdD9VAVi0VjtUASVYySC6DGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLE0wk65RT4U4Ly7JlfRV7sGKWtMyANO5TZ6r/MT24x3xgPC7L
	OJvsVMWiI54DoR8DsVtN9RdaHUDIQ/WcIls1Qt9ZPCVDYxIOsQAvqZ8wRPoL/ohyXT8=
X-Gm-Gg: ASbGncuDkugTVLQkyH2Er90uiiYAKPdsKrOgnwQsvifUs9Bl5UjYi3MRkv1j+tw/gG8
	uEVnQhY7rBPCJchxvvtVtZ8btRfJov2QzMxW5/ubvPUqY3JhEVaqaUCDI08lwzvhxdOhP14IJvM
	vkOotS9xsNicuO3EkQ92jeDTJc3b8RSPiCiv50wDVE7vL/xs0S2Jlqgnyqye4arRXnRlRMpckrQ
	wgHV8TUfcxzGt5lD9Lr25dqzLyhYPh6hijE553Q950qtMMiHnW8Yb94O6o4Np5mbW+3eDcQyRaK
	gV5q+eXOMZm/jV3BxaBndr8/j2oxLONZB2JIJjxC2oe505foejWyq2cgT/cf0N/hodkom20QrSy
	FlTBcqEbXVQLXg6NoIUuv0QfivGP4WZwm
X-Google-Smtp-Source: AGHT+IGfeq41DlypmqPkRTSl/l8QP7eln/2IOjv21pHjf/X/7wq5qHXpqHoSo1v3mMKkCz2Rvck/Ew==
X-Received: by 2002:a17:906:d0c5:b0:ad2:417b:2ab5 with SMTP id a640c23a62f3a-ae0beba2300mr174330966b.60.1750842838041;
        Wed, 25 Jun 2025 02:13:58 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0bf33b108sm106422566b.115.2025.06.25.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:13:57 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:13:48 +0200
Subject: [PATCH 2/2] interconnect: qcom: Add SM7635 interconnect provider
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
In-Reply-To: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750842835; l=47224;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=vrLW1qnJCDC0FLdYQbHwM+CFoiyFsyO9xdH1H9FbgME=;
 b=/c1TLn9NPTvHeAW94hlW9FtuxlKzZRHGbGOwG4CoW89VKSp66LNUdS7JgHw9MeKZrKu+ojKuR
 1g90u/BbCk5BPBUEVuEcXCkNkfx0XyYaVrgr7wQICbkIKUFlN+Hrhgq
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add driver for the Qualcomm interconnect buses found in SM7635 based
platforms. The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/sm7635.c | 1554 ++++++++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm7635.h |  130 +++
 4 files changed, 1695 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 1219f4f23d40ecfe6ec54af590a2d71ef01c9384..11743db636a5f596b15e7c15c2104c02ed259723 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -283,6 +283,15 @@ config INTERCONNECT_QCOM_SM7150
 	  This is a driver for the Qualcomm Network-on-Chip on sm7150-based
 	  platforms.
 
+config INTERCONNECT_QCOM_SM7635
+	tristate "Qualcomm SM7635 interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on SM7635-based
+	  platforms.
+
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 7887b1e8d69b6b0193464835dbe57414f99554bf..1bf4a8021e12eb4bd88df0e29265de6804db276f 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -34,6 +34,7 @@ qnoc-sdx75-objs				:= sdx75.o
 qnoc-sm6115-objs			:= sm6115.o
 qnoc-sm6350-objs			:= sm6350.o
 qnoc-sm7150-objs			:= sm7150.o
+qnoc-sm7635-objs			:= sm7635.o
 qnoc-sm8150-objs			:= sm8150.o
 qnoc-sm8250-objs			:= sm8250.o
 qnoc-sm8350-objs			:= sm8350.o
@@ -75,6 +76,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDX75) += qnoc-sdx75.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6115) += qnoc-sm6115.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) += qnoc-sm6350.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM7150) += qnoc-sm7150.o
+obj-$(CONFIG_INTERCONNECT_QCOM_SM7635) += qnoc-sm7635.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) += qnoc-sm8150.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) += qnoc-sm8250.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
diff --git a/drivers/interconnect/qcom/sm7635.c b/drivers/interconnect/qcom/sm7635.c
new file mode 100644
index 0000000000000000000000000000000000000000..688b2250df0699aca79f834d31c926fb2ade9241
--- /dev/null
+++ b/drivers/interconnect/qcom/sm7635.c
@@ -0,0 +1,1554 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/interconnect.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/interconnect/qcom,sm7635-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-common.h"
+#include "icc-rpmh.h"
+#include "sm7635.h"
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SM7635_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM7635_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM7635_MASTER_USB3_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM7635_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SM7635_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SM7635_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM7635_MASTER_CRYPTO,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM7635_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.id = SM7635_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.id = SM7635_MASTER_QDSS_ETR_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.id = SM7635_MASTER_SDCC_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM7635_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qup0_core_master = {
+	.name = "qup0_core_master",
+	.id = SM7635_MASTER_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_QUP_CORE_0 },
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.id = SM7635_MASTER_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_QUP_CORE_1 },
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.id = SM7635_MASTER_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 35,
+	.links = { SM7635_SLAVE_AHB2PHY_SOUTH, SM7635_SLAVE_AHB2PHY_NORTH,
+		   SM7635_SLAVE_CAMERA_CFG, SM7635_SLAVE_CLK_CTL,
+		   SM7635_SLAVE_RBCPR_CX_CFG, SM7635_SLAVE_RBCPR_MXA_CFG,
+		   SM7635_SLAVE_CRYPTO_0_CFG, SM7635_SLAVE_CX_RDPM,
+		   SM7635_SLAVE_GFX3D_CFG, SM7635_SLAVE_IMEM_CFG,
+		   SM7635_SLAVE_CNOC_MSS, SM7635_SLAVE_MX_2_RDPM,
+		   SM7635_SLAVE_MX_RDPM, SM7635_SLAVE_PDM,
+		   SM7635_SLAVE_QDSS_CFG, SM7635_SLAVE_QSPI_0,
+		   SM7635_SLAVE_QUP_0, SM7635_SLAVE_QUP_1,
+		   SM7635_SLAVE_SDC1, SM7635_SLAVE_SDCC_2,
+		   SM7635_SLAVE_TCSR, SM7635_SLAVE_TLMM,
+		   SM7635_SLAVE_UFS_MEM_CFG, SM7635_SLAVE_USB3_0,
+		   SM7635_SLAVE_VENUS_CFG, SM7635_SLAVE_VSENSE_CTRL_CFG,
+		   SM7635_SLAVE_WLAN, SM7635_SLAVE_CNOC_MNOC_HF_CFG,
+		   SM7635_SLAVE_CNOC_MNOC_SF_CFG, SM7635_SLAVE_NSP_QTB_CFG,
+		   SM7635_SLAVE_PCIE_ANOC_CFG, SM7635_SLAVE_WLAN_Q6_THROTTLE_CFG,
+		   SM7635_SLAVE_SERVICE_CNOC_CFG, SM7635_SLAVE_QDSS_STM,
+		   SM7635_SLAVE_TCU },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.id = SM7635_MASTER_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 14,
+	.links = { SM7635_SLAVE_AOSS, SM7635_SLAVE_DISPLAY_CFG,
+		   SM7635_SLAVE_IPA_CFG, SM7635_SLAVE_IPC_ROUTER_CFG,
+		   SM7635_SLAVE_PCIE_0_CFG, SM7635_SLAVE_PCIE_1_CFG,
+		   SM7635_SLAVE_PRNG, SM7635_SLAVE_TME_CFG,
+		   SM7635_SLAVE_APPSS, SM7635_SLAVE_CNOC_CFG,
+		   SM7635_SLAVE_DDRSS_CFG, SM7635_SLAVE_IMEM,
+		   SM7635_SLAVE_PIMEM, SM7635_SLAVE_SERVICE_CNOC },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SM7635_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7635_SLAVE_PCIE_0, SM7635_SLAVE_PCIE_1 },
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SM7635_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SM7635_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SM7635_MASTER_APPSS_PROC,
+	.channels = 3,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC,
+		   SM7635_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SM7635_MASTER_GFX3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_lpass_gemnoc = {
+	.name = "qnm_lpass_gemnoc",
+	.id = SM7635_MASTER_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC,
+		   SM7635_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.id = SM7635_MASTER_MSS_PROC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC,
+		   SM7635_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM7635_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM7635_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_nsp_gemnoc = {
+	.name = "qnm_nsp_gemnoc",
+	.id = SM7635_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC,
+		   SM7635_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SM7635_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM7635_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM7635_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC,
+		   SM7635_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qxm_wlan_q6 = {
+	.name = "qxm_wlan_q6",
+	.id = SM7635_MASTER_WLAN_Q6,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SM7635_SLAVE_GEM_NOC_CNOC, SM7635_SLAVE_LLCC,
+		   SM7635_SLAVE_MEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qxm_lpass_dsp = {
+	.name = "qxm_lpass_dsp",
+	.id = SM7635_MASTER_LPASS_PROC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM7635_MASTER_LLCC,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_EBI1 },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SM7635_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = SM7635_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = SM7635_MASTER_CAMNOC_SF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.id = SM7635_MASTER_MDP,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video = {
+	.name = "qnm_video",
+	.id = SM7635_MASTER_VIDEO,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qsm_hf_mnoc_cfg = {
+	.name = "qsm_hf_mnoc_cfg",
+	.id = SM7635_MASTER_CNOC_MNOC_HF_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SERVICE_MNOC_HF },
+};
+
+static struct qcom_icc_node qsm_sf_mnoc_cfg = {
+	.name = "qsm_sf_mnoc_cfg",
+	.id = SM7635_MASTER_CNOC_MNOC_SF_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SERVICE_MNOC_SF },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.id = SM7635_MASTER_CDSP_PROC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_CDSP_MEM_NOC },
+};
+
+static struct qcom_icc_node qsm_pcie_anoc_cfg = {
+	.name = "qsm_pcie_anoc_cfg",
+	.id = SM7635_MASTER_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SERVICE_PCIE_ANOC },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SM7635_MASTER_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SM7635_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM7635_MASTER_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM7635_MASTER_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_apss_noc = {
+	.name = "qnm_apss_noc",
+	.id = SM7635_MASTER_APSS_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_cnoc_data = {
+	.name = "qnm_cnoc_data",
+	.id = SM7635_MASTER_CNOC_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SM7635_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM7635_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM7635_SLAVE_A1NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_MASTER_A1NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM7635_SLAVE_A2NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_MASTER_A2NOC_SNOC },
+};
+
+static struct qcom_icc_node qup0_core_slave = {
+	.name = "qup0_core_slave",
+	.id = SM7635_SLAVE_QUP_CORE_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.id = SM7635_SLAVE_QUP_CORE_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SM7635_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SM7635_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM7635_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM7635_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM7635_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cpr_mxa = {
+	.name = "qhs_cpr_mxa",
+	.id = SM7635_SLAVE_RBCPR_MXA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM7635_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SM7635_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM7635_SLAVE_GFX3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM7635_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.id = SM7635_SLAVE_CNOC_MSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mx_2_rdpm = {
+	.name = "qhs_mx_2_rdpm",
+	.id = SM7635_SLAVE_MX_2_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_mx_rdpm = {
+	.name = "qhs_mx_rdpm",
+	.id = SM7635_SLAVE_MX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SM7635_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM7635_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SM7635_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SM7635_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SM7635_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc1 = {
+	.name = "qhs_sdc1",
+	.id = SM7635_SLAVE_SDC1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM7635_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM7635_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.id = SM7635_SLAVE_TLMM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM7635_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM7635_SLAVE_USB3_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM7635_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM7635_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_wlan_q6 = {
+	.name = "qhs_wlan_q6",
+	.id = SM7635_SLAVE_WLAN,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_mnoc_hf_cfg = {
+	.name = "qss_mnoc_hf_cfg",
+	.id = SM7635_SLAVE_CNOC_MNOC_HF_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_MASTER_CNOC_MNOC_HF_CFG },
+};
+
+static struct qcom_icc_node qss_mnoc_sf_cfg = {
+	.name = "qss_mnoc_sf_cfg",
+	.id = SM7635_SLAVE_CNOC_MNOC_SF_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_MASTER_CNOC_MNOC_SF_CFG },
+};
+
+static struct qcom_icc_node qss_nsp_qtb_cfg = {
+	.name = "qss_nsp_qtb_cfg",
+	.id = SM7635_SLAVE_NSP_QTB_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_pcie_anoc_cfg = {
+	.name = "qss_pcie_anoc_cfg",
+	.id = SM7635_SLAVE_PCIE_ANOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_MASTER_PCIE_ANOC_CFG },
+};
+
+static struct qcom_icc_node qss_wlan_q6_throttle_cfg = {
+	.name = "qss_wlan_q6_throttle_cfg",
+	.id = SM7635_SLAVE_WLAN_Q6_THROTTLE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_cnoc_cfg = {
+	.name = "srvc_cnoc_cfg",
+	.id = SM7635_SLAVE_SERVICE_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM7635_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM7635_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM7635_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM7635_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM7635_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SM7635_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SM7635_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SM7635_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SM7635_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.id = SM7635_SLAVE_TME_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_apss = {
+	.name = "qss_apss",
+	.id = SM7635_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.id = SM7635_SLAVE_CNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM7635_MASTER_CNOC_CFG },
+};
+
+static struct qcom_icc_node qss_ddrss_cfg = {
+	.name = "qss_ddrss_cfg",
+	.id = SM7635_SLAVE_DDRSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM7635_SLAVE_IMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SM7635_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_cnoc_main = {
+	.name = "srvc_cnoc_main",
+	.id = SM7635_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SM7635_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SM7635_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.id = SM7635_SLAVE_GEM_NOC_CNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_MASTER_GEM_NOC_CNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM7635_SLAVE_LLCC,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.id = SM7635_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
+	.name = "qns_lpass_ag_noc_gemnoc",
+	.id = SM7635_SLAVE_LPASS_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_MASTER_LPASS_GEM_NOC },
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM7635_SLAVE_EBI1,
+	.channels = 2,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM7635_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SM7635_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc_hf = {
+	.name = "srvc_mnoc_hf",
+	.id = SM7635_SLAVE_SERVICE_MNOC_HF,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node srvc_mnoc_sf = {
+	.name = "srvc_mnoc_sf",
+	.id = SM7635_SLAVE_SERVICE_MNOC_SF,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.id = SM7635_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM7635_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SM7635_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_pcie_aggre_noc = {
+	.name = "srvc_pcie_aggre_noc",
+	.id = SM7635_SLAVE_SERVICE_PCIE_ANOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 0,
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM7635_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM7635_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM7635_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM7635_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.enable_mask = 0x1,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.enable_mask = 0x1,
+	.keepalive = true,
+	.num_nodes = 51,
+	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
+		   &qhs_ahb2phy1, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_cpr_cx,
+		   &qhs_cpr_mxa, &qhs_crypto0_cfg,
+		   &qhs_cx_rdpm, &qhs_gpuss_cfg,
+		   &qhs_imem_cfg, &qhs_mss_cfg,
+		   &qhs_mx_2_rdpm, &qhs_mx_rdpm,
+		   &qhs_pdm, &qhs_qdss_cfg,
+		   &qhs_qspi, &qhs_sdc1,
+		   &qhs_sdc2, &qhs_tcsr,
+		   &qhs_tlmm, &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0, &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg, &qhs_wlan_q6,
+		   &qss_mnoc_hf_cfg, &qss_mnoc_sf_cfg,
+		   &qss_nsp_qtb_cfg, &qss_pcie_anoc_cfg,
+		   &qss_wlan_q6_throttle_cfg, &srvc_cnoc_cfg,
+		   &xs_qdss_stm, &xs_sys_tcu_cfg,
+		   &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie,
+		   &qhs_aoss, &qhs_ipa,
+		   &qhs_ipc_router, &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg, &qhs_prng,
+		   &qhs_tme_cfg, &qss_apss,
+		   &qss_cfg, &qss_ddrss_cfg,
+		   &qxs_imem, &qxs_pimem,
+		   &srvc_cnoc_main, &xs_pcie_0,
+		   &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 3,
+	.nodes = { &qhs_qup0, &qhs_qup1,
+		   &qhs_display_cfg },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.enable_mask = 0x1,
+	.num_nodes = 2,
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.enable_mask = 0x1,
+	.num_nodes = 4,
+	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
+		   &qnm_camnoc_sf, &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup0_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.keepalive = true,
+	.vote_scale = 1,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.enable_mask = 0x1,
+	.num_nodes = 14,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
+		   &chm_apps, &qnm_gpu,
+		   &qnm_mdsp, &qnm_mnoc_hf,
+		   &qnm_mnoc_sf, &qnm_nsp_gemnoc,
+		   &qnm_pcie, &qnm_snoc_gc,
+		   &qnm_snoc_sf, &qxm_wlan_q6,
+		   &qns_gem_noc_cnoc, &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 2,
+	.nodes = { &qns_gemnoc_gc, &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.enable_mask = 0x1,
+	.num_nodes = 1,
+	.nodes = { &qxm_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc sm7635_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.bcms = aggre1_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct qcom_icc_desc sm7635_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup0,
+	&bcm_qup1,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_0] = &qup0_core_master,
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[SLAVE_QUP_CORE_0] = &qup0_core_slave,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+};
+
+static const struct qcom_icc_desc sm7635_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_cfg_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
+	[SLAVE_RBCPR_MXA_CFG] = &qhs_cpr_mxa,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_CX_RDPM] = &qhs_cx_rdpm,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_MX_2_RDPM] = &qhs_mx_2_rdpm,
+	[SLAVE_MX_RDPM] = &qhs_mx_rdpm,
+	[SLAVE_PDM] = &qhs_pdm,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_0] = &qhs_qup0,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_SDC1] = &qhs_sdc1,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_WLAN] = &qhs_wlan_q6,
+	[SLAVE_CNOC_MNOC_HF_CFG] = &qss_mnoc_hf_cfg,
+	[SLAVE_CNOC_MNOC_SF_CFG] = &qss_mnoc_sf_cfg,
+	[SLAVE_NSP_QTB_CFG] = &qss_nsp_qtb_cfg,
+	[SLAVE_PCIE_ANOC_CFG] = &qss_pcie_anoc_cfg,
+	[SLAVE_WLAN_Q6_THROTTLE_CFG] = &qss_wlan_q6_throttle_cfg,
+	[SLAVE_SERVICE_CNOC_CFG] = &srvc_cnoc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc sm7635_cnoc_cfg = {
+	.nodes = cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
+	[SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_APPSS] = &qss_apss,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_PIMEM] = &qxs_pimem,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc_main,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+};
+
+static const struct qcom_icc_desc sm7635_cnoc_main = {
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass_gemnoc,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_gemnoc,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_WLAN_Q6] = &qxm_wlan_q6,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+};
+
+static const struct qcom_icc_desc sm7635_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_LPASS_PROC] = &qxm_lpass_dsp,
+	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
+};
+
+static const struct qcom_icc_desc sm7635_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+	.bcms = lpass_ag_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_acv,
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc sm7635_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_VIDEO] = &qnm_video,
+	[MASTER_CNOC_MNOC_HF_CFG] = &qsm_hf_mnoc_cfg,
+	[MASTER_CNOC_MNOC_SF_CFG] = &qsm_sf_mnoc_cfg,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC_HF] = &srvc_mnoc_hf,
+	[SLAVE_SERVICE_MNOC_SF] = &srvc_mnoc_sf,
+};
+
+static const struct qcom_icc_desc sm7635_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+};
+
+static const struct qcom_icc_desc sm7635_nsp_noc = {
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_ANOC_CFG] = &qsm_pcie_anoc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
+};
+
+static const struct qcom_icc_desc sm7635_pcie_anoc = {
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn1,
+	&bcm_sn2,
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_APSS_NOC] = &qnm_apss_noc,
+	[MASTER_CNOC_SNOC] = &qnm_cnoc_data,
+	[MASTER_PIMEM] = &qxm_pimem,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc sm7635_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,sm7635-aggre1-noc",
+	  .data = &sm7635_aggre1_noc},
+	{ .compatible = "qcom,sm7635-aggre2-noc",
+	  .data = &sm7635_aggre2_noc},
+	{ .compatible = "qcom,sm7635-clk-virt",
+	  .data = &sm7635_clk_virt},
+	{ .compatible = "qcom,sm7635-cnoc-cfg",
+	  .data = &sm7635_cnoc_cfg},
+	{ .compatible = "qcom,sm7635-cnoc-main",
+	  .data = &sm7635_cnoc_main},
+	{ .compatible = "qcom,sm7635-gem-noc",
+	  .data = &sm7635_gem_noc},
+	{ .compatible = "qcom,sm7635-lpass-ag-noc",
+	  .data = &sm7635_lpass_ag_noc},
+	{ .compatible = "qcom,sm7635-mc-virt",
+	  .data = &sm7635_mc_virt},
+	{ .compatible = "qcom,sm7635-mmss-noc",
+	  .data = &sm7635_mmss_noc},
+	{ .compatible = "qcom,sm7635-nsp-noc",
+	  .data = &sm7635_nsp_noc},
+	{ .compatible = "qcom,sm7635-pcie-anoc",
+	  .data = &sm7635_pcie_anoc},
+	{ .compatible = "qcom,sm7635-system-noc",
+	  .data = &sm7635_system_noc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-sm7635",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("SM7635 NoC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/interconnect/qcom/sm7635.h b/drivers/interconnect/qcom/sm7635.h
new file mode 100644
index 0000000000000000000000000000000000000000..d5625e2971b36cdd2524136901b589be2ddafabd
--- /dev/null
+++ b/drivers/interconnect/qcom/sm7635.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SM7635 interconnect IDs
+ *
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_SM7635_H
+#define __DRIVERS_INTERCONNECT_QCOM_SM7635_H
+
+#define SM7635_MASTER_A1NOC_SNOC			0
+#define SM7635_MASTER_A2NOC_SNOC			1
+#define SM7635_MASTER_ANOC_PCIE_GEM_NOC			2
+#define SM7635_MASTER_APPSS_PROC			3
+#define SM7635_MASTER_APSS_NOC				4
+#define SM7635_MASTER_CAMNOC_HF				5
+#define SM7635_MASTER_CAMNOC_ICP			6
+#define SM7635_MASTER_CAMNOC_SF				7
+#define SM7635_MASTER_CDSP_PROC				8
+#define SM7635_MASTER_CNOC_CFG				9
+#define SM7635_MASTER_CNOC_MNOC_HF_CFG			10
+#define SM7635_MASTER_CNOC_MNOC_SF_CFG			11
+#define SM7635_MASTER_CNOC_SNOC				12
+#define SM7635_MASTER_COMPUTE_NOC			13
+#define SM7635_MASTER_CRYPTO				14
+#define SM7635_MASTER_GEM_NOC_CNOC			15
+#define SM7635_MASTER_GEM_NOC_PCIE_SNOC			16
+#define SM7635_MASTER_GFX3D				17
+#define SM7635_MASTER_GIC				18
+#define SM7635_MASTER_GPU_TCU				19
+#define SM7635_MASTER_IPA				20
+#define SM7635_MASTER_LLCC				21
+#define SM7635_MASTER_LPASS_GEM_NOC			22
+#define SM7635_MASTER_LPASS_PROC			23
+#define SM7635_MASTER_MDP				24
+#define SM7635_MASTER_MNOC_HF_MEM_NOC			25
+#define SM7635_MASTER_MNOC_SF_MEM_NOC			26
+#define SM7635_MASTER_MSS_PROC				27
+#define SM7635_MASTER_PCIE_0				28
+#define SM7635_MASTER_PCIE_1				29
+#define SM7635_MASTER_PCIE_ANOC_CFG			30
+#define SM7635_MASTER_PIMEM				31
+#define SM7635_MASTER_QDSS_BAM				32
+#define SM7635_MASTER_QDSS_ETR				33
+#define SM7635_MASTER_QDSS_ETR_1			34
+#define SM7635_MASTER_QSPI_0				35
+#define SM7635_MASTER_QUP_0				36
+#define SM7635_MASTER_QUP_1				37
+#define SM7635_MASTER_QUP_CORE_0			38
+#define SM7635_MASTER_QUP_CORE_1			39
+#define SM7635_MASTER_SDCC_1				40
+#define SM7635_MASTER_SDCC_2				41
+#define SM7635_MASTER_SNOC_GC_MEM_NOC			42
+#define SM7635_MASTER_SNOC_SF_MEM_NOC			43
+#define SM7635_MASTER_SYS_TCU				44
+#define SM7635_MASTER_UFS_MEM				45
+#define SM7635_MASTER_USB3_0				46
+#define SM7635_MASTER_VIDEO				47
+#define SM7635_MASTER_WLAN_Q6				48
+#define SM7635_SLAVE_A1NOC_SNOC				49
+#define SM7635_SLAVE_A2NOC_SNOC				50
+#define SM7635_SLAVE_AHB2PHY_NORTH			51
+#define SM7635_SLAVE_AHB2PHY_SOUTH			52
+#define SM7635_SLAVE_ANOC_PCIE_GEM_NOC			53
+#define SM7635_SLAVE_AOSS				54
+#define SM7635_SLAVE_APPSS				55
+#define SM7635_SLAVE_CAMERA_CFG				56
+#define SM7635_SLAVE_CDSP_MEM_NOC			57
+#define SM7635_SLAVE_CLK_CTL				58
+#define SM7635_SLAVE_CNOC_CFG				59
+#define SM7635_SLAVE_CNOC_MNOC_HF_CFG			60
+#define SM7635_SLAVE_CNOC_MNOC_SF_CFG			61
+#define SM7635_SLAVE_CNOC_MSS				62
+#define SM7635_SLAVE_CRYPTO_0_CFG			63
+#define SM7635_SLAVE_CX_RDPM				64
+#define SM7635_SLAVE_DDRSS_CFG				65
+#define SM7635_SLAVE_DISPLAY_CFG			66
+#define SM7635_SLAVE_EBI1				67
+#define SM7635_SLAVE_GEM_NOC_CNOC			68
+#define SM7635_SLAVE_GFX3D_CFG				69
+#define SM7635_SLAVE_IMEM				70
+#define SM7635_SLAVE_IMEM_CFG				71
+#define SM7635_SLAVE_IPA_CFG				72
+#define SM7635_SLAVE_IPC_ROUTER_CFG			73
+#define SM7635_SLAVE_LLCC				74
+#define SM7635_SLAVE_LPASS_GEM_NOC			75
+#define SM7635_SLAVE_MEM_NOC_PCIE_SNOC			76
+#define SM7635_SLAVE_MNOC_HF_MEM_NOC			77
+#define SM7635_SLAVE_MNOC_SF_MEM_NOC			78
+#define SM7635_SLAVE_MX_2_RDPM				79
+#define SM7635_SLAVE_MX_RDPM				80
+#define SM7635_SLAVE_NSP_QTB_CFG			81
+#define SM7635_SLAVE_PCIE_0				82
+#define SM7635_SLAVE_PCIE_0_CFG				83
+#define SM7635_SLAVE_PCIE_1				84
+#define SM7635_SLAVE_PCIE_1_CFG				85
+#define SM7635_SLAVE_PCIE_ANOC_CFG			86
+#define SM7635_SLAVE_PDM				87
+#define SM7635_SLAVE_PIMEM				88
+#define SM7635_SLAVE_PRNG				89
+#define SM7635_SLAVE_QDSS_CFG				90
+#define SM7635_SLAVE_QDSS_STM				91
+#define SM7635_SLAVE_QSPI_0				92
+#define SM7635_SLAVE_QUP_0				93
+#define SM7635_SLAVE_QUP_1				94
+#define SM7635_SLAVE_QUP_CORE_0				95
+#define SM7635_SLAVE_QUP_CORE_1				96
+#define SM7635_SLAVE_RBCPR_CX_CFG			97
+#define SM7635_SLAVE_RBCPR_MXA_CFG			98
+#define SM7635_SLAVE_SDC1				99
+#define SM7635_SLAVE_SDCC_2				100
+#define SM7635_SLAVE_SERVICE_CNOC			101
+#define SM7635_SLAVE_SERVICE_CNOC_CFG			102
+#define SM7635_SLAVE_SERVICE_MNOC_HF			103
+#define SM7635_SLAVE_SERVICE_MNOC_SF			104
+#define SM7635_SLAVE_SERVICE_PCIE_ANOC			105
+#define SM7635_SLAVE_SNOC_GEM_NOC_GC			106
+#define SM7635_SLAVE_SNOC_GEM_NOC_SF			107
+#define SM7635_SLAVE_TCSR				108
+#define SM7635_SLAVE_TCU				109
+#define SM7635_SLAVE_TLMM				110
+#define SM7635_SLAVE_TME_CFG				111
+#define SM7635_SLAVE_UFS_MEM_CFG			112
+#define SM7635_SLAVE_USB3_0				113
+#define SM7635_SLAVE_VENUS_CFG				114
+#define SM7635_SLAVE_VSENSE_CTRL_CFG			115
+#define SM7635_SLAVE_WLAN				116
+#define SM7635_SLAVE_WLAN_Q6_THROTTLE_CFG		117
+
+#endif

-- 
2.50.0


