Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B065B22075B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGOId1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgGOId1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 04:33:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB1C20672;
        Wed, 15 Jul 2020 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594802006;
        bh=iOVN0Aj56V7pWppvWBvshuC3/3Wx6PjHbGrnZyydSO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTE7YLDehLY6msegiqFCDsJCkrKstPFQEli4wDa+DYQ0plMqvlHJ00vUMOzOrJCY/
         05CVC2ZuBA3YF5UVB395FVbgyOFuFxd2c+C3Gb9/pHpjTpCyPYcjbchaOybNvNF9Nr
         0hAr7IDZ08YHAOgkmGdtM567MY6dwVdj2gl/4Ae4=
Date:   Wed, 15 Jul 2020 10:33:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RESEND v3] PM-runtime: change the tracepoints to
 cover all usage_count
Message-ID: <20200715083322.GB2716443@kroah.com>
References: <cover.1594790493.git.yu.c.chen@intel.com>
 <395187057e486df9a4328bc6d7d4ee912967fdb3.1594790493.git.yu.c.chen@intel.com>
 <20200715070614.GA2297388@kroah.com>
 <20200715081838.GA22379@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715081838.GA22379@chenyu-office.sh.intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 04:18:38PM +0800, Chen Yu wrote:
> Hi Greg,
> thanks very much for taking a look,
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
> > 
> If I understand correctly, besides Michal's comments, if we put the trace
> before the atomic operation, we might be unable to judge whether the counter
> is going to increase or decrease from rpmflags: it is RPM_GET_PUT which combine
> the get() and put() together, then it is a little inconvenient for tracking IMO.

A trace can never know the exact value of an atomic value as it could
change right before or after the trace function is called, right?

So why are you caring about that?  Care about the functionality that is
happening, not a reference count that you do not control at all.

thanks,

greg k-h
