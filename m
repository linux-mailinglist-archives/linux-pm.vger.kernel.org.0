Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1891F82E5
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jun 2020 12:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFMKYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jun 2020 06:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgFMKYr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Jun 2020 06:24:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2F1206D7;
        Sat, 13 Jun 2020 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592043885;
        bh=5hmz+kjWd9Z2AW7NAsVZZX4+pg4hDqrs7p2tTAKmflw=;
        h=From:To:Cc:Subject:Date:From;
        b=FW2Pu/7rGdPOLqx+80eTZA579t5DpabAHDWeukIjeiU27m09Vc3K1+jggK3bM6LNz
         oxVihZrLrph4fi1tEwmyMSbbv12JzguetesxlL1xle7FSHsacIgatVJmpwcW7vJCFu
         UVdK20CNxPuzIocaTMKxFanAzf4tAfimNhldvCKY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jk3L9-002cLP-No; Sat, 13 Jun 2020 11:24:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: rk3399_dmc: Fix kernel oops when rockchip,pmu is absent
Date:   Sat, 13 Jun 2020 11:24:35 +0100
Message-Id: <20200613102435.1728299-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

The very existence of this driver in the kernel is highly doubtful
(I'd expect firmware to deal with this directly), but in the meantime
let's prevent it from oopsing the kernel at probe time if this
property isn't present.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/devfreq/rk3399_dmc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 24f04f78285b..bee233a2e0ce 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -371,13 +371,16 @@ static int rk3399_dmcfreq_probe(struct platform_devic=
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
+	if (!node) {
+		ret =3D -ENODEV;
+		goto err_edev;
+	}
+
+	data->regmap_pmu =3D syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(data->regmap_pmu)) {
+		ret =3D PTR_ERR(data->regmap_pmu);
+		goto err_edev;
 	}
=20
 	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
--=20
2.26.2

