Return-Path: <linux-pm+bounces-34552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED63B54EC8
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 15:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BF1160CA3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B253043D1;
	Fri, 12 Sep 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hha8BoUA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388C301473;
	Fri, 12 Sep 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682508; cv=none; b=sjNcO0144/QQFWFe9Zc52tAt7yPXVfLHpw2bQaOWiVmithVyTMwVJr0oCquKGWCH2FLBeysWXcu8FYM/0mkktk9iXpCKVWYQUnDTnxos2lSroYT92e0UDm5SJGSo6qaBKSAiDuUYLAVcln5c0QEYffru+lCzAlxtkzAJ3ml5BRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682508; c=relaxed/simple;
	bh=UHuTMZ+qyTbbDwiAALau3tpmWs7+C/GRBXfUMsHKt50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tag8cXN1q2mptx/c7KczMEmWFooGfiw2r2/ABcGh439/OwRVD4Hqcw7Z/lcOGNmA678WDgUeuvORBII+zLsc5HF1PP/UIp3YS7+p5oZhM5NcSqNmRPhQQFVL+yk+i86ITEaLsUEpSdgTf+Of8MSSTjFyCSocM1EqhsCy0llel7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hha8BoUA; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OohjXwdRWXklZTgiotVpN2yjSewFuyJu3XqSDoVVL3E=;
	b=hha8BoUAekuPS1tOtb+LpPMO42rNQykJYDHD341vnOjP6mfM5kikO9eGW974kI
	zWdMFQ5Zcw1VShWC7K4+qztHA/hoOqF0Wk7Rl1jg55yJtT1jkPia/s2YvNc2VIt7
	9Brq9WmwBGNW0viPA6m6JYevm9Ccz5TikaVq2vOGXMzFU=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDXSnsiG8Ro0HdiBA--.59242S3;
	Fri, 12 Sep 2025 21:07:48 +0800 (CST)
Date: Fri, 12 Sep 2025 21:07:46 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Qais Yousef <qyousef@layalina.io>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
Message-ID: <aMQbIu5QNvPoAsSF@dragon>
References: <20250910065312.176934-1-shawnguo2@yeah.net>
 <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
X-CM-TRANSID:Mc8vCgDXSnsiG8Ro0HdiBA--.59242S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1UuryDCF4UKw47WFyDJrb_yoW8CF47pr
	W5W3y2kw4kWF1vqws7Ka18Z3ZYvFs8JrW7CF1DKrnYv3y3Zw1SgF42ga15KFZIyrs3Gw1U
	XF1qq3sxAFs5ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uz6wZUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIgQbgGjEGySSBwAA37

On Fri, Sep 12, 2025 at 12:41:14PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 10, 2025 at 8:53 AM Shawn Guo <shawnguo2@yeah.net> wrote:
> >
> > From: Shawn Guo <shawnguo@kernel.org>
> >
> > A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> > cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
> > due to that platform's DT doesn't provide the optional property
> > 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> > suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> > platforms, because that the 10 ms cap for transition_delay_us was
> > accidentally dropped by the commits below.
> 
> IIRC, this was not accidental.

I could be wrong, but my understanding is that the intention of Qais's
commits is to drop 10 ms (and LATENCY_MULTIPLIER) as the *minimal* limit
on transition_delay_us, so that it's possible to get a much less
transition_delay_us on platforms like M1 mac mini where the transition
latency is just tens of us.  But it breaks platforms where 10 ms used
to be the *maximum* limit.

Even if it's intentional to remove 10 ms as both the minimal and maximum
limits, breaking some platforms must not be intentional, I guess :)

> Why do you want to address the issue in the cpufreq core instead of
> doing that in the cpufreq-dt driver?

My intuition was to fix the regression at where the regression was
introduced by recovering the code behavior.

> CPUFREQ_ETERNAL doesn't appear to be a reasonable default for
> cpuinfo.transition_latency.  Maybe just change the default there to 10
> ms?

I think cpufreq-dt is doing what it's asked to do, no?

 /*
  * Maximum transition latency is in nanoseconds - if it's unknown,
  * CPUFREQ_ETERNAL shall be used.
  */

Also, 10 ms will then be turned into 15 ms by:

	/* Give a 50% breathing room between updates */
	return latency + (latency >> 1);

Shawn


