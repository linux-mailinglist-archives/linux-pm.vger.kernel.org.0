Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4BB3F7C07
	for <lists+linux-pm@lfdr.de>; Wed, 25 Aug 2021 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbhHYSIi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Aug 2021 14:08:38 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42642 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbhHYSIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Aug 2021 14:08:38 -0400
Received: by mail-ot1-f49.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so68830otk.9;
        Wed, 25 Aug 2021 11:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBhKgJXwtRuKkyuUOozNOA3zhnnr2AaXGBgtEDyTnPY=;
        b=StjvTQvsEWt5kZP318jc43xnXg14GS1Wp4NgeNWCUDNUkstjjbjC1hIma3LTjkPlLw
         irbU6P6Ulshr2m4sZjT3LpvpejK5KvJRMR7mbdyZUU0QOkSkK+vuDhqh1vIWQGcgXYYX
         mDSYaN1Q+yxV8VymOjINybXLILvtiwniOkUsYGqAnR1uNsRvAFkaFdaWDmdK0Qn2TcAL
         vy8Rb9enmu5K6ghXyajflZ/8Ruyh17VPJbLZmbWWqbcA6UeVdW4dqm5oW19KPxzbgrR3
         GreJpWdWxH3P4B/JXT9+hkkx1aqInmaxOm0r2j6cpDLKVEnNZZqV0m+uNy3HIHv5jNrL
         jjSg==
X-Gm-Message-State: AOAM530mAcvSFvFJ+OojKSYbfEH4QVIAIAA+r0PyQt/R0HyO+9wgSr/b
        GSYq2Rg/CVGgQFxJ0XO4WjCLRhvis1AxARcs+cY=
X-Google-Smtp-Source: ABdhPJz0Zho6TQi3O0gMD6uj30AOc12BMXUDSb4gbn3p6TNX0wN22JdeML9eibp94h64829FmT+iYJScjZ/WZ0Ic9X8=
X-Received: by 2002:a05:6830:1f59:: with SMTP id u25mr39030356oth.321.1629914871814;
 Wed, 25 Aug 2021 11:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210819004305.20203-1-deepak.sharma@amd.com>
In-Reply-To: <20210819004305.20203-1-deepak.sharma@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 20:07:40 +0200
Message-ID: <CAJZ5v0jWX=H=aZ25PzHdH05bRJvtYbGHfyTgH_68k4kfYkZc5A@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
To:     Deepak Sharma <deepak.sharma@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Thu, Aug 19, 2021 at 2:43 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
>
> AMD CPU which support C3 shares cache. Its not necessary to flush the
> caches in software before entering C3. This will cause performance drop
> for the cores which share some caches. ARB_DIS is not used with current
> AMD C state implementation. So set related flags correctly.
>
> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>

Applied as 5.15 material under the edited subject "x86: ACPI: cstate:
Optimize C3 entry on AMD CPUs", thanks!

> ---
>  arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 7de599eba7f0..62a5986d625a 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>                  */
>                 flags->bm_control = 0;
>         }
> +       if (c->x86_vendor == X86_VENDOR_AMD) {
> +               /*
> +                * For all AMD CPUs that support C3, caches should not be
> +                * flushed by software while entering C3 type state. Set
> +                * bm->check to 1 so that kernel doesn't need to execute
> +                * cache flush operation.
> +                */
> +               flags->bm_check = 1;
> +               /*
> +                * In current AMD C state implementation ARB_DIS is no longer
> +                * used. So set bm_control to zero to indicate ARB_DIS is not
> +                * required while entering C3 type state.
> +                */
> +               flags->bm_control = 0;
> +       }
>  }
>  EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
>
> --
> 2.25.1
>
