Return-Path: <linux-pm+bounces-39539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FACBCF6C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 09:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2613004516
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2E24A051;
	Mon, 15 Dec 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAIm4Ueq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542282253E4
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765787626; cv=none; b=Cgp74/juZ7MypuGKf/J992WwTAncamXN+gSYdEP/4jUJp5juYOZoN6IIC27lWYcp/DsD7Mar0hg0P7nymuzSt79aVZS/GTJ23EsaMMy9au/EXdIVvUWg+aQXpyl7pXc6lQToW2KhAtQWpMrH+nMgJy0zD6y0SNj3tYbOjz3sY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765787626; c=relaxed/simple;
	bh=re/J2u5kW+iYFobhHys3ZYJFb/BDqlJM/16+S9FipJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbZW4ducGgJTsUzwfooXuYNQw6aWRCxzYAYH4ZBQwZ5DKZSdyRyOqYa94al3uAzW++YBB83QBttPgpmAtDVpKnH/9ntoboNelAoK3Thr5EuJKQ8mOI1aWoZzQSiHUVZpnNw2cbwrF5nwhs3nleuKTTuFnvtBC+zlNDHDn07Jrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LAIm4Ueq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so2109325f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765787623; x=1766392423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KqNsmeS8+YWAkdie5NFeKUkBgtpn0Yqa9GJN2uw9A6I=;
        b=LAIm4Ueq+MKrowywXebssjCj7deHMn3nRJ92DQK6X3lCORRWeQy2sn67/kpP6AugwW
         NUiJ1H2VXdbSIV6RnlKwMpxcR/ZcRdy52N8PiCE8s6LiUOplyMEsmSZLB36rbyV8NKSd
         RdDzQbrM0gX20FJL7WIeh6TbcFVWKwom3c/BzFcHzdsiTdikAGwyqVMGUm6qp1Y44JL3
         EFNKio42bb6cAS6DHgPfhyF9gMtXvBzwfrYIOC4ApJxT0oT/ls0jc5ykQbDu/wwQK8SX
         vXC3OcBZlQuXLWmuNxFGIJeZ2UMvItYHIbS/rzREDbvpfmhykEGHj2t4t375ddQo6LvI
         sdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765787623; x=1766392423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqNsmeS8+YWAkdie5NFeKUkBgtpn0Yqa9GJN2uw9A6I=;
        b=GVLgqwtVcU7gpp11qT9+fO8z+/YQX7yTIEbQJPvgiyzM2KxIBZ+3IT4r/ZLCv16wl1
         xNtCOT4FJq6AaK/knqVYUqGO8WS+4yV3QjgM89vF/77sLytJ5DgAZomb9jnHVLM9NBKA
         dIKVeEcq0TGEH3RNVPgbupIgSDlQ/ziuePN/u/WQiNcEwRd8GG+RGfL7EABQ9RUmyC4u
         S2EvdvS6aO6ewL5SRfkD3T+nEPL06Z5SaAzW952d25kiZVhC2ZGFidpD8jPKVo3assJS
         HcGA+ChbRu/7QSYYfr0r6h8mjXTAe5Xsb5npb3PU1f6fKF/bW8mw1s/RhjQncOR7ans2
         /b9g==
X-Forwarded-Encrypted: i=1; AJvYcCXsy/0Fq0E1w8z0q8QPMrLCbYBVBXJ0zApovTW2OA5zr6RA8W+zgeZMrhghf2Kls5kyTHSurcCGVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7j98AFPQsOYBdm6WNZKGj/EHk2p4PM1bR0i+QLQbJuupTdSEt
	1dlcMqLAvHxiHnIUpa66ByHPQJeqyBEYf7Xfg3UjK9sXfTl/fdr10oDzrCX2XF8BV+g=
X-Gm-Gg: AY/fxX62Jv5Q5mROX0Nmqwmy9Q8vso5m/cVcyY6FV5ayy/4N+AkAJaAyepixHs1pjmB
	r9yibGUS6qZiGrkYrhfLJeCUfG7o2vGippAC1QELRluOI+pVeg50+cBegceb+rqpevFT3jKvXJW
	o4SrEcp87lPRMze+c7mBPiglHsu4WN4r4kORz+muHQzIahCA/6q4vhzZS8ns3WSAHLdXPhBD5Sf
	ieG91dqE5wjs0IR0zHHLvy+FBztoEvy35zmhNiF5KtbQ0sYeBLtSoOmNcwGdpWLsfptV5WpBu9c
	PtVfA6DeZuRydHUaPOcwpnzOBQd+Vw0WncCvJrcZSSrv3in4l2l/Dk1stRPHw+uAombXmNAx3EJ
	3YWjO16Is/N9O4EdMOc0ZD2YbX3JuQ3EI9Lr83bR6nWEh5vSqpRdM3QsldlU4e5RNvG8d0Sf1oD
	RdYJZcouDl/MHbTzWE
X-Google-Smtp-Source: AGHT+IG4+XfIn0mjObpdlgl5MILZfrqvfE1FP5G+Qu4VQUIjo1Xf6YK5qSrSpnlntD5Ncnv7tT4dGQ==
X-Received: by 2002:a5d:6ac6:0:b0:42f:bbc6:edc1 with SMTP id ffacd0b85a97d-42fbbc6eeeamr5907976f8f.1.1765787622553;
        Mon, 15 Dec 2025 00:33:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb0fc8d5fsm20370114f8f.2.2025.12.15.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 00:33:42 -0800 (PST)
Date: Mon, 15 Dec 2025 11:33:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thermal/cpufreq: increment i in
 cpufreq_get_requested_power()
Message-ID: <aT_H4m28SuAwuQzp@stanley.mountain>
References: <a7c1fe73-b40e-437c-8ccb-7b3baad04df7@moroto.mountain>
 <67159a18-3923-4345-bff8-ade49cc769ba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67159a18-3923-4345-bff8-ade49cc769ba@arm.com>

On Mon, May 06, 2024 at 10:41:52AM +0100, Lukasz Luba wrote:
> Hi Dan,
> 
> On 5/4/24 12:25, Dan Carpenter wrote:
> > We accidentally deleted the "i++" as part of a cleanup.  Restore it.
> > 
> > Fixes: 3f7ced7ac9af ("drivers/thermal/cpufreq_cooling : Refactor thermal_power_cpu_get_power tracing")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This is based on static analysis and not tested.
> 
> Thank you for the patch. I have analyzed the code and why it
> haven't trigger an issue when I was testing it.
> 
> I looks like the function get_load() which is called above that 'i++'
> and takes the 'i' as the last argument is compiled in 2 versions:
> 1. for SMP system and the last argument 'cpu_idx' is ignored
> 2. for !SMP where we use the last argument 'cpu_idx' which is 'i'
> value. Although, for !SMP system we only have 1 cpu, thus the
> initialized 'int i = 0' at the beginning of that
> cpufreq_get_requested_power() is used correctly.
> The loop for !SMP goes only once.
> 
> > 
> >   drivers/thermal/cpufreq_cooling.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> > index 280071be30b1..a074192896de 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -249,6 +249,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
> >   			load = 0;
> >   		total_load += load;
> > +		i++;
> >   	}
> >   	cpufreq_cdev->last_load = total_load;
> 
> Would you agree that I will keep you as 'Reported-by' and send a
> separate patch to change that !SMP code completely in that
> get_load() function and get rid of the 'cpu_idx' argument?

Yes, please.

> Or I'm happy that you can develop such code and I can review it.
> It's up to you.

Happy to just get a Reported-by tag.

regards,
dan carpenter


