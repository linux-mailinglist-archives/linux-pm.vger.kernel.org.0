Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77070FE097
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfKOOzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 09:55:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41898 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfKOOzi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 09:55:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so8220439lfb.8;
        Fri, 15 Nov 2019 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wVQxG2BiztzSwM3KfGoVbwyCoQTakGKYV/pOVNlceF8=;
        b=j29J5gGEaIVTPS5bGn1MxfaTslEQCSW3ATpaV4k8wS0CrD/IJrjIoG2UNl71tyxNR6
         rmelP856C9QaKbYUOeBGHx7PvToYTeXT7fqTO0mpV8YU1jNLcUGdlJc4v0YdZevDqNsA
         ct6UBWHN5iVfuxv46A/rPOx915BFf9lF1pg8UWxVi8S+86UNOyPB6P7DT/GC4Nm2q5lt
         ELypeOyLknBzik2qBYBbRZ6vCdzUAMeolNew1GKEuGKF3hChMqXCWAuTo7c7n6E19cUD
         ylo4PISrD/u9ONGfRAOHsBhoOZM/QpIPm/2baJ8PmBCpFAVWVENiu0T107yGQ0lniKVX
         cAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wVQxG2BiztzSwM3KfGoVbwyCoQTakGKYV/pOVNlceF8=;
        b=YPtF+cO80J1MWxoWSfFYNIonxhi782F8YZJl6dJE80gYubX7aLmc6w3BZs56MCngWX
         amuqaMT0P9cYo4tFks69EQWREa5fjB5RDcpqmlr9pIapOedD0NnL5SxyvKEJEzZfYyxp
         cn/g95FEBN5evnPsJbq3i9BzeDwkQtlivdIdyn1yq2S8RBTQkpY9rYunCFmMcwdTjU9v
         yl/LUV2V9+vn+60pcN6lMaqokZ02vQ8c3R2L697Y2A2ZikUZd0BjjgNBpBeYs1lkY7NR
         y+NGnzq7OXhG1N+4m7vzTJEupaDKt03+/bUjKW5MGBGWkpXMxYB7X/4e/mxZbS6MetE/
         /G7w==
X-Gm-Message-State: APjAAAVFQ3A8KYsOpc8r5VG72P/XGyr3xAxUTUDqNoLBAHDnEY5n9Lng
        C2QxC+G18dqTOt9ulAoYkwU3IT5P
X-Google-Smtp-Source: APXvYqyfur8KS1xDBSUOk2QlmzXkp9gX3Ajdg4HgB/ZKMUnw1DlVzYbWwK77C+HNTM0D46A/oU2+cA==
X-Received: by 2002:a19:8092:: with SMTP id b140mr11428544lfd.13.1573829735117;
        Fri, 15 Nov 2019 06:55:35 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id r4sm3989537ljn.64.2019.11.15.06.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:55:34 -0800 (PST)
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
 <8974f1a8-72bb-4413-d2b5-057853696fb4@gmail.com>
 <ef22b044-2bc1-1fdc-97cb-f9b036d3d5a9@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <15962ea4-20a8-0bf9-6982-f94123b9a324@gmail.com>
