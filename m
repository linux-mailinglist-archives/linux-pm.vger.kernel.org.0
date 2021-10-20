Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18B434C9B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJTNvv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 09:51:51 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35563 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTNvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 09:51:51 -0400
Received: by mail-ot1-f41.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so6486061ott.2;
        Wed, 20 Oct 2021 06:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5SM7nz52G6r6F/j6nBMR15lNFGtJZYmywBZSEd7ZW0=;
        b=Y9QJgbeqmCpoUpx21beuohv6QzLG/zhPpOUi48lcp3IfCi2m4b8yk7v1Mz7cdAvYij
         uSOTQnQvPv6nep3uCQJDEmmnW6cRJFKvh2N8bsMwNHCqJ75l1e72CQAwI6S+T/NRytwS
         eWLSZy9uPOR2yvqXJEl/xdXV5GBdL00akX0Mw5FbkOKtL3uFIpNagHXw/4ZcOcMV+g2E
         pcKrjs8p/pA/JwvCc19zqYMpyGaxnw4aq0vsiDHGnjLsZhIZ1SCYD8kqcl7L2giBM963
         7VntbogyAsYhAt+cpd6UNGwA5ZSfdPpSDWvdxGA4iXoQp4y+efBivBMit3mMd3KuqthJ
         zg1Q==
X-Gm-Message-State: AOAM533DzR82J7IGDM45NqSJ3T7llxEjMtp0EX+RSzDq8pi8ukJ65hyP
        e9CAQjFD5RyCbY5KnyU6o8B4emRzznv5dXQZPV0=
X-Google-Smtp-Source: ABdhPJxx30v2bkve5AFhgtcLtf7OOUE8C9Ixo4OpNz528FBnu5rYBtYHcgG71uEXup0SQ7FWIAm0MklwhCidkBGRyeE=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr10268otd.16.1634737776720;
 Wed, 20 Oct 2021 06:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211014075731.GB18719@xsang-OptiPlex-9020> <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
 <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com> <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
 <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com> <20aedfba-14e3-3677-d21a-b87610095445@gmail.com>
 <d36f79b4-472c-4852-7370-a011f9f556ce@intel.com> <4300a3d4-76de-70c5-2a7b-c4d066ef5bc6@gmail.com>
In-Reply-To: <4300a3d4-76de-70c5-2a7b-c4d066ef5bc6@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Oct 2021 15:49:25 +0200
Message-ID: <CAJZ5v0jmGWLfK7-7ULEVjzHtCr2wckK0TiY=59ud=hSM0x4hkA@mail.gmail.com>
Subject: Re: [PM] bfcc1e67ff: kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 19, 2021 at 9:04 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 10/19/21 11:53 AM, Rafael J. Wysocki wrote:
> > On 10/15/2021 9:40 PM, Florian Fainelli wrote:
> >> On 10/15/21 11:45 AM, Rafael J. Wysocki wrote:
> >>> On 10/14/2021 11:55 PM, Florian Fainelli wrote:
> >>>> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
> >>>>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
> >>>>>> On 10/14/21 12:57 AM, kernel test robot wrote:
> >>>>>>> Greeting,
> >>>>>>>
> >>>>>>> FYI, we noticed the following commit (built with gcc-9):
> >>>>>>>
> >>>>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
> >>>>>>> assume that "mem" is always present")
> >>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> >>>>>>> master
> >>>>>>>
> >>>>>>>
> >>>>>>> in testcase: kernel-selftests
> >>>>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
> >>>>>>> with following parameters:
> >>>>>>>
> >>>>>>>       group: group-00
> >>>>>>>       ucode: 0x11
> >>>>>>>
> >>>>>>> test-description: The kernel contains a set of "self tests" under
> >>>>>>> the
> >>>>>>> tools/testing/selftests/ directory. These are intended to be small
> >>>>>>> unit tests to exercise individual code paths in the kernel.
> >>>>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >>>>>>>
> >>>>>>>
> >>>>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU
> >>>>>>> 7295
> >>>>>>> @ 1.50GHz with 80G memory
> >>>>>>>
> >>>>>>> caused below changes (please refer to attached dmesg/kmsg for entire
> >>>>>>> log/backtrace):
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> If you fix the issue, kindly add following tag
> >>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>>>>> Thanks for your report. Assuming that the code responsible for
> >>>>>> registering the suspend operations is drivers/acpi/sleep.c for your
> >>>>>> platform, and that acpi_sleep_suspend_setup() iterated over all
> >>>>>> possible
> >>>>>> sleep states, your platform must somehow be returning that
> >>>>>> ACPI_STATE_S3
> >>>>>> is not a supported state somehow?
> >>>>>>
> >>>>>> Rafael have you ever encountered something like that?
> >>>>> Yes, there are systems with ACPI that don't support S3.
> >>>> OK and do you know what happens when we enter suspend with "mem" in
> >>>> those cases? Do we immediately return because ultimately the firmware
> >>>> does not support ACPI S3?
> >>> "mem" should not be present in the list of available strings then, so it
> >>> should be rejected right away.
> >> Well yes, that was the purpose of the patch I submitted, but assuming
> >> that we did provide "mem" as one of the possible standby modes even
> >> though that was wrong (before patch), and the test was trying to enter
> >> ACPI S3 standby, what would have happened, would the ACPI firmware honor
> >> the request but return an error, or would it actually enter ACPI S3?
> >>
> >> In any case, I will change the test to check that this is a supported
> >> standby mode before trying it.
> >
> > Unfortunately, I will need to revert bfcc1e67ff1e4aa8bfe2, because it
> > breaks user space compatibility and that's got caught properly by the test.
>
> Reverting my commit will break powerpc and other ARM/ARM64 platforms
> where mem is not supported (via PSCI),

It won't break anything, although the things that didn't work before
will still not work after it.

And "mem" is always supported even if there are no suspend_ops at all,
in which case it becomes an alternative way to trigger s2idle.

So, on the affected systems, what's there in /sys/power/?  Is
mem_sleep present?  If so, what's in it?

> I have a change pending for PSCI
> that will actually check that SYSTEM_SUSPEND is supported before
> unconditionally making use of it.
>
> >
> > What happens is that "mem" is a "pointer" to a secondary list of
> > possible states and that generally is "s2idle shallow deep" and if
> > s2idle is the only available option, it will be just "s2idle".
> >
> > This list is there in /sys/power/mem_sleep.
> >
> > It was done this way, because some variants of user space expect "mem"
> > to be always present and don't recognize "freeze" properly.
> >
> > Sorry for the confusion.
>
> So how do we all get our cookie here? Should we just slap an #ifndef
> CONFIG_ACPI in order to allow platforms that do not have "mem" to not
> have it?

Certainly not.

I've just hacked my test-bed system with ACPI so it does not register
any suspend_ops at all and I have "freeze mem disk" in
/sys/power/state and "s2idle" in /sys/power/mem_sleep.  Writing "mem"
to /sys/power/state causes s2idle to be carried out.

Since this is the expected behavior, I'm not sure what the problem is.
