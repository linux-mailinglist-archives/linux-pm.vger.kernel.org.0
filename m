Return-Path: <linux-pm+bounces-10996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207A92E911
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F3F1C21736
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6015A15E5CD;
	Thu, 11 Jul 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eiHXWkjD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D115E5BA
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703802; cv=none; b=fg87J4kptEG4cmMTFT3L4NKeZicfpoy9sM5xcBVf6LdaFu/QKyh9z+kmjupM3P9mJpKR/3lChPgE7kVT//uMHiJvcWlcrJyAEBvD8hhywj+ZrhFRvpeDGuuY+CaJqvqpGcOVM3oGZTWpyIZiF9gd4Y7EfS7HjUomT1aO9U1WBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703802; c=relaxed/simple;
	bh=4ikN8JjZ+bXsTenqm2X8BKNxzCzpZv4nGiKyu8dkyWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEqn3Ta14QqoELabbGUK67M9vw/L5iZyhyG6rYQWEqKgA76ztqC72TLJec+Imhd1ehy7M9qZ6jaYj4wRNDNRgC0NIDTjzwe5GsG4kAnA82O5I5pajOC2LQDdON6rRWlZadHI11HyaLJZvDNYBt1MyVhz5zXusDBfNt4KueUXCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eiHXWkjD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b05260c39so658418b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720703800; x=1721308600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wuplHtDIUsY+v60dipyWU9k8SUH+WJQjVihPpkXe2os=;
        b=eiHXWkjDVLIUYlWvL56YD/VvZQRnfVI0njAfBQwZPsTdZ8xYqhkx3j5LndmnBn0fHg
         pNxNn8scVZcoEl8CqGH5r9QONkaJVlBsRS0QinN1DT1xKcuhUGdsCz+8zkbQij7xRXN9
         594WWeEuBjwKUb+4YwBFwY7oGy4nwEievCX39QaQE3G2NWW+IhtH8Yz01j9M8ikGM9Mq
         4n7dpSpP9gWO1Ssubdw61N8W/4OGiBLwzu5yFPeFUkj4t8q5WVrYAeNbw0nOH/ObhpNf
         W0BpsKtQ02nK3hLpqxKrRQX8qSMq+ekiZk5ffoGX55OsPKOumzQCEGx+4539INkG1ek1
         COAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703800; x=1721308600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuplHtDIUsY+v60dipyWU9k8SUH+WJQjVihPpkXe2os=;
        b=uUz5Q4tn9cmbFfADdCov+vlba74OX5UItbQB+W0N/Tjw+J91GKaqdIAJ5MgXrEBDcN
         sBBOYzXtv4Biyj/salcczP9VL8bG9nGntqyCyYMVqADqwrQtTVjltePvD8wNs1KOPd8l
         I6iHL3ZejUO4x5wqghqosBTa/PiSrsAICRppcVMy8d0YBhlKjYvXIylbl2fVly+nN+6b
         GH1YZV5FcQKIs8wGLMn9/IDuzxR7ffwbl8JhEel8hWJRt+q3rdey9TJShaqfjcaWnjHW
         FFi/50H2o6AN1m2st27lycOAOwbKKOnlj+dUAhuc54hXEzLUVfKimFNoGVgS0jb/gLhQ
         LBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6edb3MwPZtWm15BydqTPrcU2MnYuBtYg6fnTF1dOF+lUnKkHZw0iKHmGQMC0hxhN4pisJbWuPwYSqYcOA9+iwbgZr0eAJHsM=
X-Gm-Message-State: AOJu0Yy3otmYQEBcgrtXSDZ5MuCWcwAXaDm/o8Tv6rQeigU9p9ZYR2x8
	h6UXl9cNUeoZbCNTqT0M5okC3OXTvAr4MZCYwH29v8SU0eyvJKeo3MgTqJoI7oE=
X-Google-Smtp-Source: AGHT+IHZ3UH1ty7UF4a3wIr5FEGH2dlGV92koJ4rrmQlAuhh3VFAuItSKIUZOvFCugjqmOgiWXH3+w==
X-Received: by 2002:a05:6a20:d50b:b0:1c2:9f03:82d4 with SMTP id adf61e73a8af0-1c29f038726mr6683433637.53.1720703800081;
        Thu, 11 Jul 2024 06:16:40 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4396ab5esm5794716b3a.140.2024.07.11.06.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:16:39 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:46:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM
 domains
Message-ID: <20240711131637.opzrayksfadimgq4@vireshk-i7>
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7>
 <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7>
 <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7>
 <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>

On 11-07-24, 13:05, Ulf Hansson wrote:
> On Thu, 11 Jul 2024 at 12:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 11 Jul 2024 at 05:13, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 10-07-24, 15:51, Ulf Hansson wrote:
> > > > I think this should work, but in this case we seem to need a similar
> > > > thing for dev_pm_opp_set_rate().
> > >
> > > We don't go to that path for genpd's I recall. Do we ? For genpd's,
> > > since there is no freq, we always call _set_opp().
> >
> > You are right! Although, maybe it's still preferred to do it in
> > _set_opp() as it looks like the code would be more consistent? No?

Since the function already accepted a flag, it was very easier to just reuse it
without.

> No matter how we do this, we end up enforcing OPPs for genpds.
> 
> It means that we may be requesting the same performance-level that we
> have already requested for the device. Of course genpd manages this,
> but it just seems a bit in-efficient to mee. Or maybe this isn't a big
> deal as consumer drivers should end up doing this anyway?

Normally I won't expect a consumer driver to do this check and so was the
opp core handling that. But for genpd's we need to make this inefficient to not
miss a vote.

The problem is at another level though. Normally for any other device, like CPU,
there is one vote for the entire range of devices supported by the OPP table.
For example all CPUs of a cluster will share an OPP table (and they do dvfs
together), and you call set_opp() for any of the CPU, we will go and change the
OPP. There is no per-device vote.

This whole design is broken in case of genpd, since you are expecting a separate
vote per device. Ideally, each device should have had its own copy of the OPP
table, but it is messy in case of genpd and to make it all work nicely, we may
have to choose this inefficient way of doing it :(

-- 
viresh

