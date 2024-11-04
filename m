Return-Path: <linux-pm+bounces-16929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0059BAF68
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4141C24754
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69801ADFF6;
	Mon,  4 Nov 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGPVCOF6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF31ADFEA
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711771; cv=none; b=LFLVov7rGw9g74zTrf4d05i6f7FU+Hoq8VHNgnUz97RkoGdZeFIx7aKKNKfwOCxhV3wE7yCTx9Y6gQIaVyqvQVwyTfRVBHvRo7JaO2ygXMzF4rM2WHymi5IsgPT4f75e2Vg4pE/o5G76z3tZvqySOimQIMN+fmrgDbihptCQUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711771; c=relaxed/simple;
	bh=8qvvIbXZBoOhUrurg+FXL7IS9N/nTjxufCJF6UXmVG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4Yw2aHt0nq1OeqCByx3tNRfPhKneraiHWmzoLajgiZE9eArGeekQh/9B0hySE6zeNC1nTHRZvBn57w+PJIiWK9vSIgrOrw741ElhK2Vv/8B3gKEt7FxZASMjSF8UVs/uMEi61WA3dZTcZQsHBFVouDHV1cuhW/xwHofkctK6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGPVCOF6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso622048166b.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 01:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730711768; x=1731316568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjW0MeEanGzE6qJjI2t+OcWT0D3B+88t+GC9PRoygKY=;
        b=MGPVCOF6Hn02fyYFq3XHuUsgwuVGc5oyXa8OzGESEDC6S7b4/elG7NJGvM+YWbDJI4
         a1wH5CMtOoyseSQxuzMUxjXvQR1sDJtXj3a2cX+nwQ4pdOxRQQi5iL/WcrtJtpnNszhs
         tv/y2szsY6WRjpeqZ169bD+pywwJP7f2mXDHWZK9IC1cI00O9Mp0vJfybv6Hl4fPwmSA
         HMLFN3nj+CZ9ytgqwYrjXjUqQFBj0NOxFu3r8ZhdlWZQRVtx0ZuDs4heUBVzzMFp2oph
         ReVW8VaW++qCLmH5i7CcjRkq3r7PP9pnfGhF4m5At28adj0De086FXKzcvUk/rMPSA/f
         SLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711768; x=1731316568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjW0MeEanGzE6qJjI2t+OcWT0D3B+88t+GC9PRoygKY=;
        b=CpHu78IogX8j0NpyakcNrfjscO1Ynxj7NRI4fF+Rr20TIiQDJ8yZpn/+cvnLgqfIYV
         aUJxjtbhxHmxrkFEyBd/EO6jBWnilBIx5x0PegyfZXFAYDjJEiPrUjIMRuX8NRE3DkKr
         8JGZTj7+7G/BTm5PdjJ0AI2dXff4KShQKP/4R+Hxlc6uwieIVWHN85zUHNO88RRwQBmR
         gNvr9b3wKUjIVOIUoHIWPXYGOb1K2LB9THrEnU2pSRV0rL7/R7BRIUKQGvnb4SJSsJ2N
         05DYX8wR6wDFxmXPGVdJzdGLv2CnYIBGO+swNMT9nhny+40I5PPJMcsJMWSdisb+eKlz
         0i/g==
X-Forwarded-Encrypted: i=1; AJvYcCXu3fRv98XU84A9Rrbpu9a+AH9b6GSfOyUAiZ+x8uNfyGBDt9eX/VzoJXkcDuTftpK+VvQeM6wuKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwArHqMQxz3b6KURCXD1RplW394/OwRV8UCsToVSI0SIK1xfhb/
	tW3X+pams412wonrxtsveAOANfmOltwGqmCH9pKTlFYzCFhkW4jEfTDVnWBHDj4bAHuqy1IJ5I4
	SCw==
X-Google-Smtp-Source: AGHT+IEi3CGJRpuLDqOUs4AbQRJ6VtgvGgoK9lVUe7GdygoxskVpKy2yxyMGcjqfE0/N3aK1DynM8A==
X-Received: by 2002:a17:907:2dac:b0:a9a:82e2:e8ce with SMTP id a640c23a62f3a-a9e6587e288mr1306429766b.40.1730711768194;
        Mon, 04 Nov 2024 01:16:08 -0800 (PST)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494295sm535883266b.14.2024.11.04.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:16:07 -0800 (PST)
Date: Mon, 4 Nov 2024 09:16:05 +0000
From: Quentin Perret <qperret@google.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, rafael@kernel.org, pavel@ucw.cz,
	len.brown@intel.com, linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: EM: Fix uninitialized power in em_create_perf_table
Message-ID: <ZyiQ1YS81ZjE1Qlu@google.com>
References: <20241104090351.1352997-1-ruanjinjie@huawei.com>
 <3386f37a-55f4-43e0-a991-7cf4ece2e55a@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3386f37a-55f4-43e0-a991-7cf4ece2e55a@arm.com>

On Monday 04 Nov 2024 at 09:14:36 (+0000), Lukasz Luba wrote:
> Hi Jinjie,
> 
> On 11/4/24 09:03, Jinjie Ruan wrote:
> > In em_create_perf_table(), power is uninitialized and passed the pointer
> > to active_power() hook, but the hook function may not assign it and
> > return 0, such as mtk_cpufreq_get_cpu_power(), so the later zero check for
> 
> Please fix the driver. I have checked that function. It must return
> -EINVAL when the 'policy' is not found. We cannot progress with power=0.
> 
> 
> > power is not invalid, initialize power to zero to fix it.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7d9895c7fbfc ("PM / EM: introduce em_dev_register_perf_domain function")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >   kernel/power/energy_model.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index 927cc55ba0b3..866a3e9c05b2 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -344,7 +344,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
> >   				struct em_data_callback *cb,
> >   				unsigned long flags)
> >   {
> > -	unsigned long power, freq, prev_freq = 0;
> > +	unsigned long power = 0, freq, prev_freq = 0;
> >   	int nr_states = pd->nr_perf_states;
> >   	int i, ret;
> 
> 
> This patch proposal is just a workaround.
> 
> When you send a patch to that MTK driver, I can review it for you so
> please add me on CC.

We raced, but +1 to the above :-)

