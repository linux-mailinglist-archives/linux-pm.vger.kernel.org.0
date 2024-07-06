Return-Path: <linux-pm+bounces-10722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A1929215
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B956B21A1C
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47A47781;
	Sat,  6 Jul 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu4AkdnC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB931B963
	for <linux-pm@vger.kernel.org>; Sat,  6 Jul 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720256495; cv=none; b=su7Td2mkZZtSRUCYBVA5Ydjylxy3Bw9GwT4OZ94wA04NhPpm6VEKhdHyuGufJp77PrE4OoSTQgBu3a4+aP7mR2tTGU9IImihQAmwxriKmJpBAtOrrF5xxJDn4fn/ZDvTWORPPXy8qXT8qrN4atajAT2OBdUxDS9CDhdEBZMraFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720256495; c=relaxed/simple;
	bh=1fRFmAeRWbbnc4czXB4S/CavZUJLftpdm/WT09pQpNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHutRglR433fAIq79RDJKMwwOg8euYR8GvUJ5798qLsQjCmD75b5b0avfOX0/ArDIEviSl679Md6skjypiF23IV9NEVVNEvhoA+g6ItC1TaZQD0KHpiZVl+ZY6KiHOiXb1zHbE5pkYGDuizca077+TK0VE1JlD/C6rXh/XOuVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu4AkdnC; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c967e21888so1606920a91.1
        for <linux-pm@vger.kernel.org>; Sat, 06 Jul 2024 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720256493; x=1720861293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YsTvMvZcSY2ZSuC20nkSArsNjYonbkAEsOeFY8Okpok=;
        b=eu4AkdnCiTbZh8l5A/5blAaLvBwmdD5rR4E29RTRCXsRejuVYNUryD1xHVU+4NK7Bl
         w39EaEwQH+iwxEr80ft+DXAXhOQderRybbDfDzNI7YHgFEggmjKAKyuzT1Vc4tHEOjMd
         C0/A63HQALCcwmRmPUfSkxfPf45hRxObrxnToyq87J4ANhpuTRMliWmekXrlaJSbjKpc
         wAqmintgVNak4XuHdfipJSMde6ngnicEROM86BfkUbjymdPKXLKPe//Fz8in3ji37H8E
         8b9yetqb/Xj1UpCupn8yGKOwH7SWXLRszycfvd0DqFbUyWNJDka7MyCYl2P9yDxDQXap
         AIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720256493; x=1720861293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsTvMvZcSY2ZSuC20nkSArsNjYonbkAEsOeFY8Okpok=;
        b=BJGzMrIKRzFo49Jkb92sKienwppGxnl2mpObiNBezQmfxpdqOKmku/675/7y7SXf9h
         tH5gfTc5ihlNxyKhCvlvAqjvTa9zAo4ZmvoDrsdOKjfuQUvYWMM00j/u5dlsV33ykjAt
         Y7hxXOHX6oBmA4ao02IjubWFLvlibvadUgYPZ2NuoMBsSFfj5zRu8Fnsne+tlSSv0nd2
         3yaIly2axknRDI8sVZb4rw5DuriEk8SrSb74156oRe+dcJXJN1Kjod00Bibs/l6a95i5
         3CncvDIJzBDEzC7r2mJumnVX6ifvCerLELl1i0Fk2LHLWdZg0rZUOjGWP5ciMv/M3VMn
         w/yw==
X-Forwarded-Encrypted: i=1; AJvYcCWUZbkkMEiG+hRugubw2348mO8QftYvs7sQDsW0NEvGVghvWI89MeHsqnmc6zDXA/DZPfPQ8ZO26HkfJWusq6xQRIUjGjamDMU=
X-Gm-Message-State: AOJu0Yw3PVfXkYU0Kk5Q+VEESbREiNKV9I0W3G0jSNCrwTYUFs9X+Y1N
	GgrtM9pwvg6adZKX4TSm2LS6a7ZZvWnAH8s2SHepG0mLkI7DW73BWJHGuJvUo0yQQrcSCpJkxYb
	56Ig7K+nK2CTOKBWbwglS3pbrhdCxNB2GdHwBQQ==
X-Google-Smtp-Source: AGHT+IEOJzFvfwtnv8PFmSEqRUOVNxWPl2o9EsvkfSUtSg2DcWgK+yBNAYbmlEl+DFaAdUH76t9Z24PkqOc4gdMEQv0=
X-Received: by 2002:a17:90a:1286:b0:2c7:7e23:63d8 with SMTP id
 98e67ed59e1d1-2c99c6d0e09mr5072946a91.44.1720256493164; Sat, 06 Jul 2024
 02:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
In-Reply-To: <Zog5-Yd5wV0-Y76y@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 6 Jul 2024 11:01:20 +0200
Message-ID: <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 20:22, Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Vincent.
>
> On Fri, Jul 05, 2024 at 02:41:41PM +0200, Vincent Guittot wrote:
> > >  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
> > >  {
> > > -       unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> > > +       unsigned long min, max, util = scx_cpuperf_target(sg_cpu->cpu);
> > >
> > > +       if (!scx_switched_all())
> > > +               util += cpu_util_cfs_boost(sg_cpu->cpu);
> >
> > I don't see the need for this. If fair is not used, this returns zero
>
> There's scx_enabled() and scx_switched_all(). The former is set when some
> tasks may be on sched_ext. The latter when all tasks are on sched_ext. When
> some tasks may be on sched_ext but other tasks may be on fair, the condition
> is scx_enabled() && !scx_switched_all(). So, the above if statement
> condition is true for all cases that tasks may be on CFS (sched_ext is
> disabled or is enabled in partial mode).

My point is that if there is no fair task, cpu_util_cfs_boost() will
already return 0 so there is no need to add a sched_ext if statement
there

Vincent

>
> Thanks.
>
> --
> tejun

