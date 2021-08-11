Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384453E8986
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 06:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhHKEiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 00:38:20 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:51919 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhHKEiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 00:38:17 -0400
Date:   Wed, 11 Aug 2021 04:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628656666;
        bh=RltulBp7rqNelo/j5a8H4i8pEu3d0xVpcVreZ7oDurY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=xGO6JUOIF7w3M2N3WBZw/qEZzATuGGHvweITOcAhukK+7elDX0eSi4jQWpI1KxDtY
         RLRy9gDkt9Og+9S4+4RenebAu/sdtGakLezZVB7obNga2ajjVyx8pjU6QEC/S1pSmI
         Shf+d4VK3Ea9pin79zucbD0B7PMkKX8iDP9LXgVY=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v3 5/6] interconnect: qcom: Add MSM8996 interconnect provider driver
Message-ID: <20210811043451.189776-6-y.oudjana@protonmail.com>
In-Reply-To: <20210811043451.189776-1-y.oudjana@protonmail.com>
References: <20210811043451.189776-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a driver for the MSM8996 NoCs. This chip is similar to SDM660 where
some busses are controlled by RPM, while others directly by the AP with
writes to QoS registers.

This driver currently supports all NoCs except a0noc.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/interconnect/qcom/Kconfig   |   9 +
 drivers/interconnect/qcom/Makefile  |   2 +
 drivers/interconnect/qcom/msm8996.c | 574 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/msm8996.h | 149 ++++++++
 4 files changed, 734 insertions(+)
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/=
Kconfig
index ad16224f1720..e30ad95e5584 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -35,6 +35,15 @@ config INTERCONNECT_QCOM_MSM8974
 =09 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
 =09 platforms.
=20
+config INTERCONNECT_QCOM_MSM8996
+=09tristate "Qualcomm MSM8996 interconnect driver"
+=09depends on INTERCONNECT_QCOM
+=09depends on QCOM_SMD_RPM
+=09select INTERCONNECT_QCOM_SMD_RPM_QOS
+=09help
+=09  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
+=09  platforms.
+
 config INTERCONNECT_QCOM_OSM_L3
 =09tristate "Qualcomm OSM L3 interconnect driver"
 =09depends on INTERCONNECT_QCOM || COMPILE_TEST
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom=
/Makefile
index 2d04d024f46e..8a198b8b7a45 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,6 +4,7 @@ icc-bcm-voter-objs=09=09=09:=3D bcm-voter.o
 qnoc-msm8916-objs=09=09=09:=3D msm8916.o
 qnoc-msm8939-objs=09=09=09:=3D msm8939.o
 qnoc-msm8974-objs=09=09=09:=3D msm8974.o
+qnoc-msm8996-objs=09=09=09:=3D msm8996.o
 icc-osm-l3-objs=09=09=09=09:=3D osm-l3.o
 qnoc-qcs404-objs=09=09=09:=3D qcs404.o
 icc-rpmh-obj=09=09=09=09:=3D icc-rpmh.o
