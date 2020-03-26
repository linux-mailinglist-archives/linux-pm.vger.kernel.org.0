Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD2193C22
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCZJpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 05:45:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCZJpW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 05:45:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02Q9j8SE074969;
        Thu, 26 Mar 2020 04:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585215908;
        bh=Uo4/pxe9xGciqRZVGsz/aZE4/YhZj0j7qdyZVpdOgus=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fmVv4Jh5C8mEp8bbxg75iaj0fejDJ/FOb2VOQhi9aNdLnLqodRw2w9AhGYQ1ofwQp
         z9NggWO5xWugjVfNEJHAxPMFj3BA3Ag1CDxrd9uzOUkW3cK2EAftHs3dLvUI19Wt0/
         IqoLgKGXbIuDKy89sHrloKa1m+75WuOBLVGBESw8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02Q9j8fC017392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Mar 2020 04:45:08 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 26
 Mar 2020 04:45:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 26 Mar 2020 04:45:08 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02Q9j5hT123802;
        Thu, 26 Mar 2020 04:45:06 -0500
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mark Brown <broonie@kernel.org>, Ferry Toth <fntoth@gmail.com>,
        <grant.likely@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <CAGETcx_TGw24UqX7pXZePyskrao6zwnKTq8mBk9g_7jokqAqkA@mail.gmail.com>
 <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ca661616-f5bf-d92f-9173-172792797b16@ti.com>
Date:   Thu, 26 Mar 2020 11:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jB1hqzYK8ezjf1_1yMCudNXNS-CsrUJQcmL4W5mBD6fQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 26/03/2020 10.39, Rafael J. Wysocki wrote:
> On Wed, Mar 25, 2020 at 11:09 PM Saravana Kannan <saravanak@google.com> wrote:
>>
>> On Wed, Mar 25, 2020 at 5:51 AM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
> 
> [cut]
> 
>>>
>>> Yes, it's (unlikely) possible (*), but it will give one more iteration per such
>>> case. It's definitely better than infinite loop. Do you agree?
>>
>> Sorry I wasn't being clear (I was in a rush). I'm saying this patch
>> can reintroduce the bug where the deferred probe isn't triggered when
>> it should be.
>>
>> Let's take a simple execution flow.
>>
>> probe_okay is at 10.
>>
>> Thread-A
>>   really_probe(Device-A)
>>     local_probe_okay_count = 10
>>     Device-A probe function is running...
>>
>> Thread-B
>>   really_probe(Device-B)
>>     Device-B probes successfully.
>>     probe_okay incremented to 11
>>
>> Thread-C
>>   Device-C (which had bound earlier) is unbound (say module is
>> unloaded or a million other reasons).
>>   probe_okay is decremented to 10.
>>
>> Thread-A continues
>>   Device-A probe function returns -EPROBE_DEFER
>>   driver_deferred_probe_add_trigger() doesn't do anything because
>>     local_probe_okay_count == probe_okay
>>   But Device-A might have deferred probe waiting on Device-B.
>>   Device-A never probes.
>>
>>> *) It means during probe you have _intensive_ removing, of course you may keep
>>> kernel busy with iterations, but it has no practical sense. DoS attacks more
>>> effective in different ways.
>>
>> I wasn't worried about DoS attacks. More of a functional correctness
>> issue what I explained above.
> 
> The code is functionally incorrect as is already AFAICS.
> 
>> Anyway, if your issue and similar issues can be handles in driver core
>> in a clean way without breaking other cases, I don't have any problem
>> with that. Just that, I think the current solution breaks other cases.
> 
> OK, so the situation right now is that commit 58b116bce136 has
> introduced a regression and so it needs to be fixed or reverted.  The
> cases that were previously broken and were unbroken by that commit
> don't matter here, so you cannot argue that they would be "broken".

commit 58b116bce136 is from 2014 and the whole ULPI support for dwc3
came in a year later.
While I agree that 58b116bce136 fail to handle came a year later, but
technically it did not introduced a regression.

The revert on the other hand is going to introduce a regression as
things were working fine since 2014. Not sure why the dwc3 issue got
this long to be noticed as the 58b116bce136 was already in kernel when
the ULPI support was added...

> It looks to me like the original issue fixed by the commit in question
> needs to be addressed differently, so I would vote for reverting it
> and starting over.

Fwiw my original approach was a bit different:
https://lore.kernel.org/patchwork/patch/454800/

Greg changed it to what ended up in the kernel:
https://lore.kernel.org/patchwork/cover/454799/

>> As an alternate solution, assuming "linux,extcon-name" is coming
>> from some firmware, you might want to look into the fw_devlink
>> feature.
> 
> That would be a workaround for a driver core issue, though, wouldn't it?
> 
>> That feature allows driver core to add device links from firmware
>> information. If you can get that feature to create device links from
>> your dwc3.0.auto (or its parent pci_dev?) to the extcon supplier
>> device, all of this can be sidestepped and your dwc3.0.auto's (or the
>> dwc pci_dev's) probe will be triggered only after extcon is probed.
>>
>> I have very little familiarity with PCI/ACPI. I spent about an hour or
>> two poking at ACPI scan/property code. The relationship between a
>> pci_dev and an acpi_device is a bit confusing to me because I see:
>>
>> static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>> {
>>         struct property_entry *p = (struct property_entry *)id->driver_data;
>>         struct dwc3_pci         *dwc;
>>         struct resource         res[2];
>>         int                     ret;
>>         struct device           *dev = &pci->dev;
>> ....
>>         dwc->dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
>> ....
>>         ACPI_COMPANION_SET(&dwc->dwc3->dev, ACPI_COMPANION(dev));
>>
>> And ACPI_COMPANION returns an acpi_device by looking at dev->fwnode.
>> So how the heck is a pci_device.dev.fwnode pointing to an
>> acpi_device.fwnode?
> 
> acpi_device is an of_node counterpart (or it is an fwnode itself if you will).
> 
> Thanks!
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
