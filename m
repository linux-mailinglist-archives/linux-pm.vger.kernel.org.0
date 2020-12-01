Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897602CA665
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 15:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbgLAO4Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 09:56:25 -0500
Received: from foss.arm.com ([217.140.110.172]:44336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388952AbgLAO4Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 09:56:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32CB630E;
        Tue,  1 Dec 2020 06:55:38 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C86AD3F575;
        Tue,  1 Dec 2020 06:55:37 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:55:36 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amit.kucheria@verdurent.com,
        airlied@linux.ie, daniel.lezcano@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, rui.zhang@intel.com,
        orjan.eide@arm.com
Subject: Re: [PATCH 2/5] thermal: devfreq_cooling: get a copy of device status
Message-ID: <20201201145536.GB7206@arm.com>
References: <20200921122007.29610-1-lukasz.luba@arm.com>
 <20200921122007.29610-3-lukasz.luba@arm.com>
 <20201007161120.GC15063@arm.com>
 <76e0ef49-5898-adbb-0c54-23d5999f4907@arm.com>
 <20201201103614.GA1908@arm.com>
 <2fc2031d-e38e-2a17-8667-f2fc8d4f724b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc2031d-e38e-2a17-8667-f2fc8d4f724b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 01 Dec 2020 at 12:19:18 (+0000), Lukasz Luba wrote:
> 
> 
> On 12/1/20 10:36 AM, Ionela Voinescu wrote:
> > Hi,
> > 
> > Sorry for the delay and for the noise on this older version. I first
> > want to understand the code better.
> > 
> > On Thursday 22 Oct 2020 at 11:55:28 (+0100), Lukasz Luba wrote:
> > [..]
> > > 
> > > > 
> > > > > +{
> > > > > +	/* Make some space if needed */
> > > > > +	if (status->busy_time > 0xffff) {
> > > > > +		status->busy_time >>= 10;
> > > > > +		status->total_time >>= 10;
> > > > > +	}
> > > > 
> > > > How about removing the above code and adding here:
> > > > 
> > > > status->busy_time = status->busy_time ? : 1;
> > > 
> > > It's not equivalent. The code operates on raw device values, which
> > > might be big (e.g. read from counters). If it's lager than the 0xffff,
> > > it is going to be shifted to get smaller.
> > > 
> > 
> > Yes, the big values are handled below through the division and by making
> > total_time = 1024. These two initial checks are only to cover the
> > possibility for busy_time and total_time being 0, or busy_time >
> > total_time.
> > 
> > > > 
> > > > > +
> > > > > +	if (status->busy_time > status->total_time)
> > > > 
> > > > This check would then cover the possibility that total_time is 0.
> > > > 
> > > > > +		status->busy_time = status->total_time;
> > > > 
> > > > But a reversal is needed here:
> > > > 		status->total_time = status->busy_time;
> > > 
> > > No, I want to clamp the busy_time, which should not be bigger that
> > > total time. It could happen when we deal with 'raw' values from device
> > > counters.
> > > 
> > 
> > Yes, I understand. But isn't making total_time = busy_time accomplishing
> > the same thing?
> > 
> > > > 
> > > > > +
> > > > > +	status->busy_time *= 100;
> > > > > +	status->busy_time /= status->total_time ? : 1;
> > > > > +
> > > > > +	/* Avoid division by 0 */
> > > > > +	status->busy_time = status->busy_time ? : 1;
> > > > > +	status->total_time = 100;
> > > > 
> > > > Then all of this code can be replaced by:
> > > > 
> > > > status->busy_time = (unsigned long)div64_u64((u64)status->busy_time << 10,
> > > > 					     status->total_time);
> > > > status->total_time = 1 << 10;
> > > 
> > > No, the total_time closed to 'unsigned long' would overflow.
> > > 
> > 
> > I'm not sure I understand. total_time gets a value of 1024, it's not
> > itself shifted by 10.
> > 
> > > > 
> > > > This way you gain some resolution to busy_time and the divisions in the
> > > > callers would just become shifts by 10.
> > > 
> > > 
> > > I don't want to gain more resolution here. I want to be prepare for raw
> > > (not processed yet) big values coming from driver.
> > > 
> > 
> > Agreed! The higher resolution is an extra benefit. The more important
> > benefit is that, through my suggestion, you'd be replacing all future
> > divisions by shifts.
> 
> You have probably missed some bits.
> I don't see benefits, you have div64_u64() which is heavy on 32bit CPUs.
> 
> Then, what is the range of these values:
> busy_time [0, 1024], total_time 1024 in your case.
> These values are used for estimating power in two cases:
> 1. in devfreq_cooling_get_requested_power()
> 	est_power = power * busy_time / total_time
> 2. in devfreq_cooling_power2state():
> 	est_power = power * total_time / busy_time
> 
> As you can see above, the est_power values could overflow if total_time,
> busy_time are raw values (like in old implementation). So normalize them
> into 'some' scale. That was the motivation ('scale' motivation below).
> 

Agreed! I do think scaling is necessary, but in my mind the [0, 1024] scale
made more sense.

> In your case you cannot avoid division in 2. use case, because busy_time
> can be any value in range [0, 1024].
> We could avoid the division in 1. use case, but load in cpufreq cooling
> is also in range of [0, 100], so this devfreq cooling is aligned. I
> would like to avoid situation when someone is parsing the traces
> and these two devices present different load scale.
> 

Got it! Looking through the code I did overlook that 2 was reversed.

> I will think about better 'devfreq utilization' (as also Daniel
> suggested)in future, but first this EM must be in mainline and cpufreq
> cooling changes made by Viresh also there.
> But it would be more then just scale change to [0, 1024]...
> 

Okay, looking forward to this. It would be nice to align all of these
utilization metrics in the future for all kinds of devices.

Thanks,
Ionela.
