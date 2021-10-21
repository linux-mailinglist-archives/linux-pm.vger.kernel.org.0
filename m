Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3E4362E5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 15:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJUN1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 09:27:50 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:43836 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhJUN1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 09:27:47 -0400
Date:   Thu, 21 Oct 2021 13:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1634822714;
        bh=9KqOV4LJWRSrtIqdHdDI10Yk452A3SH8L8t6XEvpibU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=pJiJUzEpwbvYbEVmpl7B6dKcOTC06p45gIlRELnEr80uWR7nzrohDqNSoihqHl04X
         3ZYxjKOieQpBS6sCFq+cJ4F9c0LQTU+s5MyhWiIKwxbD4Sur4NME2PPdG3hBRrjjmm
         7mzrEOD7PdJJT/XAXTZTGHNSi4IHzut/fgLOzXgI=
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v5 4/5] interconnect: qcom: Add MSM8996 interconnect provider driver
Message-ID: <20211021132329.234942-5-y.oudjana@protonmail.com>
In-Reply-To: <20211021132329.234942-1-y.oudjana@protonmail.com>
References: <20211021132329.234942-1-y.oudjana@protonmail.com>
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

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v4:
 - Rebase on Dmitry's icc-rpm patches.
 - Clean up qcom_icc_node structs by removing unused properties, moving lin=
ks to external
   arrays and using the same arrays for multiple nodes where possible.
 - Add support for Aggregate 0 NoC (a0noc).
