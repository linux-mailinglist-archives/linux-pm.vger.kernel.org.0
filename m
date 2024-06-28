Return-Path: <linux-pm+bounces-10197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FDF91C038
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C36285566
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8871BF33B;
	Fri, 28 Jun 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fFkZ+JOr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E419B5A2;
	Fri, 28 Jun 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583314; cv=none; b=FAHGqeMleN6wEj+vkL0xNIchGx7EJPthF/Wp9lrQWACBWziAmCWf3IFBqTLnDW9vv4+lIcFEfpdYJPbfcBL65NFrqwo04ht0g917mqf9e8xBo2MSYuYXn1SG/S4b0pMEvv20c+cVj7HDlXeafa9GvXxRSQbWeZFJP3j+WT7zX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583314; c=relaxed/simple;
	bh=cP7qt0RTGaGZY1+4uqICd45ofn6SNOp6zlNjcm6SJ1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzpLUgTtrZjNoHevohedxRaIwNp8oJL3cfdNOklP8LcBbTdrelOq+919PqJpwxSMDfWbmLbNdtiimPZwt5X0ROWyH92gU8gZNlC3p7XbTMV7ZZdg1veeSLF+kTuPHQqfh225NoPzEgunIpLxSeMsiZ7HhD/cmIII6Qwj06Bkkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fFkZ+JOr; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC2492F3.dsl.pool.telekom.hu [188.36.146.243])
	by mail.mainlining.org (Postfix) with ESMTPSA id 545ADE456F;
	Fri, 28 Jun 2024 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1719583309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/jUAeH4sDbhlRHOvnB6YSKmEpWXzM7TF397VPLAuhw=;
	b=fFkZ+JOrcC35Jc1Fr5+LFP9qUn3Ogtp2i7UD4Xk7ahA9scEhypfojL8P6ndMyz+Hq4Mift
	bfuTdSZy2dhS0Ea5H6iKATnSbPoHC+83WT/Ah6S4jOjdD5Bh09DNatP6i+Uo6F+36ShBG8
	6dzV7nlmeahwXs2OIqvxGDj5ZeWOu5PmX9qtK4+rXv0QXn56Pivd3n+1soOr6VhW3KEgf1
	lY+Q9F1DI0WBWIfPmqBzu9o3XzMFwl/5zTJTWYMZpD7r0dulrFzJLB+E+Ncu2Up5nPhkAV
	v+BDuO0AdCaYfv2zvQCIWKbGiwHDd0fJpjZRUnvMiWwQGqPMXdKGEXQO/eJNCw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 28 Jun 2024 16:01:45 +0200
Subject: [PATCH v3 2/2] interconnect: qcom: Add MSM8953 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-msm8953-interconnect-v3-2-a70d582182dc@mainlining.org>
References: <20240628-msm8953-interconnect-v3-0-a70d582182dc@mainlining.org>
In-Reply-To: <20240628-msm8953-interconnect-v3-0-a70d582182dc@mainlining.org>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Vladimir Lypak <vladimir.lypak@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add driver for interconnect busses found in MSM8953 based platforms.
The topology consists of four NoCs that are partially controlled by a
RPM processor.

Note that one of NoCs (System NoC) has a counterpart (System NoC MM)
that is modelled as child device to avoid resource conflicts, since it
uses same MMIO space for configuration.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/interconnect/qcom/Kconfig   |    9 +
 drivers/interconnect/qcom/Makefile  |    2 +
 drivers/interconnect/qcom/msm8953.c | 1321 +++++++++++++++++++++++++++++++++++
 3 files changed, 1332 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 1446a839184e..9b84cd8becef 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -35,6 +35,15 @@ config INTERCONNECT_QCOM_MSM8939
 	  This is a driver for the Qualcomm Network-on-Chip on msm8939-based
 	  platforms.
 
+config INTERCONNECT_QCOM_MSM8953
+	tristate "Qualcomm MSM8953 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	select INTERCONNECT_QCOM_SMD_RPM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on msm8953-based
+	  platforms.
+
 config INTERCONNECT_QCOM_MSM8974
 	tristate "Qualcomm MSM8974 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 2ea3113d0a4d..7a7b6a71876f 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -7,6 +7,7 @@ icc-bcm-voter-objs			:= bcm-voter.o
 qnoc-msm8909-objs			:= msm8909.o
 qnoc-msm8916-objs			:= msm8916.o
 qnoc-msm8939-objs			:= msm8939.o
+qnoc-msm8953-objs			:= msm8953.o
 qnoc-msm8974-objs			:= msm8974.o
 qnoc-msm8996-objs			:= msm8996.o
 icc-osm-l3-objs				:= osm-l3.o
@@ -41,6 +42,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8909) += qnoc-msm8909.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8939) += qnoc-msm8939.o
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8953) += qnoc-msm8953.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
 obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
