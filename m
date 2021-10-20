Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D01434F8C
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJTQCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 12:02:31 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:46841 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJTQCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 12:02:30 -0400
Received: by mail-ot1-f42.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so8740009ote.13;
        Wed, 20 Oct 2021 09:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8Vh3j/5jDTLXwbY1bkY5BeXtXCmKpCTYashNJhu/CY=;
        b=sEKjPHZ47Anvm+BR3aFCgVZ2/aQCq4YaOSKcKLgmXsDaVUFQlMSbe8EN2OA3O9afPa
         0tus3qE2D4KDl/+wxWAnBcnIkZMqUkyqYXyxJZ5dFQJGODTvOQg6scc1ytKqBED+/u+t
         juNjIYsIPw+4AgvNyJOXX56JxW+umTxM1kqPcpbP3wNpwBbmE7BneqaW72scrwrvGgEs
         XUw/8pM/gtrkCzYxs30wCv7QpFl+4TImkLKcbg/PgtupcRd/BJp44O9pkLhymvTFJBfi
         z9kHfMuOGEpMW/vuxRNwyXH8vremtYhi5Coq3bvvquaSyCVMhfqfGTRFIvBBF8F7yHj2
         v8Yg==
X-Gm-Message-State: AOAM531OKgCXBbXkP1OXKL+Ioze78Qu4h/yBlSQ6or2S8pbTfKk6AQOX
        s78N+ouYoQxXiyKDtm8a5ervu/uEfj+pM09CKw8=
X-Google-Smtp-Source: ABdhPJwJl+cQeOqwfxw/oclkGzX5j9/GJ2q0VC9R9Wz4kp1ZHF+LdxTAocR2UaocJNw1k+WRUxzePHLB/Ggl74mPM8s=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr53327ott.254.1634745615563;
 Wed, 20 Oct 2021 09:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211014075731.GB18719@xsang-OptiPlex-9020> <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
 <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com> <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
 <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com> <20aedfba-14e3-3677-d21a-b87610095445@gmail.com>
 <d36f79b4-472c-4852-7370-a011f9f556ce@intel.com> <4300a3d4-76de-70c5-2a7b-c4d066ef5bc6@gmail.com>
 <CAJZ5v0jmGWLfK7-7ULEVjzHtCr2wckK0TiY=59ud=hSM0x4hkA@mail.gmail.com> <8ebd1cad-fa35-8ad8-0be5-3dd3364196cb@gmail.com>
In-Reply-To: <8ebd1cad-fa35-8ad8-0be5-3dd3364196cb@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Oct 2021 18:00:04 +0200
Message-ID: <CAJZ5v0iL+PwiJ3gxSzE3sJh0zyAd-3HZC=0sij7SdmDV=uR+Qg@mail.gmail.com>
Subject: Re: [PM] bfcc1e67ff: kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 20, 2021 at 5:34 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 10/20/2021 6:49 AM, Rafael J. Wysocki wrote:
> > On Tue, Oct 19, 2021 at 9:04 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 10/19/21 11:53 AM, Rafael J. Wysocki wrote:
> >>> On 10/15/2021 9:40 PM, Florian Fainelli wrote:
> >>>> On 10/15/21 11:45 AM, Rafael J. Wysocki wrote:
> >>>>> On 10/14/2021 11:55 PM, Florian Fainelli wrote:
> >>>>>> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
> >>>>>>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
> >>>>>>>> On 10/14/21 12:57 AM, kernel test robot wrote:
> >>>>>>>>> Greeting,
> >>>>>>>>>
> >>>>>>>>> FYI, we noticed the following commit (built with gcc-9):
> >>>>>>>>>
> >>>>>>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
> >>>>>>>>> assume that "mem" is always present")
> >>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> >>>>>>>>> master
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> in testcase: kernel-selftests
> >>>>>>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
> >>>>>>>>> with following parameters:
> >>>>>>>>>
> >>>>>>>>>        group: group-00
> >>>>>>>>>        ucode: 0x11
> >>>>>>>>>
> >>>>>>>>> test-description: The kernel contains a set of "self tests" under
> >>>>>>>>> the
> >>>>>>>>> tools/testing/selftests/ directory. These are intended to be small
> >>>>>>>>> unit tests to exercise individual code paths in the kernel.
> >>>>>>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU
> >>>>>>>>> 7295
> >>>>>>>>> @ 1.50GHz with 80G memory
> >>>>>>>>>
> >>>>>>>>> caused below changes (please refer to attached dmesg/kmsg for entire
> >>>>>>>>> log/backtrace):
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> If you fix the issue, kindly add following tag
> >>>>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>>>>>>> Thanks for your report. Assuming that the code responsible for
> >>>>>>>> registering the suspend operations is drivers/acpi/sleep.c for your
> >>>>>>>> platform, and that acpi_sleep_suspend_setup() iterated over all
> >>>>>>>> possible
> >>>>>>>> sleep states, your platform must somehow be returning that
> >>>>>>>> ACPI_STATE_S3
> >>>>>>>> is not a supported state somehow?
> >>>>>>>>
> >>>>>>>> Rafael have you ever encountered something like that?
> >>>>>>> Yes, there are systems with ACPI that don't support S3.
> >>>>>> OK and do you know what happens when we enter suspend with "mem" in
> >>>>>> those cases? Do we immediately return because ultimately the firmware
> >>>>>> does not support ACPI S3?
> >>>>> "mem" should not be present in the list of available strings then, so it
> >>>>> should be rejected right away.
> >>>> Well yes, that was the purpose of the patch I submitted, but assuming
> >>>> that we did provide "mem" as one of the possible standby modes even
> >>>> though that was wrong (before patch), and the test was trying to enter
> >>>> ACPI S3 standby, what would have happened, would the ACPI firmware honor
> >>>> the request but return an error, or would it actually enter ACPI S3?
> >>>>
> >>>> In any case, I will change the test to check that this is a supported
> >>>> standby mode before trying it.
> >>>
> >>> Unfortunately, I will need to revert bfcc1e67ff1e4aa8bfe2, because it
> >>> breaks user space compatibility and that's got caught properly by the test.
> >>
> >> Reverting my commit will break powerpc and other ARM/ARM64 platforms
> >> where mem is not supported (via PSCI),
> >
> > It won't break anything, although the things that didn't work before
> > will still not work after it.
> >
> > And "mem" is always supported even if there are no suspend_ops at all,
> > in which case it becomes an alternative way to trigger s2idle.
> >
> > So, on the affected systems, what's there in /sys/power/?  Is
> > mem_sleep present?  If so, what's in it?
>
> With 4.9 which is what I used initially:
>
> # cat /sys/power/state
> freeze standby
> # cat /sys/power/
> pm_async           pm_print_times     pm_wakeup_irq      wakeup_count
> pm_freeze_timeout  pm_test            state
>
> With a newer kernel without my patch:
>
> # cat /sys/power/state
> freeze standby mem
> # cat /sys/power/mem_sleep
> s2idle shallow [deep]

