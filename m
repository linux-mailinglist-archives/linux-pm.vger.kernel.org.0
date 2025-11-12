Return-Path: <linux-pm+bounces-37874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E8DC545E2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FD674E3B82
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD027703E;
	Wed, 12 Nov 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrRAgHrg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667782749E4
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977811; cv=none; b=dqEgmBbMliMoXBYZ+TOhjZF5vjO/s7Az+pBAKPphRymeoCke7+3s9cwjyL1KOZX/puL4P00Fs0eWrocZTczni8VERTiiUiuDv8NQfqncTRQCWEsYa/dYPQ0ThbtHOemO2KxMbEXoTmyZrQJIsVX7nv/GVNRZVr0h1vCzLX2WPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977811; c=relaxed/simple;
	bh=2truygGR7fmvsFgLhsjwjiIdPMxhJOWDBjbJln/EW4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQcxjWd9wsxWpETTjfo5JDQ8lz7p7yyK1/mc6wykRIZSMNY30/TDnbcWjhhAdkWVI72MF7+l87BykO9O2TZ001o7PzYhrEIXhfLcR4tq1voeHzYnkvW0L9cQH5ih2O1NZ3W6K3oc9Ipb1Rx5uSyXYwU+tYnSJM5nFsW+fEIiyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrRAgHrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32619C19424
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762977811;
	bh=2truygGR7fmvsFgLhsjwjiIdPMxhJOWDBjbJln/EW4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HrRAgHrgewQiNS6qPWAgMzhx0EJLVM27DRZ4Tg0nMaz0+LIhxNjRX+zY+EmKQQ4fv
	 uBna2AoeL7CTxoTYsVs2G0hZU1461VcmYnqSIAWJVWnEbq88CQCBo7hbr6QtY5XJmu
	 HRzzDwG7vdQxlpfBakCwHj0NfDKSzWywGME4H6CmxMKovs/5ZMWaXnDyLY19OAcDYO
	 pBG3KHzpyXRjxEJXURoxvDqonp2+LRY1Y/UfCsphnN2+hwJgi0doeurcgIw/i1MO+m
	 8KYN1HKENsa+oX3dzE1MJUCC98+KrJHNqAFCzti/z/1xeUA9PurO8Gm+UvurOYe2BK
	 bqHuUWVNtI05g==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-656e585587bso32953eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 12:03:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRkcTrCpm9iqB7zwG/Y8hXz+ivA16nmbXA2qBvyYMjJoETd7W2tppIfDs6MdATAanr9C1AK420Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PZyZkkpDhNE/UENInRMW3KK3cMnN4nbJwRyINE6gDVT5saww
	TEn8XGYf9r4I9mQF4r9LmT0CWXQcNT4S5zku6E/jYWtU2CLDxIwpuYT9wS5/S8OkrsYoNjFGnXd
	HyWakReWilvYTia64vcELdJbYramxRN4=
X-Google-Smtp-Source: AGHT+IGRBeNRM+HNo5unVf2rRvHcql8w4SILTxjZzsf1VLzE4PQggEmnPM37H5AYrqsAt+y0dGqZWxRQHZsSe99OE6A=
X-Received: by 2002:a05:6820:81c9:b0:656:735e:9eff with SMTP id
 006d021491bc7-65716443681mr1926630eaf.7.1762977810471; Wed, 12 Nov 2025
 12:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110120819.714560-1-christian.loehle@arm.com>
