Return-Path: <linux-pm+bounces-13000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C415961724
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47911F2476B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46ED1D27A0;
	Tue, 27 Aug 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N37zTsFn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC201D1757
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784238; cv=none; b=nCprIviFaCdOtcSBFNVzcLcdz3v8d0hrvCWwrw+MloL2aU1uGxufx5vfYoHy4pFAYS07pRFZWZaKkQVDy5mwtPn1WOFmIM2AHjwhch7fi+kkN/rNHzVOm8W4utRjrSkDK7Tpxx2OlrzqPHRscFR7p89AMQBuAUGCFmZjtFjYsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784238; c=relaxed/simple;
	bh=qgZLtG1J6o9q7iR5Afvb41lRnG+qqE8fldF4/4+hECg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMxco1GQRt6+78HwWyRtz0VTDxsXvwD6PhekD6xPEpC3NOL1XQAU9wLoRCxGDtSltNBeTrtDasB7dqmfdS61HsleZn9kfzLOtvRhYs6TIfiRlC9UYFQwfUtqL7Iuq8ziSxRgsctW1EoASCGqtHxfSmCHx05lTSkB4L/HQtAWD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N37zTsFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F26AC4FE9D
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724784238;
	bh=qgZLtG1J6o9q7iR5Afvb41lRnG+qqE8fldF4/4+hECg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N37zTsFn+pfzeRiOuFfXjWSM1YOAI1s4L1YpJ0SbMGYysZO9JeHMDD3t1Mr+W4RKd
	 rtFVsPmZOicKLqu5Z/GbwSNtWUZm/faiWI9BjMKnZh7g0AEkYPJ0umUU9Mu8vl3h78
	 ESG/Ynck3o58EgIx2vK586nTMlUcBEu01HZQZoC0hx+4FkSkCC3YikcjvCnxEFUUqD
	 SkYPK4vQxtkQOvX1gtB6Qp4f3HM7MQOrwVQwlutjvYQ+Zl914E0qUlUNhyiodtY7vG
	 UFQOqRyJHoiKCAXD+mMlSNfXZhoyEjf+wphyQjSgc+9WvvKkYtLSpBJoym34nWLFIj
	 Ytxcl5QAg/pyg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-709346604a7so4367128a34.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 11:43:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXY4cOndWc5iVvOlziVjgGIvD72Z4HDUNta89WqLwZR0ZmHS5LhLIaeJwuunopVvPHZh8kjnDkp6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zo1OCliLkaN7k+QMzw5nIN5LfqRzFvUPbEJAm4e8JmaX/wwZ
	llIg7WhjtUufrTTxh1M/drtvMmHWkrUndle84OqxXnC7/v+WcKEIBOjT6+B6gQdXy0id+FUNGAR
	JngpMVSWnZ9sAoNVnmDZ+OzaC3u4=
X-Google-Smtp-Source: AGHT+IEyebeCL4HTZJish0oPJ2RYWgwC9XAunMW8zbIh+u8HbgKwhYK+UlDhqEt42Fsz2nESZPosnFXX/LA20jvUs7A=
X-Received: by 2002:a05:6870:b492:b0:270:631e:cf7b with SMTP id
 586e51a60fabf-273e66db4fdmr18011489fac.41.1724784237426; Tue, 27 Aug 2024
 11:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6e8ce59-4139-4832-ab8e-133181d0c874@amd.com>
In-Reply-To: <d6e8ce59-4139-4832-ab8e-133181d0c874@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 20:43:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKO3dmbzkiOmW3bd4ySvhHiLq6yBP2qCx_H=hsi0E0Tg@mail.gmail.com>
Message-ID: <CAJZ5v0gKO3dmbzkiOmW3bd4ySvhHiLq6yBP2qCx_H=hsi0E0Tg@mail.gmail.com>
Subject: Re: amd-pstate fixes for 6.11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:28=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit 47ac09b91befbb6a235ab620c32af719f82083=
99:
>
>    Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.11-2024-08-26
>
>
>
>                                      for you to fetch changes up to
> 9983a9cd4d429dc9ca01770083c4c1f366214b65:
>
>    cpufreq/amd-pstate-ut: Don't check for highest perf matching on
> prefcore (2024-08-23 11:07:58 -0500)
>
> ----------------------------------------------------------------
> amd-pstate fixes for 6.11-rc
> - Fix to unit test coverage
> - Fix bug with enabling CPPC on hetero designs
> - Fix uninitialized variable
>
>
>
>
> ----------------------------------------------------------------
> Dan Carpenter (1):
>        cpufreq: amd-pstate: Fix uninitialized variable in
> amd_pstate_cpu_boost_update()
>
> Gautham R. Shenoy (1):
>        cpufreq/amd-pstate: Use topology_logical_package_id() instead of
> logical_die_id()
>
> Mario Limonciello (1):
>        cpufreq/amd-pstate-ut: Don't check for highest perf matching on
> prefcore
>
>   drivers/cpufreq/amd-pstate-ut.c | 13 ++++++++-----
>   drivers/cpufreq/amd-pstate.c    |  4 ++--
>   2 files changed, 10 insertions(+), 7 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

