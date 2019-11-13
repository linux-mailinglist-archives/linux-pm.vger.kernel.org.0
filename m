Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274A8FB1E8
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 14:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfKMN50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 08:57:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43684 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKMN5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 08:57:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so2650792ljh.10;
        Wed, 13 Nov 2019 05:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dd8DkIORvL+QLs2iRz7r6c4ippkrhOFQgZqGhUsz2UE=;
        b=TBciHYu83sbNwzrT0mMqbTW5AsBPWo1eiSOqa5j2rrvnri8JL7coLoP6S2kaGHxHDY
         YhFJBZP4KwCWTHlBMevYYG3vy3fdakdQw9IMYJtqWrp8IZ4loJNaukR4I7lvtaDN78hn
         WQk3vPyurU+mjZ4QUFifjKp9kA8vKYe8+UMx290A/gfhWLvrPiVPAoxPhAitd3NwslMe
         9hvFlrfIj/nHLlPXd8Lkib/7B/sfEb6RHi4cQj9dVIagzpTreiPuF2i043KQlL/xwceO
         v0bMtRSHwZofnJOCHiefoVylpMJYhe3WX2SL4/tHwka3M8NAAMzpDeQUfPpW2pgg1IAe
         2Pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dd8DkIORvL+QLs2iRz7r6c4ippkrhOFQgZqGhUsz2UE=;
        b=Y+SfqVN1G5RrezeJL9HE96S7gzCyMyrWtCgwjTNEzGZICOlOrAruQisvl8JDuRZ2IQ
         H1/1bkCI0/TWFfV+mvnWu3hzOgsExH2dGCq0I+9QyBEPpyCI01wAftgxSDDNxWZ+hYK0
         71IzkVlbM8IFqIzX95935NfNECdZ2KfB+PgSwGrsB7iOywYDNz8FCinbIAbEXJSWtl7I
         nLa+pdvb+RQ1SaW2zn8XzaGwxLwWWop7NiaJ5uYbWyCf6dKkpQe8wau80grvYvRpIGd2
         I84b/r4Evf3cglg1CSzv5UjYSLLwCv2SWm5AnbowCXxvRPBt8gk1aAnMardxJfhOifRe
         IR/Q==
X-Gm-Message-State: APjAAAW8f24t/FWGGUuKDUxh87CzHJChBEcURCk5akC0LYvJZiPuxFJc
        A4Ncabh1/a/JNP2dcjy4GPcpgmGb
X-Google-Smtp-Source: APXvYqx2gyFRCOmE2W7LIkKtVfA8HVDq3+zaGrzUjMUttqo8xiM5aMN/5IxKLMsnrcUluee3YibkyQ==
X-Received: by 2002:a05:651c:1127:: with SMTP id e7mr2669748ljo.70.1573653442641;
        Wed, 13 Nov 2019 05:57:22 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id n8sm1093579lfe.31.2019.11.13.05.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 05:57:21 -0800 (PST)
Subject: Re: [PATCH v2 17/17] ARM: dts: tegra30: cardhu-a04: Add CPU Operating
 Performance Points
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191024221416.14197-1-digetx@gmail.com>
 <20191024221416.14197-18-digetx@gmail.com>
 <be6deeff-4294-c945-1539-57ec28b4c895@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8974f1a8-72bb-4413-d2b5-057853696fb4@gmail.com>
Date:   Wed, 13 Nov 2019 16:57:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <be6deeff-4294-c945-1539-57ec28b4c895@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Jon,

