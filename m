Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0710A6CC162
	for <lists+linux-pm@lfdr.de>; Tue, 28 Mar 2023 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjC1NvN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Mar 2023 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjC1NvM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2023 09:51:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3636A5F0
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2023 06:51:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ph9j4-0006rX-Iq; Tue, 28 Mar 2023 15:51:02 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ph9j2-0002cQ-JR; Tue, 28 Mar 2023 15:51:00 +0200
Date:   Tue, 28 Mar 2023 15:51:00 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     peng.fan@nxp.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        abailon@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, abelvesa@kernel.org, marex@denx.de,
        Markus.Niebel@ew.tq-group.com,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        paul.elder@ideasonboard.com, gerg@kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linux-pm@vger.kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, aford173@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, djakov@kernel.org, shawnguo@kernel.org,
        l.stach@pengutronix.de
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk
 ctrl
Message-ID: <20230328135100.rbmnfelphe7juhxo@pengutronix.de>
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com>
 <20230327045037.593326-1-gerg@linux-m68k.org>
 <2678294.mvXUDI8C0e@steina-w>
 <b23a44ab-3666-8a41-d2a0-0d2fbdbd9f00@pengutronix.de>
 <ecd3a92b-ba1e-e7c1-088a-371bd1a2c100@linux-m68k.org>
 <20230328073302.jj64u5hvdpc6axa5@pengutronix.de>
 <426b4776-104c-cb47-c8cc-c26515fcb6e3@linux-m68k.org>
 <20230328134201.yaxrdtetjygkgkmz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328134201.yaxrdtetjygkgkmz@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-03-28, Marco Felsch wrote:
> Hi Greg,
> 
> On 23-03-28, Greg Ungerer wrote:
> > Hi Marco,
> > 
> > On 28/3/23 17:33, Marco Felsch wrote:
> > > Hi Greg,
> > > 
> > > On 23-03-27, Greg Ungerer wrote:
> > > > Hi Ahmad,
> > > > 
> > > > On 27/3/23 17:16, Ahmad Fatoum wrote:
> > > > > On 27.03.23 08:27, Alexander Stein wrote:
> > > > > > Am Montag, 27. M�rz 2023, 06:50:37 CEST schrieb Greg Ungerer:
> > > > > > > Any thoughts on why this breaks USB?
> > > > > > 
> > > > > > Maybe you are missing CONFIG_INTERCONNECT_IMX8MP?
> > > > > 
> > > > > And if that's the case, did you check /sys/kernel/debug/devices_deferred
> > > > > to see if there was any indication that this is the reason?
> > > > 
> > > > Yeah, it does:
> > > > 
> > > >      # cat /sys/kernel/debug/devices_deferred
> > > >      32f10100.usb	platform: supplier 32f10000.blk-ctrl not ready
> > > >      32f10108.usb	platform: supplier 32f10000.blk-ctrl not ready
> > > >      32ec0000.blk-ctrl	imx8m-blk-ctrl: failed to get noc entries
> > > >      381f0040.usb-phy	platform: supplier 32f10000.blk-ctrl not ready
> > > >      382f0040.usb-phy	platform: supplier 32f10000.blk-ctrl not ready
> > > >      imx-pgc-domain.11	
> > > >      imx-pgc-domain.12	
> > > >      imx-pgc-domain.13	
> > > >      38330000.blk-ctrl	platform: supplier imx-pgc-domain.11 not ready
> > > >      32f10000.blk-ctrl	imx8mp-blk-ctrl: failed to get noc entries
> > > > 
> > > > As far as I can tell blk-ctrl should be good:
> > > > 
> > > >      #
> > > >      # i.MX SoC drivers
> > > >      #
> > > >      CONFIG_IMX_GPCV2_PM_DOMAINS=y
> > > >      CONFIG_SOC_IMX8M=y
> > > >      # CONFIG_SOC_IMX9 is not set
> > > >      CONFIG_IMX8M_BLK_CTRL=y
> > > >      # end of i.MX SoC drivers
> > > > 
> > > > 
> > > > > If you didn't find any hint there, you might want to place a
> > > > > dev_err_probe with a suitable message at the place where -EPROBE_DEFER
> > > > > was returned.
> > > > 
> > > > I will try that.
> > > 
> > > Can you check that CONFIG_ARM_IMX_BUS_DEVFREQ is enabled? This is the
> > > noc/interconnect driver. This could also the problem for you vpu issue.
> > 
> > I do not have that enabled. Enabling that fixes the USB probing.
> > So that is good, thanks.
> > 
> > It doesn't fix the other problem I mentioned with the vpu pgc nodes though.
> > I do get some extra messages now with this enabled and the 6.1 kernel:
> > 
> >     imx-pgc imx-pgc-domain.8: failed to command PGC
> >     imx-pgc imx-pgc-domain.8: failed to command PGC
> >     imx8m-blk-ctrl 38330000.blk-ctrl: deferred probe timeout, ignoring dependency
> >     imx8m-blk-ctrl 38330000.blk-ctrl: error -110: failed to attach power domain "g1"
> >     imx8m-blk-ctrl: probe of 38330000.blk-ctrl failed with error -110
> 
> Okay, this seems more like a "real" issue not related to some missing
> drivers. I followed the code and found a poll within the
> imx_pgc_power_up() in gpcv2.c. Power-domain 8 is the vpumix domain which
> is used as power-domain for the g1 power-domain. My assumption is that
> this poll does run into the timeout. Maybe Peng can support you here
> since I didn't had the time for to test the VPUs yet and he did the
> integration patches.
> 
> Just ignore the errors if you don't use the VPUs or disable the
> blk-ctrl@38330000 node via status = "disabled".

I forgot to ask: Does your i.MX8MP have a VPU? There are i.MX8MP devices
(don't know the name) which don't have support for certain IPs. If this
is the case the bootloader will fixup your devicetree by disable the
corresponding nodes, we call this feature-controller:

https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/imx8mp.dtsi

As you can see the imx8mp.dtsi is missing the feature bits for the VPU
but you can check the i.mx8mm.dtsi. Here you can see that barebox will
check the availability of the vpu:

https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/imx8mm.dtsi

Regards,
  Marco
