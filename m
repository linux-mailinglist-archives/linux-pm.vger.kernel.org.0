Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D6D87D3
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfJPFNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 01:13:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42245 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJPFNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 01:13:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so8424493pgi.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 22:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+Rj9dDSu4Prlbf7aohHd+8lxC4U2wt8p6F4POWRpt8=;
        b=qJMe9z87QwXlwlOeBABdBYMVJvXMNjg8iOqa73HijnEX8AuDrSIp1A6WWgQDbiS4N6
         /xRt5gqnGLLUJHcPK1EHNb9U/G8bv9WDNNUSrfATjZqSf/wuOaI2IuRrlTnneAVlBlSv
         1mW9oCAnlRrsEmfNf6MN0WlqIBhmmWZ5AGgX8hbwka6xRHrormrpqzhVBKVJAWe+G3x2
         uY4R96H4PT8tSdVFYSzTvPCI+QH6rM6n5aLW2OQvvneC2/+hdkygZhj5bKXaOYNKbl0P
         wOu/rnuRHiqokIMAI5B8hAS2jyptFyVjrJYj97V7iq+0/l+iSkdo5WBsotUxB/UC05nf
         m8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+Rj9dDSu4Prlbf7aohHd+8lxC4U2wt8p6F4POWRpt8=;
        b=ME5rI2V5lreaC6PJOsrUEkyjN0vSCWQf7orYTK7M+Up8OJTkNnSu6e5onS8Axu5gSz
         RH91wbAMja6nSJX9UbcNiafmKjCnKXqvNZ7qaGgqKZdVOcmuQ3ziQWWfBupluL8RPyLj
         LAFOQd5dub++j9bjKYoo/OoBKwuRVuiEuHcesHSXJdk42w0SRY5NNptfy02kM1Xa1rOr
         Yct746lFQhRikkfpTA34HSEXcvJ0zMIRKx0lBVmU1u67GM1lMacE1xwZv1k/maEilFzz
         96bExP/q7bKG3c13sNsGE2WYlawx2nxe7KNkOCnhcEcgCgG0y9JtiJaa7gTLrgAzGin9
         boUQ==
X-Gm-Message-State: APjAAAXsRcT7M9YGDPWuvSyalLioyom3bJqbEo+bgSCMKTjTncDBA5+a
        BM9bRDWrlO799Pa960NONtGTmQ==
X-Google-Smtp-Source: APXvYqxuNTGN2Dq2fak0p1ansmU90Xg0vdIQGYqqBDnCMBnDUbyxkrVukendgHwS0p5cV7WGoEEDjw==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr2652941pjs.4.1571202819923;
        Tue, 15 Oct 2019 22:13:39 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id o11sm20085141pgp.13.2019.10.15.22.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 22:13:38 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:43:36 +0530
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
Message-ID: <20191016051336.oeyz56sdh3cae5yn@vireshk-i7>
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

LGTM.

-- 
viresh
