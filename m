Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9E13A9B9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 13:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgANMwN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 07:52:13 -0500
Received: from foss.arm.com ([217.140.110.172]:51958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgANMwN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jan 2020 07:52:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FA91435;
        Tue, 14 Jan 2020 04:52:12 -0800 (PST)
Received: from [10.37.12.134] (unknown [10.37.12.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E70B3F534;
        Tue, 14 Jan 2020 04:52:04 -0800 (PST)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.swigon@samsung.com" <a.swigon@samsung.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "hl@rock-chips.com" <hl@rock-chips.com>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "chanwoo@kernel.org" <chanwoo@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
 <20200107090519.3231-3-cw00.choi@samsung.com> <20200107214834.GB738324@yoga>
 <c1e6f324-b0c2-41ff-a015-7ba0b29ad42c@gmail.com>
 <ddbc54d1-c657-747c-265d-3c7bd5924e59@arm.com>
 <VI1PR04MB70232D962B603DC882388B92EE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d71e5268-7d5d-cba6-9ce3-ec11e65905d7@arm.com>
Date:   Tue, 14 Jan 2020 12:52:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB70232D962B603DC882388B92EE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 1/13/20 5:19 PM, Leonard Crestez wrote:
> On 08.01.2020 17:44, Lukasz Luba wrote:
>> On 1/8/20 2:20 PM, Dmitry Osipenko wrote:
>>> 08.01.2020 00:48, Bjorn Andersson пишет:
>>>> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
>>>>
>>>>> Add new devfreq_transitions debugfs file to track the frequency transitions
>>>>> of all devfreq devices for the simple profiling as following:
>>>>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>>>>
>>>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>>>>> in Kconfig in order to save the transition history.
>>>>>
>>>>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>>>>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>>>>> - dev_name	: Device name of h/w.
>>>>> - dev		: Device name made by devfreq core.
>>>>> - parent_dev	: If devfreq device uses the passive governor,
>>>>> 		  show parent devfreq device name.
>>>>> - load_%	: If devfreq device uses the simple_ondemand governor,
>>>>> 		  load is used by governor whene deciding the new frequency.
>>>>> 		  (unit: percentage)
>>>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>>>
>>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>>>>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>>>>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>>>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>>>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>>>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>>>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>>>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>>>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>>>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>>>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>>>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>>>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>>>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>>>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>>>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>>>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>>>>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>>>>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>>>>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>>>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>>>>> [snip]
>>>>>
>>>>
>>>> Wouldn't it make more sense to expose this through the tracing
>>>> framework - like many other subsystems does?
>>>
>>> I think devfreq core already has some tracing support and indeed it
>>> should be better to extend it rather than duplicate.
> 
> +1 for tracing
>> In my opinion this debugfs interface should be considered as a helpful
>> validation entry point. We had some issues with wrong bootloader
>> configurations in clock tree, where some frequencies could not be set
>> in the kernel. Similar useful description can be find in clock subsystem
>> where there is clock tree summary file.
>>
>> It is much cheaper to poke a few files in debug dir by some automated
>> test than starting tracing, provoking desired code flow in the
>> devfreq for every device, paring the results... A simple boot test
>> which reads only these new files can be enough to rise the flag.
> 
> Tracepoints are also very powerful for debugging boot issues! You can
> add "tp_printk trace_event=devfreq:*" to boot arguments and you will see
> console messages for all relevant events. This works even if boot fails
> before userspace is available to mount debugfs.
> 
>> Secondly the tracing is not always compiled.
> 
> Tracing is deliberately light-weight and should be enabled even on
> production systems.
> 
>> It could capture old/wrong bootloaders which pinned devices
>> improperly to PLLs or wrong DT values in OPP table.
>> (a workaround for Odroid xu4 patchset:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F7%2F15%2F276&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C8397d37b41474137f8cf08d79451a007%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637140950611913278&amp;sdata=rcbWCyFmf0ZO7LU27D05mftTf8YdSvGPYNsst1GnNjQ%3D&amp;reserved=0
>> )
>>
>> Chanwoo what do think about some sanity check summary?
>> It could be presented in a 3rd file: 'devfreq_sanity', which
>> could report if the devices could set their registered OPPs
>> and got the same values, i.e. set 166MHz --> set to 150MHz
>> in reality. If a config option i.e. DEVFREQ_SANITY is set
>> then during the registration of a new device it checks OPPs
>> if they are possible to set. It could be done before assigning
>> the governor for the device and results present in of of your files.
> 
> The new devfreq_transition tracepoint could include a field for
> "new_effective freq" next to "old_freq" and "new_requested_freq".

I would suggest to keep it aligned with cpufreq trace. The timestamps
in trace would tell you the history, 'old_freq' is not needed.
The trace_devfreq_monitor that I have added should give you this
information when you parse all the events.

> 
> For imx8m-ddrc I handled this inside the target() function: clk_get_rate
> is called after the transition and an error is reported if rate doesn't
> match.

Interesting driver, it uses ARM SMCCC like rk3399.
It handles this validation of DT OPPs vs firmware OPPs and disables
not matched frequencies. Small nit. The error is printed when the 'ret'
is 0 and freq does not match, but then 'ret' is returned from target().
You don't also revert the update parent stuff in such case.
Maybe you can also check the res.a0 != SMCCC_RET_SUCCESS in
static void imx8m_ddrc_smc_set_freq(int target_freq)
to bail out earlier and not switch to new parents when the freq
switch failed or does not match. Or I am missing something.
You can also reorder the includes alphabetically.

Regards,
Lukasz

> 
> It might make sense for devfreq core to handle this internally by
> calling get_cur_freq instead.
> 
> --
> Regards,
> Leonard
> 
