Return-Path: <linux-pm+bounces-36554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F33BF5B30
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 12:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C21844E1F11
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA527C866;
	Tue, 21 Oct 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VU6zeb5I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C71E5B71
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041321; cv=none; b=XxnT8fbXX6G8+/iqFX6FbZCWGjpgAWUNuA8o63ohkPBX0hGFr1TZ3B22c4X6lQerTzPJYU5NNyZs1IQCF9QyynZnYgj0BbKo+GuNyKnCd4S/x6hBvySK1PBu07qv6ysoESi1YWpWkiS/kcbK/h4NBdDqAsJjd50vzs1Pf+5YTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041321; c=relaxed/simple;
	bh=qAbJyQPPInrxKG97wEiG3fxqPfQEM6oQEkIzdBx2QKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Goqt4rePn4abGyAqoL4e4RjiOOhBcLBu98M0Yqg7eaMQQHpGgwi9cIU5+pi0Igj1wW7zbpd/CIzc02dbt2Jf9O7HbdE88xwYeQeJmAdk3j2HQmRz/PIhOWjhoasg9QlR7w//FmV5vvfiMCBslIjgbfDiKwHqXiQAWnUO5wSTo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VU6zeb5I; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63bc1aeb427so5621255d50.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761041319; x=1761646119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FcY1WuRhXouiGA4KCWU+G5cXctN3EhAkLVSQq5aIkDA=;
        b=VU6zeb5ITjgm6HsjuHLQtKaFcRpUmaTE7qMmuyBuM97iK4xuFFT2ibCUCWn6U9vLFO
         +Bdl+Lm81GjNDuqf12b57tkzf/p6HGT5y/f+rp6gg8qj8w//fU0cWDTEMG2peNGgpknX
         XkQxAisH9BkOaXNrwgZq5Nqmrdp0R4wYTDtRuGXro8FMsk5wglFjSZTUXbApGHelYHKM
         yVRM0KxFMrFJ6boZMFlNJS+qbunguqNk6HvFui1/QcTxY80BGFXGKQIuW7rp9nSxk7oj
         e1svSpqgbtZM6yZmAFCnpizgr1DBF27p7bRM3uVv2SZXZX8fABPQYby/kcY3pzP6Odzq
         K2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041319; x=1761646119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FcY1WuRhXouiGA4KCWU+G5cXctN3EhAkLVSQq5aIkDA=;
        b=nPvxfpPqMhxbQTzoE69SRfvMDptLNIiDuWEilCNbfvFuBe3VHPe9QkZe5vAUWdd6kM
         lL1zNP3goFtjqmbPHf81NfJKo8dundxaV5I/WrNvirnjM2iffqX84/YEWaT46DTU7sIb
         guygG8w/mcsBJ/ItJOgY2PEeVv0OFqhyiHitdfqmVu7xDG9sAo2WtKTBz3kFdXrrHi6K
         zEk3Zhle5VjihUXMr9XL+gVDLqiLR5P/Ci5/UcdEd7nIA8YnjsjZ5hp07lJ9QZiHZhGm
         sQHOD2A0giSfUY8McU5Zius/C/qYiuTRJqJEVtkrMeFjj603WsqWMe0WwVUEC1yBIqE2
         /AqA==
X-Forwarded-Encrypted: i=1; AJvYcCWH65tYiofoUuAJ7lZn6yLPRET0+zRAgozGGDAE9VoPu/Av9bgSz856aVEv3/cV7Yz9Tg8vsLbxGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgvzK8UhwIzWgur4bIBnLhM6qrh5YfBKfs87H2AdbZqUYrplB
	26MK8dN5asORkz8MO7ojhtm8TlVkXShZzBYMTVbyCKcanxfKrw1FB6RG+6BD1jvlan9bsxO48Xn
	yNihQkqxYX/0H8HBdjc+5Or5HsNVO0eU+GGaPgSpgrQ==
X-Gm-Gg: ASbGncsBU/FM4xJzH5NyxVPFwk6jt/bmLdSUNar4NaeqARyN9ap1N8JicSB1WVvdmsr
	0XExKhuBR/s9d3xYFuLgb3nzXWQClGu5Q7kuMwveF07oPB+xBOtqhyhL1DP9a+RTvFlPpZ44zq4
	quHpg6VVI5ELFuD8u+KRAGCbkV+XiDzcdrWUsVDXafvZyaQmR9b1sfxqLmS3P9cKlUhLRRwld+y
	ikVBv+hjuQuQcUHxdPsYGTsf4/q4/KOiKANo0KEOSocdb8xALIz3mUg89TcDQ==
X-Google-Smtp-Source: AGHT+IER588Lwab2jH1RPVxWEMKtc71AdHZ7rUDhw6Az9ENBa6h+mO9XQH92FP+m3bjNm6autc5uWg5ixjt23yxAFE0=
X-Received: by 2002:a05:690e:d51:b0:636:d3f9:6418 with SMTP id
 956f58d0204a3-63e1610c2eamr12824971d50.22.1761041319091; Tue, 21 Oct 2025
 03:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
 <20251020141718.150919-2-ulf.hansson@linaro.org> <a0120876-0f00-4e1a-aa17-5fe7c3512276@arm.com>
In-Reply-To: <a0120876-0f00-4e1a-aa17-5fe7c3512276@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 12:08:02 +0200
X-Gm-Features: AS18NWAG0JIz8WscydJtNeviSVU0idBmTgh-4-AojKeBaYrYkaU30tTtBYxU8G4
Message-ID: <CAPDyKFrY5kOsoOH-mcWFiaiggV4q84xOtiKHdNN4bMfFmYOQPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] smp: Introduce a helper function to check for
 pending IPIs
To: Ben Horgan <ben.horgan@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 21:11, Ben Horgan <ben.horgan@arm.com> wrote:
>
> Hi Ulf,
>
> Only a comment on the naming rather than a full review.
>
> On 10/20/25 15:17, Ulf Hansson wrote:
> > When governors used during cpuidle, tries to find the most optimal
> > idlestate for a CPU or a group of CPUs, they are known to quite often fail.
> > One reason for this, is that we are not taking into account whether there
> > has been an IPI scheduled for any of the CPUs that are affected by the
> > selected idlestate.
> >
> > To enable pending IPIs to be taken into account for cpuidle decisions,
> > let's introduce a new helper function, cpus_may_have_pending_ipi().
>
> To me, "may" indicates permission, i.e. is allowed, rather than
> correctness. Would "likely" be better here, cpus_likely_have_pending_ipi()?

Sure, that sounds better to me too.

I leave it a few days to allow people to provide their additional
input, before posting a new version with the new name of the function.

>
> >
> > Note that, the implementation is intentionally as lightweight as possible,
> > in favor of always providing the correct information. For cpuidle decisions
> > this is good enough.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Implemented a common function, rather than making it arch-specific. As
> >       suggested by Thomas and Marc.
> >       - Renamed the function to indicate that it doesn't provide correctness.
> >       - Clarified function description and commit message.
> >
> --
> Thanks,
>
> Ben
>

Kind regards
Uffe

