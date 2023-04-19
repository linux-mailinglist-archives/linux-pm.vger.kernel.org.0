Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414CB6E740E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Apr 2023 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjDSHdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Apr 2023 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjDSHdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2023 03:33:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E183C9
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 00:33:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2fa2fc747easo1519016f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681889592; x=1684481592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfCQxeXH44txeLYfAR63mxbUPTOmZEEOWcD5Gxh9IXU=;
        b=smdxdk7t2jmP9sljnoleeuMnuYo7h8ompBMv1/GpjvOul4Sym81MnGLrcOTm8a6LTj
         yLTn6aMCSlQUdEYsVs9413kORKxK/sKQK5LaG8NNjTbCD8YMDBXj6vFFZVAaRIeoJYoY
         N/o7kgFPeLvQVWGWJqGSckItHwmN1kjkMM6ffIl2O6/w4i9NDXh0jCN0e+x3SysYrTsP
         mKe9gwNaGeEuvqhquVsiqAQgwzoaZMB7vqaVeg055tD1gTa7MouVPKgtblKcSYj/APwp
         ptNTIyG6XvcH0Kz3e5dlhfNOq0OHo0YCDOGEaNhIHzRfFyqlXgTvsZQDaS1qQXqNqFhe
         r7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889592; x=1684481592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfCQxeXH44txeLYfAR63mxbUPTOmZEEOWcD5Gxh9IXU=;
        b=KjtMXwi2QV/cWsXnvcYPpY6AtON56MQXkY+m0uitAx62it54tFnSMV1wlFKzQSKcP/
         ZDd6zAOkLppKOl48wNGIw5lGRTPpm0LRSA9E3MUMeM4aL4SC1u3t0Rp6jBZ0b4+sbcA0
         QF0wKdbXDTa2RB+fyGWMDyh+oi7ygi+3mYAhfDrjiGhmm9L1RWm9Y1HSGBG4QegvImJS
         ZPewLt6yswTCZ7o9Q7D/xP4SFGudQJ0mELrKZGhB48uGvfoj0tyuXVWnVjZ/R6DXCGch
         wMIbL49pH6QFxeBXJ9ZLD0Dw9WQ+heX8+kR0nK9N6e6u14UPf+KJtHjy98dnT3Z03VSU
         jt/Q==
X-Gm-Message-State: AAQBX9cBGXyIayC2JCfEivC8xxSYaVd2Lsi3z5TP+koZ7OTQbBIwPwPi
        g4fUrfYpowHmAet1HOwBtbmcrw==
X-Google-Smtp-Source: AKy350Y6fkmsUz9/iCx6NSfuOLJOUsVGfZcsVc4Ij7DNyNaugEStDn+dBRhpqmOMD1+pyvi5+vn8hA==
X-Received: by 2002:a5d:4011:0:b0:2f4:f727:14b9 with SMTP id n17-20020a5d4011000000b002f4f72714b9mr3358907wrp.43.1681889592227;
        Wed, 19 Apr 2023 00:33:12 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m25-20020a056000181900b002f90a75b843sm9684787wrh.117.2023.04.19.00.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:33:11 -0700 (PDT)
Message-ID: <125cfb20-271f-9746-9bd3-eb3637a6648d@linaro.org>
Date:   Wed, 19 Apr 2023 09:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] MediaTek AUXADC thermal: urgent fixes
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        aouledameur@baylibre.com, bchihi@baylibre.com,
        daniel@makrotopia.org, ye.xingchen@zte.com.cn, hsinyi@chromium.org,
        michael.kao@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230419061146.22246-1-angelogioacchino.delregno@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230419061146.22246-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/04/2023 08:11, AngeloGioacchino Del Regno wrote:
> The AUXADC thermal driver unfortunately has issues with a fixed wait
> at probe, as this is not only SoC dependent, but actually depends on
> the board (and even aging...): for example, that works fine on the
> Chromebook that I have here in my hands but not for the ones in our lab.
> 
> Some machines are working fine with that 30ms delay at probe, but some
> others are not, hence I started digging in downstream sources here and
> there, and found that there actually is a valid temperature range for
> at least auxadc-thermal *v1* and can be actually found in multiple
> downstream kernels for MT8173 and MT6795.
> 
> As for v2 and v3 thermal IP, I'm sure that the v1 range works fine but
> I've "left room" for adding specific ranges for them later: this fix
> is urgent, as many MT8173 and MT8183 Chromebooks are failing tests in
> KernelCI due to thermal shutdown during boot.
> 
> For the KernelCI logs, you can look at [1] for 8173, [2] for 8183.
> 
> [1]: https://storage.kernelci.org/next/master/next-20230405/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/igt-kms-mediatek-mt8173-elm-hana.html
> [2]: https://storage.kernelci.org/next/master/next-20230405/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/cros-ec-mt8183-kukui-jacuzzi-juniper-sku16.html
> 

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

