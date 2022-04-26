Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB250F1CC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbiDZHL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 03:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343709AbiDZHLY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 03:11:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDE237BCB
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 00:08:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y3so13754122ejo.12
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=myMJmmFzXabm0MK8zN+AefUrpxOTRg0KpTHnfY8SV+k=;
        b=dky4F+ZpEvfdqcQOTGzp4A+aq5RvLb28otRcNi3DcgkiqiFA2nKPK/Y9UDrHakFyMj
         fUlE7g537+mnO5GDaDHPiSjZVRCfCv02qJBG0mu8swW5UCNIXVIWvAMqpOoEvwaiaK/E
         MOvmPKiAr5XCwpx0dMWqecvTvO5NozzKjYbVyoDirTAPzUzU5abZrnwPwajnoCh+8hO7
         UTUaucOUhwjTvWpxhezi+x4agKcerorZDZ5pFKuMUZmk9jYL9oURCNjOvQzcBZpZiCa/
         nDeSBEfZuujw3mebo3w5NOy+Pi1Wu5Pe230s1dJg4M/4tC2/3/Da/wMa4hwMKxger2ps
         DQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=myMJmmFzXabm0MK8zN+AefUrpxOTRg0KpTHnfY8SV+k=;
        b=fk5tbJ0PGV5h6G15w3pt90KtdbIZQbVNCqAuW1ywgxFknY8nkXzOrGxS1s8tY2gJLO
         MXDOfiwk4eTnLWEbwEtkTL7f0QavloPATQf+MIQd5ZUL2egv3j6+JTvCPLsiC63ukyqD
         umO6dUv3j3i64z7EhJWOXFewIxOgSRmI38TyIdIg5/F4at6oi4aFU2k+fo7KTK0JjrOP
         XdCwcGexvqJYlVVApvdCLp2qh9plfh4yCaHD5pS2IvRp8QPDR9FifEbYTYU4Ld/7PNyo
         jdlkQbkcNCaxJ8U9clXJzeGuUtN9IuM8ObTAG0v/qSk7njIXGGOHOTd6Vz8EmHCa52P8
         7zog==
X-Gm-Message-State: AOAM530NqgGYEfnxYpMZA4fTb+2CW+4mmI5BBiwHRGlL8CGVQSL7ieAo
        esWc8MnuSJ7tAVtLXwM+LZ7GdQ==
X-Google-Smtp-Source: ABdhPJyJm7edS3wk4FQaxMVtJqIYWKgMPmgVMD3GlzTqVk274oieHiuG28hXKbIevNFawdYIy0Kihw==
X-Received: by 2002:a17:906:5d0d:b0:6f3:a870:ff2a with SMTP id g13-20020a1709065d0d00b006f3a870ff2amr3803917ejt.171.1650956895542;
        Tue, 26 Apr 2022 00:08:15 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p12-20020a50c94c000000b00425c48132bfsm5005280edh.55.2022.04.26.00.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 00:08:15 -0700 (PDT)
Message-ID: <8579a3df-1a1d-c258-f65e-531cf0731949@linaro.org>
Date:   Tue, 26 Apr 2022 09:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/3] dt-bindings: clock: qcom,gcc-apq8064: split tsens
 to the child node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220425212750.2749135-1-dmitry.baryshkov@linaro.org>
 <20220425212750.2749135-4-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425212750.2749135-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/04/2022 23:27, Dmitry Baryshkov wrote:
> Split tsens properties to the child node of the gcc. This follows the
> lead of ipq8064 (which also uses a separate node for tsens) and makes
> device tree closer to other platforms, where tsens is a completely
> separate device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-apq8064.yaml      | 45 +++++++------------
>  1 file changed, 17 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> index b867da12761e..f2762599f679 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> @@ -23,47 +23,36 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,gcc-apq8064
> -      - qcom,gcc-msm8060

Hm, such list does not exist in mainline, so is your set rebased on
something? See also:
https://lore.kernel.org/linux-devicetree/20220425133527.3723233-1-robh@kernel.org/
https://lore.kernel.org/linux-devicetree/20220426064241.6379-1-krzysztof.kozlowski@linaro.org/


> -
> -  nvmem-cells:
> -    minItems: 1
> -    maxItems: 2
> -    description:
> -      Qualcomm TSENS (thermal sensor device) on some devices can
> -      be part of GCC and hence the TSENS properties can also be part
> -      of the GCC/clock-controller node.
> -      For more details on the TSENS properties please refer
> -      Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> -
> -  nvmem-cell-names:
> -    minItems: 1
>      items:
> -      - const: calib
> -      - const: calib_backup

I see the removal of tsens properties, but I do not see the other part
of split - adding them as child. It does not come from qcom,gcc.yaml,
either.

> -
> -  '#thermal-sensor-cells':
> -    const: 1
> +      - enum:
> +          - qcom,gcc-apq8064
> +          - qcom,gcc-msm8060
> +      - const: syscon
>  
>  required:
>    - compatible
> -  - nvmem-cells
> -  - nvmem-cell-names
> -  - '#thermal-sensor-cells'
>  
>  unevaluatedProperties: false
>  
>  examples:
>    - |
>      clock-controller@900000 {
> -      compatible = "qcom,gcc-apq8064";
> +      compatible = "qcom,gcc-apq8064", "syscon";
>        reg = <0x00900000 0x4000>;
> -      nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> -      nvmem-cell-names = "calib", "calib_backup";
>        #clock-cells = <1>;
>        #reset-cells = <1>;
>        #power-domain-cells = <1>;
> -      #thermal-sensor-cells = <1>;
> +
> +      thermal-sensor {
> +        compatible = "qcom,msm8960-tsens";
> +
> +        nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> +        nvmem-cell-names = "calib", "calib_backup";
> +        interrupts = <0 178 4>;

0 and 4 look like GIC/interrupt flags, so please use defines.

> +        interrupt-names = "uplow";
> +
> +        #qcom,sensors = <11>;
> +        #thermal-sensor-cells = <1>;
> +        };

Indentation looks weird here.

>      };
>  ...


Best regards,
Krzysztof
