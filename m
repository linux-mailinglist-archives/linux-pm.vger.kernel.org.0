Return-Path: <linux-pm+bounces-26120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D1A9ABB1
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304D74A074C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802981E22FC;
	Thu, 24 Apr 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHkrkaca"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3E433A8;
	Thu, 24 Apr 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494048; cv=none; b=qBrs8LNvZrnsMkVUPnj+m2QA4nlQNkONJRM8lMgKTXK+/HmZEKHQDxO0qOTThnbcOMk48ov47rZPGB8qs8jO/tPXmSE95Su6OcEXK9N2g32sVxQKNdxuj4tCTPYU9YHFue+pWjdBfOjtOhfNsFHQU+1z86qOizVeBoD/dyLcv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494048; c=relaxed/simple;
	bh=ZKF2QECobulnLVEGQEPeyx3584MvFvZQWdvewYUROlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tv5FLh44QERrQroBT8wVNM9OCaVIsAVza8VeDDocB8pGesX3AAIxgTqqFd2J/GVvE86F8N7Nag5gwN0HVTDxie+mBgFGzMnY31kiZBDbIFLvZts6+HBVZV3FQvQqWTjJ6IFpiVJWRXVB2+0ByAqQh+b7uQdYp0cXwT5FivMNJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHkrkaca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF609C4AF09;
	Thu, 24 Apr 2025 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745494047;
	bh=ZKF2QECobulnLVEGQEPeyx3584MvFvZQWdvewYUROlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qHkrkacay3Bfu+9Ocvc/zxaS/Ggg2n/d3SDkpreLqE0VhZJFPaYAkJng6il8q/7c5
	 MIIDMK82Qvp0idpCbiKbupsY1D5kYL5rhQ59829bIjlKCQTI4d5QnSHkVd5CJ04hwO
	 j8RRlGuhmJT094qplQH0ffr66UhzcSPpQ/ueNtLpp1Pk1fZVlAptddLfA1bceXj1Fq
	 uIzR23PNagCWBILy9icYMedHRzGy6D78d4gxRlAKB+qnOPLUmzmNPFTYicG7CQgGSs
	 y+yuf+YEBEuRiEJInuKb/vuAsUkr62eySUFpKeOzg9UmF+B/izMYCM28FzFn0MJG68
	 UuouYj02kanvA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c12b7af278so711557fac.0;
        Thu, 24 Apr 2025 04:27:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURhAqnCq9LUCNyPM/QzFH1H0E1B5yr2Iv9c/tp+9vi1On3YUWF1OwL0JPH9o6M5GeqkGgsW0fHUq4=@vger.kernel.org, AJvYcCXU82iH5TlMCSNQgV6j7Lb2M4XYdRNGBEUpvWa0pieskuqTWuQ9yVrlUuY4gnIXQTJxkJz/i0wvDpt4q1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthgWlrh1AqF/lRRkZR36mwVPn75fspRGzBKlvv7nMfr6UEh9r
	HR6fS4sZsPUP8f7JuN27QTrALv353uQ4hohYckPStIkxt9GtcJGR/FaE4NCmNABvXo+1HOd93D1
	2ppoIoKx5yd+6dXEpQCklN7Zzwao=
X-Google-Smtp-Source: AGHT+IGoZpN0YNiFTDrLlk6bmcMJEaJw+sl2gozWoaTpEoqU6WTcPRgzvsI81WnKOWJoSnwn7SZi6Q0Perwz/Zh1eok=
X-Received: by 2002:a05:6871:208c:b0:2d6:8eb:8918 with SMTP id
 586e51a60fabf-2d973164ae8mr956413fac.7.1745494047162; Thu, 24 Apr 2025
 04:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745315548.git.viresh.kumar@linaro.org> <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0hWUdRdbPL2=qybaEsNfPzAqdxW+xBrjwy4HaBXnTwD0g@mail.gmail.com>
 <CAJZ5v0jFy9ch4ZcW_zQs6GfvB=LCnzm94d35ifMpdv=VrqTHQA@mail.gmail.com>
 <CAJZ5v0jenM_pYUkTv-qPV21tok15R+KfT497itPO=fLUywDKqw@mail.gmail.com> <20250424072728.bbcbbcxv7x4cumck@vireshk-i7>
In-Reply-To: <20250424072728.bbcbbcxv7x4cumck@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Apr 2025 13:27:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jNFkGJa4TOsqksQg5f9BYQx+D0DA=3=XE_nMByyOxcyg@mail.gmail.com>
X-Gm-Features: ATxdqUH79ej9JARLMo_gNdXFt3LyKtpM79ZEg3_8dc1pYBe4UAw_UvzlkDWCfbs
Message-ID: <CAJZ5v0jNFkGJa4TOsqksQg5f9BYQx+D0DA=3=XE_nMByyOxcyg@mail.gmail.com>
Subject: Re: [PATCH 2/6] cpufreq: acpi: Re-sync CPU boost state on system resume
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Nicholas Chin <nic.c3.14@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 9:27=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 23-04-25, 16:59, Rafael J. Wysocki wrote:
> > On Wed, Apr 23, 2025 at 4:40=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > > > IIUC policy->boost_enabled is false at this point, so say that
> > > > boost_state(cpu) returns true and say cpufreq_boost_enabled() retur=
ns
> > > > false.
> > >
> > > This cannot happen for CPU 0 because of acpi_cpufreq_boost_init() ->
>
> Right.
>
> > > > cpufreq_online() will see policy->boost_enabled =3D=3D
> > > > cpufreq_boost_enabled(), so it won't do anything regarding boost, a=
nd
> > > > say that this happens for all online CPUs.
> > >
> > > -> so if boost_state(0) returns true, policy->boost_enabled will be
> > > set for all policies to start with due to the code in
> > > cpufreq_online(), but this is far from obvious.
>
> > > I would at least say in the changelog that set_boost() need not be
> > > called directly at the policy initialization time because of the
> > > above.
>
> Sure.
>
> > I also think that acpi_cpufreq_resume() may be a better place for
> > re-syncing the boost state with policy->boost_enabled because it may
> > do that for CPU 0 as well as for the non-boot CPUs.
>
> I thought about that but kept this in acpi_cpufreq_cpu_init() as there
> are other corner cases too. A simple CPU hotplug (without
> suspend/resume) for example. In that case exit/init will get called
> but not resume.

Fair enough.