In-Reply-To: <20251110120819.714560-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Nov 2025 21:03:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjh2cJhfQQBgtqPvNGgzUmyV_tkLQ7WJv6cXhPYBQrcA@mail.gmail.com>
X-Gm-Features: AWmQ_bkFq_SDqC3LU9Wj50F7rCTNrLgPevAbF4KDpRAyN3MOhb8pM3MPrmyPWOc
Message-ID: <CAJZ5v0jjh2cJhfQQBgtqPvNGgzUmyV_tkLQ7WJv6cXhPYBQrcA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: teo: Use this_cpu_ptr where possible
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:08=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> The cpuidle governor callbacks for update, select and reflect
> are always running on the actual idle entering/exiting CPU, so
> use the more optimized this_cpu_ptr() to access the internal teo
> data.
>
> This brings down the latency-critical teo_reflect() from
> static void teo_reflect(struct cpuidle_device *dev, int state)
> {
> ffffffc080ffcff0:       hint    #0x19
> ffffffc080ffcff4:       stp     x29, x30, [sp, #-48]!
>         struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> ffffffc080ffcff8:       adrp    x2, ffffffc0848c0000 <gicv5_global_data+0=
x28>
> {
> ffffffc080ffcffc:       add     x29, sp, #0x0
> ffffffc080ffd000:       stp     x19, x20, [sp, #16]
> ffffffc080ffd004:       orr     x20, xzr, x0
>         struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> ffffffc080ffd008:       add     x0, x2, #0xc20
> {
> ffffffc080ffd00c:       stp     x21, x22, [sp, #32]
>         struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> ffffffc080ffd010:       adrp    x19, ffffffc083eb5000 <cpu_devices+0x78>
> ffffffc080ffd014:       add     x19, x19, #0xbb0
> ffffffc080ffd018:       ldr     w3, [x20, #4]
>
>         dev->last_state_idx =3D state;
>
> to
>
> static void teo_reflect(struct cpuidle_device *dev, int state)
> {
> ffffffc080ffd034:       hint    #0x19
> ffffffc080ffd038:       stp     x29, x30, [sp, #-48]!
> ffffffc080ffd03c:       add     x29, sp, #0x0
> ffffffc080ffd040:       stp     x19, x20, [sp, #16]
> ffffffc080ffd044:       orr     x20, xzr, x0
>         struct teo_cpu *cpu_data =3D this_cpu_ptr(&teo_cpus);
> ffffffc080ffd048:       adrp    x19, ffffffc083eb5000 <cpu_devices+0x78>
> {
> ffffffc080ffd04c:       stp     x21, x22, [sp, #32]
>         struct teo_cpu *cpu_data =3D this_cpu_ptr(&teo_cpus);
> ffffffc080ffd050:       add     x19, x19, #0xbb0
>
>         dev->last_state_idx =3D state;
>
> This saves us:
>         adrp    x2, ffffffc0848c0000 <gicv5_global_data+0x28>
>         add     x0, x2, #0xc20
>         ldr     w3, [x20, #4]
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index bfa55c1eab5b..a3ebc2cda093 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -155,7 +155,7 @@ static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
>   */
>  static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device=
 *dev)
>  {
> -       struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> +       struct teo_cpu *cpu_data =3D this_cpu_ptr(&teo_cpus);
>         int i, idx_timer =3D 0, idx_duration =3D 0;
>         s64 target_residency_ns;
>         u64 measured_ns;
> @@ -268,7 +268,7 @@ static int teo_find_shallower_state(struct cpuidle_dr=
iver *drv,
>  static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device =
*dev,
>                       bool *stop_tick)
>  {
> -       struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> +       struct teo_cpu *cpu_data =3D this_cpu_ptr(&teo_cpus);
>         s64 latency_req =3D cpuidle_governor_latency_req(dev->cpu);
>         ktime_t delta_tick =3D TICK_NSEC / 2;
>         unsigned int idx_intercept_sum =3D 0;
> @@ -504,7 +504,7 @@ static int teo_select(struct cpuidle_driver *drv, str=
uct cpuidle_device *dev,
>   */
>  static void teo_reflect(struct cpuidle_device *dev, int state)
>  {
> -       struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> +       struct teo_cpu *cpu_data =3D this_cpu_ptr(&teo_cpus);
>
>         dev->last_state_idx =3D state;
>         if (dev->poll_time_limit ||
> --

Applied as 6.19 material, thanks!

