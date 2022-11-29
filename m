Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD263C543
	for <lists+linux-pm@lfdr.de>; Tue, 29 Nov 2022 17:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiK2Qf7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Nov 2022 11:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiK2Qf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2022 11:35:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E08E697DC
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2022 08:35:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b3so22910471lfv.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2022 08:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DozG8slifYUbIeG4p5hbkPUxWwGRFcCdA+vVxiWXmfs=;
        b=I9CBZQoGxjED9f6Xxs7R1Rh6NnUMmuWqQXJdRRmpJ19Mz89DIjvjAoIuZf7K9iWSBb
         BiuLtCwS1l8gbw3kmoN3yBnAy0UNEWGDVWoL2sM0tJjSRAYvll5qomZ569ewA9ysgSxU
         JzfdKhZGEjom0GwBUbMn2PSvs3xj6oK1LcdbY+Tk/SBTR5WTvgMJBNv2HG66Cws6pPO9
         Sia8hauW5d44/JN0lbQF8CYJlynN0e2tJ0r9jPqXIbic6wHazU6w0R3BFFReizNVGZHf
         3nghfdGrmHKOK8Kcx91mFYj0lzTVx4zPIFCmuqQfPRQHqdG09bfrB8NBJpuESEprcOvX
         cnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DozG8slifYUbIeG4p5hbkPUxWwGRFcCdA+vVxiWXmfs=;
        b=gF03N4Q1Qhdasc4FSdN1UL9LkNYJGX9v0oixFSHRxPef7/tmc1AoT5b4rQhriev6n1
         gkQdG5qiQbqzi8K2bL6wxj31joI/I2V7FEQADQgDv60jNWYriiEmqedpdRzjvjcMVich
         5eq/w954pHx9RK9Z3Si7zHj3r5hKkzUvOqgc+rSFw14Z3f+TUBi2k+l20qmoRGiabU4U
         hwdiF8cXDWy3dtTBdmgps1mp/R12HnEMMcKLNpVhxS9b5mogRw26LL8Ah2OAb8EGt45p
         AP1eHi0j4S6O1NVVvucx5ZfGVEOiDFY3PSHehil019ZPgtZJHn5fzblmZXRLcZ1irD00
         CNog==
X-Gm-Message-State: ANoB5pkLRZa0FxAfMMNXaoxzprX7nfQbApLV0YagMUqKXx1KqTO7Wy2d
        mpSp3YpzKCFwJ1GS3KEkUSVVCsHUZN45dnHq
X-Google-Smtp-Source: AA0mqf6nIP2Y/A3+PfTGlbmjvNTL2zsWVEGp5bBox8UJh3b4flIMVZs/UJDXUOiNFTamoISUgQ+TEQ==
X-Received: by 2002:ac2:4346:0:b0:4b4:a5c8:cc0f with SMTP id o6-20020ac24346000000b004b4a5c8cc0fmr21241693lfl.138.1669739753191;
        Tue, 29 Nov 2022 08:35:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a26-20020a056512201a00b0049496608d58sm2240486lfb.155.2022.11.29.08.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:35:52 -0800 (PST)
Message-ID: <bc230481-1c31-6121-6647-8e2b4b80512e@linaro.org>
Date:   Tue, 29 Nov 2022 17:35:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221129131203.2197959-1-abel.vesa@linaro.org>
 <20221129131203.2197959-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129131203.2197959-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/11/2022 14:12, Abel Vesa wrote:
> The Qualcomm SM8550 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8550-aggre1-noc
> +              - qcom,sm8550-aggre2-noc
> +              - qcom,sm8550-pcie-anoc
> +    then:
> +      required:
> +        - clocks
> +    else:
> +      properties:
> +        clocks: false
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/qcom,sm8550-gcc.h>
> +      #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
> +      #include <dt-bindings/clock/qcom,rpmh.h>

Keep headers sorted.... but actually these two look like not used. If
you want to mention the header for interconnect IDs, you can add it in
top level descritpion.

> +
> +      clk_virt: interconnect-0 {
> +             compatible = "qcom,sm8550-clk-virt";
> +             #interconnect-cells = <2>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      aggre1_noc: interconnect@16e0000 {
> +             compatible = "qcom,sm8550-aggre1-noc";
> +             reg = <0x016e0000 0x14400>;
> +             #interconnect-cells = <2>;
> +             clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +                      <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };

Your DTS example is oddly indented. I missed it during previous review.
DTS examples go either with 2 or 4 spaces.


Best regards,
Krzysztof

