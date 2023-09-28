Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6F7B21F6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjI1QJc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1QJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 12:09:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462E5EB;
        Thu, 28 Sep 2023 09:09:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38SG99DB055530;
        Thu, 28 Sep 2023 11:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695917350;
        bh=ZkEZMx1qLmUKgbprJN6vn0PbfaINf53rG1vSPYtE+G8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=q0AV3JHWXYJ8/W0FVag5wkOOiY6fMxuTMeVlkGudRnSTr7n9SHVg6PPTBkKxgOoyz
         wfuBBUbvAIOwD6auPXWpBfz7LAyQvMUugRffxttpG2VghAjjwReegt6zV076ev2pDa
         uhH56Q78AeXggUwppJ/NCZB2F9wlGUsmaZnrMeec=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38SG99ie118384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 11:09:09 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 11:09:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 11:09:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38SG98xc108239;
        Thu, 28 Sep 2023 11:09:09 -0500
Date:   Thu, 28 Sep 2023 21:39:08 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <kernel@pengutronix.de>
Subject: Re: [PATCH 30/31] thermal: ti-bandgap: Convert to platform remove
 callback returning void
Message-ID: <20230928160908.klmkdcj4szvlyvek@dhruva>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
 <20230927193736.2236447-31-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927193736.2236447-31-u.kleine-koenig@pengutronix.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sep 27, 2023 at 21:37:35 +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 0c2eb9c6e58b..caadfc61be93 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1069,7 +1069,7 @@ int ti_bandgap_probe(struct platform_device *pdev)
>  }
>  
>  static
> -int ti_bandgap_remove(struct platform_device *pdev)
> +void ti_bandgap_remove(struct platform_device *pdev)
>  {
>  	struct ti_bandgap *bgp = platform_get_drvdata(pdev);
>  	int i;
> @@ -1098,8 +1098,6 @@ int ti_bandgap_remove(struct platform_device *pdev)
>  
>  	if (TI_BANDGAP_HAS(bgp, TSHUT))
>  		free_irq(gpiod_to_irq(bgp->tshut_gpiod), NULL);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -1283,7 +1281,7 @@ MODULE_DEVICE_TABLE(of, of_ti_bandgap_match);
>  
>  static struct platform_driver ti_bandgap_sensor_driver = {
>  	.probe = ti_bandgap_probe,
> -	.remove = ti_bandgap_remove,
> +	.remove_new = ti_bandgap_remove,

LGTM,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  	.driver = {
>  			.name = "ti-soc-thermal",
>  			.pm = DEV_PM_OPS,
> -- 
> 2.40.1
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
