Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A789E1F1749
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgFHLLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 07:11:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42322 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgFHLLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 07:11:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200608111112euoutp02a76cf1b3f33e6f3772fce4575cc7be26~WjRywxtmB0860608606euoutp025
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 11:11:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200608111112euoutp02a76cf1b3f33e6f3772fce4575cc7be26~WjRywxtmB0860608606euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591614672;
        bh=EvxZJ5JvB3f7kIzL9j0Myjd9Q/uJ1ernbV48e4eU7vU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WFt/lsQzErbFsZ+zQUekgGg7z3N8zJtLOE3kN977Zst8v/xil0fLvU3wXKnQ878Q3
         SSWMSyuf3h+cFjf9ixFRNu4NQQ7mYcjTjKAf1PGXp5m62afz7sKhT3Q8kHoDtLSw+L
         b1nTTQAzGePvuY5uxl5lVuiu+6QSNelQSyTUfPrg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200608111112eucas1p16bec0b78eaba8e9ea0f68d02104d2b1c~WjRyeazet1322213222eucas1p16;
        Mon,  8 Jun 2020 11:11:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F6.F9.60698.0DC1EDE5; Mon,  8
        Jun 2020 12:11:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200608111111eucas1p2907107d768c5ce0e1101581eb5f834ef~WjRyDGxL90978109781eucas1p2y;
        Mon,  8 Jun 2020 11:11:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200608111111eusmtrp2a999912bef927cd76c932e4f059c3ff4~WjRyCJG0e0777507775eusmtrp20;
        Mon,  8 Jun 2020 11:11:11 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-98-5ede1cd03301
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 65.32.08375.FCC1EDE5; Mon,  8
        Jun 2020 12:11:11 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200608111110eusmtip18fd0bc170c92c2b28bc0cef1436c95ad~WjRw-OhDC0700107001eusmtip12;
        Mon,  8 Jun 2020 11:11:10 +0000 (GMT)
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Grant Likely <grant.likely@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        artem.bityutskiy@linux.intel.com, balbi@kernel.org,
        broonie@kernel.org, fntoth@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peter.ujfalusi@ti.com, rafael@kernel.org, kernel-team@android.com,
        nd <nd@arm.com>, kernel@pengutronix.de
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <437de51b-37e9-d8d1-19c7-137a9265bf45@samsung.com>
Date:   Mon, 8 Jun 2020 13:11:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608091712.GA28093@pengutronix.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3bv7q7DyXVaezDJGkEZ5gsGPaFIih8uBKGQXwytqdcp+TJ2
        1dI+ZBZmOrM3kZYvw2maGMrUzTdKp2mipiaBlS9JpqlZvqal07ZdI7/9zjn/85z/OTwkJp7n
        O5GxCUmMMkEWJyWEuL7r98DJQefxcM/tdTHKzSjgoe9fpjHUlTklQPmTUwTaKO4gUEPeRxzd
        0tYQqNHgiKrym3A03FxIoJXcToAWm99jqK9ChSH10gYfFa3mYyjbaCLOUrS+Rc+nq4urAd2k
        HhPQGl0yrau6S9DFPcH0q6JqAZ1n8qS7Rww8ekV3KEgYKvSNYuJiUxilh99lYczQUj+umPO5
        tnmvjJ8O1j2zAUlC6hRcnj2XDYSkmKoE8OnAJJENbMzBKoDzJjeOVwDc0PEtbNHPdxkA11AB
        YL7ByOOCnwDOjuVZVQ6UDM4s/LCyo5l7R9utHRi1zIPv9B3WEQTlCk11H6wsovyg9pPGyjh1
        FJbUf+ZZeD8VBnu1dYDT2MOeJ1O4hW3MNr72TFs1GOUCDQuFGMcSmLH6nG8ZBqkHJKwc2cQ5
        34Ewp2xolx3gXHe9gGNnuNNUwuP4BpyovI1xzVkANtQ2YVzBB46+/UNYDoaZXdc0e3Bpf5hV
        k4Nxd7SDIwv2nAc7+FBfsJsWwaxMMac+Aif6G3YflMDywTXiPpCq92ym3rONes826v9zNQCv
        AhImmY2XM6x3AnPVnZXFs8kJcvfIxHgdMH/B3u3utUbwcivCCCgSSG1FI5LxcDFflsKmxhsB
        JDGpoyigvzdcLIqSpaYxysRLyuQ4hjWCgyQulYi8S2fDxJRclsRcYRgFo/xX5ZE2TungcXDU
        xTb3xGmVi12E18750q30vtORS+0hL85gNZo7rydVbm5ZoYrSQPmKA0rSupRHqeaetfl9CzES
        AY8KjqU1b+3L9I1WDA8eCPYvEbSqjSHbEaYLZe5kigPPw081Y4u71h536zTdfDOn0E0d/hUY
        dD0aBQ9kyu1bVWxL12K1FGdjZF4nMCUr+ws7TFlTfgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd3zMvfiDCafMrDobZrOZPHm8TNm
        i2NtT9gtpj58wmbxY95hNout/bdYLJoXr2ez2LFdxGLV1J0sFpd3zWGz+Nx7hNHiw66rzBZn
        lvcwW8z6+IPVYu6XqcwWXYf+sjkIeGzbvY3VY828NYweO2fdZfdYsKnUY9OqTjaPeScDPfbP
        XcPu0f/XwOP4je1MHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlXPx4lqXglXXF774lrA2M3w26GDk5JARMJF4f287YxcjFISSwlFHi
        eccGZoiEuMTu+W+hbGGJP9e62CCK3jJKnDp0lQkkISyQKPH87TtWEFsEyN41vZsZpIhZ4BOT
        xOeje6DGtjJL7F39ig2kik1AU+Lv5ptgNq+AncTi2wvAbBYBFYn5Wx6ATRUViJVYfa2VEaJG
        UOLkzCcsIDYn0K1PTz4Dq2EWMJOYt/khM4QtL7H97RwoW1yi6ctK1gmMQrOQtM9C0jILScss
        JC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEb/tmM/N+9gvLQx+BCjAAejEg/vDfF7
        cUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgYsoriTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAYzLyyhHHJnEzdafXckp2z
        /k1eLWi0Z47CUa3lDoyZn25ty9Z39H+YP+nj5/QNM/O0fgj9sRO1ztx0RmDm5VOiUY0Ps3cf
        3Nt9aul3qe/Gm//szTVwar4WvTHm66sMV0Mj98y4z2vCpQL/xslvbHz+VdH+56bP7luSNbV4
        75/UbznLlXHN3W2GEktxRqKhFnNRcSIA8k+vgBQDAAA=
