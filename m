Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A664B09F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 08:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiLMHyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 02:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLMHyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 02:54:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D41B13D67
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 23:54:45 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p507e-0000i3-Ku; Tue, 13 Dec 2022 08:54:42 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p507c-0002bM-Mq; Tue, 13 Dec 2022 08:54:40 +0100
Date:   Tue, 13 Dec 2022 08:54:40 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] thermal: imx_sc_thermal: Drop empty platform remove
 function
Message-ID: <20221213075440.x42flkgll4ousizy@pengutronix.de>
References: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
 <0df3eb81-9795-a747-8cce-96e6ccd40716@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0df3eb81-9795-a747-8cce-96e6ccd40716@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 22-12-13, Daniel Lezcano wrote:
> On 12/12/2022 23:02, Uwe Kleine-König wrote:
> > A remove callback just returning 0 is equivalent to no remove callback
> > at all. So drop the useless function.
> 
> AFAIU, without the remove callback the module can not be unloaded, no?

This should be unrelated according:
https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L1419

Regards,
  Marco


> 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/thermal/imx_sc_thermal.c | 6 ------
> >   1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> > index 5d92b70a5d53..4df925e3a80b 100644
> > --- a/drivers/thermal/imx_sc_thermal.c
> > +++ b/drivers/thermal/imx_sc_thermal.c
> > @@ -127,11 +127,6 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
> >   	return 0;
> >   }
> > -static int imx_sc_thermal_remove(struct platform_device *pdev)
> > -{
> > -	return 0;
> > -}
> > -
> >   static int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
> >   static const struct of_device_id imx_sc_thermal_table[] = {
> > @@ -142,7 +137,6 @@ MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
> >   static struct platform_driver imx_sc_thermal_driver = {
> >   		.probe = imx_sc_thermal_probe,
> > -		.remove	= imx_sc_thermal_remove,
> >   		.driver = {
> >   			.name = "imx-sc-thermal",
> >   			.of_match_table = imx_sc_thermal_table,
> > 
> > base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> 
> 
