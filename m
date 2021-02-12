Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC78131A2FF
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 17:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhBLQnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 11:43:02 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38307 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBLQmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 11:42:23 -0500
Received: by mail-wm1-f48.google.com with SMTP id x4so177410wmi.3;
        Fri, 12 Feb 2021 08:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qe/FoGB3XlHR5SsZoPBQ4OwjCkV7AUBZCJxKjMOTfb8=;
        b=lt3v87cE8T3AGqhgyw28RKpFvc2bd8Gzq3TFsg1CaZNycOR6yoh/jsmAlq8HneaSMl
         ty4Vrl95Ygq6Yia2OIBVWAdQiPXNql2BQjYspbADQulJSFNMR5qWk6mBJOABKw0wZuSf
         bnQAZuB5IW2MtikvvtLI4cKToRWwjEO1JKvBNuOduurwd5pgrqXGfNeoebq78FtMMFAn
         fWXQZSAyzj+GmgZgSXlkUVpWHOPRxS37zH8C3/ALiKZlr0js2yDqjo2FGGVomt8ua6UP
         +9UolMt0Eme3TeuWfDxEk1eXb0TCJ5JkTPK/FPlgWdC71VbIZg8G+Ba4mWYW/whex/+B
         fqlw==
X-Gm-Message-State: AOAM531kekIqd0S6IftgMq42xn+0MQAVigySLFf2mT69RmctFJ7KiPe9
        XQlnZhOqVyxeK+Gy/HO6uvg=
X-Google-Smtp-Source: ABdhPJy1EwxBbvXpZvBJphcaVysg5nmtEDCb+FuNZjNuB5G7WhTqlXWEoTJH4+e6FhadvYAsALozhg==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr3480718wmb.53.1613148100192;
        Fri, 12 Feb 2021 08:41:40 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f17sm10790980wrx.57.2021.02.12.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 08:41:39 -0800 (PST)
Date:   Fri, 12 Feb 2021 17:41:37 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: cpuidle: exynos: include header in file
 pattern
Message-ID: <20210212164137.rlp5sockb5ms7de2@kozik-lap>
References: <20210210172208.335048-1-krzk@kernel.org>
 <CAJZ5v0jnb__EpZxMSSk5Aop3+=FXXt5+0jNfTy9G1ac4s+xTaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jnb__EpZxMSSk5Aop3+=FXXt5+0jNfTy9G1ac4s+xTaQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 12, 2021 at 04:56:53PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 10, 2021 at 6:23 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Inclue the platform data header in Exynos cpuidle maintainer entry.
> >
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 674f42375acf..68e2b4cb4788 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4625,6 +4625,7 @@ L:        linux-samsung-soc@vger.kernel.org
> >  S:     Supported
> >  F:     arch/arm/mach-exynos/pm.c
> >  F:     drivers/cpuidle/cpuidle-exynos.c
> > +F:     include/linux/platform_data/cpuidle-exynos.h
> >
> >  CPUIDLE DRIVER - ARM PSCI
> >  M:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > --
> 
> Do you want me to apply this?

Hi Rafael,

Yes, please apply it.

Best regards,
Krzysztof

