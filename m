Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A616E0670
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 07:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDMF3q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 13 Apr 2023 01:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMF3q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 01:29:46 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF544E69
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2023 22:29:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2ED5E80FC;
        Thu, 13 Apr 2023 05:29:44 +0000 (UTC)
Date:   Thu, 13 Apr 2023 08:29:42 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] soc: ti: smartreflex: Simplify getting the opam_sr
 pointer
Message-ID: <20230413052942.GC9837@atomide.com>
References: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
 <20230412142539.brqexyi5kpac5ltr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20230412142539.brqexyi5kpac5ltr@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Uwe Kleine-König <u.kleine-koenig@pengutronix.de> [230412 14:26]:
> Hello,
> 
> [Cc += Tony Lindgren + Arnd Bergmann who did care about the last change
> to this driver]
> 
> On Wed, Oct 12, 2022 at 04:00:32PM +0200, Uwe Kleine-König wrote:
> > The probe function stores the sr_info pointer using
> > platform_set_drvdata(). Use the corresponding platform_get_drvdata() to
> > retrieve that pointer in the remove and shutdown functions.
> > 
> > This simplifies these functions and makes error handling unnecessary.
> > This is a good thing as at least for .remove() returning an error code
> > doesn't have the desired effect.
> > 
> > This is a preparation for making platform remove callbacks return void.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> This patch still applies to v6.3-rc1, but I didn't get any feedback
> since 6 months now. I need this change to eventually make
> platform_driver's remove callback return void.
> 
> Best regards
> Uwe
> 
> [Keeping a full quote below for Tony and Arnd]

Looks good to me, maybe Arnd is still picking patches for the upcoming
merge window:

Reviewed-by: Tony Lindgren <tony@atomide.com>


> > ---
> >  drivers/soc/ti/smartreflex.c | 30 ++----------------------------
> >  1 file changed, 2 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
> > index ad2bb72e640c..1d0b50feae44 100644
> > --- a/drivers/soc/ti/smartreflex.c
> > +++ b/drivers/soc/ti/smartreflex.c
> > @@ -940,21 +940,8 @@ static int omap_sr_probe(struct platform_device *pdev)
> >  
> >  static int omap_sr_remove(struct platform_device *pdev)
> >  {
> > -	struct omap_sr_data *pdata = pdev->dev.platform_data;
> >  	struct device *dev = &pdev->dev;
> > -	struct omap_sr *sr_info;
> > -
> > -	if (!pdata) {
> > -		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> > -		return -EINVAL;
> > -	}
> > -
> > -	sr_info = _sr_lookup(pdata->voltdm);
> > -	if (IS_ERR(sr_info)) {
> > -		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
> > -			__func__);
> > -		return PTR_ERR(sr_info);
> > -	}
> > +	struct omap_sr *sr_info = platform_get_drvdata(pdev);
> >  
> >  	if (sr_info->autocomp_active)
> >  		sr_stop_vddautocomp(sr_info);
> > @@ -968,20 +955,7 @@ static int omap_sr_remove(struct platform_device *pdev)
> >  
> >  static void omap_sr_shutdown(struct platform_device *pdev)
> >  {
> > -	struct omap_sr_data *pdata = pdev->dev.platform_data;
> > -	struct omap_sr *sr_info;
> > -
> > -	if (!pdata) {
> > -		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> > -		return;
> > -	}
> > -
> > -	sr_info = _sr_lookup(pdata->voltdm);
> > -	if (IS_ERR(sr_info)) {
> > -		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
> > -			__func__);
> > -		return;
> > -	}
> > +	struct omap_sr *sr_info = platform_get_drvdata(pdev);
> >  
> >  	if (sr_info->autocomp_active)
> >  		sr_stop_vddautocomp(sr_info);
> > 
> > base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


