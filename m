Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ABE40330A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 05:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhIHDoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 23:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhIHDoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 23:44:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF25C061575
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 20:43:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s10so1560442lfr.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8B7rsR/U6MYIRRZ/pFi74UHxEXbdwK5SKXtNls19AwM=;
        b=MVYKn+8UHt/W4LnI54Pw8aJsZHCwL/RpcHVW56Gm/CN+qa21pJzbxJblhfXbDAzvJl
         ztR6wItASfyDw19FMLU1ym+MP3ITbCXen/Y4nf5/xXiRH8TWBq3y24uI9pI9u6+DCUdx
         CETtRRf48WWKqHLj0jcDOQLNPZI2xCiFQStDFF+h4/U33/m3UIg5Eq4/fvZUQCCJneNA
         8VCWRzazXqBzxMtQyDUsu/0leR3FFG1KNVOiilKrEGqcIR+LuNAvTf/zqbs90ilGuugd
         nIDD1dgvZTPy5CTPUVTPHHH61C40WXoDmUAcKMSa0PdOVXr3D9dcPAHVub27vFhPskIi
         Evng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B7rsR/U6MYIRRZ/pFi74UHxEXbdwK5SKXtNls19AwM=;
        b=WsT3/8xBAlp97N3oJ1dl3arQtVV7ARXtWOiB4Jef6EkyNsSsfK80IO8XfG0N7UGte0
         JjShEuWO5bi4E7H2NE8IA7O5z/LlKUE1JwLq7owd6eEmbPsGC1f+TcDcNGSSr5u79Hrx
         NxKQeDg9zneEIoj2WQlRPzCdKJa96sSagWli0JK9xUszd6N8TNCoSXFm36q0rDtvhMNp
         EB7AYY/UXO0QHKFrxEXuTB/L9woAkvpLtCFABfVgmQ9b9Ri9dVcFp8FYagMepwd1J56L
         AY1HTTTPXFXX2fUWjUNPmELio52sTTxLNOjEXLB5/Ozc3UESFlRUnkb6vCOaP8UPZg3w
         WM2g==
X-Gm-Message-State: AOAM531B5kXp/KOS2reyMFI+buxsWAqMhfKQu8ztUFJWNG2xlUTErznS
        rBbpYlEWxBVFWb6d+oyrMOPazwIr4kSVw2I6hEvIDA==
X-Google-Smtp-Source: ABdhPJx7i6C9RnKhg7mugC3YCRiCmTaFbqRi+K5Q1Ji9L0z+nzFfdf9DNkpc+qALXf7FcmsTkTP4QsoltVjedBLOn28=
X-Received: by 2002:ac2:5456:: with SMTP id d22mr1135144lfn.139.1631072607813;
 Tue, 07 Sep 2021 20:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
 <20210513132051.31465-1-ggherdovich@suse.cz> <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
 <067ee60e47a0350d01f0c3f216c1032818044b36.camel@suse.cz> <CAAYoRsX0xJf1mm1a_YUCzDy86r8q4QE98iVtS1AMLaUx+KTgQQ@mail.gmail.com>
 <CAAYoRsXK79PspEUh9pqgj2OGQnxQONkEeK-7af3=5frBzAqULQ@mail.gmail.com>
 <2a1b000cd101737400f6320ef18c0143d3a5145b.camel@linux.intel.com>
 <CAAYoRsVeMCivVBp-q_9N23BDOVvkc8ZLS3mubnz+4TREZ9Cz_A@mail.gmail.com> <7abae13c235d74f4789cd93c6c6b0cbf69df243d.camel@linux.intel.com>
