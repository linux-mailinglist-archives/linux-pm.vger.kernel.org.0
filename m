Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53681F3B48
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgFINCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:02:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59581 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgFINCR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:02:17 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200609130214euoutp016543135e981ee83354bf85faaebc8e07~W4cBDUdq93101431014euoutp01N
        for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2020 13:02:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200609130214euoutp016543135e981ee83354bf85faaebc8e07~W4cBDUdq93101431014euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591707734;
        bh=TEP3CaKCF/8EHcVQZKWGjIug5pe+/v8Yfjcj3hfOsyw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VXqZoe+APUS5XXV838eR0iOF2YrlstGFHctkqBtwz/aGkvzvRoAArDforpSpc1NEs
         o6eQPLmLZhzcqpxIll+AcGPXI8z1PbDBpZGlIT9a4fBaErTZ0NIuIcwcrrWFv044kZ
         iZVE/3A6RDWQSUO7u5UnZTqzJ3e4ECySQrtlv+x8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200609130213eucas1p15ef9392af98ae24e36ecb6deb436fce5~W4cAqnmdK2108221082eucas1p1t;
        Tue,  9 Jun 2020 13:02:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 22.D2.60698.5588FDE5; Tue,  9
        Jun 2020 14:02:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200609130213eucas1p21a6c3ce6a0a0c47c8415dfed5e515def~W4cAREr-I0936709367eucas1p2l;
        Tue,  9 Jun 2020 13:02:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200609130213eusmtrp243a4f42078299f9f813dd3c5b948fe95~W4cAQJYJC1791317913eusmtrp2Z;
        Tue,  9 Jun 2020 13:02:13 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-a2-5edf88556086
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.03.08375.5588FDE5; Tue,  9
        Jun 2020 14:02:13 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200609130212eusmtip20a30ff72a9370bdbb70b7bc1abfa53ba~W4b-MVaLQ0625706257eusmtip2F;
        Tue,  9 Jun 2020 13:02:12 +0000 (GMT)
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
Message-ID: <12859a82-6402-71fc-7d51-20ec40999f88@samsung.com>
Date:   Tue, 9 Jun 2020 15:02:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609121029.nfhgilpu5meoygoa@pengutronix.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm23d2dhwujsvYi1nRKiijq/74IBsVRYeCyiKJsNWpjlPSKZuX
        rB9FF1srM4RhrVxlFy+stJnzUimt0sTUKATNanntql10ptEqt2Pkv+f53ud53veBj8HKfmkI
        E69PEQx6PkFNyyln3WjLgq0mt3bx8MP5JOtIroR87u7DpC6zR0YsnT00GbE9pEl59kuKHL1a
        QpPKimBSbKmiyIvqizQZzHqEyNfqVkyeFpzGxPptREryhiyYmF1eegXLOe86pZzdZkdclfW1
        jLvsSOUcxSdpztYQxdXm2WVctncxV99WIeEGHdM3ybfLI/cKCfFpgmGRZpc8brg1S5Z8N3r/
        mdI3+DDKXmtGAQywEZCf+VhqRnJGyRYiuFd+TSKSIQQ3LnweJ4MIzg90S/9ZTBWecUsBgrOt
        OTKRfEFQ+cUl8akmszy86x/wO4LZMPCe+ON3YLYAw+hRO/YNaHYeeMvaaR9WsBq45XRQPkyx
        s6Hj/bA/aAq7A067P2JREwQN53v8mgB2OZw0XfdjzM6Aiv6LWMQqODJU5F8GrIWB+222McKM
        kdVw1aYRK0yGj/V3ZCIOhT9VlyQiPgTuwmNY9JoQlJdWYXGwDF41/6R9OXjs6JLqReLzSjCV
        nMJi/CRo6w8ST5gEOc7c8WcFmDKVonomuJvKxwNVcP2Zhz6L1NYJxawTylgnlLH+33sZUcVI
        JaQaE3WCMVwvpC808onGVL1u4Z6kRAca+4SNv+s9lajm124XYhmkDlRsi3drlVI+zZiR6ELA
        YHWwYlVTo1ap2MtnHBAMSTsNqQmC0YWmMpRapQjP/7BDyer4FGGfICQLhn9TCRMQchhFhD5K
        iGTOzeiFab100kaNN6Wr5cl63a9L0elzdBHHHBHM8QO5mtDm0KHknE+C/Obcmttr7nlUDfq3
        tXZeT8VGtZdhc+fgc9XKwCLblQ7tz0YyGrNz4EpsZHTMgw26vu/m96MxdVv6yvIDPy2lZ9m0
        54JGuhQHg9f9qG0/szkuXU0Z4/glYdhg5P8CVaDGY4ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Pd3QjvtxBk17hC16m6YzWbx5/IzZ
        4ljbE3aLqQ+fsFn8mHeYzWJr/y0Wi+bF69ksdmwXsVg1dSeLxeVdc9gsPvceYbT4sOsqs8WZ
        5T3MFrM+/mC1mPtlKrNF16G/bA4CHtt2b2P1WDNvDaPHzll32T0WbCr12LSqk81j3slAj/1z
        17B79P818Dh+YzuTx+dNcgFcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
        +nY2Kak5mWWpRfp2CXoZ3672shfsDqvo23CPuYGx372LkZNDQsBEomP7V9YuRi4OIYGljBLH
        f09ghEiIS+ye/5YZwhaW+HOtiw2i6C2jxPrbC1lAEsICiRLP375jBbFFBLQk/rb/B5vELLCc
        WaL51FRGiI6rLBIT/i8Dq2IT0JT4u/kmG4jNK2AnsW7bJrBJLAIqErdffGMCsUUFYiW6F/9g
        h6gRlDg58wlYDaeArURnx1Iwm1nATGLe5ofMELa8xPa3c6BscYmmLytZJzAKzULSPgtJyywk
        LbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGP3bjv3cvIPx0sbgQ4wCHIxKPLwR
        mffjhFgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cDElFcS
        b2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVHp3NfA00vXvPN9+2Op
        lObyX/dPL5ycJHN369z0O9/Mrr19bPlZ4o2UxRsrg4cLnrm9PWp1d1voas012p5xAcsvn7lz
        aNaiQ7uuXrgv6rHqyAS22TrnVI/ONUxgXdN5h+G5SLYk++knYSoTxH7u3bXM08gsO+Put/PL
        PeIML078HnLpYHCsyw/Ve0osxRmJhlrMRcWJALJp8xkUAwAA
