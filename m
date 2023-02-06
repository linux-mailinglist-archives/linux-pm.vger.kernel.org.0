Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F568B864
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 10:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBFJNl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 04:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBFJNk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 04:13:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2853A24F
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 01:13:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso2612973pjz.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 01:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSDlTo6SDmJg8dabNsJbo/gCkAzAgbnRPxsrydaFwSU=;
        b=D+5tcFyHZTS3PkPHUhMt3lAq12f/7/zU610gb3btBrIQddzd+G8qQv7OeSA2JGxJzr
         43KQoKRKoMEH351MeZb3GoNIAMdWzRixBPjBPk/En5FNA+5Knsuq5z5xYma+oZ59EDcG
         r8Jzx3EUykH7Xh0fPFnfWLLWzUtAhWiOi1+7G4lhxADc/cjrloSV0PaO7KiLSZ/G7gTm
         93WHC3XXUQ5T/Kmu2pjbm7+u8fpkE/811I8dPaKVp0xjtfsEsRV/fUqmdHJaLznOmBMq
         z91aDxdtJxfJRl77wzi4ausY/xbAXISLG/U/AX7+RV91esjigZUGZSLuZbEw8w2NdCGY
         difw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSDlTo6SDmJg8dabNsJbo/gCkAzAgbnRPxsrydaFwSU=;
        b=dNhbq4Dd1fXUUqObGrdI9tbSRWb9qpc0pgV31oNlLTpBZaa8eH0HiVxXVW3YvOXEJ7
         ZjbTTepm94dyRXpeAXszhNf8febPIA6RCKlGUzSjoJ2/tpCJmwgWSbqnvAm6lSsLOUhw
         U+nvO0nhRbrYFb0Odctfv4kQjDyngb5gPuGzrBTLksAExw01je/UdIXYDsLu9UIa4Bsa
         cztIfQAFeVFIEz/h4vvJsd7zNX0a1o1DQwa8P3InO4gJY+s0CYuV8StkuLp+0eWmixHq
         Tb2Ohhymh0lcDE+V9m2PAdvLCkR0cABEgFxFlOyoNodZJCi0RmBE8skf8SUaaJe25OBd
         XIBQ==
X-Gm-Message-State: AO0yUKXobhKO0TiTaLdN0K2IDgCxy3ptZ3kDdVJ+1hlO6Sk+6dYA8YW3
        sCaoZKGRfxQLSPAAlZKCdrE=
X-Google-Smtp-Source: AK7set9uY6d7C3soW/SBomzAB/IT9PP15mvHYqqI0u9U9trNKt7SmwNv2aDaD+x5uY7d+G2vK1wMUg==
X-Received: by 2002:a17:90a:690a:b0:230:b0e3:9cad with SMTP id r10-20020a17090a690a00b00230b0e39cadmr2373116pjj.23.1675674818928;
        Mon, 06 Feb 2023 01:13:38 -0800 (PST)
Received: from cyhuang-hp-elitebook-840-g3.rt ([49.216.130.197])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090a7f9300b00212e5068e17sm5836740pjl.40.2023.02.06.01.13.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 01:13:38 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:13:33 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org, alina_yu@richtek.com,
        cy_huang@richtek.com, u0084500@gmail.com
Subject: Re: [PATCH -next] power: supply: rt9471: fix using wrong ce_gpio in
 rt9471_probe()
Message-ID: <20230206091329.GA30724@cyhuang-hp-elitebook-840-g3.rt>
References: <20230206082025.1992331-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206082025.1992331-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Due to the Richtek email rule, YingLiang's mailbox could be blocked.
Resend by my personal gmail.

Hi, YingLiang:

Many thanks for the fix.

My original thought is to remove ce_gpio in chip data and make it
all by SW control only, not to control by HW pin.

Could you help to send v2 patch to remove 'ce_gpio' in chip data?
And for the macro IS_ERR(chip->ce_gpio), just change to IS_ERR(ce_gpio).

In patch v2, you can add my Reviewed-by tag.
Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>

On Mon, Feb 06, 2023 at 04:20:25PM +0800, Yang Yingliang wrote:
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
