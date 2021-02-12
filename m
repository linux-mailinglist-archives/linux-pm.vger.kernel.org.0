Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EDB31A201
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhBLPqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 10:46:30 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41685 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhBLPqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 10:46:24 -0500
Received: by mail-ot1-f46.google.com with SMTP id s107so8740985otb.8;
        Fri, 12 Feb 2021 07:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SefNymZoQqys6Wmf/7JERZFC056mrOXLncjqPcwBSps=;
        b=GMb5aDBPyIilDjhvgdbGoC43wEsSCthOPJDwEE5xuk4Z4ZyyX+ruAb3uh3K8e7AJaq
         cgZOD8gxwnVJgCmh/LLKHMvUGiPk+ZNU9PPfywlWyt73ObtDJtQGoeIccih8AT8LS/ld
         kz1fg5opz3tx2WbzJqey72zdCOB7wq8OUeaUqTNJSarw540+yn3oLX5FGkAKITjAJIox
         A4rU04TTCtxo4ZTQGojHmFccDaMBuzAkPnTqruGdZwZWIWpvSHBXCAtw4cQDag33gHvi
         CGmCcz/PGQ0XDXcdkya/ItVpVYAWgTpBQia3jqe5nB/O/uoPC0INdCDI1WyiTInifDqq
         A7OQ==
X-Gm-Message-State: AOAM53094vrTAS+TOQhQ+en8NSKf4eDZ6cI4wM2V1Ee9V373U3SKSIwo
        F58FH07MvYCZP8NVM447TJHpaM1bi49qndZDG8c=
X-Google-Smtp-Source: ABdhPJxZCy3tRdxx0qW6Z9mmCnUqVGmYj7GPV7ltAioN6mPPtD1lGZYkIt4GbaTPw586vm8l/2y+edbWSrOhhV5Gs/k=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr2365142otc.260.1613144743381;
 Fri, 12 Feb 2021 07:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20210209105435.21036-1-lukasz.luba@arm.com>
In-Reply-To: <20210209105435.21036-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 16:45:32 +0100
Message-ID: <CAJZ5v0hZsns4_An-kCbdVjzXWp9QC+b1FV2WsfRqfEhvT=rs9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / EM: update Kconfig description and drop "default
 n" option
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 9, 2021 at 11:58 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Energy Model supports now other devices like GPUs, DSPs, not only CPUs.
> Thus, update the description in the config option. Remove also unneeded
> "default n". If the "default" line is removed, it defaults to 'n'.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Applied along with the [2/2[ as 5.12 material, thanks!

> ---
>  kernel/power/Kconfig | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index a7320f07689d..56dbc2616d5c 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -322,15 +322,14 @@ config CPU_PM
>         bool
>
>  config ENERGY_MODEL
> -       bool "Energy Model for CPUs"
> +       bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
>         depends on SMP
>         depends on CPU_FREQ
> -       default n
>         help
>           Several subsystems (thermal and/or the task scheduler for example)
> -         can leverage information about the energy consumed by CPUs to make
> -         smarter decisions. This config option enables the framework from
> -         which subsystems can access the energy models.
> +         can leverage information about the energy consumed by devices to
> +         make smarter decisions. This config option enables the framework
> +         from which subsystems can access the energy models.
>
>           The exact usage of the energy model is subsystem-dependent.
>
> --
> 2.17.1
>
