Return-Path: <linux-pm+bounces-38829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D03C8F470
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5CFE4E2059
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E4243954;
	Thu, 27 Nov 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7y68FME"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CDEACE
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257463; cv=none; b=V9aJVb1lgmJMHmlPHRzPN2dC+Tn1QlSVFE0MiZPoC/URSwARAvu0FbvZjW/5i7qlirMPYDTmEzyodY05KioFb0msOEvV5ZaliYZydubqgIo6UvmgddLkLgI3eYKs1wcDRAcDnOz/O2d8FR3drG0szQdgMqFWxh8plzkLUmLpBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257463; c=relaxed/simple;
	bh=sYtTNBOadogZzM6TCrdu9JnqEAS1uG7ULElUIB5gWcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsvAMqNa3iIhkQDOhn+Ky8ARM1HGLDfy2zSZz96iSCJvxPXKBSwWvWufc9PkLhm3CK1OfC2ylfX5T3Myhc1fNTNKQ4ayp14Gd8I45N2bHEePNfQYN8KOltss6CcTaYsrulH/g1QWMDTVonuDRUq33vwXgE5R4RyH2WtLznsBULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7y68FME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E529C116D0
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764257463;
	bh=sYtTNBOadogZzM6TCrdu9JnqEAS1uG7ULElUIB5gWcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L7y68FMEJ3T0Jyf6/Cm9BucJfPeorPlgq5QJ0ZIw64dzsSrVEtIK5JnK62ou5RD7H
	 /g6sxG3AToNm69ipcr1B910B0ipX8HuYthivLN7oiSY4ZWkkrruP6bo9yj0hlVaOLx
	 YL6cugPHqfID7QbUHDDpN4orXAFLfSv1R0sZT56V8eXY1fupP/mvGxPqZWVre7jiwa
	 T+vhjEmqk72yQLNqb1cT4BtOOQN58+OLYLK0m7FEvFnlKfrD4tloXh3mqAKR6tx7+l
	 fjSrJd6Urt2LS1qBBjNerZ5U7/vE0uHXn70OLh2FRhZfKYfO3FEc68w3s/kOeDPyFV
	 WgrxJMHIFuJbA==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-450ccefe6ffso448624b6e.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 07:31:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgsg5EZLAeQkM0IdpI5CLZ2P7EvxhZSDVIM+nznUlkXIfjKrAWjp1SoBg28SAXLnuDb1oMjaKRDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxONxRxmXkLtu7MencJFGPQVP8p8efjyR+aEnlMD8oWfnhGI1mr
	oxtgOC8hKI279fUT90W0Uhe+OJIADbKMrPzLCklvds4X2coVVYXVIXLLddUigtuKxoRWXNZGKpU
	/7RswDKms50L9E+4OS0yt6Quz1zjg2hU=
X-Google-Smtp-Source: AGHT+IGdV+s1K35Hs5DKsPZG2EAHD46cBmAnn6WPCpmeGBa2nMi4i+TUShA/I+4qb27bFZ9xiISXxhfgNGyo/kIj9YM=
X-Received: by 2002:a05:6808:151f:b0:450:c16b:7ade with SMTP id
 5614622812f47-45101ed206dmr10528277b6e.28.1764257462421; Thu, 27 Nov 2025
 07:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80e7bf9c-50b3-4e34-aa33-ff9c82479dc9@kernel.org>
In-Reply-To: <80e7bf9c-50b3-4e34-aa33-ff9c82479dc9@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 16:30:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ims3hag9xqk1p6k0dzETbEjopbBN2_FPbA3FCEkLaGdQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkSXJ7pBJmQpL7pG2CahbCDT-eiR8bqE9xvAifoq_KSblpbn898sHrtFoA
Message-ID: <CAJZ5v0ims3hag9xqk1p6k0dzETbEjopbBN2_FPbA3FCEkLaGdQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.19
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

On Thu, Nov 27, 2025 at 4:10=E2=80=AFPM Chanwoo Choi <chanwoo@kernel.org> w=
rote:
>
> Dear Rafael,
>
> This is devfreq-next pull request. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bce=
b0:
>
>   Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-6.19
>
> for you to fetch changes up to d9600d57668c49308f705a660c5ad17fa3a53f73:
>
>   PM / devfreq: Fix typo in DFSO_DOWNDIFFERENTIAL macro name (2025-11-26 =
13:58:59 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.19
>
> Detailed description for this pull request:
> - Move governor.h under include/linux/ and rename to devfreq-governor.h
>   in order to allow devfreq governor definitions in out of drivers/devfre=
q/.
>
> - Fix potential use-after-free issue of OPP handling on hisi_uncore_freq.=
c
>
> - Use min() to improve the readability on tegra30-devfreq.c
>
> - Fix typo in DFSO_DOWNDIFFERENTIAL macro name on governor_simpleondemand=
.c
> ----------------------------------------------------------------
>
> Dmitry Baryshkov (1):
>       PM / devfreq: Move governor.h to a public header location
>
> Pengjie Zhang (1):
>       PM / devfreq: hisi: Fix potential UAF in OPP handling
>
> Riwen Lu (1):
>       PM / devfreq: Fix typo in DFSO_DOWNDIFFERENTIAL macro name
>
> Thorsten Blum (1):
>       PM / devfreq: tegra30: use min to simplify actmon_cpu_to_emc_rate
>
>  drivers/devfreq/devfreq.c                          |  2 +-
>  drivers/devfreq/governor_passive.c                 | 27 ++++++++++++++++=
+-
>  drivers/devfreq/governor_performance.c             |  2 +-
>  drivers/devfreq/governor_powersave.c               |  2 +-
>  drivers/devfreq/governor_simpleondemand.c          |  6 ++--
>  drivers/devfreq/governor_userspace.c               |  2 +-
>  drivers/devfreq/hisi_uncore_freq.c                 |  6 ++--
>  drivers/devfreq/tegra30-devfreq.c                  | 15 ++++------
>  .../governor.h =3D> include/linux/devfreq-governor.h | 33 +++-----------=
--------
>  9 files changed, 45 insertions(+), 50 deletions(-)
>  rename drivers/devfreq/governor.h =3D> include/linux/devfreq-governor.h =
(80%)

Pulled and added to linux-pm.git/linux-next, thanks!

