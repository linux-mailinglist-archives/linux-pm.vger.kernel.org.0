Return-Path: <linux-pm+bounces-35738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70CBBE815
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 17:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B3DC4E50C7
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476282D876A;
	Mon,  6 Oct 2025 15:36:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CEA2D8396;
	Mon,  6 Oct 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764973; cv=none; b=Xc9746Qv/4Q574Ymvgq9s9bynpTjMTYJy1M+XeB2bndPZaTcLvk5YQIpFcrH80/Axhzf7PBgm3PcC37E2KAmc7WWlTW6YP3pkwHkUM80WEUPNTFv43GCbqh6+3spOsn9vSs/Enf1+ryF2WjUNSIzcom4gn6Tk7vzvJMcNCbzRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764973; c=relaxed/simple;
	bh=44RVQaJnBFDnVRoOSLJmX0a1UZTl6kzUIy/IPi8csoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlgxgmjDS2EtIc+orEgQ3T7mVoG/8/z0w8C7gmeh0EPwzu7MgfbAbzz4VbqX79IcGNoxz56UXl51u0QQxbkNJvEBFU0vCb2d8A2YxAVOKSWOv8tURZnI5ux5Eve1DrLYfxgifb3JAU+uhk+LsUA9+3gG4G8C9lOjjI97xo5bmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D35B1515;
	Mon,  6 Oct 2025 08:36:03 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6803F66E;
	Mon,  6 Oct 2025 08:36:08 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:36:06 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] pmdomain: Improve idlestate selection for CPUs
Message-ID: <20251006-barnacle-of-pragmatic-faith-e6ca0d@sudeepholla>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003150251.520624-1-ulf.hansson@linaro.org>

On Fri, Oct 03, 2025 at 05:02:42PM +0200, Ulf Hansson wrote:
> Platforms using the genpd governor for CPUs are relying on it to find the most
> optimal idlestate for a group of CPUs. Although, observations tells us that
> there are some significant improvement that can be made around this.
> 
> These improvement are based upon allowing us to take pending IPIs into account
> for the group of CPUs that the genpd governor is in control of. If there is
> pending IPI for any of these CPUs, we should not request an idlestate that
> affects the group, but rather pick a shallower state that affects only the CPU.
>

Thinking about this further, I’m not sure this issue is really specific to
pmdomain. In my view, the proposed solution could apply equally well to
platforms that don’t use pmdomain for cpuidle. Also, I don’t see why the
solution needs to be architecture-specific.

Thoughts ?

I understand it won’t handle all IPI cases, but generic helpers like
local_softirq_pending() and irq_work_needs_cpu()
should already cover some of them in a platform-independent way.

-- 
Regards,
Sudeep

