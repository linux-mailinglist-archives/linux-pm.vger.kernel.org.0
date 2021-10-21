Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8BB436B38
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJUTV1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUTV0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 15:21:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF9C061764;
        Thu, 21 Oct 2021 12:19:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so1192749pgc.6;
        Thu, 21 Oct 2021 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NJ9gB/ZhiE8edXNri1D5Hgin9+vyni8V3+mp8kTt2SE=;
        b=ixZOSXyHrwkUdYR44QznmRGGtPUKCidpvecW0Rv5k3gIScXpjidFRVh3AmHZRMul0Z
         H0vBSiYQlUdzeXFnyQhhezKz1Mbed7k4P+BIqYnNPoKBolparITSIunAEjq2MawzjjT1
         spoBSFjSWY8h/1oL9/cYYUgz+o3nScuGbKOAUsyB19H5CiJotDdYIxkjJEIaww8Uu8jU
         45GKwJBtVFWSjL6UI4S1i1UubhyoKrLQyYiCVWOGmalcAXa9M+7/T2IwuKMY6sXFSsll
         Ohx7n/QvjX2auqPaSZQd4pazG4qO1gEFtHfY3U9KpV6stGh28BLrOBrjp2bi2CHg2GkZ
         Fudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NJ9gB/ZhiE8edXNri1D5Hgin9+vyni8V3+mp8kTt2SE=;
        b=eATvBbeti3cW3lZTl0HbJ+ERers2ndGdf06Ff5CWtTzneFeCbGTOKHO5UB1B1dZRr+
         gF6zZ3plguZ3BoOJq8u6MvO+E9VtkaSps3EVR803WQSWIxWOioV06ifE3LY5aBe2GY7W
         dBnDe2XEgrenDFWOUgRAujpxZ8fVhwcGwjAg8VQb5VoWEV0UdsCN8hhOWfpbdT+OZGW3
         Fr0FNvPJj/6idE8okTiYqwRJHu/juNh0+/3ilhavajcGPYkjloKPi6GBlf6IMMNB0+SM
         dys/LLrulTK0mlHnP2ZPXt6KVSdEAXYhB7kgTdSRxxjSXGVkh5zbVA0ObFy3tXHktf5N
         S2uA==
X-Gm-Message-State: AOAM531iBUV9PUfnHlJvZttUFbi+f8TtIYhHWo54EEtSj1vU6zN6U3Jc
        2HRkXtVWf2ruvYDgb+c9d0NSVr6l40k=
X-Google-Smtp-Source: ABdhPJy9wzrccCAQgW5mQtG3/m2Lou+p4EBgiqDbvJsEGJfl53WLxHGEdnDsmVQCMZn5CYJmiMHpiA==
X-Received: by 2002:a63:3c1a:: with SMTP id j26mr5997427pga.450.1634843949394;
        Thu, 21 Oct 2021 12:19:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gk1sm8966050pjb.2.2021.10.21.12.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 12:19:08 -0700 (PDT)
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
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
 <8ebd1cad-fa35-8ad8-0be5-3dd3364196cb@gmail.com>
 <CAJZ5v0iL+PwiJ3gxSzE3sJh0zyAd-3HZC=0sij7SdmDV=uR+Qg@mail.gmail.com>
 <0941a29e-e035-aaca-ecc4-6505f8fe1ad1@gmail.com>
 <CAJZ5v0h7XHS1c3=WztFhDUYc8tLzRDn7Dwy-yNd3WC4qs4i_eg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <df8f421a-0deb-19c4-27f3-9d50bea1eee4@gmail.com>
