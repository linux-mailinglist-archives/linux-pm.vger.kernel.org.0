Return-Path: <linux-pm+bounces-34627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D125FB57183
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 09:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5442F18915EE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20557279784;
	Mon, 15 Sep 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="J3gk/IUn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F71F4174;
	Mon, 15 Sep 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921430; cv=none; b=u7SO5+t2xEUMURg54uz4nNAigtUwXHHdrWY/Jn2YexNZZNbKFWPNqeoc5mb0/z0mdYqTvxXSqHmUfA0YYiHq0YKlWRtpX4sf3fTxJEXtTUIDNtVYhZQLLk7JK9Xsxi42BaKyGatyyVHfo1SNWFU9LDKcMTyphnnQqiFtNzJ5Y74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921430; c=relaxed/simple;
	bh=XcH7i1NU1nkQKzNcmQPjDrqXYBVW64HelzyptMyKuVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdDyFPnjrhg1eW8m+OYx+CeITy2BLCtXzUM2owPZiYJPVOHsxqR7HNP3nvR/+7oM4UUtqGlxjq8d9Wb5gOJh1NREyZTNYbekUPvpClYX2Fj6D19sZtgS2AxCoYQOfkEU66/Xpd2TAvlh3Njk1PqpNrf2WMQ8kzzy/qnCy50rWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=J3gk/IUn; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=iiG+4BPtqocqvD5BfQ1WbBJoY22xYm8SxsvFP5Qb9Pk=;
	b=J3gk/IUnjqDdVtZ1I9NEOZQysOSsqYMikjXTU/ngPgIunKH+pNW7fHmAmMpX/T
	WyvWE5WUjMZqcIoAPbyW6U0PW9HMw6zWQF2JC203DUyiTL+VQ+X9/XMyvEPR6FxB
	JqC2ZCqC8PXET/hu0thZQ6CnKtDpeRe75Shg6UBSQtAUc=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgC3dW9CwMdoe7d5BA--.6943S3;
	Mon, 15 Sep 2025 15:29:07 +0800 (CST)
Date: Mon, 15 Sep 2025 15:29:05 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
Message-ID: <aMfAQXE4sRjru9I_@dragon>
References: <20250910065312.176934-1-shawnguo2@yeah.net>
 <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
 <aMQbIu5QNvPoAsSF@dragon>
 <20250914174326.i7nqmrzjtjq7kpqm@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914174326.i7nqmrzjtjq7kpqm@airbuntu>
X-CM-TRANSID:M88vCgC3dW9CwMdoe7d5BA--.6943S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw43JF1UAw4rXr17Xry3CFg_yoW8Cw43pF
	WUu3y2y34kWa1Dtws2ya18u3WFvan8J3yjkFyUurnYvwsxJ3WYg3WUGa1UAFZ8A3ykG3Wq
	qr1Ut39rXF4jkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uz6wZUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIARNsmjHwEQhQAAA3R

On Sun, Sep 14, 2025 at 06:43:26PM +0100, Qais Yousef wrote:
> > > Why do you want to address the issue in the cpufreq core instead of
> > > doing that in the cpufreq-dt driver?
> > 
> > My intuition was to fix the regression at where the regression was
> > introduced by recovering the code behavior.
> 
> Isn't the right fix here is at the driver level still? We can only give drivers
> what they ask for. If they ask for something wrong and result in something
> wrong, it is still their fault, no?

I'm not sure.  The cpufreq-dt driver is following suggestion to use
CPUFREQ_ETERNAL, which has the implication that core will figure out
a reasonable default value for platforms where the latency is unknown.
And that was exactly the situation before the regression.  How does it
become the fault of cpufreq-dt driver?

> Alternatively maybe we can add special handling for CPUFREQ_ETERNAL value,
> though I'd suggest to return 1ms (similar to the case of value being 0). Maybe
> we can redefine CPUFREQ_ETERNAL to be 0, but not sure if this can have side
> effects.

Changing CPUFREQ_ETERNAL to 0 looks so risky to me.  What about adding
an explicit check for CPUFREQ_ETERNAL?

---8<---

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..053f3a0288bc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -549,11 +549,15 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
        if (policy->transition_delay_us)
                return policy->transition_delay_us;
 
+       if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
+               goto default_delay;
+
        latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
        if (latency)
                /* Give a 50% breathing room between updates */
                return latency + (latency >> 1);
 
+default_delay:
        return USEC_PER_MSEC;
 }
 EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);

--->8---

Shawn