Date:   Fri, 15 Nov 2019 17:55:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ef22b044-2bc1-1fdc-97cb-f9b036d3d5a9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.11.2019 15:52, Jon Hunter пишет:
> 
> On 13/11/2019 13:57, Dmitry Osipenko wrote:
>> Hello Jon,
>>
>> 13.11.2019 09:52, Jon Hunter пишет:
>>>
>>> On 24/10/2019 23:14, Dmitry Osipenko wrote:
>>>> Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on
>>>> cardhu-a04.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/tegra30-cardhu-a04.dts | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>> index 0d71925d4f0b..9234988624ec 100644
>>>> --- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>> +++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>> @@ -2,6 +2,8 @@
>>>>  /dts-v1/;
>>>>  
>>>>  #include "tegra30-cardhu.dtsi"
>>>> +#include "tegra30-cpu-opp.dtsi"
>>>> +#include "tegra30-cpu-opp-microvolt.dtsi"
>>>>  
>>>>  /* This dts file support the cardhu A04 and later versions of board */
>>>>  
>>>> @@ -127,4 +129,26 @@
>>>>  			nvidia,tegra-core-regulator;
>>>>  		};
>>>>  	};
>>>> +
>>>> +	cpus {
>>>> +		cpu0: cpu@0 {
>>>> +			cpu-supply = <&vddctrl_reg>;
>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>> +		};
>>>> +
>>>> +		cpu@1 {
>>>> +			cpu-supply = <&vddctrl_reg>;
>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>> +		};
>>>> +
>>>> +		cpu@2 {
>>>> +			cpu-supply = <&vddctrl_reg>;
>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>> +		};
>>>> +
>>>> +		cpu@3 {
>>>> +			cpu-supply = <&vddctrl_reg>;
>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>> +		};
>>>> +	};
>>>>  };
>>>
>>> Sorry for not testing this sooner, but this is generating the
>>> following WARNING on boot ...
>>>
>>> [    2.916019] ------------[ cut here ]------------
>>> [    2.920669] WARNING: CPU: 2 PID: 1 at /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/opp/of.c:688 _of_add_opp_table_v2.part.2+0x45c/0x4d4
>>> [    2.933713] Modules linked in:
>>> [    2.936785] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc7-next-20191112-gfc6d6db1df2c #1
>>> [    2.945403] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>> [    2.951706] [<c0112924>] (unwind_backtrace) from [<c010c9d0>] (show_stack+0x10/0x14)
>>> [    2.959467] [<c010c9d0>] (show_stack) from [<c0aa4494>] (dump_stack+0xc0/0xd4)
>>> [    2.966707] [<c0aa4494>] (dump_stack) from [<c0124750>] (__warn+0xe0/0xf8)
>>> [    2.973593] [<c0124750>] (__warn) from [<c0124818>] (warn_slowpath_fmt+0xb0/0xb8)
>>> [    2.981090] [<c0124818>] (warn_slowpath_fmt) from [<c0754be0>] (_of_add_opp_table_v2.part.2+0x45c/0x4d4)
>>> [    2.990583] [<c0754be0>] (_of_add_opp_table_v2.part.2) from [<c0754c98>] (dev_pm_opp_of_add_table+0x40/0x15c)
>>> [    3.000508] [<c0754c98>] (dev_pm_opp_of_add_table) from [<c0754de8>] (dev_pm_opp_of_cpumask_add_table+0x34/0xb4)
>>> [    3.010704] [<c0754de8>] (dev_pm_opp_of_cpumask_add_table) from [<c075b058>] (cpufreq_init+0xf8/0x2cc)
>>> [    3.020024] [<c075b058>] (cpufreq_init) from [<c0758758>] (cpufreq_online+0x260/0x824)
>>> [    3.027953] [<c0758758>] (cpufreq_online) from [<c0758d98>] (cpufreq_add_dev+0x6c/0x78)
>>> [    3.035976] [<c0758d98>] (cpufreq_add_dev) from [<c05b3188>] (subsys_interface_register+0xa0/0xec)
>>> [    3.044951] [<c05b3188>] (subsys_interface_register) from [<c07574d4>] (cpufreq_register_driver+0x14c/0x20c)
>>> [    3.054792] [<c07574d4>] (cpufreq_register_driver) from [<c075aee0>] (dt_cpufreq_probe+0x94/0x114)
>>> [    3.063771] [<c075aee0>] (dt_cpufreq_probe) from [<c05b6a88>] (platform_drv_probe+0x48/0x98)
>>> [    3.072225] [<c05b6a88>] (platform_drv_probe) from [<c05b4a38>] (really_probe+0x234/0x34c)
>>> [    3.080502] [<c05b4a38>] (really_probe) from [<c05b4cc8>] (driver_probe_device+0x60/0x168)
>>> [    3.088780] [<c05b4cc8>] (driver_probe_device) from [<c05b4f78>] (device_driver_attach+0x58/0x60)
>>> [    3.097664] [<c05b4f78>] (device_driver_attach) from [<c05b5000>] (__driver_attach+0x80/0xbc)
>>> [    3.106200] [<c05b5000>] (__driver_attach) from [<c05b2db0>] (bus_for_each_dev+0x74/0xb4)
>>> [    3.114389] [<c05b2db0>] (bus_for_each_dev) from [<c05b3da4>] (bus_add_driver+0x164/0x1e8)
>>> [    3.122666] [<c05b3da4>] (bus_add_driver) from [<c05b5b54>] (driver_register+0x7c/0x114)
>>> [    3.130774] [<c05b5b54>] (driver_register) from [<c010306c>] (do_one_initcall+0x54/0x2a8)
>>> [    3.138974] [<c010306c>] (do_one_initcall) from [<c0f01040>] (kernel_init_freeable+0x14c/0x1e8)
>>> [    3.147695] [<c0f01040>] (kernel_init_freeable) from [<c0abbe88>] (kernel_init+0x8/0x10c)
>>> [    3.155887] [<c0abbe88>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>>> [    3.163462] Exception stack(0xef0c9fb0 to 0xef0c9ff8)
>>> [    3.168519] 9fa0:                                     00000000 00000000 00000000 00000000
>>> [    3.176706] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [    3.184893] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>> [    3.191695] ---[ end trace a7dc36f7a4ddbdb2 ]---
>>> [    3.197855] ------------[ cut here ]------------
>>>
>>> Let me know if you can take a look at this.
>>
>> The warning happens because Cardhu now has CPU OPPs in the device-tree,
>> but supported_hw isn't set for the OPPs and thus the count of available
>> OPPs is 0.
>>
>> This is expected to happen because patch "cpufreq: tegra20: Use generic
>> cpufreq-dt driver (Tegra30 supported now)" isn't applied yet.
>>
>> It is possible to factor out the blacklisting of Tegra SoCs in
>> cpufreq_dt_platdev_init() into a separate patch and request backporting
>> of that change in order to avoid the warning noise for older kernel
>> versions + newer device-tree. Please let me know if you think that it's
>> worth to do the separation.
> 
> Unfortunately, I think we are going to need to drop this patch. Booting
> Tegra30-cardhu-a04 with Thierry's for-5.5/arm/dt branch does not even
> boot. There is no crash log but it hangs on boot. This patch appears to
> be the culprit. What is odd is that Tegra30-cardhu-a04 boots fine with
> Thierry's for-next branch which includes this. However, this is causing
> lots of bisect problems. Updating the DT shouldn't break the boot.
The diff between "for-5.5/arm/dt" and "for-next" is quite small, you
only need to try to revert one or two patches. Seems the only major
change which could be somehow related to CPUFreq is that
"for-5.5/arm/dt" doesn't have regulators coupling support, but I don't
see how it could cause any effect since CPUFreq just doesn't load due to
a missing setup of supported_hw.

Unfortunately for now I can't reproduce the hang with a similar setup
that has OPPs in DT, doesn't have Tegra CPUFreq driver, doesn't
blacklist Tegra in cpufreq-dt-platdev.c and doesn't have regulators
coupling. I see the warning splats on boot and everything appears to be
working fine.

It's likely that the hang is caused by something else than this patch.
It's also a bit odd that you're accusing this patch while apparently it
worked a day before.

Please give a try to the recent upstream linux-next. If it works, then
probably there is nothing to worry about.

I'll factor out the blacklisting change and add it as a separate patch
into the next revision of the series, marking the patch as "fixes" and
"stable" in order to get rid of the warning on stable kernels.

I'm also fine with reverting of the DT changes for now, if you prefer
that. But again, this DT change shouldn't cause any critical problems.

I need a detailed report or a way to reproduce the problem in order to
solve it, please try to collect some more details. Try to compile the
cpufreq-dt driver as a loadable module, enable tracing of clk and
regulator events (tp_printk
trace_event=regulator_set_voltage,clk_set_rate,clk_set_parent).
