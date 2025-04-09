Return-Path: <linux-pm+bounces-25008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB02A8243B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 14:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18B38A59E6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F88625E475;
	Wed,  9 Apr 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnESXfsP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629325DAF1;
	Wed,  9 Apr 2025 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200427; cv=none; b=f2BegTnrGOl2V6WgTzIcCNuu643Z9uKKHcee1Sl4pcZnYntu8Pd4FX4vfY7ZuJUWQOtytmNFvR3cT0g8poJGqIrh2YsdbGLfh7wfZreJKD9itDlx5qoou70fyGrO7qh6vVggmKd+J0nSsX7yQUwg5x8wQ9Hx4VwHJkQ312SMvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200427; c=relaxed/simple;
	bh=BwNeimq54CTkvFpSGiKXiYXjx08EMGJ9jbsWqhvChmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eni6827s8xjd+mgoOubnEgDLCXUgtuXXdZs4kaHCUKcO1cOzYnMv1qE7jyhTTaoUOxAV6IHpj38iNvefQh8ODbRJBtR+qFzXMs/jtlw/ygfuvxwR27logZ8hdCPdjP7ZNX/B//kKINv82WeK4bTTMLI1PvqTULRGNtHury7ZZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnESXfsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9119FC4CEED;
	Wed,  9 Apr 2025 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744200426;
	bh=BwNeimq54CTkvFpSGiKXiYXjx08EMGJ9jbsWqhvChmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MnESXfsPE0sLlqc3vxCHtsUA//CG30IpEbjXZLNIWtTHTpzLFLa7183Wu1lIrd2Yk
	 4hGtESN7vf35UjhpIvsBXNOhMCf88Vkji+xEHAhoZfSAunhkt9cA3KhV4ejjDnd8x6
	 M7geIj2dV0s2K0jtn1avnnlgBb8VKyCG3WUEFwHIEf5RvVjaYFJ8dTYvMqHYKuaU9I
	 QZaXziHkJbWEVOmw/U3ZNVhOouAaR5i1U3OObgPogWydxPgjSiEHVNsgxR718lwJgr
	 VjabyVi7UvE5UJ0BfWU84CKLRX8fDPb8exhpbR9MNQzMfOIkvkDyZpBtVzRaMGG+Ad
	 0VDjAY6SxtkRA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c7f876b320so3852898fac.1;
        Wed, 09 Apr 2025 05:07:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxqQ1+QSZxKPSPa1dOQhUw3Ebhp0667C89eUPoyMhmAPrIJsuxugsezO0SF3oG0ZAp7f/WKmmTEA8=@vger.kernel.org, AJvYcCWVoXMPXQXAJREXf68Sff+lVV/EwGz0lfICLe6mYtBxzxE8hqNBowlpoHJfcD1c67AjKrFhATxdIlfyWsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx87hFAzja+nwWqmln+h3cRbB6OQz6AUr29SqVqAmgzMSB+hxD
	E+QhYejB5zivGa1D10iw83NXbccjAr+T5teGBXtGb18LF2jHpW/W61nkkciN/TIoJo0im8RlQxP
	FBW3QedACo94MpOQ6uQJyP9NcCC0=
X-Google-Smtp-Source: AGHT+IHVqCCnJuQty5MXTBD8rmwgBf/nXLO4eE3vdP9++XGNhRQpIv1iVi/1uJsF8s+zaA1huDaB+EFNKjXL9KOJun4=
X-Received: by 2002:a05:6871:2b03:b0:2c2:5a63:9cd4 with SMTP id
 586e51a60fabf-2d08dde7200mr1144222fac.19.1744200425848; Wed, 09 Apr 2025
 05:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4661520.LvFx2qVVIh@rjwysocki.net> <3892c0eb983900c184c6d06ffe8364e2da23ae2a.camel@linux.intel.com>
In-Reply-To: <3892c0eb983900c184c6d06ffe8364e2da23ae2a.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 14:06:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJpXBp5A-ozrjFeG=m+wj2NJYOwNPy-NAgKNXR2ySYYg@mail.gmail.com>
X-Gm-Features: ATxdqUESgrWGwfTn-3mvYnvHO1qukxgxAr4ejQGffm43awB-XDAHQ_oDcP1Xw8o
Message-ID: <CAJZ5v0iJpXBp5A-ozrjFeG=m+wj2NJYOwNPy-NAgKNXR2ySYYg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] cpuidle: teo: Refine handling of short idle intervals
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, Doug Smythies <dsmythies@telus.net>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 8:52=E2=80=AFAM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> On Thu, 2025-04-03 at 21:16 +0200, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This series is intended to address an issue with overly aggressive sele=
ction
> > of idle state 0 (the polling state) in teo on x86 in some cases when ti=
mer
> > wakeups dominate the CPU wakeup pattern.
>
> Hi Rafael, I ran SPECjbb2015 with and without these 2 patches on Granite =
Rapids
> Xeon (GNR).
>
> Expectation: no measurable difference, because there is almost no POLL in=
 case
> of SPECjbb2015 on GNR.
>
> Result: no measurable difference.
>
> Conclusion: these 2 patches do not introduce a regression as measured by
> SPECjbb2015 on GNR.
>
> "No regression" is also a useful piece of information, so reporting.

Thank you!

