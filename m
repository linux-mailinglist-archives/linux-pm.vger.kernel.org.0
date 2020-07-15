Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADDE2206E3
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgGOIRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgGOIRw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 04:17:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA6C2067D;
        Wed, 15 Jul 2020 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594801072;
        bh=SvP8iyns00kbpVs5yBcwZXOYmwphb3eMqVXOlGWTykA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HhHhjzla7+qt5CngL6tg5OM8+pscX43/hxhpf0kHJwQsQVuNpjZXwGmgSDYsq3RXV
         6dC1i4zALOwOJ56/cRJoVeZYfrOnPlYBKn4tJURD3URn3WDl4n2UBrZfMzXMP9LxeC
         T+xIJs1imS7+nrpQajRxS2+QjIWt3dX/+1R0/IKI=
Date:   Wed, 15 Jul 2020 10:17:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RESEND v3] PM-runtime: change the tracepoints to
 cover all usage_count
Message-ID: <20200715081746.GA2616388@kroah.com>
References: <cover.1594790493.git.yu.c.chen@intel.com>
 <395187057e486df9a4328bc6d7d4ee912967fdb3.1594790493.git.yu.c.chen@intel.com>
 <20200715070614.GA2297388@kroah.com>
 <20200715072728.GA18147@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715072728.GA18147@qmqm.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 09:27:28AM +0200, Michal Miroslaw wrote:
> On Wed, Jul 15, 2020 at 09:06:14AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 15, 2020 at 02:28:03PM +0800, Chen Yu wrote:
> > > Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> > > has added some tracepoints to monitor the change of runtime usage, and
> > > there is something to improve:
> > > 1. There are some places that adjust the usage count not
> > >    been traced yet. For example, pm_runtime_get_noresume() and
> > >    pm_runtime_put_noidle()
> > > 2. The change of the usage count will not be tracked if decreased
> > >    from 1 to 0.
> > > 
> > > This patch intends to adjust the logic to be consistent with the
> > > change of usage_counter, that is to say, only after the counter has
> > > been possibly modified, we record it. Besides, all usage changes will
> > > be shown using rpm_usage even if included by other trace points.
> > > And these changes has helped track down the e1000e runtime issue.
> > > 
> > > Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c | 38 +++++++++++++++++++++++-------------
> > >  1 file changed, 24 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 85a248e196ca..5789d2624513 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -1004,10 +1004,11 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
> > >  	int retval;
> > >  
> > >  	if (rpmflags & RPM_GET_PUT) {
> > > -		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > > -			trace_rpm_usage_rcuidle(dev, rpmflags);
> > > +		bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
> > > +
> > > +		trace_rpm_usage_rcuidle(dev, rpmflags);
> > 
> > Why not just call trace everywhere before you do the atomic operations?
> > Why does the trace need to be called after the operation everywhere?
> 
> I would argue that this is easier mentally: We trace what state the
> device is in from now on (a "current state" for the time being) instead
> of tracing what it was before (an information that has just expired).

Is that really the case here and you look at that atomic value somehow
in the trace and need it?

thanks,

greg k-h
