Return-Path: <linux-pm+bounces-13015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDEB961F9C
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 08:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D742828F0
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBE157A41;
	Wed, 28 Aug 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5JBcicM"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7B15748A
	for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826059; cv=none; b=ox58agj+rDqjBtHmmOqtyCib3ig5WzAi3GjyFZu4dSrBiAnCgkxzxjiTbuIsiEQjUaqclTMqYDjCqcScA5Xzhe4I2aowGAQucPWg0MYnDnnHcLp/SvuZBZT9s4fWUC96ZSOEElZDCUFC4xI7LE8ETic2atIiVMcA9F6TirqUn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826059; c=relaxed/simple;
	bh=BKH7OF1gA2x1K6IrgePa4gqJRi2S42CGQlhI+AR8RtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAAQBu2xTnWV2NanoKfFMdVVPyYhWyZUhNE/XT6vArYC1QnH3/aXM0F1SjP5+3fUXH7hSpIcJPkF5Fmqf+zj34O+g51CEqhlImLGherp+7vdGg4C8qTISFTr1WJAH9qJG0l+teMhNBrZCIaOJxPq8PjwpNdPHFmnLfHBGi0TC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5JBcicM; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 08:20:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724826054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8q1Gi+Mka1ahs9vBttQhPLSdr4CoV1oo9//xJxqIxK0=;
	b=C5JBcicMXP+ekim+JfFPPTW5oRRPC2m8lNl20GLSZd2OS+GFTDyVo5yIbhf3J6y4GYx3Q5
	srSM1FQJybPu7VAp6wRF1o4vGjigRWaPff8zOV7Mck0Xqp6pzFT9tbQTTCHg9pkXKiMDcW
	11KKoPT24fCV8aMrTtsAa+cQNwVcTlM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	changwoo@igalia.com, David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 8/8] cpufreq: amd-pstate: Drop some uses of
 cpudata->hw_prefcore
Message-ID: <Zs7Bwh6T3HCGlR9C@gpd3>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-9-superm1@kernel.org>
 <Zs4G084+7MmzdYjU@BLRRASHENOY1.amd.com>
 <61b96549-2969-4b64-a40d-f91f614ec3ab@amd.com>
 <Zs6w3RktAb6fJrJ+@BLRRASHENOY1.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs6w3RktAb6fJrJ+@BLRRASHENOY1.amd.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 10:38:45AM +0530, Gautham R. Shenoy wrote:
...
> > I had thought this was a malfunction in the behavior that it reflected the
> > current status, not the hardware /capability/.
> > 
> > Which one makes more sense for userspace?  In my mind the most likely
> > consumer of this information would be something a sched_ext based userspace
> > scheduler.  They would need to know whether the scheduler was using
> > preferred cores; not whether the hardware supported it.
> 
> The commandline parameter currently impacts only the fair sched-class
> tasks since the preference information gets used only during
> load-balancing.
> 
> IMO, the same should continue with sched-ext, i.e. if the user has
> explicitly disabled prefcore support via commandline, the no sched-ext
> scheduler should use the preference information to make task placement
> decisions. However, I would like to see what the sched-ext folks have
> to say. Adding some of them to the Cc list.

IMHO it makes more sense to reflect the real state of prefcore support
from a "system" perspective, more than a "hardware" perspective, so if
it's disabled via boot command line it should show disabled.

From a user-space scheduler perspective we should be fine either way, as
long as the ABI is clearly documented, since we also have access to
/proc/cmdline and we would be able to figure out if the user has
disabled it via cmdline (however, the preference is still to report the
actual system status).

Question: having prefcore enabled affects also the value of
scaling_max_freq? Like an `lscpu -e`, for example, would show a higher
max frequency for the specific preferred cores? (this is another useful
information from a sched_ext scheduler perspective).

Thanks,
-Andrea

