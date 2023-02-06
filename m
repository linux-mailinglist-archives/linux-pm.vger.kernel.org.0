Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2049768B7E0
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 09:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjBFI7x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 03:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBFI7w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 03:59:52 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE5BF4
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 00:59:50 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(5121:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Mon, 06 Feb 2023 16:59:46 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 6 Feb
 2023 16:59:46 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Mon, 6 Feb 2023 16:59:46 +0800
Date:   Mon, 6 Feb 2023 16:59:46 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     <linux-pm@vger.kernel.org>, <sre@kernel.org>,
        <alina_yu@richtek.com>
Subject: Re: [PATCH -next] power: supply: rt9471: fix using wrong ce_gpio in
 rt9471_probe()
Message-ID: <20230206085946.GA3174@linuxcarl2.richtek.com>
References: <20230206082025.1992331-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230206082025.1992331-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 06, 2023 at 04:20:25PM +0800, Yang Yingliang wrote:
Hi, YingLiang:

Many thanks for the fix.

My original thought is to remove ce_gpio in chip data and make it
all by SW control only, not to control by HW pin.

Could you help to send v2 patch to remove 'ce_gpio' in chip data?
And for the macro IS_ERR(chip->ce_gpio), just change to IS_ERR(ce_gpio).

In patch v2, you can add my Reviewed-by tag.
Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>

Thanks.
> Pass the correct 'ce_gpio' to IS_ERR(), and assign it to
> the 'chip->ce_gpio', if devm_gpiod_get_optional() succeed.
> 
> Fixes: 4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charger driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/power/supply/rt9471.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
> index 5d3cf375ad5c..de0bf484d313 100644
> --- a/drivers/power/supply/rt9471.c
> +++ b/drivers/power/supply/rt9471.c
> @@ -851,10 +851,12 @@ static int rt9471_probe(struct i2c_client *i2c)
>  
>  	/* Default pull charge enable gpio to make 'CHG_EN' by SW control only */
>  	ce_gpio = devm_gpiod_get_optional(dev, "charge-enable", GPIOD_OUT_HIGH);
> -	if (IS_ERR(chip->ce_gpio))
> +	if (IS_ERR(ce_gpio))
>  		return dev_err_probe(dev, PTR_ERR(ce_gpio),
>  				     "Failed to config charge enable gpio\n");
>  
> +	chip->ce_gpio = ce_gpio;
> +
>  	regmap = devm_regmap_init_i2c(i2c, &rt9471_regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
> -- 
> 2.25.1
> 
