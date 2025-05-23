Return-Path: <linux-pm+bounces-27596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FFAC27E4
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B58A1C02878
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9C296FAB;
	Fri, 23 May 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h+vcnRi4"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01466296D0A;
	Fri, 23 May 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018964; cv=none; b=GP7sAgf2ZBcq+Q/GwmGbA7A5A88nYuBj9dILHvByB+f64FhLOS5w7MaSgKqLsjAWm9WYwuWw0hnSr9Cn5EvPtreTd38OT42ueJTRGUQ/8SsRatWoR1Ih7RdcRAvGu7y8g76cMfZo59Ro568LBF1xhumvA0cRu8Wa13eJ24oBZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018964; c=relaxed/simple;
	bh=dwZR3h0kNzHTXgqSTLC2GeZq5RQwYLhYMq6bDq7EtAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om87JhtqrqHWf3xKSPXq3i3ImZLOrTdjMbAbFLoQLK3aprBqJIT3ofprkPE1C2uTPWXHKdCeJ2yzZPiFuYV2+Dd5MCJmfeqREamd5+hTCVDFQCJdCyNXQyy25NNrlt+/m4jl9LTLUjtcxZzQL5jprki2Fo68MbGRAhqzID0wbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h+vcnRi4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5D+QdkGuk6pymafQzVxGqYS5fsweVo7+R4WrKpUIjyQ=; b=h+vcnRi4fWFXIGX7hMbz4moAku
	4vGz5RIW0bAK+A/UFrs5dNE0bqvkkTXrzA7dQozeON+t+RP+aTCdNNefgOE1OZQMso5zmnMU/lpZ+
	4fFh4Lqz13hk7bdzlF7SMo4EK04jdLxlkR4iDMwWbR8cpjc6Dlqo+JFowzj4bK5FP0SCdETC17lVF
	ackwTBOJBjZJtc1XagWnUROBeFr40fpv/vqyqgO/k063lZKrp+47K4/Uk+ZyO9jknJFzFl5BRdZgq
	MG6k77IEkUbAiMRQzQJDgJJyLA0UM0tIu8qbkThXjDXK4bvr94nSPVl+b41wklOtpUhtch6T5fiLF
	vANxM0+g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uIVa7-00000001M3T-1w37;
	Fri, 23 May 2025 16:49:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 03BDD300472; Fri, 23 May 2025 18:49:15 +0200 (CEST)
Date: Fri, 23 May 2025 18:49:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <20250523164914.GO39944@noisy.programming.kicks-ass.net>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523164348.GN39944@noisy.programming.kicks-ass.net>

On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:
> 
> Due to the weird Makefile setup of sched the various files do not
> compile as stand alone units. The new generation of editors are trying
> to do just this -- mostly to offer fancy things like completions but
> also better syntax highlighting and code navigation.

To be fair, by far the biggest help has turned out to be to get instant
compiler warning/fails while you type code. This has drastically reduced
the stupid typo, doesn't compile, try again cycle.

Code completion is 'cute' but I'm not really limited in typing speed,
getting pop-up function arguments while typing is useful.

The better code navigation is also very useful.

