Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52C11367AD
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 07:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbgAJGtZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 01:49:25 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:42141 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgAJGtY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 01:49:24 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200110064920epoutp018c4e88649fbe9a1579789961c6d87ca2~oc8Uzm2G_0536505365epoutp01l
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2020 06:49:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200110064920epoutp018c4e88649fbe9a1579789961c6d87ca2~oc8Uzm2G_0536505365epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578638960;
        bh=h419y5kdtruoBWjapj0P5aqi1d2SZxvsii8OAIOuo/s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u1DaaVI9LzV6sK664imCJQg1q4ExxL0sBC31QQWsi6Rbh0JArr42Amn9rGM0var6o
         ljG8r8vRkKjiIkV+OeCJjk9+UffnMP6aHXSdQLkLs8DGHMVcChWjlmd5vlqAD2kfHV
         GY47n9jK03VUUM9mFHU1v+UuNjqaBfkMETh+KTNk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200110064919epcas1p19575af6dae403d17066ddf5b9775bb76~oc8TsaFng2997429974epcas1p11;
        Fri, 10 Jan 2020 06:49:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47vD9S4tbRzMqYm3; Fri, 10 Jan
        2020 06:49:16 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.61.51241.C6E181E5; Fri, 10 Jan 2020 15:49:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200110064916epcas1p15aa4a0db87d840ffa88d90acdc31237c~oc8Q7kwDw1768517685epcas1p1P;
        Fri, 10 Jan 2020 06:49:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200110064915epsmtrp2832a28ae78ec5e296b20dd7651b9b582~oc8Q2NJCJ1523215232epsmtrp2Q;
        Fri, 10 Jan 2020 06:49:15 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-4d-5e181e6ca691
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.18.10238.B6E181E5; Fri, 10 Jan 2020 15:49:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200110064915epsmtip202150b102bcdffbb591ccd7da6fd0b9b~oc8QgyAsR2421124211epsmtip26;
        Fri, 10 Jan 2020 06:49:15 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, leonard.crestez@nxp.com,
        lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Organization: Samsung Electronics
