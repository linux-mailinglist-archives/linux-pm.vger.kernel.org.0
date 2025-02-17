Return-Path: <linux-pm+bounces-22226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E360A38B2F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 19:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7019D1893ED3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA6233150;
	Mon, 17 Feb 2025 18:20:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF654229B18;
	Mon, 17 Feb 2025 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816408; cv=none; b=kIk9F1djGtTMiqT0wTH25HcSxZzlq9M693gFOmYVlR7QRVEemX6N4PQIoXCyg/hUS8+FfCNOGHYH4Pn3Rxm+W6l6zgatmwuyLkfSgfYnSRbHtYX3OHWVbWiz05mvN6fEN7dmbQ4adt05WIBIqqRQdbP00UU9RaJQyahYZEMAAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816408; c=relaxed/simple;
	bh=7v9JiuvwjKhG5Dg3ZHjNC2SWZm0sNugydy6hsXZgOqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX1803TV6yNk71bjPyMSQ2CVHdc4oYZmZ2cKR6VsJOsKM+WOS17FuKm2pTSYoBSOHcoEYWo9qfjKooM4rKl3mGPB25AYEcmlYdsPiN+nJeVhaJ77CfEBuv8NtYUHAFA+419D7ZXaJFByfvYWS45olks8gYZR7nu4TQShkle9LTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C0DC4CED1;
	Mon, 17 Feb 2025 18:20:03 +0000 (UTC)
Date: Mon, 17 Feb 2025 18:20:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, will@kernel.org, viresh.kumar@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, ptsm@linux.microsoft.com,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 2/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Z7N90XZTICfLZCm_@arm.com>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
 <20250131162439.3843071-3-beata.michalska@arm.com>
 <CAJZ5v0g+yax=pT4m_2MTd9kUwbk5VBp2wkctTYJpFRU3myEjPQ@mail.gmail.com>
 <Z7NOcd3IamyMTjbH@arm.com>
 <Z7NQrBvnfYwXva1W@arm.com>
 <Z7NeTrorAqDxa8QM@bogus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7NeTrorAqDxa8QM@bogus>

On Mon, Feb 17, 2025 at 04:05:34PM +0000, Sudeep Holla wrote:
> On Mon, Feb 17, 2025 at 03:07:24PM +0000, Ionela Voinescu wrote:
> > On Monday 17 Feb 2025 at 14:57:53 (+0000), Catalin Marinas wrote:
> > > On Mon, Feb 17, 2025 at 12:52:44PM +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Jan 31, 2025 at 5:25 PM Beata Michalska <beata.michalska@arm.com> wrote:
> > > > >
> > > > > Currently the CPUFreq core exposes two sysfs attributes that can be used
> > > > > to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> > > > > and scaling_cur_freq. Both provide slightly different view on the
> > > > > subject and they do come with their own drawbacks.
> > > > >
> > > > > cpuinfo_cur_freq provides higher precision though at a cost of being
> > > > > rather expensive. Moreover, the information retrieved via this attribute
> > > > > is somewhat short lived as frequency can change at any point of time
> > > > > making it difficult to reason from.
> > > > >
> > > > > scaling_cur_freq, on the other hand, tends to be less accurate but then
> > > > > the actual level of precision (and source of information) varies between
> > > > > architectures making it a bit ambiguous.
> > > > >
> > > > > The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> > > > > distinct interface, exposing an average frequency of a given CPU(s), as
> > > > > reported by the hardware, over a time frame spanning no more than a few
> > > > > milliseconds. As it requires appropriate hardware support, this
> > > > > interface is optional.
> > > > >
> > > > > Note that under the hood, the new attribute relies on the information
> > > > > provided by arch_freq_get_on_cpu, which, up to this point, has been
> > > > > feeding data for scaling_cur_freq attribute, being the source of
> > > > > ambiguity when it comes to interpretation. This has been amended by
> > > > > restoring the intended behavior for scaling_cur_freq, with a new
> > > > > dedicated config option to maintain status quo for those, who may need
> > > > > it.
> > > > 
> > > > In case anyone is waiting for my input here
> > > > 
> > > > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > > > 
> > > > for this and the previous patch and please feel free to route them
> > > > both through ARM64.
> > > 
> > > Thanks Rafael. I indeed plan to take them through the arm64 tree.
> > 
> > Just a mention that this set depends on the patch that Beata linked at
> > [6]. That patch applies cleanly on next-20250217 and it still
> > builds/boots/works as expected.
> 
> Ah I see it is indeed dependent. Just responded on the other thread before
> reading this. So it is better if Catalin picks up [6] as well. Sorry for
> the confusion.

I picked that one as well. I'll do some tests and push them out later
today or tomorrow morning.

Thanks.

-- 
Catalin

