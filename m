Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249DD13665F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 05:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbgAJE5f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 23:57:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:33978 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbgAJE5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 23:57:34 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200110045730epoutp01fea440c8cfddcbc93ddb7ce2ce6a8be6~obasVyW4k0181301813epoutp017
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2020 04:57:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200110045730epoutp01fea440c8cfddcbc93ddb7ce2ce6a8be6~obasVyW4k0181301813epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578632251;
        bh=jMYpXE86HdOpq4CxPs8s1bnusOdMOm2Ob9ZkmRz9gL8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Sx19ZKHfLLDnlcOUHGYm2znJR74cIIk3WMbNp/P581sWbVoEAlSNYlNGPfuelxzcW
         usrL/6KtQpjyRAb6b6waLTI3vtKTimTFAz0VvfA6IgCqkCwOByh5M9UOAnzpbQYYLs
         RUt04FG/WF2Ct2cRjFhar/fYJmtZviT/SnB/mIOw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200110045730epcas1p4b24d670c0e64068221abe25f92023e20~obarxqan52829028290epcas1p4R;
        Fri, 10 Jan 2020 04:57:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47v9hS0GPvzMqYkk; Fri, 10 Jan
        2020 04:57:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.B4.48019.634081E5; Fri, 10 Jan 2020 13:57:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200110045725epcas1p3f13f53e6358b80d2c21ef313bd427d28~obanfNbDc0444204442epcas1p3b;
        Fri, 10 Jan 2020 04:57:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200110045725epsmtrp1a61474448d20e8dc06cd770ce0862f91~obaneYvuR0598905989epsmtrp1C;
        Fri, 10 Jan 2020 04:57:25 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-5f-5e180436c150
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.FF.06569.534081E5; Fri, 10 Jan 2020 13:57:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200110045725epsmtip2eaeb8f196500df63583ad16f3268f2d7~obanMVwx43141431414epsmtip2B;
        Fri, 10 Jan 2020 04:57:25 +0000 (GMT)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, leonard.crestez@nxp.com,
        lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0120d269-8e93-3498-be91-ebc7de642040@samsung.com>
Date:   Fri, 10 Jan 2020 14:04:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200109172157.GM738324@yoga>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmrq4Zi0Scwdm/2hb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmCz2NfxgMmB32PNvDWMHpf7epk8dtxdwuixc9Zddo+WfbfYPTat6mTzuHNtD5vH
        xnc7mDz+ztrP4tG3ZRWjx+dNcgHcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
        5koKeYm5qbZKLj4Bum6ZOUC/KCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0
        ihNzi0vz0vWS83OtDA0MjEyBChOyM65tesNU8M2gYvXdPrYGxjkqXYycHBICJhJHT3xh7WLk
        4hAS2MEocXPjDCYI5xOjxOSJk6Gcb4wSl17MY4Zp2X7yDjNEYi+jxIJrW9ghnPeMEk1XIaqE
        Bbwl5nctYQGxRQQiJA60tzGCFDELXGOSWNr+gxEkwSagJbH/xQ02EJtfQFHi6o/HYHFeATuJ
        P1NvgNksAqoSrye/ZAWxRQXCJE5ua4GqEZQ4OfMJ2AJOAW2JFz2HmUBsZgFxiVtP5kPZ8hLb
        384BO1VC4By7xMzpH6B+cJG48OwuC4QtLPHqOMgLILaUxMv+Nii7WmLlySNsEM0djBJb9l9g
        hUgYS+xfCgoZDqANmhLrd+lDhBUldv6eywixmE/i3dceVpASCQFeiY42IYgSZYnLD+4yQdiS
        EovbO9kmMCrNQvLOLCQvzELywiyEZQsYWVYxiqUWFOempxYbFpggx/cmRnBK17LYwbjnnM8h
        RgEORiUe3gxh8Tgh1sSy4srcQ4wSHMxKIrxHb4jFCfGmJFZWpRblxxeV5qQWH2I0BYb2RGYp
        0eR8YL7JK4k3NDUyNja2MDE0MzU0VBLn5fhxMVZIID2xJDU7NbUgtQimj4mDU6qBUSU8bvHe
        i0fqPWMXnd37+dcxvlD7JcmH9179fFvBcZu+hL7HKuHDmxT0454mJYVc770are3wxVZwM8Pk
        6Wd7rPsLzK9t9zx7oK3j7vapUj7dHsU+Jwrf/X3iYqDUliG4gX0+4wyHp78uWBqcYmxvfKhf
        2NH4cAaL/z9TkdMJx+Sz7gSc4jr/WImlOCPRUIu5qDgRAAI1fcz/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvK4pi0ScwYPfWhb357UyWpze/47F
        YuKNKywWqz8+ZrRYc/sQo8WPDaeYLTYuyLY42/SG3WLF3Y+sFpd3zWGz+Nx7hNFiYVMLu8Xa
        I3fZLW43rmCz2NfxgMmB32PNvDWMHpf7epk8dtxdwuixc9Zddo+WfbfYPTat6mTzuHNtD5vH
        xnc7mDz+ztrP4tG3ZRWjx+dNcgHcUVw2Kak5mWWpRfp2CVwZ1za9YSr4ZlCx+m4fWwPjHJUu
        Rk4OCQETie0n7zCD2EICuxkllm4MgYhLSky7eBQozgFkC0scPlwMUfKWUeJqpymILSzgLTG/
        awkLiC0iECEx9cF3NhCbWeAak8T7LcJdjFxA9U+ZJJYv6wJLsAloSex/cQPM5hdQlLj64zEj
        iM0rYCfxZ+oNMJtFQFXi9eSXrCC2qECYxM4lj5kgagQlTs58AraMU0Bb4kXPYSaIZeoSf+Zd
        YoawxSVuPZkPFZeX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WK
        E3OLS/PS9ZLzczcxgqNaS2sH44kT8YcYBTgYlXh4M4TF44RYE8uKK3MPMUpwMCuJ8B69IRYn
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgTHgZo72loNT
        +hqy3zv/Ts7Y/MtQtmIdy9fiV4tCjvaGb2MN9Inc0ijFt/ql2bzGW8u2Vsmx+qf1yIt73L5g
        ULfDKmKry1UXCVbWH9NMDopwfZjBvID9QeUdJtYnD2V/lrusS+X5yquR37CgzIFR2UXO/pBV
        4He9To++SzN3NpZrbzqXKcsxR4mlOCPRUIu5qDgRAEfTkvPmAgAA
