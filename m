Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91E434F26
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJTPhD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhJTPhC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 11:37:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB74C06161C;
        Wed, 20 Oct 2021 08:34:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q19so3282799pfl.4;
        Wed, 20 Oct 2021 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LtOvVCugM9KLxCYe5AwWOsOF2o7xv+ODVigMZQVQPEs=;
        b=hkerBJDgbpcqDOVjVEp3Pn+butj1LPsBU9rnMXKlBYWITNT8tHCCbYBQeRXN1hJPgc
         i5VhmzS5P64QkMqedjjBnWnKlYyj65KOvdNRF1xSPVkVwlRfW2l+2GpM6qTKZ54l7DoX
         B+nDvkPBXZ50/gOjuvl9nHDwYQHo1F/mVPMvJirIE/m4x6FM5seKrzHH5tpUa4ZVHzAr
         yCIaNoBP58iRWr7ECGdFxU3x8WbkNqo0mtVVk155ac9bb4QdKyoPLgRTUvnmx0LBb7x+
         LPYVmm0mXzW76ZGXzatVVkegUsmHTLNxhHeZNRVEg8h7ZDvHcJgfvGCRQ1dYYPRe8ii/
         576g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LtOvVCugM9KLxCYe5AwWOsOF2o7xv+ODVigMZQVQPEs=;
        b=tSW2Ry9mHawnHcdgRY+IeFq4KT6C7QlP5lnQQP30PPd4nocQKj23kc1T0g42LAEUDc
         28Kya+JRibpl9kVxJe+hkZ1HYS7ZBOQGBY72OHWClJNXm/PNwzcdu7OxgZfOw6XFIqBz
         rS1NMaYeMAjIywN71tF5zR5ej5lmfQCnYAbENlFGt/AdpCaMOoJsuXn95Vi2EuZTLwNN
         f0sKSdFIdBaoVsNvM2mNah12LVFmc/dXHOju+vG9FN1P+xWo8NQrooZgGhptue2RX5uk
         M3rBkpKnQhtc+WI5kzrL43Wr9xBeEaKaGxwW+M9gKLkwXQrMpqlIIsoksa9Kb5LlIrRU
         5MjQ==
X-Gm-Message-State: AOAM532QCSBhajA5FGhRU8A64VyjGmoy3Bl67cgkOGLeLsd9EeALeFEf
        JrOh1wYn4E/7fPcg6l/euN25SxU2Z2g=
X-Google-Smtp-Source: ABdhPJxvde6S00r/XwQfye4zt28OJEbUt04GWcBkVtiEcePThNs+MlLDSHZjb30yaldpgsfmblD3LA==
X-Received: by 2002:a05:6a00:b45:b0:44d:c4c4:409b with SMTP id p5-20020a056a000b4500b0044dc4c4409bmr585360pfo.3.1634744086903;
        Wed, 20 Oct 2021 08:34:46 -0700 (PDT)
Received: from [10.230.29.137] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x184sm2905618pfc.44.2021.10.20.08.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 08:34:46 -0700 (PDT)
Message-ID: <8ebd1cad-fa35-8ad8-0be5-3dd3364196cb@gmail.com>
Date:   Wed, 20 Oct 2021 08:34:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20211014075731.GB18719@xsang-OptiPlex-9020>
 <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
 <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com>
 <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
 <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com>
 <20aedfba-14e3-3677-d21a-b87610095445@gmail.com>
 <d36f79b4-472c-4852-7370-a011f9f556ce@intel.com>
 <4300a3d4-76de-70c5-2a7b-c4d066ef5bc6@gmail.com>
 <CAJZ5v0jmGWLfK7-7ULEVjzHtCr2wckK0TiY=59ud=hSM0x4hkA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAJZ5v0jmGWLfK7-7ULEVjzHtCr2wckK0TiY=59ud=hSM0x4hkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/20/2021 6:49 AM, Rafael J. Wysocki wrote:
