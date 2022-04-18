Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16922505C35
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbiDRQGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345880AbiDRQGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 12:06:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92B1276A
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:04:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so27647671ejb.6
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JrJapQKuYp8OSttBEWIA4svvfpv63Q1QVGJr1i9oSXc=;
        b=OfyfwmujRMIJ+rOvyOsAQK+0pnnPTwmJegSUmTlOuC6J/9Lbnfp+oGZ2zDtoT3A+Eh
         u0YQg5przbTeXsCFBsszJpsKJh9KXxLpFVpspOpYKS5jc+ekQxpknw5tMryhn8tRjlpS
         WDID1nFFMdTNeRiz6dcFg/BIV+VddaZz/B0QwoJBt+cR4FttDp8fUevmVAFx6QDywqIo
         EevzUqbsP0mnRiiLISfbtJhfm933PLNkv4RBTIcrLTSjIWltXYjbZz3F5kJhPOwAZE0B
         ZRA+Dsi38Io3U2S29EoCirTVc3UW5rhOtFxhXajGGXgg6OxkCjh6t9u0PlMmS53UlP/I
         Znng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JrJapQKuYp8OSttBEWIA4svvfpv63Q1QVGJr1i9oSXc=;
        b=ivFmBL51zj67tk+3iwSpi0L8YsGZjv5yBmCaHpPF/PVnkH4uefBB+zVdMy6FDr/MNb
         m5Mt22C/LTTH0pmWarI7DQj2FfJZUV5omadO52yQetnzDKeRAhTzowH8h5YcrlNxJMo0
         oHabPZQubqGwIeu0N2zcU8fbWElfHGV6bLV65IOGEg5L70g/7DqLgfGMvXlj6uEuFset
         K7a4ZhQHZIc95m3Y38yEEPR7E0YS+F2CAsBTxBLc/YhLskZYjPOwWlXqZBson0BzTxKG
         I4tSmKBUnc5VZ0iFlFOGaSPUVaBbE6ktvU+6wfPkpjhGfPSiLm8mNft7njEVRV0aMcdc
         eW/g==
X-Gm-Message-State: AOAM5325R90xubF88F8cbZKLCILzi6ip0aJy27McJZLiisNCqU8JEAUZ
        zc4XvE4wMuifuR3gQhTWgQAvqw==
X-Google-Smtp-Source: ABdhPJxGsHJGdjSoIphlhjXGf6naO4I8zToZdrpkO2BR5tTYnz1navkLvmGeJrlYROJEaBe9r1Dnvw==
X-Received: by 2002:a17:907:8a11:b0:6df:db0a:e5ab with SMTP id sc17-20020a1709078a1100b006dfdb0ae5abmr9732352ejc.528.1650297850270;
        Mon, 18 Apr 2022 09:04:10 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7c04f000000b004229daeaf37sm5184233edo.40.2022.04.18.09.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 09:04:09 -0700 (PDT)
Message-ID: <813f4a3d-255b-0ec1-cc3e-a1280e4d74ae@linaro.org>
Date:   Mon, 18 Apr 2022 18:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v2 1/9] dt-bindings: clk: qcom: msm8996-apcc: Add
 CBF
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Rob Herring <robh@kernel.org>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
 <20220416025637.83484-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220416025637.83484-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/04/2022 04:56, Yassine Oudjana wrote:
> Add CBF clock and reg.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> index a20cb10636dd..325f8aef53b2 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> @@ -10,8 +10,8 @@ maintainers:
>    - Loic Poulain <loic.poulain@linaro.org>
>  
>  description: |
> -  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power cluster
> -  and clock 1 is for Perf cluster.
> +  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power cluster,
> +  clock 1 is for Perf cluster, and clock 2 is for Coherent bus fabric (CBF).
>  
>  properties:
>    compatible:
> @@ -19,7 +19,9 @@ properties:
>        - qcom,msm8996-apcc
>  
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: Cluster clock registers
> +      - description: CBF clock registers

This breaks the ABI (which might be okay or might be not, but was not
mentioned in the commit) and breaks existing DTSes. Please fix them
before this patch.

Best regards,
Krzysztof
