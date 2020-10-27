Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9829A788
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 10:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441450AbgJ0JQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 05:16:11 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37174 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgJ0JQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:16:10 -0400
Received: by mail-ej1-f65.google.com with SMTP id p9so1173115eji.4;
        Tue, 27 Oct 2020 02:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=te7LW0h+WnaT74s0iZ3ktDJyLfJVDjSeiQCufT7c3zs=;
        b=Olyh7l13uhhpf7vVrVSAP7vCeXNcYHXAVyqtgU3LTOa+tW/5gBrieWqrqu1Dks1L51
         LV8U1d5H/1h8uHcKthAnrE9Glkejp++yoYoFkFLUhyo7odbZGibpwHlafA3UihujlI0c
         hnNgLFRHFEAor4XTl/G95QNH88G7RKaPuVUJCbKnlmhzQ50GLXcbIxCHTTjPbXCKbcCm
         HFVd0fQZvieDnSeAriYwq+Zs8yTLkXBxSUkcaZJNYoTtftpx93WzGJDsyoSmryUxlims
         VXchZXHTm/afcwJXmkYeKaDQL9XjUiowX7rDEm73hPSNp3nRx3jAAMDRUbETh31BEV+j
         zPfQ==
X-Gm-Message-State: AOAM532q2J2UnLTF/Xd5oiJK23X8JW7OP76LftpwQ700ghLbH3Zy0stb
        x2Jgn+H/tB/KB5iP15O39Zg=
X-Google-Smtp-Source: ABdhPJxqcWEhoSvTes/dDepoyWlh45x7YW1FAkIDTwxisa/25Ndd/8eT62q8W8j1JicJvbmdEsdQ+A==
X-Received: by 2002:a17:906:eb18:: with SMTP id mb24mr1427378ejb.172.1603790167918;
        Tue, 27 Oct 2020 02:16:07 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id qt11sm632422ejb.16.2020.10.27.02.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:16:06 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:16:04 +0100
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
Subject: Re: [PATCH v6 23/52] ARM: tegra: Add interconnect properties to
 Tegra124 device-tree
Message-ID: <20201027091604.GB10762@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-24-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-24-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:17:06AM +0300, Dmitry Osipenko wrote:
> Add interconnect properties to the Memory Controller, External Memory
> Controller and the Display Controller nodes in order to describe hardware
> interconnection.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 64f488ba1e72..1801e30b1d3a 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -113,6 +113,19 @@ dc@54200000 {
>  			iommus = <&mc TEGRA_SWGROUP_DC>;
>  
>  			nvidia,head = <0>;
> +
> +			interconnects = <&mc TEGRA124_MC_DISPLAY0A &emc>,

This does not compile.

> +					<&mc TEGRA124_MC_DISPLAY0B &emc>,
> +					<&mc TEGRA124_MC_DISPLAY0C &emc>,
> +					<&mc TEGRA124_MC_DISPLAYHC &emc>,
> +					<&mc TEGRA124_MC_DISPLAYD &emc>,
> +					<&mc TEGRA124_MC_DISPLAYT &emc>;
> +			interconnect-names = "wina",
> +					     "winb",
> +					     "winc",
> +					     "cursor",
> +					     "wind",
> +					     "wint";
>  		};
>  
>  		dc@54240000 {
> @@ -127,6 +140,15 @@ dc@54240000 {
>  			iommus = <&mc TEGRA_SWGROUP_DCB>;
>  
>  			nvidia,head = <1>;
> +
> +			interconnects = <&mc TEGRA124_MC_DISPLAY0AB &emc>,
> +					<&mc TEGRA124_MC_DISPLAY0BB &emc>,
> +					<&mc TEGRA124_MC_DISPLAY0CB &emc>,
> +					<&mc TEGRA124_MC_DISPLAYHCB &emc>;
> +			interconnect-names = "wina",
> +					     "winb",
> +					     "winc",
> +					     "cursor";
>  		};
>  
>  		hdmi: hdmi@54280000 {
> @@ -628,6 +650,7 @@ mc: memory-controller@70019000 {
>  
>  		#iommu-cells = <1>;
>  		#reset-cells = <1>;
> +		#interconnect-cells = <1>;
>  	};
>  
>  	emc: external-memory-controller@7001b000 {
> @@ -637,6 +660,8 @@ emc: external-memory-controller@7001b000 {
>  		clock-names = "emc";
>  
>  		nvidia,memory-controller = <&mc>;
> +

No need for blank line.

Best regards,
Krzysztof
