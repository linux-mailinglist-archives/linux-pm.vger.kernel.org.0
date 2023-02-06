Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1968C127
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 16:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBFPQv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 10:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFPQu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 10:16:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B71E9C8
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 07:16:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so10665545wrg.13
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SFdYqwIRRlNKq2URvMK10oESSfAvdxIceymEVS/gdY=;
        b=fR0O5cF5pgSH2SuVjl1H+Emhoznau6V7siwuLySYoFghvoF3oHy8kGJRaNHIsQP0lP
         274zUfPWLXdQjnbCg5UU4BvLB2Sc5eluuBkGKidHkJ4Qt9b4cHW7VJ9PBJVg0VD9IKZR
         vqAWUnEu7P2YrWdyXnmRjkvKTFSRfAkcvH2HDXXL9USQWzjIXgzwIbj3L8l5/RmH9n6E
         ICjsIxjyIuO6k/du8BnToB9hx3AwwLZySwDDsrMmwgw6yAlXjruJAludEfYD+TykAjHZ
         T4riGd1nAQ4V9OEomb2T3lmlccq1dPzfE8vOx1dUcNHPVSOoliAltP63h/f/UiUGfU/3
         Ni+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SFdYqwIRRlNKq2URvMK10oESSfAvdxIceymEVS/gdY=;
        b=pxMfb+Hn3muReNrPbgvQfOHAGY57EybyIoUgWaOC57aqoZhUHB9g4BHBetKz+3rFJe
         A4cp2dhnLHVcEN4ZlrJ/xhJ4Z0JmJtJ0N/ydfZy3CEWEVBjUOIvt2wYPcoqY1zdjsWSX
         YiGiA71yyruS3myS/eRBZbWUxitDvzXd9mnOgoUCogy4K7HhBpLYzIapEPfR3f+XHdln
         MBPasyHHOPbBfuvSIGsL+fmmoW3rl+vJsD0WNcs6XqVxALA49lEziTDdcODUqPvNsCzp
         V+WJBtzaaZC3SOXt3fwSNjBLnvTNl6P6oKGPKhOJe7HbmrSDqcV5Y2isgVHh/A0D+lHU
         jQ6g==
X-Gm-Message-State: AO0yUKUmBlVFa/bqtlsI97B7payaHcC0VnInHMsLyitv8yUdXTj94de1
        e+O7nIw1TXwgaxGpsuXopWfB2g==
X-Google-Smtp-Source: AK7set+O0Wi8N8N03D+TgkpXo7bFEjAzH/AXnvYy/oLnJfM42DQgG7nqshL9KOiTp/SaOyz+Hq6PTg==
X-Received: by 2002:adf:eb10:0:b0:2c3:d8f0:547a with SMTP id s16-20020adfeb10000000b002c3d8f0547amr10144094wrn.1.1675696608141;
        Mon, 06 Feb 2023 07:16:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b003d9fba3c7a4sm17673253wmq.16.2023.02.06.07.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 07:16:47 -0800 (PST)
Message-ID: <6a4be407-6d35-7629-8b3d-59be10cab83e@linaro.org>
Date:   Mon, 6 Feb 2023 16:16:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Lenovo Yoga C630
 EC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230205152809.2233436-1-dmitry.baryshkov@linaro.org>
 <20230205152809.2233436-2-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230205152809.2233436-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/02/2023 16:28, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add binding for the Embedded Controller found in the Qualcomm
> Snapdragon-based Lenovo Yoga C630.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Loooks ok for me.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If there is going to be resend, three nits below:


> ---
>  .../power/supply/lenovo,yoga-c630-ec.yaml     | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> new file mode 100644
> index 000000000000..37977344f157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/lenovo,yoga-c630-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lenovo Yoga C630 Embedded Controller.

Drop trailing full stop

(...)

> +
> +examples:
> +  - |+

Just:
  - |

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c1 {

Just: "i2c"

> +        clock-frequency = <400000>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;


Best regards,
Krzysztof

