Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730BDFE675
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKOUfu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 15:35:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45004 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKOUfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 15:35:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so12008702ljl.11;
        Fri, 15 Nov 2019 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WX0u1CfTjofYqW+ubHV1k4l4VhbWnz6PDgd2OjHd50k=;
        b=YS93PWbB565EP4Nhw9+ybZidhLpt6UdDohW/cfSsOmeNjo0+mxsobfPfJ0rjFG9JNT
         8ei2Zv9dOK1Sc9B6OpweDpVH+tWceRMKtzBoK0Bng/xyP4MogYp36a61BjfujDphm2Jp
         2zLWb//RUDTWECHs8Wr6La25B8KjzSOwivFj1orL6CgssW4lDyYJUbHkvN2k4EbSyBe5
         aN2Dg5Up2Wd7ZPVuwNHh8MKZ9ATxgWUGGQ4BbAn6h1SVdEnsufLpYRa4lwsU83HrtVil
         IMTmpZeCwXqrqkl+CrAseuCEThfInYKlt+TJugJR4hvg5uFPl4GJuE8ej5SISoNJgHrV
         qOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WX0u1CfTjofYqW+ubHV1k4l4VhbWnz6PDgd2OjHd50k=;
        b=cVrLZmoLobcG0lDexWKGwja97waSfWvvJHB3cuScl3E+QOUGrp0lIzU/I2ArDBVwMM
         wRO4WT17pl7qYg0m+yTKP4Lm/hB6iZLwNRlO+M4Rdr1gjQAIv2aZPTPTh6ClYMcaIBA8
         XexrGQGJUvLUM7STgkKpo9NKVE3y7sbvXrWJdHEkWPCy+A6iJIm3WZSrhCsGmiyou80W
         y7nDhcVRoXnMfgkoUZNmZ7rGV7UrwtjaTuUAx4TFUIQpG8pnqHJijtP7H4XznFueStkD
         uX+zoApKUWh4GHCcVlw6uUDmJ+7u75QnUGp7ka8vsAshhwPuq+0Nit5e787EnogmTcse
         eRvA==
X-Gm-Message-State: APjAAAVb14fY7dtb/RgTrzmkHU4zpuNfPE9r+a2qX+m9m6ysFTSMoZZ6
        VRX2yT9nQYpPTgSAcwttKhSgT6SJ
X-Google-Smtp-Source: APXvYqxRWRrwTK/e3B9IxYdwftFP2nC5MExjpBxmLMljj/tXxhzBFzq7pdxsl/Klhlcl/BWYuUlYkg==
X-Received: by 2002:a2e:7016:: with SMTP id l22mr12651762ljc.227.1573850145987;
        Fri, 15 Nov 2019 12:35:45 -0800 (PST)
Received: from [192.168.2.145] (79-139-238-227.dynamic.spd-mgts.ru. [79.139.238.227])
        by smtp.googlemail.com with ESMTPSA id x19sm4885265ljh.14.2019.11.15.12.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 12:35:45 -0800 (PST)
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
 <15962ea4-20a8-0bf9-6982-f94123b9a324@gmail.com>
 <fb196514-bcde-deb0-32fc-35344fa33f66@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <84180062-014d-f06a-b0fb-994fe52f77d7@gmail.com>
