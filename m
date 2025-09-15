Return-Path: <linux-pm+bounces-34671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC1B57AC6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3105B1AA1111
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 12:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BAE307AD9;
	Mon, 15 Sep 2025 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jrFESGPW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC92FF15D;
	Mon, 15 Sep 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938908; cv=none; b=qWRGAHV9GrZ2XJ1XZZc/n51uhOK/GNpJWDm6q5CLW7TWXW41o15eHwC+mr99ur9/dtwqin/sT1p55LJpUwQXoiPvfcfJE7BQxkfndkQMAuPkTHGhLyCjTRSo/YyBwLtScF4E1oAUqsuHnQ3Ej0cl3zVwm1OPNBtqj1lHFTv2Fag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938908; c=relaxed/simple;
	bh=z2kNIlcXBW6MfC2xnrcVa0oHxwllCrJCejQCNVLE0eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiH9A/Vmohr2aOxV5Bv8HE1n1yWRhdHuv31Wr9lJ/6dYcwoQNJK1s/z8ASoiaZmLiSt5Ro7Pl72S7eR5W23nILJCCfwjDq8oJmGN2mckG1yJA0FUzPYJ5liVCxJR+7fH5sxjlLYSRa8VCwsY+KH+dZ+jWT94p9x1TddCqCry9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jrFESGPW; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OOyfLZgtX27UDIP2iLeBPK7IHVGLm6yCXP8suJxPQlk=;
	b=jrFESGPWhXpollyfx2m2Rmh87nxknxI0bHyUfUBTA7k8Zz0Jk6COaBKi03L4dr
	I/WOcZ6ziU5uN2cHpS83VNHtD/12Jduq12MQIgeUSo9BAs7jjeUHXdEG6fBpvZa0
	aa5V28EzrTFTAgUQpbIXpKUut6KGamE3qez/pMsnrO1SQ=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgB3b7qDBMhoodmEBA--.36439S3;
	Mon, 15 Sep 2025 20:20:20 +0800 (CST)
Date: Mon, 15 Sep 2025 20:20:18 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
Message-ID: <aMgEgvTyHEzaEJ1v@dragon>
References: <20250910065312.176934-1-shawnguo2@yeah.net>
 <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
 <aMQbIu5QNvPoAsSF@dragon>
 <20250914174326.i7nqmrzjtjq7kpqm@airbuntu>
 <aMfAQXE4sRjru9I_@dragon>
 <20250915100207.5amkmknirijnvuoh@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915100207.5amkmknirijnvuoh@airbuntu>
X-CM-TRANSID:Mc8vCgB3b7qDBMhoodmEBA--.36439S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7try8Ww1fWrWDKFyDAw48Crg_yoW8GF43pF
	W7K3W2kF1kGF4Dtws2yw4Uuw1Ykwn5tr4UGry8WF1rA398Wrn0gw4Iga1Y9FW3Jr4DCw1q
	qr40g3srZayYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut9N3UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEh3JZWjHo9vN3AABsk

On Mon, Sep 15, 2025 at 11:02:07AM +0100, Qais Yousef wrote:
> On 09/15/25 15:29, Shawn Guo wrote:
> > On Sun, Sep 14, 2025 at 06:43:26PM +0100, Qais Yousef wrote:
> > > > > Why do you want to address the issue in the cpufreq core instead of
> > > > > doing that in the cpufreq-dt driver?
> > > > 
> > > > My intuition was to fix the regression at where the regression was
> > > > introduced by recovering the code behavior.
> > > 
> > > Isn't the right fix here is at the driver level still? We can only give drivers
> > > what they ask for. If they ask for something wrong and result in something
> > > wrong, it is still their fault, no?
> > 
> > I'm not sure.  The cpufreq-dt driver is following suggestion to use
> > CPUFREQ_ETERNAL, which has the implication that core will figure out
> > a reasonable default value for platforms where the latency is unknown.
> > And that was exactly the situation before the regression.  How does it
> > become the fault of cpufreq-dt driver?
> 
> Rafael and Viresh would know better, but amd-pstate chooses to fallback to
> specific values if cppc returned CPUFREQ_ETERNAL.
> 
> Have you tried to look why dev_pm_opp_get_max_transition_latency() returns
> 0 for your platform? I think this is the problem that was being masked before.

My platform doesn't scale voltage along with frequency, and the platform
DT doesn't specify 'clock-latency-ns' which is an optional property
after all.

Shawn


