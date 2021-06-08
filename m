Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3770539F93D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhFHOen (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 10:34:43 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:47069 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhFHOeS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 10:34:18 -0400
Received: by mail-vs1-f43.google.com with SMTP id z15so10951923vsn.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VI+ydfy/u7Hc+OyFXerfas5ak2PFT+K1vwTyprk1Pso=;
        b=O6THkIcKaWOy8b1lgfXxxsbLulInwDMLRycxIcbjCFpkRze3OWx66dAw4/wHb8Poo4
         eoyfagM2icPtsmMp5Ywh2BMtyeHosAe0+QdbJug6+TitlwYm6oKTXDzFzFRTgBEC8FzE
         mOXW4AJWASSvsKzR5TEGxSf1DUSXn9h3F7dk32luNOQf6MAzMXzuy+PwDixD1M1smLRi
         AU+sRbDn5uNyjlBmsRruPlwKmFUHSPhiYq3KPiPSZBcPiPvtUH48pVGwWPmULuX72cqc
         0O8nkFp5D6/IYPmHnKqgUq1WqnYtfBMQNooZgaGNWmKxR48xqcKgs6aixSxrD8R8+Q0E
         A4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VI+ydfy/u7Hc+OyFXerfas5ak2PFT+K1vwTyprk1Pso=;
        b=moGlgeUwhAdHwfBhlbz0YLWaz/BcHSzc0FBTXQQ+bq/E0CAtjMKnS4Meu8cpOk/h6g
         Z7VKSdGyUamWcwAYqJtGkclt3rSnzhkizBxpwTabrWZr4+Q55t409BxNBxc6fK0O0ckS
         FTDT8+w51TUlPRKYFTh73oyXVmr6YtXnq+cDv8pr3eKkiHOE3nVjySJdwBHgIH4ScEHE
         lkfCriOll0fLL+Zg/h1YsCC1vyj2mmBsY/HpK3g3FrBhuDRH3HqfsHjSGFsREsoOa+0O
         CSe6lgo1KN+4rfoWVmoSMtgnq33rdQ7+lSC8Wm/n/ldwc1W+3c5mQNeLx/EyUvbzQ3NX
         ENPQ==
X-Gm-Message-State: AOAM531xmbLo6rz4++Q07QiakmTnH0hhmXnfgwXJuqV6ZRpBxHXfvxIS
        Mjz5eY0e2vmsWT1gKc9oOeMBlWtndnSjzlpD/Rhp+w==
X-Google-Smtp-Source: ABdhPJxKrf0a0W96o+w9LBtIlMJohpxQJhl8D17nfc35dy8kdU1RDbbo0i+BJnWSIXJggFphuqMvdJE/n7o8guGgro4=
X-Received: by 2002:a05:6102:d1:: with SMTP id u17mr377149vsp.48.1623162684633;
 Tue, 08 Jun 2021 07:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
 <20210608090250.85256-4-ulf.hansson@linaro.org> <20210608142325.GC1804083@rowland.harvard.edu>
In-Reply-To: <20210608142325.GC1804083@rowland.harvard.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 16:30:48 +0200
Message-ID: <CAPDyKFrwP+w4grUEHQb6B4gTBMoDPx+nEt8hJEnkM3prZuYfPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PM: runtime: Clarify documentation when callbacks
 are unassigned
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
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

On Tue, 8 Jun 2021 at 16:23, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, Jun 08, 2021 at 11:02:50AM +0200, Ulf Hansson wrote:
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
> > Changes in v2:
> >       - Added a new patch for the updating the docs, as pointed out by Alan.
> >
> > ---
> >  Documentation/power/runtime_pm.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > index 18ae21bf7f92..3d09c9fd450d 100644
> > --- a/Documentation/power/runtime_pm.rst
> > +++ b/Documentation/power/runtime_pm.rst
> > @@ -827,6 +827,14 @@ or driver about runtime power changes.  Instead, the driver for the device's
> >  parent must take responsibility for telling the device's driver when the
> >  parent's power state changes.
> >
> > +Note that, in some cases it may not be desirable for subsystems/drivers to call
> > +pm_runtime_no_callbacks() for their devices. This could be because a subset of
> > +the runtime PM callbacks needs to be implemented, a platform dependent PM
> > +domain could get attached to the device or that the device is power manged
> > +through a supplier device link. For these reasons and to avoid boilerplate code
> > +in subsystems/drivers, the PM core allows runtime PM callbacks to be
> > +unassigned.
> > +
>
> You should also mention that if a callback pointer is NULL, the
> runtime PM core will act as though there was a callback and it
> returned 0.  That's an important consideration.

Good point, let me add it.

I send a new version of $subject patch, unless Rafael is happy to do
the amending when/if applying?

>
> Also, notice that this file was carefully edited to make sure that
> none of the lines exceed 80 characters.  Your new addition should
> be the same.

Absolutely, but it should be okay already, no?

>
> Alan Stern

Kind regards
Uffe
