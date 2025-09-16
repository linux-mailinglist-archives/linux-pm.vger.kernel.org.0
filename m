Return-Path: <linux-pm+bounces-34734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B01B5999D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 16:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036EA174BAB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCD356907;
	Tue, 16 Sep 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/B8vubw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E193568FE
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032016; cv=none; b=H1VWRKXhCA44z51cO8RU9+g8ML1tNjJ2jZqrXecfulOqtyzVDpUwdfQ8V9x7Th94ohzWpRZCIoKizfpsBBtsojqsnEZ+JZN+bRKEBXNWFR3Fgr5DR32ApUb1i1yzKZwcy2XysBbTpO6RPpu2gbqpCnvyXsTHY8Yj9GJhwe1twjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032016; c=relaxed/simple;
	bh=n+L4pa4V4TakMOivf0PlUU/bqhDI8BGO+P5AG4JZQQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOwvbzPFi5LE7EYf+49SrLk44kH9pjk9r33eWfXm1BGdCOvpq5aiN2IiWN1fpo6PnrTglwUbZ3R5+otVE1bGaAYMgTS9+eXuNzTs6y3ZaJdLwxt/ISF4UYI1+EFW91C4waKxStRefo0jprDqBr2YUjgNXzxvwkeYgLgu6BW55lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/B8vubw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01839C4CEFA
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758032016;
	bh=n+L4pa4V4TakMOivf0PlUU/bqhDI8BGO+P5AG4JZQQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I/B8vubw8mOUtF56jAAeGQovtfs1DA2gXr8P9VLkiXTUnZpsVnsA4DyYohrQBG2H6
	 kPweJARy54G6JTmETMuG7VaNb055flLF8xFxQBa1aE/DET/RX6QBuy91b+tOJ5OkDv
	 6ek1PQi/++qNYywqVtzZ6l6tnBZVkKBzizWa9JxClXlo9NP7bToN+SI0LpEN6Esf5A
	 2s5lNcr2BOVRv7s/PIb+pIebhnj8xj1iY1kMAZcWjEkUZFyyr+gWs6fotjStSdEM9Q
	 53nsoGyy/MKlYtuCagi9PxN84eTv9EvxKwRpYJ5rKXfDP/sQfmwfofOteb+SnmVeyz
	 EiAxPqjDnZEaw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6234995098eso1470835eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 07:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgNG0X+s42zlOncQ3o5oLYwtjIcLsy/4CBSnIO8YnNd8w+SWei1HhKRy0DWu1HsUVr/h3MSzxEbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOEkp/Az2PRWMqEBVt+XM9WEtp75C+33eVvBof9vL3ykxkAXl
	IuuJM6/eZxlJMg2gi8Hq62W1XkV6RP8kER2bT7Zv7vbxGS1kh4sRvXv9ea6NjCsgLcJaHXIe38W
	XlugdeGxnhEzJ8JJS1H63rbHY2t1nmSo=
X-Google-Smtp-Source: AGHT+IHgL22hJWIWVWxwVkIJFyclD7ftmrFNiS+18ltenSf2m8t46VEFJCl+fupooSj/e/UfhG/QBLNnbAdxNRXQz0s=
X-Received: by 2002:a05:6808:1a19:b0:438:22cd:298e with SMTP id
 5614622812f47-43b8d86ef61mr9296271b6e.1.1758032015284; Tue, 16 Sep 2025
 07:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6191405.lOV4Wx5bFT@rafael.j.wysocki>
In-Reply-To: <6191405.lOV4Wx5bFT@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Sep 2025 16:13:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
X-Gm-Features: AS18NWApZZiOkxgsLld9dGt1_5dhQy0WIEt4DE2pKcqACnVsrSqQnCBhdLuWkV4
Message-ID: <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
Subject: Re: [PATCH v1] smp: Fix up and expand the smp_call_function_many() kerneldoc
To: LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The smp_call_function_many() kerneldoc comment got out of sync with the
> function definition (bool parameter "wait" is incorrectly described as a
> bitmask in it), so fix it up by copying the "wait" description from the
> smp_call_function() kerneldoc and add information regarding the handling
> of the local CPU to it.
>
> Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It's been a week and no feedback.

Well, in the further absence of any, I'll assume no concerns and just
queue this up.

> ---
>  kernel/smp.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -884,16 +884,15 @@ static void smp_call_function_many_cond(
>   * @mask: The set of cpus to run on (only runs on online subset).
>   * @func: The function to run. This must be fast and non-blocking.
>   * @info: An arbitrary pointer to pass to the function.
> - * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
> - *        (atomically) until function has completed on other CPUs. If
> - *        %SCF_RUN_LOCAL is set, the function will also be run locally
> - *        if the local CPU is set in the @cpumask.
> - *
> - * If @wait is true, then returns once @func has returned.
> + * @wait: If true, wait (atomically) until function has completed
> + *        on other CPUs.
>   *
>   * You must not call this function with disabled interrupts or from a
>   * hardware interrupt handler or from a bottom half handler. Preemption
>   * must be disabled when calling this function.
> + *
> + * @func is not called on the local CPU even if @mask contains it.  Cons=
ider
> + * using on_each_cpu_cond_mask() instead if this is not desirable.
>   */
>  void smp_call_function_many(const struct cpumask *mask,
>                             smp_call_func_t func, void *info, bool wait)
>
>
>
>

