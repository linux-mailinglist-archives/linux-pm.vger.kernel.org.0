Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6CB1AD454
	for <lists+linux-pm@lfdr.de>; Fri, 17 Apr 2020 04:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgDQCJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 22:09:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:18628 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgDQCJM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 22:09:12 -0400
IronPort-SDR: jr9MgFuf8FKNA4Xw4t4yAqnGIk2IMdgGvzsi51bBvfp2OLCMjhFvPVgacMRziRDvZ7tU01Scs9
 LIlvVJFP4eHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 19:09:12 -0700
IronPort-SDR: FhKZAZgWOPI5x3MGcnoUurPiHDgW+8ssi07neax3/DbU3sy2PN9XkuI4ojH8GXRMofO4fQOugS
 lUf0pSvvpotw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="428066403"
Received: from ali-mobl.ccr.corp.intel.com ([10.255.31.178])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 19:09:09 -0700
Message-ID: <160de74da5b3421cf69a65acd4abc10a26dc723c.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
Date:   Fri, 17 Apr 2020 10:09:08 +0800
In-Reply-To: <de51c277-22cd-6074-d651-084810656431@linaro.org>
References: <20200408041917.2329-1-rui.zhang@intel.com>
         <20200408041917.2329-5-rui.zhang@intel.com>
         <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
         <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
         <a15dee60-8d20-0f56-0037-276830c613cd@linaro.org>
         <fee68438572796c71089571e0ff0add6cbbd3e0c.camel@intel.com>
         <e264d4a2-b0d9-8adf-b44f-7501c4407029@linaro.org>
         <17727142fac13f641d7cd5c3713cfadef77aa75c.camel@intel.com>
         <1e65a2c3-fdeb-4f48-f477-a7ec67cffd4e@linaro.org>
         <eccb4e6a77ecd6ebaff9bd68b751ea20caa6a0a8.camel@intel.com>
         <de51c277-22cd-6074-d651-084810656431@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-04-16 at 09:58 +0200, Daniel Lezcano wrote:
> On 16/04/2020 06:46, Zhang Rui wrote:
> > On Mon, 2020-04-13 at 20:06 +0200, Daniel Lezcano wrote:
> > > On 13/04/2020 04:01, Zhang Rui wrote:
> > > > On Sun, 2020-04-12 at 12:07 +0200, Daniel Lezcano wrote:
> > > 
> > > [ ... ]
> > > 
> > > > why we can not have a cdev->max_state field, and get it updated
> > > > right
> > > > after .get_max_state().
> > > > and .get_max_state()  is only invoked
> > > > a) during cooling device registration
> > > > b) when cooling device update its max_state via the new API.
> > > > 
> > > > > 
> > > > > In the function thermal_cooling_device_stats_update():
> > > > > 
> > > > >   Is it possible to just compare the 'new_state' parameter
> > > > > with
> > > > > stats->max_state and if it is greater increase the stats
> > > > > table
> > > > > and
> > > > > update max_state to the new_state ?
> > > > > 
> > > > 
> > > > the problem is that thermal_cooling_device_stats_update() is
> > > > invoked
> > > > only if thermal zone are updated or the cur_state sysfs
> > > > attribute
> > > > is
> > > > changed.
> > > > There is no way for a cooling device driver to tell thermal
> > > > framework
> > > > that it has changed.
> > > > Say, for the problem on hand, the statistics table will not be
> > > > updated
> > > > in time when cpufreq driver probed.
> > > 
> > > Except I'm missing something, the statistics are only read from
> > > userspace via sysfs.
> > 
> > I agree.
> > > 
> > > userspace is not notified about a stat change. Is it really a
> > > problem
> > > the table is not updated right at the probe time ?
> > >  Does it really matter
> > > if the user sees the old table until an update happens on a new
> > > higher
> > > max state ?
> > > 
> > > The table is always consistent whenever the userspace reads the
> > > content.
> > > 
> > > A new entry will appear only if it is used, no?
> > > 
> > 
> > Hmm, IMO, stats table is not the biggest problem here.
> > The problem is that thermal framework is not aware of the max_state
> > change, and the thermal instances are never updated according to
> > the
> > new max_state.
> > So, we should invoke .get_max_state() in
> > thermal_zone_device_update()
> > and update the thermal instances accordingly.
> > And then, what we need to do is just to do stats update right after
> > .get_max_state() being invoked.
> > 
> > About how to update the stats table, I think adding new entries is
> > not
> > enough, because the meaning of each cooling state may change when
> > max_state changes, thus I'd prefer a full reset/resizing of the
> > table.
> 
> Ok, I understand. Are planning to use the existing API:
> 
>  thermal_zone_device_update(tz, THERMAL_TABLE_CHANGED);

we can not use THERMAL_TABLE_CHANGED because cooling device driver can
not invoke thermal_zone_device_update().

So, the cooling device max_state is changed, but the thermal framework
will not know this until the cooling device being used for a
temperature change.
For the cooling devices that are not used by any thermal zones, the
stats files are probably out of date, but maybe nobody cares. Or we can
fix this by updating stats table for every stats sysfs attribute
access.

thanks,
rui