@@ -22,6 +23,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) +=3D icc-bcm-vo=
ter.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) +=3D qnoc-msm8916.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8939) +=3D qnoc-msm8939.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) +=3D qnoc-msm8974.o
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) +=3D qnoc-msm8996.o
 obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) +=3D icc-osm-l3.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) +=3D qnoc-qcs404.o
 obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) +=3D icc-rpmh.o
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qco=
m/msm8996.c
new file mode 100644
index 000000000000..0cb93d743f35
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -0,0 +1,574 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm MSM8996 Network-on-Chip (NoC) QoS driver
+ *
+ * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/interconnect/qcom,msm8996.h>
+
+#include "icc-rpm-qos.h"
+#include "smd-rpm.h"
+#include "msm8996.h"
+
+static const struct clk_bulk_data bus_clocks[] =3D {
+=09{ .id =3D "bus" },
+=09{ .id =3D "bus_a" },
+};
+
+static const struct clk_bulk_data bus_mm_clocks[] =3D {
+=09{ .id =3D "bus" },
+=09{ .id =3D "bus_a" },
+=09{ .id =3D "iface" },
+};
+
+DEFINE_QNODE(mas_cnoc_a1noc, MSM8996_MASTER_CNOC_A1NOC, 8, 116, -1, true, =
-1, 0, -1, MSM8996_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(mas_crypto_c0, MSM8996_MASTER_CRYPTO_CORE0, 8, 23, -1, true, =
NOC_QOS_MODE_FIXED, 1, 0, MSM8996_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(mas_pnoc_a1noc, MSM8996_MASTER_PNOC_A1NOC, 8, 117, -1, false,=
 NOC_QOS_MODE_FIXED, 0, 1, MSM8996_SLAVE_A1NOC_SNOC);
+DEFINE_QNODE(mas_usb3, MSM8996_MASTER_USB3, 8, 32, -1, true, NOC_QOS_MODE_=
FIXED, 1, 3, MSM8996_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_ipa, MSM8996_MASTER_IPA, 8, 59, -1, true, NOC_QOS_MODE_FI=
XED, 0, -1, MSM8996_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_ufs, MSM8996_MASTER_UFS, 8, 68, -1, true, NOC_QOS_MODE_FI=
XED, 1, 2, MSM8996_SLAVE_A2NOC_SNOC);
+DEFINE_QNODE(mas_apps_proc, MSM8996_MASTER_AMPSS_M0, 8, 0, -1, true, NOC_Q=
OS_MODE_FIXED, 0, 0, MSM8996_SLAVE_BIMC_SNOC_1, MSM8996_SLAVE_EBI_CH0, MSM8=
996_SLAVE_BIMC_SNOC_0);
+DEFINE_QNODE(mas_oxili, MSM8996_MASTER_GRAPHICS_3D, 8, 6, -1, true, NOC_QO=
S_MODE_BYPASS, 0, 1, MSM8996_SLAVE_BIMC_SNOC_1, MSM8996_SLAVE_HMSS_L3, MSM8=
996_SLAVE_EBI_CH0, MSM8996_SLAVE_BIMC_SNOC_0);
+DEFINE_QNODE(mas_mnoc_bimc, MSM8996_MASTER_MNOC_BIMC, 8, 2, -1, true, NOC_=
QOS_MODE_BYPASS, 0, 2, MSM8996_SLAVE_BIMC_SNOC_1, MSM8996_SLAVE_HMSS_L3, MS=
M8996_SLAVE_EBI_CH0, MSM8996_SLAVE_BIMC_SNOC_0);
+DEFINE_QNODE(mas_snoc_bimc, MSM8996_MASTER_SNOC_BIMC, 8, 3, -1, false, NOC=
_QOS_MODE_BYPASS, 0, -1, MSM8996_SLAVE_HMSS_L3, MSM8996_SLAVE_EBI_CH0);
+DEFINE_QNODE(mas_snoc_cnoc, MSM8996_MASTER_SNOC_CNOC, 8, 52, -1, false, -1=
, 0, -1, MSM8996_SLAVE_CLK_CTL, MSM8996_SLAVE_RBCPR_CX, MSM8996_SLAVE_A2NOC=
_SMMU_CFG, MSM8996_SLAVE_A0NOC_MPU_CFG, MSM8996_SLAVE_MESSAGE_RAM, MSM8996_=
SLAVE_CNOC_MNOC_MMSS_CFG, MSM8996_SLAVE_PCIE_0_CFG, MSM8996_SLAVE_TLMM, MSM=
8996_SLAVE_MPM, MSM8996_SLAVE_A0NOC_SMMU_CFG, MSM8996_SLAVE_EBI1_PHY_CFG, M=
SM8996_SLAVE_BIMC_CFG, MSM8996_SLAVE_PIMEM_CFG, MSM8996_SLAVE_RBCPR_MX, MSM=
8996_SLAVE_PRNG, MSM8996_SLAVE_PCIE20_AHB2PHY, MSM8996_SLAVE_A2NOC_MPU_CFG,=
 MSM8996_SLAVE_QDSS_CFG, MSM8996_SLAVE_A2NOC_CFG, MSM8996_SLAVE_A0NOC_CFG, =
MSM8996_SLAVE_UFS_CFG, MSM8996_SLAVE_CRYPTO_0_CFG, MSM8996_SLAVE_PCIE_1_CFG=
, MSM8996_SLAVE_SNOC_CFG, MSM8996_SLAVE_SNOC_MPU_CFG, MSM8996_SLAVE_A1NOC_M=
PU_CFG, MSM8996_SLAVE_A1NOC_SMMU_CFG, MSM8996_SLAVE_PCIE_2_CFG, MSM8996_SLA=
VE_CNOC_MNOC_CFG, MSM8996_SLAVE_QDSS_RBCPR_APU_CFG, MSM8996_SLAVE_PMIC_ARB,=
 MSM8996_SLAVE_IMEM_CFG, MSM8996_SLAVE_A1NOC_CFG, MSM8996_SLAVE_SSC_CFG, MS=
M8996_SLAVE_TCSR, MSM8996_SLAVE_LPASS_SMMU_CFG, MSM8996_SLAVE_DCC_CFG);
+DEFINE_QNODE(mas_qdss_dap, MSM8996_MASTER_QDSS_DAP, 8, 49, -1, true, -1, 0=
, -1, MSM8996_SLAVE_QDSS_RBCPR_APU_CFG, MSM8996_SLAVE_RBCPR_CX, MSM8996_SLA=
VE_A2NOC_SMMU_CFG, MSM8996_SLAVE_A0NOC_MPU_CFG, MSM8996_SLAVE_MESSAGE_RAM, =
MSM8996_SLAVE_PCIE_0_CFG, MSM8996_SLAVE_TLMM, MSM8996_SLAVE_MPM, MSM8996_SL=
AVE_A0NOC_SMMU_CFG, MSM8996_SLAVE_EBI1_PHY_CFG, MSM8996_SLAVE_BIMC_CFG, MSM=
8996_SLAVE_PIMEM_CFG, MSM8996_SLAVE_RBCPR_MX, MSM8996_SLAVE_CLK_CTL, MSM899=
6_SLAVE_PRNG, MSM8996_SLAVE_PCIE20_AHB2PHY, MSM8996_SLAVE_A2NOC_MPU_CFG, MS=
M8996_SLAVE_QDSS_CFG, MSM8996_SLAVE_A2NOC_CFG, MSM8996_SLAVE_A0NOC_CFG, MSM=
8996_SLAVE_UFS_CFG, MSM8996_SLAVE_CRYPTO_0_CFG, MSM8996_SLAVE_CNOC_A1NOC, M=
SM8996_SLAVE_PCIE_1_CFG, MSM8996_SLAVE_SNOC_CFG, MSM8996_SLAVE_SNOC_MPU_CFG=
, MSM8996_SLAVE_A1NOC_MPU_CFG, MSM8996_SLAVE_A1NOC_SMMU_CFG, MSM8996_SLAVE_=
PCIE_2_CFG, MSM8996_SLAVE_CNOC_MNOC_CFG, MSM8996_SLAVE_CNOC_MNOC_MMSS_CFG, =
MSM8996_SLAVE_PMIC_ARB, MSM8996_SLAVE_IMEM_CFG, MSM8996_SLAVE_A1NOC_CFG, MS=
M8996_SLAVE_SSC_CFG, MSM8996_SLAVE_TCSR, MSM8996_SLAVE_LPASS_SMMU_CFG, MSM8=
996_SLAVE_DCC_CFG);
+DEFINE_QNODE(mas_cnoc_mnoc_mmss_cfg, MSM8996_MASTER_CNOC_MNOC_MMSS_CFG, 8,=
 4, -1, true, -1, 0, -1, MSM8996_SLAVE_MMAGIC_CFG, MSM8996_SLAVE_DSA_MPU_CF=
G, MSM8996_SLAVE_MMSS_CLK_CFG, MSM8996_SLAVE_CAMERA_THROTTLE_CFG, MSM8996_S=
LAVE_VENUS_CFG, MSM8996_SLAVE_SMMU_VFE_CFG, MSM8996_SLAVE_MISC_CFG, MSM8996=
_SLAVE_SMMU_CPP_CFG, MSM8996_SLAVE_GRAPHICS_3D_CFG, MSM8996_SLAVE_DISPLAY_T=
HROTTLE_CFG, MSM8996_SLAVE_VENUS_THROTTLE_CFG, MSM8996_SLAVE_CAMERA_CFG, MS=
M8996_SLAVE_DISPLAY_CFG, MSM8996_SLAVE_CPR_CFG, MSM8996_SLAVE_SMMU_ROTATOR_=
CFG, MSM8996_SLAVE_DSA_CFG, MSM8996_SLAVE_SMMU_VENUS_CFG, MSM8996_SLAVE_VME=
M_CFG, MSM8996_SLAVE_SMMU_JPEG_CFG, MSM8996_SLAVE_SMMU_MDP_CFG, MSM8996_SLA=
VE_MNOC_MPU_CFG);
+DEFINE_QNODE(mas_cnoc_mnoc_cfg, MSM8996_MASTER_CNOC_MNOC_CFG, 8, 5, -1, tr=
ue, -1, 0, -1, MSM8996_SLAVE_SERVICE_MNOC);
+DEFINE_QNODE(mas_cpp, MSM8996_MASTER_CPP, 32, 115, -1, true, NOC_QOS_MODE_=
BYPASS, 0, 5, MSM8996_SLAVE_MNOC_BIMC);
+DEFINE_QNODE(mas_jpeg, MSM8996_MASTER_JPEG, 32, 7, -1, true, NOC_QOS_MODE_=
BYPASS, 0, 7, MSM8996_SLAVE_MNOC_BIMC);
+DEFINE_QNODE(mas_mdp_p0, MSM8996_MASTER_MDP_PORT0, 32, 8, -1, true, NOC_QO=
S_MODE_BYPASS, 0, 1, MSM8996_SLAVE_MNOC_BIMC);
+DEFINE_QNODE(mas_mdp_p1, MSM8996_MASTER_MDP_PORT1, 32, 61, -1, true, NOC_Q=
OS_MODE_BYPASS, 0, 2, MSM8996_SLAVE_MNOC_BIMC);
+DEFINE_QNODE(mas_rotator, MSM8996_MASTER_ROTATOR, 32, 120, -1, true, NOC_Q=
OS_MODE_BYPASS, 0, 0, MSM8996_SLAVE_MNOC_BIMC);
+DEFINE_QNODE(mas_venus, MSM8996_MASTER_VIDEO_P0, 32, 9, -1, true, NOC_QOS_=
MODE_BYPASS, 0, 3 /* TODO: 3 4 ?? */, MSM8996_SLAVE_MNOC_BIMC);
+DEFINE_QNODE(mas_vfe, MSM8996_MASTER_VFE, 32, 11, -1, true, NOC_QOS_MODE_B=
YPASS, 0, 6, MSM8996_SLAVE_MNOC_BIMC);
+DEFINE_QNODE(mas_snoc_vmem, MSM8996_MASTER_SNOC_VMEM, 32, 114, -1, true, -=
1, 0, -1, MSM8996_SLAVE_VMEM);
+DEFINE_QNODE(mas_venus_vmem, MSM8996_MASTER_VIDEO_P0_OCMEM, 32, 121, -1, t=
rue, -1, 0, -1, MSM8996_SLAVE_VMEM);
+DEFINE_QNODE(mas_snoc_pnoc, MSM8996_MASTER_SNOC_PNOC, 8, 44, -1, false, -1=
, 0, -1, MSM8996_SLAVE_BLSP_1, MSM8996_SLAVE_BLSP_2, MSM8996_SLAVE_SDCC_1, =
MSM8996_SLAVE_SDCC_2, MSM8996_SLAVE_SDCC_4, MSM8996_SLAVE_TSIF, MSM8996_SLA=
VE_PDM, MSM8996_SLAVE_AHB2PHY);
+DEFINE_QNODE(mas_sdcc_1, MSM8996_MASTER_SDCC_1, 8, 33, -1, false, -1, 0, -=
1, MSM8996_SLAVE_PNOC_A1NOC);
+DEFINE_QNODE(mas_sdcc_2, MSM8996_MASTER_SDCC_2, 8, 35, -1, false, -1, 0, -=
1, MSM8996_SLAVE_PNOC_A1NOC);
+DEFINE_QNODE(mas_sdcc_4, MSM8996_MASTER_SDCC_4, 8, 36, -1, false, -1, 0, -=
1, MSM8996_SLAVE_PNOC_A1NOC);
+DEFINE_QNODE(mas_usb_hs, MSM8996_MASTER_USB_HS, 8, 42, -1, false, -1, 0, -=
1, MSM8996_SLAVE_PNOC_A1NOC);
+DEFINE_QNODE(mas_blsp_1, MSM8996_MASTER_BLSP_1, 4, 41, -1, false, -1, 0, -=
1, MSM8996_SLAVE_PNOC_A1NOC);
+DEFINE_QNODE(mas_blsp_2, MSM8996_MASTER_BLSP_2, 4, 39, -1, false, -1, 0, -=
1, MSM8996_SLAVE_PNOC_A1NOC);
+DEFINE_QNODE(mas_tsif, MSM8996_MASTER_TSIF, 4, 37, -1, false, -1, 0, -1, M=
SM8996_SLAVE_PNOC_A1NOC);
+DEFINE_QNODE(mas_hmss, MSM8996_MASTER_HMSS, 8, 118, -1, true, NOC_QOS_MODE=
_FIXED, 1, 4, MSM8996_SLAVE_PIMEM, MSM8996_SLAVE_OCIMEM, MSM8996_SLAVE_SNOC=
_BIMC);
+DEFINE_QNODE(mas_qdss_bam, MSM8996_MASTER_QDSS_BAM, 16, 19, -1, true, NOC_=
QOS_MODE_FIXED, 1, 2, MSM8996_SLAVE_PIMEM, MSM8996_SLAVE_USB3, MSM8996_SLAV=
E_OCIMEM, MSM8996_SLAVE_SNOC_BIMC, MSM8996_SLAVE_SNOC_PNOC);
+DEFINE_QNODE(mas_snoc_cfg, MSM8996_MASTER_SNOC_CFG, 16, 20, -1, true, -1, =
0, -1, MSM8996_SLAVE_SERVICE_SNOC);
+DEFINE_QNODE(mas_bimc_snoc_0, MSM8996_MASTER_BIMC_SNOC_0, 16, 21, -1, true=
, -1, 0, -1, MSM8996_SLAVE_SNOC_VMEM, MSM8996_SLAVE_USB3, MSM8996_SLAVE_PIM=
EM, MSM8996_SLAVE_LPASS, MSM8996_SLAVE_APPSS, MSM8996_SLAVE_SNOC_CNOC, MSM8=
996_SLAVE_SNOC_PNOC, MSM8996_SLAVE_OCIMEM, MSM8996_SLAVE_QDSS_STM);
+DEFINE_QNODE(mas_bimc_snoc_1, MSM8996_MASTER_BIMC_SNOC_1, 16, 109, -1, tru=
e, -1, 0, -1, MSM8996_SLAVE_PCIE_2, MSM8996_SLAVE_PCIE_1, MSM8996_SLAVE_PCI=
E_0);
+DEFINE_QNODE(mas_a0noc_snoc, MSM8996_MASTER_A0NOC_SNOC, 16, 110, -1, true,=
 -1, 0, -1, MSM8996_SLAVE_SNOC_PNOC, MSM8996_SLAVE_OCIMEM, MSM8996_SLAVE_AP=
PSS, MSM8996_SLAVE_SNOC_BIMC, MSM8996_SLAVE_PIMEM);
+DEFINE_QNODE(mas_a1noc_snoc, MSM8996_MASTER_A1NOC_SNOC, 16, 111, -1, false=
, -1, 0, -1, MSM8996_SLAVE_SNOC_VMEM, MSM8996_SLAVE_USB3, MSM8996_SLAVE_PCI=
E_0, MSM8996_SLAVE_PIMEM, MSM8996_SLAVE_PCIE_2, MSM8996_SLAVE_LPASS, MSM899=
6_SLAVE_PCIE_1, MSM8996_SLAVE_APPSS, MSM8996_SLAVE_SNOC_BIMC, MSM8996_SLAVE=
_SNOC_CNOC, MSM8996_SLAVE_SNOC_PNOC, MSM8996_SLAVE_OCIMEM, MSM8996_SLAVE_QD=
SS_STM);
+DEFINE_QNODE(mas_a2noc_snoc, MSM8996_MASTER_A2NOC_SNOC, 16, 112, -1, false=
, -1, 0, -1, MSM8996_SLAVE_SNOC_VMEM, MSM8996_SLAVE_USB3, MSM8996_SLAVE_PCI=
E_1, MSM8996_SLAVE_PIMEM, MSM8996_SLAVE_PCIE_2, MSM8996_SLAVE_QDSS_STM, MSM=
8996_SLAVE_LPASS, MSM8996_SLAVE_SNOC_BIMC, MSM8996_SLAVE_SNOC_CNOC, MSM8996=
_SLAVE_SNOC_PNOC, MSM8996_SLAVE_OCIMEM, MSM8996_SLAVE_PCIE_0);
+DEFINE_QNODE(mas_qdss_etr, MSM8996_MASTER_QDSS_ETR, 16, 31, -1, true, NOC_=
QOS_MODE_FIXED, 1, 3, MSM8996_SLAVE_PIMEM, MSM8996_SLAVE_USB3, MSM8996_SLAV=
E_OCIMEM, MSM8996_SLAVE_SNOC_BIMC, MSM8996_SLAVE_SNOC_PNOC);
+DEFINE_QNODE(slv_a0noc_snoc, MSM8996_SLAVE_A0NOC_SNOC, 8, -1, 141, true, -=
1, 0, -1, MSM8996_MASTER_A0NOC_SNOC);
+DEFINE_QNODE(slv_a1noc_snoc, MSM8996_SLAVE_A1NOC_SNOC, 8, -1, 142, false, =
-1, 0, -1, MSM8996_MASTER_A1NOC_SNOC);
+DEFINE_QNODE(slv_a2noc_snoc, MSM8996_SLAVE_A2NOC_SNOC, 8, -1, 143, false, =
-1, 0, -1, MSM8996_MASTER_A2NOC_SNOC);
+DEFINE_QNODE(slv_ebi, MSM8996_SLAVE_EBI_CH0, 8, -1, 0, false, -1, 0, -1, 0=
);
+DEFINE_QNODE(slv_hmss_l3, MSM8996_SLAVE_HMSS_L3, 8, -1, 160, false, -1, 0,=
 -1, 0);
+DEFINE_QNODE(slv_bimc_snoc_0, MSM8996_SLAVE_BIMC_SNOC_0, 8, -1, 2, true, -=
1, 0, -1, MSM8996_MASTER_BIMC_SNOC_0);
+DEFINE_QNODE(slv_bimc_snoc_1, MSM8996_SLAVE_BIMC_SNOC_1, 8, -1, 138, true,=
 -1, 0, -1, MSM8996_MASTER_BIMC_SNOC_1);
+DEFINE_QNODE(slv_cnoc_a1noc, MSM8996_SLAVE_CNOC_A1NOC, 4, -1, 75, true, -1=
, 0, -1, MSM8996_MASTER_CNOC_A1NOC);
+DEFINE_QNODE(slv_clk_ctl, MSM8996_SLAVE_CLK_CTL, 4, -1, 47, false, -1, 0, =
-1, 0);
+DEFINE_QNODE(slv_tcsr, MSM8996_SLAVE_TCSR, 4, -1, 50, false, -1, 0, -1, 0)=
;
+DEFINE_QNODE(slv_tlmm, MSM8996_SLAVE_TLMM, 4, -1, 51, false, -1, 0, -1, 0)=
;
+DEFINE_QNODE(slv_crypto0_cfg, MSM8996_SLAVE_CRYPTO_0_CFG, 4, -1, 52, true,=
 -1, 0, -1, 0);
+DEFINE_QNODE(slv_mpm, MSM8996_SLAVE_MPM, 4, -1, 62, true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_pimem_cfg, MSM8996_SLAVE_PIMEM_CFG, 4, -1, 167, true, -1,=
 0, -1, 0);
+DEFINE_QNODE(slv_imem_cfg, MSM8996_SLAVE_IMEM_CFG, 4, -1, 54, true, -1, 0,=
 -1, 0);
+DEFINE_QNODE(slv_message_ram, MSM8996_SLAVE_MESSAGE_RAM, 4, -1, 55, false,=
 -1, 0, -1, 0);
+DEFINE_QNODE(slv_bimc_cfg, MSM8996_SLAVE_BIMC_CFG, 4, -1, 56, true, -1, 0,=
 -1, 0);
+DEFINE_QNODE(slv_pmic_arb, MSM8996_SLAVE_PMIC_ARB, 4, -1, 59, false, -1, 0=
, -1, 0);
+DEFINE_QNODE(slv_prng, MSM8996_SLAVE_PRNG, 4, -1, 127, true, -1, 0, -1, 0)=
;
+DEFINE_QNODE(slv_dcc_cfg, MSM8996_SLAVE_DCC_CFG, 4, -1, 155, true, -1, 0, =
-1, 0);
+DEFINE_QNODE(slv_rbcpr_mx, MSM8996_SLAVE_RBCPR_MX, 4, -1, 170, true, -1, 0=
, -1, 0);
+DEFINE_QNODE(slv_qdss_cfg, MSM8996_SLAVE_QDSS_CFG, 4, -1, 63, true, -1, 0,=
 -1, 0);
+DEFINE_QNODE(slv_rbcpr_cx, MSM8996_SLAVE_RBCPR_CX, 4, -1, 169, true, -1, 0=
, -1, 0);
+DEFINE_QNODE(slv_cpu_apu_cfg, MSM8996_SLAVE_QDSS_RBCPR_APU_CFG, 4, -1, 168=
, true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_cnoc_mnoc_cfg, MSM8996_SLAVE_CNOC_MNOC_CFG, 4, -1, 66, tr=
ue, -1, 0, -1, MSM8996_MASTER_CNOC_MNOC_CFG);
+DEFINE_QNODE(slv_snoc_cfg, MSM8996_SLAVE_SNOC_CFG, 4, -1, 70, true, -1, 0,=
 -1, 0);
+DEFINE_QNODE(slv_snoc_mpu_cfg, MSM8996_SLAVE_SNOC_MPU_CFG, 4, -1, 67, true=
, -1, 0, -1, 0);
+DEFINE_QNODE(slv_ebi1_phy_cfg, MSM8996_SLAVE_EBI1_PHY_CFG, 4, -1, 73, true=
, -1, 0, -1, 0);
+DEFINE_QNODE(slv_a0noc_cfg, MSM8996_SLAVE_A0NOC_CFG, 4, -1, 144, true, -1,=
 0, -1, 0);
+DEFINE_QNODE(slv_pcie_1_cfg, MSM8996_SLAVE_PCIE_1_CFG, 4, -1, 89, true, -1=
, 0, -1, 0);
+DEFINE_QNODE(slv_pcie_2_cfg, MSM8996_SLAVE_PCIE_2_CFG, 4, -1, 165, true, -=
1, 0, -1, 0);
+DEFINE_QNODE(slv_pcie_0_cfg, MSM8996_SLAVE_PCIE_0_CFG, 4, -1, 88, true, -1=
, 0, -1, 0);
+DEFINE_QNODE(slv_pcie20_ahb2phy, MSM8996_SLAVE_PCIE20_AHB2PHY, 4, -1, 163,=
 true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_a0noc_mpu_cfg, MSM8996_SLAVE_A0NOC_MPU_CFG, 4, -1, 145, t=
rue, -1, 0, -1, 0);
+DEFINE_QNODE(slv_ufs_cfg, MSM8996_SLAVE_UFS_CFG, 4, -1, 92, true, -1, 0, -=
1, 0);
+DEFINE_QNODE(slv_a1noc_cfg, MSM8996_SLAVE_A1NOC_CFG, 4, -1, 147, true, -1,=
 0, -1, 0);
+DEFINE_QNODE(slv_a1noc_mpu_cfg, MSM8996_SLAVE_A1NOC_MPU_CFG, 4, -1, 148, t=
rue, -1, 0, -1, 0);
+DEFINE_QNODE(slv_a2noc_cfg, MSM8996_SLAVE_A2NOC_CFG, 4, -1, 150, true, -1,=
 0, -1, 0);
+DEFINE_QNODE(slv_a2noc_mpu_cfg, MSM8996_SLAVE_A2NOC_MPU_CFG, 4, -1, 151, t=
rue, -1, 0, -1, 0);
+DEFINE_QNODE(slv_ssc_cfg, MSM8996_SLAVE_SSC_CFG, 4, -1, 177, true, -1, 0, =
-1, 0);
+DEFINE_QNODE(slv_a0noc_smmu_cfg, MSM8996_SLAVE_A0NOC_SMMU_CFG, 8, -1, 146,=
 true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_a1noc_smmu_cfg, MSM8996_SLAVE_A1NOC_SMMU_CFG, 8, -1, 149,=
 true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_a2noc_smmu_cfg, MSM8996_SLAVE_A2NOC_SMMU_CFG, 8, -1, 152,=
 true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_lpass_smmu_cfg, MSM8996_SLAVE_LPASS_SMMU_CFG, 8, -1, 161,=
 true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_cnoc_mnoc_mmss_cfg, MSM8996_SLAVE_CNOC_MNOC_MMSS_CFG, 8, =
-1, 58, true, -1, 0, -1, MSM8996_MASTER_CNOC_MNOC_MMSS_CFG);
+DEFINE_QNODE(slv_mmagic_cfg, MSM8996_SLAVE_MMAGIC_CFG, 8, -1, 162, true, -=
1, 0, -1, 0);
+DEFINE_QNODE(slv_cpr_cfg, MSM8996_SLAVE_CPR_CFG, 8, -1, 6, true, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_misc_cfg, MSM8996_SLAVE_MISC_CFG, 8, -1, 8, true, -1, 0, =
-1, 0);
+DEFINE_QNODE(slv_venus_throttle_cfg, MSM8996_SLAVE_VENUS_THROTTLE_CFG, 8, =
-1, 178, true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_venus_cfg, MSM8996_SLAVE_VENUS_CFG, 8, -1, 10, true, -1, =
0, -1, 0);
+DEFINE_QNODE(slv_vmem_cfg, MSM8996_SLAVE_VMEM_CFG, 8, -1, 180, true, -1, 0=
, -1, 0);
+DEFINE_QNODE(slv_dsa_cfg, MSM8996_SLAVE_DSA_CFG, 8, -1, 157, true, -1, 0, =
-1, 0);
+DEFINE_QNODE(slv_mnoc_clocks_cfg, MSM8996_SLAVE_MMSS_CLK_CFG, 8, -1, 12, t=
rue, -1, 0, -1, 0);
+DEFINE_QNODE(slv_dsa_mpu_cfg, MSM8996_SLAVE_DSA_MPU_CFG, 8, -1, 158, true,=
 -1, 0, -1, 0);
+DEFINE_QNODE(slv_mnoc_mpu_cfg, MSM8996_SLAVE_MNOC_MPU_CFG, 8, -1, 14, true=
, -1, 0, -1, 0);
+DEFINE_QNODE(slv_display_cfg, MSM8996_SLAVE_DISPLAY_CFG, 8, -1, 4, true, -=
1, 0, -1, 0);
+DEFINE_QNODE(slv_display_throttle_cfg, MSM8996_SLAVE_DISPLAY_THROTTLE_CFG,=
 8, -1, 156, true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_camera_cfg, MSM8996_SLAVE_CAMERA_CFG, 8, -1, 3, true, -1,=
 0, -1, 0);
+DEFINE_QNODE(slv_camera_throttle_cfg, MSM8996_SLAVE_CAMERA_THROTTLE_CFG, 8=
, -1, 154, true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_oxili_cfg, MSM8996_SLAVE_GRAPHICS_3D_CFG, 8, -1, 11, true=
, -1, 0, -1, 0);
+DEFINE_QNODE(slv_smmu_mdp_cfg, MSM8996_SLAVE_SMMU_MDP_CFG, 8, -1, 173, tru=
e, -1, 0, -1, 0);
+DEFINE_QNODE(slv_smmu_rot_cfg, MSM8996_SLAVE_SMMU_ROTATOR_CFG, 8, -1, 174,=
 true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_smmu_venus_cfg, MSM8996_SLAVE_SMMU_VENUS_CFG, 8, -1, 175,=
 true, -1, 0, -1, 0);
+DEFINE_QNODE(slv_smmu_cpp_cfg, MSM8996_SLAVE_SMMU_CPP_CFG, 8, -1, 171, tru=
e, -1, 0, -1, 0);
+DEFINE_QNODE(slv_smmu_jpeg_cfg, MSM8996_SLAVE_SMMU_JPEG_CFG, 8, -1, 172, t=
rue, -1, 0, -1, 0);
+DEFINE_QNODE(slv_smmu_vfe_cfg, MSM8996_SLAVE_SMMU_VFE_CFG, 8, -1, 176, tru=
e, -1, 0, -1, 0);
+DEFINE_QNODE(slv_mnoc_bimc, MSM8996_SLAVE_MNOC_BIMC, 32, -1, 16, true, -1,=
 0, -1, MSM8996_MASTER_MNOC_BIMC);
+DEFINE_QNODE(slv_vmem, MSM8996_SLAVE_VMEM, 32, -1, 179, true, -1, 0, -1, 0=
);
+DEFINE_QNODE(slv_srvc_mnoc, MSM8996_SLAVE_SERVICE_MNOC, 8, -1, 17, true, -=
1, 0, -1, 0);
+DEFINE_QNODE(slv_pnoc_a1noc, MSM8996_SLAVE_PNOC_A1NOC, 8, -1, 139, false, =
-1, 0, -1, MSM8996_MASTER_PNOC_A1NOC);
+DEFINE_QNODE(slv_usb_hs, MSM8996_SLAVE_USB_HS, 4, -1, 40, false, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_sdcc_2, MSM8996_SLAVE_SDCC_2, 4, -1, 33, false, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_sdcc_4, MSM8996_SLAVE_SDCC_4, 4, -1, 34, false, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_tsif, MSM8996_SLAVE_TSIF, 4, -1, 35, false, -1, 0, -1, 0)=
;
+DEFINE_QNODE(slv_blsp_2, MSM8996_SLAVE_BLSP_2, 4, -1, 37, false, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_sdcc_1, MSM8996_SLAVE_SDCC_1, 4, -1, 31, false, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_blsp_1, MSM8996_SLAVE_BLSP_1, 4, -1, 39, false, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_pdm, MSM8996_SLAVE_PDM, 4, -1, 41, false, -1, 0, -1, 0);
+DEFINE_QNODE(slv_ahb2phy, MSM8996_SLAVE_AHB2PHY, 4, -1, 153, true, -1, 0, =
-1, 0);
+DEFINE_QNODE(slv_hmss, MSM8996_SLAVE_APPSS, 16, -1, 20, true, -1, 0, -1, 0=
);
+DEFINE_QNODE(slv_lpass, MSM8996_SLAVE_LPASS, 16, -1, 21, true, -1, 0, -1, =
0);
+DEFINE_QNODE(slv_usb3, MSM8996_SLAVE_USB3, 16, -1, 22, true, -1, 0, -1, 0)=
;
+DEFINE_QNODE(slv_snoc_bimc, MSM8996_SLAVE_SNOC_BIMC, 32, -1, 24, false, -1=
, 0, -1, MSM8996_MASTER_SNOC_BIMC);
+DEFINE_QNODE(slv_snoc_cnoc, MSM8996_SLAVE_SNOC_CNOC, 16, -1, 25, false, -1=
, 0, -1, MSM8996_MASTER_SNOC_CNOC);
+DEFINE_QNODE(slv_imem, MSM8996_SLAVE_OCIMEM, 16, -1, 26, false, -1, 0, -1,=
 0);
+DEFINE_QNODE(slv_pimem, MSM8996_SLAVE_PIMEM, 16, -1, 166, false, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_snoc_vmem, MSM8996_SLAVE_SNOC_VMEM, 16, -1, 140, true, -1=
, 0, -1, MSM8996_MASTER_SNOC_VMEM);
+DEFINE_QNODE(slv_snoc_pnoc, MSM8996_SLAVE_SNOC_PNOC, 16, -1, 28, false, -1=
, 0, -1, MSM8996_MASTER_SNOC_PNOC);
+DEFINE_QNODE(slv_qdss_stm, MSM8996_SLAVE_QDSS_STM, 16, -1, 30, false, -1, =
0, -1, 0);
+DEFINE_QNODE(slv_pcie_0, MSM8996_SLAVE_PCIE_0, 16, -1, 84, true, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_pcie_1, MSM8996_SLAVE_PCIE_1, 16, -1, 85, true, -1, 0, -1=
, 0);
+DEFINE_QNODE(slv_pcie_2, MSM8996_SLAVE_PCIE_2, 16, -1, 164, true, -1, 0, -=
1, 0);
+DEFINE_QNODE(slv_srvc_snoc, MSM8996_SLAVE_SERVICE_SNOC, 16, -1, 29, true, =
-1, 0, -1, 0);
+
+static struct qcom_icc_node *a1noc_nodes[] =3D {
+=09[MASTER_CNOC_A1NOC] =3D &mas_cnoc_a1noc,
+=09[MASTER_CRYPTO_CORE0] =3D &mas_crypto_c0,
+=09[MASTER_PNOC_A1NOC] =3D &mas_pnoc_a1noc,
+};
+
+static const struct regmap_config msm8996_a1noc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x7000,
+=09.fast_io=09=3D true,
+};
+
+static const struct qcom_icc_desc msm8996_a1noc =3D {
+=09.nodes =3D a1noc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(a1noc_nodes),
+=09.regmap_cfg =3D &msm8996_a1noc_regmap_config,
+};
+
+static struct qcom_icc_node *a2noc_nodes[] =3D {
+=09[MASTER_USB3] =3D &mas_usb3,
+=09[MASTER_IPA] =3D &mas_ipa,
+=09[MASTER_UFS] =3D &mas_ufs,
+};
+
+static const struct regmap_config msm8996_a2noc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0xa000,
+=09.fast_io=09=3D true,
+};
+
+static const struct qcom_icc_desc msm8996_a2noc =3D {
+=09.nodes =3D a2noc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(a2noc_nodes),
+=09.regmap_cfg =3D &msm8996_a2noc_regmap_config,
+};
+
+static struct qcom_icc_node *bimc_nodes[] =3D {
+=09[MASTER_AMPSS_M0] =3D &mas_apps_proc,
+=09[MASTER_GRAPHICS_3D] =3D &mas_oxili,
+=09[MASTER_MNOC_BIMC] =3D &mas_mnoc_bimc,
+=09[MASTER_SNOC_BIMC] =3D &mas_snoc_bimc,
+=09[SLAVE_EBI_CH0] =3D &slv_ebi,
+=09[SLAVE_HMSS_L3] =3D &slv_hmss_l3,
+=09[SLAVE_BIMC_SNOC_0] =3D &slv_bimc_snoc_0,
+=09[SLAVE_BIMC_SNOC_1] =3D &slv_bimc_snoc_1,
+};
+
+static const struct regmap_config msm8996_bimc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x62000,
+=09.fast_io=09=3D true,
+};
+
+static const struct qcom_icc_desc msm8996_bimc =3D {
+=09.nodes =3D bimc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(bimc_nodes),
+=09.regmap_cfg =3D &msm8996_bimc_regmap_config,
+};
+
+static struct qcom_icc_node *cnoc_nodes[] =3D {
+=09[MASTER_SNOC_CNOC] =3D &mas_snoc_cnoc,
+=09[MASTER_QDSS_DAP] =3D &mas_qdss_dap,
+=09[SLAVE_CNOC_A1NOC] =3D &slv_cnoc_a1noc,
+=09[SLAVE_CLK_CTL] =3D &slv_clk_ctl,
+=09[SLAVE_TCSR] =3D &slv_tcsr,
+=09[SLAVE_TLMM] =3D &slv_tlmm,
+=09[SLAVE_CRYPTO_0_CFG] =3D &slv_crypto0_cfg,
+=09[SLAVE_MPM] =3D &slv_mpm,
+=09[SLAVE_PIMEM_CFG] =3D &slv_pimem_cfg,
+=09[SLAVE_IMEM_CFG] =3D &slv_imem_cfg,
+=09[SLAVE_MESSAGE_RAM] =3D &slv_message_ram,
+=09[SLAVE_BIMC_CFG] =3D &slv_bimc_cfg,
+=09[SLAVE_PMIC_ARB] =3D &slv_pmic_arb,
+=09[SLAVE_PRNG] =3D &slv_prng,
+=09[SLAVE_DCC_CFG] =3D &slv_dcc_cfg,
+=09[SLAVE_RBCPR_MX] =3D &slv_rbcpr_mx,
+=09[SLAVE_QDSS_CFG] =3D &slv_qdss_cfg,
+=09[SLAVE_RBCPR_CX] =3D &slv_rbcpr_cx,
+=09[SLAVE_QDSS_RBCPR_APU] =3D &slv_cpu_apu_cfg,
+=09[SLAVE_CNOC_MNOC_CFG] =3D &slv_cnoc_mnoc_cfg,
+=09[SLAVE_SNOC_CFG] =3D &slv_snoc_cfg,
+=09[SLAVE_SNOC_MPU_CFG] =3D &slv_snoc_mpu_cfg,
+=09[SLAVE_EBI1_PHY_CFG] =3D &slv_ebi1_phy_cfg,
+=09[SLAVE_A0NOC_CFG] =3D &slv_a0noc_cfg,
+=09[SLAVE_PCIE_1_CFG] =3D &slv_pcie_1_cfg,
+=09[SLAVE_PCIE_2_CFG] =3D &slv_pcie_2_cfg,
+=09[SLAVE_PCIE_0_CFG] =3D &slv_pcie_0_cfg,
+=09[SLAVE_PCIE20_AHB2PHY] =3D &slv_pcie20_ahb2phy,
+=09[SLAVE_A0NOC_MPU_CFG] =3D &slv_a0noc_mpu_cfg,
+=09[SLAVE_UFS_CFG] =3D &slv_ufs_cfg,
+=09[SLAVE_A1NOC_CFG] =3D &slv_a1noc_cfg,
+=09[SLAVE_A1NOC_MPU_CFG] =3D &slv_a1noc_mpu_cfg,
+=09[SLAVE_A2NOC_CFG] =3D &slv_a2noc_cfg,
+=09[SLAVE_A2NOC_MPU_CFG] =3D &slv_a2noc_mpu_cfg,
+=09[SLAVE_SSC_CFG] =3D &slv_ssc_cfg,
+=09[SLAVE_A0NOC_SMMU_CFG] =3D &slv_a0noc_smmu_cfg,
+=09[SLAVE_A1NOC_SMMU_CFG] =3D &slv_a1noc_smmu_cfg,
+=09[SLAVE_A2NOC_SMMU_CFG] =3D &slv_a2noc_smmu_cfg,
+=09[SLAVE_LPASS_SMMU_CFG] =3D &slv_lpass_smmu_cfg,
+=09[SLAVE_CNOC_MNOC_MMSS_CFG] =3D &slv_cnoc_mnoc_mmss_cfg,
+};
+
+static const struct regmap_config msm8996_cnoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x1000,
+=09.fast_io=09=3D true,
+};
+
+static const struct qcom_icc_desc msm8996_cnoc =3D {
+=09.nodes =3D cnoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(cnoc_nodes),
+=09.regmap_cfg =3D &msm8996_cnoc_regmap_config,
+};
+
+static struct qcom_icc_node *mnoc_nodes[] =3D {
+=09[MASTER_CNOC_MNOC_CFG] =3D &mas_cnoc_mnoc_cfg,
+=09[MASTER_CPP] =3D &mas_cpp,
+=09[MASTER_JPEG] =3D &mas_jpeg,
+=09[MASTER_MDP_PORT0] =3D &mas_mdp_p0,
+=09[MASTER_MDP_PORT1] =3D &mas_mdp_p1,
+=09[MASTER_ROTATOR] =3D &mas_rotator,
+=09[MASTER_VIDEO_P0] =3D &mas_venus,
+=09[MASTER_VFE] =3D &mas_vfe,
+=09[MASTER_SNOC_VMEM] =3D &mas_snoc_vmem,
+=09[MASTER_VIDEO_P0_OCMEM] =3D &mas_venus_vmem,
+=09[MASTER_CNOC_MNOC_MMSS_CFG] =3D &mas_cnoc_mnoc_mmss_cfg,
+=09[SLAVE_MNOC_BIMC] =3D &slv_mnoc_bimc,
+=09[SLAVE_VMEM] =3D &slv_vmem,
+=09[SLAVE_SERVICE_MNOC] =3D &slv_srvc_mnoc,
+=09[SLAVE_MMAGIC_CFG] =3D &slv_mmagic_cfg,
+=09[SLAVE_CPR_CFG] =3D &slv_cpr_cfg,
+=09[SLAVE_MISC_CFG] =3D &slv_misc_cfg,
+=09[SLAVE_VENUS_THROTTLE_CFG] =3D &slv_venus_throttle_cfg,
+=09[SLAVE_VENUS_CFG] =3D &slv_venus_cfg,
+=09[SLAVE_VMEM_CFG] =3D &slv_vmem_cfg,
+=09[SLAVE_DSA_CFG] =3D &slv_dsa_cfg,
+=09[SLAVE_MMSS_CLK_CFG] =3D &slv_mnoc_clocks_cfg,
+=09[SLAVE_DSA_MPU_CFG] =3D &slv_dsa_mpu_cfg,
+=09[SLAVE_MNOC_MPU_CFG] =3D &slv_mnoc_mpu_cfg,
+=09[SLAVE_DISPLAY_CFG] =3D &slv_display_cfg,
+=09[SLAVE_DISPLAY_THROTTLE_CFG] =3D &slv_display_throttle_cfg,
+=09[SLAVE_CAMERA_CFG] =3D &slv_camera_cfg,
+=09[SLAVE_CAMERA_THROTTLE_CFG] =3D &slv_camera_throttle_cfg,
+=09[SLAVE_GRAPHICS_3D_CFG] =3D &slv_oxili_cfg,
+=09[SLAVE_SMMU_MDP_CFG] =3D &slv_smmu_mdp_cfg,
+=09[SLAVE_SMMU_ROT_CFG] =3D &slv_smmu_rot_cfg,
+=09[SLAVE_SMMU_VENUS_CFG] =3D &slv_smmu_venus_cfg,
+=09[SLAVE_SMMU_CPP_CFG] =3D &slv_smmu_cpp_cfg,
+=09[SLAVE_SMMU_JPEG_CFG] =3D &slv_smmu_jpeg_cfg,
+=09[SLAVE_SMMU_VFE_CFG] =3D &slv_smmu_vfe_cfg,
+};
+
+static const struct regmap_config msm8996_mnoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x20000,
+=09.fast_io=09=3D true,
+};
+
+static const struct qcom_icc_desc msm8996_mnoc =3D {
+=09.nodes =3D mnoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(mnoc_nodes),
+=09.regmap_cfg =3D &msm8996_mnoc_regmap_config,
+};
+
+
+static struct qcom_icc_node *pnoc_nodes[] =3D {
+=09[MASTER_SNOC_PNOC] =3D &mas_snoc_pnoc,
+=09[MASTER_SDCC_1] =3D &mas_sdcc_1,
+=09[MASTER_SDCC_2] =3D &mas_sdcc_2,
+=09[MASTER_SDCC_4] =3D &mas_sdcc_4,
+=09[MASTER_USB_HS] =3D &mas_usb_hs,
+=09[MASTER_BLSP_1] =3D &mas_blsp_1,
+=09[MASTER_BLSP_2] =3D &mas_blsp_2,
+=09[MASTER_TSIF] =3D &mas_tsif,
+=09[SLAVE_PNOC_A1NOC] =3D &slv_pnoc_a1noc,
+=09[SLAVE_USB_HS] =3D &slv_usb_hs,
+=09[SLAVE_SDCC_2] =3D &slv_sdcc_2,
+=09[SLAVE_SDCC_4] =3D &slv_sdcc_4,
+=09[SLAVE_TSIF] =3D &slv_tsif,
+=09[SLAVE_BLSP_2] =3D &slv_blsp_2,
+=09[SLAVE_SDCC_1] =3D &slv_sdcc_1,
+=09[SLAVE_BLSP_1] =3D &slv_blsp_1,
+=09[SLAVE_PDM] =3D &slv_pdm,
+=09[SLAVE_AHB2PHY] =3D &slv_ahb2phy,
+};
+
+static const struct regmap_config msm8996_pnoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x3000,
+=09.fast_io=09=3D true,
+};
+
+static const struct qcom_icc_desc msm8996_pnoc =3D {
+=09.nodes =3D pnoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(pnoc_nodes),
+=09.regmap_cfg =3D &msm8996_pnoc_regmap_config,
+};
+
+static struct qcom_icc_node *snoc_nodes[] =3D {
+=09[MASTER_HMSS] =3D &mas_hmss,
+=09[MASTER_QDSS_BAM] =3D &mas_qdss_bam,
+=09[MASTER_SNOC_CFG] =3D &mas_snoc_cfg,
+=09[MASTER_BIMC_SNOC_0] =3D &mas_bimc_snoc_0,
+=09[MASTER_BIMC_SNOC_1] =3D &mas_bimc_snoc_1,
+=09[MASTER_A0NOC_SNOC] =3D &mas_a0noc_snoc,
+=09[MASTER_A1NOC_SNOC] =3D &mas_a1noc_snoc,
+=09[MASTER_A2NOC_SNOC] =3D &mas_a2noc_snoc,
+=09[MASTER_QDSS_ETR] =3D &mas_qdss_etr,
+=09[SLAVE_A0NOC_SNOC] =3D &slv_a0noc_snoc,
+=09[SLAVE_A1NOC_SNOC] =3D &slv_a1noc_snoc,
+=09[SLAVE_A2NOC_SNOC] =3D &slv_a2noc_snoc,
+=09[SLAVE_HMSS] =3D &slv_hmss,
+=09[SLAVE_LPASS] =3D &slv_lpass,
+=09[SLAVE_USB3] =3D &slv_usb3,
+=09[SLAVE_SNOC_BIMC] =3D &slv_snoc_bimc,
+=09[SLAVE_SNOC_CNOC] =3D &slv_snoc_cnoc,
+=09[SLAVE_IMEM] =3D &slv_imem,
+=09[SLAVE_PIMEM] =3D &slv_pimem,
+=09[SLAVE_SNOC_VMEM] =3D &slv_snoc_vmem,
+=09[SLAVE_SNOC_PNOC] =3D &slv_snoc_pnoc,
+=09[SLAVE_QDSS_STM] =3D &slv_qdss_stm,
+=09[SLAVE_PCIE_0] =3D &slv_pcie_0,
+=09[SLAVE_PCIE_1] =3D &slv_pcie_1,
+=09[SLAVE_PCIE_2] =3D &slv_pcie_2,
+=09[SLAVE_SERVICE_SNOC] =3D &slv_srvc_snoc,
+};
+
+static const struct regmap_config msm8996_snoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x20000,
+=09.fast_io=09=3D true,
+};
+
+static const struct qcom_icc_desc msm8996_snoc =3D {
+=09.nodes =3D snoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(snoc_nodes),
+=09.regmap_cfg =3D &msm8996_snoc_regmap_config,
+};
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+=09struct device *dev =3D &pdev->dev;
+=09const struct qcom_icc_desc *desc;
+=09struct icc_onecell_data *data;
+=09struct icc_provider *provider;
+=09struct qcom_icc_node **qnodes;
+=09struct qcom_icc_provider *qp;
+=09struct icc_node *node;
+=09struct resource *res;
+=09size_t num_nodes, i;
+=09int ret;
+
+=09/* wait for the RPM proxy */
+=09if (!qcom_icc_rpm_smd_available())
+=09=09return -EPROBE_DEFER;
+
+=09desc =3D of_device_get_match_data(dev);
+=09if (!desc)
+=09=09return -EINVAL;
+
+=09qnodes =3D desc->nodes;
+=09num_nodes =3D desc->num_nodes;
+
+=09qp =3D devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+=09if (!qp)
+=09=09return -ENOMEM;
+
+=09data =3D devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
+=09=09=09    GFP_KERNEL);
+=09if (!data)
+=09=09return -ENOMEM;
+
+=09if (of_device_is_compatible(dev->of_node, "qcom,msm8996-mnoc")) {
+=09=09qp->bus_clks =3D devm_kmemdup(dev, bus_mm_clocks,
+=09=09=09=09=09    sizeof(bus_mm_clocks), GFP_KERNEL);
+=09=09qp->num_clks =3D ARRAY_SIZE(bus_mm_clocks);
+=09} else {
+=09=09if (of_device_is_compatible(dev->of_node, "qcom,msm8996-bimc"))
+=09=09=09qp->is_bimc_node =3D true;
+
+=09=09qp->bus_clks =3D devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
+=09=09=09=09=09    GFP_KERNEL);
+=09=09qp->num_clks =3D ARRAY_SIZE(bus_clocks);
+=09}
+=09if (!qp->bus_clks)
+=09=09return -ENOMEM;
+
+=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09if (!res)
+=09=09return -ENODEV;
+
+=09qp->mmio =3D devm_ioremap_resource(dev, res);
+=09if (IS_ERR(qp->mmio)) {
+=09=09dev_err(dev, "Cannot ioremap interconnect bus resource\n");
+=09=09return PTR_ERR(qp->mmio);
+=09}
+
+=09qp->regmap =3D devm_regmap_init_mmio(dev, qp->mmio, desc->regmap_cfg);
+=09if (IS_ERR(qp->regmap)) {
+=09=09dev_err(dev, "Cannot regmap interconnect bus resource\n");
+=09=09return PTR_ERR(qp->regmap);
+=09}
+
+=09ret =3D devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
+=09if (ret)
+=09=09return ret;
+
+=09provider =3D &qp->provider;
+=09INIT_LIST_HEAD(&provider->nodes);
+=09provider->dev =3D dev;
+=09provider->set =3D qcom_icc_rpm_qos_set;
+=09provider->aggregate =3D icc_std_aggregate;
+=09provider->xlate =3D of_icc_xlate_onecell;
+=09provider->data =3D data;
+
+=09ret =3D icc_provider_add(provider);
+=09if (ret) {
+=09=09dev_err(dev, "error adding interconnect provider: %d\n", ret);
+=09=09clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+=09=09return ret;
+=09}
+
+=09for (i =3D 0; i < num_nodes; i++) {
+=09=09size_t j;
+
+=09=09node =3D icc_node_create(qnodes[i]->id);
+=09=09if (IS_ERR(node)) {
+=09=09=09ret =3D PTR_ERR(node);
+=09=09=09goto err;
+=09=09}
+
+=09=09node->name =3D qnodes[i]->name;
+=09=09node->data =3D qnodes[i];
+=09=09icc_node_add(node, provider);
+
+=09=09for (j =3D 0; j < qnodes[i]->num_links; j++) {
+=09=09=09icc_link_create(node, qnodes[i]->links[j]);
+=09=09}
+
+=09=09data->nodes[i] =3D node;
+=09}
+=09data->num_nodes =3D num_nodes;
+=09platform_set_drvdata(pdev, qp);
+
+=09return 0;
+err:
+=09icc_nodes_remove(provider);
+=09clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+=09icc_provider_del(provider);
+
+=09return ret;
+}
+
+static int qnoc_remove(struct platform_device *pdev)
+{
+=09struct qcom_icc_provider *qp =3D platform_get_drvdata(pdev);
+
+=09icc_nodes_remove(&qp->provider);
+=09clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+=09return icc_provider_del(&qp->provider);
+}
+
+static const struct of_device_id qnoc_of_match[] =3D {
+=09{ .compatible =3D "qcom,msm8996-a1noc", .data =3D &msm8996_a1noc},
+=09{ .compatible =3D "qcom,msm8996-a2noc", .data =3D &msm8996_a2noc},
+=09{ .compatible =3D "qcom,msm8996-bimc", .data =3D &msm8996_bimc},
+=09{ .compatible =3D "qcom,msm8996-cnoc", .data =3D &msm8996_cnoc},
+=09{ .compatible =3D "qcom,msm8996-mnoc", .data =3D &msm8996_mnoc},
+=09{ .compatible =3D "qcom,msm8996-pnoc", .data =3D &msm8996_pnoc},
+=09{ .compatible =3D "qcom,msm8996-snoc", .data =3D &msm8996_snoc},
+=09{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver =3D {
+=09.probe =3D qnoc_probe,
+=09.remove =3D qnoc_remove,
+=09.driver =3D {
+=09=09.name =3D "qnoc-msm8996",
+=09=09.of_match_table =3D qnoc_of_match,
+=09=09.sync_state =3D icc_sync_state,
+=09},
+};
+module_platform_driver(qnoc_driver);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm MSM8996 NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/msm8996.h b/drivers/interconnect/qco=
m/msm8996.h
new file mode 100644
index 000000000000..42b54ffcaa7b
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8996.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm MSM8996 interconnect IDs
+ *
+ * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_MSM8996_H__
+#define __DRIVERS_INTERCONNECT_QCOM_MSM8996_H__
+
+#define MSM8996_MASTER_PCIE_0=09=09=09=091
+#define MSM8996_MASTER_PCIE_1=09=09=09=092
+#define MSM8996_MASTER_PCIE_2=09=09=09=093
+#define MSM8996_MASTER_CNOC_A1NOC=09=09=094
+#define MSM8996_MASTER_CRYPTO_CORE0=09=09=095
+#define MSM8996_MASTER_PNOC_A1NOC=09=09=096
+#define MSM8996_MASTER_USB3=09=09=09=097
+#define MSM8996_MASTER_IPA=09=09=09=098
+#define MSM8996_MASTER_UFS=09=09=09=099
+#define MSM8996_MASTER_AMPSS_M0=09=09=09=0910
+#define MSM8996_MASTER_GRAPHICS_3D=09=09=0911
+#define MSM8996_MASTER_MNOC_BIMC=09=09=0912
+#define MSM8996_MASTER_SNOC_BIMC=09=09=0913
+#define MSM8996_MASTER_SNOC_CNOC=09=09=0914
+#define MSM8996_MASTER_QDSS_DAP=09=09=09=0915
+#define MSM8996_MASTER_CNOC_MNOC_MMSS_CFG=09=0916
+#define MSM8996_MASTER_CNOC_MNOC_CFG=09=09=0917
+#define MSM8996_MASTER_CPP=09=09=09=0918
+#define MSM8996_MASTER_JPEG=09=09=09=0919
+#define MSM8996_MASTER_MDP_PORT0=09=09=0920
+#define MSM8996_MASTER_MDP_PORT1=09=09=0921
+#define MSM8996_MASTER_ROTATOR=09=09=09=0922
+#define MSM8996_MASTER_VIDEO_P0=09=09=09=0923
+#define MSM8996_MASTER_VFE=09=09=09=0924
+#define MSM8996_MASTER_SNOC_VMEM=09=09=0925
+#define MSM8996_MASTER_VIDEO_P0_OCMEM=09=09=0926
+#define MSM8996_MASTER_SNOC_PNOC=09=09=0927
+#define MSM8996_MASTER_SDCC_1=09=09=09=0928
+#define MSM8996_MASTER_SDCC_2=09=09=09=0929
+#define MSM8996_MASTER_SDCC_4=09=09=09=0930
+#define MSM8996_MASTER_USB_HS=09=09=09=0931
+#define MSM8996_MASTER_BLSP_1=09=09=09=0932
+#define MSM8996_MASTER_BLSP_2=09=09=09=0933
+#define MSM8996_MASTER_TSIF=09=09=09=0934
+#define MSM8996_MASTER_HMSS=09=09=09=0935
+#define MSM8996_MASTER_QDSS_BAM=09=09=09=0936
+#define MSM8996_MASTER_SNOC_CFG=09=09=09=0937
+#define MSM8996_MASTER_BIMC_SNOC_0=09=09=0938
+#define MSM8996_MASTER_BIMC_SNOC_1=09=09=0939
+#define MSM8996_MASTER_A0NOC_SNOC=09=09=0940
+#define MSM8996_MASTER_A1NOC_SNOC=09=09=0941
+#define MSM8996_MASTER_A2NOC_SNOC=09=09=0942
+#define MSM8996_MASTER_QDSS_ETR=09=09=09=0943
+
+#define MSM8996_SLAVE_A0NOC_SNOC=09=09=0944
+#define MSM8996_SLAVE_A1NOC_SNOC=09=09=0945
+#define MSM8996_SLAVE_A2NOC_SNOC=09=09=0946
+#define MSM8996_SLAVE_EBI_CH0=09=09=09=0947
+#define MSM8996_SLAVE_HMSS_L3=09=09=09=0948
+#define MSM8996_SLAVE_BIMC_SNOC_0=09=09=0949
+#define MSM8996_SLAVE_BIMC_SNOC_1=09=09=0950
+#define MSM8996_SLAVE_CNOC_A1NOC=09=09=0951
+#define MSM8996_SLAVE_CLK_CTL=09=09=09=0952
+#define MSM8996_SLAVE_TCSR=09=09=09=0953
+#define MSM8996_SLAVE_TLMM=09=09=09=0954
+#define MSM8996_SLAVE_CRYPTO_0_CFG=09=09=0955
+#define MSM8996_SLAVE_MPM=09=09=09=0956
+#define MSM8996_SLAVE_PIMEM_CFG=09=09=09=0957
+#define MSM8996_SLAVE_IMEM_CFG=09=09=09=0958
+#define MSM8996_SLAVE_MESSAGE_RAM=09=09=0959
+#define MSM8996_SLAVE_BIMC_CFG=09=09=09=0960
+#define MSM8996_SLAVE_PMIC_ARB=09=09=09=0961
+#define MSM8996_SLAVE_PRNG=09=09=09=0962
+#define MSM8996_SLAVE_DCC_CFG=09=09=09=0963
+#define MSM8996_SLAVE_RBCPR_MX=09=09=09=0964
+#define MSM8996_SLAVE_QDSS_CFG=09=09=09=0965
+#define MSM8996_SLAVE_RBCPR_CX=09=09=09=0966
+#define MSM8996_SLAVE_QDSS_RBCPR_APU_CFG=09=0967
+#define MSM8996_SLAVE_CNOC_MNOC_CFG=09=09=0968
+#define MSM8996_SLAVE_SNOC_CFG=09=09=09=0969
+#define MSM8996_SLAVE_SNOC_MPU_CFG=09=09=0970
+#define MSM8996_SLAVE_EBI1_PHY_CFG=09=09=0971
+#define MSM8996_SLAVE_A0NOC_CFG=09=09=09=0972
+#define MSM8996_SLAVE_PCIE_1_CFG=09=09=0973
+#define MSM8996_SLAVE_PCIE_2_CFG=09=09=0974
+#define MSM8996_SLAVE_PCIE_0_CFG=09=09=0975
+#define MSM8996_SLAVE_PCIE20_AHB2PHY=09=09=0976
+#define MSM8996_SLAVE_A0NOC_MPU_CFG=09=09=0977
+#define MSM8996_SLAVE_UFS_CFG=09=09=09=0978
+#define MSM8996_SLAVE_A1NOC_CFG=09=09=09=0979
+#define MSM8996_SLAVE_A1NOC_MPU_CFG=09=09=0980
+#define MSM8996_SLAVE_A2NOC_CFG=09=09=09=0981
+#define MSM8996_SLAVE_A2NOC_MPU_CFG=09=09=0982
+#define MSM8996_SLAVE_SSC_CFG=09=09=09=0983
+#define MSM8996_SLAVE_A0NOC_SMMU_CFG=09=09=0984
+#define MSM8996_SLAVE_A1NOC_SMMU_CFG=09=09=0985
+#define MSM8996_SLAVE_A2NOC_SMMU_CFG=09=09=0986
+#define MSM8996_SLAVE_LPASS_SMMU_CFG=09=09=0987
+#define MSM8996_SLAVE_CNOC_MNOC_MMSS_CFG=09=0988
+#define MSM8996_SLAVE_MMAGIC_CFG=09=09=0989
+#define MSM8996_SLAVE_CPR_CFG=09=09=09=0990
+#define MSM8996_SLAVE_MISC_CFG=09=09=09=0991
+#define MSM8996_SLAVE_VENUS_THROTTLE_CFG=09=0992
+#define MSM8996_SLAVE_VENUS_CFG=09=09=09=0993
+#define MSM8996_SLAVE_VMEM_CFG=09=09=09=0994
+#define MSM8996_SLAVE_DSA_CFG=09=09=09=0995
+#define MSM8996_SLAVE_MMSS_CLK_CFG=09=09=0996
+#define MSM8996_SLAVE_DSA_MPU_CFG=09=09=0997
+#define MSM8996_SLAVE_MNOC_MPU_CFG=09=09=0998
+#define MSM8996_SLAVE_DISPLAY_CFG=09=09=0999
+#define MSM8996_SLAVE_DISPLAY_THROTTLE_CFG=09=09100
+#define MSM8996_SLAVE_CAMERA_CFG=09=09=09101
+#define MSM8996_SLAVE_CAMERA_THROTTLE_CFG=09=09102
+#define MSM8996_SLAVE_GRAPHICS_3D_CFG=09=09=09103
+#define MSM8996_SLAVE_SMMU_MDP_CFG=09=09=09104
+#define MSM8996_SLAVE_SMMU_ROTATOR_CFG=09=09=09105
+#define MSM8996_SLAVE_SMMU_VENUS_CFG=09=09=09106
+#define MSM8996_SLAVE_SMMU_CPP_CFG=09=09=09107
+#define MSM8996_SLAVE_SMMU_JPEG_CFG=09=09=09108
+#define MSM8996_SLAVE_SMMU_VFE_CFG=09=09=09109
+#define MSM8996_SLAVE_MNOC_BIMC=09=09=09=09110
+#define MSM8996_SLAVE_VMEM=09=09=09=09111
+#define MSM8996_SLAVE_SERVICE_MNOC=09=09=09112
+#define MSM8996_SLAVE_PNOC_A1NOC=09=09=09113
+#define MSM8996_SLAVE_USB_HS=09=09=09=09114
+#define MSM8996_SLAVE_SDCC_2=09=09=09=09115
+#define MSM8996_SLAVE_SDCC_4=09=09=09=09116
+#define MSM8996_SLAVE_TSIF=09=09=09=09117
+#define MSM8996_SLAVE_BLSP_2=09=09=09=09118
+#define MSM8996_SLAVE_SDCC_1=09=09=09=09119
+#define MSM8996_SLAVE_BLSP_1=09=09=09=09120
+#define MSM8996_SLAVE_PDM=09=09=09=09121
+#define MSM8996_SLAVE_AHB2PHY=09=09=09=09122
+#define MSM8996_SLAVE_APPSS=09=09=09=09123
+#define MSM8996_SLAVE_LPASS=09=09=09=09124
+#define MSM8996_SLAVE_USB3=09=09=09=09125
+#define MSM8996_SLAVE_SNOC_BIMC=09=09=09=09126
+#define MSM8996_SLAVE_SNOC_CNOC=09=09=09=09127
+#define MSM8996_SLAVE_OCIMEM=09=09=09=09128
+#define MSM8996_SLAVE_PIMEM=09=09=09=09129
+#define MSM8996_SLAVE_SNOC_VMEM=09=09=09=09130
+#define MSM8996_SLAVE_SNOC_PNOC=09=09=09=09131
+#define MSM8996_SLAVE_QDSS_STM=09=09=09=09132
+#define MSM8996_SLAVE_PCIE_0=09=09=09=09133
+#define MSM8996_SLAVE_PCIE_1=09=09=09=09134
+#define MSM8996_SLAVE_PCIE_2=09=09=09=09135
+#define MSM8996_SLAVE_SERVICE_SNOC=09=09=09136
+
+#endif /* __DRIVERS_INTERCONNECT_QCOM_MSM8996_H__ */
--=20
2.32.0


