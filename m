Return-Path: <linux-pm+bounces-35543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC16BA85E0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 10:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17503B5329
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E46C26D4D7;
	Mon, 29 Sep 2025 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1bCd8uE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09053239E79
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759133555; cv=none; b=OrpI4yetvN9AW42FPdoz+TjIrIi7PDRyXFVrSXZVWKp2Dig4GWSf4pYcy8ntJb20x2w3K6/gfuaGCUnvopz+hwIPNZYocX5hi9MTC7P+SzatvhnBAo/rFe0a0tl/e0wGyo9pYve/rHBpH0wdemoqSXtDHv7b1YAkRlBM9cmTJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759133555; c=relaxed/simple;
	bh=P3xJLz/33GrYSj1aGgGnKj3afAwcVes4JbpYpwcAf48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJeeevVDradX1cdtw2niJ/EjVAHb5pF0btXav9iiNg4risGvTZYbGFTjMETVcZM8ES+r4OOWXiDUMBb05sy5QVO6mxVBZSpXeN1+4CiDyv4//1y2kxxJf74M70oyEvan4NEcgE7v3BuxAglI0njN6wK7WpCC+/Gzs4jwhBZnpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1bCd8uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E02C116B1
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759133554;
	bh=P3xJLz/33GrYSj1aGgGnKj3afAwcVes4JbpYpwcAf48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n1bCd8uEdDXb3e/m0Ca210ZBSO2VDbnETWstTPb5h6gBhbb4pi98A1KmgZMeRsDAI
	 cRoiDBnjoIRHbILIMlzLJRGIrdPve3P0MAYdFHUtxSA+6RtNelszXFklOMJfhCbFO1
	 413S/YXccMidN48uX80gscYW/p30RtdvA/3Gcqhq6tU3OOHmz1Z/uN4roW0fS/nads
	 YI93pHIFkg45eDp4SerlfkIGnn3LZIeHNQT0f3e49JohCK8o5w0RZUCt6Y/u65lHUZ
	 tjAedEqF8QsxKegHQrk0WzGjtn6fq8R67vbrEgTCZnEDkURBMa2dL2aeipkwhosL+J
	 Lm0D2vOZGwl/Q==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-31d6b8be249so4059700fac.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 01:12:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcBA/xM2gO3vt3TibiYOSFmjAWKwMwBz5UT0xLBZWFY/rpTT5tBYojgskTwFfgnRCGZLCgjDSHWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+IEFNmQ6PRhiDkf7PXcliHR2nVX9GRhlUAhbAEMWM3QnxoGGG
	4TUbKnxDV6hDFYDrIEz63BrcdNFs5B6Wv1xRwyP43BV4HSjNiJfbyXAgVP9jQX16/SNI8vbX33d
	QkQjoaqRVk6x/iXK4SP2pn9o5PrkyTjM=
X-Google-Smtp-Source: AGHT+IHEsUC5Tp8ILZbUVUxIcIq+/7rt16ij/PVeyXnmrLUh0s2P+VnYJUNfj/SPr9b7u07NPicC6tl/WicO+PPfKw0=
X-Received: by 2002:a05:6870:d6a4:b0:353:f24:e95a with SMTP id
 586e51a60fabf-35ef0761242mr6682731fac.42.1759133553974; Mon, 29 Sep 2025
 01:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <72b9ae1e-18a4-4b59-9c01-1248c38eee43@linuxfoundation.org>
In-Reply-To: <72b9ae1e-18a4-4b59-9c01-1248c38eee43@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Sep 2025 10:12:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsa3wMJ_xKj1M=vxq3WA0Ksj4TXOxOpRYPz0PDYJb09g@mail.gmail.com>
X-Gm-Features: AS18NWBW1DK_FG7uJ7i4RTcL2v1WnvaLFMQFkkGn90AurpyckD-me-E65oQJEO4
Message-ID: <CAJZ5v0gsa3wMJ_xKj1M=vxq3WA0Ksj4TXOxOpRYPz0PDYJb09g@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.18-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>, "John B. Wyatt IV" <jwyatt@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Sun, Sep 28, 2025 at 10:39=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.18-rc1.
>
> Fixes incorrect return vale in cpupower_write_sysfs() error path
> and passing incorrect size to cpuidle_state_write_file() while
> writing status to disable file in cpuidle_state_disable().
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca7=
6e:
>
>    Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.18-rc1
>
> for you to fetch changes up to 23199d2aa6dcaf6dd2da772f93d2c94317d71459:
>
>    tools/cpupower: Fix incorrect size in cpuidle_state_disable() (2025-09=
-24 17:15:35 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.18-rc1
>
> Fixes incorrect return vale in cpupower_write_sysfs() error path
> and passing incorrect size to cpuidle_state_write_file() while
> writing status to disable file in cpuidle_state_disable().
>
> ----------------------------------------------------------------
> Kaushlendra Kumar (2):
>        tools/cpupower: fix error return value in cpupower_write_sysfs()
>        tools/cpupower: Fix incorrect size in cpuidle_state_disable()
>
>   tools/power/cpupower/lib/cpuidle.c  | 5 +++--
>   tools/power/cpupower/lib/cpupower.c | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