In-Reply-To: <7abae13c235d74f4789cd93c6c6b0cbf69df243d.camel@linux.intel.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 7 Sep 2021 20:43:19 -0700
Message-ID: <CAAYoRsVd4uU7sofcvYWd__evKJTf7HE5mi2ZVDjAYNYWXS3mzQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 7, 2021 at 7:04 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2021-09-07 at 13:16 -0700, Doug Smythies wrote:
> > Hi Srinivas, Thank you for your reply.
> >
> > On Tue, Sep 7, 2021 at 9:01 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > On Tue, 2021-09-07 at 08:45 -0700, Doug Smythies wrote:
> > > >
> > > > Recent ASUS BIOS updates have changed the default system
> > > > response for this old thread, rendering "intel_pstate=no_hwp"
> > > > useless.
> > > >
> > > > It also raises a question: If BIOS has forced HWP, then how do we
> > > > prevent the acpi-cpufreq driver from being used? Read on.
> > >
> > > Does BIOS has option to enable Intel speed shift with no legacy
> > > support?
> > > Then this option will not populate ACPI _PSS table.
> >
> > The option is there no matter what.
> > I have tried every variation of legacy or no legacy that
> > I can find. Currently:
> > Current boot mode:   UEFI Firmware mode
> > SecureBoot:          disabled
> >
> > >
> > > >
> > > > On Fri, May 14, 2021 at 3:12 PM Doug Smythies <
> > > > dsmythies@telus.net>
> > > > wrote:
> > > > >
> > > > > On Fri, May 14, 2021 at 1:33 PM Giovanni Gherdovich <
> > > > > ggherdovich@suse.cz> wrote:
> > > > > > On Fri, 2021-05-14 at 08:31 -0700, Doug Smythies wrote:
> > > > ...
> > > > > >
> > ...
> > > > Previous correspondence was with BIOS version 1003. There have
> > > > been 3
> > > > BIOS
> > > > releases since then (at least that I know of), 2103, 2201, 2301,
> > > > and
> > > > all of them
> > > > have changed the behaviour of the "Auto" setting for Intel Speed
> > > > Shift
> > > > Technology BIOS setting, forcing it on upon transfer of control
> > > > to
> > > > the OS.
> > > >
> > > > Where with "intel_pstate=no_hwp" one used to get 0 for
> > > > MSR_PM_ENABLE
> > > > (0x770) they now get 1.
> > >
> > > So they are forcing Out of band OOB mode.
> > > Does bit 8 or 18 in MSR 0x1aa is set?
> >
> > No.
>
> So there is no legacy path. I think you are working with their support.

Yes, for almost a month now, with very little to show for it.
We'll see what happens. I did get a message this afternoon:

"Our GTSD is debugging the issue,.
When they have the result, they will directly update you."

> In HWP mode does setting scaling min/max frequency has any impact?

No. I wouldn't have expected it to, as the system is confused as to who
is in charge. The acpi-cpufreq driver thinks it is in charge, but HWP
thinks it is.

The intel_pstate driver works fine.

... Doug

>
> Thanks,
> Srinivas
>
> >
> > Here is the output from my msr reader/decoder program.
> > Kernel 5.14 (unpatched).
> > intel_pstate=disable
> > BIOS setting "Auto" for Intel Speed Shift,
> > Driver: acpi-cpufreq
> >
> > doug@s19:~$ sudo c/msr-decoder
> > How many CPUs?: 12
> > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-11 :  45 :  45 :  45 :  45 :
> > 45 :  45 :  45 :  45 :  45 :  45 :  45 :  45 :
> > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > 1.) 0x19C: IA32_THERM_STATUS: 88450000
> > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination
> > enabled
> > OOB Bit 8 reset OOB Bit 18 reset
> > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88410000
> > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO
> > disable
> > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B2930 : high 48 :
> > guaranteed 41 : efficient 11 : lowest 1
> > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-11 :
> >     raw: 80003001 : 80003001 : 80003001 : 80003001 : 80003001 :
> > 80003001 : 80003001 : 80003001 : 80003001 : 80003001 : 80003001 :
> > 80003001 :
> >     min:        1 :        1 :        1 :        1 :        1 :
> > 1 :        1 :        1 :        1 :        1 :        1 :        1 :
> >     max:       48 :       48 :       48 :       48 :       48 :
> > 48 :       48 :       48 :       48 :       48 :       48 :       48
> > :
> >     des:        0 :        0 :        0 :        0 :        0 :
> > 0 :        0 :        0 :        0 :        0 :        0 :        0 :
> >     epp:      128 :      128 :      128 :      128 :      128 :
> > 128 :      128 :      128 :      128 :      128 :      128 :      128
> > :
> >     act:        0 :        0 :        0 :        0 :        0 :
> > 0 :        0 :        0 :        0 :        0 :        0 :        0 :
> > 7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 :
> > lowest 0
> >
> > ...
> >
> > ... Doug
>
>
