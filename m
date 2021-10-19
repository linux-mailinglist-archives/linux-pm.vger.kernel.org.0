Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608CA433EF2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 21:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhJSTGQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhJSTGP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 15:06:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB990C06161C;
        Tue, 19 Oct 2021 12:04:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k26so801875pfi.5;
        Tue, 19 Oct 2021 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5jq+/J8X7Obd2imDcwpZ+MCW2sOsM0kIEXRg40RYP5o=;
        b=mjKZ97EqSxYXXMQDfdwa8yGmDbqqi9AzYIMPNYrfK9qjoG4d547pyDtwBELYR2UIfr
         TdcmFpdVAb9VXXkWVM0j/+9E077bhobVhAVuI6n0F0Dg4ftDMWepDyVkYOtF2V1fQXXH
         4B5AvBhMF8JPUsxvZeIA0JUm5SM7Sc5eNSeMD2xNyLb8ZqeH7oJBgE4PuZd3YXHAo/fu
         Kf4y6N5hsj1OVPRJMP+V1E4lXHcblQ0wRTw+6qMqxOO8tz/eszofBGFImrmmC8i8NeD2
         vVz9fJ12p3Q5JhbeIYu/yhUU4F93gjXtdcOQ6jSNj4+h+GGAjhRgJhHYMrJ4F4/0JWsk
         Qecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5jq+/J8X7Obd2imDcwpZ+MCW2sOsM0kIEXRg40RYP5o=;
        b=W0Dz23TGeOa+1C1gShfpdzppR0mOkuw692zqLbP1CL0DLLSIB6FVwdIJIV3+6g3j+9
         gFabmaa9oG0qVjSxohhjsu9XSSXksviDp//mav9OFUBUsVP5B39roF7l8w+Qxn+gevFg
         gw7X/m9fNVmgi9f9S3nspmQdrpfZXVfz83x82f85rJ5w0UjrImrUP7xH6J/KZVWbIOet
         RWp4qfHzSfGS5ZOKI17JhzUyPwZ05DiNToW43enUW7rYAxD7lXT2AJPqPoInjD83+a09
         r6yY/uko0UmhsEnPH64Lo8L1TB2nbAs/fEXAZIQ5Vm+w9k9JSVw2LjsEje5+IvbVjSzt
         PQ+A==
X-Gm-Message-State: AOAM533xtkHDbkNlalUfOPex3v31/GbExhgh27RufQ5ZAiqDkP7RDSv4
        gnhMWuE4fY5j1pknd1o2uC5/ol7vGVg=
X-Google-Smtp-Source: ABdhPJy0yotQg3+/FscSU5AJf6cziXixCvM8DTsr+k5DZbp2BpsluWQZ2GYERX0Xeo9F1eD04HrrBQ==
X-Received: by 2002:a05:6a00:248a:b0:44d:ca05:6430 with SMTP id c10-20020a056a00248a00b0044dca056430mr1660847pfv.62.1634670241561;
        Tue, 19 Oct 2021 12:04:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h24sm17356992pfn.180.2021.10.19.12.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 12:04:00 -0700 (PDT)
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20211014075731.GB18719@xsang-OptiPlex-9020>
 <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
 <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com>
 <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
 <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com>
 <20aedfba-14e3-3677-d21a-b87610095445@gmail.com>
 <d36f79b4-472c-4852-7370-a011f9f556ce@intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4300a3d4-76de-70c5-2a7b-c4d066ef5bc6@gmail.com>
Date:   Tue, 19 Oct 2021 12:03:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d36f79b4-472c-4852-7370-a011f9f556ce@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/19/21 11:53 AM, Rafael J. Wysocki wrote:
> On 10/15/2021 9:40 PM, Florian Fainelli wrote:
>> On 10/15/21 11:45 AM, Rafael J. Wysocki wrote:
>>> On 10/14/2021 11:55 PM, Florian Fainelli wrote:
>>>> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
>>>>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
>>>>>> On 10/14/21 12:57 AM, kernel test robot wrote:
>>>>>>> Greeting,
>>>>>>>
>>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>>
>>>>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
>>>>>>> assume that "mem" is always present")
>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>>>>>>> master
>>>>>>>
>>>>>>>
>>>>>>> in testcase: kernel-selftests
>>>>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>>>>>>> with following parameters:
>>>>>>>
>>>>>>>       group: group-00
>>>>>>>       ucode: 0x11
>>>>>>>
>>>>>>> test-description: The kernel contains a set of "self tests" under
>>>>>>> the
>>>>>>> tools/testing/selftests/ directory. These are intended to be small
>>>>>>> unit tests to exercise individual code paths in the kernel.
>>>>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>>>>>
>>>>>>>
>>>>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU
>>>>>>> 7295
>>>>>>> @ 1.50GHz with 80G memory
>>>>>>>
>>>>>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>>>>>> log/backtrace):
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> If you fix the issue, kindly add following tag
>>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>> Thanks for your report. Assuming that the code responsible for
>>>>>> registering the suspend operations is drivers/acpi/sleep.c for your
>>>>>> platform, and that acpi_sleep_suspend_setup() iterated over all
>>>>>> possible
>>>>>> sleep states, your platform must somehow be returning that
>>>>>> ACPI_STATE_S3
>>>>>> is not a supported state somehow?
>>>>>>
>>>>>> Rafael have you ever encountered something like that?
>>>>> Yes, there are systems with ACPI that don't support S3.
>>>> OK and do you know what happens when we enter suspend with "mem" in
>>>> those cases? Do we immediately return because ultimately the firmware
>>>> does not support ACPI S3?
>>> "mem" should not be present in the list of available strings then, so it
>>> should be rejected right away.
>> Well yes, that was the purpose of the patch I submitted, but assuming
>> that we did provide "mem" as one of the possible standby modes even
>> though that was wrong (before patch), and the test was trying to enter
>> ACPI S3 standby, what would have happened, would the ACPI firmware honor
>> the request but return an error, or would it actually enter ACPI S3?
>>
>> In any case, I will change the test to check that this is a supported
>> standby mode before trying it.
> 
> Unfortunately, I will need to revert bfcc1e67ff1e4aa8bfe2, because it
> breaks user space compatibility and that's got caught properly by the test.

Reverting my commit will break powerpc and other ARM/ARM64 platforms
where mem is not supported (via PSCI), I have a change pending for PSCI
that will actually check that SYSTEM_SUSPEND is supported before
unconditionally making use of it.

> 
> What happens is that "mem" is a "pointer" to a secondary list of
> possible states and that generally is "s2idle shallow deep" and if
> s2idle is the only available option, it will be just "s2idle".
> 
> This list is there in /sys/power/mem_sleep.
> 
> It was done this way, because some variants of user space expect "mem"
> to be always present and don't recognize "freeze" properly.
> 
> Sorry for the confusion.

So how do we all get our cookie here? Should we just slap an #ifndef
CONFIG_ACPI in order to allow platforms that do not have "mem" to not
have it?
-- 
Florian
