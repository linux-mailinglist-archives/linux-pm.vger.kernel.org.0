Return-Path: <linux-pm+bounces-8618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D08FC6C8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21819B2AB80
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD849639;
	Wed,  5 Jun 2024 08:36:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F31946CD;
	Wed,  5 Jun 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576583; cv=none; b=s47MoA4PJ6DchIuNntPs0S8qNXOPCxb/Ynw9NrC/CbsdSnvHJwTXJJZKRwNY/bFtnlL5wdXMlzW7hiEzFOScDhlEc3Rzi9inDJPicVy5cjAkm9r2kTaMG1nZPxfH3OqvwjAM1H7E2RDDIE1vq8xMbgn73czodllaeXlX/WZdUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576583; c=relaxed/simple;
	bh=+bHUNQ5M5IR38v2t2j7DBP43t3xuf9K3LOgjqNKeaZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ0lvaXg2CwsioAUnrYEuHdo70P9A3O0VM1Fhg7lbD3V21+NoW1fwYDk0BR/UhXzk7CfvL8S7Ch5+eXrAL+fhBmVtb7KugEwtC+4CrfSGtpvPloMTd6HEUV95oyF2FK6LvxdhblehtCn6GKCT6fP/mRMD6x9QcN9lrU6PFBF/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCE2DDA7;
	Wed,  5 Jun 2024 01:36:44 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31BA53F762;
	Wed,  5 Jun 2024 01:36:18 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:36:15 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, len.brown@intel.com,
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for
 cpuinfo/scaling_cur_freq
Message-ID: <ZmAjfyGWtti17WiO@arm.com>
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com>
 <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>

On Mon, Jun 03, 2024 at 03:43:12PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 3, 2024 at 1:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi Beata,
> >
> > Thanks for taking this forward.
> >
> > On 03-06-24, 09:13, Beata Michalska wrote:
> > > Some architectures provide a way to determine an average frequency over
> > > a certain period of time, based on available performance monitors (AMU on
> > > ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on_cpu
> > > into cpuinfo_cur_freq policy sysfs attribute handler, which is expected to
> > > represent the current frequency of a given CPU,as obtained by the hardware.
> > > This is the type of feedback that counters do provide.
> >
> > Please add blank line between paragraphs, it makes it easier to read
> > them.
> >
> > > At the same time, keep the scaling_cur_freq attribute align with the docs
> > > and make it provide most recently requested frequency, still allowing to
> > > fallback to using arch_freq_get_on_cpu for cases when cpuinfo_cur_freq is
> > > not available.
> >
> > Please split this patch into two parts, they are very distinct changes
> > and should be kept separate.
> >
> > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index a45aac17c20f..3b0eabe4a983 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -758,7 +758,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> > >       ssize_t ret;
> > >       unsigned int freq;
> > >
> > > -     freq = arch_freq_get_on_cpu(policy->cpu);
> > > +     freq = !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->cpu)
> > > +                                 : 0;
> >
> > This is getting trickier than I thought as I dived into more details
> > of all the changes to the file.
> >
> > Rafael,
> >
> > We probably need to decide on a policy for these two files, it is
> > getting a bit confusing.
> >
> > cpuinfo_cur_freq:
> >
> > The purpose of this file is abundantly clear. This returns the best
> > possible guess of the current hardware frequency. It should rely on
> > arch_freq_get_on_cpu() or ->get() to get the value.
> 
> Let me quote the documentation:
> 
> "This is expected to be the frequency the hardware actually runs at.
> If that frequency cannot be determined, this attribute should not be
> present."
> 
> In my reading, this has nothing to do with arch_freq_get_on_cpu(), at
> least on x86.
My reading on this (and I might be wrong) is that for x86,
arch_freq_get_on_cpu() is utilizing the APERF/MPERF registers to get
a rough/average frequency and as such it does, in a way, get a hw feedback
and it does somewhat fall under "frequency the hardware actually runs at".
Because it is an average value, it might not provide an instant view on
current frequency, but either way, the value provided here migh be a bit off
anyway. But then, we could adjust the timewidnow being used to make it more
accurate. I might be looking at it the wrong way though.
> 
> > Perhaps we can
> > make this available all the time, instead of conditionally on ->get()
> > callback (which isn't present for intel-pstate for example).
> 
> We could, but then on x86 there is no expectation that this file will
> be present and changing this may introduce significant confusion
> because of the way it is documented (which would need to be changed,
> but people might be forgiven for failing to notice the change of
> interpretation of this file).
> 
> > scaling_cur_freq:
> >
> > This should better reflect the last requested frequency, but since a
> > significant time now it is trying to show what cpuinfo_cur_freq shows.
> 
> Well, not really.
> 
> > commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file for set_policy() drivers")
> > commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF")
> 
> "In the majority of cases, this is the frequency of the last P-state
> requested by the scaling driver from the hardware using the scaling
> interface provided by it, which may or may not reflect the frequency
> the CPU is actually running at (due to hardware design and other
> limitations).
> 
> Some architectures (e.g. x86) may attempt to provide information more
> precisely reflecting the current CPU frequency through this attribute,
> but that still may not be the exact current CPU frequency as seen by
> the hardware at the moment."
> 
> So the problem is that on Intel x86 with HWP and intel_pstate in the
> active mode, say, "the frequency of the last P-state requested by the
> scaling driver from the hardware" is actually never known, so exposing
> it via scaling_cur_freq is not possible.
> 
> Moreover, because cpuinfo_cur_freq is not present at all in that case,
> scaling_cur_freq is the only way to allow user space to get an idea
> about the CPU current frequency.  I don't think it can be changed now
> without confusing users.
> 
What's your take on leaving the scaling_cur_freq to resolve to
arch_freq_get_on_cpu() when cpuinfo_cur_freq is not present ?
This way nothing will change for the intel_pstate + HWP
but it will allow using the info provided by arch_freq_get_on_cpu() for
cpuinfo_cur_freq if one is provided and it will automatically ignore it for
scaling_cur_freq ? Though I guess it falls under "making all confused" that you
have described donw the line.

> > What should we do ? I wonder if we will break some userspace tools
> > (which may have started relying on these changes).
> 
> We will.
> 
> IIUC, it is desirable to expose "the frequency of the last P-state
> requested by the scaling driver from the hardware" via
> scaling_cur_freq on ARM, but it is also desirable to expose an
> approximation of the actual current CPU frequency, so the only way to
> do that without confusing the heck out of everybody downstream would
> be to introduce a new attribute for this purpose and document it
> precisely.
What would introducing new attribute mean for scaling_cur_freq on x86 then ?
I do assume we would leave cpuinfo_cur_freq untouched without calling
arch_freq_get_on_cpu() (as it is now). Then keeping scaling_cur_freq to actually
use it - what would be the 3rd attribute meaning, if:
- cpuinfo_cur_freq -> actual freq as seen by the hardware (but not the
  counters?)
- scaling_cur_freq -> last requested frequency and for some cases, feedback from
  counters
- whatever_name_we_will_come_with -> average frequency based on counters ?
  not always available

 It is still bit confusing.

 ---
 BR
 Beata

