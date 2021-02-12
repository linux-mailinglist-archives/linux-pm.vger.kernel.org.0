Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF931A357
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhBLRKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 12:10:49 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36706 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLRKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 12:10:46 -0500
Received: by mail-oi1-f170.google.com with SMTP id k204so361691oih.3;
        Fri, 12 Feb 2021 09:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WN0jbkLk3SPhp8fvRev1igQayRB9Wh4C/ZZUoZf1Amo=;
        b=loAYEeb4alxKd1UUE4fhKLzCY3Ql4/ar2aZ3oxzwG/zklByGumy2w8hDIG9Qas/P2O
         d0YlGTzk1SqFpb18eZ39U4OKtUcaVvmDjvEBPvo8+Mu6G/3HSES5R0Ce2SXf1vMoYoRI
         vtnsea7LTW5IGs+uzJ9HSEUrppT5quiRPjeGkWwYuxo2iITukeurVaJlOd4vvn/XRkJi
         d7NWaU7TUspV8zBQnsG1fRfo5VMJbrliI0ndj+b2j353PhoPgOztPSQzdH3DJWXtn1lR
         XcRX4nhcEcEpvuaOxVAmjfVx/6GcDCV0MMfUTHST33bIPmnJQeF/ofKzGsv5g+KY5Ou1
         jg6g==
X-Gm-Message-State: AOAM530ELs9Gs3yWrsDD6WJrW2pfN7eeryXchcxndGeR0SC+2w5oqNfu
        OSgBh9wCl2uO6JDcYKOuejwqD/DqJ3uSqIBY2fM=
X-Google-Smtp-Source: ABdhPJxIG42jg6ZsgvzQmWgA00fp0tcfxrvxjx/WCL0yyRVB76VWuMdr2Jh03OL7MuKkatK9JPUAVWjKxIP3ZixYce8=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr249654oia.157.1613149805409;
 Fri, 12 Feb 2021 09:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20210210172208.335048-1-krzk@kernel.org> <CAJZ5v0jnb__EpZxMSSk5Aop3+=FXXt5+0jNfTy9G1ac4s+xTaQ@mail.gmail.com>
 <20210212164137.rlp5sockb5ms7de2@kozik-lap>
In-Reply-To: <20210212164137.rlp5sockb5ms7de2@kozik-lap>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 18:09:54 +0100
Message-ID: <CAJZ5v0ha4gNWrunP_GSsCRf5R-tVQssX9ZudYvPmWvv51_PSFA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: cpuidle: exynos: include header in file pattern
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 12, 2021 at 5:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, Feb 12, 2021 at 04:56:53PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 10, 2021 at 6:23 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Inclue the platform data header in Exynos cpuidle maintainer entry.
> > >
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 674f42375acf..68e2b4cb4788 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4625,6 +4625,7 @@ L:        linux-samsung-soc@vger.kernel.org
> > >  S:     Supported
> > >  F:     arch/arm/mach-exynos/pm.c
> > >  F:     drivers/cpuidle/cpuidle-exynos.c
> > > +F:     include/linux/platform_data/cpuidle-exynos.h
> > >
> > >  CPUIDLE DRIVER - ARM PSCI
> > >  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > --
> >
> > Do you want me to apply this?
>
> Hi Rafael,
>
> Yes, please apply it.

Done, thanks!
