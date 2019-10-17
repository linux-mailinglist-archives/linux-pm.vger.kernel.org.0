Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3569BDA3C7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406977AbfJQCc2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:32:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33192 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407014AbfJQCc1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:32:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so407219pgc.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPAr1Y/6RmmsLEQ10dbAoa3w6mNhq7l8B4FyO36+FNg=;
        b=bANEqDbTdQk9HYMVNTeTQeijBkzkQEDgI/vM8EDRaIJAHyCDzT88KvjeRnxfKGVEQJ
         8wAphIUcOo9MHxknHt6ssKGh9pdSBaGHplHuOFZ4yl3v2RYXratVXrKa6NioyO4GZeet
         FAGgMY2x5adUb8+9KHiMXszAeYyVZZi9eYfnpL3zFjbF/luP+bMQGWeSaESiFDSBvUIF
         svuCq8juseqK7d1ntvF03psEetQ9DzqTSaNhvk1WdbKWj4nH7bZ+olNAVGUNUSvjByMf
         ggikUfF3dPv4hZ4EuGcZBedEur7sCnsZnBA3L4OTYRKFcFfDou+bCXkFIriXWnv8t1hF
         NP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPAr1Y/6RmmsLEQ10dbAoa3w6mNhq7l8B4FyO36+FNg=;
        b=uXjkNK+wagdWmxNJY6GQ6UrgIFTKBAlbl+OKIJZN4IUSFj99Hl30PdYQtwhpNDlVZX
         t/DVN9kphMaSQAmeqJxFjMtvYO7VtGaYxQ4HbpQ7HByuPYwBx4LOZNSIuM0rdYifPFP8
         vuupjER/U7ExqOFgqaOoAvi5uCAZ0UXO9bqjIEGT8Z1qnEE6w3aAwTL5R0M8P5udsknU
         OGectdiv6uNcBEW2sHcjSJaQ+yeDuRtf5oDMxoEgJW81GVEk6zCihTlhob9aOu8B3u/K
         wHbpB/x0h/UDnq6n1DrK4/wJLo7tCvHYkYdGyNAXfdhLOBqI+eZ+UKze6JtnYane4LG/
         ZvGg==
X-Gm-Message-State: APjAAAW/KtQljwh18lxC2uelqtTD/GZPApxQCByEpG/QiawUfD48wUZl
        +vaWB/Uvhy1EnUGntmcq1SivXw==
X-Google-Smtp-Source: APXvYqz5shTMozOO+le27yYCcEjZyQNN1/1kuVMtaMcV30IXLdT/kFc0mJ/04wjSjLtPONjZzySKIA==
X-Received: by 2002:a63:18d:: with SMTP id 135mr1472362pgb.326.1571279545065;
        Wed, 16 Oct 2019 19:32:25 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id n66sm517724pfn.90.2019.10.16.19.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:32:24 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:02:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/17] dt-bindings: cpufreq: Add binding for NVIDIA
 Tegra20/30
Message-ID: <20191017023222.krufquqemad4kmbv@vireshk-i7>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015211618.20758-7-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 00:16, Dmitry Osipenko wrote:
> Add device-tree binding that describes CPU frequency-scaling hardware
> found on NVIDIA Tegra20/30 SoCs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> new file mode 100644
> index 000000000000..daeca6ae6b76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
> @@ -0,0 +1,56 @@
> +Binding for NVIDIA Tegra20 CPUFreq
> +==================================
> +
> +Required properties:
> +- clocks: Must contain an entry for the CPU clock.
> +  See ../clocks/clock-bindings.txt for details.
> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
> +- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
> +
> +For each opp entry in 'operating-points-v2' table:
> +- opp-supported-hw: Two bitfields indicating:
> +	On Tegra20:
> +	1. CPU process ID mask
> +	2. SoC speedo ID mask
> +
> +	On Tegra30:
> +	1. CPU process ID mask
> +	2. CPU speedo ID mask
> +
> +	A bitwise AND is performed against these values and if any bit
> +	matches, the OPP gets enabled.
> +
> +- opp-microvolt: CPU voltage triplet.
> +
> +Optional properties:
> +- cpu-supply: Phandle to the CPU power supply.
> +
> +Example:
> +	regulators {
> +		cpu_reg: regulator0 {
> +			regulator-name = "vdd_cpu";
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +
> +		opp@456000000 {
> +			clock-latency-ns = <125000>;
> +			opp-microvolt = <825000 825000 1125000>;
> +			opp-supported-hw = <0x03 0x0001>;
> +			opp-hz = /bits/ 64 <456000000>;
> +		};
> +
> +		...
> +	};
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,cortex-a9";
> +			clocks = <&tegra_car TEGRA20_CLK_CCLK>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			cpu-supply = <&cpu_reg>;
> +			#cooling-cells = <2>;
> +		};
> +	};

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
