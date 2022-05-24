Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D028D53255D
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiEXIfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiEXIfW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 04:35:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A833633AE
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 01:35:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ntQ0c-0004rq-Ev; Tue, 24 May 2022 10:35:18 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ntQ0Y-00062S-OZ; Tue, 24 May 2022 10:35:14 +0200
Date:   Tue, 24 May 2022 10:35:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        Jon Nettleton <jon@solid-run.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] thermal: imx: Make trip point offset configurable
Message-ID: <20220524083514.btjjv6ai6ve74bdc@pengutronix.de>
References: <20220516190001.147919-1-francesco.dolcini@toradex.com>
 <20220518085522.3fpzy37kkbkn4hpl@pengutronix.de>
 <20220518094916.GA27037@francesco-nb.int.toradex.com>
 <0006b8cb-b4fc-5015-5c86-be2a6a39be93@linaro.org>
 <20220523143545.GA30537@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523143545.GA30537@francesco-nb.int.toradex.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Francesco,

On 22-05-23, Francesco Dolcini wrote:
> On Wed, May 18, 2022 at 12:10:34PM +0200, Daniel Lezcano wrote:
> > On 18/05/2022 11:49, Francesco Dolcini wrote:
> > > On Wed, May 18, 2022 at 10:55:22AM +0200, Marco Felsch wrote:
> > > > On 22-05-16, Francesco Dolcini wrote:
> > > > > Currently the imx thermal driver has a hardcoded critical temperature
> > > > > value offset of 5 Celsius degrees from the actual SoC maximum
> > > > > temperature.
> > > > > 
> > > > > This affects applications and systems designed to be working on this close
> > > > > to the limit, but yet valid, temperature range.
> > > > > 
> > > > > Given that there is no single value that will fit all the use cases make
> > > > > the critical trip point offset from the max temperature configurable
> > > > > using a newly added trip_offset module parameter, passive trip point is
> > > > > set to 5 Celsius degrees less than the critical. By default the
> > > > > system behaves exactly as before.
> > > > 
> > > > I thought the conclusion of the discussion was to use a dt-property?
> > > > Since it is device and/or environment specific.
> > > 
> > > Daniel proposed to use a module parameter [0], but if you prefer a
> > > dt-property I can change this. I would keep the same semantic (offset
> > > from max temperature to compute the critical trip point).
> > > 
> > > [0] https://lore.kernel.org/all/7f5a919c-2fa1-a463-1f6b-6b531d5ee27d@linaro.org/
> > 
> > 
> > It would have been easier if the imx6/7 platforms were defining the thermal
> > zones in their DT ...

After checking the driver I completely agree with you... But this would
need much more rework.

> Marco, Lucas,
> What about a &tempon { fsl,tempmon-critical-offset=<0>; } dt property?

I would not introduce a special binding for it. Instead I would add the
support to parse the already exisiting bindings so the new-tempmon node
would look like:

tempmon: tempmon {
        compatible = "fsl,imx6q-tempmon";
        interrupt-parent = <&gpc>;
        interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
        fsl,tempmon = <&anatop>;
        nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
        nvmem-cell-names = "calib", "temp_grade";
        clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
        #thermal-sensor-cells = <0>;

	commercial-thermal {
		trips {
			commercial_trip_passive: trip-point0 {
				temperature = <85000>;
				type = "passive";
			};
			commercial_trip_crit: trip-point1 {
				temperature = <90000>;
				type = "critical";
			};
		};
	};

	extended-commercial-thermal {
		trips {
			ecommercial_trip_passive: trip-point0 {
				temperature = <95000>;
				type = "passive";
			};
			ecommercial_trip_crit: trip-point1 {
				temperature = <100000>;
				type = "critical";
			};
		};
	};

	industrial-thermal { };
	automotive-thermal { };
};

That way we can reuse the existing dt definitions and if no *-thermal
child device nodes exist we can keep the original logic.

You could than adapt the trip point in your device-tree by:

&ecommercial_trip_crit {
	temperature = <105000>;
};

Regards,
  Marco

> From my point of view this is even a better solution.
> 
> Daniel, would something like that also acceptable from your point of
> view?
> 
> Francesco
> 
> 
