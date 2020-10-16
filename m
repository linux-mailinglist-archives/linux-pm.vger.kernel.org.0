Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C75290672
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404478AbgJPNlZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:41:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44160 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395255AbgJPNlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:41:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id e20so2386768otj.11;
        Fri, 16 Oct 2020 06:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDw6us/ymT1w8JQKh1+hOfSJ0DL7eGX/CDAwjYTDpuA=;
        b=RV+r8AtuKpgXZO5PeAulS/PYymXiWw0b8YEy33PGrz1NpFuDGctqsCo6gyk/7yQiD6
         Zp1tkMKtrhiflQSDtmGAy6FWM2zlZctJmkn6Lzn1SdJt/LviO79fdS7NK+qHTEvaA1TV
         ztqgBWA2wLiMmVmWreVoSezj+W3fx7oYP6/SHNARVlkDuBjAKSZ6EtV3dgdMcU8XX7/+
         EVJzpy5xnI31cfmcoMtoNyAOYdO3VSJgJHRjMfN80uF23I7bBkpXIBwFctLOQqlv9qPX
         Pyzru+h3zOQHfRAANm0ejYk2tGZ4mqgtuw6uhpW1LykD9QfrnNuShkGO3TjmqJlF/kXh
         se+A==
X-Gm-Message-State: AOAM532fBxB3fWSHNby5srQn/7OGM6rkU8hoWj3/+AAeEHd676KL91FX
        h9UwWZp3JuQgiBJwjakKADYbFrbpUMDTbZG3GBM=
X-Google-Smtp-Source: ABdhPJxRyuvIqMQV3+EzV/OlzhrdUcDEUgjwsCnM/euQIUfl0/FUTZF8o0wdgj3jbQU9AkFDtIC6FSFyxcs+3/xiEXc=
X-Received: by 2002:a9d:ac9:: with SMTP id 67mr2703887otq.321.1602855683757;
 Fri, 16 Oct 2020 06:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <c3566d2b-3da1-917b-2df6-f7dcfb33c8ed@intel.com>
 <20201006190322.GL3227@techsingularity.net> <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net> <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
 <20201008090909.GP3227@techsingularity.net> <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
 <20201008173436.GQ3227@techsingularity.net> <f6b04376-4214-ff5d-1069-890449a923e2@intel.com>
 <20201014223703.GT3227@techsingularity.net> <20201015183410.GU3227@techsingularity.net>
In-Reply-To: <20201015183410.GU3227@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 15:41:12 +0200
Message-ID: <CAJZ5v0jzZ6iQGYNnkgi-pPmdbq3aH+RoH+tBbEoBxFfmt_0MDg@mail.gmail.com>
Subject: Re: ACPI _CST introduced performance regresions on Haswll
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 15, 2020 at 8:34 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> > Yes, it's well hidden but it's there. If the profile is made custom, then
> > the p-states can be selected and "custom" default enables C6 but not C3
> > (there is a note saying that it's not recommended for that CPU). If I
> > then switch it back to the normal profile, the c-states are not restored
> > so this is a one-way trip even if you disable the c-state in custom,
> > reboot, switch back, reboot. Same if the machine is reset to "optimal
> > default settings". Yey for BIOS developers.
> >
> > This means I have a limited number of attempts to do something about
> > this. 2 machines can no longer reproduce the problem reliably.
> >
>
> Turns out I didn't even have that. On another machine (same model,
> same cpu, different BIOS that cannot be updated), enabling the C6 state
> still did not enable it on boot and dmesg complained about CST not being
> usable. This is weird because one would expect that if CST was unusable
> that it would be the same as use_acpi == false.
>
> This could potentially be if the ACPI tables are unsuitable due to bad
> bad FFH information for a lower c-state. If _CST is not found or usable,
> should acpi_state_table.count be reset to go back to the old behaviour?

Yes, it should, although I would reset it in intel_idle_cst_usable()
right away before returning 'false'.

I can send a patch to do the above or please submit the one below as
it works too.

> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 13600c403035..3b84f8631b40 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1261,6 +1261,7 @@ static bool intel_idle_acpi_cst_extract(void)
>                 return true;
>         }
>
> +       acpi_state_table.count = 0;
>         pr_debug("ACPI _CST not found or not usable\n");
>         return false;
>  }
>
> --
