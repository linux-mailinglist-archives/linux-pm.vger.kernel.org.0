Return-Path: <linux-pm+bounces-25628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17ACA91C7E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D190188A391
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051023F26A;
	Thu, 17 Apr 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwJiZBMz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA4433A4;
	Thu, 17 Apr 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893595; cv=none; b=EaB2QMLpUK9AwUisquFgSUqXQUr6YK9oQH3Q9XNAxdYEwJweTc/PBKOq/LtcvSo/f2XwHmOxuh+HgYzvQwx/wRrbQM7SBin+ixEhcnajD7sPWhdeqjGEdrtf4jljg0nb1QRi/TfYBqbdd67lpp3i4IC5UxwOPoLuedDxGnppTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893595; c=relaxed/simple;
	bh=eLj7R8phBBElsYRDrQHT8P+l90EZfuo0+Uzh9OS6ikQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ9vH4/0hDiZCPe++6VXJWHn/O+i//hIKrMPniLucYm6lwaa4bJHXlNLKO0OfGc0EunNfk+xWEIIeI48ax3Ngk9NibwtngvJerKM1rwjJ0BVk7n8ubei+qd8TBF/cLQMtuO6ifFPvRgF44PXyAj+h9d5AmXYFFTFxHdDJFzTyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwJiZBMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F56C4CEEB;
	Thu, 17 Apr 2025 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744893595;
	bh=eLj7R8phBBElsYRDrQHT8P+l90EZfuo0+Uzh9OS6ikQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TwJiZBMzZLnoDSSwd7NBmdOdrKp7Ric5v5Wxmms25sfFS+WP3gebE/K4nMwU+RI7m
	 khv7vJbjl/zh4yXSv2wiutfPbgtJCvNwGJhRiJIKTKWuoZk4jjZhcLeBll4JeRnbQz
	 os4QRO7v8Fb8e/Z0V9AfcrQs6byxwb+3zwaX5l2E9C2RdvdFJln0eVfYAh+VSlVeLL
	 gUik7O+11A9QFfcer4YXzaOJmBi6G8hnT7areJ0pJtJ2sA8Jh4V+lUeFju+VwUW4tu
	 vY8AG1tfk4KCxTjO9TZeo9Yjt8AKmRseVs0mNn6Kqizyr8cnu1cTEzga2wc+Y8HjG8
	 yZ9gk2CE4YrBg==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72a4793d4e2so439976a34.2;
        Thu, 17 Apr 2025 05:39:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6IYdaoDtOOshi74HJ44TkmhpbqE9XxtNHcH6QU2Ym0aRnKZ3fnuodjQaURO4BixaMq78YYUCG/Ck=@vger.kernel.org, AJvYcCXRXbKV2cSVcfiXymPACG3Ke0oAA2kAY87LEX1VUX6fH8/8CLaLxomtGOYpSJdxv+amL96w9Zq8v9ZblaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3T1DXhkSnL/Sf+7xGMfY6uXnomWYPW+gC+FPAm7NSRDpWKre4
	8LxznLc1qNPn5VqXMA0fjBcPXbLPQa+n1qRnfa5CqExF6XkZh6kH4iQ05kIm2lAAEpWhA4YQxNG
	r2cFGgncDiD2GChUG+f6F4/Gp43o=
X-Google-Smtp-Source: AGHT+IFA8iU1qJvlKUs1pUOZAThmJzcJGxHgdwHwSAcBFkQkXCxuYhMfRqt9sBhJ0CdGMWGQ5G+hhH8sxutROVa4Ids=
X-Received: by 2002:a05:6871:2083:b0:29e:2da3:3f7b with SMTP id
 586e51a60fabf-2d4d29d7d61mr3284724fac.7.1744893594640; Thu, 17 Apr 2025
 05:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com> <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
In-Reply-To: <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 14:39:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
X-Gm-Features: ATxdqUHxL_09M8-Iuvj-KLdobmF2J2sovGq5uwpr4jjnpmSvUwcMl5fpjTRG6PI
Message-ID: <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rafael@kernel.org, 
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 7:09=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Copying more information from Bugzilla here (Nicholas, it would be
> faster if you can put all your observations here first, more people
> are looking at emails than bugzilla).
>
> > Nicholas Chin wrote:
> > I did some more testing and debugging and it seems like when
> > cpufreq_online() runs after waking the system, policy->boost_enabled
> > and cpufreq_boost_enabled() are both 0, so the set_boost() at the end
> > of that function is never run.
>
> Right, this is what I wanted to do with the $Subject patch. Don't
> update boost anymore in suspend/resume

This is going to work for suspend-to-idle, but not necessarily for S3.

BTW, the patch is correct IMV, so I'm not going to drop it, but it
looks like something more is needed on top of it.

> > cpufreq_boost_enabled() being 0 indicates that the MSR has boosting
> > disabled, but when I read out that MSR using rdmsr the bit seems to
> > indicate that it is actually enabled (I am aware of the inverted logic
> > of that bit). set_boost() seems to be the only place in the kernel
> > that causes that MSR to be modified, and I didn't see any extra calls
> > to it in my debug logs, so it seems like something else (outside the
> > kernel?) is setting that MSR.
>
> And this is what I feel too, something else in kernel or outside of it
> is doing something tricky.

On a resume from S3, you actually don't know if the platform firmware
has preserved the configuration from before the suspend transition.
It may not.

