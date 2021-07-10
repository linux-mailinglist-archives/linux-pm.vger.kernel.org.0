Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88A3C3291
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 06:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGJEUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 00:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhGJEUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jul 2021 00:20:12 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF4FC0613E5
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 21:17:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id j10-20020a05683015cab02904b568e08dccso5461299otr.4
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mr8NLdeNWjeGDA0MrTbC6oeAvQmdceefCvwM1QcCxcc=;
        b=MQIU20DO+fDvLfTOJzViFq7OD4lqAdFbj7ElklXHJqoOAlrzVRD22lKi43wj7ANKEE
         GOZVpA2G94PDGrUEfOTKFM1qSIXv0kmizUF5W9OB2LyA6jvRAk9ENdfxxncVEpkmiMgb
         oxOrgTdZRBLLcJRknQi2SLz2mLDAuEQf67yiIr8zZcsulDAbGfZp+fD+PZSDfi84i527
         3z1SRUU8stGr2QWKSxJ0KTjw/t19/QacIEhauzljBIQk185B0p7g2UCWNHdAi+IsrYI/
         maeKZb5asrSZgeMpm2oxFjGGeCnOkpn6SvzVSjMGsIjK3qBQu8+JpBHKUR/vIN5XhGyq
         eGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mr8NLdeNWjeGDA0MrTbC6oeAvQmdceefCvwM1QcCxcc=;
        b=VIbENH1d9lBULMCu8+5FUCvQv9WFxrk/1A27nvOaIJWkmKV/vfjaHCEctgwk1Sg2C0
         hd+LLu6tH8UbCYIYogmLtUKOJNhbLYZ1ibIOw3izB/RMktSwu3gEuNPMEqECi7U7otVZ
         qwwh0whLrxr5OCczWZg21Hal76fQhqTnp9Km3IpCBaxL/VqleZu3pBO+OAz/0NLFCdQP
         801sjgZhT6WHxzJLVn4eXe/KjkJYTnaII3had+uDbQn+5AnVqZUBL95K19egHA+oia8M
         ckNH8Y10DhohEo1yr82qRXdoyTTwR/iYDMxVbEYp8K6IFYmiKcxdWF6yQf0QhbCxWDbt
         1SPA==
X-Gm-Message-State: AOAM531kNo5SXVE/bMbiGvWcDinzrwtChIJ80cIzel9ON6nTz6Iwh2ce
        /wrME9b3kc7+LM9rU0J7MfejcA==
X-Google-Smtp-Source: ABdhPJyu+WgxePkqFU8VY9blX2Gir2+rtfvwCz9SI0BxjyaE7mbEnrldA3rrCjRUvMyYMfKW5i4Msg==
X-Received: by 2002:a9d:7f0b:: with SMTP id j11mr30563870otq.369.1625890646813;
        Fri, 09 Jul 2021 21:17:26 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u22sm1640614oie.26.2021.07.09.21.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 21:17:26 -0700 (PDT)
Date:   Fri, 9 Jul 2021 23:17:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 4/6] arm64: boot: dts: qcom: sdm45: Add support for
 LMh node
Message-ID: <YOkfVBWwS/wIeIfz@yoga>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-5-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120656.663851-5-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:

> Add LMh nodes for cpu cluster0 and cpu cluster1. Also add interrupt
> support in cpufreq node to capture the LMh interrupt and let the scheduler
> know of the max frequency throttling.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v2->v3:
> 	- Changed the LMh low and high trip to 94500 and 95000 mC from
> 	  74500 and 75000 mC. This was a bug that got introduced in v2.
> v1->v2:
> 	- Dropped dt property qcom,support-lmh as per Bjorn's review comments.
> 	- Changed lmh compatible from generic to platform specific.
> 	- Introduced properties specifying arm, low and high temp thresholds for LMh
> 	  as per Daniel's suggestion.
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0a86fe71a66d..4da6b8f3dd7b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3646,6 +3646,30 @@ swm: swm@c85 {
>  			};
>  		};
>  
> +		lmh_cluster1: lmh@17d70800 {
> +			compatible = "qcom,sdm845-lmh";
> +			reg = <0 0x17d70800 0 0x401>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,lmh-cpu-id = <0x4>;
> +			qcom,lmh-temperature-arm = <65000>;
> +			qcom,lmh-temperature-low = <94500>;
> +			qcom,lmh-temperature-high = <95000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		lmh_cluster0: lmh@17d78800 {
> +			compatible = "qcom,sdm845-lmh";
> +			reg = <0 0x17d78800 0 0x401>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,lmh-cpu-id = <0x0>;
> +			qcom,lmh-temperature-arm = <65000>;
> +			qcom,lmh-temperature-low = <94500>;
> +			qcom,lmh-temperature-high = <95000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
>  		sound: sound {
>  		};
>  
> @@ -4911,6 +4935,8 @@ cpufreq_hw: cpufreq@17d43000 {
>  			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
>  			reg-names = "freq-domain0", "freq-domain1";
>  
> +			interrupts-extended = <&lmh_cluster0 0>, <&lmh_cluster1 0>;
> +
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>  			clock-names = "xo", "alternate";
>  
> -- 
> 2.25.1
> 