Date:   Fri, 15 Nov 2019 23:35:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fb196514-bcde-deb0-32fc-35344fa33f66@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.11.2019 20:31, Jon Hunter пишет:
> 
> 
> On 15/11/2019 14:55, Dmitry Osipenko wrote:
>> 15.11.2019 15:52, Jon Hunter пишет:
>>>
>>> On 13/11/2019 13:57, Dmitry Osipenko wrote:
>>>> Hello Jon,
>>>>
>>>> 13.11.2019 09:52, Jon Hunter пишет:
>>>>>
>>>>> On 24/10/2019 23:14, Dmitry Osipenko wrote:
>>>>>> Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on
>>>>>> cardhu-a04.
>>>>>>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/tegra30-cardhu-a04.dts | 24 ++++++++++++++++++++++++
>>>>>>  1 file changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>>>> index 0d71925d4f0b..9234988624ec 100644
>>>>>> --- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>>>> +++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>>>> @@ -2,6 +2,8 @@
>>>>>>  /dts-v1/;
>>>>>>  
>>>>>>  #include "tegra30-cardhu.dtsi"
>>>>>> +#include "tegra30-cpu-opp.dtsi"
>>>>>> +#include "tegra30-cpu-opp-microvolt.dtsi"
>>>>>>  
>>>>>>  /* This dts file support the cardhu A04 and later versions of board */
>>>>>>  
>>>>>> @@ -127,4 +129,26 @@
>>>>>>  			nvidia,tegra-core-regulator;
>>>>>>  		};
>>>>>>  	};
>>>>>> +
>>>>>> +	cpus {
>>>>>> +		cpu0: cpu@0 {
>>>>>> +			cpu-supply = <&vddctrl_reg>;
>>>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>>>> +		};
>>>>>> +
>>>>>> +		cpu@1 {
>>>>>> +			cpu-supply = <&vddctrl_reg>;
>>>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>>>> +		};
>>>>>> +
>>>>>> +		cpu@2 {
>>>>>> +			cpu-supply = <&vddctrl_reg>;
>>>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>>>> +		};
>>>>>> +
>>>>>> +		cpu@3 {
>>>>>> +			cpu-supply = <&vddctrl_reg>;
>>>>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>>>>> +		};
>>>>>> +	};
>>>>>>  };
>>>>>
>>>>> Sorry for not testing this sooner, but this is generating the
>>>>> following WARNING on boot ...
>>>>>
>>>>> [    2.916019] ------------[ cut here ]------------
>>>>> [    2.920669] WARNING: CPU: 2 PID: 1 at /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/opp/of.c:688 _of_add_opp_table_v2.part.2+0x45c/0x4d4
>>>>> [    2.933713] Modules linked in:
>>>>> [    2.936785] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc7-next-20191112-gfc6d6db1df2c #1
>>>>> [    2.945403] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>>>> [    2.951706] [<c0112924>] (unwind_backtrace) from [<c010c9d0>] (show_stack+0x10/0x14)
>>>>> [    2.959467] [<c010c9d0>] (show_stack) from [<c0aa4494>] (dump_stack+0xc0/0xd4)
>>>>> [    2.966707] [<c0aa4494>] (dump_stack) from [<c0124750>] (__warn+0xe0/0xf8)
>>>>> [    2.973593] [<c0124750>] (__warn) from [<c0124818>] (warn_slowpath_fmt+0xb0/0xb8)
>>>>> [    2.981090] [<c0124818>] (warn_slowpath_fmt) from [<c0754be0>] (_of_add_opp_table_v2.part.2+0x45c/0x4d4)
>>>>> [    2.990583] [<c0754be0>] (_of_add_opp_table_v2.part.2) from [<c0754c98>] (dev_pm_opp_of_add_table+0x40/0x15c)
>>>>> [    3.000508] [<c0754c98>] (dev_pm_opp_of_add_table) from [<c0754de8>] (dev_pm_opp_of_cpumask_add_table+0x34/0xb4)
>>>>> [    3.010704] [<c0754de8>] (dev_pm_opp_of_cpumask_add_table) from [<c075b058>] (cpufreq_init+0xf8/0x2cc)
>>>>> [    3.020024] [<c075b058>] (cpufreq_init) from [<c0758758>] (cpufreq_online+0x260/0x824)
>>>>> [    3.027953] [<c0758758>] (cpufreq_online) from [<c0758d98>] (cpufreq_add_dev+0x6c/0x78)
>>>>> [    3.035976] [<c0758d98>] (cpufreq_add_dev) from [<c05b3188>] (subsys_interface_register+0xa0/0xec)
>>>>> [    3.044951] [<c05b3188>] (subsys_interface_register) from [<c07574d4>] (cpufreq_register_driver+0x14c/0x20c)
>>>>> [    3.054792] [<c07574d4>] (cpufreq_register_driver) from [<c075aee0>] (dt_cpufreq_probe+0x94/0x114)
>>>>> [    3.063771] [<c075aee0>] (dt_cpufreq_probe) from [<c05b6a88>] (platform_drv_probe+0x48/0x98)
>>>>> [    3.072225] [<c05b6a88>] (platform_drv_probe) from [<c05b4a38>] (really_probe+0x234/0x34c)
>>>>> [    3.080502] [<c05b4a38>] (really_probe) from [<c05b4cc8>] (driver_probe_device+0x60/0x168)
>>>>> [    3.088780] [<c05b4cc8>] (driver_probe_device) from [<c05b4f78>] (device_driver_attach+0x58/0x60)
>>>>> [    3.097664] [<c05b4f78>] (device_driver_attach) from [<c05b5000>] (__driver_attach+0x80/0xbc)
>>>>> [    3.106200] [<c05b5000>] (__driver_attach) from [<c05b2db0>] (bus_for_each_dev+0x74/0xb4)
>>>>> [    3.114389] [<c05b2db0>] (bus_for_each_dev) from [<c05b3da4>] (bus_add_driver+0x164/0x1e8)
>>>>> [    3.122666] [<c05b3da4>] (bus_add_driver) from [<c05b5b54>] (driver_register+0x7c/0x114)
>>>>> [    3.130774] [<c05b5b54>] (driver_register) from [<c010306c>] (do_one_initcall+0x54/0x2a8)
>>>>> [    3.138974] [<c010306c>] (do_one_initcall) from [<c0f01040>] (kernel_init_freeable+0x14c/0x1e8)
>>>>> [    3.147695] [<c0f01040>] (kernel_init_freeable) from [<c0abbe88>] (kernel_init+0x8/0x10c)
>>>>> [    3.155887] [<c0abbe88>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>>>>> [    3.163462] Exception stack(0xef0c9fb0 to 0xef0c9ff8)
>>>>> [    3.168519] 9fa0:                                     00000000 00000000 00000000 00000000
>>>>> [    3.176706] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>>>> [    3.184893] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>>>> [    3.191695] ---[ end trace a7dc36f7a4ddbdb2 ]---
>>>>> [    3.197855] ------------[ cut here ]------------
>>>>>
>>>>> Let me know if you can take a look at this.
>>>>
>>>> The warning happens because Cardhu now has CPU OPPs in the device-tree,
>>>> but supported_hw isn't set for the OPPs and thus the count of available
>>>> OPPs is 0.
>>>>
>>>> This is expected to happen because patch "cpufreq: tegra20: Use generic
>>>> cpufreq-dt driver (Tegra30 supported now)" isn't applied yet.
>>>>
>>>> It is possible to factor out the blacklisting of Tegra SoCs in
>>>> cpufreq_dt_platdev_init() into a separate patch and request backporting
>>>> of that change in order to avoid the warning noise for older kernel
>>>> versions + newer device-tree. Please let me know if you think that it's
>>>> worth to do the separation.
>>>
>>> Unfortunately, I think we are going to need to drop this patch. Booting
>>> Tegra30-cardhu-a04 with Thierry's for-5.5/arm/dt branch does not even
>>> boot. There is no crash log but it hangs on boot. This patch appears to
>>> be the culprit. What is odd is that Tegra30-cardhu-a04 boots fine with
>>> Thierry's for-next branch which includes this. However, this is causing
>>> lots of bisect problems. Updating the DT shouldn't break the boot.
>> The diff between "for-5.5/arm/dt" and "for-next" is quite small, you
>> only need to try to revert one or two patches. Seems the only major
>> change which could be somehow related to CPUFreq is that
>> "for-5.5/arm/dt" doesn't have regulators coupling support, but I don't
>> see how it could cause any effect since CPUFreq just doesn't load due to
>> a missing setup of supported_hw.
>>
>> Unfortunately for now I can't reproduce the hang with a similar setup
>> that has OPPs in DT, doesn't have Tegra CPUFreq driver, doesn't
>> blacklist Tegra in cpufreq-dt-platdev.c and doesn't have regulators
>> coupling. I see the warning splats on boot and everything appears to be
>> working fine.
>>
>> It's likely that the hang is caused by something else than this patch.
> 
> No, it is definitely this patch. 100% reproducible.
> 
>> It's also a bit odd that you're accusing this patch while apparently it
>> worked a day before.
> 
> No, the behaviour on top of -next is different to the "for-5.5/arm/dt"
> branch, which is what I am saying.
> 
>> Please give a try to the recent upstream linux-next. If it works, then
>> probably there is nothing to worry about.
> 
> No, there is plenty to be concerned about, with the latest -next we are
> getting these WARN splats on boot, which we need to avoid.
> 
>> I'll factor out the blacklisting change and add it as a separate patch
>> into the next revision of the series, marking the patch as "fixes" and
>> "stable" in order to get rid of the warning on stable kernels.
>>
>> I'm also fine with reverting of the DT changes for now, if you prefer
>> that. But again, this DT change shouldn't cause any critical problems.
> 
> No it should not, but it does.
> 
>> I need a detailed report or a way to reproduce the problem in order to
>> solve it, please try to collect some more details. Try to compile the
>> cpufreq-dt driver as a loadable module, enable tracing of clk and
>> regulator events (tp_printk
>> trace_event=regulator_set_voltage,clk_set_rate,clk_set_parent).
> 
> I add some debug prints and on boot with "for-5.5/arm/dt" is dies while
> bringing CPU0 online for cpufreq ...
> 
> [    2.863369] cpufreq_dt: dt_cpufreq_probe-347
> [    2.867917] cpufreq_dt: dt_cpufreq_probe-360
> [    2.872195] cpufreq_dt: dt_cpufreq_probe-370
> [    2.876509] cpufreq: cpufreq_register_driver-2632
> [    2.881219] cpufreq: cpufreq_register_driver-2636
> [    2.885989] cpufreq: trying to register driver cpufreq-dt
> [    2.891395] cpufreq: cpufreq_register_driver-2651
> [    2.896131] cpufreq: cpufreq_register_driver-2661
> [    2.900839] cpufreq: cpufreq_register_driver-2665
> [    2.905610] cpufreq: cpufreq_register_driver-2672
> [    2.910329] cpu cpu0: cpufreq_add_dev: adding CPU0
> [    2.915152] cpufreq: cpufreq_online: bringing CPU0 online
> 
> So I think it is best to revert this for now.

I managed to reproduced the problem using unmodified "for-5.5/arm/dt":

 # modprobe cpufreq-dt

[   41.002512] regulator_set_voltage: name=vdd_core (1100000-1350000)
[   41.007822] regulator_set_voltage: name=vdd_core (1000000-1350000)
[   41.012475] regulator_set_voltage: name=vdd_cpu (925000-1250000)
[   41.017299] regulator_set_voltage: name=vdd_cpu (825000-1250000)
[   41.021842] regulator_set_voltage: name=vdd_core (950000-1350000)
[   41.025399] regulator_set_voltage: name=vdd_cpu (800000-1250000)

As you can see the voltage drops too much and I know what causes it. The
OPP core was getting some fixes recently, while "for-5.5/arm/dt" uses
older 5.4-rc1 as the base. The problem was introduced in 5.4-rc1 and
then it was fixed by the commit [1] in 5.4-rc5.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/opp?h=v5.4-rc5&id=24957db1004353346583c9cc6d783db8f213e3ad

The "for-next" branch has Tegra30 regulators coupling support and I
actually worked around that OPP-core problem in the Tegra's coupler back
in July [2] (see changelog). That explains why "for-next" branch works.

[2] https://lkml.org/lkml/2019/7/25/892

Thus the DT patch doesn't cause any problems. It just happened that the
DT patch is a victim of the 5.4-rc1 OPP-core problem that is already
fixed in rc5.

Jon, anyways thank you for the heads-up. I'll add a patch to blacklist
the cpufreq-dt-platdev in the next iteration to silence the warnings.
