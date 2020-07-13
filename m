Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F1F21DAFC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgGMP73 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:59:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36111 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgGMP70 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:59:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id 72so9895141otc.3;
        Mon, 13 Jul 2020 08:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0UW5vWMAZAwDcJY+/m5O81tARF1bbt8Cu9sjbCPdQc=;
        b=pvwWVYcFE52Sjjv8nPH1lWMtq57W6PeUWm9LyQG8WJq0qmZ1HMNt7qSibFubPffqWS
         VXGNy0QRYrw2OCr7tzz9GXoTY9lHWHmzPC/drSdwiHoW8MrqQpb7828GgDcrdAGN3URg
         YIBto62Jv7DghRdWKHlknINZP+RuPqijWkuZAebWsnr0xKrMt8/KGnASH5dMmEOyUbsK
         d039qo9b7Y18X5vU05k3vNV51TDblLSW5G8L9Ma4NFjFZOqUtEbULGFiyhLHGJT/8slS
         o/S29pl4xcVSM7wO1v3X8LLvXpUXiQP2YIWOq1Xo9Nhg6uWTg/cEW2OHrltzELzd2199
         FVVA==
X-Gm-Message-State: AOAM530sIqTOT13kXJFwxsy5D0NpqK73tlsK5qbmQk15g8+oXUhmh6uC
        4X6JIX9gIhaAYZ4cWirP0hxLtxfdcBfxVAAO3JQ=
X-Google-Smtp-Source: ABdhPJwbZZyJgt7RrFgdoqfSrsynterBjG99QZZE8gdkk39une0PoOFFF8ROkZLv8bQUVWjnQ/sYIMccGdvLV4nyTRg=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr196730ota.167.1594655965552;
 Mon, 13 Jul 2020 08:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200713105502.33482-1-grandmaster@al2klimov.de>
In-Reply-To: <20200713105502.33482-1-grandmaster@al2klimov.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Jul 2020 17:59:14 +0200
Message-ID: <CAJZ5v0iMGtaYcvOkG+1pZ1TFivAU-M2EDcKs-PfLF2KwRTaPUg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 13, 2020 at 12:55 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
>
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
>
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
>
>  If you apply the patch, please let me know.
>
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
>
>
>  drivers/cpufreq/acpi-cpufreq.c    | 2 +-
>  drivers/cpufreq/davinci-cpufreq.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 429e5a36c08a..29e8ff422b91 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -612,7 +612,7 @@ static const struct dmi_system_id sw_any_bug_dmi_table[] = {
>  static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>  {
>         /* Intel Xeon Processor 7100 Series Specification Update
> -        * http://www.intel.com/Assets/PDF/specupdate/314554.pdf
> +        * https://www.intel.com/Assets/PDF/specupdate/314554.pdf
>          * AL30: A Machine Check Exception (MCE) Occurring during an
>          * Enhanced Intel SpeedStep Technology Ratio Change May Cause
>          * Both Processor Cores to Lock Up. */
> diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
> index 297d23cad8b5..91f477a6cbc4 100644
> --- a/drivers/cpufreq/davinci-cpufreq.c
> +++ b/drivers/cpufreq/davinci-cpufreq.c
> @@ -2,7 +2,7 @@
>  /*
>   * CPU frequency scaling for DaVinci
>   *
> - * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
>   *
>   * Based on linux/arch/arm/plat-omap/cpu-omap.c. Original Copyright follows:
>   *
> --

Applied as 5.9 material, thanks!
