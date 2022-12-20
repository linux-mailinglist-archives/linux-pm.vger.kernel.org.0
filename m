Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9CB651F45
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiLTKxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiLTKxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:53:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F24186C1
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:53:16 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 1so18011728lfz.4
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQ4fo2iXqKSlBwjRTk/z9UyDmsj4t4+XdV35YdZZEpo=;
        b=YpVJUUTBp3eRX/6jU2xT01mbmJgIEAOHbP50g4ygV/yH0cPXx/UuK6aTBNCfFbfHeF
         5J7EIQolNojG6FXskBIF2BRSBnUFcPdwf7AbjWpXFfXX8NjNeJXNHcUn5w86IpG/62fQ
         kUVlBp0Yw8F9Ne27X6f/G65pojkZT+X0qVvKF+RK8FHF0ZphvKSYgE4kfqG9woFKPIOq
         Y525iHzqw9jpei38Mx/2JuOhN35KyhYw8vX9nTXV4gqaP3S5iV7qwiqeJmW5LHH7Fn5q
         sALUc93ALnBounPHcf9570YS821TJ3KHjXZi7D/Yjt0HLtDfakWdb+4T8O1tQjnEweMJ
         XV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ4fo2iXqKSlBwjRTk/z9UyDmsj4t4+XdV35YdZZEpo=;
        b=tPe15Pxhf5XI8vUEGKyEvyqn4NJNMm7PdWiEUKdTkL6kvuD6DV/bQHvqOyBCeCen2i
         NrUQrCjHCjRTQqo6teFX0vKl/Od8Ab04IfuMOdp9JC2+mDQJFKpWThfl9YKNGz42I94o
         Kco77t/IJmLmHtSQE0dbNNuommYkjQsghK9nOTKLdQcXjXPAcvoXcp7CHS9ASYGwyqFi
         L63nmvQYVYsM45NEMYj45cZJbK5vfwx0+Sl4Q/nbO8gmXuXFgbzRjDCwU2llsNeZJzfk
         YuNSeeRtbKeh2e4wPuI1cE9E8j/lJ+Nakz8n9LHh3l8MyXQK/SvtAXSINxJ6TRtcuoxG
         pCxA==
X-Gm-Message-State: AFqh2kp+sYxc8KWMwXUlzgMxLrHyHy8/cutG/37HqagIGYfMXzkzzkh7
        uLTJcV3vyo8/4c/39Htqaz1hZw==
X-Google-Smtp-Source: AMrXdXs2RdkaoioP4jv4xy429aqNxYZYKUp5Ngsu11UPakOzqp3Vq/lG7p5xZCBHoho+7QVrbLL/OQ==
X-Received: by 2002:ac2:4424:0:b0:4bb:d287:1147 with SMTP id w4-20020ac24424000000b004bbd2871147mr557092lfl.15.1671533594700;
        Tue, 20 Dec 2022 02:53:14 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b00494a603953dsm1410687lfr.89.2022.12.20.02.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:53:14 -0800 (PST)
Message-ID: <00dba8ee-034b-d269-0907-bfc5ca27b8ac@linaro.org>
Date:   Tue, 20 Dec 2022 11:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 12/15] arm64: dts: qcom: msm8916: specify per-sensor
 calibration cells
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-13-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221220024721.947147-13-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20.12.2022 03:47, Dmitry Baryshkov wrote:
> Specify pre-parsed per-sensor calibration nvmem cells in the tsens
> device node rather than parsing the whole data blob in the driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 70 ++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 2ca8e977fc2a..af7ba66bb7cd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -442,11 +442,57 @@ qfprom: qfprom@5c000 {
>  			reg = <0x0005c000 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			tsens_caldata: caldata@d0 {
> -				reg = <0xd0 0x8>;
> +			tsens_base1: base1@d0 {
> +				reg = <0xd0 0x1>;
> +				bits = <0 7>;
>  			};
> -			tsens_calsel: calsel@ec {
> -				reg = <0xec 0x4>;
> +			tsens_s0_p1: s0_p1@d0 {
No underscores in node names.

> +				reg = <0xd0 0x2>;
> +				bits = <7 5>;
> +			};
> +			tsens_s0_p2: s0_p2@d1 {
> +				reg = <0xd1 0x2>;
> +				bits = <4 5>;
> +			};
> +			tsens_s1_p1: s1_p1@d2 {
> +				reg = <0xd2 0x1>;
> +				bits = <1 5>;
> +			};
> +			tsens_s1_p2: s1_p2@d2 {
> +				reg = <0xd2 0x2>;
> +				bits = <6 5>;
> +			};
> +			tsens_s2_p1: s2_p1@d3 {
> +				reg = <0xd3 0x1>;
> +				bits = <3 5>;
> +			};
> +			tsens_s2_p2: s2_p2@d4 {
> +				reg = <0xd4 0x1>;
> +				bits = <0 5>;
> +			};
> +			tsens_s3_p1: s3_p1@d4 {
> +				reg = <0xd4 0x2>;
> +				bits = <5 5>;
> +			};
> +			tsens_s3_p2: s3_p2@d5 {
> +				reg = <0xd5 0x1>;
> +				bits = <2 5>;
> +			};
> +			tsens_s4_p1: s4_p1@d5 {
> +				reg = <0xd5 0x2>;
> +				bits = <7 5>;
> +			};
> +			tsens_s4_p2: s4_p2@d6 {
> +				reg = <0xd6 0x2>;
> +				bits = <4 5>;
> +			};
> +			tsens_base2: base2@d7 {
> +				reg = <0xd7 0x1>;
> +				bits = <1 7>;
> +			};
> +			tsens_mode: mode@ec {
> +				reg = <0xef 0x1>;
> +				bits = <5 3>;
>  			};
I (gotta admin, a bit painfully) went through all of these again
and they all seem correct!

Konrad
>  		};
>  
> @@ -473,8 +519,20 @@ tsens: thermal-sensor@4a9000 {
>  			compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
>  			reg = <0x004a9000 0x1000>, /* TM */
>  			      <0x004a8000 0x1000>; /* SROT */
> -			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> -			nvmem-cell-names = "calib", "calib_sel";
> +			nvmem-cells = <&tsens_mode>,
> +				      <&tsens_base1>, <&tsens_base2>,
> +				      <&tsens_s0_p1>, <&tsens_s0_p2>,
> +				      <&tsens_s1_p1>, <&tsens_s1_p2>,
> +				      <&tsens_s2_p1>, <&tsens_s2_p2>,
> +				      <&tsens_s3_p1>, <&tsens_s3_p2>,
> +				      <&tsens_s4_p1>, <&tsens_s4_p2>;
> +			nvmem-cell-names = "mode",
> +					   "base1", "base2",
> +					   "s0_p1", "s0_p2",
> +					   "s1_p1", "s1_p2",
> +					   "s2_p1", "s2_p2",
> +					   "s3_p1", "s3_p2",
> +					   "s4_p1", "s4_p2";
>  			#qcom,sensors = <5>;
>  			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "uplow";
