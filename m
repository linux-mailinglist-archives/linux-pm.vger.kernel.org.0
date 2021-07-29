Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601923DA18A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhG2Ku7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhG2Ku6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 06:50:58 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF97C061765
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 03:50:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id jm13so3149501qvb.5
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7LDSqJbg5uCatZHHPu87WA9Bh6dYYJKdoQ4UcOW9Nqk=;
        b=R+6Utq/mypO/2BTESax//iPcjehFNB85vYbB++C51eQcimGRAY1islhP1BkqB4EO6f
         eD1GDVj7bSuVkbDfpXdRLtnvnyjaqxTal+EM+ROj+JJzMV531IrZCIrWLXWK7q52Va8S
         QMxIeu+c01guO+Dyygq2Obc4YFHokMC7XAarXF/dc5BJ1rhFbX4nTD2wpekkOWp6HaTy
         r+gCjeMzIf3XVBnbWPcCBpibBJmKHUUumHJ+eIN0A5JttMhW6SS2z2Ipo0dWJd8+2ilc
         hQtG8NaIMqL2frteNVLJEavYWuB6N3t3/R0k55rZKTXK+NM0vysud8OMLaa8GlnOuidt
         sZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7LDSqJbg5uCatZHHPu87WA9Bh6dYYJKdoQ4UcOW9Nqk=;
        b=PHHN2OmIRxCfPxNVrfYhxZPeBWHDV28X2+5cA+JhqFnbEQ3685zlvPVRp7zpY+RBbM
         An3fwKo6a8W0T7r9lnFj9+wfAOT+c7yYo4QD/+JiaD+6zTepXUsjlpuWq+orH1KkLr7G
         ExU6BIeDUG1iHI0Q8Yq2XloQXjVSLpvkQ0+htsyGXcxPxATUlIRQJoAtUWyxgv2lBu+a
         sRH154COe9TH11gUVIjkA70v9bRdc7/n2Ejh8Moa4Q7hYaC3WuFCSz61WejNON8kfSaO
         TU1vS/UEp//AdiHIBdeLB7jm3v+OvT8RpB0FhKHoffpb8kIYIJ3PB7ypXSlium0Yf/iB
         lISg==
X-Gm-Message-State: AOAM530hrQKeYrJLmbzOrWRtrGYX7x02h4hHAOQpCPVt1GCIcyLoXEbO
        OkKLLT1fBxME1Ibi2cN4obK7Lg==
X-Google-Smtp-Source: ABdhPJymclFCGkiQXunpw1ReNKgxD5q725uzyeVyljJl8XX1w+h0z08VUI397n+uEQLXPhkGIF4G1w==
X-Received: by 2002:a0c:e087:: with SMTP id l7mr4591930qvk.23.1627555853690;
        Thu, 29 Jul 2021 03:50:53 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 188sm1515483qkj.48.2021.07.29.03.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 03:50:52 -0700 (PDT)
Subject: Re: [PATCH 14/39] arm64: dts: qcom: sdm630: Add TSENS node
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
 <20210728222542.54269-15-konrad.dybcio@somainline.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <860f1120-c5a4-f531-3ea9-aa90c6b063dc@linaro.org>
Date:   Thu, 29 Jul 2021 06:50:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728222542.54269-15-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Konrad,

On 7/28/21 6:25 PM, Konrad Dybcio wrote:
> This will enable temperature reporting for various SoC
> components.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>   .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
>   arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 4a2eaf28e3fd..d3b9e9b600a2 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -48,6 +48,7 @@ properties:
>                 - qcom,sc7180-tsens
>                 - qcom,sc7280-tsens
>                 - qcom,sc8180x-tsens
> +              - qcom,sdm630-tsens
>                 - qcom,sdm845-tsens
>                 - qcom,sm8150-tsens
>                 - qcom,sm8250-tsens
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 1e54828817d5..7e9c80e35fba 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -627,6 +627,17 @@ mnoc: interconnect@1745000 {
>   				 <&mmcc AHB_CLK_SRC>;
>   		};
>   
> +		tsens: thermal-sensor@10ae000 {
> +			compatible = "qcom,sdm630-tsens", "qcom,tsens-v2";
> +			reg = <0x010ae000 0x1000>, /* TM */
> +				  <0x010ad000 0x1000>; /* SROT */
> +			#qcom,sensors = <12>;

Are all 12 sensors used ? I see that in a later patch "arm64: dts: qcom: 
sdm630: Add thermal-zones configuration" only 9 are used.

> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +					 <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>   		tcsr_mutex_regs: syscon@1f40000 {
>   			compatible = "syscon";
>   			reg = <0x01f40000 0x20000>;
> 

-- 
Warm Regards
Thara (She/Her/Hers)