OK, so the "deep" and "shallow" suspend variants appear to be
supported.  What's the problem with advertising "mem" then?

> # cat /sys/power/
> mem_sleep          pm_freeze_timeout  pm_wakeup_irq      wakeup_count
> pm_async           pm_print_times     state
> pm_debug_messages  pm_test            suspend_stats/
>
>
> >
> >> I have a change pending for PSCI
> >> that will actually check that SYSTEM_SUSPEND is supported before
> >> unconditionally making use of it.
> >>
> >>>
> >>> What happens is that "mem" is a "pointer" to a secondary list of
> >>> possible states and that generally is "s2idle shallow deep" and if
> >>> s2idle is the only available option, it will be just "s2idle".
> >>>
> >>> This list is there in /sys/power/mem_sleep.
> >>>
> >>> It was done this way, because some variants of user space expect "mem"
> >>> to be always present and don't recognize "freeze" properly.
> >>>
> >>> Sorry for the confusion.
> >>
> >> So how do we all get our cookie here? Should we just slap an #ifndef
> >> CONFIG_ACPI in order to allow platforms that do not have "mem" to not
> >> have it?
> >
> > Certainly not.
> >
> > I've just hacked my test-bed system with ACPI so it does not register
> > any suspend_ops at all and I have "freeze mem disk" in
> > /sys/power/state and "s2idle" in /sys/power/mem_sleep.  Writing "mem"
> > to /sys/power/state causes s2idle to be carried out.
> >
> > Since this is the expected behavior, I'm not sure what the problem is.
>
> The problem is advertising "mem" in /sys/power/state when the state is
> not actually supported by the platform firmware here, whether that
> translates into the form of s2idle or not. It is not supported, and it
> should not be there IMHO.

Well, it is there, because some user space expects it to be there on
systems supporting any kind of system-wide suspend, including s2idle.
Like it or not.

If it is not there, the utilities in question assume that system-wide
suspend is not supported at all.

>I was late to the game in identifying that,
> but the 4.9 kernel makes sense to me.
>
> Similarly, if you take arch/powerpc/sysdev/fsl_pmc.c only
> PM_SUSPEND_STANDBY is valid, so advertising mem would be wrong if we
> don't look at what ->valid tells us.

Again: "mem" appears in /sys/power/state if the system supports any
kind of system-wide suspend (because of the expectations of user space
mentioned above) and mem_sleep decides what it really means.

And this is documented too (see Documentation/admin-guide/pm/sleep-states.html).
