Return-Path: <linux-pm+bounces-32251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F185FB246DE
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536841629AE
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701D1A76BC;
	Wed, 13 Aug 2025 10:13:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18A212541;
	Wed, 13 Aug 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079989; cv=none; b=g0LsyXRY8QODtav16EwE9Og11Y0m4mYtMQD1JQOj7fpL7i0hWR4S5GAZrSFyrCYnYjAdRQO1H7Z9Os+/xFPsgsuX7ut3aQcJdgf0ssjqsjoQruaeDOOqM1rSHM4i+vzb2NLomV9DXE9q3UrmNClpik2v0E9hX3rQ79wiAN+zfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079989; c=relaxed/simple;
	bh=+xvILMHL32EhZ50Fy4U37GodG1a5YsmYb0EwVO6M4uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmXuGhaPR0glcBfe/fRjJ3bpaLNBjsCd9kPv6u+IP+c64jtA56BxXqKDRAWAf29MDsIyrvHM2qdPcFAT8PfeZUSKByasQ3HWsMTjw5wp2HcWnU9Zuay65cI65ompjjOnck3GPxOxtbIFQpmDX1k7Z3rQULPBT7TSaac7WqFmXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3059112FC;
	Wed, 13 Aug 2025 03:12:59 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459E53F5A1;
	Wed, 13 Aug 2025 03:13:03 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:12:39 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Prashant Malani <pmalani@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
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
Message-ID: <aJxlF882pPDy5uf9@arm.com>
References: <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
 <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
 <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>
 <aJo5vP_mfBn_vxSF@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJo5vP_mfBn_vxSF@google.com>

On Mon, Aug 11, 2025 at 06:43:08PM +0000, Prashant Malani wrote:
> On Aug 11 11:35, Viresh Kumar wrote:
> > On 06-08-25, 17:19, Prashant Malani wrote:
> > > So, do we have consensus that the idle check is acceptable as proposed?
> > > (Just want to make sure this thread doesn't get lost given another thread
> > > has forked off in this conversation).
> > 
> > I don't have any objections to this or a better solution to this.
> 
> Thanks Viresh! Beata, can we kindly move ahead with the idle
> optimization (which is this series), while we continue discussions for
> the "under load" scenarios on the other thread?
> 
> BR,
I'd say yes, as long as you get a green light on exporting `idle_cpu`.

---
BR
Beata

