Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B8222198A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 03:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGPBfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 21:35:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:10584 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgGPBfc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 21:35:32 -0400
IronPort-SDR: 9oFk6EYq2hpke8wSwIeanK/Dpw+C0jK75zZtb+GCDWEscWlo3Ov8ZwPXgsD9J/cNgR+xs0EuP1
 CXkA3S3qeMqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="214041430"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="214041430"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 18:35:31 -0700
IronPort-SDR: ozKYVC1y3pkTrbx0L1zzxBwFXai+jRrnC5ObEUXiKpj1lQgZ6AkDwK6faWM5wX6g/F6ZzB548z
 4lruNonPTyJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="485929190"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2020 18:35:29 -0700
Date:   Thu, 16 Jul 2020 09:36:50 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RESEND v3] PM-runtime: change the tracepoints to
 cover all usage_count
Message-ID: <20200716013649.GA4588@chenyu-office.sh.intel.com>
References: <cover.1594790493.git.yu.c.chen@intel.com>
 <395187057e486df9a4328bc6d7d4ee912967fdb3.1594790493.git.yu.c.chen@intel.com>
 <20200715070614.GA2297388@kroah.com>
 <20200715081838.GA22379@chenyu-office.sh.intel.com>
 <20200715083322.GB2716443@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715083322.GB2716443@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 10:33:22AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 15, 2020 at 04:18:38PM +0800, Chen Yu wrote:
> > Hi Greg,
> > thanks very much for taking a look,
> > On Wed, Jul 15, 2020 at 09:06:14AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jul 15, 2020 at 02:28:03PM +0800, Chen Yu wrote:
> > > > Commit d229290689ae ("PM-runtime: add tracepoints for usage_count changes")
> > > > has added some tracepoints to monitor the change of runtime usage, and
> > > > there is something to improve:
> > > > 1. There are some places that adjust the usage count not
> > > >    been traced yet. For example, pm_runtime_get_noresume() and
> > > >    pm_runtime_put_noidle()
> > > > 2. The change of the usage count will not be tracked if decreased
> > > >    from 1 to 0.
> > > > 
> > > > This patch intends to adjust the logic to be consistent with the
> > > > change of usage_counter, that is to say, only after the counter has
> > > > been possibly modified, we record it. Besides, all usage changes will
> > > > be shown using rpm_usage even if included by other trace points.
> > > > And these changes has helped track down the e1000e runtime issue.
> > > > 
> > > > Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > ---
> > > >  drivers/base/power/runtime.c | 38 +++++++++++++++++++++++-------------
> > > >  1 file changed, 24 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > index 85a248e196ca..5789d2624513 100644
> > > > --- a/drivers/base/power/runtime.c
> > > > +++ b/drivers/base/power/runtime.c
> > > > @@ -1004,10 +1004,11 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
> > > >  	int retval;
> > > >  
> > > >  	if (rpmflags & RPM_GET_PUT) {
> > > > -		if (!atomic_dec_and_test(&dev->power.usage_count)) {
> > > > -			trace_rpm_usage_rcuidle(dev, rpmflags);
> > > > +		bool non_zero = !atomic_dec_and_test(&dev->power.usage_count);
> > > > +
> > > > +		trace_rpm_usage_rcuidle(dev, rpmflags);
> > > 
> > > Why not just call trace everywhere before you do the atomic operations?
> > > Why does the trace need to be called after the operation everywhere?
> > > 
> > If I understand correctly, besides Michal's comments, if we put the trace
> > before the atomic operation, we might be unable to judge whether the counter
> > is going to increase or decrease from rpmflags: it is RPM_GET_PUT which combine
> > the get() and put() together, then it is a little inconvenient for tracking IMO.
> 
> A trace can never know the exact value of an atomic value as it could
> change right before or after the trace function is called, right?
> 
> So why are you caring about that?  Care about the functionality that is
> happening, not a reference count that you do not control at all.
>
Ah I see, thanks for the explanation, I'll re-think about the scenaio.

Thanks,
Chenyu
> thanks,
> 
> greg k-h
