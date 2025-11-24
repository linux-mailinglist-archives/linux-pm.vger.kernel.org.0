Return-Path: <linux-pm+bounces-38495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F295C82197
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF8A0349ED4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE93176E4;
	Mon, 24 Nov 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SakJgkc6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B82BDC01
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008867; cv=none; b=uWpUkk2vvJlSumGZHFrsLxqbKA5DoUx2m5qLiveJVfjqsdLoC27AX8Sxtde4IhReK7k3DPYQhYmNdVhuXyY85djjuBVLVWgCxyNJMnlNlqIXw6z8zLVXxk/7S0Uuqn5yNRXbXFzvfoRCBKMaBFqSSoORjVaIKclnIFsSGwe3INE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008867; c=relaxed/simple;
	bh=8byaOLwo4uDVw5gBdl0gtRaBqH+dqIab923xS2STHNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPqQNR1B/kn603dW/kfmu8jd4pOYLw+flFpEmRcpsyGKFSAFLTFjzvcFNrSaTY0oVkhPZl1UFNyKmV+FRHMwR8wE+5xdGTr/9gIvjBr29vlQ0zbCELUvBlD0elxucY75EtPP5xwc0D9Ad2pfpaviAe0lGkpxlbA4IyQSf41YfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SakJgkc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC75C19424
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 18:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764008867;
	bh=8byaOLwo4uDVw5gBdl0gtRaBqH+dqIab923xS2STHNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SakJgkc6hFSQhLj++E/Cz/whWlA8T764ij2b83hrelPHKHgSFDynjM6xy1jiDT+qr
	 LICzGve7fBkcVPt6u9WgvJD4WQ9G/uEg74dqfUrUX12bu5cNsUXt2Qf3+AghUaip3N
	 cKazq3ZvyIUNIYKFfS0hh4ahWz1Io+6C9RdzCfVXAyCJKRbboFljIWr2jdgvLtwyqE
	 SdGdztyx6UV0uszq7ta5B/VWLW5khQE/kggnepgbQavsykR5vx7TyFrVE/M6xk4Tvn
	 O37Vfdh3YKGXgun2Gc7L3QRa8ldAN/32SiyML/ag7sFILru85AfHKilRv78mJ2x1Cc
	 mRwXI8JDvdOhQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso2920782fac.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:27:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1wAOoxaZ9ZcD+/6R3cKsjoTK6Blxdh4NAX9hMGLDvNY+UwyMBpfjx6PPqHomIVWoM4U8red5Caw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoPDlUEyN8/rkO7mTrxptzfiqX5mMrnxDszX/zZcwhhgB9jDw
	w0iyE3EZZGb+MXesykYP+lp9RFDa/7p/NLMgvalaWEzxuTRPExdNrD8wCzlhGZNOREpokqaEWr0
	sg/O9PcgOW0zRbRUzEeZ858JofCXVAHI=
X-Google-Smtp-Source: AGHT+IHiT779TlZgAXaUCLPFOmJ0ecLDMCNNvyeZH0k9+HfoaNMPLHNLq8e1cw5TEEm4eB7SzvFSK7mAH5UDLGgY4es=
X-Received: by 2002:a05:6808:f8b:b0:451:4da2:47d1 with SMTP id
 5614622812f47-4514e7dca89mr37517b6e.45.1764008866635; Mon, 24 Nov 2025
 10:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
In-Reply-To: <20251121100315.316300-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 19:27:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hz+gMnnPVX=uT3dh0tSoaATVOzwrhdBoupeYFgo6Rqkw@mail.gmail.com>
X-Gm-Features: AWmQ_bnjfbue2qetMIaVjUDdBXhGG5bWiDnOFKILuIA3dwrlu9zw9RaMM71Oy0M
Message-ID: <CAJZ5v0hz+gMnnPVX=uT3dh0tSoaATVOzwrhdBoupeYFgo6Rqkw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] PM: QoS: Introduce a CPU system wakeup QoS limit
 for s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Dhruva Gole <d-gole@ti.com>, 
	Deepti Jaggi <quic_djaggi@quicinc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 11:03=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> Changes in v3:
>         - Take new the new QoS limit into account for cpuidle too (Rafael=
).
>         - Add a new Kconfig for the new QoS interface (Rafael)
>         - Improved the documentation (Dhruva)
>         - Clarified commit messages and added acks.
>
> Changes in v2:
>         - Limit the new QoS to CPUs  and make some corresponding renaming=
 of the
>         functions along with name of the device node for user space.
>         - Make sure we deal with the failure/error path correctly when th=
ere are
>         no state available for s2idle.
>         - Add documentation.
>
> Some platforms supports multiple low power states for CPUs that can be us=
ed
> when entering system-wide suspend and s2idle in particular. Currently we =
are
> always selecting the deepest possible state for the CPUs, which can break=
 the
> system wakeup latency constraint that may be required for a use case.
>
> Therefore, this series suggests to introduce a new interface for user spa=
ce,
> allowing us to specify the CPU system wakeup QoS limit. The QoS limit is =
then
> taken into account when selecting a suitable low power state for s2idle/c=
puidle.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (6):
>   PM: QoS: Introduce a CPU system wakeup QoS limit
>   pmdomain: Respect the CPU system wakeup QoS limit for s2idle
>   pmdomain: Respect the CPU system wakeup QoS limit for cpuidle
>   sched: idle: Respect the CPU system wakeup QoS limit for s2idle
>   cpuidle: Respect the CPU system wakeup QoS limit for cpuidle
>   Documentation: power/cpuidle: Document the CPU system wakeup latency
>     QoS
>
>  Documentation/admin-guide/pm/cpuidle.rst |   9 ++
>  Documentation/power/pm_qos_interface.rst |   9 +-
>  drivers/cpuidle/cpuidle.c                |  12 +--
>  drivers/cpuidle/governor.c               |   4 +
>  drivers/pmdomain/core.c                  |  10 ++-
>  drivers/pmdomain/governor.c              |  33 ++++++-
>  include/linux/cpuidle.h                  |   6 +-
>  include/linux/pm_domain.h                |   1 +
>  include/linux/pm_qos.h                   |   9 ++
>  kernel/power/Kconfig                     |   4 +
>  kernel/power/qos.c                       | 106 +++++++++++++++++++++++
>  kernel/sched/idle.c                      |  12 +--
>  12 files changed, 196 insertions(+), 19 deletions(-)
>
> --

It looks good to me now.

Do you want me to pick it up or do you want to route it differently?

