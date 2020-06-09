Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA521F370A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgFIJ1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 05:27:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59074 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgFIJ1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 05:27:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200609092715euoutp018f6a44bbbc410a6eaa12d9139f9e9818~W1gT7MRda0734207342euoutp01U
        for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2020 09:27:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200609092715euoutp018f6a44bbbc410a6eaa12d9139f9e9818~W1gT7MRda0734207342euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591694835;
        bh=1oTJUZTGUemYBnJ4VGwd/IwzPiruFCXGH1Fd6M1vuV0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZeBgYUOIS8YpJTOJGWDInud97ioi+zRxfULhdXPLmwkbIs2pbqLsqUmm4BAhgRfA5
         hkDGNFRcqnKwOqFOIBEIdO0Nc+kRQ5SOzgM538HoCC2jGtRlFnh6anbKjBTvXN2VJ9
         QNwZKrp1Vl5frfc/8LxgmoqDdOEI2THvnCM7alGc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200609092714eucas1p2e2a97cdee4cd9577232da18869a97fea~W1gTgac9D1043010430eucas1p2H;
        Tue,  9 Jun 2020 09:27:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.BE.60698.2F55FDE5; Tue,  9
        Jun 2020 10:27:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200609092713eucas1p2c124ed58ec8ec751bfc8b88df17b9129~W1gSzQ1T31246612466eucas1p2X;
        Tue,  9 Jun 2020 09:27:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609092713eusmtrp2560db55b0d11ae191ee9aa74992646d2~W1gSyS5f41432714327eusmtrp2I;
        Tue,  9 Jun 2020 09:27:13 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-a8-5edf55f2c6f0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.50.08375.1F55FDE5; Tue,  9
        Jun 2020 10:27:13 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200609092712eusmtip1490f8194d82337445d546cf678528a3a~W1gRvtnXv2463424634eusmtip1r;
        Tue,  9 Jun 2020 09:27:12 +0000 (GMT)
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Grant Likely <grant.likely@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        artem.bityutskiy@linux.intel.com, balbi@kernel.org,
        broonie@kernel.org, fntoth@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peter.ujfalusi@ti.com, rafael@kernel.org, kernel-team@android.com,
        nd <nd@arm.com>, kernel@pengutronix.de
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b413d39f-71c4-d291-276d-1087baf07080@samsung.com>
Date:   Tue, 9 Jun 2020 11:27:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609064511.7nek2rhk6ebfjaia@pengutronix.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm23d2dhzOvqayt7KidSEFL1HRiUpNik5EN6J+FGqnPLjIG5va
        5U9SYTo1S1zSvKaZNgRr5tSVRqu8YFZQkV1HJFqRmqldzLXcziT/Pc/zPs/3Pi98DFYOSucy
        R5JSBW0Sn6Cm5ZSl/feT4O977TFhrVcC2bzTRRL268d+zLZn9slYw4c+mv1Vdp9mG/NfU+yZ
        qnqabW7yY02GFop9Zi2h2dG8B4j9Zn2B2Uc1uZg1jvySsqVjBszqbQ46knCW2xYpV1dWh7gW
        4zsZV2FO48ymbJor69rN3S2tk3H5jjCuo7dJwo2aF+yS75evjxMSjqQL2tDwg3KN0f5cklKw
        /fjEPSuVgUoi9MiLAbIKikv1tB7JGSWpReAcn5CJZAxBtSFHKpJRBEMX2qXTkT8/73kGNQju
        XH6FRTKM4GV3B3K5fAkPA4ND7oQfCQLHOac7gUkNht9n6rBrQJNAcDS8mtrOMAoSDvrJrS6Z
        IktgZLiUcmF/Eg259i9uu4LMhq7LfW7di2yA5gGLxIUxWQhNgyVYxCo4PXbdvQuIgYHq4isy
        sfYm+FFyHovYF7503PLoAeBsKZeI+BTYa89iMZyFoPFGiyewDt4+nnAXxVOl662horwRsupz
        sEsG4gO9g7PFDj5QYCnyyArIylSK7kVg72n0PKiC6qfj9AWkNs64zDjjGuOMa4z/91YgyoRU
        QpouMV7QrUwSjoXo+ERdWlJ8yOHkRDOa+oTdfzvGm1Hb5CEbIgxSeyt6Ve9jlFI+XXci0YaA
        wWo/RVRPd4xSEcefOClok2O1aQmCzobmMZRapVhZ+TlaSeL5VOGoIKQI2umphPGam4E06QHX
        yv0dgReDDzxsc74xmoMmh29+0rcy5beifDevWbYje/UiQ+fF/llzTLZ1RcUFKfP7911q+PB4
        pHD5Hk372ugD394tTq50OLd01vJrt0DETr5Ik3G20FHoc3Ug8ujhbdyCONOPZ7O4Kh/l/cD8
        l4uPew9E9fxJWPp31Bq75OHTGjWl0/ArgrBWx/8DJyBYn4ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Xd2PoffjDHbsMbfobZrOZPHm8TNm
        i2NtT9gtpj58wmbxY95hNout/bdYLJoXr2ez2LFdxGLV1J0sFpd3zWGz+Nx7hNHiw66rzBZn
        lvcwW8z6+IPVYu6XqcwWXYf+sjkIeGzbvY3VY828NYweO2fdZfdYsKnUY9OqTjaPeScDPfbP
        XcPu0f/XwOP4je1MHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlzLp/halgkm/Fr4O7WBoY59h3MXJySAiYSPz+fpC1i5GLQ0hgKaPE
        rZ+r2SES4hK7579lhrCFJf5c62KDKHrLKNG9dgkrSEJYIFHi+dt3YLaIgJbE3/b/YJOYBZYz
        SzSfmsoI1cEs0fL/PVgVm4CmxN/NN4FGcXDwCthJdP3xBAmzCKhIfHw/lwXEFhWIlehe/APs
        Cl4BQYmTM5+AxTkFbCV2PN/GBGIzC5hJzNv8kBnClpfY/nYOlC0u0fRlJesERqFZSNpnIWmZ
        haRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjf9uxn5t3MF7aGHyIUYCDUYmH
        94b4vTgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MC3l
        lcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg7Oz95XWbJVNzlZe0
        i6LpXo/ZJYyvL+29ZJFy5jS3YLeiiU7uoyLzg7cq57aw1R5k9bAWc/uy+kba+SO/3kew9Rb7
        Pn7/OeDbEoPo8ocfPx1/OYWpZCPbR7HQ6aoKR/zOni+2azypsL7qXLibt6WE185nsw6ycMod
        lHURfXLeSiG7mXX24t/lSizFGYmGWsxFxYkANWZLlBMDAAA=