X-CMS-MailID: 20200608111111eucas1p2907107d768c5ce0e1101581eb5f834ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200608091722eucas1p2fa8a4ac15c70e5a6e03c4babdf9f96b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200608091722eucas1p2fa8a4ac15c70e5a6e03c4babdf9f96b7
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
        <20200325032901.29551-1-saravanak@google.com>
        <20200325125120.GX1922688@smile.fi.intel.com>
        <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
        <20200326163110.GD1922688@smile.fi.intel.com>
        <CGME20200608091722eucas1p2fa8a4ac15c70e5a6e03c4babdf9f96b7@eucas1p2.samsung.com>
        <20200608091712.GA28093@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 08.06.2020 11:17, Marco Felsch wrote:
> On 20-03-26 18:31, Andy Shevchenko wrote:
>> On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
>>> On 25/03/2020 12:51, Andy Shevchenko wrote:
>>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>>> Consider the following scenario.
>>>>>>
>>>>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>>>>> functional dependencies on certain platform:
>>>>>> - ULPI (tusb1210)
>>>>>> - extcon (tested with extcon-intel-mrfld)
>>>>>>
>>>>>> Note, that first driver, tusb1210, is available at the moment of
>>>>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>>>>> won't appear till user space does something about it.
>>>>>>
>>>>>> This is depicted by kernel configuration excerpt:
>>>>>>
>>>>>> 	CONFIG_PHY_TUSB1210=y
>>>>>> 	CONFIG_USB_DWC3=y
>>>>>> 	CONFIG_USB_DWC3_ULPI=y
>>>>>> 	CONFIG_USB_DWC3_DUAL_ROLE=y
>>>>>> 	CONFIG_USB_DWC3_PCI=y
>>>>>> 	CONFIG_EXTCON_INTEL_MRFLD=m
>>>>>>
>>>>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>>>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>>>>> probed first followed by extcon one.
>>>>>>
>>>>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>>>>> we will get deferred probe of USB OTG, because of ordering.
>>>>>>
>>>>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>>>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>>>>> we never advance the situation -- the change makes it to be an infinite loop.
>>>>> Hi Andy,
>>>>>
>>>>> I'm trying to understand this sequence of steps. Sorry if the questions
>>>>> are stupid -- I'm not very familiar with USB/PCI stuff.
>>>> Thank you for looking into this. My answer below.
>>>>
>>>> As a first thing I would like to tell that there is another example of bad
>>>> behaviour of deferred probe with no relation to USB. The proposed change also
>>>> fixes that one (however, less possible to find in real life).
>>>>
>>>>>> ---8<---8<---
>>>>>>
>>>>>> [   22.187127] driver_deferred_probe_trigger <<< 1
>>>>>>
>>>>>> ...here is the late initcall triggers deferred probe...
>>>>>>
>>>>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>>>>>>
>>>>>> ...dwc3.0.auto is the only device in the deferred list...
>>>>> Ok, dwc3.0.auto is the only unprobed device at this point?
>>>> Correct.
>>>>
>>>>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>>>>>>
>>>>>> ...the counter before mutex is unlocked is kept the same...
>>>>>>
>>>>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>>>>>>
>>>>>> ...mutes has been unlocked, we try to re-probe the driver...
>>>>>>
>>>>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
>>>>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
>>>>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
>>>>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
>>>>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
>>>>>> [   22.263723] driver_deferred_probe_trigger <<< 2
>>>>>>
>>>>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>>>>>>
>>>>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
>>>>> So where did this dwc3.0.auto.ulpi come from?
>>>>> Looks like the device is created by dwc3_probe() through this call flow:
>>>>> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
>>>>> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
>>>> Correct.
>>>>
>>>>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>>>> Can you please point me to which code patch actually caused the probe
>>>>> deferral?
>>>> Sure, it's in drd.c.
>>>>
>>>> if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>>>     edev = extcon_get_extcon_dev(name);
>>>>     if (!edev)
>>>>       return ERR_PTR(-EPROBE_DEFER);
>>>>     return edev;
>>>> }
>>>>
>>>>>> ...but extcon driver is still missing...
>>>>>>
>>>>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>>>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>>>> I'm not fully aware of all the USB implications, but if extcon is
>>>>> needed, why can't that check be done before we add and probe the ulpi
>>>>> device? That'll avoid this whole "fake" probing and avoid the counter
>>>>> increase. And avoid the need for this patch that's touching the code
>>>>> code that's already a bit delicate.
>>>>> Also, with my limited experience with all the possible drivers in the
>>>>> kernel, it's weird that the ulpi device is added and probed before we
>>>>> make sure the parent device (dwc3.0.auto) can actually probe
>>>>> successfully.
>>>> As I said above the deferred probe trigger has flaw on its own.
>>>> Even if we fix for USB case, there is (and probably will be) others.
>>> Right here is the driver design bug. A driver's probe() hook should *not*
>>> return -EPROBE_DEFER after already creating child devices which may have
>>> already been probed.
>> Any documentation statement for this requirement?
>>
>> By the way, I may imagine other mechanisms that probe the driver on other CPU
>> at the same time (let's consider parallel modprobes). The current code has a
>> flaw with that.
> Hi,
>
> sorry for picking this up again but I stumbled above the same issue
> within the driver imx/drm driver which is using the component framework.
> I end up in a infinity boot loop if I enabled the HDMI (which is the
> DesignWare bridge device) and the LVDS support and the LVDS bind return
> with EPROBE_DEFER. There are no words within the component framework docs
> which says that this is forbidden. Of course we can work-around the
> driver-core framework but IMHO this shouldn't be the way to go. I do not
> say that we should revert the commit introducing the regression but we
> should address this not only by extending the docs since the most
> drm-drivers are using the component framework and can end up in the same
> situation.

I am not sure why do you think this is similar issue.

Please describe the issue in more detail. Which drivers defers probe and 
why, and why do you have infinite loop.

In general deferring probe from bind is not forbidden, but it should be 
used carefully (as everything in kernel :) ). Fixing deferring probe 
issues in many cases it is a matter of figuring out 'dependency loops' 
and breaking them by splitting device initialization into more than one 
phase.


Regards

Andrzej


>
>>> It can be solved by refactoring the driver probe routine. If a resource is
>>> required to be present, then check that it is available early; before
>>> registering child devices.
>> We fix one and leave others.
> E.g. the imx-drm and the sunxi driver...
>
> Regards,
>    Marco
>
>>> The proposed solution to modify driver core is fragile and susceptible to
>>> side effects from other probe paths. I don't think it is the right approach.
>> Have you tested it on your case? Does it fix the issue?
>>
