Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0654F442
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiFQJ3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380568AbiFQJ3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 05:29:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685906338C
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 02:29:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o28Ha-0001dP-Db; Fri, 17 Jun 2022 11:28:50 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1o28HY-0003ke-Kd; Fri, 17 Jun 2022 11:28:48 +0200
Date:   Fri, 17 Jun 2022 11:28:48 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v2 4/9] imx: thermal: Configure trip point from DT
Message-ID: <20220617092848.nzwjjh3gqgbtoyod@pengutronix.de>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <20220617071411.187542-5-francesco.dolcini@toradex.com>
 <20220617084017.54psumosr6p3a6qt@pengutronix.de>
 <20220617090442.GB190158@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617090442.GB190158@francesco-nb.int.toradex.com>
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

On 22-06-17, Francesco Dolcini wrote:
> On Fri, Jun 17, 2022 at 10:40:17AM +0200, Marco Felsch wrote:
> > On 22-06-17, Francesco Dolcini wrote:
> > > Allow over-writing critical and passive trip point for each
> > > temperature grade from the device tree, by default the pre-existing
> > > hard-coded trip points are used.
> > > 
> > > This change enables configuring the system thermal characteristics into
> > > the system-specific device tree instead of relying on global hard-coded
> > > temperature thresholds that does not take into account the specific
> > > system thermal design.
> > > 
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > > v2:
> > >  - return immediately if no thermal node present in the dts
> > >  - use dev_info instead of dev_dbg if there is an invalid trip
> > >  - additional comment in case passive trip point is higher than critical
> > > ---
> > >  drivers/thermal/imx_thermal.c | 58 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 58 insertions(+)
> > > 
> > > diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> > > index 16663373b682..a964baf802fc 100644
> > > --- a/drivers/thermal/imx_thermal.c
> > > +++ b/drivers/thermal/imx_thermal.c
> > > @@ -17,6 +17,8 @@
> > >  #include <linux/nvmem-consumer.h>
> > >  #include <linux/pm_runtime.h>
> > >  
> > > +#include "thermal_core.h"
> > > +
> > >  #define REG_SET		0x4
> > >  #define REG_CLR		0x8
> > >  #define REG_TOG		0xc
> > > @@ -479,36 +481,92 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
> > >  	return 0;
> > >  }
> > >  
> > > +static void imx_init_temp_from_of(struct platform_device *pdev, const char *name)
> > > +{
> > > +	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > > +	struct device_node *thermal, *trips, *trip_point;
> > > +
> > > +	thermal = of_get_child_by_name(pdev->dev.of_node, name);
> > > +	if (!thermal)
> > > +		return;
> > > +
> > > +	trips = of_get_child_by_name(thermal, "trips");
> > > +
> > > +	for_each_child_of_node(trips, trip_point) {
> > > +		struct thermal_trip t;
> > > +
> > > +		if (thermal_of_populate_trip(trip_point, &t))
> > > +			continue;
> > > +
> > > +		switch (t.type) {
> > > +		case THERMAL_TRIP_PASSIVE:
> > > +			data->temp_passive = t.temperature;
> > > +			break;
> > > +		case THERMAL_TRIP_CRITICAL:
> > 
> > Should we check also the temp_critical and temp_passive not exceeding
> > the temp_max? Sry. that it came not earlier in my mind. So system damage
> > is avoided.
> 
> I would not add such kind of restriction in the code. I can think of
> multiple situations in which a system designer would prefer to take the
> chances of burning a silicon (or more likely just age it a little bit
> faster) than to just shut down the system.
> 
> In the end whoever is building the system should be empowered to do
> something like that and it's no different from what it's already possible
> with thermal_of driver for example. 
> 
> In addition to that from a system debug prospective all the threshold
> (max, passive, critical) are already available in the kernel logs.

Okay, fine with me since you provided dt-snippets with the correct
temperature. But we should really print a warning since this is a
abnormal usage and the user should be warned.

Regards,
  Marco
> 
> Francesco
> 
> 
