Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265EB29A784
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 10:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509792AbgJ0JPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 05:15:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33721 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509791AbgJ0JPW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:15:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id w23so662362edl.0;
        Tue, 27 Oct 2020 02:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g6bHoMhiwcmZw1/CSnlFqJcYBMkTv5s8A4syHXJYESk=;
        b=WKexmU/X4//LWeCWTSIYUeuu6z6zJBRA6UidchYkUAPVS/jG/hcLaQLIaZ5rhhyUeB
         qJ9b0yENnWnxhkqz1JpKEwMRZ/6F2prty7DjOAd/WxdU1TNhPycufbSec01Uo0UkbMSZ
         E3p8FLOwVunM5LifOGhuIbOChi1TFRUyZdOMZiIkFCh8KFVFKkIsNJPG+/Vba/uv3Bwh
         gxfahtaBE8/0ft4mpEhGqTCzHa54JX6BQwnOz5/frkKbVuP/dByTe6SfYrRUdcNouW+t
         4k7/Y+0UO6zf5mNGJHkgjRj8QsUjvZG+9a8hrlJIy3S+nTU4RvDU9Znh6BHmtG2FFFEd
         kmNw==
X-Gm-Message-State: AOAM530HrmhEsEcMivb0zLHEElXNGKDBJKtyIqlQAqcYahUk+wF7xtFK
        fG8e0dcmFpRvRUoNSlnCNQc=
X-Google-Smtp-Source: ABdhPJxd6ufTfpcGWYE02ffhR1QhXCCQSQWXm5hhrDvcb+FyIyVie9373Y/Qw2lKZrkAXRmUqyj8Fg==
X-Received: by 2002:aa7:de95:: with SMTP id j21mr1204973edv.199.1603790119475;
        Tue, 27 Oct 2020 02:15:19 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id t5sm546479edw.45.2020.10.27.02.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:15:18 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:15:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 22/52] ARM: tegra: Add interconnect properties to
 Tegra30 device-tree
Message-ID: <20201027091516.GA10762@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-23-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-23-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:17:05AM +0300, Dmitry Osipenko wrote:
> Add interconnect properties to the Memory Controller, External Memory
> Controller and the Display Controller nodes in order to describe hardware
> interconnection.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index aeae8c092d41..2caf6cc6f4b1 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -210,6 +210,17 @@ dc@54200000 {
>  
>  			nvidia,head = <0>;
>  
> +			interconnects = <&mc TEGRA30_MC_DISPLAY0A &emc>,

Does not compile.

> +					<&mc TEGRA30_MC_DISPLAY0B &emc>,
> +					<&mc TEGRA30_MC_DISPLAY1B &emc>,
> +					<&mc TEGRA30_MC_DISPLAY0C &emc>,
> +					<&mc TEGRA30_MC_DISPLAYHC &emc>;
> +			interconnect-names = "wina",
> +					     "winb",
> +					     "winb-vfilter",
> +					     "winc",
> +					     "cursor";
> +
>  			rgb {
>  				status = "disabled";
>  			};
> @@ -229,6 +240,17 @@ dc@54240000 {
>  
>  			nvidia,head = <1>;
>  
> +			interconnects = <&mc TEGRA30_MC_DISPLAY0AB &emc>,
> +					<&mc TEGRA30_MC_DISPLAY0BB &emc>,
> +					<&mc TEGRA30_MC_DISPLAY1BB &emc>,
> +					<&mc TEGRA30_MC_DISPLAY0CB &emc>,
> +					<&mc TEGRA30_MC_DISPLAYHCB &emc>;
> +			interconnect-names = "wina",
> +					     "winb",
> +					     "winb-vfilter",
> +					     "winc",
> +					     "cursor";
> +
>  			rgb {
>  				status = "disabled";
>  			};
> @@ -748,15 +770,18 @@ mc: memory-controller@7000f000 {
>  
>  		#iommu-cells = <1>;
>  		#reset-cells = <1>;
> +		#interconnect-cells = <1>;
>  	};
>  
> -	memory-controller@7000f400 {
> +	emc: memory-controller@7000f400 {
>  		compatible = "nvidia,tegra30-emc";
>  		reg = <0x7000f400 0x400>;
>  		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&tegra_car TEGRA30_CLK_EMC>;
>  
>  		nvidia,memory-controller = <&mc>;
> +

No need for blank line.

Best regards,
Krzysztof

> +		#interconnect-cells = <0>;
>  	};
>  
>  	fuse@7000f800 {
> -- 
> 2.27.0
> 
