Return-Path: <linux-pm+bounces-40021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6059CE8470
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 23:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9015030021DD
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F652274FF5;
	Mon, 29 Dec 2025 22:12:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9E82C2372
	for <linux-pm@vger.kernel.org>; Mon, 29 Dec 2025 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767046334; cv=none; b=rXC3MReVRIA+tbpmEHD2oCrUGVYZ3IY5CNNU0LXry3F2JWMU4jKrtZuX9f/2uruazvqI/Qd2uNQsD6RCRCeHMvGKk2kTL37C8XWpHQx5eX0dlsRlwZtg3d3c6bkgXKRQql6PSdwmG+DQTlI7iTPIsdNh95wpIrHSbnALxmgHeT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767046334; c=relaxed/simple;
	bh=Q97l49UMcLW/9HbN7nVb7C9OE3vu87fPNbVab3j4xoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eseeDKXebdPmsqWhcQ6cvquoQHh/vq/QKKov84heOx2+SkjoozzKuv4CQISHHjX2YwvA18loOXCdR5/+ir2OqqSoXQm4U8ObJdA2y66F8JoVaae77DamTXrvk08n33CPbqw6nUMu0o05GdBGI2M1XEox302Zri0tDHs3xBrJ3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFEB4497;
	Mon, 29 Dec 2025 14:12:02 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBCC23F694;
	Mon, 29 Dec 2025 14:12:04 -0800 (PST)
Date: Mon, 29 Dec 2025 23:12:06 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
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
Message-ID: <aVL8tp7k1ne9DWSX@arm.com>
References: <20251119081356.2495290-1-zhenglifeng1@huawei.com>
 <aS2z0EURwHbbGZab@arm.com>
 <9b6882dc-a91a-42d6-bf76-347338930d71@huawei.com>
 <aS8GZOuaS1-j14MD@arm.com>
 <29253319-ced9-4ab6-a58e-28afdf235cde@huawei.com>
 <aTx2V4am0FNHm03R@google.com>
 <62ad0257-aa50-4ab6-bd46-64c3963e4b94@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ad0257-aa50-4ab6-bd46-64c3963e4b94@huawei.com>

On Sat, Dec 20, 2025 at 05:09:52PM +0800, zhenglifeng (A) wrote:
> On 2025/12/13 4:08, Will Deacon wrote:
> > On Fri, Dec 12, 2025 at 05:27:09PM +0800, zhenglifeng (A) wrote:
> >> On 2025/12/2 23:31, Beata Michalska wrote:
> >>> On Tue, Dec 02, 2025 at 11:05:25AM +0800, zhenglifeng (A) wrote:
> >>>> On 2025/12/1 23:27, Beata Michalska wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Apologies for the delay in reviewing this - currently in progress....
> >>>>> Out of curiosity: what's the cpufreq driver used for testing this series ?
> >>>>
> >>>> I used cppc_cpufreq for testing this. But with some modifications in
> >>>> processor_driver.c, or you'll find that the driver will fail to load with
> >>>> maxcpus set. The modification below is only a temporary solution. I'm still
> >>>> working on that.
> >>>>
> >>> Right, so overall the implementation looks good - thanks for that.
> >>> There are two issues though with the cppc cpufreq driver.
> >>>
> >>> One: as you have already noticed - it fails to register when
> >>> cpumask_present != cpumask_online.
> >>>
> >>> Second: it will mix the sources of the freq scale if not all CPUs within the
> >>> policy have AMUs enabled/valid. This is due to the fact that at the time of
> >>> registering the driver and initializing the FIE support policy->cpus ==
> >>> policy->related_cpus. Assuming scenario when there are two CPUs within the
> >>> policy, one being offline and missing valid AMU counters,
> >>> the topology_set_scale_freq_source from cppc cpufreq driver will register
> >>> the tick handler for both CPUs, whereas AMU support will (rightly so) register
> >>> only for the firs one. When the second CPU comes online, the mismatch will be
> >>> detected and the arch callback will get cleared for the first CPU, but the
> >>> second one will remain unchanged.
> >>>
> >>> That said, I do not think any of those issues is a blocker for this series.
> >>> But both would need fixing.
> >>
> >> I believe Beata is OK with this series. So I think we can move ahead with it
> >> now.
> > 
> > Please repost at -rc1. It would be nice to have an Ack from Beata...
> 
> Hi Beata,
> 
> It would be nice if you could give this patch an Ack.
> 
> Thanks.
> 
Apologies, 've been away.

Acked-by: Beata Michalska <beata.michalska@arm.com>

---
BR
Beata
> > 
> > Will
> > 
> 

