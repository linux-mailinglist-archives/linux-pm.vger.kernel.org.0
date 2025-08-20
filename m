Return-Path: <linux-pm+bounces-32751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD98B2E6F6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8189A24911
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 20:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990882D3739;
	Wed, 20 Aug 2025 20:49:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83E202F93;
	Wed, 20 Aug 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722973; cv=none; b=JLzh8rLu/w5yNJupEkla7oXgLSnM/Nzj5Ok6l/3pKgEdrsSgb1uU1SHSwkiZRsER8WcLTt3Fpm5nihk4aErOe1Ak2jhm3RUrq8rVNJlKiof8u7sbz6Ktalhmz0t4+kgXncrv0ttS/4zFZdkPQIXFhwo3mgKljy4KwBj0lu83gko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722973; c=relaxed/simple;
	bh=nrpwOSah7pmLtE7EoGA0PDWjj2F6huyxEDKBgLTJkg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLKUKKEATljDzac76SlI2vAKtpYPX3warLNpv/nNaSy4vDc0xD2AmVlICyeEj9WK22oip0s6Tzmk8ZhjB0wkNiwTlIf34/GDIV3tRHwpcqcrBIZxP32M2kfUuW+yCTlqVcr81m+hfoC2y4frmdjGSxilHnQriL1smN5kBUR7smc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ACDB1F37;
	Wed, 20 Aug 2025 13:49:21 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94CF73F63F;
	Wed, 20 Aug 2025 13:49:26 -0700 (PDT)
Date: Wed, 20 Aug 2025 22:49:10 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Prashant Malani <pmalani@google.com>
Cc: Yang Shi <yang@os.amperecomputing.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
Message-ID: <aKY0xuegI1S4X2uW@arm.com>
References: <20250730220812.53098-1-pmalani@google.com>
 <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
 <aKRDxhirzwEPxaqd@arm.com>
 <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>

On Tue, Aug 19, 2025 at 04:43:59PM -0700, Prashant Malani wrote:
> On Tue, 19 Aug 2025 at 02:29, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > On Tue, Aug 05, 2025 at 06:00:09PM -0700, Prashant Malani wrote:
> > > Thanks Yang,
> > >
> > > On Tue, 5 Aug 2025 at 17:26, Yang Shi <yang@os.amperecomputing.com> wrote:
> > > > Thank you for cc'ing me the patch. I posted the similar patch ago and
> > > > had some discussion on the mailing list. Then someone else from ARM
> > > > pursued a different way to solve it. But I didn't follow very closely.
> > > > If I remember correctly, a new sysfs interface, called cpuinfo_avg_freq
> > > > was added. It should be the preferred way to get cpu frequency. Please
> > > > see
> > > > https://github.com/torvalds/linux/commit/fbb4a4759b541d09ebb8e391d5fa7f9a5a0cad61.
> > > >
> > > > Added Beata Michalska in the loop too, who is the author of the patch.
> > > > Please feel free to correct me, if I'm wrong.
> > >
> > > Thanks for the additional context. Yeah, the issue is that :
> > > - The new sysfs node is sampling period is too long (20ms) [1]
> > > That makes it problematic for userspace use cases, so we need something
> > > which takes less time.
> > That actually specifies the duration, for which the most recently acquired
> > sample is considered valid. Sampling is tick-based.
> 
> Thanks for the correction. I made an error in understanding the code.
> 
> >
> > > - The central accuracy issue behind cpuinfo_cur_freq still needs to be handled.
> > I'd really discourage increasing the sampling period for cppc.
> 
> The only true solution is to make the register reads (ref + delivered
> combined) atomic.
> We see that this solves the issue when conducting the same
> measurements on firmware
> (which is an RTOS, so no scheduler randomness).
Kinda working on that one.
> 
> Outside of that, I can't think of another mitigation beyond adding delay to make
> the time deltas not matter so much.
I'm not entirely sure what 'so much' means in this context.
How one would quantify whether the added delay is actually mitigating the issue?

> 
> Perhaps ARM should introduce a "snapshot" feature which takes the snapshot
> of the AMU counters on a register write; IAC that's outside the scope
What do you mean by register write ?
> of this discussion.
> 
> Could you kindly explain why adding the udelay here is discouraged?

Would you mind clarifying how the specific value of 200 µs was determined?
Was it carefully derived from measurements across multiple platforms and
workloads, or simply observed to “work” on one relatively stable setup?

Understanding the basis for choosing that delay will help put the discussion
into the right context.

---
BR
Beata
> 
> Best regards,
> 
> -- 
> -Prashant

