Return-Path: <linux-pm+bounces-35726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E86BBDCDA
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 12:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7D4EA64E
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F674264A86;
	Mon,  6 Oct 2025 10:54:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069B263F4A;
	Mon,  6 Oct 2025 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748074; cv=none; b=BgNysi0acQVbGh+n2hrhCEgy84wYa4MiGLFiPe3FLzNuWmbMvpoho95/161dvXRA2S3elzapv71xi2BIJ0y1xn4X+GztE99q4R0j3bojwyFChBm/tikp6Azl6DRKOT8GZic/jxgnCEPO7lqLyPLfRL2txwqotXLXrAaxoji3VCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748074; c=relaxed/simple;
	bh=v8nLoXgILBKux4dXsSp4ugfNGb2r1Hlq0mhvGU0+0bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBUZ1ziCeptgPI6KakD0Z+0Pe5HlvUljo2Jap7KZ5sdD8unOcOVXN3kuKtN6GHnb2fCXg5OvCasfT3+lXRp/+3JKfGB8+yffUBSKqF0hDSnViy/tksIxzheuxtW+dJcI06xSC/N3gJbmP5k2LRYg+JQowJEiaFBBG/weVtdDu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4198D1515;
	Mon,  6 Oct 2025 03:54:23 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16AF33F66E;
	Mon,  6 Oct 2025 03:54:28 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:54:26 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
Message-ID: <20251006-manipulative-urban-antelope-31101f@sudeepholla>
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003150251.520624-3-ulf.hansson@linaro.org>

On Fri, Oct 03, 2025 at 05:02:44PM +0200, Ulf Hansson wrote:
> To add support for keeping track of whether there may be a pending IPI
> scheduled for a CPU or a group of CPUs, let's implement
> cpus_has_pending_ipi() for arm64.
> 
> Note, the implementation is intentionally lightweight and doesn't use any
> additional lock. This is good enough for cpuidle based decisions.
> 

I’m not completely against this change, but I’d like to discuss a few points
based on my understanding (which might also be incorrect):

1. For systems that don’t use PM domains for idle, wouldn’t this be
   unnecessary? It might be worth making this conditional if we decide to
   proceed.

2. I understand this is intended for the DragonBoard 410c, where the firmware
   can’t be updated. However, ideally, the PSCI firmware should handle checking
   for pending IPIs if that’s important for the platform. The firmware could
   perform this check at the CPU PPU/HW level and prevent entering the
   state if needed.

3. I’m not an expert, but on systems with a large number of CPUs, tracking
   this for idle (which may or may not be enabled) seems a bit excessive,
   especially under heavy load when the system isn’t really idling.

-- 
Regards,
Sudeep

