Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2E3A476F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFKRIF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 13:08:05 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:38871 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhFKRIF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 13:08:05 -0400
Received: by mail-oi1-f169.google.com with SMTP id q10so2228306oij.5;
        Fri, 11 Jun 2021 10:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXP2I4ApuWB5HpBIMgQb1QiH7C1vfyiKYMTo3USWuuU=;
        b=hNgPx8wSocmbBfFlOpCkftShUbrUBZv8lsiWS8tP2Ou48Mb/wGXOX/1OjyW4frcqqb
         jHdYb3PPCKvDKGRxba3uQkJI2UiCf/p08uNvxkP1Yvfuio6yWp0FzZZiY+fNPDkW3aKV
         ddOTKunXEsWNFRCvUZhVw7HoYi/aZUZj6mswnS5bsXPKekdv+cJS6617oRiJcsjwS88E
         yZuSTzxLij5a8wveTGo+5u7WJyZ3sIErH6rwoPCWiAVJXhL1o0Rqdhtd3Rq26ey9V+7v
         dwOfKExzfyBLxE3OPk5gopIjtHnuOiDaskxYmXiUfaIJYo+iHzTWVzvI1sijqlrlsKgU
         ufkg==
X-Gm-Message-State: AOAM533aO+O+llMeCVogk/oR3O2lvIppRsC9nZ5/0QivkU8wz1Z/mJGM
        fXzgcerhJRRBpqEE9DfWut/f117/UU2/kxQIQvzWRoBP
X-Google-Smtp-Source: ABdhPJzRF9YDfJw1Ds2/HmqLY1bYqvhDDai3/DGOsGM+1GqpiViH7ZIwA3tPPZj8eT/rPGMfzdbpbq4c2+q6UIa5/ho=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr999950oia.157.1623431150205;
 Fri, 11 Jun 2021 10:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210609100610.97830-1-ulf.hansson@linaro.org> <20210609141623.GA1842836@rowland.harvard.edu>
In-Reply-To: <20210609141623.GA1842836@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 19:05:39 +0200
Message-ID: <CAJZ5v0j30rEvGhWm7YgLPcMe53r9gyi3wrw+j+0Lm6T1p2t6Yg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PM: runtime: Clarify documentation when callbacks
 are unassigned
To:     Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 9, 2021 at 4:16 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Jun 09, 2021 at 12:06:10PM +0200, Ulf Hansson wrote:
> > Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
> > be unassigned.
> >
> > In the earlier behaviour the PM core would return -ENOSYS, when trying to
> > runtime resume a device, for example. Let's update the documentation to
> > clarify this.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v4:
> >         - This time, really, fix spelling and further clarified the behaviour,
> >       according to comments from Alan.
> >
> > ---
> >  Documentation/power/runtime_pm.rst | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > index 18ae21bf7f92..8a0a43811e3a 100644
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -827,6 +827,15 @@ or driver about runtime power changes.  Instead, the driver for the device's
> >  parent must take responsibility for telling the device's driver when the
> >  parent's power state changes.
> >
> > +Note that, in some cases it may not be desirable for subsystems/drivers to call
> > +pm_runtime_no_callbacks() for their devices. This could be because a subset of
> > +the runtime PM callbacks needs to be implemented, a platform dependent PM
> > +domain could get attached to the device or that the device is power managed
> > +through a supplier device link. For these reasons and to avoid boilerplate code
> > +in subsystems/drivers, the PM core allows runtime PM callbacks to be
> > +unassigned. More precisely, if a callback pointer is NULL, the PM core will act
> > +as though there was a callback and it returned 0.
> > +
> >  9. Autosuspend, or automatically-delayed suspends
> >  =================================================
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Applied as 5.14 material along with the [1-2/3] from this series.

Thanks!
