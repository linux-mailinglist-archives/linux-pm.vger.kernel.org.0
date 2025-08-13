Return-Path: <linux-pm+bounces-32252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AACB246E6
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A0694E138C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3C2D6E4A;
	Wed, 13 Aug 2025 10:15:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085623D7D3;
	Wed, 13 Aug 2025 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080145; cv=none; b=Xd1LuKAXTPBMAqwbU9jOE+DmKu4pwv6fUHmTZiy63CXoMHhOBNA/28Eq6F5o9y8pQHk+nP4P0HqobXexXYBCWhRm3Mxz5/bllF/CRHZtnyYcFpD81GxN++4HlEWHmLVAuA1TBbNOcbjxtg4J/2qvF+1SS5/eu5ueq2NwnjbdUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080145; c=relaxed/simple;
	bh=ZluH6uhX2B/02Winvt1DG5yfLXuMX01kxN6jfx2fzOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/GOcw6igeXMJ594cYKnvNBoHxL/H3SZMzbQks7F8dDKOAQkNPyAJ/QcVYH8Q4vBlff4Yxvc/zFgCucov3PA72IyiIGox9dDhUnYByxwCvY7S9qeozU84my+G7M6enqO2Sf/SIb1YvzEhs8RKfL5ilAzqu/gTo5DL9T93eXQvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C21B12FC;
	Wed, 13 Aug 2025 03:15:35 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D59D93F5A1;
	Wed, 13 Aug 2025 03:15:39 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:15:24 +0200
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
Message-ID: <aJxlvMFD2hHaKdoK@arm.com>
References: <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com>
 <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
 <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
 <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
 <aJMCgGt5zu5Dhrd5@arm.com>
 <CAFivqmLSp6RwfsPBK0d=zvRd6M_5GoeU4jHb-0OM9BpaDeSrzA@mail.gmail.com>
 <aJR-4J-sTpLaNIJB@arm.com>
 <aJVdjwU-qkdDIXaD@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJVdjwU-qkdDIXaD@google.com>

On Fri, Aug 08, 2025 at 02:14:39AM +0000, Prashant Malani wrote:
> Hi Beata,
> 
> On Aug 07 12:24, Beata Michalska wrote:
> > Right .... that's what happens when you are (I am) making last minute clean up.
> > That should fix it. Would you mind giving it another go ? Would appreciate it.
> > 
> > ---
> > BR
> > Beata
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 65adb78a9a87..2a51e93fcd6c 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -543,7 +543,7 @@ void counters_burst_read_on_cpu(void *arg)
> >  
> >  static inline bool cpc_reg_supported(struct cpc_reg *reg)
> >  {
> > -       return !((u64)reg->address != 0x0 || (u64)reg->address != 0x1);
> > +       return !((u64)reg->address != 0x0 && (u64)reg->address != 0x1);
> >  }
> 
> Here are the measurements with the fix:
> 
> The readings are less accurate. There are some which report
> 3.4 GHz (as earlier) but many are off:
> 
> t0: del:77500009084, ref:22804739600
> t1: del:77500020316, ref:22804743100
> ref_perf:10
> delivered_perf:32
> 
> t0: del:77910203848, ref:22941794740
> t1: del:77910215594, ref:22941798070
> ref_perf:10
> delivered_perf:35
> 
> t0: del:77354782419, ref:22762276000
> t1: del:77354793991, ref:22762279400
> ref_perf:10
> delivered_perf:34
> 
> t0: del:64470686034, ref:22998377620
> t1: del:64470695313, ref:22998380880
> ref_perf:10
> delivered_perf:28
> 
> t0: del:78019898424, ref:22957940640
> t1: del:78019912872, ref:22957944590
> ref_perf:10
> delivered_perf:36
> 
> Best regards,
> 
> -Prashant
Ok, that's not really good.
Any chances on sharing which platform are you using ?
Remote debugging tends to be rather painful.

---
(Note: I will be off for couple of days so please bear with me)

BR
Beata

