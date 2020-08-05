Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD1423C76C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgHEIIh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 04:08:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40080 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgHEIIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 04:08:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id h16so12610866oti.7;
        Wed, 05 Aug 2020 01:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uD4hPPFrvL18wYQY890DHm7IhBXmpPd92E8QGoGXHIs=;
        b=tzCIX4pv6YQ9CNlEp5z3izFY4+iiRivW8x0tvhoj5yhEJydn7pK97EUy/AiorIqtAJ
         RiXBkWZ+J4cHpHUU+JzPi4Zdff1pi7w9HVesgpO6JiKRwarfukWVT0E2fuo+FUyiKdyX
         4EAthlGGubhQ4oCmutxIrQlfZhjYzcmN+6FmYWVGUOahXyrlThIa9HeXDT2gfnvMLNVu
         sOhvLmqcpbUpGgNVWl9hJqjSZLZwKsdOTV8qVZkml/LTlwKVdWP8nUdLBhcILNdI/SJF
         i1Vqi1y8A4qFaU2BJXtyCqJ6fRh0X1YUlpFOEbud2uWkOCCcyiOT3nY+fj9McfmOejyA
         kAQw==
X-Gm-Message-State: AOAM5321NIEgu5s+pwX/B0sZLuPC432XsU5uoAiyccYXIuAjS9ws1X4e
        nw2UfCLssYXJEpzpAsCEkl+3TqM5h/g3XhXcbpm8flGe
X-Google-Smtp-Source: ABdhPJyJwmcP9aNp9I6r/CJUNFpM0wKCfNLkR//0n97vBQtlejzoEvu+GFb6PAlrnYuDq5SlXH53h1Wt/trTMFDoMCA=
X-Received: by 2002:a9d:7d8c:: with SMTP id j12mr1687821otn.250.1596614894453;
 Wed, 05 Aug 2020 01:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <1592792699-24638-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1592792699-24638-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1592792699-24638-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Aug 2020 10:08:03 +0200
Message-ID: <CAMuHMdXr+tV1w+dkjUM0aMozp9mAHC=YRcZ1ThTMyLQSQwXWiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] firmware: psci: call pm_set_suspend_via_firmware()
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shimoda-san,

CC linux-pm

On Mon, Jun 22, 2020 at 4:25 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Call pm_set_suspend_via_firmware() in .begin() of psci_suspend_ops
> to use pm_suspend_via_firmware() on PSCI environment.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

While [PATCH v3 2/2] has been rejected, and a different solution (DT
property "full-pwr-cycle-in-suspend") was accepted, I think this patch
has merits on its own: it makes sure pm_suspend_global_flags contains
the correct state not only for systems using ACPI, but also for PSCI.

> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -309,6 +309,13 @@ static int psci_system_suspend(unsigned long unused)
>                               __pa_symbol(cpu_resume), 0, 0);
>  }
>
> +static int psci_system_suspend_begin(suspend_state_t state)
> +{
> +       pm_set_suspend_via_firmware();
> +
> +       return 0;
> +}
> +
>  static int psci_system_suspend_enter(suspend_state_t state)
>  {

Shouldn't you add a call to pm_set_resume_via_firmware() here?

>         return cpu_suspend(0, psci_system_suspend);
> @@ -316,6 +323,7 @@ static int psci_system_suspend_enter(suspend_state_t state)
>
>  static const struct platform_suspend_ops psci_suspend_ops = {
>         .valid          = suspend_valid_only_mem,
> +       .begin          = psci_system_suspend_begin,
>         .enter          = psci_system_suspend_enter,
>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
