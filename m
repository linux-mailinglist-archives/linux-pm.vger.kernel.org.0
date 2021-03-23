Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D43462B4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhCWPYF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 11:24:05 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:43866 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhCWPYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 11:24:04 -0400
Received: by mail-oo1-f44.google.com with SMTP id x187-20020a4a41c40000b02901b664cf3220so5012435ooa.10;
        Tue, 23 Mar 2021 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1aJHxkNOulF9VwGvuT/m1YBztH1QSi19tLg5bArcsI=;
        b=Ic5qwzHjMBOBBsm0tBJtpmitCe2Hb2pZRU3HoDrYd/pbHPl93n1VOxprd9iyjkrgTW
         L5n6SAMZnEeHQlu09OQ/JJ/NiXOo86PXyUvhe3SkJAjtHjHjyHliTTW0uwHGqbMzJ3NF
         7JV39Na2ur+j4VOiCI4848hPw63zcolfAKyhylBbYf4u8M2975JHG+6TqW8ZaOHhuOKC
         k7wUWXq3HqSOUYMPH2NOMD4Z0PzysedtzXWWEGrlVsjhJvsx/pNr/VKjl01KOkhHvP85
         VWrC1WsMnqmBAKmUMnpizfgfldHYJNX6e/3ViSjBy8v5M2QSGWahB72ZBq1L2Xe9Cdoa
         kVyA==
X-Gm-Message-State: AOAM533W0YGJ90Dk0YRQCvDqH+qQhoL0GLUy5hrue47s/1viDJWAW/tl
        eOCHAmnrCHm9sfJ3yhN7RoAaDbGPHqyBxKz5ysk=
X-Google-Smtp-Source: ABdhPJyc3/573cx+tcIb+D71wmSxdJpa1By54b9Kza4tcBR2YK9yTFt8FUwdZQFuRrLwNF0BL+PACpMOoEpdYezanLQ=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr4278345oou.44.1616513043457;
 Tue, 23 Mar 2021 08:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210323141405.55115-1-fazilyildiran@gmail.com>
In-Reply-To: <20210323141405.55115-1-fazilyildiran@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Mar 2021 16:23:52 +0100
Message-ID: <CAJZ5v0hU6tnCJZFO63N-GRPo41jyj_LbJ3OGKdgBgJXZZuqtJg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Kconfig: fix unmet dependency for PM_SLEEP_SMP
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

On Tue, Mar 23, 2021 at 3:16 PM Necip Fazil Yildiran
<fazilyildiran@gmail.com> wrote:
>
> When PM_SLEEP_SMP is enabled and HOTPLUG_CPU is disabled, it results in
> the following Kbuild warning:
>
> WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
>   Selected by [y]:
>   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=n] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]
>
> The reason is that PM_SLEEP_SMP selects HOTPLUG_CPU without depending on
> or selecting HOTPLUG_CPU's dependencies.
>
> Let PM_SLEEP_SMP depend on HOTPLUG_CPU's dependencies to avoid Kbuild issues.
>
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
> ---
> v1->v2:
> * Keep selecting HOTPLUG_CPU by PM_SLEEP_SMP as it needs to be selected
> automatically, let PM_SLEEP_SMP depend on missing dependencies instead.
> ---
>  kernel/power/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 6bfe3ead10ad..0c4aa403e04a 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -125,6 +125,7 @@ config PM_SLEEP_SMP
>         depends on SMP
>         depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
>         depends on PM_SLEEP
> +       depends on PPC_PSERIES || PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE

This would make it not work on non-PPC, wouldn't it?

>         select HOTPLUG_CPU
>
>  config PM_SLEEP_SMP_NONZERO_CPU
> --
