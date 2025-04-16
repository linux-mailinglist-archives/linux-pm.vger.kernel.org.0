Return-Path: <linux-pm+bounces-25566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A050BA907B9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 17:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AD8165548
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DD20E007;
	Wed, 16 Apr 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgviw3OR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73E20CCED;
	Wed, 16 Apr 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817314; cv=none; b=Rjh3NH5NLxevyolJIQq/wCnrPePZYis6aS2cifbcl5RVFVlxGUroli1vMMaaXZ7oXUjoEfNLNLehKA8AtfLq9pRZqVUi+3FzIA/qgdPYeDrZaKGBw/+Iq+ziRuNZ9tUkLtkpzFVOPGeCBr4mk/J9OuD0R0Adju5QiRh41HzIALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817314; c=relaxed/simple;
	bh=MsjbhaOEphesSSCIElxFHXGU2418nAkZZ+N11+IBNWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY6KY0CrdFK5JBiRniCPxUWIUxwfKvA9LNCkZVWV5uzgMR7mYQqFQ987dbExgFXsszREBSog1vuFWu7OVRbuF2Df59i4MSvxcf8KDclGlOG5UIMO1+VqI8ndxFqytbapyCUqPsXiUHkYLPuv8aSrgAhtdyn4AgZz6kl0k4bUv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgviw3OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAABAC4AF0B;
	Wed, 16 Apr 2025 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744817313;
	bh=MsjbhaOEphesSSCIElxFHXGU2418nAkZZ+N11+IBNWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hgviw3OR/US8/QNzOjmDG46VPiKo/APFf5VruUj/KrYzyvMj0e/GNrFxYYJJL+0+W
	 IGbZrqryRP/TJTl56CX/gdMzTcJr2egUeYGEylvZGjZIAsH8f0+I8BiXxomlCin4g8
	 XsuDWilSzul+C8j8stpxRdwDT8mk/hdkn3TNHzedXAn1WfUezihb33uvGElVCRCz5x
	 h9qhSSgP3LGtR6C7xk7FZDkKyIOIoiz+Jy6lI9SuScAmcNSQgw7isJWQl4VbQ8PSmF
	 agUxJBtcphNn5AN6Rj8V4JrrBTt3Qk4JcktnxhTgB3zk3jNsmW382fATnYEGPkOxtz
	 CfLzUGaaCpS+g==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c172f1de1so3887292a34.3;
        Wed, 16 Apr 2025 08:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUw5mt3STlqBNcDAkl62cQGORBuqp2CZwgJI2hUdutc82YORvC3uHjrseJUe+cEz4Bmv/aRVcgl1Wp0xpQ=@vger.kernel.org, AJvYcCWypInSIbSauylpt/f8AbUXxs+QwpBAUDRpmCpzwEO8u4zaWYFdpnYM9Mv9sX0ledDYRnLL0jpE8y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eInft4AeM5BQPlg1OvDketdYpXMiYyzxD+Gjfifh/bC+1AB6
	N+fiuALQrj9Ypf1SUgTVllJrQAv7I6U4jO5rwJE80JLjsOn9SZGAAs7oRjA/LkB/tn3+cOawFBC
	++Wm8Qb5ocjsiBPeQfpwaBiFjwBo=
X-Google-Smtp-Source: AGHT+IGdOJonCplCSu4kXZCYw+CiIoY+ia2VQfjjcicIv8BbTyEkCPzMxvsFNZ/0r7MFzSnEYVyNn+zLFgzzkOiKSvg=
X-Received: by 2002:a05:6830:3748:b0:72b:8f4e:8c61 with SMTP id
 46e09a7af769-72ec6d215efmr1532487a34.24.1744817313009; Wed, 16 Apr 2025
 08:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4661520.LvFx2qVVIh@rjwysocki.net> <2239639.irdbgypaU6@rjwysocki.net>
 <1c0c6caa-e56c-454a-a976-81303dee1852@arm.com>
In-Reply-To: <1c0c6caa-e56c-454a-a976-81303dee1852@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 17:28:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-=DB_W5jkxxCERy22jz9a_V1Tcj8hiVwL6_R+xSM=gQ@mail.gmail.com>
X-Gm-Features: ATxdqUHLX0aZbmy5IcEK3XvUJxiV3QkGqST-gk2VoRr0NR_-QkNL1i3K3PdwmP0
Message-ID: <CAJZ5v0g-=DB_W5jkxxCERy22jz9a_V1Tcj8hiVwL6_R+xSM=gQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpuidle: teo: Refine handling of short idle intervals
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Doug Smythies <dsmythies@telus.net>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 5:00=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/3/25 20:18, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make teo take all recent wakeups (both timer and non-timer) into
> > account when looking for a new candidate idle state in the cases
> > when the majority of recent idle intervals are within the
> > LATENCY_THRESHOLD_NS range or the latency limit is within the
> > LATENCY_THRESHOLD_NS range.
> >
> > Since the tick_nohz_get_sleep_length() invocation is likely to be
> > skipped in those cases, timer wakeups should arguably be taken into
> > account somehow in case they are significant while the current code
> > mostly looks at non-timer wakeups under the assumption that frequent
> > timer wakeups are unlikely in the given idle duration range which
> > may or may not be accurate.
> >
> > The most natural way to do that is to add the "hits" metric to the
> > sums used during the new candidate idle state lookup which effectively
> > means the above.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Hi Rafael,
> I might be missing something so bare with me.
> Quoting the cover-letter too:
> "In those cases, timer wakeups are not taken into account when they are
> within the LATENCY_THRESHOLD_NS range and the idle state selection may
> be based entirely on non-timer wakeups which may be rare.  This causes
> the prediction accuracy to be low and too much energy may be used as
> a result.
>
> The first patch is preparatory and it is not expected to make any
> functional difference.
>
> The second patch causes teo to take timer wakeups into account if it
> is about to skip the tick_nohz_get_sleep_length() invocation, so they
> get a chance to influence the idle state selection."
>
> If the timer wakeups are < LATENCY_THRESHOLD_NS we will not do
>
> cpu_data->sleep_length_ns =3D tick_nohz_get_sleep_length(&delta_tick);
>
> but
>
> cpu_data->sleep_length_ns =3D KTIME_MAX;
>
> therefore
> idx_timer =3D drv->state_count - 1
> idx_duration =3D some state with residency < LATENCY_THRESHOLD_NS
>
> For any reasonable system therefore idx_timer !=3D idx_duration
> (i.e. there's an idle state deeper than LATENCY_THRESHOLD_NS).
> So hits will never be incremented?

Why never?

First of all, you need to get into the "2 * cpu_data->short_idles >=3D
cpu_data->total" case somehow and this may be through timer wakeups.

> How would adding hits then help this case?

They may be dominant when this condition triggers for the first time.

