Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D991001C5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 10:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKRJwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 04:52:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18617 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKRJwJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 04:52:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd269c80001>; Mon, 18 Nov 2019 01:52:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 01:52:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 01:52:07 -0800
Received: from [10.26.11.241] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 09:52:02 +0000
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
 <be6deeff-4294-c945-1539-57ec28b4c895@nvidia.com>
 <8974f1a8-72bb-4413-d2b5-057853696fb4@gmail.com>
 <ef22b044-2bc1-1fdc-97cb-f9b036d3d5a9@nvidia.com>
 <15962ea4-20a8-0bf9-6982-f94123b9a324@gmail.com>
 <fb196514-bcde-deb0-32fc-35344fa33f66@nvidia.com>
 <84180062-014d-f06a-b0fb-994fe52f77d7@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e3cf7855-f434-8a2c-5195-ec82d0218fb5@nvidia.com>
Date:   Mon, 18 Nov 2019 09:52:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <84180062-014d-f06a-b0fb-994fe52f77d7@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574070728; bh=xk8/c5+6nxswFjH7oe859Y+RBSz8sbDeN5Uv2dQy1Eo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VJl64T4UJ1t1BntQg59WgSfVRAVqRMCOIKJLwZr8m3GDQ4sRAJcLglmyYwNgzFOjm
         IrV1Ixb63plaCjx8YPTbMgpMG3mQmXYgDxyqUKGepr53qv0n9b/XpTD3j/yTrGMT8W
         DUolDDFWfoFIibVIAkCFq/6aQ96unlkTshyilqQTBxTNkZ4F69sOEjTiggghPvWW+u
         3dcakwNIEpT7+3vNRblUUMUP/YspJ0MfXFZ/yaFeDkoebwksIfZh7jCawIYknvEOm7
         T+oqt7StBXiYPw0QKTN4v4vQA6ufX2f/vh7XmKuSmArxsfKG8PwuO55fm01IaLpfdf
         OD4x+Xzs5I/eA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 15/11/2019 20:35, Dmitry Osipenko wrote:
