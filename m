Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7891589E8F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 17:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiHDPWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239285AbiHDPWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 11:22:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742BC25EA0
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 08:22:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s14so269809ljh.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cDwtWe0gIkdtSi8cNur71HHPuzn0FTWDpwW7k5ExZPw=;
        b=Q+iGCjYR4/zG4LeeytGWsb+GidV+WjYzlUxgX8NHoygC39ZdFqdgqzSf2/rrCT2hP+
         rqG+vffLIVNES7Dv14kBLfhyghQR0XQuliT8aTg3oBpC7ybxdIFN2y8L1HnDSuWj9XWc
         kP7ZuVtoovFclRQRz2i7Zl46SduqV5fu2dAMfUUHOiYHRQu79rsLtzsmH/EOi8/h95A/
         x5RYViPEmzjt3LB6d9KY/aTlF/s/VmM26/RyYQnESPL9pZsGqcypfphyjsbK6QDExaib
         r1BEnxH6nSZo5Sl6r1qe+A5jUWu8GDx9Rgu1CTWIkJbk7X7HYiFmU97BpgFZhdLg7Ftc
         MuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cDwtWe0gIkdtSi8cNur71HHPuzn0FTWDpwW7k5ExZPw=;
        b=7YLDYjZYjHPFW+Ih3PWJJD+set8iHBobyq0JIq5AeEUeTVMorY92gK5P9b2+vEdpLZ
         V2RruEOl4iQMPW2ZXITwgniudCBSA4ZgWhSMrOx00h1JTRHyfAfCtt0hEJGdaUZlqFOW
         +QZGdutx3RcomzypGNTYioe1lnrVKmyXdo837vJ9U71dhL8CG7SNHcitzrxs2chxcd8I
         zwoCcsEPYPPVGuNeyRjOTpMSnrkLW5CJk/VJ/sC8a30+F4MjjBHMd67Qiqhq2fOB+WVn
         Q/WOaV/KC0AzlFqCHROsTd5EgupbNIJxbICpewAHsZ4s8T80ER22V4ExM6dWmsHaCBlG
         Ww3A==
X-Gm-Message-State: ACgBeo1mDh2vOqeXgelSmbux3q62TD5ESHOWDQzUe2QXFRh3QJtPw6Ok
        7UjNLzQEO2kG27n5ZtmtHuKokQ==
X-Google-Smtp-Source: AA6agR6kgl6aDqL0jj5GOm3S0+pZbnR+K4i9xZIFoIoGCS9e/HTYt5sGvAxP7DXLI82RddE/CX3GXQ==
X-Received: by 2002:a2e:597:0:b0:25e:4a64:1628 with SMTP id 145-20020a2e0597000000b0025e4a641628mr736820ljf.378.1659626532848;
        Thu, 04 Aug 2022 08:22:12 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512219100b0048a8c907fe9sm152854lft.167.2022.08.04.08.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:22:11 -0700 (PDT)
Message-ID: <0991e867-10bd-56e8-c8c1-b5d0cdefbb52@linaro.org>
Date:   Thu, 4 Aug 2022 17:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8.1, 5/7] arm64: dts: mt8195: Add efuse node to mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-6-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804130912.676043-6-bchihi@baylibre.com>
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

On 04/08/2022 15:09, bchihi@baylibre.com wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This adds the efuse node. This will be required by the thermal driver
> to get the calibration data.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 73a0e2103b83..cbd0401968a2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
> - * Copyright (c) 2021 MediaTek Inc.
> + * Copyright (c) 2022 MediaTek Inc.

Why changing first copyright release date? This was not explained in
commit msg.



Best regards,
Krzysztof
