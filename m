Return-Path: <linux-pm+bounces-40236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB5CF5EE2
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 00:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4866230970A4
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702613009EC;
	Mon,  5 Jan 2026 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6r1S8gA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA917C220
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653958; cv=none; b=WMPLMJrn4pOURYkirkrIrY3ZgBAeGAxMzo9PwxI/AtwkbJkKJEzIqg4Ho7ei709KFene8oPbjZ2UWZqueJ/A6KscGESWSdfXl4XmcbuZFRMgSh9Z3EymGCLxEbLEEqtWzDW2f1Fnp90szN7l9MiVtacpiYGfJuz2zK6WqS0zwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653958; c=relaxed/simple;
	bh=KoxFTUsZ/Of4FpR1fNnDeWRLDtfKACGPbvAGhu6FGEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBtcuPfnQwV6SalKKDU6x7TZ6d05PvUwGx7wDmOG9MiydpOnFDsdxAjwmUeEA7b3P6PQP8ha8DsayRCKcEDhnD1420linfaElXn6y7RTkldtPFgWtexbibiqCZLXnbnIatX7Z1c/+3n86sQa5gu4klgKoC29UZ42c4QuLy6hyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6r1S8gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5315C116D0;
	Mon,  5 Jan 2026 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653957;
	bh=KoxFTUsZ/Of4FpR1fNnDeWRLDtfKACGPbvAGhu6FGEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6r1S8gASfY2AXvWRNoY4CiHm7V+po1rHc5YibaxHnrCtTJsXaq65M0P8eian+XtR
	 ht1uXBS6YFiX5NsVI6KY7vLtAfOZKk47Qv2FPJHMLwFlilqQP1QQPxbvb6WtWua3Ac
	 cbir6th4dO2/4YdQ0mFpmVRRo5CHWh/lYWNh7qjxlHpleVk1XdIgN1QvOEpiMVtwEf
	 7iT1WyywOrC/Sm/0qsJpGXsW8bVsqcggX1aBfmrRBQklSaHkH8Ij5qLl32ih3NXMfI
	 DZZtv6tMun+4se3oAbB2cOPUNk4dlAEk7gKKfsNq6D45LKVBW8MUs28oqfG7I9LOek
	 4kpljl9B4zWxA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	beata.michalska@arm.com,
	ionela.voinescu@arm.com,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linuxarm@huawei.com,
	jonathan.cameron@huawei.com,
	vincent.guittot@linaro.org,
	zhanjie9@hisilicon.com,
	lihuisong@huawei.com,
	yubowen8@huawei.com,
	zhangpengjie2@huawei.com,
	wangzhi12@huawei.com,
	linhongye@h-partners.com
Subject: Re: [PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU hotplug
Date: Mon,  5 Jan 2026 22:58:31 +0000
Message-ID: <176764750971.1449488.16003345808762968197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 19 Nov 2025 16:13:53 +0800, Lifeng Zheng wrote:
> Solve a problem that causes CPUs Setup AMU FIE failed in a corner case,
> even though they're eligible.
> 
> Changelog:
> 
> v6:
> 
> [...]

Applied to arm64 (for-next/cpufreq), thanks!

[1/3] arm64: topology: Skip already covered CPUs when setting freq source
      https://git.kernel.org/arm64/c/af15bc259e26
[2/3] cpufreq: Add new helper function returning cpufreq policy
      https://git.kernel.org/arm64/c/4221504c4328
[3/3] arm64: topology: Handle AMU FIE setup on CPU hotplug
      https://git.kernel.org/arm64/c/6fd9be0b7b2e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

