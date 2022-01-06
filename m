Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD288486DD3
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jan 2022 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245559AbiAFXfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 18:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245593AbiAFXfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 18:35:11 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C1C0611FD
        for <linux-pm@vger.kernel.org>; Thu,  6 Jan 2022 15:35:11 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q186so525682oih.8
        for <linux-pm@vger.kernel.org>; Thu, 06 Jan 2022 15:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k+AXXTXFi1cWIEwtg73aFjj3MfoRkcbinIzxQo9/DOY=;
        b=MA3EeJeLnwvymvy4Qt2JImgfM9yMQRPtdNStEtT6cC0NkKPGG9e/Ypj4Qb0xB5+rjw
         T+sGqYHDW3hl92IIENMquMHcDvtkepaFQYhj4YDOQCO+j4SeJzH84VSpGaQCb1nQqLOA
         UKoGOUWX+fT2oul0+uBLhfJyNFNDGBv5F62y1KXAk8XO3HRvk6MjnapTSXT+946MLe0b
         gAv1QqG3X0Qsgb8p5HpGcJFtDbE2gSs+lC327/XZiomVQrofHFofOy5v6MZiRgI4PmP8
         Kkvra88lb8vS+GG5s5W4EGcP2LSMUn4Udj/QxwD3beLSLE2lqHPAM3T7WvmXjTZPRyJH
         EZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+AXXTXFi1cWIEwtg73aFjj3MfoRkcbinIzxQo9/DOY=;
        b=eh776IHAlDHLkNBIMZWGpFqF6H9I/lC9E5B96HEFBpctUkLw+HzW4sSEoQfFZkMhhb
         JZqAJHvLtjcyYNffvgT4H6jRxyrkHqSU+UYPQOI/ScEM9GntHWq6kDk5k8BZ8ZCQbwG3
         uhOqyncjhwSI17Dh5EtVegS4z4L8hIhMRiDsYhsVPqYEGpVoQZim6wPY2V0ZUDj7j44v
         byLtzfDafI8MbWQnWQrWm2ZUrc+sO2rFVDheqNvIWYgwclmUjZztWNkCtfj1vMJ3tMKb
         a3dfh3fJsGgYj/ZrbNq7NxjHsphc9VCLIQY/KTMoTjZF3sex21u5PjJcosntNMmMQBjp
         Ssow==
X-Gm-Message-State: AOAM530PKswAdy0sy2+6dr16iXEI4q6U48Dyfj+LZgRKBeiCzvl8E+Xc
        F0rP5oenUUMKQLoTtcBXloLubw==
X-Google-Smtp-Source: ABdhPJwaRRGMTpfWmpeUEfMfF32qW3dxW25CH6zMJn7uOynq8j1EabTLXGE8CMUDX9UanXZZj4eytw==
X-Received: by 2002:aca:1811:: with SMTP id h17mr7451667oih.178.1641512110515;
        Thu, 06 Jan 2022 15:35:10 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h14sm633673ots.48.2022.01.06.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:35:10 -0800 (PST)
Date:   Thu, 6 Jan 2022 15:35:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        daniel.lezcano@linaro.org
Cc:     agross@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 2/3] arm64: dts: qcom: sm8150: Add support for LMh node
Message-ID: <Ydd839Wu1Gm4bWpm@ripper>
References: <20220106173138.411097-1-thara.gopinath@linaro.org>
 <20220106173138.411097-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106173138.411097-3-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 06 Jan 09:31 PST 2022, Thara Gopinath wrote:

> Add LMh nodes for cpu cluster0 and cpu cluster1 for sm8150 SoC.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Daniel, will you please apply patch 1 and 3 through your tree and I can
take this through the qcom dts tree.

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 81b4ff2cc4cd..e755d7ab78dd 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3650,6 +3650,30 @@ cpufreq_hw: cpufreq@18323000 {
>  			#freq-domain-cells = <1>;
>  		};
>  
> +		lmh_cluster1: lmh@18350800 {
> +			compatible = "qcom,sm8150-lmh";
> +			reg = <0 0x18350800 0 0x400>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			cpus = <&CPU4>;
> +			qcom,lmh-temp-arm-millicelsius = <60000>;
> +			qcom,lmh-temp-low-millicelsius = <84500>;
> +			qcom,lmh-temp-high-millicelsius = <85000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		lmh_cluster0: lmh@18358800 {
> +			compatible = "qcom,sm8150-lmh";
> +			reg = <0 0x18358800 0 0x400>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			cpus = <&CPU0>;
> +			qcom,lmh-temp-arm-millicelsius = <60000>;
> +			qcom,lmh-temp-low-millicelsius = <84500>;
> +			qcom,lmh-temp-high-millicelsius = <85000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
>  		wifi: wifi@18800000 {
>  			compatible = "qcom,wcn3990-wifi";
>  			reg = <0 0x18800000 0 0x800000>;
> -- 
> 2.25.1
> 
