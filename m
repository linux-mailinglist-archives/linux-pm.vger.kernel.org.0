Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BB1F1312
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 08:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgFHGw2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 02:52:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:17633 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHGw1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jun 2020 02:52:27 -0400
IronPort-SDR: cp9X9B84NAjPh0/jJ2V5rrR8AkAdWPa3wTMXeSCL97NiC6dw+IAMSQi5+4sdC0m9R2LxMQF3H0
 qpaRkDHn2OFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 23:52:26 -0700
IronPort-SDR: mTuTwaNs94YS1DXYh0D7RJaQ3aJ2l6U9lq8UJ0y4jWjDGsH6lBWYNmBD/nA6kW3Bn5pNrPCUYz
 SzRyVmF9zuog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="313797666"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2020 23:52:25 -0700
Date:   Mon, 8 Jun 2020 14:53:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RFC] PM-runtime: add tracepoints to cover all
 usage_count changes
Message-ID: <20200608065324.GA9018@chenyu-office.sh.intel.com>
References: <cover.1591380524.git.yu.c.chen@intel.com>
 <6ce5c2d21758363b7c9a31187eda1787bc4a6160.1591380524.git.yu.c.chen@intel.com>
 <20200605193311.GB9553@qmqm.qmqm.pl>
 <20200606071459.GA1298@chenyu-office.sh.intel.com>
 <20200607045535.GD12913@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607045535.GD12913@qmqm.qmqm.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 07, 2020 at 06:55:35AM +0200, Michal Miroslaw wrote:
> On Sat, Jun 06, 2020 at 03:14:59PM +0800, Chen Yu wrote:
> > Hi,
> > On Fri, Jun 05, 2020 at 09:33:11PM +0200, Michal Miroslaw wrote:
> > > On Sat, Jun 06, 2020 at 03:05:52AM +0800, Chen Yu wrote:
> > > > Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> > > > has added some tracepoints to monitor the change of runtime usage, and
> > > > there is something to improve:
> > > > 1. There are some places that adjust the usage count have not
> > > >    been traced yet. For example, pm_runtime_get_noresume() and
> > > >    pm_runtime_put_noidle()
> > > > 2. The change of the usage count will not be tracked if decreased
> > > >    from 1 to 0.
> > > [...]
> > > > @@ -1448,16 +1453,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
> > > >   */
> > > >  void pm_runtime_allow(struct device *dev)
> > > >  {
> > > > +	bool is_zero;
> > > > +
> > > >  	spin_lock_irq(&dev->power.lock);
> > > >  	if (dev->power.runtime_auto)
> > > >  		goto out;
> > > >  
> > > >  	dev->power.runtime_auto = true;
> > > > -	if (atomic_dec_and_test(&dev->power.usage_count))
> > > > +	is_zero = atomic_dec_and_test(&dev->power.usage_count);
> > > > +	trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> > > > +	if (is_zero)
> > > >  		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> > > > -	else
> > > > -		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> > > > -
> > > [...]
> > > 
> > > IIRC, rpm_idle() has a tracepoint already.
> > > 
> > Yes, this is what I concerned previously. If someone
> > want to track the change of usage_count, then he might
> > have to enable both trace rpm_usage and rpm_idle so
> > as to track the moment when the counter drops from 1 to
> > 0. It might be more consistent if we only enable
> > trace rpm_usage to track the whole process.
> > > > @@ -1523,9 +1529,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
> > > >  		/* If it used to be allowed then prevent it. */
> > > >  		if (!old_use || old_delay >= 0) {
> > > >  			atomic_inc(&dev->power.usage_count);
> > > > -			rpm_resume(dev, 0);
> > > > -		} else {
> > > >  			trace_rpm_usage_rcuidle(dev, 0);
> > > > +			rpm_resume(dev, 0);
> > > >  		}
> > > >  	}
> > > [...]
> > > 
> > > This actually changes logic, so it doesn't match the patch description.
> > > 
> > This patch intends to adjust the logic to be consistent with
> > the change of usage_counter, that is to say, only after the
> > counter has been possibly modified, we record it. In current
> > logic above, it tracks the usage count where the latter does
> > not change.
> 
> I see now what you intended. I think it would be nice to put the idea
> (that all usage changes be shown using rpm_usage even if included in
> other trace points) into the commit message. Otherwise, looks ok.
>
Okay, will do in next version, thanks!

Chenyu
