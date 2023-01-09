Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4066310C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 21:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjAIUKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Jan 2023 15:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbjAIUKt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2023 15:10:49 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BC1C10A
        for <linux-pm@vger.kernel.org>; Mon,  9 Jan 2023 12:10:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so14791891lfa.9
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2023 12:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYv8YtklJYFSBnqUzDCKD0SPZFw1ONkumQGMVniPZaI=;
        b=GDxTuQIRJgtel7vfxfPwHsWCDWNukZE5tnLZKPy88rB461vEjbSal8xpgOdpnmO8mR
         8MXuox/tp4GMowtxnXwz5/9sR24YuckCV8aVg/7CXnBelhfZArB6J/3PXs6HaxP5utyz
         ishkVfpqOLz+qWIHZDUQWnnhmzPN1pxcDLZACLj3xU4mC+QONy2/KX+Ih7BVP4VGtcrC
         0A+9Qk4CQxKHmwzHKEaGxQa0tcideu/IhvLfA2P45c8+UP7qveelrvsoEGNunkJvenog
         sxO1WnOY+FQgee1ZogSpSmbVWfOt7RfizZO61l63u38iIwheNeHQclE/ElOcrwE20xrf
         YpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYv8YtklJYFSBnqUzDCKD0SPZFw1ONkumQGMVniPZaI=;
        b=btf44pjUZQWGvXRO2KFll9W+NegKCgdelZoRqz9FXSFYrBhyurgEXVktQOZGkf48Ew
         2GLTBQRrRDav+laTt/WoJBKIFWUS79L3tWWyFVBcfXGZHS1Sv6vxhU2PQjkeNQcqbmtr
         7LSMkPnLwklX+/Cah5HaIIePGWLxADs7aDw6uNYck6a92dngsFDKU/7imNQLeqywTuVa
         FqaP9Lw6g6/wlx6R12A3vG+Dcoqu0zO7y7Q0kNyJTEZYuabHsHpr7E/oWXLpYMKp2iFn
         x7PHf6qdOZJwxO6tP5N94PJxGL8yszWHslmANOgclxOcoi8egOLjPBeu+0MBadoSbv/x
         JkpA==
X-Gm-Message-State: AFqh2kpZy2uroWDUxKgR/0RY7b5P6WGx8KE7qFSsZjZQbsAJoJkQkjeS
        AK5h1HYbiWO0ZFI2EaQXXPx8jQ==
X-Google-Smtp-Source: AMrXdXtPrpj6UYPWG3GXi/KKEUU8tcapTSxME54rfgaBkTDH5LSK/GVpX5mevXKdB2D1xY0QRN5y6A==
X-Received: by 2002:a05:6512:3b0e:b0:4cb:4362:381d with SMTP id f14-20020a0565123b0e00b004cb4362381dmr8105304lfv.62.1673295045061;
        Mon, 09 Jan 2023 12:10:45 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004cc548b35fbsm1769736lfr.71.2023.01.09.12.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 12:10:44 -0800 (PST)
Message-ID: <01baab80-4332-542e-e080-affb441f9c97@linaro.org>
Date:   Mon, 9 Jan 2023 22:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 14/18] soc: qcom: rmphpd: add power domains for sa8775p
Content-Language: en-GB
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-15-brgl@bgdev.pl>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230109174511.1740856-15-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/01/2023 19:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add power domain description for sa8775p and a new compatible to match it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/soc/qcom/rpmhpd.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)

[skipped]

> +/* SA8775P RPMH power domains */
> +static struct rpmhpd *sa8775p_rpmhpds[] = {
> +	[SA8775P_CX] = &cx,
> +	[SA8775P_CX_AO] = &cx_ao,
> +	[SA8775P_EBI] = &ebi,
> +	[SA8775P_GFX] = &gfx,
> +	[SA8775P_LCX] = &lcx,
> +	[SA8775P_LMX] = &lmx,
> +	[SA8775P_MMCX] = &mmcx,
> +	[SA8775P_MMCX_AO] = &mmcx_ao,
> +	[SA8775P_MXC] = &mxc,
> +	[SA8775P_MXC_AO] = &mxc_ao,

Is there any parent/child relationship between mmcx/mxc and other domains?

> +	[SA8775P_MX] = &mx,
> +	[SA8775P_MX_AO] = &mx_ao,
> +	[SA8775P_NSP0] = &nsp0,
> +	[SA8775P_NSP1] = &nsp1,
> +};
> +
> +static const struct rpmhpd_desc sa8775p_desc = {
> +	.rpmhpds = sa8775p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
> +};
> +
>   /* SDM670 RPMH powerdomains */
>   static struct rpmhpd *sdm670_rpmhpds[] = {
>   	[SDM670_CX] = &cx_w_mx_parent,
> @@ -487,6 +520,7 @@ static const struct rpmhpd_desc sc8280xp_desc = {
>   static const struct of_device_id rpmhpd_match_table[] = {
>   	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
>   	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
> +	{ .compatible = "qcom,sa8775p-rpmhpd", .data = &sa8775p_desc },
>   	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
>   	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
>   	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },

-- 
With best wishes
Dmitry

