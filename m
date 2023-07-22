Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE275DB68
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jul 2023 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGVJhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jul 2023 05:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGVJge (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jul 2023 05:36:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720CD3586
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:35:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9924ac01f98so437454166b.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Jul 2023 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690018531; x=1690623331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCIS2uTebsocjvDgAv2fQsB5I/jrohTaosOQPFj6fGk=;
        b=UYIQ093u+tNZP3ENIS84pw8eRjfe3BPmLcHuHH8yM7JniqpE0VdIl84EyFzDtW6ojs
         G6tG9n5jqUQyWud/NT6bBpFI66fEMLpNU1SXPgssJeMO+a1cd6FBiGGXPTVGdETRSjpw
         9WrYblC4bEqk7c0X2sVKE26GAm1VcqbnPLvMt4Cqc9ptd1vv7kBOteJTgzZhiGju33UK
         6UMvswsZpVwkeiRfsNtFXc7ahlrPzifSNCUzQYJS0+GHtvEJp6jKiXl5pALzC6im2T/A
         meSLNHEjV+qK0GGoY/fSSPH/U2zGjlEyi8hz1GF95374GEYkGDZSzIfpzVMVVwDQxMn0
         W/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690018531; x=1690623331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCIS2uTebsocjvDgAv2fQsB5I/jrohTaosOQPFj6fGk=;
        b=cAs4HVNc37rIwbGlH91BTpmyLPcP+E7Rx5327E1vZHawmbL9qtt1g0+J1QNPbm/Ga+
         5hOkcN+7fCUrDSY8iqXGtXBHm5t0za/I9l0OObxY8+b3wz/e3vZ9FX6klLtRDFH/Gdja
         TeywlGi2GgGqmZ8KJsxB1nb1elx7sSDz6Aup6gb+PkzGIYBWn6b39XRVbuvfnlZOpIqa
         31XujpJzPaxqzBLClLdz0K43JyfFB22yXjv6szBDzUMDBotjEhwcj5LZ6VOJ2zsFwGIf
         XUDxuCZ8rK/qtLH1jXhG873Gwzf/NQ8x5m7gtV8hxkOatZY4svrALLyrg5MnAYcifogI
         8oQw==
X-Gm-Message-State: ABy/qLZ3pmhJkE3xlGN6xLL8vN3Euq9kA35cmJdUJOdXrnJhYD+2I7e9
        iwz+X8leFNgtg5KbyxPYrKQ0Vw==
X-Google-Smtp-Source: APBJJlH4IBRWY62H6Zuudk2bWPiFDp43Bc9QkHMhORCXbREh/tTDGLk+BMjOhhehABKyOOgOHx9HVA==
X-Received: by 2002:a17:907:2715:b0:993:e691:6dd5 with SMTP id w21-20020a170907271500b00993e6916dd5mr3848491ejk.7.1690018531272;
        Sat, 22 Jul 2023 02:35:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id mc13-20020a170906eb4d00b00988c0c175c6sm3272997ejb.189.2023.07.22.02.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:35:30 -0700 (PDT)
Message-ID: <4bb6c559-2bf4-3bcd-c154-60ec6dd2d58b@linaro.org>
Date:   Sat, 22 Jul 2023 11:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] dt-bindings: interconnect: qcom: Introduce
 qcom,rpm-common
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
 <20230721-topic-icc_bindings-v1-1-93e2bc728fb7@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-1-93e2bc728fb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/07/2023 15:54, Konrad Dybcio wrote:
> The current RPM interconnect bindings are messy. Start cleaning them
> up with a common include.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcm2290.yaml        | 12 +++------
>  .../bindings/interconnect/qcom,rpm-common.yaml     | 31 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> index f65a2fe846de..edee78c456b7 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> @@ -13,19 +13,16 @@ description: |
>    The Qualcomm QCM2290 interconnect providers support adjusting the
>    bandwidth requirements between the various NoC fabrics.
>  
> -properties:
> -  reg:
> -    maxItems: 1
> +allOf:
> +  - $ref: qcom,rpm-common.yaml#
>  
> +properties:
>    compatible:
>      enum:
>        - qcom,qcm2290-bimc
>        - qcom,qcm2290-cnoc
>        - qcom,qcm2290-snoc
>  
> -  '#interconnect-cells':
> -    const: 1
> -
>    clock-names:
>      items:
>        - const: bus

What about the children? Aren't they also rpm-common?

> @@ -75,11 +72,10 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> -  - '#interconnect-cells'
>    - clock-names
>    - clocks
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
> new file mode 100644
> index 000000000000..87995b40a856
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpm-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description:
> +  RPM interconnect providers support for managing system bandwidth requirements
> +  through manual requests based on either predefined values or as indicated by
> +  the bus monitor hardware. Each provider node represents a NoC bus master,
> +  driven by a dedicated clock source.
> +
> +properties:
> +  reg:
> +    maxItems: 1

I would drop the reg from common parts because some of the children here
don't use it.

Best regards,
Krzysztof

