Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF32F2F28
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbhALMd0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 07:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbhALMd0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 07:33:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F63C061575;
        Tue, 12 Jan 2021 04:32:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q18so2342003wrn.1;
        Tue, 12 Jan 2021 04:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aM24vL1gPR6qASSHUNQlMwvy81FHWXkH1YAXneeMQoA=;
        b=pZY6Maiwg7rgdFHPgQNSkKcKcJAVfB7ijeElJV+w32kW2GnL8ihH+TlMc/HrX4gb9Q
         kTyy4fNGbtDIJ9+gscwHu6v+PzPOrh+LbaIXAEjMRkON89y9VohvGt702gw0MO8JvhIa
         wsGmAXf/CQlN6803c3luw10w2H25lJicK9hjqNg/RNNVKwt2MOl3537yFVZn1D300r8P
         M7KMwPcW712Fz5zUK80YJzDQmHZyqmUsxrX9AcaXyatwUBZAW1eg+Ph7N3QeZDoQoON3
         Pv69yip3729bTgj/LcIgEWjR5u6odQdHCvcX2wHnRkzgiLZycw+kIkUOP8xoBTEvZ/mp
         nW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aM24vL1gPR6qASSHUNQlMwvy81FHWXkH1YAXneeMQoA=;
        b=Z5GVFB4OAfncRjSbKePsHA2Zt2xK31StfLV+G7siYbDqo4DGnhlKTEOw0+iDKSBkjI
         qkyMuOHJkUupfpgn9FcJNdPjpPTc9xL/pgTT3NHbuD/hhY1rV6/GeLCmRI+UQ6jjkp7P
         kppCMfQr+WnVtECXHbRA7aEIj28dLHSM2BAR6J1vI6sj3OE3JTqBuwGuMWgLjkhFjRIt
         /EyqJVHTMsDrCbAgn7jAKY4KQbW75fYLlZ6Dusxolcp3vto/aqPp1kOhdeNRuoBYy7JI
         Pn5zjU86GBc8ObUAkjuh3G0pCs9JP/QXZa4vFj1/d8bGhEhUc+IOXgp3gdxS4nr0s2hy
         hW3A==
X-Gm-Message-State: AOAM530jDD12iFOdFZfBRY3dnld+UGVDBl12NIp4SxoUDChM4YcAe8AW
        er5ROSxqzB7MZapg5uFFXmJewnXAWTBaCQ==
X-Google-Smtp-Source: ABdhPJyPAgzHEEo3ugjAXRk4rP75T8ynGPtKVTqKbPbcC9R7J/W1IyXbFCGdKnF5pbHdf3Qtqu+a0w==
X-Received: by 2002:adf:d20b:: with SMTP id j11mr4035471wrh.318.1610454764721;
        Tue, 12 Jan 2021 04:32:44 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id x25sm3620475wmc.3.2021.01.12.04.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 04:32:43 -0800 (PST)
Subject: Re: [PATCH v7 04/11] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
To:     Gene Chen <gene.chen.richtek@gmail.com>, sre@kernel.org,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
References: <1605177598-23501-1-git-send-email-gene.chen.richtek@gmail.com>
 <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <74b127eb-9a3c-20c9-5692-b00b982f4da3@gmail.com>
Date:   Tue, 12 Jan 2021 13:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1605177598-23501-5-git-send-email-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/11/2020 11:39, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> to simplify the similar resources object.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/mt6360-core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 692e47b..5119e51 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -265,7 +265,7 @@ static const struct resource mt6360_led_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
>  };
>  
> -static const struct resource mt6360_pmic_resources[] = {
> +static const struct resource mt6360_regulator_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
> @@ -278,9 +278,6 @@ static const struct resource mt6360_pmic_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
> -};
> -
> -static const struct resource mt6360_ldo_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
>  	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
> @@ -298,10 +295,8 @@ static const struct mfd_cell mt6360_devs[] = {
>  		    NULL, 0, 0, "mediatek,mt6360-chg"),
>  	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
>  		    NULL, 0, 0, "mediatek,mt6360-led"),
> -	OF_MFD_CELL("mt6360-pmic", mt6360_pmic_resources,
> -		    NULL, 0, 0, "mediatek,mt6360-pmic"),
> -	OF_MFD_CELL("mt6360-ldo", mt6360_ldo_resources,
> -		    NULL, 0, 0, "mediatek,mt6360-ldo"),
> +	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> +		    NULL, 0, 0, "mediatek,mt6360-regulator"),

As discussed with the MFD maintainer [1], the regulator (and probably all cells)
shouldn't have a DT binding.

So please send a new version which fixes that.

Regards,
Matthias

[1] https://lore.kernel.org/linux-mediatek/20210111164118.GE4728@sirena.org.uk/

>  	OF_MFD_CELL("mt6360-tcpc", NULL,
>  		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };
> 
