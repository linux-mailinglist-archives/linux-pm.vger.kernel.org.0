Return-Path: <linux-pm+bounces-32615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B744B2BD6C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A134E5920
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E0272E5E;
	Tue, 19 Aug 2025 09:29:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85649620;
	Tue, 19 Aug 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595744; cv=none; b=Ry1blxKnPuBCT9aRPBCmy2w0ww3Xxx4xWfPPwhiEiP1cVN9co3m/NZHMtRe1WPjRZ1gIcmRPVHz1UuBDt6wviZl8m1hv+hqf3eBMyNG/KMyexJPKk3xxoe822CAJEQATmiaFo7IeNMAR79J1GOnzL492RgqSyChCQygWvBwdBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595744; c=relaxed/simple;
	bh=HC67VCKp4weH+jjL5hqx09tRarh00wXR51NIPJTTfzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I80p+a+gI8u9iADDyPXpytIg9kUmPRZGxqFNz4S4RA9rpJ9k9uuo+NBx5Z03R5kTF3/eI9EC+NS55337jYFDaJjnnR+hE6PFFyoZbcvYdnFjN7CiH9Sk2ndnA0bmZ7M3xUrY0piKe9kqIzbWmNe62u1E58V/Oj7Biy9PtWW9MzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E211BD0;
	Tue, 19 Aug 2025 02:28:54 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274AF3F58B;
	Tue, 19 Aug 2025 02:28:59 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:28:38 +0200
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
Message-ID: <aKRDxhirzwEPxaqd@arm.com>
References: <20250730220812.53098-1-pmalani@google.com>
 <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>

On Tue, Aug 05, 2025 at 06:00:09PM -0700, Prashant Malani wrote:
> Thanks Yang,
> 
> On Tue, 5 Aug 2025 at 17:26, Yang Shi <yang@os.amperecomputing.com> wrote:
> > Thank you for cc'ing me the patch. I posted the similar patch ago and
> > had some discussion on the mailing list. Then someone else from ARM
> > pursued a different way to solve it. But I didn't follow very closely.
> > If I remember correctly, a new sysfs interface, called cpuinfo_avg_freq
> > was added. It should be the preferred way to get cpu frequency. Please
> > see
> > https://github.com/torvalds/linux/commit/fbb4a4759b541d09ebb8e391d5fa7f9a5a0cad61.
> >
> > Added Beata Michalska in the loop too, who is the author of the patch.
> > Please feel free to correct me, if I'm wrong.
> 
> Thanks for the additional context. Yeah, the issue is that :
> - The new sysfs node is sampling period is too long (20ms) [1]
> That makes it problematic for userspace use cases, so we need something
> which takes less time.
That actually specifies the duration, for which the most recently acquired
sample is considered valid. Sampling is tick-based.

> - The central accuracy issue behind cpuinfo_cur_freq still needs to be handled.
I'd really discourage increasing the sampling period for cppc.

---
BR
Beata
> 
> [1] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/kernel/topology.c#L283
> 
> 
> -- 
> -Prashant

