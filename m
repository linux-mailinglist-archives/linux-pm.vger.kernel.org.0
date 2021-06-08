Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6939F987
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhFHOu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 10:50:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35263 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233505AbhFHOu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 10:50:58 -0400
Received: (qmail 1806040 invoked by uid 1000); 8 Jun 2021 10:49:05 -0400
Date:   Tue, 8 Jun 2021 10:49:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PM: runtime: Clarify documentation when callbacks
 are unassigned
Message-ID: <20210608144905.GE1804083@rowland.harvard.edu>
References: <20210608090250.85256-1-ulf.hansson@linaro.org>
 <20210608090250.85256-4-ulf.hansson@linaro.org>
 <20210608142325.GC1804083@rowland.harvard.edu>
 <CAPDyKFrwP+w4grUEHQb6B4gTBMoDPx+nEt8hJEnkM3prZuYfPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrwP+w4grUEHQb6B4gTBMoDPx+nEt8hJEnkM3prZuYfPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 08, 2021 at 04:30:48PM +0200, Ulf Hansson wrote:
> On Tue, 8 Jun 2021 at 16:23, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, Jun 08, 2021 at 11:02:50AM +0200, Ulf Hansson wrote:
> > > Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
> > > be unassigned.
> > >
> > > In the earlier behaviour the PM core would return -ENOSYS, when trying to
> > > runtime resume a device, for example. Let's update the documentation to
> > > clarify this.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >       - Added a new patch for the updating the docs, as pointed out by Alan.
> > >
> > > ---
> > >  Documentation/power/runtime_pm.rst | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> > > index 18ae21bf7f92..3d09c9fd450d 100644
> > > --- a/Documentation/power/runtime_pm.rst
> > > +++ b/Documentation/power/runtime_pm.rst
> > > @@ -827,6 +827,14 @@ or driver about runtime power changes.  Instead, the driver for the device's
> > >  parent must take responsibility for telling the device's driver when the
> > >  parent's power state changes.
> > >
> > > +Note that, in some cases it may not be desirable for subsystems/drivers to call

More than 80 chars.

> > > +pm_runtime_no_callbacks() for their devices. This could be because a subset of

More than 80 chars.

> > > +the runtime PM callbacks needs to be implemented, a platform dependent PM
> > > +domain could get attached to the device or that the device is power manged

s/manged/managed/

> > > +through a supplier device link. For these reasons and to avoid boilerplate code

More than 80 chars.

> > > +in subsystems/drivers, the PM core allows runtime PM callbacks to be
> > > +unassigned.
> > > +
> >
> > You should also mention that if a callback pointer is NULL, the
> > runtime PM core will act as though there was a callback and it
> > returned 0.  That's an important consideration.
> 
> Good point, let me add it.
> 
> I send a new version of $subject patch, unless Rafael is happy to do
> the amending when/if applying?
> 
> >
> > Also, notice that this file was carefully edited to make sure that
> > none of the lines exceed 80 characters.  Your new addition should
> > be the same.
> 
> Absolutely, but it should be okay already, no?

See above.

Alan