Message-ID: <6fca978a-471c-8429-ef3a-5e1aefcced8d@samsung.com>
Date:   Fri, 10 Jan 2020 15:56:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <0120d269-8e93-3498-be91-ebc7de642040@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGc3rbey9i9VIUXkuieMmi4EAupewwRedGlpvoHyRmc5mRegM3
        LaFf6S1GJFmQsPKR6WQzi1QG6pDwGS12DFCpMnBhH4SJEhDrcDAzZasiUUkMurYXM/77nfM+
        z3nPcz5oQjNLaukCq1N0WAUzS65Qdv2YmJxsXg+5qa8mNuE/6j9H+BdfQIlrxm8pcdvcNMLt
        k/0IL1z8mcCeM4X4t7J/KNzsn1Ph0d46Es8fG0D4bFk5hTsG/BSePNpM4r7KKcV7q/n2+nbE
        jx4/puC7/Y2I73H7Kb687w7Fd7ZWkfzdsSsk7wl0K/hFt0/JH/e2In6+c31O5KeF202ikC86
        4kVrni2/wGrMYnfvNXxg0GekcslcJn6HjbcKFjGLzd6Tk/xhgTmYhY0/JJiLglM5giSxW3ds
        d9iKnGK8ySY5s1jRnm+2Z9pTJMEiFVmNKXk2y7tcamqaPig8WGg6vehC9sn0w6XT11WlqGVT
        NYqggUmH+oeLVIg1TDeCByf3V6MVQX6K4O7wU0IePEfg8rhVbxwzvoukXLiKoOuUd2nwGEHP
        YGN4rWhmNzRUNypDTDJJ4Pt7nAzxGuYTuFbhQiEDwYwp4HzFAgoVVjMb4fbCdJjVzA44Pd8Z
        NiuZt8A7dyNsXst8DENd5UuaKBiqnQlrIpidcPL71+HtEUws3JlpUMi8AX74ty6cAZibFJyr
        +pWQM2TDSPMEJXM0PPrJu8RamA9cJWUugZahAVI2VyLw+kaWDkAHvvNfBzvQwQ6JcKF3qzy9
        EXpefovkxqsg8OwLVUgCjBoqXRpZkgCjU36FzOvgu4oq8gRi3cviuJdFcC+L4P6/2RmkbEUx
        ol2yGEWJs+uXX3cnCj/0pMxudGN4Tz9iaMSuVJuiY3M1KuGQVGzpR0AT7Br14HhMrkadLxQf
        ER02g6PILEr9SB887RpCuzbPFvw2VqeB06fpdDqczmXoOY6NVdMLvx/QMEbBKRaKol10vPEp
        6AhtKXr/3uWGsktbpBF33M23+YSB4ildE5x7EBnIfdK0JSqjd989TV3aqWsu2vDiwq5ZLs55
        n+r4czbybKLls7ajUNWhvd+QMkZdt+aRxl1RH21uoRwTNX17N+e0fBM3PBqZ1jRcGdiW7qkt
        Scj2PFfNvf5q8knJl9vqH/3VBTFtg7UHZlilZBK4JMIhCf8B6xvU0f4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCSvG62nEScweLtRhb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmCz2NfxgMmB32PNvDWMHpf7epk8dtxdwuixc9Zddo+WfbfYPTat6mTzuHNtD5vH
        xnc7mDz+ztrP4tG3ZRWjx+dNcgHcUVw2Kak5mWWpRfp2CVwZs/+2MRbcNqloeHyQtYFxpXoX
        IyeHhICJxJP9G9hAbCGB3YwSry/aQcQlJaZdPMrcxcgBZAtLHD5c3MXIBVTyllHi1syTYPXC
        At4S87uWsIDYbAJaEvtf3ACLiwhESEx98B3MZha4xiTxfoswRPMsZol9k76BJfgFFCWu/njM
        CGLzCthJzP68CWwQi4CqxJaPx8BqRAXCJHYuecwEUSMocXLmE7AaTgF7iSlb/7NCLFCX+DPv
        EjOELS5x68l8JghbXmL72znMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3X
        K07MLS7NS9dLzs/dxAiOay3NHYyXl8QfYhTgYFTi4c0QFo8TYk0sK67MPcQowcGsJMJ79IZY
        nBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2MMvU9kQVt
        BekGQR5cdscfJ24u5HtuLid5MXDnG8a4X4b73j0SYtX+ypi/5EmdUHdsE9/nddYFiUnlJ48l
        nuDKnsKvnao2a5ErS8cO5RXzrGzOMXI8Z9TPkAwXvO9S0Jaqt/N8vkP1gd8r9UseuEwXOqT4
        O/Tm2oO5rtfyHA+YtZ0MYrxh/FqJpTgj0VCLuag4EQBhH8+F5wIAAA==
X-CMS-MailID: 20200110064916epcas1p15aa4a0db87d840ffa88d90acdc31237c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea
References: <20200107090519.3231-1-cw00.choi@samsung.com>
        <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
        <20200107090519.3231-3-cw00.choi@samsung.com> <20200107214834.GB738324@yoga>
        <c1e6f324-b0c2-41ff-a015-7ba0b29ad42c@gmail.com>
        <9c3574e8-945b-56c4-3425-28e68cd3d2a9@samsung.com>
        <20200109172157.GM738324@yoga>
        <0120d269-8e93-3498-be91-ebc7de642040@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

