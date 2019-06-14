Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF2AA460F2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfFNOgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 10:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfFNOgk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 10:36:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3C42064A;
        Fri, 14 Jun 2019 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560522998;
        bh=LMq/Sb352anykVPMDvbfaZbQVk5PdaiQxrm+VWdoXPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXXdGL8qWGjsbWS38tMiiBeKXuvQtjJMM8YxL6EZvTVr7+IshxL8aWkak4YPBdy7I
         xlaNFx0B10KcjATD+ixICuTu95BuX7s0tiN4HUfFvGxKqOkjY91wsoRYYTne3DSpXa
         of+fGHu5khkS/PMYStOw53xAKyVZ/wybwY3YdyJE=
Date:   Fri, 14 Jun 2019 16:36:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring
 probe
Message-ID: <20190614143636.GB11550@kroah.com>
References: <20190613170011.9647-1-thierry.reding@gmail.com>
 <20190614091058.GA25912@kroah.com>
 <20190614093856.GC15526@ulmo>
 <CAJZ5v0jeH3x+kfAH9D5H6507-iBdVRhAfEKb-NOdhiutwR9O_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jeH3x+kfAH9D5H6507-iBdVRhAfEKb-NOdhiutwR9O_Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 14, 2019 at 12:10:10PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 14, 2019 at 11:39 AM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > On Fri, Jun 14, 2019 at 11:10:58AM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Jun 13, 2019 at 07:00:11PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> 
> [cut]
> 
> >
> > To avoid further back and forth, what exactly is it that you would have
> > me do? That is, what do you consider to be the correct way to do this?
> >
> > Would you prefer me to add another function with a different name that
> > reimplements the functionality only with the exception? Something along
> > the lines of:
> >
> >         int driver_deferred_probe_check_state_continue(struct device *dev)
> >         {
> >                 int ret;
> >
> >                 ret = driver_deferred_probe_check_state(dev);
> >                 if (ret == -ENODEV)
> >                         return -EPROBE_DEFER;
> >
> >                 return ret;
> >         }
> >
> > ? I'd need to split that up some more to avoid the warning that the
> > inner function prints before returning -ENODEV, but that's a minor
> > detail. Would that API be more to your liking?
> 
> Well, why don't you do
> 
> static int deferred_probe_check_state_internal(struct device *dev)
> {
>         if (!initcalls_done)
>                 return -EPROBE_DEFER;
> 
>         if (!deferred_probe_timeout) {
>                 dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                 return -ETIMEDOUT;
>         }
> 
>         return 0;
> }
> 
> int driver_deferred_probe_check_state(struct device *dev)
> {
>         int ret = deferred_probe_check_state_internal(dev);
> 
>         if (ret)
>                  return ret;
> 
>         dev_warn(dev, "ignoring dependency for device, assuming no driver");
>         return -ENODEV;
> }
> 
> int driver_deferred_probe_check_state_continue(struct device *dev)
> {
>         int ret = deferred_probe_check_state_internal(dev);
> 
>         if (ret)
>                  return ret;
> 
>         return -EPROBE_DEFER;
> }

Yes, that's much more sane.  Self-decribing apis are the key here, I did
not want a boolean flag, or any other flag, as part of the public api as
they do not describe what the call does at all.

thanks,

greg k-h
