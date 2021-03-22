Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B859C3445CA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 14:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVNcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 09:32:46 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41728 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhCVNcm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 09:32:42 -0400
Received: by mail-oi1-f176.google.com with SMTP id z15so13035602oic.8;
        Mon, 22 Mar 2021 06:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wr1SI0TL4EHWYS5BZNgIxSW5Ww590y/QRaEpzzFSZ2s=;
        b=rfdxamLeBHSwrUonHQ0ojaDV7eJ6oaH9DXXEDmTy2Ln8TnTD+GAd9Iy5WjpscHtOWI
         hiHs6UeIAIDMts2h6MHwbHbBpbdy7q/Ne3TyYQFop0Kpzi8rvj7JXLJ0v7yM6sJaFBcC
         ds9FY5nQ8cuRZXxoCeAVuMG+4Gse4MEhRcpGdJUOWrHN/xdIq9NIl0lNwg/4PjilVQz7
         wuSkSuLY5RvcHOmz8SDeX3U7pzXZ5uu82iA6hIG+ODId1gJF+1LoeRCruJ0xbdZoiDg7
         DYAIEO9Wg6bF03sH3ilHT+u1B7hJ4vu2hCezMdaFIdn9IFMXWzSHgBi53bDLOlWWX77H
         yIcQ==
X-Gm-Message-State: AOAM532VU1I3h9vjqR9L1FwB5m7ZdujdG2+TcqFUevJm1+G7DMhKfduS
        /mCAjwfzgcRCNaqAjp7Q04zNF47jxuyzhVcNW8Q=
X-Google-Smtp-Source: ABdhPJwmYah6xhBmpTTkzua8+uROxwaMkuwp5QTUXoR4ZzqUuujkXaSLHlcUQFRTn0BjZDxXFvvHGGaz0Wrt6L97+Qo=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr10022819oie.157.1616419961613;
 Mon, 22 Mar 2021 06:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210321201818.15271-1-fazilyildiran@gmail.com>
In-Reply-To: <20210321201818.15271-1-fazilyildiran@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Mar 2021 14:32:26 +0100
Message-ID: <CAJZ5v0gYxpzNUzSbkH1mJZuFB464JHMSQ-KeP-raJAPb=3mo=A@mail.gmail.com>
Subject: Re: [PATCH] PM: Kconfig: fix unmet dependency for PM_SLEEP_SMP
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        paul@pgazz.com, jeho@cs.utexas.edu, julianbraha@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 21, 2021 at 9:20 PM Necip Fazil Yildiran
<fazilyildiran@gmail.com> wrote:
>
> When PM_SLEEP_SMP is enabled and HOTPLUG_CPU is disabled, it results in the
> following Kbuild warning:
>
> WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>   Selected by [y]:
>   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
>
> The reason is that PM_SLEEP_SMP selects HOTPLUG_CPU without depending on or
> selecting HOTPLUG_CPU's dependencies.

This needs to be fixed.

HOTPLUG_CPU needs to be selected automatically by PM_SLEEP_SMP as it is now.

> Let PM_SLEEP_SMP depend on HOTPLUG_CPU instead to avoid Kbuild issues.
>
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> ---
>  kernel/power/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 6bfe3ead10ad..8b53c9b61347 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -125,7 +125,7 @@ config PM_SLEEP_SMP
>         depends on SMP
>         depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
>         depends on PM_SLEEP
> -       select HOTPLUG_CPU
> +       depends on HOTPLUG_CPU
>
>  config PM_SLEEP_SMP_NONZERO_CPU
>         def_bool y
> --
> 2.25.1
>
