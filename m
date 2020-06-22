Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF48120387D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 15:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgFVNyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 09:54:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50358 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgFVNyN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jun 2020 09:54:13 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jnMti-0008Uo-Bz; Mon, 22 Jun 2020 15:54:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Marc Zyngier <maz@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: rk3399_dmc: Fix kernel oops when rockchip,pmu is absent
Date:   Mon, 22 Jun 2020 15:54:05 +0200
Message-ID: <3900410.KmKVo4a8Xk@diego>
In-Reply-To: <20200622143128.1fac29ad@why>
References: <20200613102435.1728299-1-maz@kernel.org> <20200622143128.1fac29ad@why>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marc,

Am Montag, 22. Juni 2020, 15:31:55 CEST schrieb Marc Zyngier:
> On Sat, 13 Jun 2020 11:24:35 +0100
> Marc Zyngier <maz@kernel.org> wrote:
> 
> > Booting a recent kernel on a rk3399-based system (nanopc-t4),
> > equipped with a recent u-boot and ATF results in the following:
> > 
> > [    5.607431] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001e4
> > [    5.608219] Mem abort info:
> > [    5.608469]   ESR = 0x96000004
> > [    5.608749]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    5.609223]   SET = 0, FnV = 0
> > [    5.609600]   EA = 0, S1PTW = 0
> > [    5.609891] Data abort info:
> > [    5.610149]   ISV = 0, ISS = 0x00000004
> > [    5.610489]   CM = 0, WnR = 0
> > [    5.610757] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000e62fb000
> > [    5.611326] [00000000000001e4] pgd=0000000000000000, p4d=0000000000000000
> > [    5.611931] Internal error: Oops: 96000004 [#1] SMP
> > [    5.612363] Modules linked in: rockchip_thermal(E+) rk3399_dmc(E+) soundcore(E) dw_wdt(E) rockchip_dfi(E) nvmem_rockchip_efuse(E) pwm_rockchip(E) cfg80211(E+) rockchip_saradc(E) industrialio(E) rfkill(E) cpufreq_dt(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) realtek(E) nvme(E) nvme_core(E) t10_pi(E) xhci_plat_hcd(E) xhci_hcd(E) rtc_rk808(E) rk808_regulator(E) clk_rk808(E) dwc3(E) udc_core(E) roles(E) ulpi(E) rk808(E)
> fan53555(E) rockchipdrm(E) analogix_dp(E) dw_hdmi(E) cec(E)
> dw_mipi_dsi(E) fixed(E) dwc3_of_simple(E) phy_rockchip_emmc(E)
> gpio_keys(E) drm_kms_helper(E) phy_rockchip_inno_usb2(E)
> ehci_platform(E) dwmac_rk(E) stmmac_platform(E) phy_rockchip_pcie(E)
> ohci_platform(E) ohci_hcd(E) rockchip_io_domain(E) stmmac(E)
> phy_rockchip_typec(E) ehci_hcd(E) sdhci_of_arasan(E) mdio_xpcs(E)
> sdhci_pltfm(E) cqhci(E) drm(E) sdhci(E) phylink(E) of_mdio(E)
> usbcore(E) i2c_rk3x(E) dw_mmc_rockchip(E) dw_mmc_pltfm(E) dw_mmc(E)
> fixed_phy(E) libphy(E)
> > [    5.612454]  pl330(E)
> > [    5.620255] CPU: 1 PID: 270 Comm: systemd-udevd Tainted: G            E     5.7.0-13692-g83ae758d8b22 #1157
> > [    5.621110] Hardware name: rockchip evb_rk3399/evb_rk3399, BIOS 2020.07-rc4-00023-g10d4cafe0f 06/10/2020
> > [    5.621947] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
> > [    5.622446] pc : regmap_read+0x1c/0x80
> > [    5.622787] lr : rk3399_dmcfreq_probe+0x6a4/0x8c0 [rk3399_dmc]
> > [    5.623299] sp : ffff8000126cb8a0
> > [    5.623594] x29: ffff8000126cb8a0 x28: ffff8000126cbdb0
> > [    5.624063] x27: ffff0000f22dac40 x26: ffff0000f6779800
> > [    5.624533] x25: ffff0000f6779810 x24: 00000000ffffffea
> > [    5.625002] x23: 00000000ffffffea x22: ffff0000f65b74c8
> > [    5.625471] x21: ffff0000f783ca08 x20: ffff0000f65b7480
> > [    5.625941] x19: 0000000000000000 x18: 0000000000000001
> > [    5.626410] x17: 0000000000000000 x16: 0000000000000000
> > [    5.626878] x15: ffff0000f22db138 x14: ffffffffffffffff
> > [    5.627347] x13: 0000000000000018 x12: ffff80001106a8c7
> > [    5.627817] x11: 0000000000000003 x10: 0101010101010101
> > [    5.627861] systemd[1]: Found device SPCC M.2 PCIE SSD 3.
> > [    5.628286] x9 : ffff800008d7c89c x8 : 7f7f7f7f7f7f7f7f
> > [    5.629238] x7 : fefefeff646c606d x6 : 1c0e0e0ee3e8e9f0
> > [    5.629709] x5 : 706968630e0e0e1c x4 : 8080808000000000
> > [    5.630178] x3 : 937b1b5b1b434b80 x2 : ffff8000126cb944
> > [    5.630648] x1 : 0000000000000308 x0 : 0000000000000000
> > [    5.631119] Call trace:
> > [    5.631346]  regmap_read+0x1c/0x80
> > [    5.631654]  rk3399_dmcfreq_probe+0x6a4/0x8c0 [rk3399_dmc]
> > [    5.632142]  platform_drv_probe+0x5c/0xb0
> > [    5.632500]  really_probe+0xe4/0x448
> > [    5.632819]  driver_probe_device+0xfc/0x168
> > [    5.633191]  device_driver_attach+0x7c/0x88
> > [    5.633567]  __driver_attach+0xac/0x178
> > [    5.633914]  bus_for_each_dev+0x78/0xc8
> > [    5.634261]  driver_attach+0x2c/0x38
> > [    5.634582]  bus_add_driver+0x14c/0x230
> > [    5.634925]  driver_register+0x6c/0x128
> > [    5.635269]  __platform_driver_register+0x50/0x60
> > [    5.635692]  rk3399_dmcfreq_driver_init+0x2c/0x1000 [rk3399_dmc]
> > [    5.636226]  do_one_initcall+0x50/0x230
> > [    5.636569]  do_init_module+0x60/0x248
> > [    5.636902]  load_module+0x21f8/0x28d8
> > [    5.637237]  __do_sys_finit_module+0xb0/0x118
> > [    5.637627]  __arm64_sys_finit_module+0x28/0x38
> > [    5.638031]  el0_svc_common.constprop.0+0x7c/0x1f8
> > [    5.638456]  do_el0_svc+0x2c/0x98
> > [    5.638754]  el0_svc+0x18/0x48
> > [    5.639029]  el0_sync_handler+0x8c/0x2d4
> > [    5.639378]  el0_sync+0x158/0x180
> > [    5.639680] Code: a9bd7bfd 910003fd a90153f3 aa0003f3 (b941e400)
> > [    5.640221] ---[ end trace 63675fe5d0021970 ]---
> > 
> > This turns out to be due to the rk3399-dmc driver looking for
> > an *undocumented* property (rockchip,pmu), and happily using
> > a NULL pointer when the property isn't there.
> > 
> > The very existence of this driver in the kernel is highly doubtful
> > (I'd expect firmware to deal with this directly), but in the meantime
> > let's prevent it from oopsing the kernel at probe time if this
> > property isn't present.

TF-A is handling the actual frequency scaling, this driver is like a
glorified wrapper around the TF-A interface ... and the dmc_clock it
calls is just this firmware-interface (see drivers/clk/rockchip/clk-ddr.c)

And I guess it also works around some missing Coreboot functionality.

On u-boot we have ddr-timings in the uboot-devicetree which
_now_ after so many years finally also gets passed on to TF-A
but coreboot uses a completely different system, so I guess ChromeOS
used this to also tell TF-A about the actual ram configuration.


> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/devfreq/rk3399_dmc.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> > index 24f04f78285b..bee233a2e0ce 100644
> > --- a/drivers/devfreq/rk3399_dmc.c
> > +++ b/drivers/devfreq/rk3399_dmc.c
> > @@ -371,13 +371,16 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	node = of_parse_phandle(np, "rockchip,pmu", 0);
> > -	if (node) {
> > -		data->regmap_pmu = syscon_node_to_regmap(node);
> > -		of_node_put(node);
> > -		if (IS_ERR(data->regmap_pmu)) {
> > -			ret = PTR_ERR(data->regmap_pmu);
> > -			goto err_edev;
> > -		}
> > +	if (!node) {
> > +		ret = -ENODEV;
> > +		goto err_edev;
> > +	}
> > +
> > +	data->regmap_pmu = syscon_node_to_regmap(node);
> > +	of_node_put(node);
> > +	if (IS_ERR(data->regmap_pmu)) {
> > +		ret = PTR_ERR(data->regmap_pmu);
> > +		goto err_edev;
> >  	}
> >  
> >  	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> 
> 
> Any opinion on this patch? I can't believe I'm the only one hitting
> this.

Looking at my test-kernel-config, I don't seem to actually build this driver
though I'm also not using boards productively.

But looking deeper, I'm either blind or nothing really carries a dt-node
with a "rockchip,rk3399-dmc" compatible at all, so I'm wondering how you
could actually hit it yourself :-) .

The change was introduced only last year with
commit 9173c5ceb035 ("PM / devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.")

So adding that rockchip,pmu property should be optional to not break
dt-bindings, so I guess instead of erroring out, the one regmap_read below
that (only one using the regmap) should actually just check for
regmap_pmu != NULL?


Heiko



