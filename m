Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF828B31B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbgJLKzu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 06:55:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33653 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbgJLKzt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 06:55:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id s21so468040oij.0;
        Mon, 12 Oct 2020 03:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+hd10jJuHFvk+cIEZrswP+cpusL+l5/ShjyumJlZ9g=;
        b=ZgFZBnMdEYDKqq+Bx2p6/yz48WlzqwItTm7c06rwczQY62jD6wsParNcogWhidi5oO
         JybDcx9C8UdJ7NVdIPoC3mdyp+irkbqfw1HAvVWZEHpBFebLLnUQceCxT2jCmRILX9WO
         QXhjeaCGDY9zat4Z1fln2u6Dom/4szIsQtSyIO77BsJJJyuwbLA+dOEK1ScPgw4n4Rc5
         5Fp1PPOW8pNXeLe/FfhmbwQeuus60fDuCYc0VfETYSJXp/i2dIxlcLYvTiuHbRPwN3m2
         M92WpaiQRiV+rNQc1+JjsEy1Lcax92csvuy6/qS83Qvru90PxpDOsclD2w6TW+ucVceV
         iI8g==
X-Gm-Message-State: AOAM533Tj/5v1sMYbF2HHcUrHZc84YmEzw71Hn3w8zmgT0aZZo5tKROW
        ggJyv+QyFE8+mu+kreLWF3c7KpMpLSnsCDWmRk/PSL10V/E=
X-Google-Smtp-Source: ABdhPJyF1gQYc/tPRiLsXbeuSgURmZLIMAPjNV3JpAj72mu2R9FAlHx36tHhzdYVkRix9k4XZ6SMTnzXOnPVICqPoys=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr10403675oii.69.1602500147705;
 Mon, 12 Oct 2020 03:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201010221806.2106-1-amonakov@ispras.ru>
In-Reply-To: <20201010221806.2106-1-amonakov@ispras.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 12:55:32 +0200
Message-ID: <CAJZ5v0iFj0s=ZNrLnBxQ34uUnn2NQ6bH+oriyNWrFu-g8HGfUg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: mention assumption that wbinvd is not needed
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 11, 2020 at 1:13 AM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> Intel SDM does not explicitly say that entering a C-state via MWAIT will
> implicitly flush CPU caches as appropriate for that C-state. However,
> documentation for individual Intel CPU generations does mention this
> behavior.
>
> Since intel_idle binds to any Intel CPU with MWAIT, mention this
> assumption on MWAIT behavior. In passing, reword opening comment
> to make it clear that driver can load on any future Intel CPU with MWAIT.
>
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Hi,
>
> I noticed that one of significant optimizations of intel_idle over
> acpi_idle is elision of explicit wbinvd: ACPI requires the OS to flush
> caches when entering C3, and Linux issues an explicit wbinvd to do that,
> but intel_idle simply issues mwait with the expectation that the CPU
> will automatically flush caches if needed.
>
> To me this is a fairly subtle point that became even more subtle
> following the update to intel_idle that made it capable to bind to old
> and future Intel CPUs with MWAIT (by the way, thanks for that!)
>
> Can you take this patch to spell out the assumption?
>
>  drivers/idle/intel_idle.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index f4495841bf68..1e5666cf8763 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -8,7 +8,7 @@
>   */
>
>  /*
> - * intel_idle is a cpuidle driver that loads on specific Intel processors
> + * intel_idle is a cpuidle driver that loads on all Intel CPUs with MWAIT
>   * in lieu of the legacy ACPI processor_idle driver.  The intent is to
>   * make Linux more efficient on these processors, as intel_idle knows
>   * more than ACPI, as well as make Linux more immune to ACPI BIOS bugs.
> @@ -20,7 +20,11 @@
>   * All CPUs have same idle states as boot CPU
>   *
>   * Chipset BM_STS (bus master status) bit is a NOP
> - *     for preventing entry into deep C-stats
> + *     for preventing entry into deep C-states
> + *
> + * CPU will flush caches as needed when entering a C-state via MWAIT

I would rephrase this to mention that the above actually is an assumption.

> + *     (in contrast to entering ACPI C3, where acpi_idle driver is

And mentioning acpi_idle here is not needed; it would be sufficient to
say something like "in which case the WBINVD instruction needs to be
executed to flush the caches".

> + *     itself responsible for flushing, via WBINVD)
>   */
>
>  /*
> --

Thanks!
