Return-Path: <linux-pm+bounces-27503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A2AC0924
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08290173663
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427681C3C04;
	Thu, 22 May 2025 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOGhBB7A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129153C38;
	Thu, 22 May 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907796; cv=none; b=ipHVCThUlg2XUcE7yqOmKp+TOlMKCb49rHI9l5d7buNsqC8UsviF6L1cDMUlz8MtUCEIEog8mZOayPC5SKZP3e2mVzZoUAlkxlB2kzCdBfSN9Y9n5UMN48KUecCGv3zETkzGc0mg3vihMpSVk2MZPlWLuyuWIk9b1q3iPRS5cuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907796; c=relaxed/simple;
	bh=l+UBCZ90uofbpfwu3YkJzh8e5MpIZHy9Wgl4VOlqqQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDBf+lfVdHRyiPxybkixwWfyNwWd6uvef5b4bOsrUCn11uiF+C2dB7ogwqQAPwi+/jg/u7qrF6d54X23hw3uVG87cSCqfC9OSESZRwxcw1iSnPkHFabQaecNQaHW6/u7Jjnm5WnLBe1JLBS43WOZt7ha/1orFF3Jg2crbxbiEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOGhBB7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74330C4CEE4;
	Thu, 22 May 2025 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747907794;
	bh=l+UBCZ90uofbpfwu3YkJzh8e5MpIZHy9Wgl4VOlqqQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sOGhBB7AyYSHlj7s2xcnLFewRhTps5gnKReHSzWTEv8zi3E98oOyS9oyoqLK62vRu
	 jyy8rRfgpQAnXZ9HZ7zBzmKaeTZjRs229VPnKLG4KGH5kysl1/rf2OAQs9qmZF0P6Y
	 7BfzEdsSSvIYATjrOFYUAizciWlFftbXCaGf7zk5RFEJBhbf6KOBqoJkUoHPjBEWwQ
	 TCmW1vWkXLUI3xdgV8BIgDkmwzXtewI7CU144XoA371TaF9OepfCpmvBtVWDh/2/Hq
	 kdHh0ZgNC8DOm2qQQDUmgkDCff9h+jbflCaglp92F4i7Drkub1MdLT9sZ6g8QDSBId
	 gN/o3tp9TnZ0Q==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-604f0d27c24so4082080eaf.2;
        Thu, 22 May 2025 02:56:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWUfWuPSb0mbGJJmzPD+HZTF5QDVVNbmuiV5jyc4IOt5S/O77zDTrU56WFueqTG+el3mA5n54ovlc=@vger.kernel.org, AJvYcCV1CNCVHuuhTGkP7wH0Bic1//mbV0OXRimpjDDLZQnZfB9pROJyPXbZ9fFm013XyEBHlw6MyawSJMQ=@vger.kernel.org, AJvYcCVBF9KMq/Lj59JBfxHM/0b8It6hJO75ecWY863rp1x26BBbrLGOhhYQbz2KZbCgJG32OtwHCcL7Kf34kqWv@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrT4x94uWNozXSS2WduA4Gu9wg7Vre62mH/Rkl3nkrSSxfck0
	E/FAfAQp6lWnE+vioOujvx6BCkuG5ghjHhGam3KTEA8oDBf29r7NtthpOla+0z3z/R4HxShth/C
	AIQOROsAd3Wr5xetxisSwFwDCLEHQsMQ=
X-Google-Smtp-Source: AGHT+IFDlauQgvFUHi7zRroxnG0JT5GL+TEEToKRpHxNLwLE2g/bn421wTKa1Lj6BeKs24deqdV/eZDC+3zwVRMva/k=
X-Received: by 2002:a4a:ec49:0:b0:607:dd61:9c33 with SMTP id
 006d021491bc7-609f48646b0mr13509442eaf.1.1747907793770; Thu, 22 May 2025
 02:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com> <aC7yeQvKVQ1No9EW@JPC00244420>
In-Reply-To: <aC7yeQvKVQ1No9EW@JPC00244420>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 May 2025 11:56:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6i6xt5-QOU2r0MDxR+7aOXYBUJ4kkJFQg6+RekayTNQ@mail.gmail.com>
X-Gm-Features: AX0GCFuDeg96kru4SyCumlyfA3Q7mWIK4DCxHnyPBE6HaK68vl43j7pxhzrRxqk
Message-ID: <CAJZ5v0i6i6xt5-QOU2r0MDxR+7aOXYBUJ4kkJFQg6+RekayTNQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Russell Haley <yumpusamongus@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 11:46=E2=80=AFAM Shashank Balaji
<shashank.mahadasyam@sony.com> wrote:
>
> Hi Russell,
>
> On Thu, May 22, 2025 at 03:50:55AM -0500, Russell Haley wrote:
> > If the user asks for the frequency to be set from userspace, the
> > frequency had damn well better be set from userspace.
>
> First of all, I agree with you. In fact, before sending this patch, I
> was considering adding CPUFREQ_GOV_STRICT_TARGET to the userspace
> governor. intel_pstate should handle the rest of it.

This wouldn't work the way you expect, though.  It would cause the
driver to always set the frequency to policy->max.

> > In my opinion, the documentation is correct, and it is the
> > implementation in intel_pstate that is wrong. If the user wanted two
> > separate knobs that control the minimum and maximum frequencies, they
> > could leave intel_pstate in "active" mode and change scaling_min_freq
> > and scaling_max_freq.
>
> If intel_pstate is left in "active" mode, then userspace can't use any
> of the other governors. Moreover, intel_pstate's min and max frequencies
> apply to all the cpus.

That's not true.

scaling_min_freq and scaling_max_freq is per CPU, but the values from
there are subject to hardware coordination.

> Whereas, the userspace governor can be set on a per-cpu basis.

This is also subject to hardware coordination.

> Let's say this is "fixed" by adding CPUFREQ_GOV_STRICT_TARGET flag to
> the userspace governor. Then userspace has no way to get back the
> current behavior where the hardware automagically increases frequency
> beyond the target frequency. At least not without a new interface.
>
> With the current behaviour, userspace can have it both ways:
>     - actual frequency =3D target frequency
>     - actual frequency >=3D target frequency
>
> And the occasional higher frequency shouldn't hurt performance, right?
> But if they still want exact equality, with the current interface, they
> can do that too.
>
> This consideration is what led me to document the "actual freq >=3D targe=
t
> freq" rather than patch it so that "actual freq =3D target freq".

The documentation can be adjusted by replacing "set" with "request" in
the userspace governor description and adding a clarification to it
that the requested frequency is between the policy min and max levels.

With HWP enabled, the closest to setting the frequency to a specific
value one can get is by setting scaling_min_freq and scaling_max_freq
to that value.

