Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94563A1085
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhFIJrk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 05:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhFIJrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 05:47:39 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55713C06175F
        for <linux-pm@vger.kernel.org>; Wed,  9 Jun 2021 02:45:44 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q2so5114504vsr.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDVcIBWGDWM1PdDfQAVglfmSkwPbg11fBeIYPrXJ/UE=;
        b=FhEYZOKJhzxspT2d9TFZAKGjjqIfVENB2iSfH/Fwt0o+FXReR7ZOUSms9DEaWnu8rV
         o5e7KPr5YKzzz7KJvHHf5CLRevXm63ElLQDxbJd34au9Bu7aOD9lSrqngzz4Hx1dWCbf
         YNe25SFeIfKi6D/DBjDlm3WIa9Le0iwzjFLgmOw5XF3OUp+kkEE0+vHSn3F4OPTtY5+5
         TlqgfrUEjQjegaHPx8FKW0NRVi+fIl23yxILbGiDjKJJ6y2H5rK055h6FhyR/AaTg88s
         OmEZyXdPtB5DzQ5A1kFBxEl7le8MVMA7AJ7gLHhCsO/e1/B4AIOj3TfPc9141Inc8LrF
         sGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDVcIBWGDWM1PdDfQAVglfmSkwPbg11fBeIYPrXJ/UE=;
        b=MKmVRyA5oLpKnDLHW5irWT/snujdQtDL9XxKJmLZfzoJixcfTcjwSzDtIAYrZ2zLaL
         fGQKeg1nGxLT7Wc42sYKMe0Df6y2Pd7IGwCZ/coGAXIN8N+dRhqfjsN+poHbJCR77ZsW
         Ajin8S6VJ7avAzeC1GSAoALb2gh4KjahYjMKoWRGK2K5Iw6JlxmFETZEBG85ZrYg6Sde
         rdoYxJzdNDfGbEwbBalpPlPo03kpmO8JeiON3tSVVHk3O6dUB6Cuu+mfv3YeT6YU9bSx
         0Hfnqx529+0aJQYHzxj+SQYJhQn60S9GDdWznuR/kRLMHI7//qRKIs4WysTT9W6tZMKg
         xM7A==
X-Gm-Message-State: AOAM532ojUPQFWppqnYgZLrFLIIrdu49W4LRAY3pujqY4m6j3y5aCtlr
        O1fN7ZqjXd5iebBABqrmdMFtxT1wh+bU0vrdpEd0kg==
X-Google-Smtp-Source: ABdhPJyG6uoIvr6Vzcz/k06+wX6BQNTTQd+f+J8E9FZbeuZhjBmXHmBVipMAQXUix9BZvEKgyotFjFETrSsQplAdAoA=
X-Received: by 2002:a67:e359:: with SMTP id s25mr3271454vsm.55.1623231943491;
 Wed, 09 Jun 2021 02:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
 <20210608090250.85256-4-ulf.hansson@linaro.org> <20210608142325.GC1804083@rowland.harvard.edu>
 <CAPDyKFrwP+w4grUEHQb6B4gTBMoDPx+nEt8hJEnkM3prZuYfPQ@mail.gmail.com> <20210608144905.GE1804083@rowland.harvard.edu>
In-Reply-To: <20210608144905.GE1804083@rowland.harvard.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Jun 2021 11:45:07 +0200
Message-ID: <CAPDyKFrrwAgm+=X5ra_f+Ln9eX6phj=YPd5sFdEyyLR3JdV4vg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PM: runtime: Clarify documentation when callbacks
 are unassigned
To:     Alan Stern <stern@rowland.harvard.edu>
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

On Tue, 8 Jun 2021 at 16:49, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, Jun 08, 2021 at 04:30:48PM +0200, Ulf Hansson wrote:
> > On Tue, 8 Jun 2021 at 16:23, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Tue, Jun 08, 2021 at 11:02:50AM +0200, Ulf Hansson wrote:
> > > > Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
> > > > be unassigned.
> > > >
> > > > In the earlier behaviour the PM core would return -ENOSYS, when trying to
> > > > runtime resume a device, for example. Let's update the documentation to
> > > > clarify this.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >       - Added a new patch for the updating the docs, as pointed out by Alan.
> > > >
> > > > ---
> > > >  Documentation/power/runtime_pm.rst | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > > > index 18ae21bf7f92..3d09c9fd450d 100644
> > > > --- a/Documentation/power/runtime_pm.rst
> > > > +++ b/Documentation/power/runtime_pm.rst
> > > > @@ -827,6 +827,14 @@ or driver about runtime power changes.  Instead, the driver for the device's
> > > >  parent must take responsibility for telling the device's driver when the
> > > >  parent's power state changes.
> > > >
> > > > +Note that, in some cases it may not be desirable for subsystems/drivers to call
>
> More than 80 chars.

Perhaps it's the email client that messes up the patch in some way.
This above line in the patch is 79 chars.

If you have a look at the patch in patchwork [1], you should see (I
hope) that it respects the 80 chars per line!?

>
> > > > +pm_runtime_no_callbacks() for their devices. This could be because a subset of
>
> More than 80 chars.
>
> > > > +the runtime PM callbacks needs to be implemented, a platform dependent PM
> > > > +domain could get attached to the device or that the device is power manged
>
> s/manged/managed/

Thanks for spotting this, my spell checker accepted "manged". :-)

>
> > > > +through a supplier device link. For these reasons and to avoid boilerplate code
>
> More than 80 chars.
>
> > > > +in subsystems/drivers, the PM core allows runtime PM callbacks to be
> > > > +unassigned.
> > > > +
> > >
> > > You should also mention that if a callback pointer is NULL, the
> > > runtime PM core will act as though there was a callback and it
> > > returned 0.  That's an important consideration.
> >
> > Good point, let me add it.
> >
> > I send a new version of $subject patch, unless Rafael is happy to do
> > the amending when/if applying?
> >
> > >
> > > Also, notice that this file was carefully edited to make sure that
> > > none of the lines exceed 80 characters.  Your new addition should
> > > be the same.
> >
> > Absolutely, but it should be okay already, no?
>
> See above.
>
> Alan

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-pm/patch/20210608090250.85256-4-ulf.hansson@linaro.org/
