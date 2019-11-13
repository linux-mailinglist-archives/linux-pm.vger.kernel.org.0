Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3364AFAA73
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 07:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKMGwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 01:52:35 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6574 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfKMGwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 01:52:35 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcba8330000>; Tue, 12 Nov 2019 22:52:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 22:52:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 12 Nov 2019 22:52:32 -0800
Received: from [10.26.11.32] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 06:52:28 +0000
Subject: Re: [PATCH v2 17/17] ARM: dts: tegra30: cardhu-a04: Add CPU Operating
 Performance Points
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191024221416.14197-1-digetx@gmail.com>
 <20191024221416.14197-18-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <be6deeff-4294-c945-1539-57ec28b4c895@nvidia.com>
Date:   Wed, 13 Nov 2019 06:52:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024221416.14197-18-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573627955; bh=hAPd6vZThQ+ICA6jEK3O0xPM/BMVXTDWmnPp5G7Fimo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fhiVEHHuUlKQKh/SUp1f/FV3Xb5BTTUjeEXDPAVhN/qeRYd9N9K/67RobSEmkLjz5
         XkO7RqKkw7Hs0jhpoUR+HveNbzjc1n6pWq5+5LTpB7wEc0ACXmmvggfrLr3Pg/ylaM
         mjzHneb86evOmfocAm5KFSznU7P4cqdRLzmlbSaDUbG84jESguezC91jfdOdYpjcpz
         3ncYu1EIDrooxG64vcK5c0HJLSuuBf0v2Ij8gtdvkUym9PxEw4dwOy4B1qaRGw4Iul
         fdtk9lPqpLKuTFFfDqJkZS4dmLbdEXRQKQTM87y2o9s3u2rGUiIs0IgYizDwCFbGM7
         8VgFqu2OvT3rQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 24/10/2019 23:14, Dmitry Osipenko wrote:
> Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on
> cardhu-a04.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30-cardhu-a04.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
> index 0d71925d4f0b..9234988624ec 100644
> --- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
> +++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
> @@ -2,6 +2,8 @@
>  /dts-v1/;
>  
>  #include "tegra30-cardhu.dtsi"
> +#include "tegra30-cpu-opp.dtsi"
> +#include "tegra30-cpu-opp-microvolt.dtsi"
>  
>  /* This dts file support the cardhu A04 and later versions of board */
>  
> @@ -127,4 +129,26 @@
>  			nvidia,tegra-core-regulator;
>  		};
>  	};
> +
> +	cpus {
> +		cpu0: cpu@0 {
> +			cpu-supply = <&vddctrl_reg>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +
> +		cpu@1 {
> +			cpu-supply = <&vddctrl_reg>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +
> +		cpu@2 {
> +			cpu-supply = <&vddctrl_reg>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +
> +		cpu@3 {
> +			cpu-supply = <&vddctrl_reg>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +	};
>  };

Sorry for not testing this sooner, but this is generating the
following WARNING on boot ...

[    2.916019] ------------[ cut here ]------------
[    2.920669] WARNING: CPU: 2 PID: 1 at /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/opp/of.c:688 _of_add_opp_table_v2.part.2+0x45c/0x4d4
[    2.933713] Modules linked in:
[    2.936785] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc7-next-20191112-gfc6d6db1df2c #1
[    2.945403] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    2.951706] [<c0112924>] (unwind_backtrace) from [<c010c9d0>] (show_stack+0x10/0x14)
[    2.959467] [<c010c9d0>] (show_stack) from [<c0aa4494>] (dump_stack+0xc0/0xd4)
[    2.966707] [<c0aa4494>] (dump_stack) from [<c0124750>] (__warn+0xe0/0xf8)
[    2.973593] [<c0124750>] (__warn) from [<c0124818>] (warn_slowpath_fmt+0xb0/0xb8)
[    2.981090] [<c0124818>] (warn_slowpath_fmt) from [<c0754be0>] (_of_add_opp_table_v2.part.2+0x45c/0x4d4)
[    2.990583] [<c0754be0>] (_of_add_opp_table_v2.part.2) from [<c0754c98>] (dev_pm_opp_of_add_table+0x40/0x15c)
[    3.000508] [<c0754c98>] (dev_pm_opp_of_add_table) from [<c0754de8>] (dev_pm_opp_of_cpumask_add_table+0x34/0xb4)
[    3.010704] [<c0754de8>] (dev_pm_opp_of_cpumask_add_table) from [<c075b058>] (cpufreq_init+0xf8/0x2cc)
[    3.020024] [<c075b058>] (cpufreq_init) from [<c0758758>] (cpufreq_online+0x260/0x824)
[    3.027953] [<c0758758>] (cpufreq_online) from [<c0758d98>] (cpufreq_add_dev+0x6c/0x78)
[    3.035976] [<c0758d98>] (cpufreq_add_dev) from [<c05b3188>] (subsys_interface_register+0xa0/0xec)
[    3.044951] [<c05b3188>] (subsys_interface_register) from [<c07574d4>] (cpufreq_register_driver+0x14c/0x20c)
[    3.054792] [<c07574d4>] (cpufreq_register_driver) from [<c075aee0>] (dt_cpufreq_probe+0x94/0x114)
[    3.063771] [<c075aee0>] (dt_cpufreq_probe) from [<c05b6a88>] (platform_drv_probe+0x48/0x98)
[    3.072225] [<c05b6a88>] (platform_drv_probe) from [<c05b4a38>] (really_probe+0x234/0x34c)
[    3.080502] [<c05b4a38>] (really_probe) from [<c05b4cc8>] (driver_probe_device+0x60/0x168)
[    3.088780] [<c05b4cc8>] (driver_probe_device) from [<c05b4f78>] (device_driver_attach+0x58/0x60)
[    3.097664] [<c05b4f78>] (device_driver_attach) from [<c05b5000>] (__driver_attach+0x80/0xbc)
[    3.106200] [<c05b5000>] (__driver_attach) from [<c05b2db0>] (bus_for_each_dev+0x74/0xb4)
[    3.114389] [<c05b2db0>] (bus_for_each_dev) from [<c05b3da4>] (bus_add_driver+0x164/0x1e8)
[    3.122666] [<c05b3da4>] (bus_add_driver) from [<c05b5b54>] (driver_register+0x7c/0x114)
[    3.130774] [<c05b5b54>] (driver_register) from [<c010306c>] (do_one_initcall+0x54/0x2a8)
[    3.138974] [<c010306c>] (do_one_initcall) from [<c0f01040>] (kernel_init_freeable+0x14c/0x1e8)
[    3.147695] [<c0f01040>] (kernel_init_freeable) from [<c0abbe88>] (kernel_init+0x8/0x10c)
[    3.155887] [<c0abbe88>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    3.163462] Exception stack(0xef0c9fb0 to 0xef0c9ff8)
[    3.168519] 9fa0:                                     00000000 00000000 00000000 00000000
[    3.176706] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.184893] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    3.191695] ---[ end trace a7dc36f7a4ddbdb2 ]---
[    3.197855] ------------[ cut here ]------------

Let me know if you can take a look at this.

Thanks
Jon

-- 
nvpublic
