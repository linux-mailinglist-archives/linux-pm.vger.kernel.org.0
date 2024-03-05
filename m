Return-Path: <linux-pm+bounces-4673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9EC8715AD
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 07:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6DCB212BB
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 06:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822FE7B3E7;
	Tue,  5 Mar 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qflZbLNR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B016167A
	for <linux-pm@vger.kernel.org>; Tue,  5 Mar 2024 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618995; cv=none; b=o2R6dHeRiEyTWM5nzZZETH4eihvibT1/DQCIrDBbOD+K0nIrTLceCH9TOmAFuy2II4eicITR+CO2xOg1niXhslgh+TUezlLgLXy1i74QlzQfRrbCy0gWvL2Sfc9rr5Ist1IEh5H+KEVzEgvaJwFqtEskpF5xVZpdYCnLg7b3Hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618995; c=relaxed/simple;
	bh=TNBK9fUwJLsaAImw1Jf5Q46P/Y3QQThaMK9QPXp0nsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNMTeqRoBl99400KEtGR0LwQP6jpu0sLpP3Qcn0MVTD+oPev1pDmAhId8rwQg6j7B0rhh+slEC2linCBxdjUb5OtbpyowOjOs7C2I7cZYyrNu5GsiRsKnP+GF/Lsn3MW9l1z4uZRohjiuI2pPQaxsAZZuWlHFH8Fg6kOAyl/7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qflZbLNR; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a142375987so135331eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2024 22:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709618993; x=1710223793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BDLkvHSjKn2xGeDzvhFh1c2vd6PQCy331MBE5g4t/8=;
        b=qflZbLNRn5UYMHmzoq7FzxVgibF+WGlXxko2jmmO98SAzngob3DLY/V6urUs0ZEjww
         Ji0FhgZ+MgTscwNqUf5PenfKLThxAYfKdGqovEWjDkFRfVa8oMuDLLgYPfX9ysfydJKy
         gohgmc9UoZsEMU95OgZPvJ2aQOD5Sw9lmYBZs/tSzjEFH3VxILcTaGQaeR9pagZZ3eAU
         HEh6J8FA6SxfZj2LEcOdO0JFLXKesszHQNtonJPWlqXoKyUQTNpR2ROdtGLZxJtBp+SL
         5aDMgO/+hVW+PAvEjrqMv+XKbX3vZXbvgCeGHJV/lr8modOMd/eW5B3WTX/od30JnR+M
         1rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709618993; x=1710223793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BDLkvHSjKn2xGeDzvhFh1c2vd6PQCy331MBE5g4t/8=;
        b=xDXJno6QU/gdUJeVaTWNCVeXiNptXohgSK7ykx1AuIGMVzUNdQmingBVMmMdVHAXYH
         kNYszonkT7eei+/tmp8ZMeQ8j0+xSS3IXvT1gLsp5cQnHorYWDno+C8oBiGxQi/i1MVp
         7mASm++0id5jTSznerGh+bfPnHaEjhVhagd8x455a8dB33xpmoj40Vi2nnJEWn9phW1j
         vHIaOOAN0S2oSxfapQ9RYfmir6aB8X8lPMUUWjPzSdC+f3kcHepHtE2PMpjxJ/1joqRy
         8KtCuDjKSixEN/Gk5msYKFX8s/dDe+PiICR36G6BEpG6SVAA7XGuFRqvtydb/LxfJkcT
         lNEA==
X-Forwarded-Encrypted: i=1; AJvYcCW5OV96G1z0VZhYWittQz+dPd9n8soqwe1OuLX96ETklVFh+ndpOYUVCyhZcU7U2kVwkuoK4fTfYGCcUxEHJjGAJOAwBMNdwrc=
X-Gm-Message-State: AOJu0YwkkXY352aLePSsWkb78kE7kfs3v2xvnkbR/CLn5ebzHemdSW97
	M9D0gX2LvLSIMKRnhi0J8/tcIgnfX6Z+SPf3uoK2MjVYtmWPTyJw9qLaV6XqLac=
X-Google-Smtp-Source: AGHT+IEIWFOfaFbEh9f6ob6ornvM/SZDefnANJC8LnnWZLbBx3Vndoh0MwTSPcdNEYdKAsuDpqmoSQ==
X-Received: by 2002:a05:6359:458d:b0:17a:e9db:bc10 with SMTP id no13-20020a056359458d00b0017ae9dbbc10mr974302rwb.20.1709618992856;
        Mon, 04 Mar 2024 22:09:52 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id c11-20020a63da0b000000b005bd980cca56sm8302545pgh.29.2024.03.04.22.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 22:09:51 -0800 (PST)
Date: Tue, 5 Mar 2024 11:39:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] OPP: debugfs: Fix warning with W=1 builds
Message-ID: <20240305060949.pjzb54zkcelt5xgz@vireshk-i7>
References: <ab75239d2280e506e5b9386b8aeb9edf97cd3294.1709551295.git.viresh.kumar@linaro.org>
 <66af18e0-56eb-401f-900d-a83f6e52c603@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66af18e0-56eb-401f-900d-a83f6e52c603@ti.com>

On 04-03-24, 17:08, Dhruva Gole wrote:
> Hi,
> 
> On 04/03/24 16:52, Viresh Kumar wrote:
> > We currently get the following warning:
> > 
> > debugfs.c:105:54: error: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
> >                   snprintf(name, sizeof(name), "supply-%d", i);
> >                                                        ^~
> > debugfs.c:105:46: note: directive argument in the range [-2147483644, 2147483646]
> >                   snprintf(name, sizeof(name), "supply-%d", i);
> >                                                ^~~~~~~~~~~
> > debugfs.c:105:17: note: 'snprintf' output between 9 and 19 bytes into a destination of size 15
> >                   snprintf(name, sizeof(name), "supply-%d", i);
> > 
> > Fix this and another potential issues it by allocating larger arrays.
> 
> Just to keep in mind while applying maybe: s/another/other
> 
> > Use the exact string format to allocate the arrays without getting into
> > these issues again.
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2: Use string name while allocating memory for the array to fix potential
> > issues later on.
> > 
> >   drivers/opp/debugfs.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> > index ec030b19164a..27c3748347af 100644
> > --- a/drivers/opp/debugfs.c
> > +++ b/drivers/opp/debugfs.c
> > @@ -56,11 +56,11 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
> >   				struct dentry *pdentry)
> >   {
> >   	struct dentry *d;
> > -	char name[20];
> > +	char name[] = "icc-path-XXXXXXXXXX"; /* Integers can take 10 chars max */

Integers can take 11 chars max, I forgot the negative symbol. Added
space for another byte and pushed the changes.

> Feels like a better solution to me than the previous revision, thanks!
> 
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Thanks.

-- 
viresh

