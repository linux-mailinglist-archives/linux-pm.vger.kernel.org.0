Return-Path: <linux-pm+bounces-22218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9579A38716
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF2618906FB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF24224B0A;
	Mon, 17 Feb 2025 14:58:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1B224B02;
	Mon, 17 Feb 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804280; cv=none; b=Dtk/zToRZ5MXsf+qx69L2P5xZBkRuIVPzbR0IJIn4gq/gnMLBlULER6rrz2gjTEKyNq33dYcaJUplm5A+RY72K/mOVTPXBMiQNmILwwZ1o6/vWBSbSTTGc/EdmofpKD+AyBA2RXyxeAFpVKSw6UMkTiZTbYITWRrUyAV9NEgkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804280; c=relaxed/simple;
	bh=i5qIBPFIfSleKeqPnmWgDXFsvCA3yOtMTPrnhYV6Cqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5rO2SYwjHeE7QXaUxO1ge8gT+ZOpkHWAjerKGO2j0XbtJywaxhm3npOLSTkNHWfVffSxOMD+KSRSRs9Nqs/0C1BCLuCOQtIJ0VyLcDvI6kpyG4r8nD3AXWjhdVaPainUmVNjn4nh5ZDnm+zxrA0AbEUMvHwUbgbV0W4wbjlJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F0C4CEE4;
	Mon, 17 Feb 2025 14:57:55 +0000 (UTC)
Date: Mon, 17 Feb 2025 14:57:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	viresh.kumar@linaro.org, sumitg@nvidia.com,
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com, zhanjie9@hisilicon.com,
	ptsm@linux.microsoft.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 2/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <Z7NOcd3IamyMTjbH@arm.com>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
 <20250131162439.3843071-3-beata.michalska@arm.com>
 <CAJZ5v0g+yax=pT4m_2MTd9kUwbk5VBp2wkctTYJpFRU3myEjPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g+yax=pT4m_2MTd9kUwbk5VBp2wkctTYJpFRU3myEjPQ@mail.gmail.com>

On Mon, Feb 17, 2025 at 12:52:44PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 31, 2025 at 5:25 PM Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > Currently the CPUFreq core exposes two sysfs attributes that can be used
> > to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> > and scaling_cur_freq. Both provide slightly different view on the
> > subject and they do come with their own drawbacks.
> >
> > cpuinfo_cur_freq provides higher precision though at a cost of being
> > rather expensive. Moreover, the information retrieved via this attribute
> > is somewhat short lived as frequency can change at any point of time
> > making it difficult to reason from.
> >
> > scaling_cur_freq, on the other hand, tends to be less accurate but then
> > the actual level of precision (and source of information) varies between
> > architectures making it a bit ambiguous.
> >
> > The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> > distinct interface, exposing an average frequency of a given CPU(s), as
> > reported by the hardware, over a time frame spanning no more than a few
> > milliseconds. As it requires appropriate hardware support, this
> > interface is optional.
> >
> > Note that under the hood, the new attribute relies on the information
> > provided by arch_freq_get_on_cpu, which, up to this point, has been
> > feeding data for scaling_cur_freq attribute, being the source of
> > ambiguity when it comes to interpretation. This has been amended by
> > restoring the intended behavior for scaling_cur_freq, with a new
> > dedicated config option to maintain status quo for those, who may need
> > it.
> 
> In case anyone is waiting for my input here
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> for this and the previous patch and please feel free to route them
> both through ARM64.

Thanks Rafael. I indeed plan to take them through the arm64 tree.

-- 
Catalin

