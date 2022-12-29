Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1A658A92
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 09:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiL2Ifu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 03:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiL2Ifs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 03:35:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68B2BDE
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 00:35:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so26618750lfa.12
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 00:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nn+L7ZFW/RK3/kCOolsV87i3HVKdOq4YpEDAmCcTxBM=;
        b=UgJuilLIQDUhAmJ6TlExHb682enSnsoybnVOxhzesUJ473aemV7pUT7ZOuvdzKt991
         Ng0r5nSA9aMFYBrQ7bfyJGkFcixVHevpJgYRTWr8uknKzRa21ljLaayNvdyFuWPgkkYn
         sHS8BNcfFxz9N9ZNHFvRAB1epi97g3pniYBu7O9WxFETtYp0hB+x4LmdevPDKoJO25VO
         yFRgL5KxqS7imE53ybKT/4wNwLPjRlWZmyqRvQiaq/8nuEEd97EQTKvWgW/f3tLPs5+D
         Jg0312reonBJkcjYr5mhlCDN0CgOSd3AhqYhS8SXwngBrqIAWABey7S7cqypf/ZEKZF3
         +XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn+L7ZFW/RK3/kCOolsV87i3HVKdOq4YpEDAmCcTxBM=;
        b=Iv8Ja7b3t2KRvURLXXMBhbHjYU9iqr1ofDh88rD+yztRjOEdnjptkxHdgSXhUT7pHu
         C2nX+iIZbzLG76FcCkm8ak36JNJ3haJf7Y8CE3f2A4rSkbbemMkUR/Nfj6d4QQNO0m7w
         nA2nNLJVS3rZF6rpY8ejA8SFmm02TPUCQ1KzVDLu6GVeUXAsPPlReckZhkp8NJU9Oh/5
         chVxRh862JNwecgvQ+XkU5qMuojYep5B5EK1yYf4TKa3XeNsATlcJLzcqIDegRN8CNkS
         CqHCXAzPNJnxSOtxOW5SL6FXcO9uqlTrfz3lIEbLDJCOLSqBeyIxai11EbSrNndHncxE
         CIOg==
X-Gm-Message-State: AFqh2krqgqK99fAyHTfUxhJUxwZFepmz4HO8ZvYLlwH81e7TduOYiVO7
        vx1nV+3EUmIXKZMPjMGiuxEUPA==
X-Google-Smtp-Source: AMrXdXsenEXFrzEM+P6NXUEyIR8Q04dG1lJhUB27Nv56yKOGvZGysmx5i31pwnnDdK8i0WWOkNWlmw==
X-Received: by 2002:ac2:5318:0:b0:4b5:7720:5fe4 with SMTP id c24-20020ac25318000000b004b577205fe4mr8365186lfh.67.1672302945497;
        Thu, 29 Dec 2022 00:35:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o6-20020ac25e26000000b004b01305732bsm2977571lfg.216.2022.12.29.00.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:35:45 -0800 (PST)
Message-ID: <ef9d5f72-e39a-e32c-5d7d-4a6ee57101aa@linaro.org>
Date:   Thu, 29 Dec 2022 09:35:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 02/20] dt-bindings: thermal: tsens: support per-sensor
 calibration cells
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
 <20221229030106.3303205-3-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221229030106.3303205-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/12/2022 04:00, Dmitry Baryshkov wrote:
> Allow specifying the exact calibration mode and calibration data as nvmem
> cells, rather than specifying just a single calibration data blob.
> 
> Note, unlike the vendor kernel the calibration data uses hw_ids rather
> than software sensor indices (to match actual tsens usage in
> thermal zones).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 95 +++++++++++++++++--
>  1 file changed, 85 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index f3660af0b3bf..4bb689f4602d 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -81,18 +81,63 @@ properties:
>      maxItems: 2
>  
>    nvmem-cells:
> -    minItems: 1
> -    maxItems: 2
> -    description:
> -      Reference to an nvmem node for the calibration data
> +    oneOf:
> +      - minItems: 1
> +        maxItems: 2
> +        description:
> +          Reference to an nvmem node for the calibration data
> +      - minItems: 5
> +        maxItems: 35
> +        description: |
> +          Reference to nvmem cells for the calibration mode, two calibration
> +          bases and two cells per each sensor
>  
>    nvmem-cell-names:
> -    minItems: 1
> -    items:
> -      - const: calib
> -      - enum:
> -          - calib_backup
> -          - calib_sel
> +    oneOf:
> +      - minItems: 1
> +        items:
> +          - const: calib
> +          - enum:
> +              - calib_backup
> +              - calib_sel
> +      - minItems: 5
> +        items:
> +          enum:

This should not be an enum but a list of const... unless "holes" are
expected (e.g. s0_p1 and s5_p2, without ones in between).

> +            - mode
> +            - base1
> +            - base2
> +            - s0_p1
> +            - s0_p2
> +            - s1_p1
> +            - s1_p2
> +            - s2_p1
> +            - s2_p2
> +            - s3_p1
> +            - s3_p2
> +            - s4_p1


Best regards,
Krzysztof

