Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1A203AD5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 17:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgFVP2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 11:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgFVP2m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jun 2020 11:28:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC617206D7;
        Mon, 22 Jun 2020 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592839720;
        bh=TSSeRGzdErnsCbHgmI7LFTi1CDTYGksitatZGJHZ0Xc=;
        h=From:To:Cc:Subject:Date:From;
        b=c7FlBnpPa8F8aOxF+IPC4tUTne//pK+EgHdav4pxshh/+wB3ppH1ddZnVwP/geLkz
         V8ni3GX/gpcfZtSEN5RKysOH2/7DAJ5I4VIXmX2LqjPGQlftjflVSEz9GJG8piKJ/T
         K3bUW7EVHma7HNX+vh+UK5brcjXTDoyLkKhN9gV8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jnOND-005Mvd-7F; Mon, 22 Jun 2020 16:28:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v2] PM / devfreq: rk3399_dmc: Fix kernel oops when rockchip,pmu is absent
Date:   Mon, 22 Jun 2020 16:28:24 +0100
Message-Id: <20200622152824.1054946-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: heiko@sntech.de, enric.balletbo@collabora.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Booting a recent kernel on a rk3399-based system (nanopc-t4),
equipped with a recent u-boot and ATF results in the following:

[    5.607431] Unable to handle kernel NULL pointer dereference at virtual =
address 00000000000001e4
[    5.608219] Mem abort info:
[    5.608469]   ESR =3D 0x96000004
[    5.608749]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    5.609223]   SET =3D 0, FnV =3D 0
[    5.609600]   EA =3D 0, S1PTW =3D 0
[    5.609891] Data abort info:
[    5.610149]   ISV =3D 0, ISS =3D 0x00000004
[    5.610489]   CM =3D 0, WnR =3D 0
[    5.610757] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000e62fb000
[    5.611326] [00000000000001e4] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[    5.611931] Internal error: Oops: 96000004 [#1] SMP
[    5.612363] Modules linked in: rockchip_thermal(E+) rk3399_dmc(E+) sound=
core(E) dw_wdt(E) rockchip_dfi(E) nvmem_rockchip_efuse(E) pwm_rockchip(E) c=
fg80211(E+) rockchip_saradc(E) industrialio(E) rfkill(E) cpufreq_dt(E) ip_t=
ables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(=
E) jbd2(E) realtek(E) nvme(E) nvme_core(E) t10_pi(E) xhci_plat_hcd(E) xhci_=
hcd(E) rtc_rk808(E) rk808_regulator(E) clk_rk808(E) dwc3(E) udc_core(E) rol=
es(E) ulpi(E) rk808(E) fan53555(E) rockchipdrm(E) analogix_dp(E) dw_hdmi(E)=
 cec(E) dw_mipi_dsi(E) fixed(E) dwc3_of_simple(E) phy_rockchip_emmc(E) gpio=
_keys(E) drm_kms_helper(E) phy_rockchip_inno_usb2(E) ehci_platform(E) dwmac=
_rk(E) stmmac_platform(E) phy_rockchip_pcie(E) ohci_platform(E) ohci_hcd(E)=
 rockchip_io_domain(E) stmmac(E) phy_rockchip_typec(E) ehci_hcd(E) sdhci_of=
_arasan(E) mdio_xpcs(E) sdhci_pltfm(E) cqhci(E) drm(E) sdhci(E) phylink(E) =
of_mdio(E) usbcore(E) i2c_rk3x(E) dw_mmc_rockchip(E) dw_mmc_pltfm(E) dw_mmc=
(E) fixed_phy(E) libphy(E)
[    5.612454]  pl330(E)
[    5.620255] CPU: 1 PID: 270 Comm: systemd-udevd Tainted: G            E =
    5.7.0-13692-g83ae758d8b22 #1157
[    5.621110] Hardware name: rockchip evb_rk3399/evb_rk3399, BIOS 2020.07-=
rc4-00023-g10d4cafe0f 06/10/2020
[    5.621947] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=3D--)
[    5.622446] pc : regmap_read+0x1c/0x80
[    5.622787] lr : rk3399_dmcfreq_probe+0x6a4/0x8c0 [rk3399_dmc]
[    5.623299] sp : ffff8000126cb8a0
[    5.623594] x29: ffff8000126cb8a0 x28: ffff8000126cbdb0
[    5.624063] x27: ffff0000f22dac40 x26: ffff0000f6779800
[    5.624533] x25: ffff0000f6779810 x24: 00000000ffffffea
[    5.625002] x23: 00000000ffffffea x22: ffff0000f65b74c8
[    5.625471] x21: ffff0000f783ca08 x20: ffff0000f65b7480
[    5.625941] x19: 0000000000000000 x18: 0000000000000001
[    5.626410] x17: 0000000000000000 x16: 0000000000000000
[    5.626878] x15: ffff0000f22db138 x14: ffffffffffffffff
[    5.627347] x13: 0000000000000018 x12: ffff80001106a8c7
[    5.627817] x11: 0000000000000003 x10: 0101010101010101
[    5.627861] systemd[1]: Found device SPCC M.2 PCIE SSD 3.
[    5.628286] x9 : ffff800008d7c89c x8 : 7f7f7f7f7f7f7f7f
[    5.629238] x7 : fefefeff646c606d x6 : 1c0e0e0ee3e8e9f0
[    5.629709] x5 : 706968630e0e0e1c x4 : 8080808000000000
[    5.630178] x3 : 937b1b5b1b434b80 x2 : ffff8000126cb944
[    5.630648] x1 : 0000000000000308 x0 : 0000000000000000
[    5.631119] Call trace:
[    5.631346]  regmap_read+0x1c/0x80
[    5.631654]  rk3399_dmcfreq_probe+0x6a4/0x8c0 [rk3399_dmc]
[    5.632142]  platform_drv_probe+0x5c/0xb0
[    5.632500]  really_probe+0xe4/0x448
[    5.632819]  driver_probe_device+0xfc/0x168
[    5.633191]  device_driver_attach+0x7c/0x88
[    5.633567]  __driver_attach+0xac/0x178
[    5.633914]  bus_for_each_dev+0x78/0xc8
[    5.634261]  driver_attach+0x2c/0x38
[    5.634582]  bus_add_driver+0x14c/0x230
[    5.634925]  driver_register+0x6c/0x128
[    5.635269]  __platform_driver_register+0x50/0x60
[    5.635692]  rk3399_dmcfreq_driver_init+0x2c/0x1000 [rk3399_dmc]
[    5.636226]  do_one_initcall+0x50/0x230
[    5.636569]  do_init_module+0x60/0x248
[    5.636902]  load_module+0x21f8/0x28d8
[    5.637237]  __do_sys_finit_module+0xb0/0x118
[    5.637627]  __arm64_sys_finit_module+0x28/0x38
[    5.638031]  el0_svc_common.constprop.0+0x7c/0x1f8
[    5.638456]  do_el0_svc+0x2c/0x98
[    5.638754]  el0_svc+0x18/0x48
[    5.639029]  el0_sync_handler+0x8c/0x2d4
[    5.639378]  el0_sync+0x158/0x180
[    5.639680] Code: a9bd7bfd 910003fd a90153f3 aa0003f3 (b941e400)
[    5.640221] ---[ end trace 63675fe5d0021970 ]---

