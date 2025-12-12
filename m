Return-Path: <linux-pm+bounces-39475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2415CB9BA2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 21:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 370EE3009577
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 20:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE82D063F;
	Fri, 12 Dec 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXFsLIVY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505B293C4E
	for <linux-pm@vger.kernel.org>; Fri, 12 Dec 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570143; cv=none; b=gHp37m1v6eQ6V1eYdZ9xGlOfHQWFJIl5EEoJtAvJGiBD3pXVJGdLmTOrLW8dXMFpApVJpiuQDtv3EU023uHF5tUsIgSMlUK1KF76NXmH65SIL8tv/ClqNJUxkbtu26aRtwG3zyo+QKCzWLdhUE/XPvwtaqQBf/M1bpTyyREnSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570143; c=relaxed/simple;
	bh=YYMImzrZ+6ZKJx4/H0T7um10BEk1uBLaINM4peWTmaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHL2HpP/Xfh3Pbzsj6KKV0/J0bJ5xjjOLVchv+dSHo6RJHgwh9ozltRNy86XhLAH3cLdOL1wUZtc5VzISO4/xz86NDOcWyekhzlT3+e3h1hKQC6oG4Mud09nZDeBxaHZxr//zvuKonhIWayI1KMcCK9CWsPatM6TKUksLwxy98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXFsLIVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9179C4CEF1;
	Fri, 12 Dec 2025 20:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765570143;
	bh=YYMImzrZ+6ZKJx4/H0T7um10BEk1uBLaINM4peWTmaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXFsLIVYJcYusP2Gb6FtTIV1/ytUmaKR3NTRfaufIx2hH50LC3BWxd5wb0ELal9ux
	 grAZqZGWR0LNamNy2pAdRglzn5xlUUR/lmd1DvzQ/VLN4fx2UxVOehR0s7c7S2nMzG
	 vHlfbiumk2SKA7P4JNzfKf6zeKSc1MZabHp8srjt4qK4WYMuC4D87lJBZGcjJDnXce
	 o3iI54qz/CP0fb2iiXWL+0v9Jm727DVp4Mqe+FwRU1VvZFaMW/9EpiccALwmoYqFSH
	 RJ6vwHZGD5x96rblKNv0r8HUL71B4YkGqbdZ+/SMVyTOCyCXIo3YcsbAfJpIgUTrtV
	 rT3sINvqQ5F8A==
Date: Sat, 13 Dec 2025 05:08:55 +0900
From: Will Deacon <will@kernel.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, Beata Michalska <beata.michalska@arm.com>,
	rafael@kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com,
	gregkh@linuxfoundation.org, dakr@kernel.org,
	ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
	zhangpengjie2@huawei.com, wangzhi12@huawei.com,
	linhongye@h-partners.com
Subject: Re: [PATCH v6 0/3] arm64: topology: Handle AMU FIE setup on CPU
 hotplug
Message-ID: <aTx2V4am0FNHm03R@google.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
 <aS2z0EURwHbbGZab@arm.com>
 <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>
 <aS8GZOuaS1-j14MD@arm.com>
 <29253319-ced9-4ab6-a58e-28afdf235cde@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29253319-ced9-4ab6-a58e-28afdf235cde@huawei.com>

On Fri, Dec 12, 2025 at 05:27:09PM +0800, zhenglifeng (A) wrote:
> On 2025/12/2 23:31, Beata Michalska wrote:
> > On Tue, Dec 02, 2025 at 11:05:25AM +0800, zhenglifeng (A) wrote:
> >> On 2025/12/1 23:27, Beata Michalska wrote:
> >>> Hi,
> >>>
> >>> Apologies for the delay in reviewing this - currently in progress....
> >>> Out of curiosity: what's the cpufreq driver used for testing this series ?
> >>
> >> I used cppc_cpufreq for testing this. But with some modifications in
> >> processor_driver.c, or you'll find that the driver will fail to load with
> >> maxcpus set. The modification below is only a temporary solution. I'm still
> >> working on that.
> >>
> > Right, so overall the implementation looks good - thanks for that.
> > There are two issues though with the cppc cpufreq driver.
> > 
> > One: as you have already noticed - it fails to register when
> > cpumask_present != cpumask_online.
> > 
> > Second: it will mix the sources of the freq scale if not all CPUs within the
> > policy have AMUs enabled/valid. This is due to the fact that at the time of
> > registering the driver and initializing the FIE support policy->cpus ==
> > policy->related_cpus. Assuming scenario when there are two CPUs within the
> > policy, one being offline and missing valid AMU counters,
> > the topology_set_scale_freq_source from cppc cpufreq driver will register
> > the tick handler for both CPUs, whereas AMU support will (rightly so) register
> > only for the firs one. When the second CPU comes online, the mismatch will be
> > detected and the arch callback will get cleared for the first CPU, but the
> > second one will remain unchanged.
> > 
> > That said, I do not think any of those issues is a blocker for this series.
> > But both would need fixing.
> 
> I believe Beata is OK with this series. So I think we can move ahead with it
> now.

Please repost at -rc1. It would be nice to have an Ack from Beata...

Will

