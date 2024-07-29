Return-Path: <linux-pm+bounces-11583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD22393FD4B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2161C22183
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A1186E26;
	Mon, 29 Jul 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaY6qqBl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9478274
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277513; cv=none; b=FOwuWwobhmJuWvAhqXwWANnQaMmawZw9PKipmasZzlRwzRJ4AwMWvdAAl83z+sa8g4M2+Syj+NEVSgxpKaSX3+ySkkPSDqgJM+aw051jKlC1ET+MKLxQHVS6uU/XQWej7uA6woEXtMv1E6wKZy7S/DZT8UpcUcQ6vAtADFqIbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277513; c=relaxed/simple;
	bh=58W8hH/U6u8zeGv2wimltSbtCpG21AOuRVRdfLxUuLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeUhpjrWMjwbtiaO2yNZXjaMsecQZcMWtvFYH+Zp41fi3eBGdggzIntuykrqX1p8xU31h79D+wvleAwqiQZlVT7FCVxYmiVGhuBN2QotQUwleu3EFFU01k6jv21DX2+YhkkANE6onYRjpK/aXKVp0wOdGob6W/qy9sTGWCrVBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaY6qqBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70C0C4AF0A
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 18:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722277512;
	bh=58W8hH/U6u8zeGv2wimltSbtCpG21AOuRVRdfLxUuLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gaY6qqBlVNrCZ32fcjt74DHUb5QMcXunhUUgQ3vrOk4bn0nyBGBt6yHRqXjTHEyq+
	 BZTRJlIajSFg0j9RuEwMDDqiex7xstYjUKx0gN1V0vmq70g6z/fdBLxSFjAWHxsKex
	 wctfRLjHEmyUW+AvJoqn0j6kesxUZ5NhnA98aFXAuHO1cHZDxooLB0xmg5LOi8bmil
	 iJ3Fpp9cpepBgrGroP4Ol8I4WJkF+JyHt4quS1Nj3nF+ljgF2hka/CGngtZiJvzXam
	 BlqTL5V3PGoIol4d+Y0GrB2YjgGgfSXOGyaXSIeURr4ghtIWL0muZi9XHdVm5PB1Vf
	 NgCAYifaS5Ncg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5cf146a82a5so126542eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 11:25:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YxaLoTkuHDbuO2SfbY6r2Y7RQbze+YDyyCHfC32pG00gQ9rlCdW
	rUmRj+U1CJ1C8R3VMaOMa3NutceNz5nrrMrD7K1KoQ0IjvUlhOXfu7MHBl5tJC20hweY7e54hjN
	fNbQeZWdOFUtSGlcvFeDFxE4VnZc=
X-Google-Smtp-Source: AGHT+IEbeFMZ92Oao7vIXL07+Kw2UwDSIW/W68+Z4lw5B66KlMZumCHEKSRAJS9fJr4HBcrP5Ov/HAHb4MEXsQhlG84=
X-Received: by 2002:a4a:df47:0:b0:5d5:bc1f:daa with SMTP id
 006d021491bc7-5d5bc1f0f75mr7572306eaf.1.1722277511979; Mon, 29 Jul 2024
 11:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <872ea739-632a-4344-9e3d-49f8fb846f8a@gmail.com>
In-Reply-To: <872ea739-632a-4344-9e3d-49f8fb846f8a@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jul 2024 20:25:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hD+6YR9HvtrSu_bDGZKMr2D2c1FKmDiDPwqDWV7wc_WA@mail.gmail.com>
Message-ID: <CAJZ5v0hD+6YR9HvtrSu_bDGZKMr2D2c1FKmDiDPwqDWV7wc_WA@mail.gmail.com>
Subject: Re: Need help setting asynchronous CPU frequencies.
To: Anish Rashinkar <rashinkar.anish@gmail.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:35=E2=80=AFPM Anish Rashinkar
<rashinkar.anish@gmail.com> wrote:
>
> Sorry, I am really not sure if this is the correct place to ask this,
> but I have tried almost everywhere but to no success.

No worries.

> In short, one of my cores in my processor is defective/degraded. It
> can't run at max frequency or else it will crash. Either I have to lock
> down the frequency of all the cores to a lower value, or set that core
> offline.
>
> Access to turbo ratio limits is restricted by the firmware, or otherwise
> it would have been easy to set the working cores to max frequency while
> keeping the defective core to a lower speed. Voltage controls are also
> locked, which could have fixed the problem, and I have already put a lot
> of time trying to gain the access, but it's too risky (firmware modding).
>
> It's an HP Elitebook 840 G5 laptop, with an Intel Core i5 8350U. 4 cores
> with 8 logical threads, It boosts up to 3600 MHz. I have to lock the
> whole processor frequency to around 3 - 3.1 GHz, but it is getting worse
> and might crash on that as well. Or if I choose to disable the core, I
> have to disable CPUs 2 and 6, which is the third core. I have noticed
> that disabling idle states (C states) gives me a bit more stability so I
> can probably raise the frequency a bit more.
>
> All I want to know is if there is a way to run the 3 cores at max
> frequency, while running that one core at a lower 3 GHz frequency?

If the processor is not capable of controlling frequency per-core,
which is very unlikely for a laptop one, then no.

The problem is that all cores share one voltage regulator that is
necessary to raise the voltage in accordance with the frequency you
want to run at.

In that case, the best you can do is to either take the defective core
offline (which requires taking CPUs 2 and 6 offline if I understand
the above correctly) and run the other cores at higher frequencies (if
you care about single-thread performance more than about the ability
to run 8 threads in parallel), or run all cores at lower frequencies
(if running more threads in parallel us more desirable).

> All my attempts included trying to get the userspace governor working,
> but it is a big mess. Using tools like cpupower or cpufreq
> (cpufrequtils), I can't load the userspace governor directly. The
> userspace governor loads if I disable intel_pstate or put it to passive
> mode, but it doesn't seem to have any effect. After loading it, any
> frequency I set using cpupower/cpufreq doesn't apply. I also tried with
> intel_pstate hwp on/off. And I of course tried manually choosing the
> core in cpufreq but either the changes don't apply, or it gets applied
> to all cores. I also kind of tried manually setting the frequencies in
> the kernel files (/sys and those), but they didn't really work. I also
> tried "intel_pstate=3Dper_cpu_perf_limits" kernel parameter, but that
> didn't really help (I couldn't get the intel_pstate folder under all
> CPUs, and instead I still got it under .../cpu/ like always).
>
> I am currently running Ubuntu 24.04 LTS.

The distribution and kernel version do not matter here.

Thanks!

