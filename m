Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB36295F0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Nov 2022 11:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiKOKeD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Nov 2022 05:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiKOKd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2022 05:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8624F07
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 02:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668508375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbJbC3373kkrEOKgcv9UmDhvbvwdApWRUuMA85jnOVI=;
        b=M8+JeVjG3OugtN13z2c/NP4rF+6ZaW2SyXIVIizv7oKYCHyCm3i/AlLNg1wpcwLciYvvoi
        tfPAPJZilzPV9Op+LXG3pD5kdkYPNIjV4rS3zRHboe1nA9LBrPoS5FDeZfLVtOMoUtUXsK
        hhSwn+6LNboCnti/eCEXDgTHtxYXINc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-B7Me3IrPNliITI3NuRCLQw-1; Tue, 15 Nov 2022 05:32:35 -0500
X-MC-Unique: B7Me3IrPNliITI3NuRCLQw-1
Received: by mail-ej1-f72.google.com with SMTP id hq18-20020a1709073f1200b007ade8dd3494so6952826ejc.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 02:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbJbC3373kkrEOKgcv9UmDhvbvwdApWRUuMA85jnOVI=;
        b=Zoysr+odEyno7OJtbphRKwHeq7e8fQVKL9Hl8DIm+55id/X3//LQ0SVATC4tAGNCNz
         pEAm6n27VPBiVEsc2Zl+XyfJqssHGuqd8BnAkY8VKfAz+BWMWEGHq98eIVUbVgvzala2
         u/xf6uwbDWIouoNL8M7SMYUbiddSoIxB/adAbU6TlgLPkKkDZ+z+FIRWCHwTIFp00Goe
         +ywmojWs7YzRe/rrcvXaxJJBtgv7OdzJtOG9gC4XzvB2sM03fYSsC0CKrjMIrs5Q2mWA
         jyXEQ7Z18eO4LNGWACQyYdoXkcfLirN2Z9kWaW9rSf7tNkyMBXtAOj4INorZDtC4GYvc
         4NfA==
X-Gm-Message-State: ANoB5plj9xMA00JTcKWI/yMOS/JH7r5O2v4dtEqVqBsGibv7JNv5Uiiy
        y5FuKdsmfftMv19vSScPQoFoP4DgKlkekt4zPmNFCRlQIKSIvm0xIJufPhi4f+mrF9dh1hEhWRK
        oruheaepQpwoz0J8zwr0=
X-Received: by 2002:a17:906:7c8d:b0:7af:1233:948d with SMTP id w13-20020a1709067c8d00b007af1233948dmr4023500ejo.698.1668508353979;
        Tue, 15 Nov 2022 02:32:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wJ1VOZdGGU5QOI9zqTMoKSncxewGjF9i9ZaLSzmNXClbiU2E5pCuqCEjPlbmtEutNDNaugQ==
X-Received: by 2002:a17:906:7c8d:b0:7af:1233:948d with SMTP id w13-20020a1709067c8d00b007af1233948dmr4023481ejo.698.1668508353756;
        Tue, 15 Nov 2022 02:32:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id i34-20020a0564020f2200b00458947539desm6050012eda.78.2022.11.15.02.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 02:32:33 -0800 (PST)
Message-ID: <f1bff724-252c-e403-f02b-2fff49b2283f@redhat.com>
Date:   Tue, 15 Nov 2022 11:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Content-Language: en-US, nl
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com> <871qq6tnqx.ffs@tglx>
 <MN0PR12MB6101BB92574BEF0A0AE2AB11E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB6101BB92574BEF0A0AE2AB11E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        TVD_PH_BODY_ACCOUNTS_PRE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mario,

On 11/14/22 20:12, Limonciello, Mario wrote:
> [Public]
> 
> Thanks! Appreciate the comments.
> At least conceptually is there agreement to this idea for the two sysfs files
> and userspace can use them to do this comparison?

First of all let me say that I think that having some generic mechanism
which allows userspace to check if deep enough sleep-state were reached
is a good idea.  And thank you for working on this!

I wonder though if it would not be better to have some mechanism
where a list of sleep states + time spend in each time is printed ?

E.g. I know that on Intel Bay Trail and Cherry Trail devices (just an
example I'm familiar with) there are S0i0 - S0i3 and we really want
to reach S0i3 during suspend.

Sometimes on S0i1 or S0i2 is reached due to some part of the hw
not getting suspended properly.

So then we have reached "a hardware sleep state over s2idle"
but no the one we want.

OTOH I can image that if we start adding support for functionality
like standby-connect under Linux that then we may not always
reach the deepest hw sleep-state.

So I'm a bit worried that having just a single number for
last_hw_state_residency is not enough.

I think that it might be better to have a mechanism to set
a set of names for hw-states (once) and then set the residency
per state (*) after resume and have the sysfs file print
the entire list.

This list could then also always include the total suspend time,
also avoiding the need for a second sysfs file and we could also
use the same format for non s2idle suspend having it print
only the total suspend time when no hw-state names are set.

Regards,

Hans


*) Using an array, so up to MAX_HW_RESIDENCY_STATES


