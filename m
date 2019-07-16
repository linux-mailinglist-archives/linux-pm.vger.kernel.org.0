Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8F6A407
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfGPIjl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 04:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfGPIjl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 04:39:41 -0400
Received: from localhost (unknown [113.157.217.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F2321721;
        Tue, 16 Jul 2019 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563266380;
        bh=M/lqVVPiWZwgAYL4LGiADH8CqNdvW8sCBgca7ffnYDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ignF/XJSPof7phYqp5604uR5utOVu63j0eZlOTnf2OaptycLIcZ/w1bKjQnfvWS+S
         fD7YgyS78PNy2HYjl3JkK/oC3kGS/toRShRF9BMhp/Gmrt/hGIvSgzu1t+fxeJKKdr
         pXKcybiEIp6m+eJDgLi4xBTgBvti7ClNjZRNQ2vs=
Date:   Tue, 16 Jul 2019 17:39:26 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>, sspatil@google.com,
        kaleshsingh@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH v4] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190716083926.GA2505@kroah.com>
References: <20190715203651.GA7513@kroah.com>
 <20190715214348.81865-1-trong@android.com>
 <CAJZ5v0gEzZkbeLFtW5yadwxBryvL3vWcUoQTkUy3VkxiTV+UrA@mail.gmail.com>
 <20190716021102.GA8310@kroah.com>
 <CAJZ5v0hxKeK-eDEs1rGP0ZYbbCHa0q5=ZPMVCemYVHGL48Q=pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hxKeK-eDEs1rGP0ZYbbCHa0q5=ZPMVCemYVHGL48Q=pg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 10:30:48AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 16, 2019 at 4:13 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 15, 2019 at 11:48:27PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jul 15, 2019 at 11:44 PM Tri Vo <trong@android.com> wrote:
> > > >
> > > > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > > > blocking wakeup sources over device's boot cycle. This information can
> > > > then be used (1) for power-specific bug reporting and (2) towards
> > > > attributing battery consumption to specific processes over a period of
> > > > time.
> > > >
> > > > However, debugfs doesn't have stable ABI. For this reason, create a
> > > > 'struct device' to expose wakeup sources statistics in sysfs under
> > > > /sys/class/wakeup/<name>/.
> > > >
> > > > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > > > source statistics in sysfs.
> > >
> > > I'm not sure if this is really needed, but I'll let Greg decide.
> >
> > You are right.  Having zillions of config options is a pain, who is
> > going to turn this off?
> >
> > But we can always remove the option before 5.4-rc1, so I'll take this
> > as-is for now :)
> >
> > > Apart from this
> > >
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > thanks for the review!  I'll wait for 5.3-rc1 to come out before adding
> > this to my tree.
> 
> So it occurred to me that maybe it's better if I apply it?  After all,
> this is PM material. :-)

Heh, true, feel free to add:
	Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
to the patch then.

> It is fine by me either way, but then I'm not sure if you want to get
> future bug reports related to this if any ...

I get enough emails as it is, no need to ask for more :)

thanks,

greg k-h
