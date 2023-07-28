Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1F7666AF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jul 2023 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjG1IPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jul 2023 04:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjG1IPT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jul 2023 04:15:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035771BD6;
        Fri, 28 Jul 2023 01:15:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36S8ElsD130857;
        Fri, 28 Jul 2023 03:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690532087;
        bh=N0r3RPSlHpkVq6rNR6DaqZXRQvQQCMumynPYlWojVFI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BSHinxm9uOn2UhHLeZ5+D7ryjtr1iNxqEqvpVE8SNPAd0VN7P0CV2hZfPhXQi+F04
         /OTdEChYyASaG0mYemcvTiLXrtKoOt3jToFX4N9cznorAPKBwPGTirRFvzA2S4CDpI
         epEDIWMOTHbeRPiKkXs9jVpTrZ+FrK5s9mFqAoNo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36S8Elwj012046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 03:14:47 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 03:14:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 03:14:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36S8Ekrv026247;
        Fri, 28 Jul 2023 03:14:46 -0500
Date:   Fri, 28 Jul 2023 13:44:45 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
CC:     <sre@kernel.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH -next v2] power: supply: Remove redundant dev_err_probe()
 for platform_get_irq_byname()
Message-ID: <20230728081445.bmij44pfbckyyrr7@dhruva>
References: <20230727113550.2599335-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230727113550.2599335-1-ruanjinjie@huawei.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Jul 27, 2023 at 19:35:50 +0800, Ruan Jinjie wrote:
> There is no need to call the dev_err_probe() function directly to print
> a custom message when handling an error from platform_get_irq_byname()
> function as it is going to display an appropriate error message
> in case of a failure.

Ah yes, good catch!

> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v2:
> - clarify the commit title
> ---
>  drivers/power/supply/mt6370-charger.c       | 4 +---
>  drivers/power/supply/qcom_pmi8998_charger.c | 3 +--
>  2 files changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
> index f27dae5043f5..571cf00dde07 100644
> --- a/drivers/power/supply/mt6370-charger.c
> +++ b/drivers/power/supply/mt6370-charger.c
> @@ -849,9 +849,7 @@ static int mt6370_chg_init_irq(struct mt6370_priv *priv)
>  		ret = platform_get_irq_byname(to_platform_device(priv->dev),
>  					      mt6370_chg_irqs[i].name);
>  		if (ret < 0)
> -			return dev_err_probe(priv->dev, ret,
> -					     "Failed to get irq %s\n",
> -					     mt6370_chg_irqs[i].name);
> +			return ret;
>  
>  		priv->irq_nums[i] = ret;
>  		ret = devm_request_threaded_irq(priv->dev, ret, NULL,
> diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
> index d16c5ee17249..ce7392e7d8b8 100644
> --- a/drivers/power/supply/qcom_pmi8998_charger.c
> +++ b/drivers/power/supply/qcom_pmi8998_charger.c
> @@ -922,8 +922,7 @@ static int smb2_init_irq(struct smb2_chip *chip, int *irq, const char *name,
>  
>  	irqnum = platform_get_irq_byname(to_platform_device(chip->dev), name);
>  	if (irqnum < 0)
> -		return dev_err_probe(chip->dev, irqnum,
> -				     "Couldn't get irq %s byname\n", name);
> +		return irqnum;
>  
>  	rc = devm_request_threaded_irq(chip->dev, irqnum, NULL, handler,
>  				       IRQF_ONESHOT, name, chip);
> -- 
> 2.34.1
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