Date:   Thu, 21 Oct 2021 12:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h7XHS1c3=WztFhDUYc8tLzRDn7Dwy-yNd3WC4qs4i_eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/20/21 11:48 AM, Rafael J. Wysocki wrote:
>   On Wed, Oct 20, 2021 at 8:17 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 10/20/21 9:00 AM, Rafael J. Wysocki wrote:
>>> On Wed, Oct 20, 2021 at 5:34 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/20/2021 6:49 AM, Rafael J. Wysocki wrote:
>>>>> On Tue, Oct 19, 2021 at 9:04 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>>
>>>>>> On 10/19/21 11:53 AM, Rafael J. Wysocki wrote:
>>>>>>> On 10/15/2021 9:40 PM, Florian Fainelli wrote:
>>>>>>>> On 10/15/21 11:45 AM, Rafael J. Wysocki wrote:
>>>>>>>>> On 10/14/2021 11:55 PM, Florian Fainelli wrote:
>>>>>>>>>> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
>>>>>>>>>>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
>>>>>>>>>>>> On 10/14/21 12:57 AM, kernel test robot wrote:
>>>>>>>>>>>>> Greeting,
>>>>>>>>>>>>>
>>>>>>>>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>>>>>>>>
>>>>>>>>>>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
>>>>>>>>>>>>> assume that "mem" is always present")
>>>>>>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>>>>>>>>>>>>> master
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> in testcase: kernel-selftests
>>>>>>>>>>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>>>>>>>>>>>>> with following parameters:
>>>>>>>>>>>>>
>>>>>>>>>>>>>        group: group-00
>>>>>>>>>>>>>        ucode: 0x11
>>>>>>>>>>>>>
>>>>>>>>>>>>> test-description: The kernel contains a set of "self tests" under
>>>>>>>>>>>>> the
>>>>>>>>>>>>> tools/testing/selftests/ directory. These are intended to be small
>>>>>>>>>>>>> unit tests to exercise individual code paths in the kernel.
>>>>>>>>>>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU
>>>>>>>>>>>>> 7295
>>>>>>>>>>>>> @ 1.50GHz with 80G memory
>>>>>>>>>>>>>
>>>>>>>>>>>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>>>>>>>>>>>> log/backtrace):
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> If you fix the issue, kindly add following tag
>>>>>>>>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>>>>>>>> Thanks for your report. Assuming that the code responsible for
>>>>>>>>>>>> registering the suspend operations is drivers/acpi/sleep.c for your
>>>>>>>>>>>> platform, and that acpi_sleep_suspend_setup() iterated over all
>>>>>>>>>>>> possible
>>>>>>>>>>>> sleep states, your platform must somehow be returning that
>>>>>>>>>>>> ACPI_STATE_S3
>>>>>>>>>>>> is not a supported state somehow?
>>>>>>>>>>>>
>>>>>>>>>>>> Rafael have you ever encountered something like that?
>>>>>>>>>>> Yes, there are systems with ACPI that don't support S3.
>>>>>>>>>> OK and do you know what happens when we enter suspend with "mem" in
>>>>>>>>>> those cases? Do we immediately return because ultimately the firmware
>>>>>>>>>> does not support ACPI S3?
>>>>>>>>> "mem" should not be present in the list of available strings then, so it
>>>>>>>>> should be rejected right away.
>>>>>>>> Well yes, that was the purpose of the patch I submitted, but assuming
>>>>>>>> that we did provide "mem" as one of the possible standby modes even
>>>>>>>> though that was wrong (before patch), and the test was trying to enter
>>>>>>>> ACPI S3 standby, what would have happened, would the ACPI firmware honor
>>>>>>>> the request but return an error, or would it actually enter ACPI S3?
>>>>>>>>
>>>>>>>> In any case, I will change the test to check that this is a supported
>>>>>>>> standby mode before trying it.
>>>>>>>
>>>>>>> Unfortunately, I will need to revert bfcc1e67ff1e4aa8bfe2, because it
>>>>>>> breaks user space compatibility and that's got caught properly by the test.
>>>>>>
>>>>>> Reverting my commit will break powerpc and other ARM/ARM64 platforms
>>>>>> where mem is not supported (via PSCI),
>>>>>
>>>>> It won't break anything, although the things that didn't work before
>>>>> will still not work after it.
>>>>>
>>>>> And "mem" is always supported even if there are no suspend_ops at all,
>>>>> in which case it becomes an alternative way to trigger s2idle.
>>>>>
>>>>> So, on the affected systems, what's there in /sys/power/?  Is
>>>>> mem_sleep present?  If so, what's in it?
>>>>
>>>> With 4.9 which is what I used initially:
>>>>
>>>> # cat /sys/power/state
>>>> freeze standby
>>>> # cat /sys/power/
>>>> pm_async           pm_print_times     pm_wakeup_irq      wakeup_count
>>>> pm_freeze_timeout  pm_test            state
>>>>
>>>> With a newer kernel without my patch:
>>>>
>>>> # cat /sys/power/state
>>>> freeze standby mem
>>>> # cat /sys/power/mem_sleep
>>>> s2idle shallow [deep]
>>>
>>> OK, so the "deep" and "shallow" suspend variants appear to be
>>> supported.  What's the problem with advertising "mem" then?
>>
>> s2idle and shallow are, but deep is not.
> 
> Why is it there in mem_sleep, then?  It should not be there if
> valid_state() returns 'false' for it.

The suspend_ops that is registered has a ->valid that will return false
for the PM_SUSPEND_MEM case, yet we ignore that and we still populate
valide_state[PM]

> 
> mem_sleep_states[PM_SUSPEND_MEM] is only set by suspend_set_ops() if
> valid_state(PM_SUSPEND_MEM) is 'true'.

