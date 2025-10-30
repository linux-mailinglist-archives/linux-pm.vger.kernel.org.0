Return-Path: <linux-pm+bounces-37095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAACC1FFF3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 13:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C2188D605
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135663191AC;
	Thu, 30 Oct 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyF4M2wk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1F315D4E
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827181; cv=none; b=jElyL+bFx/l+V+6kvvRz/zoFcZhvOBrDc05KeXG3CT1VcQUObBwEdqgqlRm17oi9aoaXV9glJChahv7SUN3zKKsxWbc0GLzIBf4AlX63N1xBqqLPeucJAGnMG6FFef5MmojKRakzoDHu7IuSxIrupa5xQCAXScGvwpzb7mrychY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827181; c=relaxed/simple;
	bh=cbYd5mUObvWAq247RhDtBIy0RsBRceJxvBYCc/36UrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fapDv/NE6IUmesXqVxSWKwjTLeHNJaxocvmFmLkEpB1RKlfuTZpxoTV+nLihlQSdsM/Oev2ARdvRRV1qTHT0Imza2vYZfNDkJAWCKRvKi95umxmftq9AN57TarOZ5NJK0LG4r8oqbJZ5+OHdV6nC6wkgNKcKxjLI+tHyVQip/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyF4M2wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0EAC116B1
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761827180;
	bh=cbYd5mUObvWAq247RhDtBIy0RsBRceJxvBYCc/36UrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AyF4M2wkszEj8YzoRywKFKRFv0hK/plWl2XPzFbx/ZKhqEgb1/xP+SAZEUn+7/pQn
	 ZJnnrmvL86XVytuLwGKIlHUPaGI3/Qb4HZxzH4SG2wK2gui6Z87q6AGdbGFmWXFD0t
	 i6rqd2UTX1goP4WmZ1gJZKf1BcHXU5KRMEyUO8KUUNPIN1TWwaflsmNYkI9WNNs2k8
	 GcT5wDRAYUlIiFn0dLJfX7buTDbAcxv2+nFrCE90YzDvU/uefIunmLPQH4+HZ6LK6Z
	 u+TnvNpJNq/PlPhlvE43Nn2jX3JIatNpspVQA5QNF5Ycz3V/SigHhSQx+W9B2ihD76
	 ol/Y58xgGcAvQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-65682d20e4cso603949eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 05:26:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwB/ziJ7oXVOB6EInpYE0gL5Gxu59Iu1UlVrqo2A3gwTxNLiL2I6bw4IFYXb/sY/D2cKUkgE4LnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNzf8UumNDqCORI0rFZh/tiVKoISXidcNU98ns2jWZ82ZtP7+
	GXU5P7qFAx+7/QQ8Wu4JQL07bBv16B4g9Pk/Gj5qWcfRNbkO0kVyZnH9P1Eg12P/LAbWaqnma1j
	jrtvEoYgQ9dFvphBjU75oSEe0/uuI1IQ=
X-Google-Smtp-Source: AGHT+IEwjr7Am+NaeHIS0C1w30ZZZ2Vn00gSsL4T/N1OBCD7rXt9dWVKHDNMrHClFaEPtO0E0Vlxm8uV7fo0uY8BUEI=
X-Received: by 2002:a05:6820:168a:b0:654:f9ac:dd33 with SMTP id
 006d021491bc7-65681bba481mr1288688eaf.4.1761827179860; Thu, 30 Oct 2025
 05:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com> <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
In-Reply-To: <CAPDyKFpYfLJ1F1ynLAZLJBoWp+Uk-k2B0796_yWQTNg4xT9zew@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Oct 2025 13:26:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
X-Gm-Features: AWmQ_blQnc1Hb5b5KgZH0kGZoqGgp1aF-U3Rc9_Ll2lxwa4enYfIkY8i9oGv1Pg
Message-ID: <CAJZ5v0igMhr=N90As66dioXXzL8YL11PN3k49n5-yoPuHNR-_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:23=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 29 Oct 2025 at 15:53, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > Changes in v2:
> > >         - Limit the new QoS to CPUs  and make some corresponding rena=
ming of the
> > >         functions along with name of the device node for user space.
> > >         - Make sure we deal with the failure/error path correctly whe=
n there are
> > >         no state available for s2idle.
> > >         - Add documentation.
> > >
> > > Some platforms supports multiple low-power states for CPUs that can b=
e used
> > > when entering system-wide suspend and s2idle in particular. Currently=
 we are
> > > always selecting the deepest possible state for the CPUs, which can b=
reak the
> > > system-wakeup latency constraint that may be required for some use-ca=
ses.
> > >
> > > Therefore, this series suggests to introduce a new interface for user=
-space,
> > > allowing us to specify the CPU system-wakeup QoS limit. The QoS limit=
 is then
> > > taken into account when selecting a suitable low-power state for s2id=
le.
> >
> > Last time we discussed this I said I would like the new limit to be
> > taken into account by regular "runtime" cpuidle because the "s2idle"
> > limit should not be less that the "runtime" limit (or at least it
> > would be illogical if that happened).
>
> Yes, we discussed this, but that was also before we concluded to add a
> new file for user-space to operate on after all.
>
> To me, it looks unnecessarily limiting to not allow them to be
> orthogonal,

So what's the use case in which it makes sense to have a lower latency
limit for s2idle than for runtime?

> but I am not insisting that it needs to be like this. I
> was just thinking that we do not necessarily have to care about the
> same use-case in runtime as in the system-suspend state. Moreover,
> nothing would prevent user-space from applying the same constraint to
> both of them, if that is needed.
>
> >
> > It looks like that could be implemented by making
> > cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limit()
> > into account, couldn't it?
>
> Right, but I am not sure we want that. See above.

I do or I need to be convinced that this is a bad idea.

