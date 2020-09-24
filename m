Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B07276E93
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgIXKWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 06:22:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33643 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKWA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 06:22:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id m7so3153881oie.0;
        Thu, 24 Sep 2020 03:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zpAvY0vr3Ak8ufELOux4AWgn5ac7UgZxPu4XSHprpM=;
        b=Uq6wj7wYAUJ+PbOxXQ7kePc8zIEvpMG0ilz1n1Cbdq97HwR4VLsobqkYFPyEmOT9vR
         FlFzA1x0n6YXr7sRy08iYSbRzMEsm2PPlRWjgZnb3Gu6MWc3G9uF/g59E5KBCDsCUZCq
         hxomwpVfUnlJhq+b3vf36vDwHw2oITiet43djDejolrb5c3N2gIPL2DGXRS0vWFgj9M/
         gyfITCoDZZ3GH2zvw9NRBoUKEbkzpjC7Egk1hGSnuKMM+9fqpwcUF2Rtba9mMLLPVHuX
         KzBHXzIyLkWbO7vy1n24Ei5CY0Y8bOYAiaMr+gvTkrggkF9aMB9Sbyg79/e0FWcwqqfT
         6mlw==
X-Gm-Message-State: AOAM531S8oPF2xKUEKAqQxQ33ff5AG0g7NbKF4hPzB4eV7T6C4If7lhO
        ISrwBp2uj+m+IbDKJSfxoNQD9gY9A95GI+Wc+bU=
X-Google-Smtp-Source: ABdhPJwve9pMkXku1eh6WMAk7iSLC2cB3udEJlkHhsJ/lDC3OXBSL1vy47XzcCJyZY79SoV/r5JeZheA2UdaP0RnRxw=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr2134211oid.110.1600942919368;
 Thu, 24 Sep 2020 03:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201633.27017-1-khilman@baylibre.com> <CAJZ5v0gzk_h09kJnWnagAL3E7TVmCqFO2E52Dewwyj6NRgKd=w@mail.gmail.com>
 <CAPDyKFqR6WTt1_p8jTkZVvvBvAGF2ROChfYLvnW8Mu0KUFvhFA@mail.gmail.com>
In-Reply-To: <CAPDyKFqR6WTt1_p8jTkZVvvBvAGF2ROChfYLvnW8Mu0KUFvhFA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Sep 2020 12:21:48 +0200
Message-ID: <CAJZ5v0ibhi=5U+cbQNBKjWL7Gt21dg7ZTBXGknEo6A-wmzF5PQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop myself from PM AVS drivers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 24, 2020 at 11:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 22 Sep 2020 at 20:10, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Sep 18, 2020 at 10:16 PM Kevin Hilman <khilman@baylibre.com> wrote:
> > >
> > > I haven't had the time or the expertise to adequately review and
> > > maintain these drivers for awhile, so make it official.
> >
> > Well, fair enough, so applied as 5.10 material.
> >
> > But this means that I'm going to stop picking up AVS drivers changes myself.
> >
> > I'll be expecting someone to step in and become a proper maintainer of
> > them and send pull requests either to me or to arm-soc.
>
> How about if we instead move these avs drivers to drivers/soc/* instead?
>
> There are currently only three avs drivers, they are SoC specific and
> we already have kind of similar drivers in drivers/soc/*.
>
> I can take care of the move, to release you from the burden. :-)

That would work for me.

Cheers!
