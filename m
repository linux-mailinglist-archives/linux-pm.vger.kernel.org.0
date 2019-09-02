Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8FA5D74
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 23:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfIBVTm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 17:19:42 -0400
Received: from onstation.org ([52.200.56.107]:51248 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfIBVTl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 17:19:41 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 8D00A450B6;
        Mon,  2 Sep 2019 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1567459178;
        bh=lDEPfffLPvWLWxGAX8ESWBk+PYGG44vqeJUfD42k4Jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3J9W1PYPDCfWIkz5JHtH0J7kzGMjZ5RHgGXr9xOQZjQMrI1mVyGNHwLgnuRtD+lJ
         m6Hchv+WYgH5k5H6x8LqzvHLQxMqOVZ0duCncfsLM0Gv/MYK2r+brlI4JC2CvO23HD
         hbOLMekNrGm52bknRpwIGnTjc0HCcsbgu72OOTOE=
From:   Brian Masney <masneyb@onstation.org>
To:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] interconnect: qcom: add msm8974 driver
Date:   Mon,  2 Sep 2019 17:19:25 -0400
Message-Id: <20190902211925.27169-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902211925.27169-1-masneyb@onstation.org>
References: <20190902211925.27169-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver for the Qualcomm MSM8974 interconnect providers that support
setting system bandwidth requirements between various network-on-chip
fabrics.

I marked this as a PATCH RFC since I'm not able to write to all of the
master IDs with qcom_icc_rpm_smd_send(). I included tables below that
shows which of the 20 master IDs that I'm able to activate with
qcom_icc_rpm_smd_send() [1] and the remaining 37 where
qcom_icc_rpm_smd_send() fails with -ENXIO [2].

The device tree snippets that I'm using is in patch 1 of this series,
however the relevant interconnect properties for the mdp5 are:

    interconnects = <&mmssnoc MNOC_MAS_GRAPHICS_3D &bimc BIMC_SLV_EBI_CH0>,
                    <&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;
    interconnect-names = "mdp0-mem", "mdp1-mem";

The two interconnects have the following paths:

- mdp0-mem
  - mas_graphics_3d
  - mnoc_to_bimc
  - bimc_to_mnoc
  - slv_ebi_ch0

- mdp1-mem
  - mas_v_ocmem_gfx3d
  - ocmem_vnoc_to_onoc
  - ocmem_noc_to_ocmem_vnoc
  - slv_ocmem

ocmem_noc_to_ocmem_vnoc is the only one that is successfully activated
and the remaining fail in these two paths.

With this interconnect driver, I am able to remove a clock hack that I
had in place that set the speed of MDSS_AXI_CLK high and I'm able to use
kmscube. However, I do see a clock warning on system startup [3].

The display doesn't work for me with the downstream MSM sources so I may
have to get that working to debug this some more unless anyone has any
suggestions. I verified that the downstream msm8974 sources are using
rpm smd to setup the interconnects for the msm bus:
https://github.com/AICP/kernel_lge_hammerhead/blob/n7.1/arch/arm/mach-msm/msm_bus/msm_bus_rpm_smd.c#L153
The only difference I noticed is that that upstream uses a 32 bit field
for the 'value' field in drivers/interconnect/qcom/smd-rpm.c for
qcom_icc_rpm_smd_send(), and downstream uses a 64 bit value instead.
Changing that upstream doesn't make a difference.

Downstream msm8974 msm bus code:
https://github.com/AICP/kernel_lge_hammerhead/blob/n7.1/arch/arm/mach-msm/msm_bus/msm_bus_board_8974.c

[1] Master IDs that I'm able to activate with qcom_icc_rpm_smd_send():

    HW ID    Name
    -------------------------------
     3       mas_mss_proc
    18       slv_tcsr
    21       slv_crypto_1_cfg
    22       slv_imem_cfg
    25       slv_boot_rom
    29       slv_mpm
    33       cnoc_to_snoc
    34       slv_cnoc_onoc_cfg
    35       slv_cnoc_mnoc_mmss_cfg
    36       slv_cnoc_mnoc_cfg
    37       slv_pnoc_cfg
    38       slv_snoc_mpu_cfg
    39       slv_snoc_cfg
    40       slv_ebi1_dll_cfg
    41       slv_phy_apu_cfg
    42       slv_ebi1_phy_cfg
    43       slv_rpm
    44       slv_service_cnoc
    52       mnoc_to_bimc
    54       slv_display_cfg

[2] Master IDs where qcom_icc_rpm_smd_send() fails with -ENXIO. The
    -ENXIO error comes from qcom_smd_rpm_callback() in
    https://elixir.bootlin.com/linux/latest/source/drivers/soc/qcom/smd-rpm.c#L179

    HW ID    Name
    -------------------------------
     1       mas_ampss_m0
     2       mas_ampss_m1
     4       bimc_to_mnoc
     5       bimc_to_snoc
     6       slv_ebi_ch0
     7       slv_ampss_l2
     8       mas_rpm_inst
     9       mas_rpm_data
    10       mas_rpm_sys
    11       mas_dehr
    12       mas_qdss_dap
    13       mas_spdm
    14       mas_tic
    15       slv_clk_ctl
    16       slv_cnoc_mss
    17       slv_security
    19       slv_tlmm
    20       slv_crypto_0_cfg
    23       slv_message_ram
    24       slv_bimc_cfg
    26       slv_pmic_arb
    27       slv_spdm_wrapper
    28       slv_dehr_cfg
    30       slv_qdss_cfg
    31       slv_rbcpr_cfg
    32       slv_rbcpr_qdss_apu_cfg
    45       mas_graphics_3d
    46       mas_jpeg
    47       mas_mdp_port0
    48       mas_video_p0
    49       mas_video_p1
    50       mas_vfe
    51       mnoc_to_cnoc
    53       slv_camera_cfg
    55       slv_ocmem_cfg
    56       slv_cpr_cfg
    57       slv_cpr_xpu_cfg

