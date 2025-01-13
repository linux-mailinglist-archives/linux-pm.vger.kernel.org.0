Return-Path: <linux-pm+bounces-20379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D266AA0C198
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA2188BBEA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01C1CEADC;
	Mon, 13 Jan 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OglH2+Iy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A231CEACB;
	Mon, 13 Jan 2025 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796915; cv=none; b=JlAkGhHikzx81LLav+3Geujkx7umECelNsYMoa4I8h5m0OHPcsd0LoqfSBxQBFamgPKBc3r4ZdPQp/Bi8YcSdbz8b2ZEftinTf9aVum7K4vGJHLwPcYpS1g2yKAgpslRY49Lr7GiqN39C2WtAEYkDUvXGzG6JvDPJ/rf6GO8Rr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796915; c=relaxed/simple;
	bh=XvclYCCVAktsQZ4/EYoEoKOpCU7UuNxbB52hZC8Grdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meB3W/Sw6S0+CXwM6yWzPCmXD96211fzkgQD0/TMR6b+VV9vpIF3pMa2qdhiBCzERsJYk+rPRei1zSBnrQ+Bd55AtsHa9/kF713J7/Lovgx1UFiicU7sJjtUScMORggJhOmMNk7fFRQOQ10WR5rpX8dzyNNOzXb5RytkOGrGZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OglH2+Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CBFC4CEE3;
	Mon, 13 Jan 2025 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736796914;
	bh=XvclYCCVAktsQZ4/EYoEoKOpCU7UuNxbB52hZC8Grdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OglH2+IySrt6bAhQVsGdZ5MOZBszMEOEadS9q8FVHpn7yiDOg8+hsvLjW1gvCmxOl
	 HwryZfAR8V954nNT+yMlzvkiu7EZGP0ycn1Ux7OgiZPirwFLf2iBZJupoasN0SMhR1
	 oLq4xGbeMl06vANgWQrtOxr38VA61VYVppn0IB/maJUHz4iCo8kTm1Xu4Ap7mlON8h
	 VjHEyFlBSomU59dBSa+chgoEVDwrgCnyvMYKYxEbONRKKPFAAN1nza1rDqhB9Uh9+3
	 JvLjys0Ug1+SKpsjH13qlY5wCruyW5E0pI3tjlLWe9odSondF3Ua2ItfsXKTWu3Mww
	 CUl1FUt8usDSw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eba7784112so2553677b6e.2;
        Mon, 13 Jan 2025 11:35:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwC3cjOksmPjZjOf4Rer9bhzbkqXNPsl6jmEwaiT/HWmbXT6JdrKj/dos9dV85DRgQTZdoWoamt5dwyQI=@vger.kernel.org, AJvYcCX2t+azlghq6z24MiH4qp5erg5i2jpaXukrzqAoM+DyekIMdzs3zOWovWu/RE9ld4F1U7clmwKFa5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ypnaITUdPHaDf9+Ei+9wDOluQCzwAHeIIn9dx/yh1P08Eh3B
	z8k2Yb0BFWdgCw5LdafFToPAYy+S2xItzL2EAPnDq4T0OXJAAq75xCLDpN2bfblv3TxOuGKmu+7
	MTuTcL8t680iM1kBqPZWtcpDlGlA=
X-Google-Smtp-Source: AGHT+IE2uG16/9YiE0bIL1nFfXnRUVzp2lsbaUFE0lHdeswwQB+1JG5OL/zmCdaqsevyn3IX0Af0TBHwG+cXXBpSxdk=
X-Received: by 2002:a05:6808:250c:b0:3ea:6533:f19d with SMTP id
 5614622812f47-3ef2ed70cd1mr14639154b6e.30.1736796913276; Mon, 13 Jan 2025
 11:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe61c48e-d34a-4d57-98ef-1eebc6cad797@linuxfoundation.org>
