Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EE83FDC43
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbhIAMse (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 08:48:34 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45752 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbhIAMq3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 08:46:29 -0400
Received: by mail-ot1-f50.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso3221559otv.12;
        Wed, 01 Sep 2021 05:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6/i3NZnet89UyQ9e4UbJHMSWylrIr0dvo/VnaEs/+4=;
        b=qp/PlfbODaNOdNZ3Qms5M/CfXYLcDNGcxMwruFymfGnD18qTFL3erig1tgV34FzIUd
         mrOxaE0N/9AZR/mqZJO4Nt+ts0tDXKbA5WPt2+eb3DvzRTXYcMn3XZ/732iVhSS4P4RH
         YctFszQ9dNezYgJcGzrkpHFI8VNbMS47RqPcdxoP5U+I6xioYZpMmr7wt/zUOw4dkFkT
         kg6ne2BBKQ5lQsxGajoonW1oc08sgGjhjoyx32N26p4pV6tlhtBtJ/QQeUBIVunDIE8s
         xSXSTQ20nOPCe0qJJAr6v3dvHER/OJVpFTfoI5nAjwgXgVdFWjutVNu875daSQD64TjE
         kMbA==
X-Gm-Message-State: AOAM5326ESWjGrF5fO/kr0KSrFFdOIQo5WjzbzGazjxIMV0qi8MIcXXj
        npKsRfOndwql0PaDwOkEMQ+jZSTPs5BmFxr/uqI=
X-Google-Smtp-Source: ABdhPJz1ArAHLAscwIWQjhp8pZZZSSKCKqX+ZqvZTsLPtnV2JVffdIdHjP7mJ2V7Ci06i+AqdgwDnNlj8lb5v6Ehj0k=
X-Received: by 2002:a9d:705d:: with SMTP id x29mr1487576otj.260.1630500327788;
 Wed, 01 Sep 2021 05:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210819004305.20203-1-deepak.sharma@amd.com> <CAJZ5v0jWX=H=aZ25PzHdH05bRJvtYbGHfyTgH_68k4kfYkZc5A@mail.gmail.com>
 <951c4f8f-30ee-77d3-afb7-46e45c84213d@amd.com>
In-Reply-To: <951c4f8f-30ee-77d3-afb7-46e45c84213d@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 14:45:15 +0200
Message-ID: <CAJZ5v0ic+0MKDbebrxnyxr=rRJbqP4LmB4g1fVVAVJWh98e=MA@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
To:     Deepak Sharma <deesharm@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 1, 2021 at 4:14 AM Deepak Sharma <deesharm@amd.com> wrote:
>
>
> On 8/25/21 11:07 AM, Rafael J. Wysocki wrote:
> > On Thu, Aug 19, 2021 at 2:43 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
> >> AMD CPU which support C3 shares cache. Its not necessary to flush the
> >> caches in software before entering C3. This will cause performance drop
> >> for the cores which share some caches. ARB_DIS is not used with current
> >> AMD C state implementation. So set related flags correctly.
> >>
> >> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> > Applied as 5.15 material under the edited subject "x86: ACPI: cstate:
> > Optimize C3 entry on AMD CPUs", thanks!
>
> I might need to send subsequent patch for this. Can you please point me
> to git and branch where this has been merged.

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

> >> ---
> >>   arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
> >>   1 file changed, 15 insertions(+)
> >>
> >> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> >> index 7de599eba7f0..62a5986d625a 100644
> >> --- a/arch/x86/kernel/acpi/cstate.c
> >> +++ b/arch/x86/kernel/acpi/cstate.c
> >> @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
> >>                   */
> >>                  flags->bm_control = 0;
> >>          }
> >> +       if (c->x86_vendor == X86_VENDOR_AMD) {
> >> +               /*
> >> +                * For all AMD CPUs that support C3, caches should not be
> >> +                * flushed by software while entering C3 type state. Set
> >> +                * bm->check to 1 so that kernel doesn't need to execute
> >> +                * cache flush operation.
> >> +                */
> >> +               flags->bm_check = 1;
> >> +               /*
> >> +                * In current AMD C state implementation ARB_DIS is no longer
> >> +                * used. So set bm_control to zero to indicate ARB_DIS is not
> >> +                * required while entering C3 type state.
> >> +                */
> >> +               flags->bm_control = 0;
> >> +       }
> >>   }
> >>   EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
> >>
> >> --
> >> 2.25.1
> >>