> 15.11.2019 20:31, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>
>> On 15/11/2019 14:55, Dmitry Osipenko wrote:
>>> 15.11.2019 15:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 13/11/2019 13:57, Dmitry Osipenko wrote:
>>>>> Hello Jon,
>>>>>
>>>>> 13.11.2019 09:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>
>>>>>> On 24/10/2019 23:14, Dmitry Osipenko wrote:
>>>>>>> Utilize common Tegra30 CPU OPP table. CPU DVFS is available now on
>>>>>>> cardhu-a04.
>>>>>>>
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/tegra30-cardhu-a04.dts | 24 ++++++++++++++++++++=
++++
>>>>>>>  1 file changed, 24 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/bo=
ot/dts/tegra30-cardhu-a04.dts
>>>>>>> index 0d71925d4f0b..9234988624ec 100644
>>>>>>> --- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>>>>> +++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
>>>>>>> @@ -2,6 +2,8 @@
>>>>>>>  /dts-v1/;
>>>>>>> =20
>>>>>>>  #include "tegra30-cardhu.dtsi"
>>>>>>> +#include "tegra30-cpu-opp.dtsi"
>>>>>>> +#include "tegra30-cpu-opp-microvolt.dtsi"
>>>>>>> =20
>>>>>>>  /* This dts file support the cardhu A04 and later versions of boar=
d */
>>>>>>> =20
>>>>>>> @@ -127,4 +129,26 @@
>>>>>>>  			nvidia,tegra-core-regulator;
>>>>>>>  		};
>>>>>>>  	};
>>>>>>> +
>>>>>>> +	cpus {
>>>>>>> +		cpu0: cpu@0 {
>>>>>>> +			cpu-supply =3D <&vddctrl_reg>;
>>>>>>> +			operating-points-v2 =3D <&cpu0_opp_table>;
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		cpu@1 {
>>>>>>> +			cpu-supply =3D <&vddctrl_reg>;
>>>>>>> +			operating-points-v2 =3D <&cpu0_opp_table>;
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		cpu@2 {
>>>>>>> +			cpu-supply =3D <&vddctrl_reg>;
>>>>>>> +			operating-points-v2 =3D <&cpu0_opp_table>;
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		cpu@3 {
>>>>>>> +			cpu-supply =3D <&vddctrl_reg>;
>>>>>>> +			operating-points-v2 =3D <&cpu0_opp_table>;
>>>>>>> +		};
>>>>>>> +	};
>>>>>>>  };
>>>>>>
>>>>>> Sorry for not testing this sooner, but this is generating the
>>>>>> following WARNING on boot ...
>>>>>>
>>>>>> [    2.916019] ------------[ cut here ]------------
>>>>>> [    2.920669] WARNING: CPU: 2 PID: 1 at /dvs/git/dirty/git-master_l=
4t-upstream/kernel/drivers/opp/of.c:688 _of_add_opp_table_v2.part.2+0x45c/0=
x4d4
>>>>>> [    2.933713] Modules linked in:
>>>>>> [    2.936785] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc7-n=
ext-20191112-gfc6d6db1df2c #1
>>>>>> [    2.945403] Hardware name: NVIDIA Tegra SoC (Flattened Device Tre=
e)
>>>>>> [    2.951706] [<c0112924>] (unwind_backtrace) from [<c010c9d0>] (sh=
ow_stack+0x10/0x14)
>>>>>> [    2.959467] [<c010c9d0>] (show_stack) from [<c0aa4494>] (dump_sta=
ck+0xc0/0xd4)
>>>>>> [    2.966707] [<c0aa4494>] (dump_stack) from [<c0124750>] (__warn+0=
xe0/0xf8)
>>>>>> [    2.973593] [<c0124750>] (__warn) from [<c0124818>] (warn_slowpat=
h_fmt+0xb0/0xb8)
>>>>>> [    2.981090] [<c0124818>] (warn_slowpath_fmt) from [<c0754be0>] (_=
of_add_opp_table_v2.part.2+0x45c/0x4d4)
>>>>>> [    2.990583] [<c0754be0>] (_of_add_opp_table_v2.part.2) from [<c07=
54c98>] (dev_pm_opp_of_add_table+0x40/0x15c)
>>>>>> [    3.000508] [<c0754c98>] (dev_pm_opp_of_add_table) from [<c0754de=
8>] (dev_pm_opp_of_cpumask_add_table+0x34/0xb4)
>>>>>> [    3.010704] [<c0754de8>] (dev_pm_opp_of_cpumask_add_table) from [=
<c075b058>] (cpufreq_init+0xf8/0x2cc)
>>>>>> [    3.020024] [<c075b058>] (cpufreq_init) from [<c0758758>] (cpufre=
q_online+0x260/0x824)
>>>>>> [    3.027953] [<c0758758>] (cpufreq_online) from [<c0758d98>] (cpuf=
req_add_dev+0x6c/0x78)
>>>>>> [    3.035976] [<c0758d98>] (cpufreq_add_dev) from [<c05b3188>] (sub=
sys_interface_register+0xa0/0xec)
>>>>>> [    3.044951] [<c05b3188>] (subsys_interface_register) from [<c0757=
4d4>] (cpufreq_register_driver+0x14c/0x20c)
>>>>>> [    3.054792] [<c07574d4>] (cpufreq_register_driver) from [<c075aee=
0>] (dt_cpufreq_probe+0x94/0x114)
>>>>>> [    3.063771] [<c075aee0>] (dt_cpufreq_probe) from [<c05b6a88>] (pl=
atform_drv_probe+0x48/0x98)
>>>>>> [    3.072225] [<c05b6a88>] (platform_drv_probe) from [<c05b4a38>] (=
really_probe+0x234/0x34c)
>>>>>> [    3.080502] [<c05b4a38>] (really_probe) from [<c05b4cc8>] (driver=
_probe_device+0x60/0x168)
>>>>>> [    3.088780] [<c05b4cc8>] (driver_probe_device) from [<c05b4f78>] =
(device_driver_attach+0x58/0x60)
>>>>>> [    3.097664] [<c05b4f78>] (device_driver_attach) from [<c05b5000>]=
 (__driver_attach+0x80/0xbc)
>>>>>> [    3.106200] [<c05b5000>] (__driver_attach) from [<c05b2db0>] (bus=
_for_each_dev+0x74/0xb4)
>>>>>> [    3.114389] [<c05b2db0>] (bus_for_each_dev) from [<c05b3da4>] (bu=
s_add_driver+0x164/0x1e8)
>>>>>> [    3.122666] [<c05b3da4>] (bus_add_driver) from [<c05b5b54>] (driv=
er_register+0x7c/0x114)
>>>>>> [    3.130774] [<c05b5b54>] (driver_register) from [<c010306c>] (do_=
one_initcall+0x54/0x2a8)
>>>>>> [    3.138974] [<c010306c>] (do_one_initcall) from [<c0f01040>] (ker=
nel_init_freeable+0x14c/0x1e8)
>>>>>> [    3.147695] [<c0f01040>] (kernel_init_freeable) from [<c0abbe88>]=
 (kernel_init+0x8/0x10c)
>>>>>> [    3.155887] [<c0abbe88>] (kernel_init) from [<c01010e8>] (ret_fro=
m_fork+0x14/0x2c)
>>>>>> [    3.163462] Exception stack(0xef0c9fb0 to 0xef0c9ff8)
>>>>>> [    3.168519] 9fa0:                                     00000000 00=
000000 00000000 00000000
>>>>>> [    3.176706] 9fc0: 00000000 00000000 00000000 00000000 00000000 00=
000000 00000000 00000000
>>>>>> [    3.184893] 9fe0: 00000000 00000000 00000000 00000000 00000013 00=
000000
>>>>>> [    3.191695] ---[ end trace a7dc36f7a4ddbdb2 ]---
>>>>>> [    3.197855] ------------[ cut here ]------------
>>>>>>
>>>>>> Let me know if you can take a look at this.
>>>>>
>>>>> The warning happens because Cardhu now has CPU OPPs in the device-tre=
e,
>>>>> but supported_hw isn't set for the OPPs and thus the count of availab=
le
>>>>> OPPs is 0.
>>>>>
>>>>> This is expected to happen because patch "cpufreq: tegra20: Use gener=
ic
>>>>> cpufreq-dt driver (Tegra30 supported now)" isn't applied yet.
>>>>>
>>>>> It is possible to factor out the blacklisting of Tegra SoCs in
>>>>> cpufreq_dt_platdev_init() into a separate patch and request backporti=
ng
>>>>> of that change in order to avoid the warning noise for older kernel
>>>>> versions + newer device-tree. Please let me know if you think that it=
's
>>>>> worth to do the separation.
>>>>
>>>> Unfortunately, I think we are going to need to drop this patch. Bootin=
g
>>>> Tegra30-cardhu-a04 with Thierry's for-5.5/arm/dt branch does not even
>>>> boot. There is no crash log but it hangs on boot. This patch appears t=
o
>>>> be the culprit. What is odd is that Tegra30-cardhu-a04 boots fine with
>>>> Thierry's for-next branch which includes this. However, this is causin=
g
>>>> lots of bisect problems. Updating the DT shouldn't break the boot.
>>> The diff between "for-5.5/arm/dt" and "for-next" is quite small, you
>>> only need to try to revert one or two patches. Seems the only major
>>> change which could be somehow related to CPUFreq is that
>>> "for-5.5/arm/dt" doesn't have regulators coupling support, but I don't
>>> see how it could cause any effect since CPUFreq just doesn't load due t=
o
>>> a missing setup of supported_hw.
>>>
>>> Unfortunately for now I can't reproduce the hang with a similar setup
>>> that has OPPs in DT, doesn't have Tegra CPUFreq driver, doesn't
>>> blacklist Tegra in cpufreq-dt-platdev.c and doesn't have regulators
>>> coupling. I see the warning splats on boot and everything appears to be
>>> working fine.
>>>
>>> It's likely that the hang is caused by something else than this patch.
>>
>> No, it is definitely this patch. 100% reproducible.
>>
>>> It's also a bit odd that you're accusing this patch while apparently it
>>> worked a day before.
>>
>> No, the behaviour on top of -next is different to the "for-5.5/arm/dt"
>> branch, which is what I am saying.
>>
>>> Please give a try to the recent upstream linux-next. If it works, then
>>> probably there is nothing to worry about.
>>
>> No, there is plenty to be concerned about, with the latest -next we are
>> getting these WARN splats on boot, which we need to avoid.
>>
>>> I'll factor out the blacklisting change and add it as a separate patch
>>> into the next revision of the series, marking the patch as "fixes" and
>>> "stable" in order to get rid of the warning on stable kernels.
>>>
>>> I'm also fine with reverting of the DT changes for now, if you prefer
>>> that. But again, this DT change shouldn't cause any critical problems.
>>
>> No it should not, but it does.
>>
>>> I need a detailed report or a way to reproduce the problem in order to
>>> solve it, please try to collect some more details. Try to compile the
>>> cpufreq-dt driver as a loadable module, enable tracing of clk and
>>> regulator events (tp_printk
>>> trace_event=3Dregulator_set_voltage,clk_set_rate,clk_set_parent).
>>
>> I add some debug prints and on boot with "for-5.5/arm/dt" is dies while
>> bringing CPU0 online for cpufreq ...
>>
>> [    2.863369] cpufreq_dt: dt_cpufreq_probe-347
>> [    2.867917] cpufreq_dt: dt_cpufreq_probe-360
>> [    2.872195] cpufreq_dt: dt_cpufreq_probe-370
>> [    2.876509] cpufreq: cpufreq_register_driver-2632
>> [    2.881219] cpufreq: cpufreq_register_driver-2636
>> [    2.885989] cpufreq: trying to register driver cpufreq-dt
>> [    2.891395] cpufreq: cpufreq_register_driver-2651
>> [    2.896131] cpufreq: cpufreq_register_driver-2661
>> [    2.900839] cpufreq: cpufreq_register_driver-2665
>> [    2.905610] cpufreq: cpufreq_register_driver-2672
>> [    2.910329] cpu cpu0: cpufreq_add_dev: adding CPU0
>> [    2.915152] cpufreq: cpufreq_online: bringing CPU0 online
>>
>> So I think it is best to revert this for now.
>=20
> I managed to reproduced the problem using unmodified "for-5.5/arm/dt":
>=20
>  # modprobe cpufreq-dt
>=20
> [   41.002512] regulator_set_voltage: name=3Dvdd_core (1100000-1350000)
> [   41.007822] regulator_set_voltage: name=3Dvdd_core (1000000-1350000)
> [   41.012475] regulator_set_voltage: name=3Dvdd_cpu (925000-1250000)
> [   41.017299] regulator_set_voltage: name=3Dvdd_cpu (825000-1250000)
> [   41.021842] regulator_set_voltage: name=3Dvdd_core (950000-1350000)
> [   41.025399] regulator_set_voltage: name=3Dvdd_cpu (800000-1250000)
>=20
> As you can see the voltage drops too much and I know what causes it. The
> OPP core was getting some fixes recently, while "for-5.5/arm/dt" uses
> older 5.4-rc1 as the base. The problem was introduced in 5.4-rc1 and
> then it was fixed by the commit [1] in 5.4-rc5.

OK, great. Thanks for tracking this down.

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/opp?h=3Dv5.4-rc5&id=3D24957db1004353346583c9cc6d783db8f213e3ad
>=20
> The "for-next" branch has Tegra30 regulators coupling support and I
> actually worked around that OPP-core problem in the Tegra's coupler back
> in July [2] (see changelog). That explains why "for-next" branch works.
>=20
> [2] https://lkml.org/lkml/2019/7/25/892
>=20
> Thus the DT patch doesn't cause any problems. It just happened that the
> DT patch is a victim of the 5.4-rc1 OPP-core problem that is already
> fixed in rc5.

OK, and so that explains what I am seeing.

> Jon, anyways thank you for the heads-up. I'll add a patch to blacklist
> the cpufreq-dt-platdev in the next iteration to silence the warnings.

Yes if we could get the WARN fixed-up, that would make me happy :-)

Cheers!
Jon

--=20
nvpublic
