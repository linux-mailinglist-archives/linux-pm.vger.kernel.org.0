Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76012715D30
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjE3L2o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 07:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjE3L2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 07:28:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609D6106
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 04:28:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso773034366b.2
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685446114; x=1688038114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUGM9vwyi3bSbkT57iVkDIziKVOQ8v/LTR1nAotjTgg=;
        b=nh1cIMyMIIVbE/20jQbHGjREBn1rbgCyE8VEshFq7JIYMMP6B9PDcJ6HC+UetWNx0F
         /o11oGuJ3bXvaKs+6y4hncrrQmiEOuX8vuCccmawAE2Aq47yC7J+R8zHUz8nr2y1rDEu
         Y0dS2jh0fW3jKqoWluxSU+6CYsHNQtyTjnTrUOq9KGmpQ7/97XONLbkxxNujJv7VEYPj
         rpm3sFUuSTcq1OMbeO8ig4Y8ZL/CZrdk/NOz2SOxjH93Qi3pUfO8bMTuRnQvII2qcCCx
         LtT3DF02tSBskeq0+Jar+1IzAZad0N3eeGga7m5RUbTz+E1GHL/HC6ZfEfXl10AwVqxo
         dVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446114; x=1688038114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUGM9vwyi3bSbkT57iVkDIziKVOQ8v/LTR1nAotjTgg=;
        b=aH/ogTwiDHoVQ8u+f6H1sZQ/38HANmPrXzQ/0a4h1sSnHc/dR/8nWTcu2u4rqkt56J
         d9r0fdlZjAjPrpj/pmgCBPP2pV+CwbApE/YcYOqS4qmQwr9+l23t5n8e55LAksIvOyuP
         Ft1BtwNSbbsH4Ui+KxjgB7JeZWGFFvhUC86VH3RHveBZB9VgJ8YX1dgecIifI6ED+ksc
         sxOwmYCMNATZS6bFrhJUC8yWtKYednQZ8cRezDUiOiwT91eQMwciAz8R9ANX2+4ndM1E
         c+h8ufgNH0kL2sxg3SZ5IcEx7M0N6a5Nt0jm/wOlvmBqj/y7G00CaPvr/QavQ8txsiPG
         ReXg==
X-Gm-Message-State: AC+VfDw2P1ojCUpBUoyYAPuiwrltbpA9BvKaXKSCg5DvhD7/f2zpqeI0
        rwITdDxbw4DZdg3Dt+3PTHVdjA==
X-Google-Smtp-Source: ACHHUZ5V9wS6Ke7Ij4PQnrUFWP1yKwmKVCcMaEEHDfjjHy5/X9n+fUlh+WbrulYEOMfLmXzA92PZIw==
X-Received: by 2002:a17:907:9707:b0:974:1ef7:15be with SMTP id jg7-20020a170907970700b009741ef715bemr1990950ejc.30.1685446113893;
        Tue, 30 May 2023 04:28:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906475700b00967a18df1easm7207714ejs.117.2023.05.30.04.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:28:33 -0700 (PDT)
Message-ID: <98e4684b-725f-92f0-2920-d7bd582f60db@linaro.org>
Date:   Tue, 30 May 2023 13:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1684920389.git.quic_varada@quicinc.com>
 <cb26ad4a6550c18b1a70104c6b75c10946766944.1684920389.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cb26ad4a6550c18b1a70104c6b75c10946766944.1684920389.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/05/2023 11:36, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v4]:
> 	Add description about IPQ9574 and remove unnecessary
> 	additions to the file
> [v3]:
> 	Fix dt_binding_check & dtbs_check errors (Used
> 	Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
> 	as reference/example)
> 
> 	Drop 'Acked-by: Rob Herring' as suggested in review
> 
> [v2]:
> 	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 	for the tip to make qcom,ipq8074-tsens as fallback.
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index d1ec963..1a752e0 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -16,9 +16,14 @@ description: |
>    The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 captures
>    everything before v1 when there was no versioning information.
>  
> +  Since IPQ9574 is similar to IPQ8074, mapping it to IPQ8074 without
> +  introducing a new compatible.
> +
>  properties:
>    compatible:
>      oneOf:
> +      - const: qcom,ipq8074-tsens

No, no need to move it to const. Was correct before.
> +
>        - description: msm8960 TSENS based
>          items:
>            - enum:
> @@ -64,8 +69,10 @@ properties:
>            - const: qcom,tsens-v2
>  
>        - description: v2 of TSENS with combined interrupt
> -        enum:
> -          - qcom,ipq8074-tsens

Again, "-" means you remove a diff hunk. `man diff` and `man patch` (or
Wikipedia, dunno).

> +        items:
> +          - enum:
> +              - qcom,ipq9574-tsens
> +          - const: qcom,ipq8074-tsens

No, do not touch existing entry.

You need new item on entire list with two compatibles:

+        items:
+          - enum:
+              - qcom,ipq9574-tsens
+          - const: qcom,ipq8074-tsens

That's it. There should be no removal hunks in your diff (so one with "-").

Best regards,
Krzysztof

