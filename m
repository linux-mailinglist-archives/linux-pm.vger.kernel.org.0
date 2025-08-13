Return-Path: <linux-pm+bounces-32250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3F0B2457F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 11:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503D2176EE4
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1CF2D5439;
	Wed, 13 Aug 2025 09:31:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615222C21C8;
	Wed, 13 Aug 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077470; cv=none; b=vDwFFqH2QTmW2/ym9xuyfKX4pQlk7K9e9pcHIAcM7LkA0DdsKc4o+icJjIWd+f53Glp1WPy+u4FlgEy/58DJJMbPK7cpIDWB1CGHbdYFk7rVDsC/G1XI/L0AUwGCgqOcqxlfyVOElMN95gXDb+PZ09oZsUZoxQNbsyuQwwbV6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077470; c=relaxed/simple;
	bh=gh+TrPhyFiD1u6AmL0oc7wiBTl6k8FPlcuQEuF8Jdkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir1P2uhx7vJ+p8p0mYEC3gEleokHwLSqUb8rus4J+ruNB/Q7JGvFhDMv8DQ6P7kmbFrnLm4UOh7VfIKvTq+Eaof9VF0rCs8Ow9sDJhRwzkofxQ5hOX24rh49LJ4puwWKKtiK7rOvUYMMzyNdUWZTyoQIO1HF+KRPN7/fTENvYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945D812FC;
	Wed, 13 Aug 2025 02:30:59 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3A6C3F63F;
	Wed, 13 Aug 2025 02:31:04 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:30:33 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Prashant Malani <pmalani@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com,
	Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: CPPC: Fix error handling in
 cppc_scale_freq_workfn()
Message-ID: <aJxbOSMLWyTporw1@arm.com>
References: <20250730032312.167062-1-yubowen8@huawei.com>
 <20250730032312.167062-3-yubowen8@huawei.com>
 <20250730063930.cercfcpjwnfbnskj@vireshk-i7>
 <CAFivqmLkLn-92rMow+c7iEADCdh3-DEapVmtB_Qwk1a2JrwwWw@mail.gmail.com>
 <9041c44e-b81a-879d-90cd-3ad0e8992c6c@hisilicon.com>
 <CAFivqmLr_0BDkMhD4o6box3k9ouKek8pnY7aHX36h1Q9TaT_HA@mail.gmail.com>
 <7a9030d0-e758-4d11-11aa-d694edaa79a0@hisilicon.com>
 <CAFivqmJyYJ+d+TH4qYBKf_5t-AqWZuzgk2H_4nHmynTjoUHnYQ@mail.gmail.com>
 <CAFivqm+4Mir8hgGw-HMLdW=dBYuUw1wJ4xG4a+WAtqfG1vYKXQ@mail.gmail.com>
 <8aa1efad-8f30-9548-259a-09fccb9da48a@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa1efad-8f30-9548-259a-09fccb9da48a@hisilicon.com>

On Wed, Aug 13, 2025 at 03:15:12PM +0800, Jie Zhan wrote:
> 
> 
> On 05/08/2025 12:58, Prashant Malani wrote:
> > On Mon, 4 Aug 2025 at 18:12, Prashant Malani <pmalani@google.com> wrote:
> >>
> >> On Sun, 3 Aug 2025 at 23:21, Jie Zhan <zhanjie9@hisilicon.com> wrote
> >>> On 01/08/2025 16:58, Prashant Malani wrote:
> >>>> This begs the question: why is this work function being scheduled
> >>>> for CPUs that are in reset or offline/powered-down at all?
> >>>> IANAE but it sounds like it would be better to add logic to ensure this
> >>>> work function doesn't get scheduled/executed for CPUs that
> >>>> are truly offline/powered-down or in reset.
> >>> Yeah good question.  We may discuss that on your thread.
> >>
> >> OK.
> >> Quickly looking around, it sounds having in the CPPC tick function [1]
> >> might be a better option (one probably doesn't want to lift it beyond the
> >> CPPC layer, since other drivers might have different behaviour).
> >> One can add a cpu_online/cpu_enabled check there.
> > 
> > Fixed link:
> > [1] https://elixir.bootlin.com/linux/v6.13/source/drivers/cpufreq/cppc_cpufreq.c#L125
> I don't think a cpu_online/cpu_enabled check there would help.
> 
> Offlined CPUs don't make cppc_scale_freq_workfn() fail because they won't
> have FIE triggered.  It fails from accessing perf counters on powered-down
> CPUs.
> 
> Perhaps the CPPC FIE needs a bit rework.  AFAICS, FIE is meant to run in
> ticks, but currently the CPPC FIE eventually runs in a thread due to the
> possible PCC path when reading CPC regs I guess.
Just for my benefit: the tick is being fired on a given CPU which is when an
irq_work is being queued. Then before this goes through the kworker and finally
ends up in 'cppc_scale_freq_workfn' that CPU is entering a deeper idle state ?
Could the cppc driver register for pm notifications and cancel any pending work
for a CPU that is actually going down, directly or by setting some flag or smth
so that the final worker function is either not triggered or knows it has to
bail out early ?
(Note this is a rough idea and needs verification)

---
BR
Beata

