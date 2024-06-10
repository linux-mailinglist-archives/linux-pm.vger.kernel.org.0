Return-Path: <linux-pm+bounces-8853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0B6901EAD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4C81C21D92
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA375811;
	Mon, 10 Jun 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHQXAN7f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076873502
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013515; cv=none; b=Cq+iLVZNHXpfoe0FAQlpJ2xZZSKE06MqMl0a82L7PYpojL3+ViCnEEPmYTDKCGOv6TGmKghBeGB646kA4UfDBZmZn4jn9yDJyZFi1tSKC/sBewqPocjnNBoOIgYJflUIIfnMP7QX0BYK4oCF5/xXFFyPeA2XaGYMJJjNEvldtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013515; c=relaxed/simple;
	bh=vL+e4B6rQelOhW3SQ+8ffC0Kvp6DIcq6ImI5X4iou8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USK9wnfXt3M7vluYk1cVKRXqrwFlmz586xaDje+GHU7ywmw00nf34HljE0XZOQFt+2K0gcaD1joLNLmiB09ODJps4c/ZthnQP9xMNxuGeca0AbgQdXW61ao59Satf/HXP0OMGolwdF1uVeeQyNsNp26pVuDXt4u0P45aB/S0VCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHQXAN7f; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfaf47d3d9fso3079746276.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718013511; x=1718618311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=grzyUJy9kcHXf/MxmuiGPzY3cLbCYDEM6U0m2F2h4IM=;
        b=uHQXAN7frRdgbA3LlVD4JO+xtPX4TVGBteiuvpX41wfXEM/1JfD8qCtAhOFjGRuJM+
         MeMoRift4GlGyYTyACHPeDGUYgfouH6Hh7XA9jtYmmmjGwNjmDx1RFet+bCg95KlrUtv
         llfZ7pIChiycwQI4lF0ksBiJQyCzUE7nrRYLuJVKEW2qMhBOLDc1zZO/qMUyDU+usZ2f
         SYlEXJKvYYEWKjsGqncB7/qD8zK4+mbbtL0CLpYNmsFccV5MBHXi6W2m+kxww3E9f36Y
         +YeF8snxBSshmOkf7aJOyWhTVsSpsOmCJWHh3ylYpqShHEtSqZy6GhjtUufWk5vxgTe4
         jpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013511; x=1718618311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grzyUJy9kcHXf/MxmuiGPzY3cLbCYDEM6U0m2F2h4IM=;
        b=XHmrPpd3/mvNAc6sgdQLNspZ6FJBgRSh8Ay4orn+009Trl4kuzgSMvZacm0S44xLtD
         OwTa/MgfqfQXHqBBZyoIa4SYmPKQ2kkZgLgtYNpVEUEiRhG9xnBSVhjk3XuX8ZXNzRXv
         +tIKKC2hDAQmFThrD/LU9hDg0xGTF3ApMmwKu6HyqDpDvhytd6qdfho4F3fG8LwfTu7g
         4c878ufXk1THTPR3ribhUuNryjHEoUTPgFYgH/tDw3hG6jybny9ZpKX9THyRkRERS38i
         Y/5u8iLThfVvcrAl5H8Z88SN6d+b9hs8NyLSZ7gB14PTvBw0AFXd6EUS+dgUVBMbqOiP
         AOpw==
X-Gm-Message-State: AOJu0YyBVMSNMDyv+nfxFDYdQBMgOdRZb4IyY7q7WDlmWk8hqJUKOE0G
	yWM+gbQITd1Xa/iTMi9hpWaoo1UH5+OzOAVYVcjDd+Fn6YWoLldhrx6XdHFhOX7YCS55CzAHbYU
	l0y9MBlYsGTT5YosEhl3/Ef+ObIP1j9/s5WFkTYQiqhsq3DSzuXA=
X-Google-Smtp-Source: AGHT+IHqz16v0hYO4hjfMD0/cvunbHpItzUfiQ27fnJaZcbUsv3C/XWXRPkEAzG04WgB5BXS7pQOGEiiSV3LWnxQGVs=
X-Received: by 2002:a25:7453:0:b0:df7:40de:5b72 with SMTP id
 3f1490d57ef6-dfaf66d0c5bmr7521213276.47.1718013511292; Mon, 10 Jun 2024
 02:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com> <20240609224701.pc6om2o5ep6btywe@airbuntu>
In-Reply-To: <20240609224701.pc6om2o5ep6btywe@airbuntu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Jun 2024 11:57:55 +0200
Message-ID: <CAPDyKFoHc6Zcg8i-y3HxUp0=S_N2GhmKcT0w2e-NkzR498mp2Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
To: Qais Yousef <qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	vincent.guittot@linaro.org, peterz@infradead.org, daniel.lezcano@linaro.org, 
	anna-maria@linutronix.de, kajetan.puchalski@arm.com, lukasz.luba@arm.com, 
	dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 00:47, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 06/06/24 10:00, Christian Loehle wrote:
> > Increase the util-threshold by a lot as it was low enough for some
> > minor load to always be active, especially on smaller CPUs.
> >
> > For small cap CPUs (Pixel6) the util threshold is as low as 1.
> > For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.
> >
> > Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> > Reported-by: Qais Yousef <qyousef@layalina.io>
> > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Suggested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> >  drivers/cpuidle/governors/teo.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> > index 7244f71c59c5..45f43e2ee02d 100644
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -146,13 +146,11 @@
> >   * The number of bits to shift the CPU's capacity by in order to determine
> >   * the utilized threshold.
> >   *
> > - * 6 was chosen based on testing as the number that achieved the best balance
> > - * of power and performance on average.
> > - *
> >   * The resulting threshold is high enough to not be triggered by background
> > - * noise and low enough to react quickly when activity starts to ramp up.
> > + * noise.
> >   */
> > -#define UTIL_THRESHOLD_SHIFT 6
> > +#define UTIL_THRESHOLD_SHIFT 2
> > +#define UTIL_THRESHOLD_MIN 50
> >
> >  /*
> >   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
> > @@ -671,7 +669,8 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> >       int i;
> >
> >       memset(cpu_data, 0, sizeof(*cpu_data));
> > -     cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> > +     cpu_data->util_threshold = max(UTIL_THRESHOLD_MIN,
> > +                             max_capacity >> UTIL_THRESHOLD_SHIFT);
>
> Thanks for trying to fix this. But I am afraid this is not a solution. There's
> no magic number that can truly work here - we tried. As I tried to explain
> before, a higher util value doesn't mean long idle time is unlikely. And
> blocked load can cause problems where a decay can take too long.
>
> We are following up with the suggestions I have thrown back then and we'll
> share results if anything actually works.
>
> For now, I think a revert is more appropriate. There was some perf benefit, but
> the power regressions were bad and there's no threshold value that actually
> works. The thresholding concept itself is incorrect and flawed - it seemed the
> correct thing back then, yes. But in a hindsight now it doesn't work.
>

For the record, I fully agree with the above. A revert seems to be the
best option in my opinion too.

Besides for the above reasons; when using cpuidle-psci with PSCI OSI
mode, the approach leads to disabling *all* of cluster's idle-states
too, as those aren't even visible for the teo governor. I am sure,
that was not the intent with commit 9ce0f7c4bc64.

[...]

Kind regards
Uffe