> On Tue, Oct 19, 2021 at 9:04 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 10/19/21 11:53 AM, Rafael J. Wysocki wrote:
>>> On 10/15/2021 9:40 PM, Florian Fainelli wrote:
>>>> On 10/15/21 11:45 AM, Rafael J. Wysocki wrote:
>>>>> On 10/14/2021 11:55 PM, Florian Fainelli wrote:
>>>>>> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
>>>>>>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
>>>>>>>> On 10/14/21 12:57 AM, kernel test robot wrote:
>>>>>>>>> Greeting,
>>>>>>>>>
>>>>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>>>>
>>>>>>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
>>>>>>>>> assume that "mem" is always present")
>>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>>>>>>>>> master
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> in testcase: kernel-selftests
>>>>>>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>>>>>>>>> with following parameters:
>>>>>>>>>
>>>>>>>>>        group: group-00
>>>>>>>>>        ucode: 0x11
>>>>>>>>>
>>>>>>>>> test-description: The kernel contains a set of "self tests" under
>>>>>>>>> the
>>>>>>>>> tools/testing/selftests/ directory. These are intended to be small
>>>>>>>>> unit tests to exercise individual code paths in the kernel.
>>>>>>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU
>>>>>>>>> 7295
>>>>>>>>> @ 1.50GHz with 80G memory
>>>>>>>>>
>>>>>>>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>>>>>>>> log/backtrace):
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> If you fix the issue, kindly add following tag
>>>>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>>>> Thanks for your report. Assuming that the code responsible for
>>>>>>>> registering the suspend operations is drivers/acpi/sleep.c for your
>>>>>>>> platform, and that acpi_sleep_suspend_setup() iterated over all
>>>>>>>> possible
>>>>>>>> sleep states, your platform must somehow be returning that
>>>>>>>> ACPI_STATE_S3
>>>>>>>> is not a supported state somehow?
>>>>>>>>
>>>>>>>> Rafael have you ever encountered something like that?
>>>>>>> Yes, there are systems with ACPI that don't support S3.
>>>>>> OK and do you know what happens when we enter suspend with "mem" in
>>>>>> those cases? Do we immediately return because ultimately the firmware
>>>>>> does not support ACPI S3?
>>>>> "mem" should not be present in the list of available strings then, so it
>>>>> should be rejected right away.
>>>> Well yes, that was the purpose of the patch I submitted, but assuming
>>>> that we did provide "mem" as one of the possible standby modes even
>>>> though that was wrong (before patch), and the test was trying to enter
>>>> ACPI S3 standby, what would have happened, would the ACPI firmware honor
>>>> the request but return an error, or would it actually enter ACPI S3?
>>>>
>>>> In any case, I will change the test to check that this is a supported
>>>> standby mode before trying it.
>>>
>>> Unfortunately, I will need to revert bfcc1e67ff1e4aa8bfe2, because it
>>> breaks user space compatibility and that's got caught properly by the test.
>>
>> Reverting my commit will break powerpc and other ARM/ARM64 platforms
>> where mem is not supported (via PSCI),
> 
> It won't break anything, although the things that didn't work before
> will still not work after it.
> 
> And "mem" is always supported even if there are no suspend_ops at all,
> in which case it becomes an alternative way to trigger s2idle.
> 
> So, on the affected systems, what's there in /sys/power/?  Is
> mem_sleep present?  If so, what's in it?

With 4.9 which is what I used initially:

# cat /sys/power/state
freeze standby
# cat /sys/power/
pm_async           pm_print_times     pm_wakeup_irq      wakeup_count
pm_freeze_timeout  pm_test            state

With a newer kernel without my patch:

# cat /sys/power/state
freeze standby mem
# cat /sys/power/mem_sleep
s2idle shallow [deep]
# cat /sys/power/
mem_sleep          pm_freeze_timeout  pm_wakeup_irq      wakeup_count
pm_async           pm_print_times     state
pm_debug_messages  pm_test            suspend_stats/


> 
>> I have a change pending for PSCI
>> that will actually check that SYSTEM_SUSPEND is supported before
>> unconditionally making use of it.
>>
>>>
>>> What happens is that "mem" is a "pointer" to a secondary list of
>>> possible states and that generally is "s2idle shallow deep" and if
>>> s2idle is the only available option, it will be just "s2idle".
>>>
>>> This list is there in /sys/power/mem_sleep.
>>>
>>> It was done this way, because some variants of user space expect "mem"
>>> to be always present and don't recognize "freeze" properly.
>>>
>>> Sorry for the confusion.
>>
>> So how do we all get our cookie here? Should we just slap an #ifndef
>> CONFIG_ACPI in order to allow platforms that do not have "mem" to not
>> have it?
> 
> Certainly not.
> 
> I've just hacked my test-bed system with ACPI so it does not register
> any suspend_ops at all and I have "freeze mem disk" in
> /sys/power/state and "s2idle" in /sys/power/mem_sleep.  Writing "mem"
> to /sys/power/state causes s2idle to be carried out.
> 
> Since this is the expected behavior, I'm not sure what the problem is.

The problem is advertising "mem" in /sys/power/state when the state is 
not actually supported by the platform firmware here, whether that 
translates into the form of s2idle or not. It is not supported, and it 
should not be there IMHO. I was late to the game in identifying that, 
but the 4.9 kernel makes sense to me.

Similarly, if you take arch/powerpc/sysdev/fsl_pmc.c only 
PM_SUSPEND_STANDBY is valid, so advertising mem would be wrong if we 
don't look at what ->valid tells us.
-- 
Florian
