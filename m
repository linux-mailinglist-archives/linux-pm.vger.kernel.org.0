Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5979C1932A4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 22:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCYV2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 17:28:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44175 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYV2T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 17:28:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id v134so3548502oie.11;
        Wed, 25 Mar 2020 14:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMnQUhHsMUqkwZSy38drjBgyagt4hVHMEAtOg07ZQq8=;
        b=X3OOwSWwF9exeyEaukuWVnthtnuCWkdj/NhnzgeqrAmzkzlpU2fT/VytfClj4jEFGJ
         G5o4gBQdeEgLIC78xTNGk+ErRE3NP+lWB3eKoLn+VkXHURccNbfl2IDQooDC0N2FqxpP
         1rSlrh4Lfm6leOlBEFzcsfCAw1tbbHxp731gtzTNtDy02Owu+V9KHo1qO7+HnfTeIrb+
         jF8ouIms+DFnG0IazntOwmamZ+brj1YNWbwLkf1X6oRBRU0OMbDQ5r25hjyWp/LbPxQk
         K1D7JZg1/HWdNehhcl35Poa+DQfvSFhSXkg3mqICk3/nxMCSvt6eki071DUhP8sx2BYE
         kAfQ==
X-Gm-Message-State: ANhLgQ1pUVY2M0FtB2Yw1Dhc97q49m1Z29krYAT8gHNAYsSASS5uAPUW
        Sl3yUdcc7Ae7hb0le3d1rzRpVC7rBVQSt94Tcds=
X-Google-Smtp-Source: ADFU+vvzKkZOnTfMVU8Sfwv/GSImVsJgGRvYaaTVayXvuwf+AsGAEnB58orlXTBPHO173efwnlO+Y+mX9i6UdjFRaiI=
X-Received: by 2002:aca:f07:: with SMTP id 7mr2269427oip.68.1585171698442;
 Wed, 25 Mar 2020 14:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200325150017.xhabucfo3v6i234o@e107158-lin> <Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Mar 2020 22:28:06 +0100
Message-ID: <CAJZ5v0gqNnoT41=Vm7AtbH8PMW+qPGighK7Up3q2rS+B0jBKFg@mail.gmail.com>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 9:49 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 25 Mar 2020, Qais Yousef wrote:
>
> > Thanks for all the hints Alan.
> >
> > I think I figured it out, the below patch seems to fix it for me. Looking
> > at other drivers resume functions it seems we're missing the
> > pm_runtime_disable()->set_active()->enable() dance. Doing that fixes the
> > warning and the dev_err() in driver/base/power.
>
> Ah, yes.  This should have been added years ago; guess I forgot.  :-(
>
> > I don't see xhci-plat.c doing that, I wonder if it needs it too.
> >
> > I'm not well versed about the details and the rules here. So my fix could be
> > a hack, though it does seem the right thing to do.
> >
> > I wonder why the power core doesn't handle this transparently..
>
> Initially, we didn't want the PM core to do this automatically because
> we thought some devices might want to remain runtime-suspended
> following a system resume, and only the device driver would know what
> to do.
>
> Raphael, now that we have the direct_complete mechanism, can we revisit
> this?  Should the PM core automatically call pm_runtime_set_active() if
> dev->power.direct_complete isn't set?  Perhaps in device_resume_early()
> prior to the pm_runtime_enable() call?
>
> It's possible we discussed this and decided against it at the time when
> direct_complete was added, but if so I don't remember what was said.

Me neither. :-)

That said complexity has grown since then and there are the
DPM_FLAG_SMART_SUSPEND and DPM_FLAG_LEAVE_SUSPENDED flags that can be
used to control that behavior to some extent.

Setting DPM_FLAG_SMART_SUSPEND alone, in particular, causes
pm_runtime_set_active() to be called at the noirq stage of device
resume either by the core or by bus types (e.g. PCI) etc.

It looks like ohci-platform might use DPM_FLAG_SMART_SUSPEND, but I
need to take a closer look at that (possibly later this week).

Cheers!


>
> > diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> > index 7addfc2cbadc..eb92c8092fae 100644
> > --- a/drivers/usb/host/ohci-platform.c
> > +++ b/drivers/usb/host/ohci-platform.c
> > @@ -299,6 +299,10 @@ static int ohci_platform_resume(struct device *dev)
> >         }
> >
> >         ohci_resume(hcd, false);
> > +
> > +       pm_runtime_disable(dev);
> > +       pm_runtime_set_active(dev);
> > +       pm_runtime_enable(dev);
> >         return 0;
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> >
> >
> > Thanks
> >
> > --
> > Qais Yousef
>
>