This turns out to be due to the rk3399-dmc driver looking for
an *undocumented* property (rockchip,pmu), and happily using
a NULL pointer when the property isn't there.

Instead, make most of what was brought in with 9173c5ceb035
("PM / devfreq: rk3399_dmc: Pass ODT and auto power down parameters
to TF-A.") conditioned on finding this property in the device-tree,
preventing the driver from exploding.

Fixes: 9173c5ceb035 ("PM / devfreq: rk3399_dmc: Pass ODT and auto power dow=
n parameters to TF-A.")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/devfreq/rk3399_dmc.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 24f04f78285b..027769e39f9b 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -95,18 +95,20 @@ static int rk3399_dmcfreq_target(struct device *dev, un=
signed long *freq,
=20
 	mutex_lock(&dmcfreq->lock);
=20
-	if (target_rate >=3D dmcfreq->odt_dis_freq)
-		odt_enable =3D true;
-
-	/*
-	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
-	 * timings and to enable or disable the ODT (on-die termination)
-	 * resistors.
-	 */
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
-		      dmcfreq->odt_pd_arg1,
-		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
-		      odt_enable, 0, 0, 0, &res);
+	if (dmcfreq->regmap_pmu) {
+		if (target_rate >=3D dmcfreq->odt_dis_freq)
+			odt_enable =3D true;
+
+		/*
+		 * This makes a SMC call to the TF-A to set the DDR PD
+		 * (power-down) timings and to enable or disable the
+		 * ODT (on-die termination) resistors.
+		 */
+		arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
+			      dmcfreq->odt_pd_arg1,
+			      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
+			      odt_enable, 0, 0, 0, &res);
+	}
=20
 	/*
 	 * If frequency scaling from low to high, adjust voltage first.
@@ -371,13 +373,14 @@ static int rk3399_dmcfreq_probe(struct platform_devic=
e *pdev)
 	}
=20
 	node =3D of_parse_phandle(np, "rockchip,pmu", 0);
-	if (node) {
-		data->regmap_pmu =3D syscon_node_to_regmap(node);
-		of_node_put(node);
-		if (IS_ERR(data->regmap_pmu)) {
-			ret =3D PTR_ERR(data->regmap_pmu);
-			goto err_edev;
-		}
+	if (!node)
+		goto no_pmu;
+
+	data->regmap_pmu =3D syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(data->regmap_pmu)) {
+		ret =3D PTR_ERR(data->regmap_pmu);
+		goto err_edev;
 	}
=20
 	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
@@ -399,6 +402,7 @@ static int rk3399_dmcfreq_probe(struct platform_device =
*pdev)
 		goto err_edev;
 	};
=20
+no_pmu:
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
 		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
 		      0, 0, 0, 0, &res);
--=20
2.26.2