13.11.2019 09:52, Jon Hunter пишет:
> 
> On 24/10/2019 23:14, Dmitry Osipenko wrote:
>> Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on
>> cardhu-a04.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/boot/dts/tegra30-cardhu-a04.dts | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>> index 0d71925d4f0b..9234988624ec 100644
>> --- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>> +++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>> @@ -2,6 +2,8 @@
>>  /dts-v1/;
>>  
>>  #include "tegra30-cardhu.dtsi"
>> +#include "tegra30-cpu-opp.dtsi"
>> +#include "tegra30-cpu-opp-microvolt.dtsi"
>>  
>>  /* This dts file support the cardhu A04 and later versions of board */
>>  
>> @@ -127,4 +129,26 @@
>>  			nvidia,tegra-core-regulator;
>>  		};
>>  	};
>> +
>> +	cpus {
>> +		cpu0: cpu@0 {
>> +			cpu-supply = <&vddctrl_reg>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +		};
>> +
>> +		cpu@1 {
>> +			cpu-supply = <&vddctrl_reg>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +		};
>> +
>> +		cpu@2 {
>> +			cpu-supply = <&vddctrl_reg>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +		};
>> +
>> +		cpu@3 {
>> +			cpu-supply = <&vddctrl_reg>;
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +		};
>> +	};
>>  };
> 
> Sorry for not testing this sooner, but this is generating the
> following WARNING on boot ...
> 
> [    2.916019] ------------[ cut here ]------------
> [    2.920669] WARNING: CPU: 2 PID: 1 at /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/opp/of.c:688 _of_add_opp_table_v2.part.2+0x45c/0x4d4
> [    2.933713] Modules linked in:
> [    2.936785] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc7-next-20191112-gfc6d6db1df2c #1
> [    2.945403] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [    2.951706] [<c0112924>] (unwind_backtrace) from [<c010c9d0>] (show_stack+0x10/0x14)
> [    2.959467] [<c010c9d0>] (show_stack) from [<c0aa4494>] (dump_stack+0xc0/0xd4)
> [    2.966707] [<c0aa4494>] (dump_stack) from [<c0124750>] (__warn+0xe0/0xf8)
> [    2.973593] [<c0124750>] (__warn) from [<c0124818>] (warn_slowpath_fmt+0xb0/0xb8)
> [    2.981090] [<c0124818>] (warn_slowpath_fmt) from [<c0754be0>] (_of_add_opp_table_v2.part.2+0x45c/0x4d4)
> [    2.990583] [<c0754be0>] (_of_add_opp_table_v2.part.2) from [<c0754c98>] (dev_pm_opp_of_add_table+0x40/0x15c)
> [    3.000508] [<c0754c98>] (dev_pm_opp_of_add_table) from [<c0754de8>] (dev_pm_opp_of_cpumask_add_table+0x34/0xb4)
> [    3.010704] [<c0754de8>] (dev_pm_opp_of_cpumask_add_table) from [<c075b058>] (cpufreq_init+0xf8/0x2cc)
> [    3.020024] [<c075b058>] (cpufreq_init) from [<c0758758>] (cpufreq_online+0x260/0x824)
> [    3.027953] [<c0758758>] (cpufreq_online) from [<c0758d98>] (cpufreq_add_dev+0x6c/0x78)
> [    3.035976] [<c0758d98>] (cpufreq_add_dev) from [<c05b3188>] (subsys_interface_register+0xa0/0xec)
> [    3.044951] [<c05b3188>] (subsys_interface_register) from [<c07574d4>] (cpufreq_register_driver+0x14c/0x20c)
> [    3.054792] [<c07574d4>] (cpufreq_register_driver) from [<c075aee0>] (dt_cpufreq_probe+0x94/0x114)
> [    3.063771] [<c075aee0>] (dt_cpufreq_probe) from [<c05b6a88>] (platform_drv_probe+0x48/0x98)
> [    3.072225] [<c05b6a88>] (platform_drv_probe) from [<c05b4a38>] (really_probe+0x234/0x34c)
> [    3.080502] [<c05b4a38>] (really_probe) from [<c05b4cc8>] (driver_probe_device+0x60/0x168)
> [    3.088780] [<c05b4cc8>] (driver_probe_device) from [<c05b4f78>] (device_driver_attach+0x58/0x60)
> [    3.097664] [<c05b4f78>] (device_driver_attach) from [<c05b5000>] (__driver_attach+0x80/0xbc)
> [    3.106200] [<c05b5000>] (__driver_attach) from [<c05b2db0>] (bus_for_each_dev+0x74/0xb4)
> [    3.114389] [<c05b2db0>] (bus_for_each_dev) from [<c05b3da4>] (bus_add_driver+0x164/0x1e8)
> [    3.122666] [<c05b3da4>] (bus_add_driver) from [<c05b5b54>] (driver_register+0x7c/0x114)
> [    3.130774] [<c05b5b54>] (driver_register) from [<c010306c>] (do_one_initcall+0x54/0x2a8)
> [    3.138974] [<c010306c>] (do_one_initcall) from [<c0f01040>] (kernel_init_freeable+0x14c/0x1e8)
> [    3.147695] [<c0f01040>] (kernel_init_freeable) from [<c0abbe88>] (kernel_init+0x8/0x10c)
> [    3.155887] [<c0abbe88>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> [    3.163462] Exception stack(0xef0c9fb0 to 0xef0c9ff8)
> [    3.168519] 9fa0:                                     00000000 00000000 00000000 00000000
> [    3.176706] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    3.184893] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    3.191695] ---[ end trace a7dc36f7a4ddbdb2 ]---
> [    3.197855] ------------[ cut here ]------------
> 
> Let me know if you can take a look at this.

The warning happens because Cardhu now has CPU OPPs in the device-tree,
but supported_hw isn't set for the OPPs and thus the count of available
OPPs is 0.

This is expected to happen because patch "cpufreq: tegra20: Use generic
cpufreq-dt driver (Tegra30 supported now)" isn't applied yet.

It is possible to factor out the blacklisting of Tegra SoCs in
cpufreq_dt_platdev_init() into a separate patch and request backporting
of that change in order to avoid the warning noise for older kernel
versions + newer device-tree. Please let me know if you think that it's
worth to do the separation.
