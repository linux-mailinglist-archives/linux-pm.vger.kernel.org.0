Return-Path: <linux-pm+bounces-34171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AFFB49935
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 21:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A671342B3C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9D26AC3;
	Mon,  8 Sep 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEGZcPBK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE380B
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358045; cv=none; b=BWl55ikc4B33HYH446s8zc2o5cL3W6yTC1bHRPv0JAdxfZgltk+juBvMmTBxYSwD3cKdYnMkFoC7NRBLOhLWfWmAdYT9e0bIGTzfgGALwf3qhdBCGmbn8h2tNu07UQ+uiwRa+iuhbn0ChXWzpleHbw0IjZvJeK1RK5z/fMI1XCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358045; c=relaxed/simple;
	bh=Iwt8hYw/vrd2vOLIqq6ZleY9I9OALhrgBly+IB3p4y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOt8LT0pYN1oFAs7Pp6lk0+NQuvR1h3pm9Zva/UOtFiZFSmFziOpX9M/D1G3lG8s1tp37lOO/C3Yx0wgK+4HQa6nffrTmrkxUnsjEU1u9mOtN7ql0cOUttgrI7esR6jikK4Qastd3IIj+LOngcftFf1WkJsEZjpcIbbDe5V77Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEGZcPBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B06EC4CEF5
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757358045;
	bh=Iwt8hYw/vrd2vOLIqq6ZleY9I9OALhrgBly+IB3p4y4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aEGZcPBKnEJNyca8UbJVNeFjyUKw1F0Sclth6PpXAQzxq4fBX61Ca8GF9ntkw3Ntf
	 eU+88Ahgg9RyJZ5mSDyjJS0kCsrvRFH+iXMgBDbuWMeB9M3pOeetzFku+UJ/yjmCCK
	 faQvgy/CmkykbUxPv98wktSAFJJmOUEuMDM/f8l6if/s2l9fTvRcmmp0plgqp1Zlp1
	 wiIVDdzQnq2zFv92pl8k0j/3nf6rfK+Ytxo3l6OaXEC2bTYlmvgcV/w9BoYcZPF+tN
	 r6vXa5dsicC/NjkEYVwaDju19r7Rdz8oNueg+uvj24TLEnWRoMaI7Xetpjd05LYs70
	 ncEXrHHNRtZAA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-746d7c469a8so3070611a34.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 12:00:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGYq6BnvhUdq3yi0yCPTFhAfx+RmLj1ZDa2YGqR4HFlnNecjco2JIxb5ecpb7KDiWyHeF1J7FvOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjKx8VDKNYGkEh3HiUWcJPC8LGzvCdHSZPNTQ4KqPdVGExJW3
	Bzdm4aj+beyOTSJuO7QKq4V9TTlLJU7CH6I6geqr7g7pX3TILKIC9AE4VcW8j5EDDU7u51+JEnn
	g3NVOvCJa8KwLbVZxSEqd1uIfcoujDKw=
X-Google-Smtp-Source: AGHT+IGAc/QTf7MFW3ME+EoVhTsd/d9NkxbS9EKHVaWNR9LSiaGmj4LpOxXi/9SR2X+AF6P0d+EK5rrdpsin7Vj7LNA=
X-Received: by 2002:a05:6808:159d:b0:438:3b96:7cf9 with SMTP id
 5614622812f47-43b29a4c789mr3920119b6e.15.1757358044442; Mon, 08 Sep 2025
 12:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904081600.2706572-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0iBdmzD2ansm34HQhXQE+Q6_qUkjW1XC9xK_G8Aw_0ubQ@mail.gmail.com> <LV3PR11MB8768E28D7A75ADDD9722624BF502A@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB8768E28D7A75ADDD9722624BF502A@LV3PR11MB8768.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Sep 2025 21:00:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5h1Xs6YPzujxy80kUvsQ=D5D1tPWOaNtnXB5GCuXP_A@mail.gmail.com>
X-Gm-Features: Ac12FXw34JgH79Hh6Tcp2MmQn4BkjOemnbmoZIXOGhlUMislepMRVCG-sU-yrJc
Message-ID: <CAJZ5v0g5h1Xs6YPzujxy80kUvsQ=D5D1tPWOaNtnXB5GCuXP_A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: Optimize SMP calls in drv_write() function
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 6:22=E2=80=AFAM Kumar, Kaushlendra
<kaushlendra.kumar@intel.com> wrote:
>
> > But smp_call_function_many() doesn't run func() on the local CPU, does =
it?
> >
> > So what do you really do in this patch?
>
> Thanks for the review feedback. I've examined the function documentation =
for smp_call_function_many():
>
> /**
>  * smp_call_function_many(): Run a function on a set of CPUs.
>  * @mask: The set of cpus to run on (only runs on online subset).
>  * @func: The function to run. This must be fast and non-blocking.
>  * @info: An arbitrary pointer to pass to the function.
>  * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
>  *        (atomically) until function has completed on other CPUs. If
>  *        %SCF_RUN_LOCAL is set, the function will also be run locally
>  *        if the local CPU is set in the @cpumask.

@wait is not a bitmask, so the above description is not accurate.

>  *
>  * If @wait is true, then returns once @func has returned.
>  *
>  * You must not call this function with disabled interrupts or from a
>  * hardware interrupt handler or from a bottom half handler. Preemption
>  * must be disabled when calling this function.
>  */
>
> Based on this documentation, when the SCF_RUN_LOCAL flag is there and the=
 current CPU is in the mask, it will get called on local CPU also.

This applies to smp_call_function_many_cond() which is called by
smp_call_function_many() with the mask of either SCF_WAIT or 0.

In any case, the $subject patch isn't quite right.