diff --git a/drivers/interconnect/qcom/msm8953.c b/drivers/interconnect/qcom/msm8953.c
new file mode 100644
index 000000000000..9e8867c07692
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8953.c
@@ -0,0 +1,1321 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk.h>
+#include <linux/interconnect-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/interconnect/qcom,msm8953.h>
+
+#include "icc-rpm.h"
+
+enum {
+	MSM8953_MASTER_AMPSS_M0 = 1,
+	MSM8953_MASTER_GRAPHICS_3D,
+	MSM8953_SNOC_BIMC_0_MAS,
+	MSM8953_SNOC_BIMC_2_MAS,
+	MSM8953_SNOC_BIMC_1_MAS,
+	MSM8953_MASTER_TCU_0,
+	MSM8953_SLAVE_EBI_CH0,
+	MSM8953_BIMC_SNOC_SLV,
+	MSM8953_MASTER_SPDM,
+	MSM8953_MASTER_BLSP_1,
+	MSM8953_MASTER_BLSP_2,
+	MSM8953_MASTER_USB3,
+	MSM8953_MASTER_CRYPTO_CORE0,
+	MSM8953_MASTER_SDCC_1,
+	MSM8953_MASTER_SDCC_2,
+	MSM8953_SNOC_PNOC_MAS,
+	MSM8953_PNOC_M_0,
+	MSM8953_PNOC_M_1,
+	MSM8953_PNOC_INT_1,
+	MSM8953_PNOC_INT_2,
+	MSM8953_PNOC_SLV_0,
+	MSM8953_PNOC_SLV_1,
+	MSM8953_PNOC_SLV_2,
+	MSM8953_PNOC_SLV_3,
+	MSM8953_PNOC_SLV_4,
+	MSM8953_PNOC_SLV_6,
+	MSM8953_PNOC_SLV_7,
+	MSM8953_PNOC_SLV_8,
+	MSM8953_PNOC_SLV_9,
+	MSM8953_SLAVE_SPDM_WRAPPER,
+	MSM8953_SLAVE_PDM,
+	MSM8953_SLAVE_TCSR,
+	MSM8953_SLAVE_SNOC_CFG,
+	MSM8953_SLAVE_TLMM,
+	MSM8953_SLAVE_MESSAGE_RAM,
+	MSM8953_SLAVE_BLSP_1,
+	MSM8953_SLAVE_BLSP_2,
+	MSM8953_SLAVE_PRNG,
+	MSM8953_SLAVE_CAMERA_CFG,
+	MSM8953_SLAVE_DISPLAY_CFG,
+	MSM8953_SLAVE_VENUS_CFG,
+	MSM8953_SLAVE_GRAPHICS_3D_CFG,
+	MSM8953_SLAVE_SDCC_1,
+	MSM8953_SLAVE_SDCC_2,
+	MSM8953_SLAVE_CRYPTO_0_CFG,
+	MSM8953_SLAVE_PMIC_ARB,
+	MSM8953_SLAVE_USB3,
+	MSM8953_SLAVE_IPA_CFG,
+	MSM8953_SLAVE_TCU,
+	MSM8953_PNOC_SNOC_SLV,
+	MSM8953_MASTER_QDSS_BAM,
+	MSM8953_BIMC_SNOC_MAS,
+	MSM8953_PNOC_SNOC_MAS,
+	MSM8953_MASTER_IPA,
+	MSM8953_MASTER_QDSS_ETR,
+	MSM8953_SNOC_QDSS_INT,
+	MSM8953_SNOC_INT_0,
+	MSM8953_SNOC_INT_1,
+	MSM8953_SNOC_INT_2,
+	MSM8953_SLAVE_APPSS,
+	MSM8953_SLAVE_WCSS,
+	MSM8953_SNOC_BIMC_1_SLV,
+	MSM8953_SLAVE_OCIMEM,
+	MSM8953_SNOC_PNOC_SLV,
+	MSM8953_SLAVE_QDSS_STM,
+	MSM8953_SLAVE_OCMEM_64,
+	MSM8953_SLAVE_LPASS,
+	MSM8953_MASTER_JPEG,
+	MSM8953_MASTER_MDP_PORT0,
+	MSM8953_MASTER_VIDEO_P0,
+	MSM8953_MASTER_VFE,
+	MSM8953_MASTER_VFE1,
+	MSM8953_MASTER_CPP,
+	MSM8953_SNOC_BIMC_0_SLV,
+	MSM8953_SNOC_BIMC_2_SLV,
+	MSM8953_SLAVE_CATS_128,
+};
+
+static const u16 mas_apps_proc_links[] = {
+	MSM8953_SLAVE_EBI_CH0,
+	MSM8953_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_apps_proc = {
+	.name = "mas_apps_proc",
+	.id = MSM8953_MASTER_AMPSS_M0,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 0,
+	.num_links = ARRAY_SIZE(mas_apps_proc_links),
+	.links = mas_apps_proc_links,
+};
+
+static const u16 mas_oxili_links[] = {
+	MSM8953_SLAVE_EBI_CH0,
+	MSM8953_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_oxili = {
+	.name = "mas_oxili",
+	.id = MSM8953_MASTER_GRAPHICS_3D,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 2,
+	.num_links = ARRAY_SIZE(mas_oxili_links),
+	.links = mas_oxili_links,
+};
+
+static const u16 mas_snoc_bimc_0_links[] = {
+	MSM8953_SLAVE_EBI_CH0,
+	MSM8953_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_snoc_bimc_0 = {
+	.name = "mas_snoc_bimc_0",
+	.id = MSM8953_SNOC_BIMC_0_MAS,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 3,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_0_links),
+	.links = mas_snoc_bimc_0_links,
+};
+
+static const u16 mas_snoc_bimc_2_links[] = {
+	MSM8953_SLAVE_EBI_CH0,
+	MSM8953_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_snoc_bimc_2 = {
+	.name = "mas_snoc_bimc_2",
+	.id = MSM8953_SNOC_BIMC_2_MAS,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 4,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_2_links),
+	.links = mas_snoc_bimc_2_links,
+};
+
+static const u16 mas_snoc_bimc_1_links[] = {
+	MSM8953_SLAVE_EBI_CH0
+};
+
+static struct qcom_icc_node mas_snoc_bimc_1 = {
+	.name = "mas_snoc_bimc_1",
+	.id = MSM8953_SNOC_BIMC_1_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 76,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_bimc_1_links),
+	.links = mas_snoc_bimc_1_links,
+};
+
+static const u16 mas_tcu_0_links[] = {
+	MSM8953_SLAVE_EBI_CH0,
+	MSM8953_BIMC_SNOC_SLV
+};
+
+static struct qcom_icc_node mas_tcu_0 = {
+	.name = "mas_tcu_0",
+	.id = MSM8953_MASTER_TCU_0,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 2,
+	.qos.areq_prio = 2,
+	.qos.qos_port = 6,
+	.num_links = ARRAY_SIZE(mas_tcu_0_links),
+	.links = mas_tcu_0_links,
+};
+
+static struct qcom_icc_node slv_ebi = {
+	.name = "slv_ebi",
+	.id = MSM8953_SLAVE_EBI_CH0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 0,
+};
+
+static const u16 slv_bimc_snoc_links[] = {
+	MSM8953_BIMC_SNOC_MAS
+};
+
+static struct qcom_icc_node slv_bimc_snoc = {
+	.name = "slv_bimc_snoc",
+	.id = MSM8953_BIMC_SNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 2,
+	.num_links = ARRAY_SIZE(slv_bimc_snoc_links),
+	.links = slv_bimc_snoc_links,
+};
+
+static const u16 mas_spdm_links[] = {
+	MSM8953_PNOC_M_0
+};
+
+static struct qcom_icc_node mas_spdm = {
+	.name = "mas_spdm",
+	.id = MSM8953_MASTER_SPDM,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(mas_spdm_links),
+	.links = mas_spdm_links,
+};
+
+static const u16 mas_blsp_1_links[] = {
+	MSM8953_PNOC_M_1
+};
+
+static struct qcom_icc_node mas_blsp_1 = {
+	.name = "mas_blsp_1",
+	.id = MSM8953_MASTER_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = 41,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_blsp_1_links),
+	.links = mas_blsp_1_links,
+};
+
+static const u16 mas_blsp_2_links[] = {
+	MSM8953_PNOC_M_1
+};
+
+static struct qcom_icc_node mas_blsp_2 = {
+	.name = "mas_blsp_2",
+	.id = MSM8953_MASTER_BLSP_2,
+	.buswidth = 4,
+	.mas_rpm_id = 39,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_blsp_2_links),
+	.links = mas_blsp_2_links,
+};
+
+static const u16 mas_usb3_links[] = {
+	MSM8953_PNOC_INT_1
+};
+
+static struct qcom_icc_node mas_usb3 = {
+	.name = "mas_usb3",
+	.id = MSM8953_MASTER_USB3,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 1,
+	.qos.areq_prio = 1,
+	.qos.qos_port = 11,
+	.num_links = ARRAY_SIZE(mas_usb3_links),
+	.links = mas_usb3_links,
+};
+
+static const u16 mas_crypto_links[] = {
+	MSM8953_PNOC_INT_1
+};
+
+static struct qcom_icc_node mas_crypto = {
+	.name = "mas_crypto",
+	.id = MSM8953_MASTER_CRYPTO_CORE0,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 1,
+	.qos.areq_prio = 1,
+	.qos.qos_port = 0,
+	.num_links = ARRAY_SIZE(mas_crypto_links),
+	.links = mas_crypto_links,
+};
+
+static const u16 mas_sdcc_1_links[] = {
+	MSM8953_PNOC_INT_1
+};
+
+static struct qcom_icc_node mas_sdcc_1 = {
+	.name = "mas_sdcc_1",
+	.id = MSM8953_MASTER_SDCC_1,
+	.buswidth = 8,
+	.mas_rpm_id = 33,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_1_links),
+	.links = mas_sdcc_1_links,
+};
+
+static const u16 mas_sdcc_2_links[] = {
+	MSM8953_PNOC_INT_1
+};
+
+static struct qcom_icc_node mas_sdcc_2 = {
+	.name = "mas_sdcc_2",
+	.id = MSM8953_MASTER_SDCC_2,
+	.buswidth = 8,
+	.mas_rpm_id = 35,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_sdcc_2_links),
+	.links = mas_sdcc_2_links,
+};
+
+static const u16 mas_snoc_pcnoc_links[] = {
+	MSM8953_PNOC_INT_2
+};
+
+static struct qcom_icc_node mas_snoc_pcnoc = {
+	.name = "mas_snoc_pcnoc",
+	.id = MSM8953_SNOC_PNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 77,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_snoc_pcnoc_links),
+	.links = mas_snoc_pcnoc_links,
+};
+
+static const u16 pcnoc_m_0_links[] = {
+	MSM8953_PNOC_INT_1
+};
+
+static struct qcom_icc_node pcnoc_m_0 = {
+	.name = "pcnoc_m_0",
+	.id = MSM8953_PNOC_M_0,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 1,
+	.qos.areq_prio = 1,
+	.qos.qos_port = 5,
+	.num_links = ARRAY_SIZE(pcnoc_m_0_links),
+	.links = pcnoc_m_0_links,
+};
+
+static const u16 pcnoc_m_1_links[] = {
+	MSM8953_PNOC_INT_1
+};
+
+static struct qcom_icc_node pcnoc_m_1 = {
+	.name = "pcnoc_m_1",
+	.id = MSM8953_PNOC_M_1,
+	.buswidth = 4,
+	.mas_rpm_id = 88,
+	.slv_rpm_id = 117,
+	.num_links = ARRAY_SIZE(pcnoc_m_1_links),
+	.links = pcnoc_m_1_links,
+};
+
+static const u16 pcnoc_int_1_links[] = {
+	MSM8953_PNOC_INT_2,
+	MSM8953_PNOC_SNOC_SLV
+};
+
+static struct qcom_icc_node pcnoc_int_1 = {
+	.name = "pcnoc_int_1",
+	.id = MSM8953_PNOC_INT_1,
+	.buswidth = 8,
+	.mas_rpm_id = 86,
+	.slv_rpm_id = 115,
+	.num_links = ARRAY_SIZE(pcnoc_int_1_links),
+	.links = pcnoc_int_1_links,
+};
+
+static const u16 pcnoc_int_2_links[] = {
+	MSM8953_PNOC_SLV_1,
+	MSM8953_PNOC_SLV_2,
+	MSM8953_PNOC_SLV_0,
+	MSM8953_PNOC_SLV_4,
+	MSM8953_PNOC_SLV_6,
+	MSM8953_PNOC_SLV_7,
+	MSM8953_PNOC_SLV_8,
+	MSM8953_PNOC_SLV_9,
+	MSM8953_SLAVE_TCU,
+	MSM8953_SLAVE_GRAPHICS_3D_CFG,
+	MSM8953_PNOC_SLV_3
+};
+
+static struct qcom_icc_node pcnoc_int_2 = {
+	.name = "pcnoc_int_2",
+	.id = MSM8953_PNOC_INT_2,
+	.buswidth = 8,
+	.mas_rpm_id = 124,
+	.slv_rpm_id = 184,
+	.num_links = ARRAY_SIZE(pcnoc_int_2_links),
+	.links = pcnoc_int_2_links,
+};
+
+static const u16 pcnoc_s_0_links[] = {
+	MSM8953_SLAVE_PDM,
+	MSM8953_SLAVE_SPDM_WRAPPER
+};
+
+static struct qcom_icc_node pcnoc_s_0 = {
+	.name = "pcnoc_s_0",
+	.id = MSM8953_PNOC_SLV_0,
+	.buswidth = 4,
+	.mas_rpm_id = 89,
+	.slv_rpm_id = 118,
+	.num_links = ARRAY_SIZE(pcnoc_s_0_links),
+	.links = pcnoc_s_0_links,
+};
+
+static const u16 pcnoc_s_1_links[] = {
+	MSM8953_SLAVE_TCSR
+};
+
+static struct qcom_icc_node pcnoc_s_1 = {
+	.name = "pcnoc_s_1",
+	.id = MSM8953_PNOC_SLV_1,
+	.buswidth = 4,
+	.mas_rpm_id = 90,
+	.slv_rpm_id = 119,
+	.num_links = ARRAY_SIZE(pcnoc_s_1_links),
+	.links = pcnoc_s_1_links,
+};
+
+static const u16 pcnoc_s_2_links[] = {
+	MSM8953_SLAVE_SNOC_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_2 = {
+	.name = "pcnoc_s_2",
+	.id = MSM8953_PNOC_SLV_2,
+	.buswidth = 4,
+	.mas_rpm_id = 91,
+	.slv_rpm_id = 120,
+	.num_links = ARRAY_SIZE(pcnoc_s_2_links),
+	.links = pcnoc_s_2_links,
+};
+
+static const u16 pcnoc_s_3_links[] = {
+	MSM8953_SLAVE_TLMM,
+	MSM8953_SLAVE_PRNG,
+	MSM8953_SLAVE_BLSP_1,
+	MSM8953_SLAVE_BLSP_2,
+	MSM8953_SLAVE_MESSAGE_RAM
+};
+
+static struct qcom_icc_node pcnoc_s_3 = {
+	.name = "pcnoc_s_3",
+	.id = MSM8953_PNOC_SLV_3,
+	.buswidth = 4,
+	.mas_rpm_id = 92,
+	.slv_rpm_id = 121,
+	.num_links = ARRAY_SIZE(pcnoc_s_3_links),
+	.links = pcnoc_s_3_links,
+};
+
+static const u16 pcnoc_s_4_links[] = {
+	MSM8953_SLAVE_CAMERA_CFG,
+	MSM8953_SLAVE_DISPLAY_CFG,
+	MSM8953_SLAVE_VENUS_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_4 = {
+	.name = "pcnoc_s_4",
+	.id = MSM8953_PNOC_SLV_4,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_4_links),
+	.links = pcnoc_s_4_links,
+};
+
+static const u16 pcnoc_s_6_links[] = {
+	MSM8953_SLAVE_CRYPTO_0_CFG,
+	MSM8953_SLAVE_SDCC_2,
+	MSM8953_SLAVE_SDCC_1
+};
+
+static struct qcom_icc_node pcnoc_s_6 = {
+	.name = "pcnoc_s_6",
+	.id = MSM8953_PNOC_SLV_6,
+	.buswidth = 4,
+	.mas_rpm_id = 94,
+	.slv_rpm_id = 123,
+	.num_links = ARRAY_SIZE(pcnoc_s_6_links),
+	.links = pcnoc_s_6_links,
+};
+
+static const u16 pcnoc_s_7_links[] = {
+	MSM8953_SLAVE_PMIC_ARB
+};
+
+static struct qcom_icc_node pcnoc_s_7 = {
+	.name = "pcnoc_s_7",
+	.id = MSM8953_PNOC_SLV_7,
+	.buswidth = 4,
+	.mas_rpm_id = 95,
+	.slv_rpm_id = 124,
+	.num_links = ARRAY_SIZE(pcnoc_s_7_links),
+	.links = pcnoc_s_7_links,
+};
+
+static const u16 pcnoc_s_8_links[] = {
+	MSM8953_SLAVE_USB3
+};
+
+static struct qcom_icc_node pcnoc_s_8 = {
+	.name = "pcnoc_s_8",
+	.id = MSM8953_PNOC_SLV_8,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_8_links),
+	.links = pcnoc_s_8_links,
+};
+
+static const u16 pcnoc_s_9_links[] = {
+	MSM8953_SLAVE_IPA_CFG
+};
+
+static struct qcom_icc_node pcnoc_s_9 = {
+	.name = "pcnoc_s_9",
+	.id = MSM8953_PNOC_SLV_9,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(pcnoc_s_9_links),
+	.links = pcnoc_s_9_links,
+};
+
+static struct qcom_icc_node slv_spdm = {
+	.name = "slv_spdm",
+	.id = MSM8953_SLAVE_SPDM_WRAPPER,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_pdm = {
+	.name = "slv_pdm",
+	.id = MSM8953_SLAVE_PDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 41,
+};
+
+static struct qcom_icc_node slv_tcsr = {
+	.name = "slv_tcsr",
+	.id = MSM8953_SLAVE_TCSR,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 50,
+};
+
+static struct qcom_icc_node slv_snoc_cfg = {
+	.name = "slv_snoc_cfg",
+	.id = MSM8953_SLAVE_SNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 70,
+};
+
+static struct qcom_icc_node slv_tlmm = {
+	.name = "slv_tlmm",
+	.id = MSM8953_SLAVE_TLMM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 51,
+};
+
+static struct qcom_icc_node slv_message_ram = {
+	.name = "slv_message_ram",
+	.id = MSM8953_SLAVE_MESSAGE_RAM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 55,
+};
+
+static struct qcom_icc_node slv_blsp_1 = {
+	.name = "slv_blsp_1",
+	.id = MSM8953_SLAVE_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 39,
+};
+
+static struct qcom_icc_node slv_blsp_2 = {
+	.name = "slv_blsp_2",
+	.id = MSM8953_SLAVE_BLSP_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 37,
+};
+
+static struct qcom_icc_node slv_prng = {
+	.name = "slv_prng",
+	.id = MSM8953_SLAVE_PRNG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 44,
+};
+
+static struct qcom_icc_node slv_camera_ss_cfg = {
+	.name = "slv_camera_ss_cfg",
+	.id = MSM8953_SLAVE_CAMERA_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_disp_ss_cfg = {
+	.name = "slv_disp_ss_cfg",
+	.id = MSM8953_SLAVE_DISPLAY_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_venus_cfg = {
+	.name = "slv_venus_cfg",
+	.id = MSM8953_SLAVE_VENUS_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_gpu_cfg = {
+	.name = "slv_gpu_cfg",
+	.id = MSM8953_SLAVE_GRAPHICS_3D_CFG,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_sdcc_1 = {
+	.name = "slv_sdcc_1",
+	.id = MSM8953_SLAVE_SDCC_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 31,
+};
+
+static struct qcom_icc_node slv_sdcc_2 = {
+	.name = "slv_sdcc_2",
+	.id = MSM8953_SLAVE_SDCC_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 33,
+};
+
+static struct qcom_icc_node slv_crypto_0_cfg = {
+	.name = "slv_crypto_0_cfg",
+	.id = MSM8953_SLAVE_CRYPTO_0_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_pmic_arb = {
+	.name = "slv_pmic_arb",
+	.id = MSM8953_SLAVE_PMIC_ARB,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 59,
+};
+
+static struct qcom_icc_node slv_usb3 = {
+	.name = "slv_usb3",
+	.id = MSM8953_SLAVE_USB3,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_ipa_cfg = {
+	.name = "slv_ipa_cfg",
+	.id = MSM8953_SLAVE_IPA_CFG,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_tcu = {
+	.name = "slv_tcu",
+	.id = MSM8953_SLAVE_TCU,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_pcnoc_snoc_links[] = {
+	MSM8953_PNOC_SNOC_MAS
+};
+
+static struct qcom_icc_node slv_pcnoc_snoc = {
+	.name = "slv_pcnoc_snoc",
+	.id = MSM8953_PNOC_SNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 45,
+	.num_links = ARRAY_SIZE(slv_pcnoc_snoc_links),
+	.links = slv_pcnoc_snoc_links,
+};
+
+static const u16 mas_qdss_bam_links[] = {
+	MSM8953_SNOC_QDSS_INT
+};
+
+static struct qcom_icc_node mas_qdss_bam = {
+	.name = "mas_qdss_bam",
+	.id = MSM8953_MASTER_QDSS_BAM,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 1,
+	.qos.areq_prio = 1,
+	.qos.qos_port = 11,
+	.num_links = ARRAY_SIZE(mas_qdss_bam_links),
+	.links = mas_qdss_bam_links,
+};
+
+static const u16 mas_bimc_snoc_links[] = {
+	MSM8953_SNOC_INT_0,
+	MSM8953_SNOC_INT_1,
+	MSM8953_SNOC_INT_2
+};
+
+static struct qcom_icc_node mas_bimc_snoc = {
+	.name = "mas_bimc_snoc",
+	.id = MSM8953_BIMC_SNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 21,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_bimc_snoc_links),
+	.links = mas_bimc_snoc_links,
+};
+
+static const u16 mas_pcnoc_snoc_links[] = {
+	MSM8953_SNOC_INT_0,
+	MSM8953_SNOC_INT_1,
+	MSM8953_SNOC_BIMC_1_SLV
+};
+
+static struct qcom_icc_node mas_pcnoc_snoc = {
+	.name = "mas_pcnoc_snoc",
+	.id = MSM8953_PNOC_SNOC_MAS,
+	.buswidth = 8,
+	.mas_rpm_id = 29,
+	.slv_rpm_id = -1,
+	.num_links = ARRAY_SIZE(mas_pcnoc_snoc_links),
+	.links = mas_pcnoc_snoc_links,
+};
+
+static const u16 mas_ipa_links[] = {
+	MSM8953_SNOC_INT_0,
+	MSM8953_SNOC_INT_1,
+	MSM8953_SNOC_BIMC_1_SLV
+};
+
+static struct qcom_icc_node mas_ipa = {
+	.name = "mas_ipa",
+	.id = MSM8953_MASTER_IPA,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 14,
+	.num_links = ARRAY_SIZE(mas_ipa_links),
+	.links = mas_ipa_links,
+};
+
+static const u16 mas_qdss_etr_links[] = {
+	MSM8953_SNOC_QDSS_INT
+};
+
+static struct qcom_icc_node mas_qdss_etr = {
+	.name = "mas_qdss_etr",
+	.id = MSM8953_MASTER_QDSS_ETR,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.prio_level = 1,
+	.qos.areq_prio = 1,
+	.qos.qos_port = 10,
+	.num_links = ARRAY_SIZE(mas_qdss_etr_links),
+	.links = mas_qdss_etr_links,
+};
+
+static const u16 qdss_int_links[] = {
+	MSM8953_SNOC_INT_1,
+	MSM8953_SNOC_BIMC_1_SLV
+};
+
+static struct qcom_icc_node qdss_int = {
+	.name = "qdss_int",
+	.id = MSM8953_SNOC_QDSS_INT,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(qdss_int_links),
+	.links = qdss_int_links,
+};
+
+static const u16 snoc_int_0_links[] = {
+	MSM8953_SLAVE_LPASS,
+	MSM8953_SLAVE_WCSS,
+	MSM8953_SLAVE_APPSS
+};
+
+static struct qcom_icc_node snoc_int_0 = {
+	.name = "snoc_int_0",
+	.id = MSM8953_SNOC_INT_0,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(snoc_int_0_links),
+	.links = snoc_int_0_links,
+};
+
+static const u16 snoc_int_1_links[] = {
+	MSM8953_SLAVE_QDSS_STM,
+	MSM8953_SLAVE_OCIMEM,
+	MSM8953_SNOC_PNOC_SLV
+};
+
+static struct qcom_icc_node snoc_int_1 = {
+	.name = "snoc_int_1",
+	.id = MSM8953_SNOC_INT_1,
+	.buswidth = 8,
+	.mas_rpm_id = 100,
+	.slv_rpm_id = 131,
+	.num_links = ARRAY_SIZE(snoc_int_1_links),
+	.links = snoc_int_1_links,
+};
+
+static const u16 snoc_int_2_links[] = {
+	MSM8953_SLAVE_CATS_128,
+	MSM8953_SLAVE_OCMEM_64
+};
+
+static struct qcom_icc_node snoc_int_2 = {
+	.name = "snoc_int_2",
+	.id = MSM8953_SNOC_INT_2,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(snoc_int_2_links),
+	.links = snoc_int_2_links,
+};
+
+static struct qcom_icc_node slv_kpss_ahb = {
+	.name = "slv_kpss_ahb",
+	.id = MSM8953_SLAVE_APPSS,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_wcss = {
+	.name = "slv_wcss",
+	.id = MSM8953_SLAVE_WCSS,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 slv_snoc_bimc_1_links[] = {
+	MSM8953_SNOC_BIMC_1_MAS
+};
+
+static struct qcom_icc_node slv_snoc_bimc_1 = {
+	.name = "slv_snoc_bimc_1",
+	.id = MSM8953_SNOC_BIMC_1_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 104,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_1_links),
+	.links = slv_snoc_bimc_1_links,
+};
+
+static struct qcom_icc_node slv_imem = {
+	.name = "slv_imem",
+	.id = MSM8953_SLAVE_OCIMEM,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 26,
+};
+
+static const u16 slv_snoc_pcnoc_links[] = {
+	MSM8953_SNOC_PNOC_MAS
+};
+
+static struct qcom_icc_node slv_snoc_pcnoc = {
+	.name = "slv_snoc_pcnoc",
+	.id = MSM8953_SNOC_PNOC_SLV,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 28,
+	.num_links = ARRAY_SIZE(slv_snoc_pcnoc_links),
+	.links = slv_snoc_pcnoc_links,
+};
+
+static struct qcom_icc_node slv_qdss_stm = {
+	.name = "slv_qdss_stm",
+	.id = MSM8953_SLAVE_QDSS_STM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 30,
+};
+
+static struct qcom_icc_node slv_cats_1 = {
+	.name = "slv_cats_1",
+	.id = MSM8953_SLAVE_OCMEM_64,
+	.buswidth = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node slv_lpass = {
+	.name = "slv_lpass",
+	.id = MSM8953_SLAVE_LPASS,
+	.buswidth = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static const u16 mas_jpeg_links[] = {
+	MSM8953_SNOC_BIMC_2_SLV
+};
+
+static struct qcom_icc_node mas_jpeg = {
+	.name = "mas_jpeg",
+	.id = MSM8953_MASTER_JPEG,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 6,
+	.num_links = ARRAY_SIZE(mas_jpeg_links),
+	.links = mas_jpeg_links,
+};
+
+static const u16 mas_mdp_links[] = {
+	MSM8953_SNOC_BIMC_0_SLV
+};
+
+static struct qcom_icc_node mas_mdp = {
+	.name = "mas_mdp",
+	.id = MSM8953_MASTER_MDP_PORT0,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 7,
+	.num_links = ARRAY_SIZE(mas_mdp_links),
+	.links = mas_mdp_links,
+};
+
+static const u16 mas_venus_links[] = {
+	MSM8953_SNOC_BIMC_2_SLV
+};
+
+static struct qcom_icc_node mas_venus = {
+	.name = "mas_venus",
+	.id = MSM8953_MASTER_VIDEO_P0,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 8,
+	.num_links = ARRAY_SIZE(mas_venus_links),
+	.links = mas_venus_links,
+};
+
+static const u16 mas_vfe0_links[] = {
+	MSM8953_SNOC_BIMC_0_SLV
+};
+
+static struct qcom_icc_node mas_vfe0 = {
+	.name = "mas_vfe0",
+	.id = MSM8953_MASTER_VFE,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 9,
+	.num_links = ARRAY_SIZE(mas_vfe0_links),
+	.links = mas_vfe0_links,
+};
+
+static const u16 mas_vfe1_links[] = {
+	MSM8953_SNOC_BIMC_0_SLV
+};
+
+static struct qcom_icc_node mas_vfe1 = {
+	.name = "mas_vfe1",
+	.id = MSM8953_MASTER_VFE1,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 13,
+	.num_links = ARRAY_SIZE(mas_vfe1_links),
+	.links = mas_vfe1_links,
+};
+
+static const u16 mas_cpp_links[] = {
+	MSM8953_SNOC_BIMC_2_SLV
+};
+
+static struct qcom_icc_node mas_cpp = {
+	.name = "mas_cpp",
+	.id = MSM8953_MASTER_CPP,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = 12,
+	.num_links = ARRAY_SIZE(mas_cpp_links),
+	.links = mas_cpp_links,
+};
+
+static const u16 slv_snoc_bimc_0_links[] = {
+	MSM8953_SNOC_BIMC_0_MAS
+};
+
+static struct qcom_icc_node slv_snoc_bimc_0 = {
+	.name = "slv_snoc_bimc_0",
+	.id = MSM8953_SNOC_BIMC_0_SLV,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_0_links),
+	.links = slv_snoc_bimc_0_links,
+};
+
+static const u16 slv_snoc_bimc_2_links[] = {
+	MSM8953_SNOC_BIMC_2_MAS
+};
+
+static struct qcom_icc_node slv_snoc_bimc_2 = {
+	.name = "slv_snoc_bimc_2",
+	.id = MSM8953_SNOC_BIMC_2_SLV,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+	.num_links = ARRAY_SIZE(slv_snoc_bimc_2_links),
+	.links = slv_snoc_bimc_2_links,
+};
+
+static struct qcom_icc_node slv_cats_0 = {
+	.name = "slv_cats_0",
+	.id = MSM8953_SLAVE_CATS_128,
+	.buswidth = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.qos.prio_level = 0,
+	.qos.areq_prio = 0,
+	.qos.qos_port = -1,
+};
+
+static struct qcom_icc_node * const msm8953_bimc_nodes[] = {
+	[MAS_APPS_PROC] = &mas_apps_proc,
+	[MAS_OXILI] = &mas_oxili,
+	[MAS_SNOC_BIMC_0] = &mas_snoc_bimc_0,
+	[MAS_SNOC_BIMC_2] = &mas_snoc_bimc_2,
+	[MAS_SNOC_BIMC_1] = &mas_snoc_bimc_1,
+	[MAS_TCU_0] = &mas_tcu_0,
+	[SLV_EBI] = &slv_ebi,
+	[SLV_BIMC_SNOC] = &slv_bimc_snoc,
+};
+
+static const struct regmap_config msm8953_bimc_regmap_config = {
+	.fast_io = true,
+	.max_register = 0x5a000,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static const struct qcom_icc_desc msm8953_bimc = {
+	.type = QCOM_ICC_BIMC,
+	.bus_clk_desc = &bimc_clk,
+	.nodes = msm8953_bimc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8953_bimc_nodes),
+	.qos_offset = 0x8000,
+	.regmap_cfg = &msm8953_bimc_regmap_config
+};
+
+static struct qcom_icc_node * const msm8953_pcnoc_nodes[] = {
+	[MAS_SPDM] = &mas_spdm,
+	[MAS_BLSP_1] = &mas_blsp_1,
+	[MAS_BLSP_2] = &mas_blsp_2,
+	[MAS_USB3] = &mas_usb3,
+	[MAS_CRYPTO] = &mas_crypto,
+	[MAS_SDCC_1] = &mas_sdcc_1,
+	[MAS_SDCC_2] = &mas_sdcc_2,
+	[MAS_SNOC_PCNOC] = &mas_snoc_pcnoc,
+	[PCNOC_M_0] = &pcnoc_m_0,
+	[PCNOC_M_1] = &pcnoc_m_1,
+	[PCNOC_INT_1] = &pcnoc_int_1,
+	[PCNOC_INT_2] = &pcnoc_int_2,
+	[PCNOC_S_0] = &pcnoc_s_0,
+	[PCNOC_S_1] = &pcnoc_s_1,
+	[PCNOC_S_2] = &pcnoc_s_2,
+	[PCNOC_S_3] = &pcnoc_s_3,
+	[PCNOC_S_4] = &pcnoc_s_4,
+	[PCNOC_S_6] = &pcnoc_s_6,
+	[PCNOC_S_7] = &pcnoc_s_7,
+	[PCNOC_S_8] = &pcnoc_s_8,
+	[PCNOC_S_9] = &pcnoc_s_9,
+	[SLV_SPDM] = &slv_spdm,
+	[SLV_PDM] = &slv_pdm,
+	[SLV_TCSR] = &slv_tcsr,
+	[SLV_SNOC_CFG] = &slv_snoc_cfg,
+	[SLV_TLMM] = &slv_tlmm,
+	[SLV_MESSAGE_RAM] = &slv_message_ram,
+	[SLV_BLSP_1] = &slv_blsp_1,
+	[SLV_BLSP_2] = &slv_blsp_2,
+	[SLV_PRNG] = &slv_prng,
+	[SLV_CAMERA_SS_CFG] = &slv_camera_ss_cfg,
+	[SLV_DISP_SS_CFG] = &slv_disp_ss_cfg,
+	[SLV_VENUS_CFG] = &slv_venus_cfg,
+	[SLV_GPU_CFG] = &slv_gpu_cfg,
+	[SLV_SDCC_1] = &slv_sdcc_1,
+	[SLV_SDCC_2] = &slv_sdcc_2,
+	[SLV_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
+	[SLV_PMIC_ARB] = &slv_pmic_arb,
+	[SLV_USB3] = &slv_usb3,
+	[SLV_IPA_CFG] = &slv_ipa_cfg,
+	[SLV_TCU] = &slv_tcu,
+	[SLV_PCNOC_SNOC] = &slv_pcnoc_snoc,
+};
+
+static const char * const msm8953_pcnoc_intf_clocks[] = {
+	"pcnoc_usb3_axi"
+};
+
+static const struct regmap_config msm8953_pcnoc_regmap_config = {
+	.fast_io = true,
+	.max_register = 0x12080,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static const struct qcom_icc_desc msm8953_pcnoc = {
+	.type = QCOM_ICC_NOC,
+	.bus_clk_desc = &bus_0_clk,
+	.intf_clocks = msm8953_pcnoc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(msm8953_pcnoc_intf_clocks),
+	.nodes = msm8953_pcnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8953_pcnoc_nodes),
+	.qos_offset = 0x7000,
+	.regmap_cfg = &msm8953_pcnoc_regmap_config,
+};
+
+static struct qcom_icc_node * const msm8953_snoc_nodes[] = {
+	[MAS_QDSS_BAM] = &mas_qdss_bam,
+	[MAS_BIMC_SNOC] = &mas_bimc_snoc,
+	[MAS_PCNOC_SNOC] = &mas_pcnoc_snoc,
+	[MAS_IPA] = &mas_ipa,
+	[MAS_QDSS_ETR] = &mas_qdss_etr,
+	[QDSS_INT] = &qdss_int,
+	[SNOC_INT_0] = &snoc_int_0,
+	[SNOC_INT_1] = &snoc_int_1,
+	[SNOC_INT_2] = &snoc_int_2,
+	[SLV_KPSS_AHB] = &slv_kpss_ahb,
+	[SLV_WCSS] = &slv_wcss,
+	[SLV_SNOC_BIMC_1] = &slv_snoc_bimc_1,
+	[SLV_IMEM] = &slv_imem,
+	[SLV_SNOC_PCNOC] = &slv_snoc_pcnoc,
+	[SLV_QDSS_STM] = &slv_qdss_stm,
+	[SLV_CATS_1] = &slv_cats_1,
+	[SLV_LPASS] = &slv_lpass,
+};
+
+static const struct regmap_config msm8953_snoc_regmap_config = {
+	.fast_io = true,
+	.max_register = 0x16080,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static const struct qcom_icc_desc msm8953_snoc = {
+	.type = QCOM_ICC_NOC,
+	.bus_clk_desc = &bus_1_clk,
+	.nodes = msm8953_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8953_snoc_nodes),
+	.qos_offset = 0x7000,
+	.regmap_cfg = &msm8953_snoc_regmap_config,
+};
+
+static struct qcom_icc_node * const msm8953_snoc_mm_nodes[] = {
+	[MAS_JPEG] = &mas_jpeg,
+	[MAS_MDP] = &mas_mdp,
+	[MAS_VENUS] = &mas_venus,
+	[MAS_VFE0] = &mas_vfe0,
+	[MAS_VFE1] = &mas_vfe1,
+	[MAS_CPP] = &mas_cpp,
+	[SLV_SNOC_BIMC_0] = &slv_snoc_bimc_0,
+	[SLV_SNOC_BIMC_2] = &slv_snoc_bimc_2,
+	[SLV_CATS_0] = &slv_cats_0,
+};
+
+static const struct qcom_icc_desc msm8953_snoc_mm = {
+	.type = QCOM_ICC_NOC,
+	.bus_clk_desc = &bus_2_clk,
+	.nodes = msm8953_snoc_mm_nodes,
+	.num_nodes = ARRAY_SIZE(msm8953_snoc_mm_nodes),
+	.qos_offset = 0x7000,
+	.regmap_cfg = &msm8953_snoc_regmap_config,
+};
+
+static const struct of_device_id msm8953_noc_of_match[] = {
+	{ .compatible = "qcom,msm8953-bimc", .data = &msm8953_bimc },
+	{ .compatible = "qcom,msm8953-pcnoc", .data = &msm8953_pcnoc },
+	{ .compatible = "qcom,msm8953-snoc", .data = &msm8953_snoc },
+	{ .compatible = "qcom,msm8953-snoc-mm", .data = &msm8953_snoc_mm },
+	{ }
+};
+
+static struct platform_driver msm8953_noc_driver = {
+	.probe = qnoc_probe,
+	.remove_new = qnoc_remove,
+	.driver = {
+		.name = "qnoc-msm8953",
+		.of_match_table = msm8953_noc_of_match,
+	},
+};
+
+module_platform_driver(msm8953_noc_driver);
+MODULE_DEVICE_TABLE(of, msm8953_noc_of_match);
+MODULE_DESCRIPTION("Qualcomm MSM8953 NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.45.2


