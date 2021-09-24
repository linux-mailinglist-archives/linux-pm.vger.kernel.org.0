Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B70417916
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbhIXQue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 12:50:34 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34532 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbhIXQud (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 12:50:33 -0400
Received: by mail-ot1-f41.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so8247882otb.1;
        Fri, 24 Sep 2021 09:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5K4cABxcVWxR6DLYWr2e4RPFZO80BE4h3PW/K8t1Eik=;
        b=1YOrA2FEtYT/iWo3VifghQfHCnTk2ZXGDxrC4rfmY3GVreSVYBNeMz5E4qNBI0UzFe
         bnMucILKrrBcim6zHwcvCDfbHe+3TeHewVQvR9Eyr5RbFEXUjsBkMNge39+z0I9aqZ9/
         MZlSwTD1Lb1dtCOlZmr25g69rIaSvK5Rob914cLfsHK6r8otPrrljyzTZx7hiR1mzZ3c
         lqSdbkgPWGSvrRxg3NP22ieFjUU0L+aAAEx/gxPGIyWET2lWirGkXqwIT0vCHaTk1b0G
         rF3gUShk5QrQOVQ2lL4mk5EpnRwEpWHmHbYIiid+zOjtWTjDe38N8igDEE1IQEPFa35X
         Vjlw==
X-Gm-Message-State: AOAM533ZQ8mgTkyIslLM2kQjmxVoXBSMDHqK818yp6ipfXNfZSo5l0nf
        BQjIP3epuaSA4B/CBI7y4ZAbjrvGSFCMQdGqotY=
X-Google-Smtp-Source: ABdhPJxrwy3alQD5Z51/akbAkmwWUKeFBOnntyzt8Jj20eqcLlVwTAeCwqUve5VwvLkJzWnzkj780IEQAogdhKCb9b8=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr5158915otr.301.1632502139499;
 Fri, 24 Sep 2021 09:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210924061205.5523-1-deepak.sharma@amd.com>
In-Reply-To: <20210924061205.5523-1-deepak.sharma@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 18:48:48 +0200
Message-ID: <CAJZ5v0iS+TnkoqCxLa92Na=By53PXY-qW=k4utr_84KYaw+sVQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] x86: ACPI: cstate: Optimize C3 entry on AMD CPUs
To:     Deepak Sharma <deepak.sharma@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 24, 2021 at 8:12 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
>
> All Zen or newer CPU which support C3 shares cache. Its not necessary to
> flush the caches in software before entering C3. This will cause drop in
> performance for the cores which share some caches. ARB_DIS is not used
> with current AMD C state implementation. So set related flags correctly.
>
> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>

I'm planning to take this one unless the x86 maintainers have concerns, thanks.

> ---
>  arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 7de599eba7f0..7945eae5b315 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>                  */
>                 flags->bm_control = 0;
>         }
> +       if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17) {
> +               /*
> +                * For all AMD Zen or newer CPUs that support C3, caches
> +                * should not be flushed by software while entering C3
> +                * type state. Set bm->check to 1 so that kernel doesn't
> +                * need to execute cache flush operation.
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
