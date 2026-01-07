Return-Path: <linux-pm+bounces-40397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C78CFFEFF
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 987F6303D8B7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF657328631;
	Wed,  7 Jan 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG38mJQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E726E6E8
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816214; cv=none; b=ITNkgPTc0LcJgJeFnmxag5qSh4zEZjDFczmVCnjoEn4Zx9XqkEvx2BAreI06FMPClVlYwB/CfbTNfYrxvdN8B0DId3qTa8acZSm5wwkS8vQXRWFYDyatJQh8ySr/cgt6TbTtredL2auJlJ/EAEXZnVBaslVn5COPuUeRO2zRB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816214; c=relaxed/simple;
	bh=cG9VQr+jc5f++sTl00Frvp7iPx5ElGSDhEz+iqKB5dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLunJBqNyxpALRgNKZZsmT3g+Ab7A4Lf5vvuaHhsv6G6pJboxm5pIIc+99jfE1Kn1o+CJlmdiwM+DLFEIS8ExTTg8TUja+s7lOdCAqAX5fBCiQjFh6vnWaMcvgYuJWq0i8DSfvrYt/5B++Vxop1NQ7XphtSMe3LUOJ/UEy5KNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG38mJQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC38C4CEF1
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767816214;
	bh=cG9VQr+jc5f++sTl00Frvp7iPx5ElGSDhEz+iqKB5dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vG38mJQgxMl6Ffw8POpzQt366SejPi1MwXx3w0eUJ9BWBV/cWmyRz8uyUQo0xUH5s
	 tAugQjxhCuH5Pe7pVYsuFmIzle3VX9F9cynCOQOpFCv8yvlsbRbWARip+HNKgEq7GE
	 KH8ljrCHrUeO7/ieAVhkgHa8bI5jfd6F0wx1wMK6VsranpktOmGV+yZ6eMav9Juse3
	 gP1sc6xxwdQz/1MBHMz5+Q5Ik89EfUFLrN/5BDuHRXDe6I9PiiUC7poKhzxGp+wkqK
	 TfxM5izLSj0bc1pqmgg8p3HpBPBvybupGxMb5Qfyg5fFyJo/LpWGuuXDQKjChtxmxQ
	 6F6qzEs/njmGw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65b6b69baf8so834067eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:03:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVA22jw2X58KFIFXbFBUN9E626b2t+CixwAZ2Z2Ol0V9dWt9RNc62BWkQefOVqXE+D9RHCI5BPOTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynuzW72A8rQucbecd/kM39+DeMzK8ow0loGmgYNbg1jdHuFsrQ
	2EkV+fdISDZYlj5hi345H4YsRMsoReOZz52dCA/64sugR7AebC70w8UAnZ0YU5wzaiG2h07cge5
	K8A2VL8DkbuU/qnlhRtyQYn8qKqvHslw=
X-Google-Smtp-Source: AGHT+IGcJ6kh7UzFHZJtGeN4iVGFHSWPFXx1fntABef5lMbXA6rFXT5pqZDdF/7JRhkcKVjD5mqofJLoDjgZqf9j11s=
X-Received: by 2002:a05:6820:220f:b0:65c:fd25:f430 with SMTP id
 006d021491bc7-65f54ee4e1bmr1498720eaf.20.1767816213457; Wed, 07 Jan 2026
 12:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e2424d2-7fd1-488d-901c-ba154cbfcd44@linuxfoundation.org>
In-Reply-To: <0e2424d2-7fd1-488d-901c-ba154cbfcd44@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:03:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jpx6WhgfX8E2SfWDV0C6OEWK539nYYSVnJ3_xGMBd1Cw@mail.gmail.com>
X-Gm-Features: AQt7F2oFdXz3y_v-jsa1T_amkH3XtGHWtsSPe2racgnvRB8FZeRCVdU3IxNJyJw
Message-ID: <CAJZ5v0jpx6WhgfX8E2SfWDV0C6OEWK539nYYSVnJ3_xGMBd1Cw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.20-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "John B. Wyatt IV" <jwyatt@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Wed, Jan 7, 2026 at 1:09=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.20-rc1.
>
> Fixes to miscellaneous problems in cpupower tool:
>
> - idle_monitor: fix incorrect value logged after stop
> - Fix inverted APERF capability check
> - Use strcspn() to strip trailing newline
> - Reset errno before strtoull()
> - Show C0 in idle-info dump
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1=
e8:
>
>    Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.20-rc1
>
> for you to fetch changes up to ff72619e11348ab189e232c59515dd5c33780d7c:
>
>    tools/power cpupower: Show C0 in idle-info dump (2025-12-15 12:33:29 -=
0700)
>
> ----------------------------------------------------------------
> cpupower update for Linux 6.20-rc1
>
> Fixes to miscellaneous problems in cpupower tool:
>
> - idle_monitor: fix incorrect value logged after stop
> - Fix inverted APERF capability check
> - Use strcspn() to strip trailing newline
> - Reset errno before strtoull()
> - Show C0 in idle-info dump
>
> ----------------------------------------------------------------
> Kaushlendra Kumar (5):
>        cpupower: idle_monitor: fix incorrect value logged after stop
>        tools/cpupower: Fix inverted APERF capability check
>        tools/cpupower: Use strcspn() to strip trailing newline
>        tools/power cpupower: Reset errno before strtoull()
>        tools/power cpupower: Show C0 in idle-info dump
>
>   tools/power/cpupower/lib/cpuidle.c                      | 7 +++----
>   tools/power/cpupower/utils/cpufreq-info.c               | 2 +-
>   tools/power/cpupower/utils/cpuidle-info.c               | 2 +-
>   tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 2 +-
>   4 files changed, 6 insertions(+), 7 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