> 
> A few nested replies below, but I'll clean it up for
> RFC v3 or submit as PATCH v1 if there is conceptual alignment before then.
> 
>> On Thu, Nov 10 2022 at 00:47, Mario Limonciello wrote:
>>
>> 'Add a sysfs files'?
>>
>> Can you please decide whether that's 'a file' or 'multiple files'?
> 
> Yup thanks; bad find and replace in the commit message when I added
> the second file.
> 
>>
>>> Both AMD and Intel SoCs have a concept of reporting whether the
>> hardware
>>> reached a hardware sleep state over s2idle as well as how much
>>> time was spent in such a state.
>>
>> Nice, but ...
>>
>>> This information is valuable to both chip designers and system designers
>>> as it helps to identify when there are problems with power consumption
>>> over an s2idle cycle.
>>>
>>> To make the information discoverable, create a new sysfs file and a symbol
>>> that drivers from supported manufacturers can use to advertise this
>>> information. This file will only be exported when the system supports low
>>> power idle in the ACPI table.
>>>
>>> In order to effectively use this information you will ideally want to
>>> compare against the total duration of sleep, so export a second sysfs file
>>> that will show total time. This file will be exported on all systems and
>>> used both for s2idle and s3.
>>
>> The above is incomprehensible word salad. Can you come up with some
>> coherent explanation of what you are trying to achieve please?
>>
>>> +void pm_set_hw_state_residency(u64 duration)
>>> +{
>>> +	suspend_stats.last_hw_state_residency = duration;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
>>> +
>>> +void pm_account_suspend_type(const struct timespec64 *t)
>>> +{
>>> +	suspend_stats.last_suspend_total += (s64)t->tv_sec *
>> USEC_PER_SEC +
>>> +						 t->tv_nsec /
>> NSEC_PER_USEC;
>>
>> Conversion functions for timespecs to scalar nanoseconds exist for a
>> reason. Why does this need special treatment and open code it?
> 
> Will fixup to use conversion functions.
> 
>>
>>> +}
>>> +EXPORT_SYMBOL_GPL(pm_account_suspend_type);
>>
>> So none of these functions has any kind of documentation. kernel-doc
>> exists for a reason especially for exported functions.
>>
>> That said, what's the justification to export any of these functions at
>> all? AFAICT pm_account_suspend_type() is only used by builtin code...
> 
> I think you're right; they shouldn't export; will fix.
> 
>>
>>> +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct
>> attribute *attr, int idx)
>>> +{
>>> +	if (attr != &last_hw_state_residency.attr)
>>> +		return 0444;
>>> +#ifdef CONFIG_ACPI
>>> +	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
>>> +		return 0444;
>>> +#endif
>>> +	return 0;
>>> +}
>>> +
>>>  static const struct attribute_group suspend_attr_group = {
>>>  	.name = "suspend_stats",
>>>  	.attrs = suspend_attrs,
>>> +	.is_visible = suspend_attr_is_visible,
>>
>> How is this change related to the changelog above? We are not hiding
>> subtle changes to the existing code in some conglomorate patch. See
>> Documentation/process/...
> 
> It was from feedback from RFC v1 from David Box that this file should only
> be visible when s2idle is supported on the hardware.  Will adjust commit
> message to make it clearer.
> 
>>
>>> --- a/kernel/time/timekeeping.c
>>> +++ b/kernel/time/timekeeping.c
>>> @@ -24,6 +24,7 @@
>>>  #include <linux/compiler.h>
>>>  #include <linux/audit.h>
>>>  #include <linux/random.h>
>>> +#include <linux/suspend.h>
>>>
>>>  #include "tick-internal.h"
>>>  #include "ntp_internal.h"
>>> @@ -1698,6 +1699,7 @@ static void
>> __timekeeping_inject_sleeptime(struct timekeeper *tk,
>>>  	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic,
>> *delta));
>>>  	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
>>>  	tk_debug_account_sleep_time(delta);
>>> +	pm_account_suspend_type(delta);
>>
>> That function name is really self explaining - NOT !
>>
>>      pm_account_suspend_type(delta);
>>
>> So this will account a suspend type depending on the time spent in
>> suspend, right?
>>
>> It's totally obvious that the suspend type (whatever it is) depends on
>> the time delta argument... especially when the function at hand has
>> absolutely nothing to do with a type:
>>
> 
> I fat fingered this.  In my mind I thought I wrote pm_account_suspend_time()
> Will fix.
> 
>>> +void pm_account_suspend_type(const struct timespec64 *t)
>>> +{
>>> +	suspend_stats.last_suspend_total += (s64)t->tv_sec *
>> USEC_PER_SEC +
>>> +						 t->tv_nsec /
>> NSEC_PER_USEC;
>>> +}
>>
>> Sigh....
>>
>> Thanks,
>>
>>         tglx
> 

