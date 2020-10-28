Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4929DFCB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 02:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgJ2BE3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 21:04:29 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40036 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgJ1WGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:06:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id m128so1173923oig.7;
        Wed, 28 Oct 2020 15:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6fODSQ4vr9/XMdY27bSNaiMwe4c2CZ3zY9crW4kgXQ=;
        b=giofxv4nCdl9rEPf+VGNNkX/x9gpPIykurn5Pf4IcN2WjrYVxfn1KX65CLar3kDq+l
         JVFeh1R9YyeWGlOLnqrB3FvqSytHgt4Hy5QWPVg7Y0lOSOD7xpyTo3818mnuwV+aqExj
         CStrD/ZQGl6A/ZIhJKEmkKEfVfFSc/ahn5CXXgGGoBwgYIaxYMWYD4XxUH/K7D0sxPcF
         tfUNMRc+xYB04T7Te2JnbDxCLmMM1aqEsruUTWvHe3Yn2GW9Vbf+25FAIZmmwlBFISdj
         sHOgAnLHK2DUT9T0Z+VUjFim/5G+HHGGU4V6pvqoUJFQ+NuELBJGnpC00JfxqGk2jf2T
         LyXQ==
X-Gm-Message-State: AOAM530DQLZc5aVEDcKQhDgmX6hqUlTxwtxQuH2EKEROsAxjOOwU/BFK
        fTSaXS9+Q75pOYRLB6EofCstx1bRqQ==
X-Google-Smtp-Source: ABdhPJzrQ/sPPiQh1XWKgR+EAUUZ9HS2ocEuKqdVfGw3aS3RICzkEg8FJnv6OaOSMDEQcXRlXFSJlA==
X-Received: by 2002:a05:6808:198:: with SMTP id w24mr5539933oic.69.1603898917913;
        Wed, 28 Oct 2020 08:28:37 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s20sm307873oof.39.2020.10.28.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:28:37 -0700 (PDT)
Received: (nullmailer pid 4057539 invoked by uid 1000);
        Wed, 28 Oct 2020 15:28:35 -0000
Date:   Wed, 28 Oct 2020 10:28:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
Message-ID: <20201028152835.GB4051913@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:51AM +0300, Dmitry Osipenko wrote:
> External Memory Controller can gather various hardware statistics that
> are intended to be used for debugging purposes and for dynamic frequency
> scaling of memory bus.
> 
> Document the new mfd-simple compatible and EMC statistics sub-device.

It's simple-mfd.

That should only be used if the child has no dependencies on the parent 
node (and driver).

> The subdev contains EMC DFS OPP table and interconnect paths to be used
> for dynamic scaling of system's memory bandwidth based on EMC utilization
> statistics.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.txt | 43 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> index 8d09b228ac42..382aabcd6952 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> @@ -4,7 +4,7 @@ Properties:
>  - name : Should be emc
>  - #address-cells : Should be 1
>  - #size-cells : Should be 0
> -- compatible : Should contain "nvidia,tegra20-emc".
> +- compatible : Should contain "nvidia,tegra20-emc" and "simple-mfd".
>  - reg : Offset and length of the register set for the device
>  - nvidia,use-ram-code : If present, the sub-nodes will be addressed
>    and chosen using the ramcode board selector. If omitted, only one
> @@ -17,7 +17,8 @@ Properties:
>  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
>  - operating-points-v2: See ../bindings/opp/opp.txt for details.
>  
> -Child device nodes describe the memory settings for different configurations and clock rates.
> +Child device nodes describe the memory settings for different configurations and clock rates,
> +as well as EMC activity statistics collection sub-device.
>  
>  Example:
>  
> @@ -31,17 +32,34 @@ Example:
>  		...
>  	};
>  
> +	emc_bw_dfs_opp_table: emc_opp_table1 {
> +		compatible = "operating-points-v2";
> +
> +		opp@36000000 {
> +			opp-hz = /bits/ 64 <36000000>;
> +			opp-peak-kBps = <144000>;
> +		};
> +		...
> +	};
> +
>  	memory-controller@7000f400 {
>  		#address-cells = < 1 >;
>  		#size-cells = < 0 >;
>  		#interconnect-cells = < 0 >;
> -		compatible = "nvidia,tegra20-emc";
> +		compatible = "nvidia,tegra20-emc", "simple-mfd";
>  		reg = <0x7000f400 0x400>;
>  		interrupts = <0 78 0x04>;
>  		clocks = <&tegra_car TEGRA20_CLK_EMC>;
>  		nvidia,memory-controller = <&mc>;
>  		core-supply = <&core_vdd_reg>;
>  		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
> +
> +		emc-stats {
> +			compatible = "nvidia,tegra20-emc-statistics";
> +			operating-points-v2 = <&emc_bw_dfs_opp_table>;
> +			interconnects = <&mc TEGRA20_MC_MPCORER &emc>;
> +			interconnect-names = "cpu";
> +		};
>  	}
>  
>  
> @@ -120,3 +138,22 @@ Properties:
>  						 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>  						 0 0 0 0 >;
>  		};
> +
> +
> +
> +Embedded Memory Controller statistics gathering sub-device
> +
> +EMC statistics subdev gathers information about hardware utilization
> +which is intended to be used for debugging purposes and for dynamic
> +frequency scaling based on the collected stats.
> +
> +Properties:
> +- name : Should be emc-stats.
> +- compatible : Should contain "nvidia,tegra20-emc-statistics".
> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
> +- interconnects: Should contain entries for memory clients sitting on
> +                 MC->EMC memory interconnect path.
> +- interconnect-names: Should include name of the interconnect path for each
> +                      interconnect entry. Consult TRM documentation for
> +                      information about available memory clients, see MEMORY
> +                      CONTROLLER section.
> -- 
> 2.27.0
> 
