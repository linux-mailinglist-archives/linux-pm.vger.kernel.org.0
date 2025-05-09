Return-Path: <linux-pm+bounces-26944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632DAB151F
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAED189E07F
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA729189B;
	Fri,  9 May 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ea3R4BAv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FC291899
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797125; cv=none; b=PvN5AGDZk8ORf+CD+94Q0uFLOh1PFSw3Mq+mVgVt/uEDYGac/blJl6dcRJ71PWIjEzUNuVS0ph77QkoYEysinNjxDUzgdjlm/IQzjGwKZXTmL1N0mLcplq7meocw8RRoOGCJAlQnDGgU6E8ejfqqclszx0HFx+uzpDjJ71Vl7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797125; c=relaxed/simple;
	bh=PCJ2NA79JSKUQsjDG0PDOEoE6D6p5/xYWBudELjBPw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFQiCOSODS9tIlYoWY5XiYIEbr3wPyRSxtMSlRAR4WhUTDx9o0XgtXJHNxjaIGtVeLFHoXD614aWmC/mTCM7nSi33wiNC771E4cYVIie7PcYaikS90WTuYSeROH3gAd87lx1Y/sof7QLNdbdWLxSgjliKAqyCrobsGWpYZF9+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ea3R4BAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C3AC4CEE4
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746797124;
	bh=PCJ2NA79JSKUQsjDG0PDOEoE6D6p5/xYWBudELjBPw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ea3R4BAv3VR94Qk3OAG6kwcaiKC5pVWu8IIPL44Dyuf9SBpc1mcSmskEf391ryglE
	 4T7z6MMF3SYah1psD4t+yBT6Z7OD18P2EukuSLQp7W6jCx8gqCxlaG4gd+3r1dj+EI
	 VrBZ0JBPC/T1DoVfvoXKOrWSfwHPGvws8JjD+rsDykddux5vAhoZkjYcI45sQo6DsX
	 N3SrSiydNyXXz+zVXr1JxN1XFJRAVN+Bsb+2iPwzxnuQjC0NV8xsjGmgKSsEFmVO+q
	 kJyjAkh9nzOjvCNuDJ1WHLt2iUGL2YiFugygj2K6aqGnl3vSFccK957madTU743Gjv
	 7VsuZnRpRkDLg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-401c43671ecso1245330b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2025 06:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWtoSGPf4Sc9G53Mub7S4trv+so6XPL+nRjIDcqaQTj8BK6eI/U23FN+nTQY6J+AT7oa/uKdsVZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8oxQmpm/RvQnrnH9AjRhjdcQYaL4znPXLzJNmln737WQ08hX
	uoSesKaomBgei0dFyvlmxcFPJsoftemNKB0wTQ1Av0uS35Pn/5DNKae4IN5+0f4BChIqJ600bBU
	fGCV/BmsHfjKoLCbAMA3ZLF/oYNA=
X-Google-Smtp-Source: AGHT+IFcwjuXv5BQWusvPtLznol3Zdz7ZENSyJuUSpHfIJhbikQN3tt7De1ItA1Z9GpogRuicd2BGuNbyVRIMjr0XwY=
X-Received: by 2002:a05:6808:2107:b0:401:bb42:700c with SMTP id
 5614622812f47-40377a09173mr4390221b6e.19.1746797124222; Fri, 09 May 2025
 06:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5524b46b-88c4-46f6-ab12-96c6a10d84dc@kernel.org>
In-Reply-To: <5524b46b-88c4-46f6-ab12-96c6a10d84dc@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 15:25:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gpcE6PoJ0QSW2sVSHPnxBw2GSzncP7xtMYDi4JSG5CTA@mail.gmail.com>
X-Gm-Features: ATxdqUH7ZfGWDwCU44yHrquLBC_p6-15s5KMDY4LVycgvNGVMIozFjbVZmdj7fI
Message-ID: <CAJZ5v0gpcE6PoJ0QSW2sVSHPnxBw2GSzncP7xtMYDi4JSG5CTA@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.16 (5/8/25)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:23=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> The following changes since commit 9c32cda43eb78f78c73aee4aa344b777714e25=
9b:
>
>    Linux 6.15-rc3 (2025-04-20 13:43:47 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.16-2025-05-08
>
> for you to fetch changes up to d26d16438bc5fd5524121244cc133f9872a63210:
>
>    amd-pstate-ut: Reset amd-pstate driver mode after running selftests
> (2025-05-05 12:07:42 -0500)
>
> ----------------------------------------------------------------
> amd-pstate content for 6.16 (5/8/25)
>
> Add support for a new feature on some BIOS that allows setting
> "lowest CPU minimum frequency".
>
> Fix the amd-pstate-ut unit tests to restore system settings when done.
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (3):
>        cpufreq/amd-pstate: Move max_perf limiting in amd_pstate_update
>        cpufreq/amd-pstate: Add offline, online and suspend callbacks for
> amd_pstate_driver
>        cpufreq/amd-pstate: Add support for the "Requested CPU Min
> frequency" BIOS option
>
> Swapnil Sapkal (1):
>        amd-pstate-ut: Reset amd-pstate driver mode after running selftest=
s
>
>   drivers/cpufreq/amd-pstate-ut.c |  19 ++++++++++++-------
>   drivers/cpufreq/amd-pstate.c    | 113
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++-------------------------
>   drivers/cpufreq/amd-pstate.h    |   3 +++
>   3 files changed, 103 insertions(+), 32 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!