That is true, but pm_states[PM_SUSPEND_MEM] was (before my patch that
is) unconditionally present. And for the same reason that you expect
user-space to find the string "mem" in /sys/power/state, we expected not
to find it, if PM_SUSPEND_MEM is not supported.

> 
>>>
>>>> # cat /sys/power/
>>>> mem_sleep          pm_freeze_timeout  pm_wakeup_irq      wakeup_count
>>>> pm_async           pm_print_times     state
>>>> pm_debug_messages  pm_test            suspend_stats/
>>>>
>>>>
>>>>>
>>>>>> I have a change pending for PSCI
>>>>>> that will actually check that SYSTEM_SUSPEND is supported before
>>>>>> unconditionally making use of it.
>>>>>>
>>>>>>>
>>>>>>> What happens is that "mem" is a "pointer" to a secondary list of
>>>>>>> possible states and that generally is "s2idle shallow deep" and if
>>>>>>> s2idle is the only available option, it will be just "s2idle".
>>>>>>>
>>>>>>> This list is there in /sys/power/mem_sleep.
>>>>>>>
>>>>>>> It was done this way, because some variants of user space expect "mem"
>>>>>>> to be always present and don't recognize "freeze" properly.
>>>>>>>
>>>>>>> Sorry for the confusion.
>>>>>>
>>>>>> So how do we all get our cookie here? Should we just slap an #ifndef
>>>>>> CONFIG_ACPI in order to allow platforms that do not have "mem" to not
>>>>>> have it?
>>>>>
>>>>> Certainly not.
>>>>>
>>>>> I've just hacked my test-bed system with ACPI so it does not register
>>>>> any suspend_ops at all and I have "freeze mem disk" in
>>>>> /sys/power/state and "s2idle" in /sys/power/mem_sleep.  Writing "mem"
>>>>> to /sys/power/state causes s2idle to be carried out.
>>>>>
>>>>> Since this is the expected behavior, I'm not sure what the problem is.
>>>>
>>>> The problem is advertising "mem" in /sys/power/state when the state is
>>>> not actually supported by the platform firmware here, whether that
>>>> translates into the form of s2idle or not. It is not supported, and it
>>>> should not be there IMHO.
>>>
>>> Well, it is there, because some user space expects it to be there on
>>> systems supporting any kind of system-wide suspend, including s2idle.
>>> Like it or not.
>>
>> But that was not the case before 406e79385f32 ("PM / sleep: System sleep
>> state selection interface rework") and clearly nobody complained about
>> that, did they?
> 
> Yes, it was and yes, they did.  Changes like that are not made without a reason.
> 
>>>
>>> If it is not there, the utilities in question assume that system-wide
>>> suspend is not supported at all.
>>
>> What utilities do depend on that? That selftest that does not even check
>> that "mem" is actually present in /sys/power/state and just fails its
>> test if it is not, yes it's not great, but that can be fixed.
> 
> Various GUI-based things like KDE, GNOME and similar plus the Chrome
> user space IIRC.

OK.

> 
>>>
>>>> I was late to the game in identifying that,
>>>> but the 4.9 kernel makes sense to me.
>>>>
>>>> Similarly, if you take arch/powerpc/sysdev/fsl_pmc.c only
>>>> PM_SUSPEND_STANDBY is valid, so advertising mem would be wrong if we
>>>> don't look at what ->valid tells us.
>>>
>>> Again: "mem" appears in /sys/power/state if the system supports any
>>> kind of system-wide suspend (because of the expectations of user space
>>> mentioned above) and mem_sleep decides what it really means.
>>>
>>> And this is documented too (see Documentation/admin-guide/pm/sleep-states.html).
>>
>> The documentation just states that if the kernel supports *any* suspend
>> state, then /sys/power/state will be present and likewise for
>> /sys/power/mem_sleep, it does not say what the contents will be and that
>> "mem" would always be present in there.
> 
> It doesn't say so directly, but it kind of wouldn't make sense to have
> "mem_sleep" without "mem" in "state" and it implies that "mem_sleep"
> is not empty if it is present.  Ergo "mem" is present in "state" if
> "mem_sleep" is present which is the case if (at least) s2idle is
> supported.  That is always the case if CONFIG_SUSPEND is set which
> follows from the suspend-to-idle description.
> 
> Anyway, I'm still not sure what the problem really is.  Commit
> 406e79385f32 still allows user space to only trigger transitions to
> s2idle and other states explicitly reported as valid by the platform.
> 

The problem from my perspective is still that "mem" is present even with
PM_SUSPEND_PM not being valid for the said platform, and this is just
confusing my/our user-space here as well as our users. This was not like
that back in the 4.9 kernel, but it changed later, therefore it also
constitutes an user-space regression from my angle.
-- 
Florian