X-CMS-MailID: 20200609130213eucas1p21a6c3ce6a0a0c47c8415dfed5e515def
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
        <b413d39f-71c4-d291-276d-1087baf07080@samsung.com>
        <20200609121029.nfhgilpu5meoygoa@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 09.06.2020 14:10, Marco Felsch wrote:
> On 20-06-09 11:27, Andrzej Hajda wrote:
>> On 09.06.2020 08:45, Marco Felsch wrote:
>>> On 20-06-08 13:11, Andrzej Hajda wrote:
>>>> On 08.06.2020 11:17, Marco Felsch wrote:
>>>>> On 20-03-26 18:31, Andy Shevchenko wrote:
>>>>>> On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
>>>>>>> On 25/03/2020 12:51, Andy Shevchenko wrote:
>>>>>>>> On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
>>>>>>>>> On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>>>> Consider the following scenario.
>>>>>>>>>>
>>>>>>>>>> The main driver of USB OTG controller (dwc3-pci), which has the following
>>>>>>>>>> functional dependencies on certain platform:
>>>>>>>>>> - ULPI (tusb1210)
>>>>>>>>>> - extcon (tested with extcon-intel-mrfld)
>>>>>>>>>>
>>>>>>>>>> Note, that first driver, tusb1210, is available at the moment of
>>>>>>>>>> dwc3-pci probing, while extcon-intel-mrfld is built as a module and
>>>>>>>>>> won't appear till user space does something about it.
>>>>>>>>>>
>>>>>>>>>> This is depicted by kernel configuration excerpt:
>>>>>>>>>>
>>>>>>>>>> 	CONFIG_PHY_TUSB1210=y
>>>>>>>>>> 	CONFIG_USB_DWC3=y
>>>>>>>>>> 	CONFIG_USB_DWC3_ULPI=y
>>>>>>>>>> 	CONFIG_USB_DWC3_DUAL_ROLE=y
>>>>>>>>>> 	CONFIG_USB_DWC3_PCI=y
>>>>>>>>>> 	CONFIG_EXTCON_INTEL_MRFLD=m
>>>>>>>>>>
>>>>>>>>>> In the Buildroot environment the modules are probed by alphabetical ordering
>>>>>>>>>> of their modaliases. The latter comes to the case when USB OTG driver will be
>>>>>>>>>> probed first followed by extcon one.
>>>>>>>>>>
>>>>>>>>>> So, if the platform anticipates extcon device to be appeared, in the above case
>>>>>>>>>> we will get deferred probe of USB OTG, because of ordering.
>>>>>>>>>>
>>>>>>>>>> Since current implementation, done by the commit 58b116bce136 ("drivercore:
>>>>>>>>>> deferral race condition fix") counts the amount of triggered deferred probe,
>>>>>>>>>> we never advance the situation -- the change makes it to be an infinite loop.
>>>>>>>>> Hi Andy,
>>>>>>>>>
>>>>>>>>> I'm trying to understand this sequence of steps. Sorry if the questions
>>>>>>>>> are stupid -- I'm not very familiar with USB/PCI stuff.
>>>>>>>> Thank you for looking into this. My answer below.
>>>>>>>>
>>>>>>>> As a first thing I would like to tell that there is another example of bad
>>>>>>>> behaviour of deferred probe with no relation to USB. The proposed change also
>>>>>>>> fixes that one (however, less possible to find in real life).
>>>>>>>>
>>>>>>>>>> ---8<---8<---
>>>>>>>>>>
>>>>>>>>>> [   22.187127] driver_deferred_probe_trigger <<< 1
>>>>>>>>>>
>>>>>>>>>> ...here is the late initcall triggers deferred probe...
>>>>>>>>>>
>>>>>>>>>> [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
>>>>>>>>>>
>>>>>>>>>> ...dwc3.0.auto is the only device in the deferred list...
>>>>>>>>> Ok, dwc3.0.auto is the only unprobed device at this point?
>>>>>>>> Correct.
>>>>>>>>
>>>>>>>>>> [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
>>>>>>>>>>
>>>>>>>>>> ...the counter before mutex is unlocked is kept the same...
>>>>>>>>>>
>>>>>>>>>> [   22.205663] platform dwc3.0.auto: Retrying from deferred list
>>>>>>>>>>
>>>>>>>>>> ...mutes has been unlocked, we try to re-probe the driver...
>>>>>>>>>>
>>>>>>>>>> [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
>>>>>>>>>> [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
>>>>>>>>>> [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
>>>>>>>>>> [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
>>>>>>>>>> [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
>>>>>>>>>> [   22.263723] driver_deferred_probe_trigger <<< 2
>>>>>>>>>>
>>>>>>>>>> ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
>>>>>>>>>>
>>>>>>>>>> [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
>>>>>>>>> So where did this dwc3.0.auto.ulpi come from?
>>>>>>>>> Looks like the device is created by dwc3_probe() through this call flow:
>>>>>>>>> dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
>>>>>>>>> dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
>>>>>>>> Correct.
>>>>>>>>
>>>>>>>>>> [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
>>>>>>>>> Can you please point me to which code patch actually caused the probe
>>>>>>>>> deferral?
>>>>>>>> Sure, it's in drd.c.
>>>>>>>>
>>>>>>>> if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>>>>>>>       edev = extcon_get_extcon_dev(name);
>>>>>>>>       if (!edev)
>>>>>>>>         return ERR_PTR(-EPROBE_DEFER);
>>>>>>>>       return edev;
>>>>>>>> }
>>>>>>>>
>>>>>>>>>> ...but extcon driver is still missing...
>>>>>>>>>>
>>>>>>>>>> [   22.283174] platform dwc3.0.auto: Added to deferred list
>>>>>>>>>> [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
>>>>>>>>> I'm not fully aware of all the USB implications, but if extcon is
>>>>>>>>> needed, why can't that check be done before we add and probe the ulpi
>>>>>>>>> device? That'll avoid this whole "fake" probing and avoid the counter
>>>>>>>>> increase. And avoid the need for this patch that's touching the code
>>>>>>>>> code that's already a bit delicate.
>>>>>>>>> Also, with my limited experience with all the possible drivers in the
>>>>>>>>> kernel, it's weird that the ulpi device is added and probed before we
>>>>>>>>> make sure the parent device (dwc3.0.auto) can actually probe
>>>>>>>>> successfully.
>>>>>>>> As I said above the deferred probe trigger has flaw on its own.
>>>>>>>> Even if we fix for USB case, there is (and probably will be) others.
>>>>>>> Right here is the driver design bug. A driver's probe() hook should *not*
>>>>>>> return -EPROBE_DEFER after already creating child devices which may have
>>>>>>> already been probed.
>>>>>> Any documentation statement for this requirement?
>>>>>>
>>>>>> By the way, I may imagine other mechanisms that probe the driver on other CPU
>>>>>> at the same time (let's consider parallel modprobes). The current code has a
>>>>>> flaw with that.
>>>>> Hi,
>>>>>
>>>>> sorry for picking this up again but I stumbled above the same issue
>>>>> within the driver imx/drm driver which is using the component framework.
>>>>> I end up in a infinity boot loop if I enabled the HDMI (which is the
>>>>> DesignWare bridge device) and the LVDS support and the LVDS bind return
>>>>> with EPROBE_DEFER. There are no words within the component framework docs
>>>>> which says that this is forbidden. Of course we can work-around the
>>>>> driver-core framework but IMHO this shouldn't be the way to go. I do not
>>>>> say that we should revert the commit introducing the regression but we
>>>>> should address this not only by extending the docs since the most
>>>>> drm-drivers are using the component framework and can end up in the same
>>>>> situation.
>>>> I am not sure why do you think this is similar issue.
>>> Because I see trying to bind the device over and over..
>>>
>>>> Please describe the issue in more detail. Which drivers defers probe and
>>>> why, and why do you have infinite loop.
>>> As said I'm currently on the imx-drm driver. The iMX6 devices are
>>> using the synopsis HDMI IP core and so they are using this bridge device
>>> driver (drivers/gpu/drm/bridge/synopsys/). The imx-drm driver can be
>>> build module wise. As example I enabled the LDB and the HDMI support.
>>> The HDMI driver is composed as platform driver with different
>>> (sub-)drivers and devices. Those devices are populated by the HDMI core
>>> driver _probe() function and triggers a driver_deferred_probe_trigger()
>>> after the driver successfully probed. The LDB driver bind() returns
>>> -EPROBE_DEFER because the panel we are looking for depends on a defered
>>> regulator device. Now the defered probe code tries to probe the defered
>>> devices again because the local-trigger count was changed by the HDMI
>>> driver and we are in the never ending loop.
>>>
>>>> In general deferring probe from bind is not forbidden, but it should be
>>>> used carefully (as everything in kernel :) ). Fixing deferring probe
>>>> issues in many cases it is a matter of figuring out 'dependency loops'
>>>> and breaking them by splitting device initialization into more than one
>>>> phase.
>>> We are on the way of splitting the imx-drm driver but there are many
>>> other DRM drivers using the component framework. As far as I can see the
>>> sunxi8 driver is component based and uses the same HDMI driver. I'm with
>>> Andy that we should fix that on the common/core place.
>>
>> I have looked at the drivers and I see the main issue I see is that imx
>> drivers performs resource acquisition in bind phase.
> As I said we are working on this.
>
>> I think rule of
>> thumb should be "do not expose yourself, until you are ready", which in
>> this case means "do not call component_add, until resources are
>> acquired" - ie resource acquisition should be performed in probe.
> Hm.. there are is no documentation which forbid this use-case. I thought
> that the component framework bind() equals the driver probe() function..


In this particular case (components vs deferred probe interaction) I 
guess the source code is the only documentation.


>
>> I use
>> this approach mainly to avoid multiple deferred re-probes, but it should
>> solve also this issue, so even if there will be solution to "deferred
>> probe issues" in core it would be good to fix imx drivers.
> Pls, see my above comments. It is not only the imx driver. Also we
> shouldn't expect that driver-developers will follow a rule which is
> not written somewhere.


As I wrote above this is only my advice and my experience, if you have 
better idea regarding drivers/documentation/core please post appropriate 
patches.


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
>>> Regards,
>>>     Marco
>>>
>>>> Regards
>>>>
>>>> Andrzej
>>>>
>>>>
>>>>>>> It can be solved by refactoring the driver probe routine. If a resource is
>>>>>>> required to be present, then check that it is available early; before
>>>>>>> registering child devices.
>>>>>> We fix one and leave others.
>>>>> E.g. the imx-drm and the sunxi driver...
>>>>>
>>>>> Regards,
>>>>>      Marco
>>>>>
>>>>>>> The proposed solution to modify driver core is fragile and susceptible to
>>>>>>> side effects from other probe paths. I don't think it is the right approach.
>>>>>> Have you tested it on your case? Does it fix the issue?
>>>>>>
