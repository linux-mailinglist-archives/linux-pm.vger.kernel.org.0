Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6FD1F0A13
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 06:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgFGEzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 00:55:39 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:37520 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgFGEzi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Jun 2020 00:55:38 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49fkbY015Mz2d;
        Sun,  7 Jun 2020 06:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591505737; bh=6UnrK/OmV85PtsxFuB58PQ6KMxKOlyohnWQ5M2B8m/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADXGRqbKXr8x5pGtBTlY2ESBhWsOswJXSYhc6uZxv1K7Zix+J1UkTt5JS2sS1NAD7
         JgF0iq6PAghMubWJCN+NLQCUTrQOfd0veuC2pMF/JiJI3yLniL9BkqWWhMdl8oATgE
         C2P0AL85++UK2UFShBYhxNpb1NHZNBXZG5a6QciKwSxsQXxvQHMn19lZua+Pc6sYE1
         aDcvEPh4pV8CVI1a11EVonEQ2TYKnZR0RrviiiysW/B2o/Ln4eM5khlyrDlB1Kjrzt
         mQK5nSUTs/BPK9CgIK/q3/2e0PpQaZD3teLUV7bKEp2c8PRRDLozB6ebuF4JPSQvru
         wfTSrdXeD8Vkg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 7 Jun 2020 06:55:35 +0200
From:   Michal Miroslaw <mirq-linux@rere.qmqm.pl>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RFC] PM-runtime: add tracepoints to cover all
 usage_count changes
Message-ID: <20200607045535.GD12913@qmqm.qmqm.pl>
References: <cover.1591380524.git.yu.c.chen@intel.com>
 <6ce5c2d21758363b7c9a31187eda1787bc4a6160.1591380524.git.yu.c.chen@intel.com>
 <20200605193311.GB9553@qmqm.qmqm.pl>
 <20200606071459.GA1298@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200606071459.GA1298@chenyu-office.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 06, 2020 at 03:14:59PM +0800, Chen Yu wrote:
> Hi,
> On Fri, Jun 05, 2020 at 09:33:11PM +0200, Michal Miroslaw wrote:
> > On Sat, Jun 06, 2020 at 03:05:52AM +0800, Chen Yu wrote:
> > > Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> > > has added some tracepoints to monitor the change of runtime usage, and
> > > there is something to improve:
> > > 1. There are some places that adjust the usage count have not
> > >    been traced yet. For example, pm_runtime_get_noresume() and
> > >    pm_runtime_put_noidle()
> > > 2. The change of the usage count will not be tracked if decreased
> > >    from 1 to 0.
> > [...]
> > > @@ -1448,16 +1453,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
> > >   */
> > >  void pm_runtime_allow(struct device *dev)
> > >  {
> > > +	bool is_zero;
> > > +
> > >  	spin_lock_irq(&dev->power.lock);
> > >  	if (dev->power.runtime_auto)
> > >  		goto out;
> > >  
> > >  	dev->power.runtime_auto = true;
> > > -	if (atomic_dec_and_test(&dev->power.usage_count))
> > > +	is_zero = atomic_dec_and_test(&dev->power.usage_count);
> > > +	trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> > > +	if (is_zero)
> > >  		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
> > > -	else
> > > -		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
> > > -
> > [...]
> > 
> > IIRC, rpm_idle() has a tracepoint already.
> > 
> Yes, this is what I concerned previously. If someone
> want to track the change of usage_count, then he might
> have to enable both trace rpm_usage and rpm_idle so
> as to track the moment when the counter drops from 1 to
> 0. It might be more consistent if we only enable
> trace rpm_usage to track the whole process.
> > > @@ -1523,9 +1529,8 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
> > >  		/* If it used to be allowed then prevent it. */
> > >  		if (!old_use || old_delay >= 0) {
> > >  			atomic_inc(&dev->power.usage_count);
> > > -			rpm_resume(dev, 0);
> > > -		} else {
> > >  			trace_rpm_usage_rcuidle(dev, 0);
> > > +			rpm_resume(dev, 0);
> > >  		}
> > >  	}
> > [...]
> > 
> > This actually changes logic, so it doesn't match the patch description.
> > 
> This patch intends to adjust the logic to be consistent with
> the change of usage_counter, that is to say, only after the
> counter has been possibly modified, we record it. In current
> logic above, it tracks the usage count where the latter does
> not change.

I see now what you intended. I think it would be nice to put the idea
(that all usage changes be shown using rpm_usage even if included in
other trace points) into the commit message. Otherwise, looks ok.

Best Regards
Micha³ Miros³aw
