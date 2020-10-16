Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2241F2907FA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409162AbgJPPLi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:11:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45509 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406926AbgJPPLi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:11:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id j7so2750686oie.12;
        Fri, 16 Oct 2020 08:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1cWWdYktv9KzOmDwgjjOczko8U/7YWosUu3S0VLH7A=;
        b=dF8bUXGCAnZgBFj4ABCpa5eHLuoVdUhP4OJspb+JDvYNVKgCIFQQPme/UVJroPS2Gl
         zehFvIfxmn8u0pQwD4juBtnIzs5S/YPfZxSN3fcP/HZroJUKRELtdpsdAeMIUQG9FG7c
         mtuqf4qPBxYOXeurHwmKK4EAmDjnSOaHIk9EMV134/vFSR23s8I1JqqEA8R8UQwKLaqr
         Gy/b6lhFQQrlPathVUA0NpEl1nKnho7qpzOSgvhIsATP3wVl0J1n0uHG9eDZC5B+tkbt
         LCtGkmGX8zFgO3WVGx0oVkrZ1BDREJhR4iDNlWakULhchq4K2/3d2jWYTF6q0woPytg7
         a+eQ==
X-Gm-Message-State: AOAM530vUdRN4BUqYLBbOFsVIEQXMCsCcbc7S3ToTuWHkt8pvifpj2eX
        Z1fYJI8ylHnCZvZc+Cis+GyuxvmNMP3kFLf26xs=
X-Google-Smtp-Source: ABdhPJzt1e/31LrtSJL1Z+WRHh7ll27TcGg5kT7kfGc85/OMNjQlPkJNhXDpjSLUM6NqK7gUjZO/eVNnJVUFf9kXV5M=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2806924oii.69.1602861097688;
 Fri, 16 Oct 2020 08:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125033.2809-1-amonakov@ispras.ru>
In-Reply-To: <20201012125033.2809-1-amonakov@ispras.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:11:26 +0200
Message-ID: <CAJZ5v0ggvwHhkZHNf2V+fk=vxQjVN_twL8TD7BFhz6jzjnR5vw@mail.gmail.com>
Subject: Re: [PATCH v2] intel_idle: mention assumption that wbinvd is not needed
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 12, 2020 at 2:51 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> Intel SDM does not explicitly say that entering a C-state via MWAIT will
> implicitly flush CPU caches as appropriate for that C-state. However,
> documentation for individual Intel CPU generations does mention this
> behavior.
>
> Since intel_idle binds to any Intel CPU with MWAIT, list this assumption
> of MWAIT behavior. In passing, reword opening comment to make it clear
> that the driver can load on any old and future Intel CPU with MWAIT.
>
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v2: reword remark about WBINVD (Rafael)
>
>  drivers/idle/intel_idle.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index f4495841bf68..6d87f2129119 100644
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
> + *     (in contrast to entering ACPI C3, in which case the WBINVD
> + *     instruction needs to be executed to flush the caches)
>   */
>
>  /*
> --

Applied as 5.10-rc material, thanks!