X-CMS-MailID: 20200609092713eucas1p2c124ed58ec8ec751bfc8b88df17b9129
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
        <437de51b-37e9-d8d1-19c7-137a9265bf45@samsung.com>
        <20200609064511.7nek2rhk6ebfjaia@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 09.06.2020 08:45, Marco Felsch wrote:
> On 20-06-08 13:11, Andrzej Hajda wrote:
>> On 08.06.2020 11:17, Marco Felsch wrote:
>>> On 20-03-26 18:31, Andy Shevchenko wrote:
>>>> On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
>>>>> On 25/03/2020 12:51, Andy Shevchenko wrote:
>>>>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>>>>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>> Consider the following scenario.
>>>>>>>>
>>>>>>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>>>>>>> functional dependencies on certain platform:
>>>>>>>> - ULPI (tusb1210)
>>>>>>>> - extcon (tested with extcon-intel-mrfld)
>>>>>>>>
>>>>>>>> Note, that first driver, tusb1210, is available at the moment of
>>>>>>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>>>>>>> won't appear till user space does something about it.
>>>>>>>>
>>>>>>>> This is depicted by kernel configuration excerpt:
>>>>>>>>
>>>>>>>> 	CONFIG_PHY_TUSB1210=y
>>>>>>>> 	CONFIG_USB_DWC3=y
>>>>>>>> 	CONFIG_USB_DWC3_ULPI=y
>>>>>>>> 	CONFIG_USB_DWC3_DUAL_ROLE=y
>>>>>>>> 	CONFIG_USB_DWC3_PCI=y
>>>>>>>> 	CONFIG_EXTCON_INTEL_MRFLD=m
>>>>>>>>
>>>>>>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>>>>>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>>>>>>> probed first followed by extcon one.
>>>>>>>>
>>>>>>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>>>>>>> we will get deferred probe of USB OTG, because of ordering.
>>>>>>>>
>>>>>>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>>>>>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>>>>>>> we never advance the situation -- the change makes it to be an infinite loop.
>>>>>>> Hi Andy,
>>>>>>>
>>>>>>> I'm trying to understand this sequence of steps. Sorry if the questions
>>>>>>> are stupid -- I'm not very familiar with USB/PCI stuff.
>>>>>> Thank you for looking into this. My answer below.
>>>>>>
>>>>>> As a first thing I would like to tell that there is another example of bad
>>>>>> behaviour of deferred probe with no relation to USB. The proposed change also
>>>>>> fixes that one (however, less possible to find in real life).
>>>>>>
>>>>>>>> ---8<---8<---
>>>>>>>>
>>>>>>>> [   22.187127] driver_deferred_probe_trigger <<< 1
>>>>>>>>
>>>>>>>> ...here is the late initcall triggers deferred probe...
>>>>>>>>
>>>>>>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>>>>>>>>
>>>>>>>> ...dwc3.0.auto is the only device in the deferred list...
>>>>>>> Ok, dwc3.0.auto is the only unprobed device at this point?
>>>>>> Correct.
>>>>>>
>>>>>>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>>>>>>>>
>>>>>>>> ...the counter before mutex is unlocked is kept the same...
>>>>>>>>
>>>>>>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>>>>>>>>
>>>>>>>> ...mutes has been unlocked, we try to re-probe the driver...
>>>>>>>>
>>>>>>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
>>>>>>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
>>>>>>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
>>>>>>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
>>>>>>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
>>>>>>>> [   22.263723] driver_deferred_probe_trigger <<< 2
>>>>>>>>
>>>>>>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>>>>>>>>
>>>>>>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
>>>>>>> So where did this dwc3.0.auto.ulpi come from?
>>>>>>> Looks like the device is created by dwc3_probe() through this call flow:
>>>>>>> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
>>>>>>> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
>>>>>> Correct.
>>>>>>
>>>>>>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>>>>>> Can you please point me to which code patch actually caused the probe
>>>>>>> deferral?
>>>>>> Sure, it's in drd.c.
>>>>>>
>>>>>> if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>>>>>      edev = extcon_get_extcon_dev(name);
>>>>>>      if (!edev)
>>>>>>        return ERR_PTR(-EPROBE_DEFER);
>>>>>>      return edev;
>>>>>> }
>>>>>>
>>>>>>>> ...but extcon driver is still missing...
>>>>>>>>
>>>>>>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>>>>>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>>>>>> I'm not fully aware of all the USB implications, but if extcon is
>>>>>>> needed, why can't that check be done before we add and probe the ulpi
>>>>>>> device? That'll avoid this whole "fake" probing and avoid the counter
>>>>>>> increase. And avoid the need for this patch that's touching the code
>>>>>>> code that's already a bit delicate.
>>>>>>> Also, with my limited experience with all the possible drivers in the
>>>>>>> kernel, it's weird that the ulpi device is added and probed before we
>>>>>>> make sure the parent device (dwc3.0.auto) can actually probe
>>>>>>> successfully.
>>>>>> As I said above the deferred probe trigger has flaw on its own.
>>>>>> Even if we fix for USB case, there is (and probably will be) others.
>>>>> Right here is the driver design bug. A driver's probe() hook should *not*
>>>>> return -EPROBE_DEFER after already creating child devices which may have
>>>>> already been probed.
>>>> Any documentation statement for this requirement?
>>>>
>>>> By the way, I may imagine other mechanisms that probe the driver on other CPU
>>>> at the same time (let's consider parallel modprobes). The current code has a
>>>> flaw with that.
>>> Hi,
>>>
>>> sorry for picking this up again but I stumbled above the same issue
>>> within the driver imx/drm driver which is using the component framework.
>>> I end up in a infinity boot loop if I enabled the HDMI (which is the
>>> DesignWare bridge device) and the LVDS support and the LVDS bind return
>>> with EPROBE_DEFER. There are no words within the component framework docs
>>> which says that this is forbidden. Of course we can work-around the
>>> driver-core framework but IMHO this shouldn't be the way to go. I do not
>>> say that we should revert the commit introducing the regression but we
>>> should address this not only by extending the docs since the most
>>> drm-drivers are using the component framework and can end up in the same
>>> situation.
>> I am not sure why do you think this is similar issue.
> Because I see trying to bind the device over and over..
>
>> Please describe the issue in more detail. Which drivers defers probe and
>> why, and why do you have infinite loop.
> As said I'm currently on the imx-drm driver. The iMX6 devices are
> using the synopsis HDMI IP core and so they are using this bridge device
> driver (drivers/gpu/drm/bridge/synopsys/). The imx-drm driver can be
> build module wise. As example I enabled the LDB and the HDMI support.
> The HDMI driver is composed as platform driver with different
> (sub-)drivers and devices. Those devices are populated by the HDMI core
> driver _probe() function and triggers a driver_deferred_probe_trigger()
> after the driver successfully probed. The LDB driver bind() returns
> -EPROBE_DEFER because the panel we are looking for depends on a defered
> regulator device. Now the defered probe code tries to probe the defered
> devices again because the local-trigger count was changed by the HDMI
> driver and we are in the never ending loop.
>
>> In general deferring probe from bind is not forbidden, but it should be
>> used carefully (as everything in kernel :) ). Fixing deferring probe
>> issues in many cases it is a matter of figuring out 'dependency loops'
>> and breaking them by splitting device initialization into more than one
>> phase.
> We are on the way of splitting the imx-drm driver but there are many
> other DRM drivers using the component framework. As far as I can see the
> sunxi8 driver is component based and uses the same HDMI driver. I'm with
> Andy that we should fix that on the common/core place.


I have looked at the drivers and I see the main issue I see is that imx 
drivers performs resource acquisition in bind phase. I think rule of 
thumb should be "do not expose yourself, until you are ready", which in 
this case means "do not call component_add, until resources are 
acquired" - ie resource acquisition should be performed in probe. I use 
this approach mainly to avoid multiple deferred re-probes, but it should 
solve also this issue, so even if there will be solution to "deferred 
probe issues" in core it would be good to fix imx drivers.


Regards

Andrzej


>
> Regards,
>    Marco
>
>> Regards
>>
>> Andrzej
>>
>>
>>>>> It can be solved by refactoring the driver probe routine. If a resource is
>>>>> required to be present, then check that it is available early; before
>>>>> registering child devices.
>>>> We fix one and leave others.
>>> E.g. the imx-drm and the sunxi driver...
>>>
>>> Regards,
>>>     Marco
>>>
>>>>> The proposed solution to modify driver core is fragile and susceptible to
>>>>> side effects from other probe paths. I don't think it is the right approach.
>>>> Have you tested it on your case? Does it fix the issue?
>>>>