X-CMS-MailID: 20200110045725epcas1p3f13f53e6358b80d2c21ef313bd427d28
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/10/20 2:21 AM, Bjorn Andersson wrote:
> On Thu 09 Jan 00:07 PST 2020, Chanwoo Choi wrote:
> 
>> Hi Bjorn and Dmitry,
>>
>> I replied from Bjorn and Dmitry opinion.
>>
>> On 1/8/20 11:20 PM, Dmitry Osipenko wrote:
>>> 08.01.2020 00:48, Bjorn Andersson ??????????:
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
>>>
>>
>> First of all, thanks for comments.
>>
>> Before developing it, I have considered what is better to
>> support debugging features for devfreq device. As you commented,
>> trace event is more general way to catch the detailed behavior.
>>
> 
> It's more general, it has already dealt with the locking and life cycle
> questions that was brought up by others and it allows getting traces
> devfreq traces in the same timeline as other events (to give insight in
> cross-framework behavior).
> 
>> But, I hope to provide the very easy simple profiling way
>> for user if it is not harmful to the principle of linux kernel.
>>
> 
> You would achieve the same simplicity by integrating with the trace
> framework instead of rolling your own subset of the functionality.
> 
> I know that it's the principle of the Linux kernel that everyone should
> have their own ring buffer implementation, but you should try to use the
> existing ones when it makes sense. And in my view this is a prime
> example - with many additional benefits of doing so.

When we are usually using the profiling tool, existing trace framework
is the best. Actually, might need to read the frequency transitions
on the user-space process which is related to monitoring, without
the enabled trace configuration.

> 
>> In order to prevent the performance regression when DEBUG_FS is enabled,
>> I will add the CONFIG_DEVFREQ_TRANSITIONS_DEBUG for 'devfreq_transitions'
>> to make it selectable.
>>
> 
> The tracing framework has both static and dynamic mechanisms for
> avoiding performance penalties when tracing is disabled and does provide
> better performance than your proposal when active.

It provides the separate configuration to select them by user.
It is optional. It means that if CONFIG_DEVFREQ_TRANSITIONS_DEBUG
is enabled by user, the user has made a choice this situation with
even if the some regression happen and instead get the frequency
transition for monitoring on user-space process.

> 
> Relying on a Kconfig option means that with e.g. arm64 devices being
> built from a single defconfig we will either all be missing this feature
> or we will all always keep logging devfreq transitions to your buffer.

The single defconfig doesn't contain the all configuration provided
from linux kernel. Furthermore, the debug option is optional by user.
I think that it doesn't matter.
-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
