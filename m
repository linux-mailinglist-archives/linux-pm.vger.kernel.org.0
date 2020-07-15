Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E766C220CEB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgGOMal (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:30:41 -0400
Received: from foss.arm.com ([217.140.110.172]:52172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgGOMal (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 08:30:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10B5130E;
        Wed, 15 Jul 2020 05:30:40 -0700 (PDT)
Received: from [10.57.32.45] (unknown [10.57.32.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 847AC3F66E;
        Wed, 15 Jul 2020 05:30:38 -0700 (PDT)
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
To:     Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Denis Sadykov <denis.m.sadykov@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dominik Brodowski <linux@brodo.de>
References: <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell> <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
 <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell>
 <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
 <20200715115029.GC3165313@dell>
 <CAJZ5v0hJf2BwDvmtD6UEyyxm-CGcA=SLmAt+F8Sr0ceDZji0jw@mail.gmail.com>
 <20200715121657.GE3165313@dell>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4ba45e6b-7c49-7a7b-ae76-12d912629e4d@arm.com>
Date:   Wed, 15 Jul 2020 13:30:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715121657.GE3165313@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-15 13:16, Lee Jones wrote:
> On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> 
>> On Wed, Jul 15, 2020 at 1:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>>>
>>> On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
>>>
>>>> On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
>>>>>
>>>>> On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
>>>>>
>>>>>> On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>>>>
>>>>>>> On 15-07-20, 08:54, Viresh Kumar wrote:
>>>>>>>> On 14-07-20, 22:03, Lee Jones wrote:
>>>>>>>>> On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
>>>>>>>>>
>>>>>>>>>> On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Can't see them being used anywhere and the compiler doesn't complain
>>>>>>>>>>> that they're missing, so ...
>>>>>>>>>>
>>>>>>>>>> Aren't they needed for automatic module loading in certain configurations?
>>>>>>>>>
>>>>>>>>> Any idea how that works, or where the code is for that?
>>>>>>>>
>>>>>>>> The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
>>>>>>>> product-id that the kernel keeps after boot (and so there is no static
>>>>>>>> reference of it for the compiler), later when a device is hotplugged
>>>>>>>> into the kernel it refers to the map to find the related driver for it
>>>>>>>> and loads it if it isn't already loaded.
>>>>>>>>
>>>>>>>> This has some of it, search for MODULE_DEVICE_TABLE() in it.
>>>>>>>> Documentation/driver-api/usb/hotplug.rst
>>>>>>>
>>>>>>> And you just need to add __maybe_unused to them to suppress the
>>>>>>> warning.
>>>>>>
>>>>>> Wouldn't that cause the compiler to optimize them away if it doesn't
>>>>>> see any users?
>>>>>
>>>>> It looks like they're only unused when !MODULE,
>>>>
>>>> OK
>>>>
>>>>> in which case optimising them away would be the correct thing to do, no?
>>>
>>> It would be good if someone with a little more knowledge could provide
>>> a second opinion though.  I would think (hope) that the compiler would
>>> be smart enough to see when its actually in use.  After all, it is the
>>> compiler that places the information into the device table.
>>>
>> If that is not the case, then the MODULE_DEVICE_TABLE() magic is
>>> broken and will need fixing.
>>
>> I'm not sure why that would be the case?
> 
> Nor me.  In fact, take a look at my latest email.  I think I just
> proved out that it's not broken.  The warning is valid and
> MODULE_DEVICE_TABLE() appears to work just as it should.

I won't claim to be an expert at all, but...

For !MODULE, MODULE_DEVICE_TABLE() expands to nothing, so after 
preprocessing the static variable is literally unreferenced.

Otherwise, MODULE_DEVICE_TABLE() emits an extern declaration of another 
variable which is defined via the "alias" attribute to refer to the 
symbol of the static variable. Thus the compiler presumably has to treat 
it as potentially accessible from other compilation units such that it 
can't be optimised away.

>>> Removing boiler-plate is good, but not at the expense of obfuscation.
>>
>> I'm not following you here to be honest.
> 
> Never mind.  It's no longer important.
> 
>> BTW, I'm wondering if removing the "static" modifier from the
>> definitions of the structures in question makes the warnings you want
>> to get rid of go away.
> 
> I'm sure that it would.  But that just alludes to the fact that the
> tables may be in use elsewhere, which in the case of !MODULE is
> untrue.  That's probably more of a hack than using __maybe_unused.

Right, that just ends up with someone sending another patch changing it 
back to shut up "variable foo was not declared, should it be static?" 
warnings from Sparse ;)

Robin.
