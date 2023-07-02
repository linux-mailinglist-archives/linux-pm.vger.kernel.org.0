Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198B6745220
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjGBUKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 16:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjGBUKY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 16:10:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFA26BE
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 13:09:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5363414f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688328543; x=1690920543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rl1D9Tli2+5e4JWCWhtCcIZOANcTNquvS3B+7/6vmto=;
        b=kYYhsCh2Xn3MLk4kU8bihp5TFLHOxXvG37G0DsaQXr11ONFrTscA3Wk2LiUaisFBIl
         tSFOdMLJTKUe4Ih5mNiHjuH+kw/Oi5uypitfyxrcuxssX3vZdwvasOAGHV5fjYs6vFJz
         Yorw2zN4HgjAIa6ek2QgOkaxfk6jCGiWfGI7Te7f6hdUE6Jc9tb25XWDOdomJMuA/KGx
         EObVTfbotcd2R3o7KkS0ipeva4+NmqAfqqzgTHJiQac38aXnwwCFz67njb1S0vuDLPq6
         X23jy3V/FqZ6FEmNswyfqSvy2RgzR58RW4n3lB8Mufa+BBgS3NetgRAVs6e9Y2uXHRF+
         vZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688328543; x=1690920543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rl1D9Tli2+5e4JWCWhtCcIZOANcTNquvS3B+7/6vmto=;
        b=hYkuMiuMvH3kfimGFaAzc39QKlzSk7SUHi6pDG8WOsRy9kY78XMWKmOFBTDDDhifQd
         rt4vtkhgYPkQDwGPnp5PIdEtpV2IXYE1+VCfaimv4W4ejX88I4FZL2puVHZeL8TYvdyS
         wBcdcavHoTqibFzNC2tgLSZH3tSLkhsSXYBeQSCXO9eTVz3560MvHTJT2U/HUPxvqlpV
         TfMO6jluu6+ZZv7BvalU5D1OWxyf/y0Ub4iYUrKxuBtenf7odHk0KJfiwao4WUyc5qbU
         4ZebEzkJCtgTOq+deIpPpnSNQH8KnUD7q8aAu8TXzEQSGShwhHf6fZRueMFkbjoob3JI
         ifUg==
X-Gm-Message-State: ABy/qLYDOoAi3o1FZJjCv45XHJsIx7rwLpckvYzNnt4+aIsg0zI9M3Sz
        AzXPQYv9n7MmC0aBJLdHMO2/zw==
X-Google-Smtp-Source: APBJJlHaLLoauk7y8K93DDwKYDQR8bJko6UKf7p/ZIcWG5ZaKsx/h2EKtLSvdenDitunbOnIbQL8lg==
X-Received: by 2002:a5d:4fcb:0:b0:314:2132:a277 with SMTP id h11-20020a5d4fcb000000b003142132a277mr7534882wrw.9.1688328543197;
        Sun, 02 Jul 2023 13:09:03 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402165300b0051d9df5dd2fsm7315420edx.72.2023.07.02.13.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 13:09:02 -0700 (PDT)
Message-ID: <77a34cf2-4e7f-e196-b289-d7da5f8d27dd@linaro.org>
Date:   Sun, 2 Jul 2023 22:09:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 05/28] dt-bindings: cache: describe L2 cache on
 Qualcomm Krait platforms
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
 <20230702174246.121656-6-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230702174246.121656-6-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/07/2023 19:42, Dmitry Baryshkov wrote:
> The L2 cache device on Qualcomm Krait platforms controls the supplying
> voltages and the cache frequency. Add corresponding bindings for this
> device.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/cache/qcom,krait-l2-cache.yaml   | 75 +++++++++++++++++++
>  include/dt-bindings/soc/qcom,krait-l2-cache.h | 12 +++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
>  create mode 100644 include/dt-bindings/soc/qcom,krait-l2-cache.h
> 
> diff --git a/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
> new file mode 100644
> index 000000000000..1dcf8165135b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cache/qcom,krait-l2-cache.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cache/qcom,krait-l2-cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Krait L2 Cache
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description:
> +  L2 cache on Qualcomm Krait platforms is shared between all CPU cores. L2
> +  cache frequency and voltages should be scaled according to the needs of the
> +  cores.
> +
> +allOf:
> +  - $ref: ../cache-controller.yaml#

This does not look like correct path. git grep also will suggest that...

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,krait-l2-cache
> +      - const: cache
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +  vdd-mem-supply:
> +    description: suppling regulator for the memory cells of the cache
> +
> +  vdd-dig-supply:
> +    description: suppling regulator for the digital logic of the cache
> +
> +  operating-points-v2: true
> +  opp-table-l2: true

opp-table:
  type: object

Missing cache-level (const).


Best regards,
Krzysztof

