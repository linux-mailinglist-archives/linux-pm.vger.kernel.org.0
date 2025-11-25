Return-Path: <linux-pm+bounces-38642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD06C866AB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DED3A3C60
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BCB28725A;
	Tue, 25 Nov 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTEmjSzk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345520C48A
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093793; cv=none; b=GvS6KfIkeJxn9S8zRCaiBzkfru8b/4GwCorZ6Yhvyn8B/v9IOdIg2m7SeBsOhjedOvL05QHwC+jEuCnxTsU1Q0WDk80UuEir5fs7/PUP/l9N8S9mfcwrF69cCx9ISIM993ii0pkSzaRy1gnZtPFHeby/l5KJZdqeqJJ5sCX/yPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093793; c=relaxed/simple;
	bh=0JkrhCzltkWDo+Dw8ucEAhb81EDWGWcWIxkpr7glq+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxOlrhqSabuqbArvMxQ046OzI1snKOf+sYLUOuJSfQxriE19KxzhXfUqvQF6g6bTGHWW4em9w9ExII8cyuVF08dxkmUwWQu1J9XgbON44uH1gL1hBgIT0VQ9wd8CknU8qm4+QDc3dwwcd7CWNnppYj7bBf+kkdwWaxLNXDwMXmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTEmjSzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8564C19425
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764093792;
	bh=0JkrhCzltkWDo+Dw8ucEAhb81EDWGWcWIxkpr7glq+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oTEmjSzkO7PuyFagvuM80ZVZba/4Gn1GSDzabkCY19MTt/oXonMRyL0+NBuX36qLc
	 Opa4CmbuK554jfVwW8ld9/6Iu09N87n7zHCJxbph7/kulYRb760Cdt4lGrpNL9ngEc
	 MXx5xYOvLf7DGRbOfnCrYs6FAudSvsVH66lMvp/URecXUK1FuLU2Diqq4ARuH1gxSI
	 ZNXxWRD/DLddmtShM0KBS57IwjjFtV1nvRf9IqthZM5eREDBvgtSY4OyGeUBbOOhVF
	 To1bevjHS4rQ2tBBX0ERyf+cet2qnXDore4tqoq4UWCINNm24YsZ8IVP8TDUOeVryd
	 eUJZS70fQF+eQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3e3dac349easo4599577fac.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 10:03:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtaQm1mZ+jB6pJfSt8VUhW5cHp51LkYp6rhIlL+5T54c9Y5KxfX0xuqS+i+szULmwBqchyrjVWgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcVnTfDDYriKoAd3ui71ibv3zCkhc3dI4M/MM4YNdWo8AMGC2
	zKlurKz3CcduuBO2N2ya2TZvg8kLLrbjL6ufC03JiYQG1F2sHrOcdI42qsZtbcRPvqVnDBz3Oc2
	CEM5qvMrEg7X7d2zllnslnfjbWVY68Ng=
X-Google-Smtp-Source: AGHT+IFDsJ4jLmbW178zrQWJ9I9C7ZENJibSMzqAIw1jBWqyQLd9c8jHQIAvzNKALqtg8n31enhfAXdhfoFEHEFrlBE=
X-Received: by 2002:a05:6808:1982:b0:450:c916:10b with SMTP id
 5614622812f47-45115b2f8e4mr6202905b6e.54.1764093792158; Tue, 25 Nov 2025
 10:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125112650.329269-1-ulf.hansson@linaro.org>
In-Reply-To: <20251125112650.329269-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 19:03:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0he17_Nc_Hpf0D1sgLBwpup_Hexzx1ZrKJ85t1sOjdNVw@mail.gmail.com>
X-Gm-Features: AWmQ_blOlpxVnTbeEvTIyIyHY0DVCf-v79LfUDDQy2ddHpl1m3IrnXpIpISsfRI
Message-ID: <CAJZ5v0he17_Nc_Hpf0D1sgLBwpup_Hexzx1ZrKJ85t1sOjdNVw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] PM: QoS: Introduce a CPU system wakeup QoS limit
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

On Tue, Nov 25, 2025 at 12:26=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> Changes in v4:
>         - Add Kconfig help text. (Dhruva)
>         - Fixed grammar in documentation patch (Dhruva)
>         - Added reviewed/tested-by tags from Dhruva/Kevin. I leave Rafael=
 to add
>         his tags when applying.
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
>  kernel/power/Kconfig                     |  11 +++
>  kernel/power/qos.c                       | 106 +++++++++++++++++++++++
>  kernel/sched/idle.c                      |  12 +--
>  12 files changed, 203 insertions(+), 19 deletions(-)
>
> --

Applied as 6.19 material, thanks!

