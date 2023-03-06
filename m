Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5836AB66C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 07:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCFGkN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 01:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCFGkM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 01:40:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56887CDDC
        for <linux-pm@vger.kernel.org>; Sun,  5 Mar 2023 22:40:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so33963368edb.12
        for <linux-pm@vger.kernel.org>; Sun, 05 Mar 2023 22:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678084809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0uHF9zbKg9xgGKwpWcbugNvxA7barkTYqPCS14uJCo=;
        b=VbE4JMgrkkl1MBtWejm+B80EuU0h9oiIsNHafwLTvSN6MDfwod2pHIbSFlOhkxSq5Z
         InHrMN7yCJvx+qXa0zoSe16OEzVamDvSbfeohWZHc9QRx/rFJ8JAvK9ceYSYasN2t1Sf
         PlZdn566afyWm6RvagBWWBCUDxPld3nUGPzdk6rVC0ez2Tc5LuADp14mJVt4lRF8hgIH
         mYMwUI1N7Voe+9VKEKwfgyWkH7AnmRGc5iuLsq22KaEe65km2y3oCe4+kCp3PPJGjCRl
         kRTpB/Tt6WcHWGH0AF+JGFyvEh4N1gwPaYeZf1BX5HH7nPIuiQIfOwLGtPP48+vv2gVa
         VrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678084809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0uHF9zbKg9xgGKwpWcbugNvxA7barkTYqPCS14uJCo=;
        b=rCxL7Q5MkklDXcFPz2HavMDDzFgby/rCLOe/+I45apiSb6uxyqCJPqmyBVaZz34WGE
         C26jvvXxSc9Te8hiYWK6zGlSVruY7AzyWUI/s6M/zlf3qJZsywSLpDMHD8mJUtH8T8qS
         jjJ32Na7WG++8sKvBB+FD3XY8EvTDYdmZb9g/WrLQlJWrBnZ0rKc1eX4y4Rl5FkSYjRx
         2ZwIlLm3bWMA3mev95ErnNgqc2gNmL0jNwB+fq8hlvuPm3nKbndVYPeb6t11wHqMjqs1
         7ekFDUt6Zn0WiMauXA4vVtHhxpWwy7RoGVSukwqHlhOb7xUvFYiOmO7j4nrcubL/AoUe
         fMlg==
X-Gm-Message-State: AO0yUKWizCOIyr0EZMqAUr7iTAIVLRYIKR2zBkpZ+fA4iu0TVNvI9OwK
        QEKicOda9Hp6FB4dyNU1dn6Dsg==
X-Google-Smtp-Source: AK7set+6bC7/gAUXyQTO7c8DnH6zWltFHUoEf51GIWHyj5fNPnCguigPLn4YgHzvAa/+o6mgAp4Lzw==
X-Received: by 2002:a17:906:9451:b0:8e1:d996:dca2 with SMTP id z17-20020a170906945100b008e1d996dca2mr8961058ejx.64.1678084808873;
        Sun, 05 Mar 2023 22:40:08 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906738300b008cf377e8795sm4125659ejl.199.2023.03.05.22.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 22:40:08 -0800 (PST)
Message-ID: <a5db2529-6f45-1267-bc08-019059cf29d2@linaro.org>
Date:   Mon, 6 Mar 2023 07:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/6] ARM: dts: imx6ul: Fix second GPT compatible
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230305225901.7119-1-stefan.wahren@i2se.com>
 <20230305225901.7119-5-stefan.wahren@i2se.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230305225901.7119-5-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8
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

On 05/03/2023 23:58, Stefan Wahren wrote:
> According to the imxgpt DT schema all i.MX6 GPT IP is

That's not true... you just changed the bindings to say that.

> derived from imx6dl. So fix the imx6ul DTS accordingly
> and avoid dtbs_check warnings.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index f0a9139748b8..65b2c6c131b3 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -448,7 +448,7 @@ can2: can@2094000 {
>  			};
>  
>  			gpt1: timer@2098000 {
> -				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
> +				compatible = "fsl,imx6ul-gpt", "fsl,imx6dl-gpt";


Best regards,
Krzysztof

