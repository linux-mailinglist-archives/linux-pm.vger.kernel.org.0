Return-Path: <linux-pm+bounces-37377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24811C32179
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BD97348226
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA72F5308;
	Tue,  4 Nov 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEvciSum"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53C23EAA4
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274257; cv=none; b=YKoMkYJc5HfwtmHbGqI5x/ML9f++cMgbx19aVXSNCq7XOw9AHSV7y5KAcuWU61R/NuejHExI/92hyIJnLmH/24X8iaGUsb4lH+k8ARpuzYyrJOBNsH4qFwJp3/5Gqb9mdMO3KAlPDvy8QJgCrURmQEfyS3tQuoJxSYX20TwfCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274257; c=relaxed/simple;
	bh=DuOOhubZcWA1xgwlxUOpIDKiy3RUsyOZEd3bVejwO5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZnnAhHZOrhxksX08jRNZWQpJjzmykw+zNOK23s6Mg2qGlxU22ihTbhb2J4/SaLT5I8ZfwPbYW1JaKdvKQ09IjKLmmNRiG8xKunVJPzQZ2+r7miV98v9NvCJSDkwugKD/h3AKK5bWx5KLVWVBZKrHUcPuo/b7JBGriZCsLCQDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEvciSum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4218C19423
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274256;
	bh=DuOOhubZcWA1xgwlxUOpIDKiy3RUsyOZEd3bVejwO5Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nEvciSumdSXML6/82981cg4ywxlDGMGJo2vxdJgHCvBVkwYLi/74Xg9omMac1D3pU
	 k4W4hkLmOSux9rCBsDqvuBfBU+tmRNC80e/gE52gYleWIENihN7SvHY1crzp8cG9ai
	 nulUxXNg8tr9g7srqY9Tujn5/h4+SejVFixj4OarIejH+EnUpR89ku1cNdgkwi7rJ9
	 ZC192t8HyneHE7+2VZRGW86Y+v1h0u3tpvIBAnFLJ1zh2qbURj2iR5DOWHyTuhw/Ut
	 DL70wEPdpG4MJH5mfcWPwTUrgHLTbWw6iBR9Ub92wpgE/smkeiBF82hczvm3oXrx8p
	 Ji5KdeR1eA96g==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3d322b3fd7eso2115671fac.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 08:37:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNZfmcZs7aI4+hjEfieb2z4UXtH1VUV0cc64hAh2O6xBRK0fS//1inqe2o1+JYAhhvTqKeLWSxOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzH76iYIo4hzUFhjy0wSOLcagXp66w/88fu5ljNs/td9CuqX7
	EIiFjes+YPGXLovMdoYZh+YKprfRu4FpjdIZn2x7FTYtmjEk0gY47Yos80TMuCxiS3EZ2xDVD/4
	b6AbiB0YOM+oUIA06vyiwL/xPCNo/1rw=
X-Google-Smtp-Source: AGHT+IFXhOxmxGRnAcwSt+4j7yeZnol49jxRf5wL+5NFterYp0qzsLK3BsehgdFzddQzZeagyb8msspIXFqt3WTKgmw=
X-Received: by 2002:a05:6871:e70e:b0:3cd:c87c:c639 with SMTP id
 586e51a60fabf-3daccf0f1d7mr7881618fac.49.1762274256026; Tue, 04 Nov 2025
 08:37:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org> <7h1pmik3w9.fsf@baylibre.com> <CAPDyKFr1bC1=3psegT0DM0tPQaCUm1DoOxV3xBa-gVV6oSuRVA@mail.gmail.com>
In-Reply-To: <CAPDyKFr1bC1=3psegT0DM0tPQaCUm1DoOxV3xBa-gVV6oSuRVA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Nov 2025 17:37:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gfd+nvvkthtjtKgw22kek02K68rOLYTy=a39D0uZYpMw@mail.gmail.com>
X-Gm-Features: AWmQ_bn6BjRKXNK8_yMwOIPmPhLg_KvpDrsfbP_oTSAaCe6f9Sz3SI5DxQrz6q4
Message-ID: <CAJZ5v0gfd+nvvkthtjtKgw22kek02K68rOLYTy=a39D0uZYpMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit
 during s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:10=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Sat, 1 Nov 2025 at 01:11, Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Ulf Hansson <ulf.hansson@linaro.org> writes:
> >
> > > A CPU system-wakeup QoS limit may have been requested by user-space. =
To
> > > avoid breaking this constraint when entering a low-power state during
> > > s2idle through genpd, let's extend the corresponding genpd governor f=
or
> > > CPUs. More precisely, during s2idle let the genpd governor select a
> > > suitable low-power state, by taking into account the QoS limit.
> >
> > In addition to a QoS limit requested by userspace, shouldn't any
> > per-device QoS limits from devices in the PM domain with CPUs/clusters
> > also be considered?
> >
> > Right now, if a device is in a PM domain that also contains CPUs, any
> > per-device QoS constraints for those devices should also impact the
> > state chosen by s2idle.
>
> I am not so sure about that. The existing dev PM QoS latency is
> targeted towards runtime suspend of a device and the genpd governor
> also takes it into account for this use case.
>
> If we would start to take the same dev PM QoS latency constraint into
> account for system suspend (s2idle), it may not be what the user
> really intended. Instead, I think we should consider extending the dev
> PM QoS interface, to allow the user to set a specific latency limit
> for system wakeup. Then the genpd governor should take that into
> account for s2idle.
>
> >
> > I just tried a quick hack of extending you cpu_system_power_down_ok()
> > function to look for any per-device QoS constraints set all devices in
> > the PM domain (and subdomains).  It takes the min of all the per-device
> > QoS constratins, compares it to the one from userspace, and uses the mi=
n
> > of those to decide the genpd state.
> >
> > That has the effect I'm after, but curious what you think about the
> > usecase and the idea?
>
> It makes sense, but as stated above, I think we need a new QoS limit
> specific for system suspend.
>
> Rafael, what's your thoughts around this?

Well, it's analogous to the CPU latency limit case, so if a new
"system suspend" QoS limit is introduced for CPUs, that also needs to
be done for the other devices.

However, as in the CPU case, my personal view is that the "system
suspend" latency limits should be greater than or equal to the
corresponding latency limits for runtime PM.

One more thing that has just occurred to me is that there are systems
in which I don't want to enable the "system suspend" limits at all.
IOW, all of this needs to be disabled unless the platform opts in.