In-Reply-To: <fe61c48e-d34a-4d57-98ef-1eebc6cad797@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jan 2025 20:35:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i+E=Aw8DGcsKCgddh646d+_cbp74-UX=x-wyHi7g+XbQ@mail.gmail.com>
X-Gm-Features: AbW1kvawIqobrgE5m6EPtjCallc2cHSawa7qiDsqlyXmvpxOV4t_tiJrdrOZN2E
Message-ID: <CAJZ5v0i+E=Aw8DGcsKCgddh646d+_cbp74-UX=x-wyHi7g+XbQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.14-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Thu, Jan 9, 2025 at 12:14=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.14-rc1.
>
> Several fixes, cleanups and AMD support enhancements:
>
> - fix TSC MHz calculation
> - Add install and uninstall options to bindings makefile
> - Add header changes for cpufreq.h to SWIG bindings
> - selftests/cpufreq: gitignore output files and clean them in make clean
> - Remove spurious return statement
> - Add support for parsing 'enabled' or 'disabled' strings from table
> - Add support for amd-pstate preferred core rankings
> - Don't try to read frequency from hardware when kernel uses aperf mperf
> - Add support for showing energy performance preference
> - Don't fetch maximum latency when EPP is enabled
> - Adjust whitespace for amd-pstate specific prints
> - Fix cross compilation
> - revise is_valid flag handling for idle_monitor
>
> diff is attached.

Pulled and added to linux-pm.git/linux-next, thanks!

> ----------------------------------------------------------------
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b=
37:
>
>    Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.14-rc1
>
> for you to fetch changes up to 8d097444982d7b23a5396169dc9d2923a59b5a79:
>
>    pm: cpupower: Add header changes for cpufreq.h to SWIG bindings (2024-=
12-27 08:11:51 -0700)
>
> ----------------------------------------------------------------
> linux-cpupower-6.14-rc1
>
> Several fixes, cleanups and AMD support enhancements:
>
> - fix TSC MHz calculation
> - Add install and uninstall options to bindings makefile
> - Add header changes for cpufreq.h to SWIG bindings
> - selftests/cpufreq: gitignore output files and clean them in make clean
> - Remove spurious return statement
> - Add support for parsing 'enabled' or 'disabled' strings from table
> - Add support for amd-pstate preferred core rankings
> - Don't try to read frequency from hardware when kernel uses aperf mperf
> - Add support for showing energy performance preference
> - Don't fetch maximum latency when EPP is enabled
> - Adjust whitespace for amd-pstate specific prints
> - Fix cross compilation
> - revise is_valid flag handling for idle_monitor
>
> ----------------------------------------------------------------
> He Rongguang (1):
>        cpupower: fix TSC MHz calculation
>
> John B. Wyatt IV (2):
>        pm: cpupower: Add install and uninstall options to bindings makefi=
le
>        pm: cpupower: Add header changes for cpufreq.h to SWIG bindings
>
> Li Zhijian (1):
>        selftests/cpufreq: gitignore output files and clean them in make c=
lean
>
> Mario Limonciello (7):
>        cpupower: Remove spurious return statement
>        cpupower: Add support for parsing 'enabled' or 'disabled' strings =
from table
>        cpupower: Add support for amd-pstate preferred core rankings
>        cpupower: Don't try to read frequency from hardware when kernel us=
es aperfmperf
>        cpupower: Add support for showing energy performance preference
>        cpupower: Don't fetch maximum latency when EPP is enabled
>        cpupower: Adjust whitespace for amd-pstate specific prints
>
> Peng Fan (1):
>        pm: cpupower: Makefile: Fix cross compilation
>
> wangfushuai (1):
>        cpupower: revise is_valid flag handling for idle_monitor
>
> tools/power/cpupower/Makefile                      |  8 +++++
>   tools/power/cpupower/bindings/python/Makefile      | 10 ++++++
>   tools/power/cpupower/bindings/python/README        | 25 +++++++++++++++
>   .../cpupower/bindings/python/raw_pylibcpupower.swg |  3 ++
>   tools/power/cpupower/lib/cpufreq.c                 | 18 +++++++++++
>   tools/power/cpupower/lib/cpufreq.h                 |  8 +++++
>   tools/power/cpupower/utils/cpufreq-info.c          | 36 +++++++++++++++=
+++++--
>   tools/power/cpupower/utils/helpers/amd.c           | 18 ++++++++---
>   .../cpupower/utils/idle_monitor/hsw_ext_idle.c     |  4 +--
>   .../cpupower/utils/idle_monitor/mperf_monitor.c    | 17 +++++-----
>   tools/power/cpupower/utils/idle_monitor/nhm_idle.c |  2 +-
>   tools/power/cpupower/utils/idle_monitor/snb_idle.c |  4 +--
>   tools/testing/selftests/cpufreq/.gitignore         |  2 ++
>   tools/testing/selftests/cpufreq/Makefile           |  1 +
>   14 files changed, 137 insertions(+), 19 deletions(-)
>   create mode 100644 tools/testing/selftests/cpufreq/.gitignore
> ----------------------------------------------------------------