On 1/10/20 2:04 PM, Chanwoo Choi wrote:
> On 1/10/20 2:21 AM, Bjorn Andersson wrote:
>> On Thu 09 Jan 00:07 PST 2020, Chanwoo Choi wrote:
>>
>>> Hi Bjorn and Dmitry,
>>>
>>> I replied from Bjorn and Dmitry opinion.
>>>
>>> On 1/8/20 11:20 PM, Dmitry Osipenko wrote:
>>>> 08.01.2020 00:48, Bjorn Andersson ??????????:
>>>>> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
>>>>>
>>>>>> Add new devfreq_transitions debugfs file to track the frequency transitions
>>>>>> of all devfreq devices for the simple profiling as following:
>>>>>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>>>>>
>>>>>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>>>>>> in Kconfig in order to save the transition history.
>>>>>>
>>>>>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>>>>>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>>>>>> - dev_name	: Device name of h/w.
>>>>>> - dev		: Device name made by devfreq core.
>>>>>> - parent_dev	: If devfreq device uses the passive governor,
>>>>>> 		  show parent devfreq device name.
>>>>>> - load_%	: If devfreq device uses the simple_ondemand governor,
>>>>>> 		  load is used by governor whene deciding the new frequency.
>>>>>> 		  (unit: percentage)
>>>>>> - old_freq_hz	: Frequency before changing. (unit: hz)
>>>>>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>>>>>
>>>>>> [For example on Exynos5422-based Odroid-XU3 board]
>>>>>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>>>>>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>>>>>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>>>>>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>>>>>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>>>>>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>>>>>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>>>>>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>>>>>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>>>>>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>>>>>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>>>>>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>>>>>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>>>>>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>>>>>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>>>>>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>>>>>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>>>>>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>>>>>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>>>>>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>>>>>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>>>>>> [snip]
>>>>>>
>>>>>
>>>>> Wouldn't it make more sense to expose this through the tracing
>>>>> framework - like many other subsystems does?
>>>>
>>>> I think devfreq core already has some tracing support and indeed it
>>>> should be better to extend it rather than duplicate.
>>>>
>>>
>>> First of all, thanks for comments.
>>>
>>> Before developing it, I have considered what is better to
>>> support debugging features for devfreq device. As you commented,
>>> trace event is more general way to catch the detailed behavior.
>>>
>>
>> It's more general, it has already dealt with the locking and life cycle
>> questions that was brought up by others and it allows getting traces
>> devfreq traces in the same timeline as other events (to give insight in
>> cross-framework behavior).
>>
>>> But, I hope to provide the very easy simple profiling way
>>> for user if it is not harmful to the principle of linux kernel.
>>>
>>
>> You would achieve the same simplicity by integrating with the trace
>> framework instead of rolling your own subset of the functionality.
>>
>> I know that it's the principle of the Linux kernel that everyone should
>> have their own ring buffer implementation, but you should try to use the
>> existing ones when it makes sense. And in my view this is a prime
>> example - with many additional benefits of doing so.
> 
> When we are usually using the profiling tool, existing trace framework
> is the best. Actually, might need to read the frequency transitions
> on the user-space process which is related to monitoring, without
> the enabled trace configuration.
> 
>>
>>> In order to prevent the performance regression when DEBUG_FS is enabled,
>>> I will add the CONFIG_DEVFREQ_TRANSITIONS_DEBUG for 'devfreq_transitions'
>>> to make it selectable.
>>>
>>
>> The tracing framework has both static and dynamic mechanisms for
>> avoiding performance penalties when tracing is disabled and does provide
>> better performance than your proposal when active.
> 
> It provides the separate configuration to select them by user.
> It is optional. It means that if CONFIG_DEVFREQ_TRANSITIONS_DEBUG
> is enabled by user, the user has made a choice this situation with
> even if the some regression happen and instead get the frequency
> transition for monitoring on user-space process.
> 
>>
>> Relying on a Kconfig option means that with e.g. arm64 devices being
>> built from a single defconfig we will either all be missing this feature
>> or we will all always keep logging devfreq transitions to your buffer.
> 
> The single defconfig doesn't contain the all configuration provided
> from linux kernel. Furthermore, the debug option is optional by user.
> I think that it doesn't matter.
> 

Basically, I agree that trace point is better. Just as I said,
I hope to provide the very easy simple profiling way.
But, as you suggested and I knew that it seems that
duplicate feature. So, I'll drop it and extend the existing
trace point of devfreq. Thanks for your comment and discussion.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
