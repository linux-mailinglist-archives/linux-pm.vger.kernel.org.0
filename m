Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07C4276CCE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgIXJH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgIXJH1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 05:07:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F4CC0613CE
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 02:07:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a16so1653004vsp.12
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/X7t9uVIEd+S4xSIbror7zIP86C/H0V5Buw9Pzp4CZQ=;
        b=IZ3+kGRz+xW/GPCA5Ct34Vn6POsjNIyMIC2BJf25muLLT1VW+fy9hPEApxK+ov//uW
         lLPpwShllPTEp/t+51PPukiPuRNiI0MDzcQl9B5wEVqspVLEfA2x4mF9h5q27fLuEUr/
         JPggxVugLZuzBZU8rXEkSz3pCfWLGnXKaCKemSygdQszB7ZDsqY7Q1tY2B/KT58is8md
         N54rjXlWGNRw91+Vg3aIe6mBpgkmmi8Ox5krSuqAi7HS5+rvaXqMwZcjIbqu0pyzKttP
         Jv+fGUe/vOzCvjTenc0Yrfy9e2wDyh+UNoY/eQidXc7wHzv2po4QmFV7TUkKrBAmC2Ht
         BQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/X7t9uVIEd+S4xSIbror7zIP86C/H0V5Buw9Pzp4CZQ=;
        b=mQqo5NgMwBMNOro0nbGwxzyexnNLSIO/gE0cct3AkZ8qC2i8mQAubWOYRrUbS0eBML
         qszq83zKHutFeXe3MPv9kAZpBx4fLrLa4sYnUrGu9mheT9MCoU0+s5/QY8rRLzjHbQ2e
         QOAgzDrHNw/wxYYVFwzPojUi7Zoh+D5UIsv8ZiYKp4FYtw7/eghF4iSaumTVCCyBNd1G
         iMA/Xc8vJgxiNBL2HEYkdbizYDD2aVDmOojQ8104ZV4QAG/NTVUqiPQ1yXcL5Gju5MFY
         gJnOAxNqkSbAfaeNrBSR+OHE/EvciObF591H2L/bBKJ9yqu5c0XevKjwWoTAkxrwRmcN
         2zmw==
X-Gm-Message-State: AOAM530qJjJGDjDZ9C/nkGVCF9euWN0TDBk2L8EuH0B0LH1laaloBqLh
        QE1wGNSdZSSgueX5zltkRIuIMX3bLX+TAOom3dz6Pw==
X-Google-Smtp-Source: ABdhPJyos8gdOhVSu8Yw+Ta+UgVcQV1l8SNxPLoifsBHaUuGMdJ2eI8bSRsCAI4Ru+05RrslWyoUN9AQu0Xj/PPLRLc=
X-Received: by 2002:a67:3009:: with SMTP id w9mr3249705vsw.19.1600938446195;
 Thu, 24 Sep 2020 02:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201633.27017-1-khilman@baylibre.com> <CAJZ5v0gzk_h09kJnWnagAL3E7TVmCqFO2E52Dewwyj6NRgKd=w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gzk_h09kJnWnagAL3E7TVmCqFO2E52Dewwyj6NRgKd=w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 11:06:50 +0200
Message-ID: <CAPDyKFqR6WTt1_p8jTkZVvvBvAGF2ROChfYLvnW8Mu0KUFvhFA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop myself from PM AVS drivers
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 22 Sep 2020 at 20:10, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 18, 2020 at 10:16 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > I haven't had the time or the expertise to adequately review and
> > maintain these drivers for awhile, so make it official.
>
> Well, fair enough, so applied as 5.10 material.
>
> But this means that I'm going to stop picking up AVS drivers changes myself.
>
> I'll be expecting someone to step in and become a proper maintainer of
> them and send pull requests either to me or to arm-soc.

How about if we instead move these avs drivers to drivers/soc/* instead?

There are currently only three avs drivers, they are SoC specific and
we already have kind of similar drivers in drivers/soc/*.

I can take care of the move, to release you from the burden. :-)

Kind regards
Uffe

>
> Cheers!
>
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index deaafb617361..f1bf6071c438 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5361,7 +5361,6 @@ F:        include/linux/kobj*
> >  F:     lib/kobj*
> >
> >  DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
> > -M:     Kevin Hilman <khilman@kernel.org>
> >  M:     Nishanth Menon <nm@ti.com>
> >  L:     linux-pm@vger.kernel.org
> >  S:     Maintained
> > --
> > 2.28.0
> >
