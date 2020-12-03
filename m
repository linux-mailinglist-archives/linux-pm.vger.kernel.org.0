Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA682CDEAB
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 20:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgLCTU3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 14:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgLCTU2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 14:20:28 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D242C061A51
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 11:19:48 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id x2so3045473ybt.11
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUYfB3LhbOXH/qWX5ow3QLdCqkjf8YNWyBuEVSInt6w=;
        b=tAd4JdpSkRPjjrscn5ThUbDcRYUSaRgmc8LmMW8HU7IePg47OQhCVJdawgzjaN7syv
         e3N3DviCmLqpIzkG8sO9XhRF7Xf5itcYmV+qZhq7FZqrC0InNtmGC17CoIJH1Wfphncr
         Rg3+TeoBuBit3SqGgU3LvdQFbIl4Hfvd3BljTLXwQyaI0Nmmgvg8oNhs51a3TPi3/ykN
         3T79WmLyPDK6zN22VMLIOPq8xzaeDsW3ln56eq9MCq3v+uSGTB7yi3dNZ01zx+siGqKN
         vaiTRladSGMR+rgnYUqa2sd69sMLzM0Csre6QiBaviz0vCyosEHEY5UGK4etRXSK2MqN
         PnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUYfB3LhbOXH/qWX5ow3QLdCqkjf8YNWyBuEVSInt6w=;
        b=IAWyIGGRDsj0O3xPjXM81PRiYBQz8Rb4u4bj7SipDZg+q96w0k+2XdosH1ZpZYurT7
         EjjRrxkZYUkxn3bfl6kFoawxuKYwNugoRSj+pXG56RwN6oxjZZE06ZD5QIKlihw7R7lL
         u66FLp7bglcvyFcOPmqMCL3Rwq/bl++frFkUkXY72k37VzSP25hqBWHmrBKSXGO8qMf3
         WFWWDpJnanpLx0rf0iod6F2wzNImKIvTsavLMN+oMXQNohD+1KKAbgwJTvD9828lSZ9O
         L+VpHUkK+VcJvFUXrjmO2Pt+uKfjKtGRAlGFzMZcNXbgZOWJmMVOuDTrYyT7N/brt0yt
         BYVw==
X-Gm-Message-State: AOAM532Qx5PrO2MtHedBWS1pfUflWI7snNpqzMKHCAeT1hd/0Y6jhgjN
        tCBIgW2X/WxYEFjdRjzaUu7lBlTI73LmdchfnVWRNw==
X-Google-Smtp-Source: ABdhPJyhXbsmp80bw0icNNI9ciSn4KKgQYFLMDbMBvVHnJ7Dp8BN0RFUQsPErKCI3u7Ti+5A7pCXg92G1jadJjuVlVw=
X-Received: by 2002:a25:8401:: with SMTP id u1mr1068640ybk.96.1607023187549;
 Thu, 03 Dec 2020 11:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20201203175756.1405564-1-thierry.reding@gmail.com> <CAJZ5v0g_FC6Pikrvk2PK=XMvAwqjaNOcYXHYS6eqv6Zc0JgqNQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_FC6Pikrvk2PK=XMvAwqjaNOcYXHYS6eqv6Zc0JgqNQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 3 Dec 2020 11:19:11 -0800
Message-ID: <CAGETcx9wrKNfvV36v1YJLa_A8jtb6OvZRMjsNG9AYxLPDvdpgQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Reorder devices on successful probe
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 3, 2020 at 10:17 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 3, 2020 at 6:58 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Device drivers usually depend on the fact that the devices that they
> > control are suspended in the same order that they were probed in. In
> > most cases this is already guaranteed via deferred probe.
> >
> > However, there's one case where this can still break: if a device is
> > instantiated before a dependency (for example if it appears before the
> > dependency in device tree) but gets probed only after the dependency is
> > probed. Instantiation order would cause the dependency to get probed
> > later, in which case probe of the original device would be deferred and
> > the suspend/resume queue would get reordered properly. However, if the
> > dependency is provided by a built-in driver and the device depending on
> > that driver is controlled by a loadable module, which may only get
> > loaded after the root filesystem has become available, we can be faced
> > with a situation where the probe order ends up being different from the
> > suspend/resume order.
> >
> > One example where this happens is on Tegra186, where the ACONNECT is
> > listed very early in device tree (sorted by unit-address) and depends on
> > BPMP (listed very late because it has no unit-address) for power domains
> > and clocks/resets. If the ACONNECT driver is built-in, there is no
> > problem because it will be probed before BPMP, causing a probe deferral
> > and that in turn reorders the suspend/resume queue. However, if built as
> > a module, it will end up being probed after BPMP, and therefore not
> > result in a probe deferral, and therefore the suspend/resume queue will
> > stay in the instantiation order. This in turn causes problems because
> > ACONNECT will be resumed before BPMP, which will result in a hang
> > because the ACONNECT's power domain cannot be powered on as long as the
> > BPMP is still suspended.
> >
> > Fix this by always reordering devices on successful probe. This ensures
> > that the suspend/resume queue is always in probe order and hence meets
> > the natural expectations of drivers vs. their dependencies.
> >
> > Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>
> Saravana had submitted a very similar patch (I don't have a pointer to
> that one though) and I was against it at that time due to
> overhead-related concerns.  There still are some, but maybe that
> doesn't matter in practice.

Yeah, it's a very similar patch but I also suggested deleting the
reorder done in the deferred probe code (I'm pretty sure we can drop
it). Here's the thread:
https://lore.kernel.org/lkml/20200625032430.152447-1-saravanak@google.com/

Btw, I've been wondering about this recently. Do we even need
device_pm_move_to_tail() to do the recursive thing once we do "add
device to end of list when added" + "move probed devices to the end
after probe" thing here? Doesn't this guarantee that none of the
consumers can come before the supplier in the dpm list?

-Saravana

>
> Also, I kind of expect this to blow up somewhere, but since I have no
> examples ready from the top of my head, I think let's try and see, so:
>
> Acked-by: Rafael. J. Wysocki <rafael@kernel.org>
>
> > ---
> >  drivers/base/dd.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 148e81969e04..cfc079e738bb 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -370,6 +370,13 @@ static void driver_bound(struct device *dev)
> >
> >         device_pm_check_callbacks(dev);
> >
> > +       /*
> > +        * Reorder successfully probed devices to the end of the device list.
> > +        * This ensures that suspend/resume order matches probe order, which
> > +        * is usually what drivers rely on.
> > +        */
> > +       device_pm_move_to_tail(dev);
> > +
> >         /*
> >          * Make sure the device is no longer in one of the deferred lists and
> >          * kick off retrying all pending devices
> > --
> > 2.29.2
> >