Changes since v3:
 - Expand DEFINE_QNODE macros in msm8996.c.
 - Commonize probe function.
 - Code style fixes.

 drivers/interconnect/qcom/Kconfig   |    9 +
 drivers/interconnect/qcom/Makefile  |    2 +
 drivers/interconnect/qcom/msm8996.c | 2113 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/msm8996.h |  149 ++
 4 files changed, 2273 insertions(+)
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/=
Kconfig
index daf1e25f6042..d0ed6f570355 100644
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
+=09select INTERCONNECT_QCOM_SMD_RPM
+=09help
+=09  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
+=09  platforms.
+
 config INTERCONNECT_QCOM_OSM_L3
 =09tristate "Qualcomm OSM L3 interconnect driver"
 =09depends on INTERCONNECT_QCOM || COMPILE_TEST
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom=
/Makefile
index 69300b1d48ef..750e42ab82ac 100644
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
index 000000000000..788fda09417e
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -0,0 +1,2113 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+#include "icc-rpm.h"
+#include "smd-rpm.h"
+#include "msm8996.h"
+
+static const char * const bus_mm_clocks[] =3D {
+=09"bus",
+=09"bus_a",
+=09"iface"
+};
+
+static const char * const bus_a0noc_clocks[] =3D {
+=09"aggre0_snoc_axi",
+=09"aggre0_cnoc_ahb",
+=09"aggre0_noc_mpu_cfg"
+};
+
+static const u16 mas_a0noc_common_links[] =3D {
+=09MSM8996_SLAVE_A0NOC_SNOC
+};
+
+static struct qcom_icc_node mas_pcie_0 =3D {
+=09.name =3D "mas_pcie_0",
+=09.id =3D MSM8996_MASTER_PCIE_0,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 65,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 0,
+=09.num_links =3D ARRAY_SIZE(mas_a0noc_common_links),
+=09.links =3D mas_a0noc_common_links
+};
+
+static struct qcom_icc_node mas_pcie_1 =3D {
+=09.name =3D "mas_pcie_1",
+=09.id =3D MSM8996_MASTER_PCIE_1,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 66,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_a0noc_common_links),
+=09.links =3D mas_a0noc_common_links
+};
+
+static struct qcom_icc_node mas_pcie_2 =3D {
+=09.name =3D "mas_pcie_2",
+=09.id =3D MSM8996_MASTER_PCIE_2,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 119,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 2,
+=09.num_links =3D ARRAY_SIZE(mas_a0noc_common_links),
+=09.links =3D mas_a0noc_common_links
+};
+
+static const u16 mas_a1noc_common_links[] =3D {
+=09MSM8996_SLAVE_A1NOC_SNOC
+};
+
+static struct qcom_icc_node mas_cnoc_a1noc =3D {
+=09.name =3D "mas_cnoc_a1noc",
+=09.id =3D MSM8996_MASTER_CNOC_A1NOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 116,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_a1noc_common_links),
+=09.links =3D mas_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_crypto_c0 =3D {
+=09.name =3D "mas_crypto_c0",
+=09.id =3D MSM8996_MASTER_CRYPTO_CORE0,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 23,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 0,
+=09.num_links =3D ARRAY_SIZE(mas_a1noc_common_links),
+=09.links =3D mas_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_pnoc_a1noc =3D {
+=09.name =3D "mas_pnoc_a1noc",
+=09.id =3D MSM8996_MASTER_PNOC_A1NOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 117,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D false,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_a1noc_common_links),
+=09.links =3D mas_a1noc_common_links
+};
+
+static const u16 mas_a2noc_common_links[] =3D {
+=09MSM8996_SLAVE_A2NOC_SNOC
+};
+
+static struct qcom_icc_node mas_usb3 =3D {
+=09.name =3D "mas_usb3",
+=09.id =3D MSM8996_MASTER_USB3,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 32,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 3,
+=09.num_links =3D ARRAY_SIZE(mas_a2noc_common_links),
+=09.links =3D mas_a2noc_common_links
+};
+
+static struct qcom_icc_node mas_ipa =3D {
+=09.name =3D "mas_ipa",
+=09.id =3D MSM8996_MASTER_IPA,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 59,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D -1,
+=09.num_links =3D ARRAY_SIZE(mas_a2noc_common_links),
+=09.links =3D mas_a2noc_common_links
+};
+
+static struct qcom_icc_node mas_ufs =3D {
+=09.name =3D "mas_ufs",
+=09.id =3D MSM8996_MASTER_UFS,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 68,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 2,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_a2noc_common_links),
+=09.links =3D mas_a2noc_common_links
+};
+
+static const u16 mas_apps_proc_links[] =3D {
+=09MSM8996_SLAVE_BIMC_SNOC_1,
+=09MSM8996_SLAVE_EBI_CH0,
+=09MSM8996_SLAVE_BIMC_SNOC_0
+};
+
+static struct qcom_icc_node mas_apps_proc =3D {
+=09.name =3D "mas_apps_proc",
+=09.id =3D MSM8996_MASTER_AMPSS_M0,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 0,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 0,
+=09.num_links =3D ARRAY_SIZE(mas_apps_proc_links),
+=09.links =3D mas_apps_proc_links
+};
+
+static const u16 mas_oxili_common_links[] =3D {
+=09MSM8996_SLAVE_BIMC_SNOC_1,
+=09MSM8996_SLAVE_HMSS_L3,
+=09MSM8996_SLAVE_EBI_CH0,
+=09MSM8996_SLAVE_BIMC_SNOC_0
+};
+
+static struct qcom_icc_node mas_oxili =3D {
+=09.name =3D "mas_oxili",
+=09.id =3D MSM8996_MASTER_GRAPHICS_3D,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 6,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_oxili_common_links),
+=09.links =3D mas_oxili_common_links
+};
+
+static struct qcom_icc_node mas_mnoc_bimc =3D {
+=09.name =3D "mas_mnoc_bimc",
+=09.id =3D MSM8996_MASTER_MNOC_BIMC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 2,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 2,
+=09.num_links =3D ARRAY_SIZE(mas_oxili_common_links),
+=09.links =3D mas_oxili_common_links
+};
+
+static const u16 mas_snoc_bimc_links[] =3D {
+=09MSM8996_SLAVE_HMSS_L3,
+=09MSM8996_SLAVE_EBI_CH0
+};
+
+static struct qcom_icc_node mas_snoc_bimc =3D {
+=09.name =3D "mas_snoc_bimc",
+=09.id =3D MSM8996_MASTER_SNOC_BIMC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 3,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D false,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D -1,
+=09.num_links =3D ARRAY_SIZE(mas_snoc_bimc_links),
+=09.links =3D mas_snoc_bimc_links
+};
+
+static const u16 mas_snoc_cnoc_links[] =3D {
+=09MSM8996_SLAVE_CLK_CTL,
+=09MSM8996_SLAVE_RBCPR_CX,
+=09MSM8996_SLAVE_A2NOC_SMMU_CFG,
+=09MSM8996_SLAVE_A0NOC_MPU_CFG,
+=09MSM8996_SLAVE_MESSAGE_RAM,
+=09MSM8996_SLAVE_CNOC_MNOC_MMSS_CFG,
+=09MSM8996_SLAVE_PCIE_0_CFG,
+=09MSM8996_SLAVE_TLMM,
+=09MSM8996_SLAVE_MPM,
+=09MSM8996_SLAVE_A0NOC_SMMU_CFG,
+=09MSM8996_SLAVE_EBI1_PHY_CFG,
+=09MSM8996_SLAVE_BIMC_CFG,
+=09MSM8996_SLAVE_PIMEM_CFG,
+=09MSM8996_SLAVE_RBCPR_MX,
+=09MSM8996_SLAVE_PRNG,
+=09MSM8996_SLAVE_PCIE20_AHB2PHY,
+=09MSM8996_SLAVE_A2NOC_MPU_CFG,
+=09MSM8996_SLAVE_QDSS_CFG,
+=09MSM8996_SLAVE_A2NOC_CFG,
+=09MSM8996_SLAVE_A0NOC_CFG,
+=09MSM8996_SLAVE_UFS_CFG,
+=09MSM8996_SLAVE_CRYPTO_0_CFG,
+=09MSM8996_SLAVE_PCIE_1_CFG,
+=09MSM8996_SLAVE_SNOC_CFG,
+=09MSM8996_SLAVE_SNOC_MPU_CFG,
+=09MSM8996_SLAVE_A1NOC_MPU_CFG,
+=09MSM8996_SLAVE_A1NOC_SMMU_CFG,
+=09MSM8996_SLAVE_PCIE_2_CFG,
+=09MSM8996_SLAVE_CNOC_MNOC_CFG,
+=09MSM8996_SLAVE_QDSS_RBCPR_APU_CFG,
+=09MSM8996_SLAVE_PMIC_ARB,
+=09MSM8996_SLAVE_IMEM_CFG,
+=09MSM8996_SLAVE_A1NOC_CFG,
+=09MSM8996_SLAVE_SSC_CFG,
+=09MSM8996_SLAVE_TCSR,
+=09MSM8996_SLAVE_LPASS_SMMU_CFG,
+=09MSM8996_SLAVE_DCC_CFG
+};
+
+static struct qcom_icc_node mas_snoc_cnoc =3D {
+=09.name =3D "mas_snoc_cnoc",
+=09.id =3D MSM8996_MASTER_SNOC_CNOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 52,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D 37,
+=09.num_links =3D ARRAY_SIZE(mas_snoc_cnoc_links),
+=09.links =3D mas_snoc_cnoc_links
+};
+
+static const u16 mas_qdss_dap_links[] =3D {
+=09MSM8996_SLAVE_QDSS_RBCPR_APU_CFG,
+=09MSM8996_SLAVE_RBCPR_CX,
+=09MSM8996_SLAVE_A2NOC_SMMU_CFG,
+=09MSM8996_SLAVE_A0NOC_MPU_CFG,
+=09MSM8996_SLAVE_MESSAGE_RAM,
+=09MSM8996_SLAVE_PCIE_0_CFG,
+=09MSM8996_SLAVE_TLMM,
+=09MSM8996_SLAVE_MPM,
+=09MSM8996_SLAVE_A0NOC_SMMU_CFG,
+=09MSM8996_SLAVE_EBI1_PHY_CFG,
+=09MSM8996_SLAVE_BIMC_CFG,
+=09MSM8996_SLAVE_PIMEM_CFG,
+=09MSM8996_SLAVE_RBCPR_MX,
+=09MSM8996_SLAVE_CLK_CTL,
+=09MSM8996_SLAVE_PRNG,
+=09MSM8996_SLAVE_PCIE20_AHB2PHY,
+=09MSM8996_SLAVE_A2NOC_MPU_CFG,
+=09MSM8996_SLAVE_QDSS_CFG,
+=09MSM8996_SLAVE_A2NOC_CFG,
+=09MSM8996_SLAVE_A0NOC_CFG,
+=09MSM8996_SLAVE_UFS_CFG,
+=09MSM8996_SLAVE_CRYPTO_0_CFG,
+=09MSM8996_SLAVE_CNOC_A1NOC,
+=09MSM8996_SLAVE_PCIE_1_CFG,
+=09MSM8996_SLAVE_SNOC_CFG,
+=09MSM8996_SLAVE_SNOC_MPU_CFG,
+=09MSM8996_SLAVE_A1NOC_MPU_CFG,
+=09MSM8996_SLAVE_A1NOC_SMMU_CFG,
+=09MSM8996_SLAVE_PCIE_2_CFG,
+=09MSM8996_SLAVE_CNOC_MNOC_CFG,
+=09MSM8996_SLAVE_CNOC_MNOC_MMSS_CFG,
+=09MSM8996_SLAVE_PMIC_ARB,
+=09MSM8996_SLAVE_IMEM_CFG,
+=09MSM8996_SLAVE_A1NOC_CFG,
+=09MSM8996_SLAVE_SSC_CFG,
+=09MSM8996_SLAVE_TCSR,
+=09MSM8996_SLAVE_LPASS_SMMU_CFG,
+=09MSM8996_SLAVE_DCC_CFG
+};
+
+static struct qcom_icc_node mas_qdss_dap =3D {
+=09.name =3D "mas_qdss_dap",
+=09.id =3D MSM8996_MASTER_QDSS_DAP,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 49,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_qdss_dap_links),
+=09.links =3D mas_qdss_dap_links
+};
+
+static const u16 mas_cnoc_mnoc_mmss_cfg_links[] =3D {
+=09MSM8996_SLAVE_MMAGIC_CFG,
+=09MSM8996_SLAVE_DSA_MPU_CFG,
+=09MSM8996_SLAVE_MMSS_CLK_CFG,
+=09MSM8996_SLAVE_CAMERA_THROTTLE_CFG,
+=09MSM8996_SLAVE_VENUS_CFG,
+=09MSM8996_SLAVE_SMMU_VFE_CFG,
+=09MSM8996_SLAVE_MISC_CFG,
+=09MSM8996_SLAVE_SMMU_CPP_CFG,
+=09MSM8996_SLAVE_GRAPHICS_3D_CFG,
+=09MSM8996_SLAVE_DISPLAY_THROTTLE_CFG,
+=09MSM8996_SLAVE_VENUS_THROTTLE_CFG,
+=09MSM8996_SLAVE_CAMERA_CFG,
+=09MSM8996_SLAVE_DISPLAY_CFG,
+=09MSM8996_SLAVE_CPR_CFG,
+=09MSM8996_SLAVE_SMMU_ROTATOR_CFG,
+=09MSM8996_SLAVE_DSA_CFG,
+=09MSM8996_SLAVE_SMMU_VENUS_CFG,
+=09MSM8996_SLAVE_VMEM_CFG,
+=09MSM8996_SLAVE_SMMU_JPEG_CFG,
+=09MSM8996_SLAVE_SMMU_MDP_CFG,
+=09MSM8996_SLAVE_MNOC_MPU_CFG
+};
+
+static struct qcom_icc_node mas_cnoc_mnoc_mmss_cfg =3D {
+=09.name =3D "mas_cnoc_mnoc_mmss_cfg",
+=09.id =3D MSM8996_MASTER_CNOC_MNOC_MMSS_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 4,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_cnoc_mnoc_mmss_cfg_links),
+=09.links =3D mas_cnoc_mnoc_mmss_cfg_links
+};
+
+static const u16 mas_cnoc_mnoc_cfg_links[] =3D {
+=09MSM8996_SLAVE_SERVICE_MNOC
+};
+
+static struct qcom_icc_node mas_cnoc_mnoc_cfg =3D {
+=09.name =3D "mas_cnoc_mnoc_cfg",
+=09.id =3D MSM8996_MASTER_CNOC_MNOC_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 5,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_cnoc_mnoc_cfg_links),
+=09.links =3D mas_cnoc_mnoc_cfg_links
+};
+
+static const u16 mas_mnoc_bimc_common_links[] =3D {
+=09MSM8996_SLAVE_MNOC_BIMC
+};
+
+static struct qcom_icc_node mas_cpp =3D {
+=09.name =3D "mas_cpp",
+=09.id =3D MSM8996_MASTER_CPP,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 115,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 5,
+=09.num_links =3D ARRAY_SIZE(mas_mnoc_bimc_common_links),
+=09.links =3D mas_mnoc_bimc_common_links
+};
+
+static struct qcom_icc_node mas_jpeg =3D {
+=09.name =3D "mas_jpeg",
+=09.id =3D MSM8996_MASTER_JPEG,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 7,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 7,
+=09.num_links =3D ARRAY_SIZE(mas_mnoc_bimc_common_links),
+=09.links =3D mas_mnoc_bimc_common_links
+};
+
+static struct qcom_icc_node mas_mdp_p0 =3D {
+=09.name =3D "mas_mdp_p0",
+=09.id =3D MSM8996_MASTER_MDP_PORT0,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 8,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_mnoc_bimc_common_links),
+=09.links =3D mas_mnoc_bimc_common_links
+};
+
+static struct qcom_icc_node mas_mdp_p1 =3D {
+=09.name =3D "mas_mdp_p1",
+=09.id =3D MSM8996_MASTER_MDP_PORT1,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 61,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 2,
+=09.num_links =3D ARRAY_SIZE(mas_mnoc_bimc_common_links),
+=09.links =3D mas_mnoc_bimc_common_links
+};
+
+static struct qcom_icc_node mas_rotator =3D {
+=09.name =3D "mas_rotator",
+=09.id =3D MSM8996_MASTER_ROTATOR,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 120,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 0,
+=09.num_links =3D ARRAY_SIZE(mas_mnoc_bimc_common_links),
+=09.links =3D mas_mnoc_bimc_common_links
+};
+
+static struct qcom_icc_node mas_venus =3D {
+=09.name =3D "mas_venus",
+=09.id =3D MSM8996_MASTER_VIDEO_P0,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 9,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 3,
+=09.num_links =3D ARRAY_SIZE(mas_mnoc_bimc_common_links),
+=09.links =3D mas_mnoc_bimc_common_links
+};
+
+static struct qcom_icc_node mas_vfe =3D {
+=09.name =3D "mas_vfe",
+=09.id =3D MSM8996_MASTER_VFE,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 11,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_BYPASS,
+=09.qos.areq_prio =3D 0,
+=09.qos.prio_level =3D 0,
+=09.qos.qos_port =3D 6,
+=09.num_links =3D ARRAY_SIZE(mas_mnoc_bimc_common_links),
+=09.links =3D mas_mnoc_bimc_common_links
+};
+
+static const u16 mas_vmem_common_links[] =3D {
+=09MSM8996_SLAVE_VMEM
+};
+
+static struct qcom_icc_node mas_snoc_vmem =3D {
+=09.name =3D "mas_snoc_vmem",
+=09.id =3D MSM8996_MASTER_SNOC_VMEM,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 114,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_vmem_common_links),
+=09.links =3D mas_vmem_common_links
+};
+
+static struct qcom_icc_node mas_venus_vmem =3D {
+=09.name =3D "mas_venus_vmem",
+=09.id =3D MSM8996_MASTER_VIDEO_P0_OCMEM,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D 121,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_vmem_common_links),
+=09.links =3D mas_vmem_common_links
+};
+
+static const u16 mas_snoc_pnoc_links[] =3D {
+=09MSM8996_SLAVE_BLSP_1,
+=09MSM8996_SLAVE_BLSP_2,
+=09MSM8996_SLAVE_SDCC_1,
+=09MSM8996_SLAVE_SDCC_2,
+=09MSM8996_SLAVE_SDCC_4,
+=09MSM8996_SLAVE_TSIF,
+=09MSM8996_SLAVE_PDM,
+=09MSM8996_SLAVE_AHB2PHY
+};
+
+static struct qcom_icc_node mas_snoc_pnoc =3D {
+=09.name =3D "mas_snoc_pnoc",
+=09.id =3D MSM8996_MASTER_SNOC_PNOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 44,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D ARRAY_SIZE(mas_snoc_pnoc_links),
+=09.links =3D mas_snoc_pnoc_links
+};
+
+static const u16 mas_pnoc_a1noc_common_links[] =3D {
+=09MSM8996_SLAVE_PNOC_A1NOC
+};
+
+static struct qcom_icc_node mas_sdcc_1 =3D {
+=09.name =3D "mas_sdcc_1",
+=09.id =3D MSM8996_MASTER_SDCC_1,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 33,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D ARRAY_SIZE(mas_pnoc_a1noc_common_links),
+=09.links =3D mas_pnoc_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_sdcc_2 =3D {
+=09.name =3D "mas_sdcc_2",
+=09.id =3D MSM8996_MASTER_SDCC_2,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 35,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_pnoc_a1noc_common_links),
+=09.links =3D mas_pnoc_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_sdcc_4 =3D {
+=09.name =3D "mas_sdcc_4",
+=09.id =3D MSM8996_MASTER_SDCC_4,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 36,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_pnoc_a1noc_common_links),
+=09.links =3D mas_pnoc_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_usb_hs =3D {
+=09.name =3D "mas_usb_hs",
+=09.id =3D MSM8996_MASTER_USB_HS,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 42,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_pnoc_a1noc_common_links),
+=09.links =3D mas_pnoc_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_blsp_1 =3D {
+=09.name =3D "mas_blsp_1",
+=09.id =3D MSM8996_MASTER_BLSP_1,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D 41,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_pnoc_a1noc_common_links),
+=09.links =3D mas_pnoc_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_blsp_2 =3D {
+=09.name =3D "mas_blsp_2",
+=09.id =3D MSM8996_MASTER_BLSP_2,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D 39,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_pnoc_a1noc_common_links),
+=09.links =3D mas_pnoc_a1noc_common_links
+};
+
+static struct qcom_icc_node mas_tsif =3D {
+=09.name =3D "mas_tsif",
+=09.id =3D MSM8996_MASTER_TSIF,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D 37,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(mas_pnoc_a1noc_common_links),
+=09.links =3D mas_pnoc_a1noc_common_links
+};
+
+static const u16 mas_hmss_links[] =3D {
+=09MSM8996_SLAVE_PIMEM,
+=09MSM8996_SLAVE_OCIMEM,
+=09MSM8996_SLAVE_SNOC_BIMC
+};
+
+static struct qcom_icc_node mas_hmss =3D {
+=09.name =3D "mas_hmss",
+=09.id =3D MSM8996_MASTER_HMSS,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D 118,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 4,
+=09.num_links =3D ARRAY_SIZE(mas_hmss_links),
+=09.links =3D mas_hmss_links
+};
+
+static const u16 mas_qdss_common_links[] =3D {
+=09MSM8996_SLAVE_PIMEM,
+=09MSM8996_SLAVE_USB3,
+=09MSM8996_SLAVE_OCIMEM,
+=09MSM8996_SLAVE_SNOC_BIMC,
+=09MSM8996_SLAVE_SNOC_PNOC
+};
+
+static struct qcom_icc_node mas_qdss_bam =3D {
+=09.name =3D "mas_qdss_bam",
+=09.id =3D MSM8996_MASTER_QDSS_BAM,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 19,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 2,
+=09.num_links =3D ARRAY_SIZE(mas_qdss_common_links),
+=09.links =3D mas_qdss_common_links
+};
+
+static const u16 mas_snoc_cfg_links[] =3D {
+=09MSM8996_SLAVE_SERVICE_SNOC
+};
+
+static struct qcom_icc_node mas_snoc_cfg =3D {
+=09.name =3D "mas_snoc_cfg",
+=09.id =3D MSM8996_MASTER_SNOC_CFG,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 20,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_snoc_cfg_links),
+=09.links =3D mas_snoc_cfg_links
+};
+
+static const u16 mas_bimc_snoc_0_links[] =3D {
+=09MSM8996_SLAVE_SNOC_VMEM,
+=09MSM8996_SLAVE_USB3,
+=09MSM8996_SLAVE_PIMEM,
+=09MSM8996_SLAVE_LPASS,
+=09MSM8996_SLAVE_APPSS,
+=09MSM8996_SLAVE_SNOC_CNOC,
+=09MSM8996_SLAVE_SNOC_PNOC,
+=09MSM8996_SLAVE_OCIMEM,
+=09MSM8996_SLAVE_QDSS_STM
+};
+
+static struct qcom_icc_node mas_bimc_snoc_0 =3D {
+=09.name =3D "mas_bimc_snoc_0",
+=09.id =3D MSM8996_MASTER_BIMC_SNOC_0,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 21,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_bimc_snoc_0_links),
+=09.links =3D mas_bimc_snoc_0_links
+};
+
+static const u16 mas_bimc_snoc_1_links[] =3D {
+=09MSM8996_SLAVE_PCIE_2,
+=09MSM8996_SLAVE_PCIE_1,
+=09MSM8996_SLAVE_PCIE_0
+};
+
+static struct qcom_icc_node mas_bimc_snoc_1 =3D {
+=09.name =3D "mas_bimc_snoc_1",
+=09.id =3D MSM8996_MASTER_BIMC_SNOC_1,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 109,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_bimc_snoc_1_links),
+=09.links =3D mas_bimc_snoc_1_links
+};
+
+static const u16 mas_a0noc_snoc_links[] =3D {
+=09MSM8996_SLAVE_SNOC_PNOC,
+=09MSM8996_SLAVE_OCIMEM,
+=09MSM8996_SLAVE_APPSS,
+=09MSM8996_SLAVE_SNOC_BIMC,
+=09MSM8996_SLAVE_PIMEM
+};
+
+static struct qcom_icc_node mas_a0noc_snoc =3D {
+=09.name =3D "mas_a0noc_snoc",
+=09.id =3D MSM8996_MASTER_A0NOC_SNOC,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 110,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(mas_a0noc_snoc_links),
+=09.links =3D mas_a0noc_snoc_links
+};
+
+static const u16 mas_a1noc_snoc_links[] =3D {
+=09MSM8996_SLAVE_SNOC_VMEM,
+=09MSM8996_SLAVE_USB3,
+=09MSM8996_SLAVE_PCIE_0,
+=09MSM8996_SLAVE_PIMEM,
+=09MSM8996_SLAVE_PCIE_2,
+=09MSM8996_SLAVE_LPASS,
+=09MSM8996_SLAVE_PCIE_1,
+=09MSM8996_SLAVE_APPSS,
+=09MSM8996_SLAVE_SNOC_BIMC,
+=09MSM8996_SLAVE_SNOC_CNOC,
+=09MSM8996_SLAVE_SNOC_PNOC,
+=09MSM8996_SLAVE_OCIMEM,
+=09MSM8996_SLAVE_QDSS_STM
+};
+
+static struct qcom_icc_node mas_a1noc_snoc =3D {
+=09.name =3D "mas_a1noc_snoc",
+=09.id =3D MSM8996_MASTER_A1NOC_SNOC,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 111,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D ARRAY_SIZE(mas_a1noc_snoc_links),
+=09.links =3D mas_a1noc_snoc_links
+};
+
+static const u16 mas_a2noc_snoc_links[] =3D {
+=09MSM8996_SLAVE_SNOC_VMEM,
+=09MSM8996_SLAVE_USB3,
+=09MSM8996_SLAVE_PCIE_1,
+=09MSM8996_SLAVE_PIMEM,
+=09MSM8996_SLAVE_PCIE_2,
+=09MSM8996_SLAVE_QDSS_STM,
+=09MSM8996_SLAVE_LPASS,
+=09MSM8996_SLAVE_SNOC_BIMC,
+=09MSM8996_SLAVE_SNOC_CNOC,
+=09MSM8996_SLAVE_SNOC_PNOC,
+=09MSM8996_SLAVE_OCIMEM,
+=09MSM8996_SLAVE_PCIE_0
+};
+
+static struct qcom_icc_node mas_a2noc_snoc =3D {
+=09.name =3D "mas_a2noc_snoc",
+=09.id =3D MSM8996_MASTER_A2NOC_SNOC,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 112,
+=09.slv_rpm_id =3D -1,
+=09.num_links =3D ARRAY_SIZE(mas_a2noc_snoc_links),
+=09.links =3D mas_a2noc_snoc_links
+};
+
+static struct qcom_icc_node mas_qdss_etr =3D {
+=09.name =3D "mas_qdss_etr",
+=09.id =3D MSM8996_MASTER_QDSS_ETR,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D 31,
+=09.slv_rpm_id =3D -1,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_FIXED,
+=09.qos.areq_prio =3D 1,
+=09.qos.prio_level =3D 1,
+=09.qos.qos_port =3D 3,
+=09.num_links =3D ARRAY_SIZE(mas_qdss_common_links),
+=09.links =3D mas_qdss_common_links
+};
+
+static const u16 slv_a0noc_snoc_links[] =3D {
+=09MSM8996_MASTER_A0NOC_SNOC
+};
+
+static struct qcom_icc_node slv_a0noc_snoc =3D {
+=09.name =3D "slv_a0noc_snoc",
+=09.id =3D MSM8996_SLAVE_A0NOC_SNOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 141,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_a0noc_snoc_links),
+=09.links =3D slv_a0noc_snoc_links
+};
+
+static const u16 slv_a1noc_snoc_links[] =3D {
+=09MSM8996_MASTER_A1NOC_SNOC
+};
+
+static struct qcom_icc_node slv_a1noc_snoc =3D {
+=09.name =3D "slv_a1noc_snoc",
+=09.id =3D MSM8996_SLAVE_A1NOC_SNOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 142,
+=09.num_links =3D ARRAY_SIZE(slv_a1noc_snoc_links),
+=09.links =3D slv_a1noc_snoc_links
+};
+
+static const u16 slv_a2noc_snoc_links[] =3D {
+=09MSM8996_MASTER_A2NOC_SNOC
+};
+
+static struct qcom_icc_node slv_a2noc_snoc =3D {
+=09.name =3D "slv_a2noc_snoc",
+=09.id =3D MSM8996_SLAVE_A2NOC_SNOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 143,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(slv_a2noc_snoc_links),
+=09.links =3D slv_a2noc_snoc_links
+};
+
+static struct qcom_icc_node slv_ebi =3D {
+=09.name =3D "slv_ebi",
+=09.id =3D MSM8996_SLAVE_EBI_CH0,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 0
+};
+
+static struct qcom_icc_node slv_hmss_l3 =3D {
+=09.name =3D "slv_hmss_l3",
+=09.id =3D MSM8996_SLAVE_HMSS_L3,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 160
+};
+
+static const u16 slv_bimc_snoc_0_links[] =3D {
+=09MSM8996_MASTER_BIMC_SNOC_0
+};
+
+static struct qcom_icc_node slv_bimc_snoc_0 =3D {
+=09.name =3D "slv_bimc_snoc_0",
+=09.id =3D MSM8996_SLAVE_BIMC_SNOC_0,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 2,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_bimc_snoc_0_links),
+=09.links =3D slv_bimc_snoc_0_links
+};
+
+static const u16 slv_bimc_snoc_1_links[] =3D {
+=09MSM8996_MASTER_BIMC_SNOC_1
+};
+
+static struct qcom_icc_node slv_bimc_snoc_1 =3D {
+=09.name =3D "slv_bimc_snoc_1",
+=09.id =3D MSM8996_SLAVE_BIMC_SNOC_1,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 138,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_bimc_snoc_1_links),
+=09.links =3D slv_bimc_snoc_1_links
+};
+
+static const u16 slv_cnoc_a1noc_links[] =3D {
+=09MSM8996_MASTER_CNOC_A1NOC
+};
+
+static struct qcom_icc_node slv_cnoc_a1noc =3D {
+=09.name =3D "slv_cnoc_a1noc",
+=09.id =3D MSM8996_SLAVE_CNOC_A1NOC,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 75,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_cnoc_a1noc_links),
+=09.links =3D slv_cnoc_a1noc_links
+};
+
+static struct qcom_icc_node slv_clk_ctl =3D {
+=09.name =3D "slv_clk_ctl",
+=09.id =3D MSM8996_SLAVE_CLK_CTL,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 47
+};
+
+static struct qcom_icc_node slv_tcsr =3D {
+=09.name =3D "slv_tcsr",
+=09.id =3D MSM8996_SLAVE_TCSR,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 50
+};
+
+static struct qcom_icc_node slv_tlmm =3D {
+=09.name =3D "slv_tlmm",
+=09.id =3D MSM8996_SLAVE_TLMM,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 51
+};
+
+static struct qcom_icc_node slv_crypto0_cfg =3D {
+=09.name =3D "slv_crypto0_cfg",
+=09.id =3D MSM8996_SLAVE_CRYPTO_0_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 52,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_mpm =3D {
+=09.name =3D "slv_mpm",
+=09.id =3D MSM8996_SLAVE_MPM,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 62,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pimem_cfg =3D {
+=09.name =3D "slv_pimem_cfg",
+=09.id =3D MSM8996_SLAVE_PIMEM_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 167,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_imem_cfg =3D {
+=09.name =3D "slv_imem_cfg",
+=09.id =3D MSM8996_SLAVE_IMEM_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 54,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_message_ram =3D {
+=09.name =3D "slv_message_ram",
+=09.id =3D MSM8996_SLAVE_MESSAGE_RAM,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 55
+};
+
+static struct qcom_icc_node slv_bimc_cfg =3D {
+=09.name =3D "slv_bimc_cfg",
+=09.id =3D MSM8996_SLAVE_BIMC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 56,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pmic_arb =3D {
+=09.name =3D "slv_pmic_arb",
+=09.id =3D MSM8996_SLAVE_PMIC_ARB,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 59
+};
+
+static struct qcom_icc_node slv_prng =3D {
+=09.name =3D "slv_prng",
+=09.id =3D MSM8996_SLAVE_PRNG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 127,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_dcc_cfg =3D {
+=09.name =3D "slv_dcc_cfg",
+=09.id =3D MSM8996_SLAVE_DCC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 155,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_rbcpr_mx =3D {
+=09.name =3D "slv_rbcpr_mx",
+=09.id =3D MSM8996_SLAVE_RBCPR_MX,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 170,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_qdss_cfg =3D {
+=09.name =3D "slv_qdss_cfg",
+=09.id =3D MSM8996_SLAVE_QDSS_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 63,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_rbcpr_cx =3D {
+=09.name =3D "slv_rbcpr_cx",
+=09.id =3D MSM8996_SLAVE_RBCPR_CX,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 169,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_cpu_apu_cfg =3D {
+=09.name =3D "slv_cpu_apu_cfg",
+=09.id =3D MSM8996_SLAVE_QDSS_RBCPR_APU_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 168,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static const u16 slv_cnoc_mnoc_cfg_links[] =3D {
+=09MSM8996_MASTER_CNOC_MNOC_CFG
+};
+
+static struct qcom_icc_node slv_cnoc_mnoc_cfg =3D {
+=09.name =3D "slv_cnoc_mnoc_cfg",
+=09.id =3D MSM8996_SLAVE_CNOC_MNOC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 66,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_cnoc_mnoc_cfg_links),
+=09.links =3D slv_cnoc_mnoc_cfg_links
+};
+
+static struct qcom_icc_node slv_snoc_cfg =3D {
+=09.name =3D "slv_snoc_cfg",
+=09.id =3D MSM8996_SLAVE_SNOC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 70,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_snoc_mpu_cfg =3D {
+=09.name =3D "slv_snoc_mpu_cfg",
+=09.id =3D MSM8996_SLAVE_SNOC_MPU_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 67,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_ebi1_phy_cfg =3D {
+=09.name =3D "slv_ebi1_phy_cfg",
+=09.id =3D MSM8996_SLAVE_EBI1_PHY_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 73,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a0noc_cfg =3D {
+=09.name =3D "slv_a0noc_cfg",
+=09.id =3D MSM8996_SLAVE_A0NOC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 144,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pcie_1_cfg =3D {
+=09.name =3D "slv_pcie_1_cfg",
+=09.id =3D MSM8996_SLAVE_PCIE_1_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 89,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pcie_2_cfg =3D {
+=09.name =3D "slv_pcie_2_cfg",
+=09.id =3D MSM8996_SLAVE_PCIE_2_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 165,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pcie_0_cfg =3D {
+=09.name =3D "slv_pcie_0_cfg",
+=09.id =3D MSM8996_SLAVE_PCIE_0_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 88,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pcie20_ahb2phy =3D {
+=09.name =3D "slv_pcie20_ahb2phy",
+=09.id =3D MSM8996_SLAVE_PCIE20_AHB2PHY,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 163,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a0noc_mpu_cfg =3D {
+=09.name =3D "slv_a0noc_mpu_cfg",
+=09.id =3D MSM8996_SLAVE_A0NOC_MPU_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 145,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_ufs_cfg =3D {
+=09.name =3D "slv_ufs_cfg",
+=09.id =3D MSM8996_SLAVE_UFS_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 92,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a1noc_cfg =3D {
+=09.name =3D "slv_a1noc_cfg",
+=09.id =3D MSM8996_SLAVE_A1NOC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 147,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a1noc_mpu_cfg =3D {
+=09.name =3D "slv_a1noc_mpu_cfg",
+=09.id =3D MSM8996_SLAVE_A1NOC_MPU_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 148,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a2noc_cfg =3D {
+=09.name =3D "slv_a2noc_cfg",
+=09.id =3D MSM8996_SLAVE_A2NOC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 150,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a2noc_mpu_cfg =3D {
+=09.name =3D "slv_a2noc_mpu_cfg",
+=09.id =3D MSM8996_SLAVE_A2NOC_MPU_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 151,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_ssc_cfg =3D {
+=09.name =3D "slv_ssc_cfg",
+=09.id =3D MSM8996_SLAVE_SSC_CFG,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 177,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a0noc_smmu_cfg =3D {
+=09.name =3D "slv_a0noc_smmu_cfg",
+=09.id =3D MSM8996_SLAVE_A0NOC_SMMU_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 146,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a1noc_smmu_cfg =3D {
+=09.name =3D "slv_a1noc_smmu_cfg",
+=09.id =3D MSM8996_SLAVE_A1NOC_SMMU_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 149,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_a2noc_smmu_cfg =3D {
+=09.name =3D "slv_a2noc_smmu_cfg",
+=09.id =3D MSM8996_SLAVE_A2NOC_SMMU_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 152,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_lpass_smmu_cfg =3D {
+=09.name =3D "slv_lpass_smmu_cfg",
+=09.id =3D MSM8996_SLAVE_LPASS_SMMU_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 161,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static const u16 slv_cnoc_mnoc_mmss_cfg_links[] =3D {
+=09MSM8996_MASTER_CNOC_MNOC_MMSS_CFG
+};
+
+static struct qcom_icc_node slv_cnoc_mnoc_mmss_cfg =3D {
+=09.name =3D "slv_cnoc_mnoc_mmss_cfg",
+=09.id =3D MSM8996_SLAVE_CNOC_MNOC_MMSS_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 58,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_cnoc_mnoc_mmss_cfg_links),
+=09.links =3D slv_cnoc_mnoc_mmss_cfg_links
+};
+
+static struct qcom_icc_node slv_mmagic_cfg =3D {
+=09.name =3D "slv_mmagic_cfg",
+=09.id =3D MSM8996_SLAVE_MMAGIC_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 162,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_cpr_cfg =3D {
+=09.name =3D "slv_cpr_cfg",
+=09.id =3D MSM8996_SLAVE_CPR_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 6,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_misc_cfg =3D {
+=09.name =3D "slv_misc_cfg",
+=09.id =3D MSM8996_SLAVE_MISC_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 8,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_venus_throttle_cfg =3D {
+=09.name =3D "slv_venus_throttle_cfg",
+=09.id =3D MSM8996_SLAVE_VENUS_THROTTLE_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 178,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_venus_cfg =3D {
+=09.name =3D "slv_venus_cfg",
+=09.id =3D MSM8996_SLAVE_VENUS_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 10,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_vmem_cfg =3D {
+=09.name =3D "slv_vmem_cfg",
+=09.id =3D MSM8996_SLAVE_VMEM_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 180,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_dsa_cfg =3D {
+=09.name =3D "slv_dsa_cfg",
+=09.id =3D MSM8996_SLAVE_DSA_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 157,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_mnoc_clocks_cfg =3D {
+=09.name =3D "slv_mnoc_clocks_cfg",
+=09.id =3D MSM8996_SLAVE_MMSS_CLK_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 12,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_dsa_mpu_cfg =3D {
+=09.name =3D "slv_dsa_mpu_cfg",
+=09.id =3D MSM8996_SLAVE_DSA_MPU_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 158,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_mnoc_mpu_cfg =3D {
+=09.name =3D "slv_mnoc_mpu_cfg",
+=09.id =3D MSM8996_SLAVE_MNOC_MPU_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 14,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_display_cfg =3D {
+=09.name =3D "slv_display_cfg",
+=09.id =3D MSM8996_SLAVE_DISPLAY_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 4,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_display_throttle_cfg =3D {
+=09.name =3D "slv_display_throttle_cfg",
+=09.id =3D MSM8996_SLAVE_DISPLAY_THROTTLE_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 156,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_camera_cfg =3D {
+=09.name =3D "slv_camera_cfg",
+=09.id =3D MSM8996_SLAVE_CAMERA_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 3,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_camera_throttle_cfg =3D {
+=09.name =3D "slv_camera_throttle_cfg",
+=09.id =3D MSM8996_SLAVE_CAMERA_THROTTLE_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 154,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_oxili_cfg =3D {
+=09.name =3D "slv_oxili_cfg",
+=09.id =3D MSM8996_SLAVE_GRAPHICS_3D_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 11,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_smmu_mdp_cfg =3D {
+=09.name =3D "slv_smmu_mdp_cfg",
+=09.id =3D MSM8996_SLAVE_SMMU_MDP_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 173,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_smmu_rot_cfg =3D {
+=09.name =3D "slv_smmu_rot_cfg",
+=09.id =3D MSM8996_SLAVE_SMMU_ROTATOR_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 174,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_smmu_venus_cfg =3D {
+=09.name =3D "slv_smmu_venus_cfg",
+=09.id =3D MSM8996_SLAVE_SMMU_VENUS_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 175,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_smmu_cpp_cfg =3D {
+=09.name =3D "slv_smmu_cpp_cfg",
+=09.id =3D MSM8996_SLAVE_SMMU_CPP_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 171,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_smmu_jpeg_cfg =3D {
+=09.name =3D "slv_smmu_jpeg_cfg",
+=09.id =3D MSM8996_SLAVE_SMMU_JPEG_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 172,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_smmu_vfe_cfg =3D {
+=09.name =3D "slv_smmu_vfe_cfg",
+=09.id =3D MSM8996_SLAVE_SMMU_VFE_CFG,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 176,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static const u16 slv_mnoc_bimc_links[] =3D {
+=09MSM8996_MASTER_MNOC_BIMC
+};
+
+static struct qcom_icc_node slv_mnoc_bimc =3D {
+=09.name =3D "slv_mnoc_bimc",
+=09.id =3D MSM8996_SLAVE_MNOC_BIMC,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 16,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_mnoc_bimc_links),
+=09.links =3D slv_mnoc_bimc_links
+};
+
+static struct qcom_icc_node slv_vmem =3D {
+=09.name =3D "slv_vmem",
+=09.id =3D MSM8996_SLAVE_VMEM,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 179,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_srvc_mnoc =3D {
+=09.name =3D "slv_srvc_mnoc",
+=09.id =3D MSM8996_SLAVE_SERVICE_MNOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 17,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static const u16 slv_pnoc_a1noc_links[] =3D {
+=09MSM8996_MASTER_PNOC_A1NOC
+};
+
+static struct qcom_icc_node slv_pnoc_a1noc =3D {
+=09.name =3D "slv_pnoc_a1noc",
+=09.id =3D MSM8996_SLAVE_PNOC_A1NOC,
+=09.buswidth =3D 8,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 139,
+=09.num_links =3D ARRAY_SIZE(slv_pnoc_a1noc_links),
+=09.links =3D slv_pnoc_a1noc_links
+};
+
+static struct qcom_icc_node slv_usb_hs =3D {
+=09.name =3D "slv_usb_hs",
+=09.id =3D MSM8996_SLAVE_USB_HS,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 40
+};
+
+static struct qcom_icc_node slv_sdcc_2 =3D {
+=09.name =3D "slv_sdcc_2",
+=09.id =3D MSM8996_SLAVE_SDCC_2,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 33
+};
+
+static struct qcom_icc_node slv_sdcc_4 =3D {
+=09.name =3D "slv_sdcc_4",
+=09.id =3D MSM8996_SLAVE_SDCC_4,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 34
+};
+
+static struct qcom_icc_node slv_tsif =3D {
+=09.name =3D "slv_tsif",
+=09.id =3D MSM8996_SLAVE_TSIF,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 35
+};
+
+static struct qcom_icc_node slv_blsp_2 =3D {
+=09.name =3D "slv_blsp_2",
+=09.id =3D MSM8996_SLAVE_BLSP_2,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 37
+};
+
+static struct qcom_icc_node slv_sdcc_1 =3D {
+=09.name =3D "slv_sdcc_1",
+=09.id =3D MSM8996_SLAVE_SDCC_1,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 31
+};
+
+static struct qcom_icc_node slv_blsp_1 =3D {
+=09.name =3D "slv_blsp_1",
+=09.id =3D MSM8996_SLAVE_BLSP_1,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 39
+};
+
+static struct qcom_icc_node slv_pdm =3D {
+=09.name =3D "slv_pdm",
+=09.id =3D MSM8996_SLAVE_PDM,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 41
+};
+
+static struct qcom_icc_node slv_ahb2phy =3D {
+=09.name =3D "slv_ahb2phy",
+=09.id =3D MSM8996_SLAVE_AHB2PHY,
+=09.buswidth =3D 4,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 153,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_hmss =3D {
+=09.name =3D "slv_hmss",
+=09.id =3D MSM8996_SLAVE_APPSS,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 20,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_lpass =3D {
+=09.name =3D "slv_lpass",
+=09.id =3D MSM8996_SLAVE_LPASS,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 21,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_usb3 =3D {
+=09.name =3D "slv_usb3",
+=09.id =3D MSM8996_SLAVE_USB3,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 22,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static const u16 slv_snoc_bimc_links[] =3D {
+=09MSM8996_MASTER_SNOC_BIMC
+};
+
+static struct qcom_icc_node slv_snoc_bimc =3D {
+=09.name =3D "slv_snoc_bimc",
+=09.id =3D MSM8996_SLAVE_SNOC_BIMC,
+=09.buswidth =3D 32,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 24,
+=09.num_links =3D 1,
+=09.num_links =3D ARRAY_SIZE(slv_snoc_bimc_links),
+=09.links =3D slv_snoc_bimc_links
+};
+
+static const u16 slv_snoc_cnoc_links[] =3D {
+=09MSM8996_MASTER_SNOC_CNOC
+};
+
+static struct qcom_icc_node slv_snoc_cnoc =3D {
+=09.name =3D "slv_snoc_cnoc",
+=09.id =3D MSM8996_SLAVE_SNOC_CNOC,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 25,
+=09.num_links =3D ARRAY_SIZE(slv_snoc_cnoc_links),
+=09.links =3D slv_snoc_cnoc_links
+};
+
+static struct qcom_icc_node slv_imem =3D {
+=09.name =3D "slv_imem",
+=09.id =3D MSM8996_SLAVE_OCIMEM,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 26
+};
+
+static struct qcom_icc_node slv_pimem =3D {
+=09.name =3D "slv_pimem",
+=09.id =3D MSM8996_SLAVE_PIMEM,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 166
+};
+
+static const u16 slv_snoc_vmem_links[] =3D {
+=09MSM8996_MASTER_SNOC_VMEM
+};
+
+static struct qcom_icc_node slv_snoc_vmem =3D {
+=09.name =3D "slv_snoc_vmem",
+=09.id =3D MSM8996_SLAVE_SNOC_VMEM,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 140,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID,
+=09.num_links =3D ARRAY_SIZE(slv_snoc_vmem_links),
+=09.links =3D slv_snoc_vmem_links
+};
+
+static const u16 slv_snoc_pnoc_links[] =3D {
+=09MSM8996_MASTER_SNOC_PNOC
+};
+
+static struct qcom_icc_node slv_snoc_pnoc =3D {
+=09.name =3D "slv_snoc_pnoc",
+=09.id =3D MSM8996_SLAVE_SNOC_PNOC,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 28,
+=09.num_links =3D ARRAY_SIZE(slv_snoc_pnoc_links),
+=09.links =3D slv_snoc_pnoc_links
+};
+
+static struct qcom_icc_node slv_qdss_stm =3D {
+=09.name =3D "slv_qdss_stm",
+=09.id =3D MSM8996_SLAVE_QDSS_STM,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 30
+};
+
+static struct qcom_icc_node slv_pcie_0 =3D {
+=09.name =3D "slv_pcie_0",
+=09.id =3D MSM8996_SLAVE_PCIE_0,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 84,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pcie_1 =3D {
+=09.name =3D "slv_pcie_1",
+=09.id =3D MSM8996_SLAVE_PCIE_1,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 85,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_pcie_2 =3D {
+=09.name =3D "slv_pcie_2",
+=09.id =3D MSM8996_SLAVE_PCIE_2,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 164,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node slv_srvc_snoc =3D {
+=09.name =3D "slv_srvc_snoc",
+=09.id =3D MSM8996_SLAVE_SERVICE_SNOC,
+=09.buswidth =3D 16,
+=09.mas_rpm_id =3D -1,
+=09.slv_rpm_id =3D 29,
+=09.qos.ap_owned =3D true,
+=09.qos.qos_mode =3D NOC_QOS_MODE_INVALID
+};
+
+static struct qcom_icc_node *a0noc_nodes[] =3D {
+=09[MASTER_PCIE_0] =3D &mas_pcie_0,
+=09[MASTER_PCIE_1] =3D &mas_pcie_1,
+=09[MASTER_PCIE_2] =3D &mas_pcie_2
+};
+
+static const struct regmap_config msm8996_a0noc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x9000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_a0noc =3D {
+=09.nodes =3D a0noc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(a0noc_nodes),
+=09.clocks =3D bus_a0noc_clocks,
+=09.num_clocks =3D ARRAY_SIZE(bus_a0noc_clocks),
+=09.has_bus_pd =3D true,
+=09.regmap_cfg =3D &msm8996_a0noc_regmap_config
+};
+
+static struct qcom_icc_node *a1noc_nodes[] =3D {
+=09[MASTER_CNOC_A1NOC] =3D &mas_cnoc_a1noc,
+=09[MASTER_CRYPTO_CORE0] =3D &mas_crypto_c0,
+=09[MASTER_PNOC_A1NOC] =3D &mas_pnoc_a1noc
+};
+
+static const struct regmap_config msm8996_a1noc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x7000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_a1noc =3D {
+=09.nodes =3D a1noc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(a1noc_nodes),
+=09.regmap_cfg =3D &msm8996_a1noc_regmap_config
+};
+
+static struct qcom_icc_node *a2noc_nodes[] =3D {
+=09[MASTER_USB3] =3D &mas_usb3,
+=09[MASTER_IPA] =3D &mas_ipa,
+=09[MASTER_UFS] =3D &mas_ufs
+};
+
+static const struct regmap_config msm8996_a2noc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0xa000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_a2noc =3D {
+=09.nodes =3D a2noc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(a2noc_nodes),
+=09.regmap_cfg =3D &msm8996_a2noc_regmap_config
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
+=09[SLAVE_BIMC_SNOC_1] =3D &slv_bimc_snoc_1
+};
+
+static const struct regmap_config msm8996_bimc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x62000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_bimc =3D {
+=09.nodes =3D bimc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(bimc_nodes),
+=09.is_bimc_node =3D true,
+=09.regmap_cfg =3D &msm8996_bimc_regmap_config
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
+=09[SLAVE_CNOC_MNOC_MMSS_CFG] =3D &slv_cnoc_mnoc_mmss_cfg
+};
+
+static const struct regmap_config msm8996_cnoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x1000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_cnoc =3D {
+=09.nodes =3D cnoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(cnoc_nodes),
+=09.regmap_cfg =3D &msm8996_cnoc_regmap_config
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
+=09[SLAVE_SMMU_VFE_CFG] =3D &slv_smmu_vfe_cfg
+};
+
+static const struct regmap_config msm8996_mnoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x20000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_mnoc =3D {
+=09.nodes =3D mnoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(mnoc_nodes),
+=09.clocks =3D bus_mm_clocks,
+=09.num_clocks =3D ARRAY_SIZE(bus_mm_clocks),
+=09.regmap_cfg =3D &msm8996_mnoc_regmap_config
+};
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
+=09[SLAVE_AHB2PHY] =3D &slv_ahb2phy
+};
+
+static const struct regmap_config msm8996_pnoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x3000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_pnoc =3D {
+=09.nodes =3D pnoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(pnoc_nodes),
+=09.regmap_cfg =3D &msm8996_pnoc_regmap_config
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
+=09[SLAVE_SERVICE_SNOC] =3D &slv_srvc_snoc
+};
+
+static const struct regmap_config msm8996_snoc_regmap_config =3D {
+=09.reg_bits=09=3D 32,
+=09.reg_stride=09=3D 4,
+=09.val_bits=09=3D 32,
+=09.max_register=09=3D 0x20000,
+=09.fast_io=09=3D true
+};
+
+static const struct qcom_icc_desc msm8996_snoc =3D {
+=09.nodes =3D snoc_nodes,
+=09.num_nodes =3D ARRAY_SIZE(snoc_nodes),
+=09.regmap_cfg =3D &msm8996_snoc_regmap_config
+};
+
+static const struct of_device_id qnoc_of_match[] =3D {
+=09{ .compatible =3D "qcom,msm8996-a0noc", .data =3D &msm8996_a0noc},
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
+=09}
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
2.33.1


