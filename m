Return-Path: <linux-pm+bounces-22221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC625A388DA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03C3162E46
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60E2253E3;
	Mon, 17 Feb 2025 16:05:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636B42A8B;
	Mon, 17 Feb 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808344; cv=none; b=WVJ34pEk+LzxeVQU8D0hE1CkXziJ08+pmz6gl8oxllqiXMarTEbOdV9JlItLtDTMRFllizPpyVRA0htp6EzWXXRJlrLcxXLLuGmuZy60DPBPY9/pTR1JDaJZXcYdC7MX43tZFu7mhDb7ZZnqtkSK00Ocltfnex/M7lrMDTq91es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808344; c=relaxed/simple;
	bh=yqJws6JkW21lN8MpioURnWEVZodpjZJM/x4s2QiNOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seywwFyAPD28a+JeKtP5IPGnMCuE2AwL1EOviDMgSACzK0THCcqfnyoy976NbTXH6QS/hn/YfaGKFTJfuaZ/QK4q9ypJuHPJlSx6lNyvQHLS3jIAOE8G+nHbsOrt/ueqOII2uoovpgC9rz6G4YQ7TLaT5xUjzTQAhDOoEPQdL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BE99152B;
	Mon, 17 Feb 2025 08:06:00 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561253F5A1;
	Mon, 17 Feb 2025 08:05:37 -0800 (PST)
Date: Mon, 17 Feb 2025 16:05:34 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<will@kernel.org>, <viresh.kumar@linaro.org>, <sumitg@nvidia.com>,
	<yang@os.amperecomputing.com>, <vanshikonda@os.amperecomputing.com>,
	<lihuisong@huawei.com>, <zhanjie9@hisilicon.com>,
	<ptsm@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v10 2/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Z7NeTrorAqDxa8QM@bogus>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
 <20250131162439.3843071-3-beata.michalska@arm.com>
 <CAJZ5v0g+yax=pT4m_2MTd9kUwbk5VBp2wkctTYJpFRU3myEjPQ@mail.gmail.com>
 <Z7NOcd3IamyMTjbH@arm.com>
 <Z7NQrBvnfYwXva1W@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7NQrBvnfYwXva1W@arm.com>

On Mon, Feb 17, 2025 at 03:07:24PM +0000, Ionela Voinescu wrote:
> Hi Catalin,
> 
> On Monday 17 Feb 2025 at 14:57:53 (+0000), Catalin Marinas wrote:
> > On Mon, Feb 17, 2025 at 12:52:44PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Jan 31, 2025 at 5:25 PM Beata Michalska <beata.michalska@arm.com> wrote:
> > > >
> > > > Currently the CPUFreq core exposes two sysfs attributes that can be used
> > > > to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> > > > and scaling_cur_freq. Both provide slightly different view on the
> > > > subject and they do come with their own drawbacks.
> > > >
> > > > cpuinfo_cur_freq provides higher precision though at a cost of being
> > > > rather expensive. Moreover, the information retrieved via this attribute
> > > > is somewhat short lived as frequency can change at any point of time
> > > > making it difficult to reason from.
> > > >
> > > > scaling_cur_freq, on the other hand, tends to be less accurate but then
> > > > the actual level of precision (and source of information) varies between
> > > > architectures making it a bit ambiguous.
> > > >
> > > > The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> > > > distinct interface, exposing an average frequency of a given CPU(s), as
> > > > reported by the hardware, over a time frame spanning no more than a few
> > > > milliseconds. As it requires appropriate hardware support, this
> > > > interface is optional.
> > > >
> > > > Note that under the hood, the new attribute relies on the information
> > > > provided by arch_freq_get_on_cpu, which, up to this point, has been
> > > > feeding data for scaling_cur_freq attribute, being the source of
> > > > ambiguity when it comes to interpretation. This has been amended by
> > > > restoring the intended behavior for scaling_cur_freq, with a new
> > > > dedicated config option to maintain status quo for those, who may need
> > > > it.
> > > 
> > > In case anyone is waiting for my input here
> > > 
> > > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > > 
> > > for this and the previous patch and please feel free to route them
> > > both through ARM64.
> > 
> > Thanks Rafael. I indeed plan to take them through the arm64 tree.
> 
> Just a mention that this set depends on the patch that Beata linked at
> [6]. That patch applies cleanly on next-20250217 and it still
> builds/boots/works as expected.
> 

Ah I see it is indeed dependent. Just responded on the other thread before
reading this. So it is better if Catalin picks up [6] as well. Sorry for
the confusion.

-- 
Regards,
Sudeep

[6] https://lore.kernel.org/all/20240827154818.1195849-1-ionela.voinescu@arm.com/

