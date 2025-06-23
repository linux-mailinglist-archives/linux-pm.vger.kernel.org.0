Return-Path: <linux-pm+bounces-29415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B3AE5806
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 01:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661474C604B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 23:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AABB1624C5;
	Mon, 23 Jun 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TVwvL7+C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5AEA95C
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721430; cv=none; b=OYgYV5a0yClrz+OOCQZhmnkx/cyuhSVBirUbKmnogT9WJkBpl+z71Sao0oBa284ZywsVzieoDIJ6JTlCyWVM88W6rnMz1UCYwubD92cPPleyqFmZdWjDkHLiUVsh4R4nszA1AqopOz635UE/Nash2O81xemzIbf9KuXNmWTLw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721430; c=relaxed/simple;
	bh=+pzksmTU21a14H+AoU855eBMzjvNfwKGmzqegPCUfz0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rlC4LooBs3ipvfzLW/1huqQ3UZmt6+74Fk7aziaKe03Mf1RpdToWVpW2TDFgj7dqLA5laiLzuH1ibTHfBSd3JqTJk4QPTlgwXe/WnnkaDuu4MibhR1eZitSRGAFMcpPwtR1rQI3OjMF0tWU3eD7S8t4mXLlvxF3kmUhe60mnRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TVwvL7+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B876C4CEEA;
	Mon, 23 Jun 2025 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750721429;
	bh=+pzksmTU21a14H+AoU855eBMzjvNfwKGmzqegPCUfz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TVwvL7+CH+emFOPEcbSmexDp/bxZo2WpXF5IM4MfNkGpXDwP605gweI/1ro7UCa1c
	 t/pom6YA4zRP6ewjo5XoW4mwESp6bzj9oABc5VQsNe0EaH5chClFNnipA0F/fNs+/L
	 DDZfxz+HnvEKeEq+ndtaRhHGHPXXO2JcQiq5uPyk=
Date: Mon, 23 Jun 2025 16:30:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <dianders@chromium.org>,
 <sumit.garg@linaro.org>, <kernelfans@gmail.com>,
 <lecopzer.chen@mediatek.com>, <tglx@linutronix.de>, <song@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>,
 <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
 <yangyicong@hisilicon.com>, <linuxarm@huawei.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-pm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/2] Update the watchdog period according to
 real CPU frequency
Message-Id: <20250623163028.1914d7ec909eb9bfc1daa666@linux-foundation.org>
In-Reply-To: <20250619114805.16968-1-yangyicong@huawei.com>
References: <20250619114805.16968-1-yangyicong@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 19:48:03 +0800 Yicong Yang <yangyicong@huawei.com> wrote:

> watchdog perf needs architecture to provide method for converting the watchdog
> thresh to counter period. For arm64 we're using the max CPU frequency for
> doing the conversion which is from cpufreq driver. But some cpufreq driver
> are registered lately, for example cppc_cpufreq will be registered at late
> initcall which is after the initialization of watchdog perf (initialized in
> armv8_pmuv3 of device initcall). In such case the period of watchdog will not
> be accurate enough. Fix this by registering a cpufreq notifier and update the
> watchdog period once the cpufreq driver is initialized.

Great, thanks.  I'll add these to mm.git for testing.

> arch/arm64/kernel/watchdog_hld.c | 58 ++++++++++++++++++++++++++++++++
> include/linux/nmi.h              |  2 ++
> kernel/watchdog_perf.c           | 23 +++++++++++++

This is not exactly my comfort zone so additional review would be
appreciated, please.  Even though it doesn't touch drivers/cpufreq,
perhaps the developers over there could take a look?

