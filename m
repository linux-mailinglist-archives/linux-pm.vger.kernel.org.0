Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33B745B08
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGCL1O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGCL1N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 07:27:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D5C1
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 04:27:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso6464345e87.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2023 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688383630; x=1690975630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RK/XJ7o+rgsGaeoI5Nx8ZGV+2DCm01Ayne6yt0W67Bk=;
        b=lvQgnb18npAG2E5bEUiJLdJgNhVL06F8d2QTEzTZp/G59gbbEULFSXOwmCSL2nJAe9
         V/C8RvYiwjvcX9DeMaZdGFzLzo6/J/hArAd0cSR8uojumzzouwWvFk8HmfsDxsvL4D5L
         6j9GjiFDwam6O98K4SaanQHwEx7jCP6Zuzhd2BEHVbFsNizijfnDQwHYnSP5X1W3+Rrl
         aGr84/vTaG9VjB9b/akgUUWJEg5TaztBnD+gol7hfYm9QD+fFf/jqv8wxDbJCivTgQOl
         brWBi1p5W5yP7yb0Z2haASCAxiZg0YhaccjS2DkXhoEFKvokl0EYGoJ/+LTTfGRvOH6M
         APAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688383630; x=1690975630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RK/XJ7o+rgsGaeoI5Nx8ZGV+2DCm01Ayne6yt0W67Bk=;
        b=TH/XxC/dogBTZebYJtjPDoHaswbtNNcuSlYu0hS9v+bdSB80g22PyP8kRip0BbyyJ8
         iA0B6CBLw4QrN06l0SdT3BHz6K0nQQYAiJ4wr8ycN8yaGpZJaaHHptDit366cWZ2aEvi
         nETwVjltiUqESz8ZcXTuOEfg4LJFuLPsCj1IvlzxMsPDnLZZ6oZCxxgCdktu3dM2AY2H
         LT69q3quvs/Sl8WqaB3OVAFk3fVk33W8rme6ZyaY0T8fNR9iu8oin+WNMpkVxhBlWdxU
         GBrrytPnqLjKxDbV1EKeyLBGfeoYEklovWT+GKnvLHanVvIKC6XL2/usSzAyRYKTHX//
         mmYg==
X-Gm-Message-State: ABy/qLbhLt9O+YmyvwQ9t7xL/20NuxYjNehZtwfAmIQ1OHL4aFnT+4RM
        uQlXVeXoBd9IzfN+kpX+GcpkLQ==
X-Google-Smtp-Source: APBJJlEPbfyN6mdWTguA9QbTauN9qkLOL9M3diZXA8lBUwtOOJQZXLXwd3NJEgoFJMP+dwYTDNEiIg==
X-Received: by 2002:a05:6512:70c:b0:4fb:7b2a:78de with SMTP id b12-20020a056512070c00b004fb7b2a78demr5894609lfs.45.1688383630371;
        Mon, 03 Jul 2023 04:27:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25628000000b004fa5bfddabesm4301405lff.296.2023.07.03.04.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:27:10 -0700 (PDT)
Message-ID: <44b3ced2-660c-d8b4-a190-947f30e622af@linaro.org>
Date:   Mon, 3 Jul 2023 13:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 20/28] ARM: dts: qcom: apq8064: add Krait clock
 controller
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
 <20230702174246.121656-21-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702174246.121656-21-dmitry.baryshkov@linaro.org>
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

On 2.07.2023 19:42, Dmitry Baryshkov wrote:
> Add device node for the clock controller for the CPU cores and L2
> clocks. It will be further used by the L2 and by the CPUfreq nodes.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> index ab4b8f8270bb..c212215800d0 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> @@ -213,6 +213,32 @@ sleep_clk: sleep_clk {
>  		};
>  	};
>  
> +	kraitcc: clock-controller {
> +		compatible = "qcom,krait-cc-v1";
> +		clocks = <&gcc PLL9>, /* hfpll0 */
> +			 <&gcc PLL10>, /* hfpll1 */
> +			 <&gcc PLL16>, /* hfpll2 */
> +			 <&gcc PLL17>, /* hfpll3 */
> +			 <&gcc PLL12>, /* hfpll_l2 */
I'm not sure how useful these comments are, given clock-names are
just like 7 lines below.

Konrad
> +			 <&acc0>,
> +			 <&acc1>,
> +			 <&acc2>,
> +			 <&acc3>,
> +			 <&l2cc>;
> +		clock-names = "hfpll0",
> +			      "hfpll1",
> +			      "hfpll2",
> +			      "hfpll3",
> +			      "hfpll_l2",
> +			      "acpu0_aux",
> +			      "acpu1_aux",
> +			      "acpu2_aux",
> +			      "acpu3_aux",
> +			      "acpu_l2_aux";
> +		#clock-cells = <1>;
> +		#interconnect-cells = <1>;
> +	};
> +
>  	sfpb_mutex: hwmutex {
>  		compatible = "qcom,sfpb-mutex";
>  		syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
