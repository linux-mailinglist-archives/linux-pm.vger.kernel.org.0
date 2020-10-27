Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F329A71C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895152AbgJ0I50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:57:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46986 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403964AbgJ0I5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:57:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id 33so566859edq.13;
        Tue, 27 Oct 2020 01:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUl+o/7xg/oQWEkHSv+Sd9NIOES//4+6SIoc9etOZOE=;
        b=ewjrfUK42fl1cMbQSWi+3pykGSpcsDzHOq1JNmfQeLsw4yidi0UyZdaEpkorQ/4aqg
         2fyJbYFLmTNbhBlE9t6Z1r7fzBlkPu+qbcUG5090Uq6cGOEu1t3juHMVzPdJwl5z2EgC
         01fcj6ScqxKKDkOTGXrsJ/15ACgURLRkOhRT4qLaznkusl3CPLhbdeeEccRS+iRauPSY
         Ste/mQQ/yClkY9LBEafq6XkaPNke5Snl0Np4TSQC3fG0S3jbuvwmI6itq1ecOjnLmvHM
         BciNg0D84cDI4YI/lmtsFZl+ioBTT6omHtC9smHfb7qKSCXISBlWWmnbCC+mLadkEK/9
         x2iw==
X-Gm-Message-State: AOAM530k1lezHR2/Erib0YNzQaXG6St5gPt/S9xpI/0KmW9dOLzWOUkm
        XTZpHVV9JoWntSBWvQCNL5M=
X-Google-Smtp-Source: ABdhPJz1HXUDOFZ/JUJ/wbYV21cxZO30liKh11vnxTXHeeuT2qryjv96syz//4EvKya3F2LDe8npww==
X-Received: by 2002:aa7:c792:: with SMTP id n18mr1099285eds.209.1603789041727;
        Tue, 27 Oct 2020 01:57:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id hb6sm591383ejb.65.2020.10.27.01.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:57:20 -0700 (PDT)
Date:   Tue, 27 Oct 2020 09:57:18 +0100
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
Subject: Re: [PATCH v6 07/52] dt-bindings: memory: tegra20: emc: Document OPP
 table and voltage regulator
Message-ID: <20201027085718.GF4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-8-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:50AM +0300, Dmitry Osipenko wrote:
> The SoC core voltage can't be changed without taking into account the
> clock rate of External Memory Controller. Document OPP table that will
> be used for dynamic voltage frequency scaling, taking into account EMC
> voltage requirement. Document optional core voltage regulator, which is
> optional because some boards may have a fixed core regulator and still
> frequency scaling may be desired to have.

You need to document that property is optional in the binding.

Best regards,
Krzysztof

> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.txt      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> index 0a53adc6ccba..8d09b228ac42 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> @@ -14,11 +14,23 @@ Properties:
>  - clocks : Should contain EMC clock.
>  - nvidia,memory-controller : Phandle of the Memory Controller node.
>  - #interconnect-cells : Should be 0.
> +- core-supply: Phandle of voltage regulator of the SoC "core" power domain.
> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
>  
>  Child device nodes describe the memory settings for different configurations and clock rates.
>  
>  Example:
>  
> +	emc_icc_dvfs_opp_table: emc_opp_table0 {
> +		compatible = "operating-points-v2";
> +
> +		opp@36000000 {
> +			opp-microvolt = <950000 950000 1300000>;
> +			opp-hz = /bits/ 64 <36000000>;
> +		};
> +		...
> +	};
> +
>  	memory-controller@7000f400 {
>  		#address-cells = < 1 >;
>  		#size-cells = < 0 >;
> @@ -28,6 +40,8 @@ Example:
>  		interrupts = <0 78 0x04>;
>  		clocks = <&tegra_car TEGRA20_CLK_EMC>;
>  		nvidia,memory-controller = <&mc>;
> +		core-supply = <&core_vdd_reg>;
> +		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
>  	}
>  
>  
> -- 
> 2.27.0
> 