[3] Clock warning on system startup:

    WARNING: CPU: 3 PID: 26 at drivers/clk/qcom/clk-rcg2.c:121 update_config+0xe8/0xf0
    gfx3d_clk_src: rcg didn't update its configuration.
    Modules linked in: msm qcom_spmi_vadc qcom_vadc_common pm8941_pwrkey qcom_spmi_iadc msm_vibrator brcmfmac qnoc_msm8974 icc_core inv_mpu6050_i2c(+) inv_mpu6050 brcmutil cfg80211 bq24190_charger tsl2772 rmi_i2c rmi_core icc_smd_rpm usb_f_rndis dm_mod
    CPU: 3 PID: 26 Comm: kworker/3:0 Not tainted 5.3.0-rc4-next-20190816-00021-gd27e1e778708-dirty #148
    Hardware name: Generic DT based system
    Workqueue: events deferred_probe_work_func
    [<c0312328>] (unwind_backtrace) from [<c030d618>] (show_stack+0x10/0x14)
    [<c030d618>] (show_stack) from [<c0a8f8e4>] (dump_stack+0x78/0x8c)
    [<c0a8f8e4>] (dump_stack) from [<c0321b64>] (__warn.part.0+0xb8/0xd4)
    [<c0321b64>] (__warn.part.0) from [<c0321be8>] (warn_slowpath_fmt+0x68/0x94)
    [<c0321be8>] (warn_slowpath_fmt) from [<c07262cc>] (update_config+0xe8/0xf0)
    [<c07262cc>] (update_config) from [<c071d1cc>] (clk_change_rate+0x9c/0x594)
    [<c071d1cc>] (clk_change_rate) from [<c071d850>] (clk_core_set_rate_nolock+0x18c/0x1d4)
    [<c071d850>] (clk_core_set_rate_nolock) from [<c071d8c8>] (clk_set_rate+0x30/0x88)
    [<c071d8c8>] (clk_set_rate) from [<bf16edf8>] (msm_gpu_pm_resume+0x104/0x168 [msm])
    [<bf16edf8>] (msm_gpu_pm_resume [msm]) from [<c07d7c50>] (genpd_runtime_resume+0x9c/0x2a4)
    [<c07d7c50>] (genpd_runtime_resume) from [<c07cd344>] (__rpm_callback+0x74/0x12c)
    [<c07cd344>] (__rpm_callback) from [<c07cd41c>] (rpm_callback+0x20/0x80)
    [<c07cd41c>] (rpm_callback) from [<c07ccf98>] (rpm_resume+0x640/0x814)
    [<c07ccf98>] (rpm_resume) from [<c07cd1bc>] (__pm_runtime_resume+0x50/0x68)
    [<c07cd1bc>] (__pm_runtime_resume) from [<bf11e498>] (adreno_load_gpu+0x50/0x154 [msm])
    [<bf11e498>] (adreno_load_gpu [msm]) from [<bf1690d4>] (msm_open+0x80/0x94 [msm])
    [<bf1690d4>] (msm_open [msm]) from [<c078b32c>] (drm_file_alloc+0x138/0x1f0)
    [<c078b32c>] (drm_file_alloc) from [<c07aebdc>] (drm_client_init+0xa8/0x124)
    [<c07aebdc>] (drm_client_init) from [<c0789700>] (drm_fb_helper_init.part.0+0x30/0x3c)
    [<c0789700>] (drm_fb_helper_init.part.0) from [<bf1740fc>] (msm_fbdev_init+0x4c/0xb4 [msm])
    [<bf1740fc>] (msm_fbdev_init [msm]) from [<bf169c90>] (msm_drm_bind+0x5d4/0x654 [msm])
    [<bf169c90>] (msm_drm_bind [msm]) from [<c07b98b0>] (try_to_bring_up_master+0x1f8/0x2b4)
    [<c07b98b0>] (try_to_bring_up_master) from [<c07b9a1c>] (__component_add+0xb0/0x174)
    [<c07b9a1c>] (__component_add) from [<c07c29e8>] (platform_drv_probe+0x48/0x98)
    [<c07c29e8>] (platform_drv_probe) from [<c07c0578>] (really_probe+0x24c/0x480)
    [<c07c0578>] (really_probe) from [<c07c09a0>] (driver_probe_device+0xa0/0x1f8)
    [<c07c09a0>] (driver_probe_device) from [<c07be5ec>] (bus_for_each_drv+0x84/0xd0)
    [<c07be5ec>] (bus_for_each_drv) from [<c07c028c>] (__device_attach+0xe0/0x178)
    [<c07c028c>] (__device_attach) from [<c07bf3c4>] (bus_probe_device+0x84/0x8c)
    [<c07bf3c4>] (bus_probe_device) from [<c07bf91c>] (deferred_probe_work_func+0x84/0xc4)
    [<c07bf91c>] (deferred_probe_work_func) from [<c033d2a8>] (process_one_work+0x1dc/0x538)
    [<c033d2a8>] (process_one_work) from [<c033ebf8>] (worker_thread+0x44/0x508)
    [<c033ebf8>] (worker_thread) from [<c0343370>] (kthread+0x120/0x150)
    [<c0343370>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/interconnect/qcom/Kconfig   |   9 +
 drivers/interconnect/qcom/Makefile  |   2 +
 drivers/interconnect/qcom/msm8974.c | 793 ++++++++++++++++++++++++++++
 3 files changed, 804 insertions(+)
 create mode 100644 drivers/interconnect/qcom/msm8974.c

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 6ab4012a059a..2945d88d58e5 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -5,6 +5,15 @@ config INTERCONNECT_QCOM
 	help
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
+config INTERCONNECT_QCOM_MSM8974
+	tristate "Qualcomm MSM8974 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	select INTERCONNECT_QCOM_SMD_RPM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on msm8974-based
+	  platforms.
+
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 67dafb783dec..255055ea5a21 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -1,9 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 qnoc-qcs404-objs			:= qcs404.o
+qnoc-msm8974-objs			:= msm8974.o
 qnoc-sdm845-objs			:= sdm845.o
 icc-smd-rpm-objs			:= smd-rpm.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
 obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
new file mode 100644
index 000000000000..a024553e8b60
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -0,0 +1,793 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Brian Masney <masneyb@onstation.org>
+ *
+ * Based on qcs404.c
+ * Copyright (C) 2019 Linaro Ltd
+ *
+ * Nodes and associated IDs came from the downstream MSM kernel sources.
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ *
+ * Here's a rough representation that shows the various buses that form the
+ * Network On Chip (NOC) for the msm8974:
+ *
+ *                         Multimedia Subsystem (MMSS)
+ *         |----------+-----------------------------------+-----------|
+ *                    |                                   |
+ *                    |                                   |
+ *        Config      |                     Bus Interface | Memory Controller
+ *       |------------+-+-----------|        |------------+-+-----------|
+ *                      |                                   |
+ *                      |                                   |
+ *                      |             System                |
+ *     |--------------+-+---------------------------------+-+-------------|
+ *                    |                                   |
+ *                    |                                   |
+ *        Peripheral  |                           On Chip | Memory (OCMEM)
+ *       |------------+-------------|        |------------+-------------|
+ */
+
+#include <dt-bindings/interconnect/qcom,msm8974.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "smd-rpm.h"
+
+enum {
+	MSM8974_BIMC_MAS_AMPSS_M0 = 1,
+	MSM8974_BIMC_MAS_AMPSS_M1,
+	MSM8974_BIMC_MAS_MSS_PROC,
+	MSM8974_BIMC_TO_MNOC,
+	MSM8974_BIMC_TO_SNOC,
+	MSM8974_BIMC_SLV_EBI_CH0,
+	MSM8974_BIMC_SLV_AMPSS_L2,
+	MSM8974_CNOC_MAS_RPM_INST,
+	MSM8974_CNOC_MAS_RPM_DATA,
+	MSM8974_CNOC_MAS_RPM_SYS,
+	MSM8974_CNOC_MAS_DEHR,
+	MSM8974_CNOC_MAS_QDSS_DAP,
+	MSM8974_CNOC_MAS_SPDM,
+	MSM8974_CNOC_MAS_TIC,
+	MSM8974_CNOC_SLV_CLK_CTL,
+	MSM8974_CNOC_SLV_CNOC_MSS,
+	MSM8974_CNOC_SLV_SECURITY,
+	MSM8974_CNOC_SLV_TCSR,
+	MSM8974_CNOC_SLV_TLMM,
+	MSM8974_CNOC_SLV_CRYPTO_0_CFG,
+	MSM8974_CNOC_SLV_CRYPTO_1_CFG,
+	MSM8974_CNOC_SLV_IMEM_CFG,
+	MSM8974_CNOC_SLV_MESSAGE_RAM,
+	MSM8974_CNOC_SLV_BIMC_CFG,
+	MSM8974_CNOC_SLV_BOOT_ROM,
+	MSM8974_CNOC_SLV_PMIC_ARB,
+	MSM8974_CNOC_SLV_SPDM_WRAPPER,
+	MSM8974_CNOC_SLV_DEHR_CFG,
+	MSM8974_CNOC_SLV_MPM,
+	MSM8974_CNOC_SLV_QDSS_CFG,
+	MSM8974_CNOC_SLV_RBCPR_CFG,
+	MSM8974_CNOC_SLV_RBCPR_QDSS_APU_CFG,
+	MSM8974_CNOC_TO_SNOC,
+	MSM8974_CNOC_SLV_CNOC_ONOC_CFG,
+	MSM8974_CNOC_SLV_CNOC_MNOC_MMSS_CFG,
+	MSM8974_CNOC_SLV_CNOC_MNOC_CFG,
+	MSM8974_CNOC_SLV_PNOC_CFG,
+	MSM8974_CNOC_SLV_SNOC_MPU_CFG,
+	MSM8974_CNOC_SLV_SNOC_CFG,
+	MSM8974_CNOC_SLV_EBI1_DLL_CFG,
+	MSM8974_CNOC_SLV_PHY_APU_CFG,
+	MSM8974_CNOC_SLV_EBI1_PHY_CFG,
+	MSM8974_CNOC_SLV_RPM,
+	MSM8974_CNOC_SLV_SERVICE_CNOC,
+	MSM8974_MNOC_MAS_GRAPHICS_3D,
+	MSM8974_MNOC_MAS_JPEG,
+	MSM8974_MNOC_MAS_MDP_PORT0,
+	MSM8974_MNOC_MAS_VIDEO_P0,
+	MSM8974_MNOC_MAS_VIDEO_P1,
+	MSM8974_MNOC_MAS_VFE,
+	MSM8974_MNOC_TO_CNOC,
+	MSM8974_MNOC_TO_BIMC,
+	MSM8974_MNOC_SLV_CAMERA_CFG,
+	MSM8974_MNOC_SLV_DISPLAY_CFG,
+	MSM8974_MNOC_SLV_OCMEM_CFG,
+	MSM8974_MNOC_SLV_CPR_CFG,
+	MSM8974_MNOC_SLV_CPR_XPU_CFG,
+	MSM8974_MNOC_SLV_MISC_CFG,
+	MSM8974_MNOC_SLV_MISC_XPU_CFG,
+	MSM8974_MNOC_SLV_VENUS_CFG,
+	MSM8974_MNOC_SLV_GRAPHICS_3D_CFG,
+	MSM8974_MNOC_SLV_MMSS_CLK_CFG,
+	MSM8974_MNOC_SLV_MMSS_CLK_XPU_CFG,
+	MSM8974_MNOC_SLV_MNOC_MPU_CFG,
+	MSM8974_MNOC_SLV_ONOC_MPU_CFG,
+	MSM8974_MNOC_SLV_SERVICE_MNOC,
+	MSM8974_OCMEM_NOC_TO_OCMEM_VNOC,
+	MSM8974_OCMEM_MAS_JPEG_OCMEM,
+	MSM8974_OCMEM_MAS_MDP_OCMEM,
+	MSM8974_OCMEM_MAS_VIDEO_P0_OCMEM,
+	MSM8974_OCMEM_MAS_VIDEO_P1_OCMEM,
+	MSM8974_OCMEM_MAS_VFE_OCMEM,
+	MSM8974_OCMEM_MAS_CNOC_ONOC_CFG,
+	MSM8974_OCMEM_SLV_SERVICE_ONOC,
+	MSM8974_OCMEM_VNOC_TO_SNOC,
+	MSM8974_OCMEM_VNOC_TO_OCMEM_NOC,
+	MSM8974_OCMEM_VNOC_MAS_GFX3D,
+	MSM8974_OCMEM_SLV_OCMEM,
+	MSM8974_PNOC_MAS_PNOC_CFG,
+	MSM8974_PNOC_MAS_SDCC_1,
+	MSM8974_PNOC_MAS_SDCC_3,
+	MSM8974_PNOC_MAS_SDCC_4,
+	MSM8974_PNOC_MAS_SDCC_2,
+	MSM8974_PNOC_MAS_TSIF,
+	MSM8974_PNOC_MAS_BAM_DMA,
+	MSM8974_PNOC_MAS_BLSP_2,
+	MSM8974_PNOC_MAS_USB_HSIC,
+	MSM8974_PNOC_MAS_BLSP_1,
+	MSM8974_PNOC_MAS_USB_HS,
+	MSM8974_PNOC_TO_SNOC,
+	MSM8974_PNOC_SLV_SDCC_1,
+	MSM8974_PNOC_SLV_SDCC_3,
+	MSM8974_PNOC_SLV_SDCC_2,
+	MSM8974_PNOC_SLV_SDCC_4,
+	MSM8974_PNOC_SLV_TSIF,
+	MSM8974_PNOC_SLV_BAM_DMA,
+	MSM8974_PNOC_SLV_BLSP_2,
+	MSM8974_PNOC_SLV_USB_HSIC,
+	MSM8974_PNOC_SLV_BLSP_1,
+	MSM8974_PNOC_SLV_USB_HS,
+	MSM8974_PNOC_SLV_PDM,
+	MSM8974_PNOC_SLV_PERIPH_APU_CFG,
+	MSM8974_PNOC_SLV_PNOC_MPU_CFG,
+	MSM8974_PNOC_SLV_PRNG,
+	MSM8974_PNOC_SLV_SERVICE_PNOC,
+	MSM8974_SNOC_MAS_LPASS_AHB,
+	MSM8974_SNOC_MAS_QDSS_BAM,
+	MSM8974_SNOC_MAS_SNOC_CFG,
+	MSM8974_SNOC_TO_BIMC,
+	MSM8974_SNOC_TO_CNOC,
+	MSM8974_SNOC_TO_PNOC,
+	MSM8974_SNOC_TO_OCMEM_VNOC,
+	MSM8974_SNOC_MAS_CRYPTO_CORE0,
+	MSM8974_SNOC_MAS_CRYPTO_CORE1,
+	MSM8974_SNOC_MAS_LPASS_PROC,
+	MSM8974_SNOC_MAS_MSS,
+	MSM8974_SNOC_MAS_MSS_NAV,
+	MSM8974_SNOC_MAS_OCMEM_DMA,
+	MSM8974_SNOC_MAS_WCSS,
+	MSM8974_SNOC_MAS_QDSS_ETR,
+	MSM8974_SNOC_MAS_USB3,
+	MSM8974_SNOC_SLV_AMPSS,
+	MSM8974_SNOC_SLV_LPASS,
+	MSM8974_SNOC_SLV_USB3,
+	MSM8974_SNOC_SLV_WCSS,
+	MSM8974_SNOC_SLV_OCIMEM,
+	MSM8974_SNOC_SLV_SNOC_OCMEM,
+	MSM8974_SNOC_SLV_SERVICE_SNOC,
+	MSM8974_SNOC_SLV_QDSS_STM,
+};
+
+#define RPM_BUS_MASTER_REQ	0x73616d62
+#define RPM_BUS_SLAVE_REQ	0x766c7362
+
+#define to_qcom_provider(_provider) \
+	container_of(_provider, struct qcom_icc_provider, provider)
+
+static const struct clk_bulk_data bus_clocks[] = {
+	{ .id = "bus" },
+	{ .id = "bus_a" },
+};
+
+/**
+ * struct qcom_icc_provider - Qualcomm specific interconnect provider
+ * @provider: generic interconnect provider
+ * @bus_clks: the clk_bulk_data table of bus clocks
+ * @num_clks: the total number of clk_bulk_data entries
+ */
+struct qcom_icc_provider {
+	struct icc_provider provider;
+	struct clk_bulk_data *bus_clks;
+	int num_clks;
+};
+
+#define MSM8974_MAX_LINKS	3
+
+/**
+ * struct qcom_icc_node - Qualcomm specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @id: a unique node identifier
+ * @links: an array of nodes where we can go next while traversing
+ * @num_links: the total number of @links
+ * @buswidth: width of the interconnect between a node and the bus (bytes)
+ * @mas_rpm_id:	RPM id for devices that are bus masters
+ * @slv_rpm_id:	RPM id for devices that are bus slaves
+ * @rate: current bus clock rate in Hz
+ */
+struct qcom_icc_node {
+	unsigned char *name;
+	u16 id;
+	u16 links[MSM8974_MAX_LINKS];
+	u16 num_links;
+	u16 buswidth;
+	int mas_rpm_id;
+	int slv_rpm_id;
+	u64 rate;
+};
+
+struct qcom_icc_desc {
+	struct qcom_icc_node **nodes;
+	size_t num_nodes;
+};
+
+#define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
+		     ...)						\
+		static struct qcom_icc_node _name = {			\
+		.name = #_name,						\
+		.id = _id,						\
+		.buswidth = _buswidth,					\
+		.mas_rpm_id = _mas_rpm_id,				\
+		.slv_rpm_id = _slv_rpm_id,				\
+		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
+		.links = { __VA_ARGS__ },				\
+	}
+
+DEFINE_QNODE(mas_ampss_m0, MSM8974_BIMC_MAS_AMPSS_M0, 8, 0, -1);
+DEFINE_QNODE(mas_ampss_m1, MSM8974_BIMC_MAS_AMPSS_M1, 8, 0, -1);
+DEFINE_QNODE(mas_mss_proc, MSM8974_BIMC_MAS_MSS_PROC, 8, 1, -1);
+DEFINE_QNODE(bimc_to_mnoc, MSM8974_BIMC_TO_MNOC, 8, 2, -1,
+	     MSM8974_BIMC_SLV_EBI_CH0);
+DEFINE_QNODE(bimc_to_snoc, MSM8974_BIMC_TO_SNOC, 8, 3, 2,
+	     MSM8974_SNOC_TO_BIMC, MSM8974_BIMC_SLV_EBI_CH0,
+	     MSM8974_BIMC_MAS_AMPSS_M0);
+DEFINE_QNODE(slv_ebi_ch0, MSM8974_BIMC_SLV_EBI_CH0, 8, -1, 0);
+DEFINE_QNODE(slv_ampss_l2, MSM8974_BIMC_SLV_AMPSS_L2, 8, -1, 1);
+
+static struct qcom_icc_node *msm8974_bimc_nodes[] = {
+	[BIMC_MAS_AMPSS_M0] = &mas_ampss_m0,
+	[BIMC_MAS_AMPSS_M1] = &mas_ampss_m1,
+	[BIMC_MAS_MSS_PROC] = &mas_mss_proc,
+	[BIMC_TO_MNOC] = &bimc_to_mnoc,
+	[BIMC_TO_SNOC] = &bimc_to_snoc,
+	[BIMC_SLV_EBI_CH0] = &slv_ebi_ch0,
+	[BIMC_SLV_AMPSS_L2] = &slv_ampss_l2,
+};
+
+static struct qcom_icc_desc msm8974_bimc = {
+	.nodes = msm8974_bimc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8974_bimc_nodes),
+};
+
+DEFINE_QNODE(mas_rpm_inst, MSM8974_CNOC_MAS_RPM_INST, 8, 45, -1);
+DEFINE_QNODE(mas_rpm_data, MSM8974_CNOC_MAS_RPM_DATA, 8, 46, -1);
+DEFINE_QNODE(mas_rpm_sys, MSM8974_CNOC_MAS_RPM_SYS, 8, 47, -1);
+DEFINE_QNODE(mas_dehr, MSM8974_CNOC_MAS_DEHR, 8, 48, -1);
+DEFINE_QNODE(mas_qdss_dap, MSM8974_CNOC_MAS_QDSS_DAP, 8, 49, -1);
+DEFINE_QNODE(mas_spdm, MSM8974_CNOC_MAS_SPDM, 8, 50, -1);
+DEFINE_QNODE(mas_tic, MSM8974_CNOC_MAS_TIC, 8, 51, -1);
+DEFINE_QNODE(slv_clk_ctl, MSM8974_CNOC_SLV_CLK_CTL, 8, -1, 47);
+DEFINE_QNODE(slv_cnoc_mss, MSM8974_CNOC_SLV_CNOC_MSS, 8, -1, 48);
+DEFINE_QNODE(slv_security, MSM8974_CNOC_SLV_SECURITY, 8, -1, 49);
+DEFINE_QNODE(slv_tcsr, MSM8974_CNOC_SLV_TCSR, 8, -1, 50);
+DEFINE_QNODE(slv_tlmm, MSM8974_CNOC_SLV_TLMM, 8, -1, 51);
+DEFINE_QNODE(slv_crypto_0_cfg, MSM8974_CNOC_SLV_CRYPTO_0_CFG, 8, -1, 52);
+DEFINE_QNODE(slv_crypto_1_cfg, MSM8974_CNOC_SLV_CRYPTO_1_CFG, 8, -1, 53);
+DEFINE_QNODE(slv_imem_cfg, MSM8974_CNOC_SLV_IMEM_CFG, 8, -1, 54);
+DEFINE_QNODE(slv_message_ram, MSM8974_CNOC_SLV_MESSAGE_RAM, 8, -1, 55);
+DEFINE_QNODE(slv_bimc_cfg, MSM8974_CNOC_SLV_BIMC_CFG, 8, -1, 56);
+DEFINE_QNODE(slv_boot_rom, MSM8974_CNOC_SLV_BOOT_ROM, 8, -1, 57);
+DEFINE_QNODE(slv_pmic_arb, MSM8974_CNOC_SLV_PMIC_ARB, 8, -1, 59);
+DEFINE_QNODE(slv_spdm_wrapper, MSM8974_CNOC_SLV_SPDM_WRAPPER, 8, -1, 60);
+DEFINE_QNODE(slv_dehr_cfg, MSM8974_CNOC_SLV_DEHR_CFG, 8, -1, 61);
+DEFINE_QNODE(slv_mpm, MSM8974_CNOC_SLV_MPM, 8, -1, 62);
+DEFINE_QNODE(slv_qdss_cfg, MSM8974_CNOC_SLV_QDSS_CFG, 8, -1, 63);
+DEFINE_QNODE(slv_rbcpr_cfg, MSM8974_CNOC_SLV_RBCPR_CFG, 8, -1, 64);
+DEFINE_QNODE(slv_rbcpr_qdss_apu_cfg, MSM8974_CNOC_SLV_RBCPR_QDSS_APU_CFG, 8, -1,
+	     65);
+DEFINE_QNODE(cnoc_to_snoc, MSM8974_CNOC_TO_SNOC, 8, 52, 75);
+DEFINE_QNODE(slv_cnoc_onoc_cfg, MSM8974_CNOC_SLV_CNOC_ONOC_CFG, 8, -1, 68);
+DEFINE_QNODE(slv_cnoc_mnoc_mmss_cfg, MSM8974_CNOC_SLV_CNOC_MNOC_MMSS_CFG, 8, -1,
+	     58);
+DEFINE_QNODE(slv_cnoc_mnoc_cfg, MSM8974_CNOC_SLV_CNOC_MNOC_CFG, 8, -1, 66);
+DEFINE_QNODE(slv_pnoc_cfg, MSM8974_CNOC_SLV_PNOC_CFG, 8, -1, 69);
+DEFINE_QNODE(slv_snoc_mpu_cfg, MSM8974_CNOC_SLV_SNOC_MPU_CFG, 8, -1, 67);
+DEFINE_QNODE(slv_snoc_cfg, MSM8974_CNOC_SLV_SNOC_CFG, 8, -1, 70);
+DEFINE_QNODE(slv_ebi1_dll_cfg, MSM8974_CNOC_SLV_EBI1_DLL_CFG, 8, -1, 71);
+DEFINE_QNODE(slv_phy_apu_cfg, MSM8974_CNOC_SLV_PHY_APU_CFG, 8, -1, 72);
+DEFINE_QNODE(slv_ebi1_phy_cfg, MSM8974_CNOC_SLV_EBI1_PHY_CFG, 8, -1, 73);
+DEFINE_QNODE(slv_rpm, MSM8974_CNOC_SLV_RPM, 8, -1, 74);
+DEFINE_QNODE(slv_service_cnoc, MSM8974_CNOC_SLV_SERVICE_CNOC, 8, -1, 76);
+
+static struct qcom_icc_node *msm8974_cnoc_nodes[] = {
+	[CNOC_MAS_RPM_INST] = &mas_rpm_inst,
+	[CNOC_MAS_RPM_DATA] = &mas_rpm_data,
+	[CNOC_MAS_RPM_SYS] = &mas_rpm_sys,
+	[CNOC_MAS_DEHR] = &mas_dehr,
+	[CNOC_MAS_QDSS_DAP] = &mas_qdss_dap,
+	[CNOC_MAS_SPDM] = &mas_spdm,
+	[CNOC_MAS_TIC] = &mas_tic,
+	[CNOC_SLV_CLK_CTL] = &slv_clk_ctl,
+	[CNOC_SLV_CNOC_MSS] = &slv_cnoc_mss,
+	[CNOC_SLV_SECURITY] = &slv_security,
+	[CNOC_SLV_TCSR] = &slv_tcsr,
+	[CNOC_SLV_TLMM] = &slv_tlmm,
+	[CNOC_SLV_CRYPTO_0_CFG] = &slv_crypto_0_cfg,
+	[CNOC_SLV_CRYPTO_1_CFG] = &slv_crypto_1_cfg,
+	[CNOC_SLV_IMEM_CFG] = &slv_imem_cfg,
+	[CNOC_SLV_MESSAGE_RAM] = &slv_message_ram,
+	[CNOC_SLV_BIMC_CFG] = &slv_bimc_cfg,
+	[CNOC_SLV_BOOT_ROM] = &slv_boot_rom,
+	[CNOC_SLV_PMIC_ARB] = &slv_pmic_arb,
+	[CNOC_SLV_SPDM_WRAPPER] = &slv_spdm_wrapper,
+	[CNOC_SLV_DEHR_CFG] = &slv_dehr_cfg,
+	[CNOC_SLV_MPM] = &slv_mpm,
+	[CNOC_SLV_QDSS_CFG] = &slv_qdss_cfg,
+	[CNOC_SLV_RBCPR_CFG] = &slv_rbcpr_cfg,
+	[CNOC_SLV_RBCPR_QDSS_APU_CFG] = &slv_rbcpr_qdss_apu_cfg,
+	[CNOC_TO_SNOC] = &cnoc_to_snoc,
+	[CNOC_SLV_CNOC_ONOC_CFG] = &slv_cnoc_onoc_cfg,
+	[CNOC_SLV_CNOC_MNOC_MMSS_CFG] = &slv_cnoc_mnoc_mmss_cfg,
+	[CNOC_SLV_CNOC_MNOC_CFG] = &slv_cnoc_mnoc_cfg,
+	[CNOC_SLV_PNOC_CFG] = &slv_pnoc_cfg,
+	[CNOC_SLV_SNOC_MPU_CFG] = &slv_snoc_mpu_cfg,
+	[CNOC_SLV_SNOC_CFG] = &slv_snoc_cfg,
+	[CNOC_SLV_EBI1_DLL_CFG] = &slv_ebi1_dll_cfg,
+	[CNOC_SLV_PHY_APU_CFG] = &slv_phy_apu_cfg,
+	[CNOC_SLV_EBI1_PHY_CFG] = &slv_ebi1_phy_cfg,
+	[CNOC_SLV_RPM] = &slv_rpm,
+	[CNOC_SLV_SERVICE_CNOC] = &slv_service_cnoc,
+};
+
+static struct qcom_icc_desc msm8974_cnoc = {
+	.nodes = msm8974_cnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8974_cnoc_nodes),
+};
+
+DEFINE_QNODE(mas_graphics_3d, MSM8974_MNOC_MAS_GRAPHICS_3D, 16, 6, -1,
+	     MSM8974_MNOC_TO_BIMC);
+DEFINE_QNODE(mas_jpeg, MSM8974_MNOC_MAS_JPEG, 16, 7, -1);
+DEFINE_QNODE(mas_mdp_port0, MSM8974_MNOC_MAS_MDP_PORT0, 16, 8, -1);
+DEFINE_QNODE(mas_video_p0, MSM8974_MNOC_MAS_VIDEO_P0, 16, 9, -1);
+DEFINE_QNODE(mas_video_p1, MSM8974_MNOC_MAS_VIDEO_P1, 16, 10, -1);
+DEFINE_QNODE(mas_vfe, MSM8974_MNOC_MAS_VFE, 16, 11, -1);
+DEFINE_QNODE(mnoc_to_cnoc, MSM8974_MNOC_TO_CNOC, 16, 4, -1);
+DEFINE_QNODE(mnoc_to_bimc, MSM8974_MNOC_TO_BIMC, 16, -1, 16,
+	     MSM8974_BIMC_TO_MNOC);
+DEFINE_QNODE(slv_camera_cfg, MSM8974_MNOC_SLV_CAMERA_CFG, 16, -1, 3);
+DEFINE_QNODE(slv_display_cfg, MSM8974_MNOC_SLV_DISPLAY_CFG, 16, -1, 4);
+DEFINE_QNODE(slv_ocmem_cfg, MSM8974_MNOC_SLV_OCMEM_CFG, 16, -1, 5);
+DEFINE_QNODE(slv_cpr_cfg, MSM8974_MNOC_SLV_CPR_CFG, 16, -1, 6);
+DEFINE_QNODE(slv_cpr_xpu_cfg, MSM8974_MNOC_SLV_CPR_XPU_CFG, 16, -1, 7);
+DEFINE_QNODE(slv_misc_cfg, MSM8974_MNOC_SLV_MISC_CFG, 16, -1, 8);
+DEFINE_QNODE(slv_misc_xpu_cfg, MSM8974_MNOC_SLV_MISC_XPU_CFG, 16, -1, 9);
+DEFINE_QNODE(slv_venus_cfg, MSM8974_MNOC_SLV_VENUS_CFG, 16, -1, 10);
+DEFINE_QNODE(slv_graphics_3d_cfg, MSM8974_MNOC_SLV_GRAPHICS_3D_CFG, 16, -1, 11);
+DEFINE_QNODE(slv_mmss_clk_cfg, MSM8974_MNOC_SLV_MMSS_CLK_CFG, 16, -1, 12);
+DEFINE_QNODE(slv_mmss_clk_xpu_cfg, MSM8974_MNOC_SLV_MMSS_CLK_XPU_CFG, 16, -1,
+	     13);
+DEFINE_QNODE(slv_mnoc_mpu_cfg, MSM8974_MNOC_SLV_MNOC_MPU_CFG, 16, -1, 14);
+DEFINE_QNODE(slv_onoc_mpu_cfg, MSM8974_MNOC_SLV_ONOC_MPU_CFG, 16, -1, 15);
+DEFINE_QNODE(slv_service_mnoc, MSM8974_MNOC_SLV_SERVICE_MNOC, 16, -1, 17);
+
+static struct qcom_icc_node *msm8974_mnoc_nodes[] = {
+	[MNOC_MAS_GRAPHICS_3D] = &mas_graphics_3d,
+	[MNOC_MAS_JPEG] = &mas_jpeg,
+	[MNOC_MAS_MDP_PORT0] = &mas_mdp_port0,
+	[MNOC_MAS_VIDEO_P0] = &mas_video_p0,
+	[MNOC_MAS_VIDEO_P1] = &mas_video_p1,
+	[MNOC_MAS_VFE] = &mas_vfe,
+	[MNOC_TO_CNOC] = &mnoc_to_cnoc,
+	[MNOC_TO_BIMC] = &mnoc_to_bimc,
+	[MNOC_SLV_CAMERA_CFG] = &slv_camera_cfg,
+	[MNOC_SLV_DISPLAY_CFG] = &slv_display_cfg,
+	[MNOC_SLV_OCMEM_CFG] = &slv_ocmem_cfg,
+	[MNOC_SLV_CPR_CFG] = &slv_cpr_cfg,
+	[MNOC_SLV_CPR_XPU_CFG] = &slv_cpr_xpu_cfg,
+	[MNOC_SLV_MISC_CFG] = &slv_misc_cfg,
+	[MNOC_SLV_MISC_XPU_CFG] = &slv_misc_xpu_cfg,
+	[MNOC_SLV_VENUS_CFG] = &slv_venus_cfg,
+	[MNOC_SLV_GRAPHICS_3D_CFG] = &slv_graphics_3d_cfg,
+	[MNOC_SLV_MMSS_CLK_CFG] = &slv_mmss_clk_cfg,
+	[MNOC_SLV_MMSS_CLK_XPU_CFG] = &slv_mmss_clk_xpu_cfg,
+	[MNOC_SLV_MNOC_MPU_CFG] = &slv_mnoc_mpu_cfg,
+	[MNOC_SLV_ONOC_MPU_CFG] = &slv_onoc_mpu_cfg,
+	[MNOC_SLV_SERVICE_MNOC] = &slv_service_mnoc,
+};
+
+static struct qcom_icc_desc msm8974_mnoc = {
+	.nodes = msm8974_mnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8974_mnoc_nodes),
+};
+
+DEFINE_QNODE(ocmem_noc_to_ocmem_vnoc, MSM8974_OCMEM_NOC_TO_OCMEM_VNOC, 16, 54,
+	     78, MSM8974_OCMEM_SLV_OCMEM);
+DEFINE_QNODE(mas_jpeg_ocmem, MSM8974_OCMEM_MAS_JPEG_OCMEM, 16, 13, -1);
+DEFINE_QNODE(mas_mdp_ocmem, MSM8974_OCMEM_MAS_MDP_OCMEM, 16, 14, -1);
+DEFINE_QNODE(mas_video_p0_ocmem, MSM8974_OCMEM_MAS_VIDEO_P0_OCMEM, 16, 15, -1);
+DEFINE_QNODE(mas_video_p1_ocmem, MSM8974_OCMEM_MAS_VIDEO_P1_OCMEM, 16, 16, -1);
+DEFINE_QNODE(mas_vfe_ocmem, MSM8974_OCMEM_MAS_VFE_OCMEM, 16, 17, -1);
+DEFINE_QNODE(mas_cnoc_onoc_cfg, MSM8974_OCMEM_MAS_CNOC_ONOC_CFG, 16, 12, -1);
+DEFINE_QNODE(slv_service_onoc, MSM8974_OCMEM_SLV_SERVICE_ONOC, 16, -1, 19);
+DEFINE_QNODE(slv_ocmem, MSM8974_OCMEM_SLV_OCMEM, 16, -1, 18);
+
+/* Virtual NoC is needed for connection to OCMEM */
+DEFINE_QNODE(ocmem_vnoc_to_onoc, MSM8974_OCMEM_VNOC_TO_OCMEM_NOC, 16, 56, 79,
+	     MSM8974_OCMEM_NOC_TO_OCMEM_VNOC);
+DEFINE_QNODE(ocmem_vnoc_to_snoc, MSM8974_OCMEM_VNOC_TO_SNOC, 8, 57, 80);
+DEFINE_QNODE(mas_v_ocmem_gfx3d, MSM8974_OCMEM_VNOC_MAS_GFX3D, 8, 55, -1,
+	     MSM8974_OCMEM_VNOC_TO_OCMEM_NOC);
+
+static struct qcom_icc_node *msm8974_onoc_nodes[] = {
+	[OCMEM_NOC_TO_OCMEM_VNOC] = &ocmem_noc_to_ocmem_vnoc,
+	[OCMEM_MAS_JPEG_OCMEM] = &mas_jpeg_ocmem,
+	[OCMEM_MAS_MDP_OCMEM] = &mas_mdp_ocmem,
+	[OCMEM_MAS_VIDEO_P0_OCMEM] = &mas_video_p0_ocmem,
+	[OCMEM_MAS_VIDEO_P1_OCMEM] = &mas_video_p1_ocmem,
+	[OCMEM_MAS_VFE_OCMEM] = &mas_vfe_ocmem,
+	[OCMEM_MAS_CNOC_ONOC_CFG] = &mas_cnoc_onoc_cfg,
+	[OCMEM_SLV_SERVICE_ONOC] = &slv_service_onoc,
+	[OCMEM_VNOC_TO_SNOC] = &ocmem_vnoc_to_snoc,
+	[OCMEM_VNOC_TO_OCMEM_NOC] = &ocmem_vnoc_to_onoc,
+	[OCMEM_VNOC_MAS_GFX3D] = &mas_v_ocmem_gfx3d,
+	[OCMEM_SLV_OCMEM] = &slv_ocmem,
+};
+
+static struct qcom_icc_desc msm8974_onoc = {
+	.nodes = msm8974_onoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8974_onoc_nodes),
+};
+
+DEFINE_QNODE(mas_pnoc_cfg, MSM8974_PNOC_MAS_PNOC_CFG, 8, 43, -1);
+DEFINE_QNODE(mas_sdcc_1, MSM8974_PNOC_MAS_SDCC_1, 8, 33, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_sdcc_3, MSM8974_PNOC_MAS_SDCC_3, 8, 34, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_sdcc_4, MSM8974_PNOC_MAS_SDCC_4, 8, 36, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_sdcc_2, MSM8974_PNOC_MAS_SDCC_2, 8, 35, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_tsif, MSM8974_PNOC_MAS_TSIF, 8, 37, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_bam_dma, MSM8974_PNOC_MAS_BAM_DMA, 8, 38, -1);
+DEFINE_QNODE(mas_blsp_2, MSM8974_PNOC_MAS_BLSP_2, 8, 39, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_usb_hsic, MSM8974_PNOC_MAS_USB_HSIC, 8, 40, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_blsp_1, MSM8974_PNOC_MAS_BLSP_1, 8, 41, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(mas_usb_hs, MSM8974_PNOC_MAS_USB_HS, 8, 42, -1,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(pnoc_to_snoc, MSM8974_PNOC_TO_SNOC, 8, 44, 45,
+	     MSM8974_SNOC_TO_PNOC, MSM8974_PNOC_SLV_PRNG);
+DEFINE_QNODE(slv_sdcc_1, MSM8974_PNOC_SLV_SDCC_1, 8, -1, 31);
+DEFINE_QNODE(slv_sdcc_3, MSM8974_PNOC_SLV_SDCC_3, 8, -1, 32);
+DEFINE_QNODE(slv_sdcc_2, MSM8974_PNOC_SLV_SDCC_2, 8, -1, 33);
+DEFINE_QNODE(slv_sdcc_4, MSM8974_PNOC_SLV_SDCC_4, 8, -1, 34);
+DEFINE_QNODE(slv_tsif, MSM8974_PNOC_SLV_TSIF, 8, -1, 35);
+DEFINE_QNODE(slv_bam_dma, MSM8974_PNOC_SLV_BAM_DMA, 8, -1, 36);
+DEFINE_QNODE(slv_blsp_2, MSM8974_PNOC_SLV_BLSP_2, 8, -1, 37);
+DEFINE_QNODE(slv_usb_hsic, MSM8974_PNOC_SLV_USB_HSIC, 8, -1, 38);
+DEFINE_QNODE(slv_blsp_1, MSM8974_PNOC_SLV_BLSP_1, 8, -1, 39);
+DEFINE_QNODE(slv_usb_hs, MSM8974_PNOC_SLV_USB_HS, 8, -1, 40);
+DEFINE_QNODE(slv_pdm, MSM8974_PNOC_SLV_PDM, 8, -1, 41);
+DEFINE_QNODE(slv_periph_apu_cfg, MSM8974_PNOC_SLV_PERIPH_APU_CFG, 8, -1, 42);
+DEFINE_QNODE(slv_pnoc_mpu_cfg, MSM8974_PNOC_SLV_PNOC_MPU_CFG, 8, -1, 43);
+DEFINE_QNODE(slv_prng, MSM8974_PNOC_SLV_PRNG, 8, -1, 44,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(slv_service_pnoc, MSM8974_PNOC_SLV_SERVICE_PNOC, 8, -1, 46);
+
+static struct qcom_icc_node *msm8974_pnoc_nodes[] = {
+	[PNOC_MAS_PNOC_CFG] = &mas_pnoc_cfg,
+	[PNOC_MAS_SDCC_1] = &mas_sdcc_1,
+	[PNOC_MAS_SDCC_3] = &mas_sdcc_3,
+	[PNOC_MAS_SDCC_4] = &mas_sdcc_4,
+	[PNOC_MAS_SDCC_2] = &mas_sdcc_2,
+	[PNOC_MAS_TSIF] = &mas_tsif,
+	[PNOC_MAS_BAM_DMA] = &mas_bam_dma,
+	[PNOC_MAS_BLSP_2] = &mas_blsp_2,
+	[PNOC_MAS_USB_HSIC] = &mas_usb_hsic,
+	[PNOC_MAS_BLSP_1] = &mas_blsp_1,
+	[PNOC_MAS_USB_HS] = &mas_usb_hs,
+	[PNOC_TO_SNOC] = &pnoc_to_snoc,
+	[PNOC_SLV_SDCC_1] = &slv_sdcc_1,
+	[PNOC_SLV_SDCC_3] = &slv_sdcc_3,
+	[PNOC_SLV_SDCC_2] = &slv_sdcc_2,
+	[PNOC_SLV_SDCC_4] = &slv_sdcc_4,
+	[PNOC_SLV_TSIF] = &slv_tsif,
+	[PNOC_SLV_BAM_DMA] = &slv_bam_dma,
+	[PNOC_SLV_BLSP_2] = &slv_blsp_2,
+	[PNOC_SLV_USB_HSIC] = &slv_usb_hsic,
+	[PNOC_SLV_BLSP_1] = &slv_blsp_1,
+	[PNOC_SLV_USB_HS] = &slv_usb_hs,
+	[PNOC_SLV_PDM] = &slv_pdm,
+	[PNOC_SLV_PERIPH_APU_CFG] = &slv_periph_apu_cfg,
+	[PNOC_SLV_PNOC_MPU_CFG] = &slv_pnoc_mpu_cfg,
+	[PNOC_SLV_PRNG] = &slv_prng,
+	[PNOC_SLV_SERVICE_PNOC] = &slv_service_pnoc,
+};
+
+static struct qcom_icc_desc msm8974_pnoc = {
+	.nodes = msm8974_pnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8974_pnoc_nodes),
+};
+
+DEFINE_QNODE(mas_lpass_ahb, MSM8974_SNOC_MAS_LPASS_AHB, 8, 18, -1);
+DEFINE_QNODE(mas_qdss_bam, MSM8974_SNOC_MAS_QDSS_BAM, 8, 19, -1);
+DEFINE_QNODE(mas_snoc_cfg, MSM8974_SNOC_MAS_SNOC_CFG, 8, 20, -1);
+DEFINE_QNODE(snoc_to_bimc, MSM8974_SNOC_TO_BIMC, 8, 21, 24,
+	     MSM8974_BIMC_TO_SNOC);
+DEFINE_QNODE(snoc_to_cnoc, MSM8974_SNOC_TO_CNOC, 8, 22, 25);
+DEFINE_QNODE(snoc_to_pnoc, MSM8974_SNOC_TO_PNOC, 8, 29, 28,
+	     MSM8974_PNOC_TO_SNOC);
+DEFINE_QNODE(snoc_to_ocmem_vnoc, MSM8974_SNOC_TO_OCMEM_VNOC, 8, 53, 77,
+	     MSM8974_OCMEM_VNOC_TO_OCMEM_NOC);
+DEFINE_QNODE(mas_crypto_core0, MSM8974_SNOC_MAS_CRYPTO_CORE0, 8, 23, -1,
+	     MSM8974_SNOC_TO_BIMC);
+DEFINE_QNODE(mas_crypto_core1, MSM8974_SNOC_MAS_CRYPTO_CORE1, 8, 24, -1);
+DEFINE_QNODE(mas_lpass_proc, MSM8974_SNOC_MAS_LPASS_PROC, 8, 25, -1,
+	     MSM8974_SNOC_TO_OCMEM_VNOC);
+DEFINE_QNODE(mas_mss, MSM8974_SNOC_MAS_MSS, 8, 26, -1);
+DEFINE_QNODE(mas_mss_nav, MSM8974_SNOC_MAS_MSS_NAV, 8, 27, -1);
+DEFINE_QNODE(mas_ocmem_dma, MSM8974_SNOC_MAS_OCMEM_DMA, 8, 28, -1);
+DEFINE_QNODE(mas_wcss, MSM8974_SNOC_MAS_WCSS, 8, 30, -1);
+DEFINE_QNODE(mas_qdss_etr, MSM8974_SNOC_MAS_QDSS_ETR, 8, 31, -1);
+DEFINE_QNODE(mas_usb3, MSM8974_SNOC_MAS_USB3, 8, 32, -1,
+	     MSM8974_SNOC_TO_BIMC);
+DEFINE_QNODE(slv_ampss, MSM8974_SNOC_SLV_AMPSS, 8, -1, 20);
+DEFINE_QNODE(slv_lpass, MSM8974_SNOC_SLV_LPASS, 8, -1, 21);
+DEFINE_QNODE(slv_usb3, MSM8974_SNOC_SLV_USB3, 8, -1, 22);
+DEFINE_QNODE(slv_wcss, MSM8974_SNOC_SLV_WCSS, 8, -1, 23);
+DEFINE_QNODE(slv_ocimem, MSM8974_SNOC_SLV_OCIMEM, 8, -1, 26);
+DEFINE_QNODE(slv_snoc_ocmem, MSM8974_SNOC_SLV_SNOC_OCMEM, 8, -1, 27);
+DEFINE_QNODE(slv_service_snoc, MSM8974_SNOC_SLV_SERVICE_SNOC, 8, -1, 29);
+DEFINE_QNODE(slv_qdss_stm, MSM8974_SNOC_SLV_QDSS_STM, 8, -1, 30);
+
+static struct qcom_icc_node *msm8974_snoc_nodes[] = {
+	[SNOC_MAS_LPASS_AHB] = &mas_lpass_ahb,
+	[SNOC_MAS_QDSS_BAM] = &mas_qdss_bam,
+	[SNOC_MAS_SNOC_CFG] = &mas_snoc_cfg,
+	[SNOC_TO_BIMC] = &snoc_to_bimc,
+	[SNOC_TO_CNOC] = &snoc_to_cnoc,
+	[SNOC_TO_PNOC] = &snoc_to_pnoc,
+	[SNOC_TO_OCMEM_VNOC] = &snoc_to_ocmem_vnoc,
+	[SNOC_MAS_CRYPTO_CORE0] = &mas_crypto_core0,
+	[SNOC_MAS_CRYPTO_CORE1] = &mas_crypto_core1,
+	[SNOC_MAS_LPASS_PROC] = &mas_lpass_proc,
+	[SNOC_MAS_MSS] = &mas_mss,
+	[SNOC_MAS_MSS_NAV] = &mas_mss_nav,
+	[SNOC_MAS_OCMEM_DMA] = &mas_ocmem_dma,
+	[SNOC_MAS_WCSS] = &mas_wcss,
+	[SNOC_MAS_QDSS_ETR] = &mas_qdss_etr,
+	[SNOC_MAS_USB3] = &mas_usb3,
+	[SNOC_SLV_AMPSS] = &slv_ampss,
+	[SNOC_SLV_LPASS] = &slv_lpass,
+	[SNOC_SLV_USB3] = &slv_usb3,
+	[SNOC_SLV_WCSS] = &slv_wcss,
+	[SNOC_SLV_OCIMEM] = &slv_ocimem,
+	[SNOC_SLV_SNOC_OCMEM] = &slv_snoc_ocmem,
+	[SNOC_SLV_SERVICE_SNOC] = &slv_service_snoc,
+	[SNOC_SLV_QDSS_STM] = &slv_qdss_stm,
+};
+
+static struct qcom_icc_desc msm8974_snoc = {
+	.nodes = msm8974_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8974_snoc_nodes),
+};
+
+static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	u64 sum_bw, max_peak_bw, rate;
+	u32 agg_avg = 0, agg_peak = 0;
+	struct icc_provider *provider;
+	struct qcom_icc_provider *qp;
+	struct qcom_icc_node *qn;
+	struct icc_node *n;
+	int ret, i;
+
+	qn = src->data;
+	provider = src->provider;
+	qp = to_qcom_provider(provider);
+
+	list_for_each_entry(n, &provider->nodes, node_list)
+		qcom_icc_aggregate(n, 0, n->avg_bw, n->peak_bw,
+				   &agg_avg, &agg_peak);
+
+	sum_bw = icc_units_to_bps(agg_avg);
+	max_peak_bw = icc_units_to_bps(agg_peak);
+
+	/* send bandwidth request message to the RPM processor */
+	if (qn->mas_rpm_id != -1) {
+		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+					    RPM_BUS_MASTER_REQ,
+					    qn->mas_rpm_id,
+					    sum_bw);
+		if (ret) {
+			dev_err(provider->dev,
+				"Error sending bandwidth request for RPM master %s (%d): %d\n",
+				qn->name, qn->mas_rpm_id, ret);
+			return ret;
+		}
+	}
+
+	if (qn->slv_rpm_id != -1) {
+		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
+					    RPM_BUS_SLAVE_REQ,
+					    qn->slv_rpm_id,
+					    sum_bw);
+		if (ret) {
+			dev_err(provider->dev,
+				"Error sending bandwidth request for RPM slave %s (%d): %d\n",
+				qn->name, qn->slv_rpm_id, ret);
+			return ret;
+		}
+	}
+
+	rate = max(sum_bw, max_peak_bw);
+
+	do_div(rate, qn->buswidth);
+
+	if (qn->rate == rate)
+		return 0;
+
+	for (i = 0; i < qp->num_clks; i++) {
+		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
+		if (ret) {
+			dev_err(provider->dev, "%s clk_set_rate error: %d\n",
+				qp->bus_clks[i].id, ret);
+			ret = 0;
+		}
+	}
+
+	qn->rate = rate;
+
+	return 0;
+}
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct qcom_icc_desc *desc;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct qcom_icc_node **qnodes;
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+	size_t num_nodes, i;
+	int ret;
+
+	/* wait for the RPM proxy */
+	if (!qcom_icc_rpm_smd_available())
+		return -EPROBE_DEFER;
+
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	data = devm_kcalloc(dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	qp->bus_clks = devm_kmemdup(dev, bus_clocks, sizeof(bus_clocks),
+				    GFP_KERNEL);
+	if (!qp->bus_clks)
+		return -ENOMEM;
+
+	qp->num_clks = ARRAY_SIZE(bus_clocks);
+	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
+	if (ret)
+		return ret;
+
+	provider = &qp->provider;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->dev = dev;
+	provider->set = qcom_icc_set;
+	provider->aggregate = qcom_icc_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	provider->data = data;
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(dev, "error adding interconnect provider: %d\n", ret);
+		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		return ret;
+	}
+
+	for (i = 0; i < num_nodes; i++) {
+		size_t j;
+
+		node = icc_node_create(qnodes[i]->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = qnodes[i]->name;
+		node->data = qnodes[i];
+		icc_node_add(node, provider);
+
+		dev_dbg(dev, "registered node %s\n", node->name);
+
+		/* populate links */
+		for (j = 0; j < qnodes[i]->num_links; j++)
+			icc_link_create(node, qnodes[i]->links[j]);
+
+		data->nodes[i] = node;
+	}
+	data->num_nodes = num_nodes;
+
+	platform_set_drvdata(pdev, qp);
+
+	return 0;
+err:
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		icc_node_del(node);
+		icc_node_destroy(node->id);
+	}
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	icc_provider_del(provider);
+
+	return ret;
+}
+
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+	struct icc_provider *provider = &qp->provider;
+	struct icc_node *n;
+
+	list_for_each_entry(n, &provider->nodes, node_list) {
+		icc_node_del(n);
+		icc_node_destroy(n->id);
+	}
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+
+	return icc_provider_del(provider);
+}
+
+static const struct of_device_id msm8974_noc_of_match[] = {
+	{ .compatible = "qcom,msm8974-bimc", .data = &msm8974_bimc},
+	{ .compatible = "qcom,msm8974-cnoc", .data = &msm8974_cnoc},
+	{ .compatible = "qcom,msm8974-mmssnoc", .data = &msm8974_mnoc},
+	{ .compatible = "qcom,msm8974-ocmemnoc", .data = &msm8974_onoc},
+	{ .compatible = "qcom,msm8974-pnoc", .data = &msm8974_pnoc},
+	{ .compatible = "qcom,msm8974-snoc", .data = &msm8974_snoc},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, msm8974_noc_of_match);
+
+static struct platform_driver msm8974_noc_driver = {
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
+	.driver = {
+		.name = "qnoc-msm8974",
+		.of_match_table = msm8974_noc_of_match,
+	},
+};
+module_platform_driver(msm8974_noc_driver);
+MODULE_DESCRIPTION("Qualcomm MSM8974 NoC driver");
+MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

