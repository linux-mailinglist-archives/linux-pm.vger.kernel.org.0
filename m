Return-Path: <linux-pm+bounces-31706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 205D0B1771B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7AA7AB8C8
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292D256C9B;
	Thu, 31 Jul 2025 20:23:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D892A8C1;
	Thu, 31 Jul 2025 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993429; cv=none; b=jeNsTAE6HDaqbuCn5skvPxnBsUB1TvbKNG2kJ3eXCiq5Vuy2m1JYEDSruz956x1wMtFFMxKuDimKExL7uprwVHpZTJhIKeCKD/AbRutD7+m+sR0qWD+ejlIxoEZdx2URp31L+VgrGmIfL4lzO7TlvGNFZH2D+x7u3ATXnTvPS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993429; c=relaxed/simple;
	bh=7T5DkLXsWRQRpO8ffb3B/LzNqgFP/7BQVmMO21vl5Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u66mMoOB/dPgn4Vy6KuGOCMv98JEVJQWGIJUyMBSZTqWvldJ/i7FnTFnQfmInf1oeLJy8TCCzkgKD2CoSiXBpunebNBJEYv+HbdiGdlMmvcXdptzLFay8c8+wx8btnZ8xkLwqXYFxcRYbCita/ImcKXwYNf4CONzzibIbPjnaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A05101A2D;
	Thu, 31 Jul 2025 13:23:37 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9803F5A1;
	Thu, 31 Jul 2025 13:23:39 -0700 (PDT)
Date: Thu, 31 Jul 2025 22:23:24 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prashant Malani <pmalani@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aIvQvLL34br6haQi@arm.com>
References: <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com>
 <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>

On Thu, Jul 31, 2025 at 04:43:24PM +0530, Viresh Kumar wrote:
> On 31-07-25, 10:27, Beata Michalska wrote:
> > I am still wondering whether cpufreq core is not a better suited place for
> > checking whether the CPU is idle. We could potentially try on anther CPU within
> > the policy and if there is none, just provide the last known freq ?
> > 
> > @Viresh: What are your thoughts on that ?
> 
> For other platforms (that' don't have counters to read), I think a call to
> ->get() to get the currently configured frequency is perfectly fine. Isn't it ?
I assume it is. I was just thinking out loud and wasn't suggesting anything
otherwise. The reason why I mentioned that is that getting current frequency
for an idle CPU seems like smth we could potentially optimise away and save some
cycles (fixing other problems on the way, like this one).
But if that's undesired for any reason, it's perfectly fine to stay with
unconditional calls to `->get()'.

---
BR
Beata
> 
> -- 
> viresh

