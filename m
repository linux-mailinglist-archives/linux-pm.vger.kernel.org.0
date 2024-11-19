Return-Path: <linux-pm+bounces-17767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCC9D2CCC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5AAB2D8CD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E91D14F6;
	Tue, 19 Nov 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQtUNul6"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CAB1D0F79;
	Tue, 19 Nov 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037831; cv=none; b=uBFarg6xVA7G0oW4jdWMtsksj6P7/XoId1toI4bIlwnuOgZB2z9/j1aI8VYLZUwgy5Cc+KCHOC3atz7b7taVQvWJzHZ8jfeJCVptgpt9KvvTqB13DwIlAh5+IME11AeDEsswVRW+SyL7F9EyX8vJpHiYYqiYgR+jqpzmckjwUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037831; c=relaxed/simple;
	bh=HtPAf28dsfHHDGWo7Boz7Y15Y7dn0tgp/x1gbifoOgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN84sIFVue+cSWrqgiu3uZWQY72FFBapODyBSYfkR+qI5j7ey8MbNy/UsUltGY70c3ykNkmH7Otp7kqpefv57/d4KzjPApoGW57nN6XWFdY7/sfAuqL6m4nHXw02pqax2l0GfAvDjFmHUMXmPaDaEyWdTfPIuxSgP741iKpaXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UQtUNul6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fwyRJIcjvMYWUfC0fV4a9N59ppnlFSHGcp1YD7DqRKA=; b=UQtUNul6T8dGBRrT7qW0+k4gUa
	is9XediJAqDoOIcvG/Rg0V9vkHdPte5rrxX+L6yTfIuQdG11ksaX+7mMZEmghWxLC7oy1QsB6ly2F
	y+jfRhnJ6yIa0OOqdVUMKLoxVS94wulmsdTUyu4qlS/K5TN2kgtki6JDDjEYPJf/NZ43zHKSEl2WR
	ArCs+Iay1dd6pAHhbvxvMeBc495D/hoFuc5avXpQFgvQTW4l2GZrMqd/HQ1raqWCg8fVJXoOM64dS
	LDThf9Tf//519jZMlYOwH9DqmuDaiPjQTVM81GyjOiJf6Z3wZrbg58Hxcz0/kcUaDRyiUgCeeLuUX
	BB8bxYRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDS9u-00000004Lwj-31MQ;
	Tue, 19 Nov 2024 17:37:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A44333006AB; Tue, 19 Nov 2024 18:37:02 +0100 (CET)
Date: Tue, 19 Nov 2024 18:37:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC][PATCH v0.1 5/6] sched/topology: Allow .setpolicy() cpufreq
 drivers to enable EAS
Message-ID: <20241119173702.GA27509@noisy.programming.kicks-ass.net>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
 <1889415.atdPhlSkOF@rjwysocki.net>
 <64a63f1c-088d-43dc-85c3-cecf8b59764f@arm.com>
 <CAJZ5v0hrj0jQ9mi20XRK3bTfaMDgUS3HyGnk=2x0UfF26jN1pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hrj0jQ9mi20XRK3bTfaMDgUS3HyGnk=2x0UfF26jN1pQ@mail.gmail.com>

On Mon, Nov 11, 2024 at 02:54:43PM +0100, Rafael J. Wysocki wrote:

> Or what about ondemand?  Is it alway completely broken with EAS?

I thought that thing was mostly considered broken anyway :-)

> > For plain (non-intel_pstate) powersave and performance we could replace
> > sugov_effective_cpu_perf()
> > that determines the OPP of the perf-domain by the OPP they will be
> > choosing, but for the rest?
> 
> I generally think that depending on schedutil for EAS is a mistake.

Well, the thinking was that we wanted to move to a single governor, and
not proliferate things.


