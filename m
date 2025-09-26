Return-Path: <linux-pm+bounces-35465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13047BA3C1A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE580383353
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8762F5A03;
	Fri, 26 Sep 2025 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7ZpBosi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCEA18C02E
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891979; cv=none; b=qxguAQLUlWrwMpOT7gYh3JqsUCb4qmpDcTqEU5PJv8v93ZbyhDLOojuBj2fRsag6p5Hxko7Eb/wMNHmZLLCm5b4Xjvu+TDPgosH2ikcCfEOd5lXbIa0Is5SlMQiYo2afVKoqDgEo9Jk/uJa/cSS8kWZ8dV+j7UQG7SVBqcjHQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891979; c=relaxed/simple;
	bh=3PunmQvhz24iJ2incEw/SRU487XUFFiCDh5FL12odFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI0N2f8Uw4l1PiVXxWu0yuS2ymw2sIj78g2qMyCCL9eEOPdHW7Vs4hN/4aLPO1PXacJIp4ZV/nNXqf63QAHhkNmkYQQz/hX1p+7QN7SZy36hARJXurLbDU8hinhmi1c+zgf4wHEUtK9+sn8qYLWr8eDIN/2joUjVsFdbwusdRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7ZpBosi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64719C113D0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891974;
	bh=3PunmQvhz24iJ2incEw/SRU487XUFFiCDh5FL12odFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P7ZpBosim34bKl671m3rz4LKB2QpjiXJAo3Xopi4KxW3ogsQD6c5frU4l4YqX8HRG
	 1+q1WuObcbQX+OaI6cSz9eCqBwxKi7Bf5dNEwS60XRBBtgsL8MXP0UizkD5Qw86r8D
	 4Qq0AlrYcN1V7Xx/OOUWHUfgXXxQbf9wrDpQ89QEUBNDBpfbdliFtEKiLfj2uLnfIc
	 NBl+0Xz+jB6VoffWFqRnk0KpQHVqVSyAyGks2N+gyfdDihjSrPyu4dGTAacOBRgCab
	 ShJM1BzSuF+PfgUr1NGKDlmZDprhJp17Czl/cLVjNt0HFnSdYVMqIrwtOwPgMw2+2J
	 W+iPfQb/VGkHA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30ccea8a199so1725588fac.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 06:06:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlE6LgcUkASMQTb8iYUPzBc+9aUb+LV7cSI8VRyHTU9M+TY2gW0PWMvNNp6kpDwukIqaXdUZL49A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/9+u/uPaqpykSZw3IkV0VxruMWISoJomClOw8388DuimbDwr
	R1jViImCLo0+Tv1xLiEZPTD1gv0ospDrKRVghUzSow68f9yZlUUjDj/H/xLIdBYgGyHj0dgsMWn
	WwI4tEf224f02Iy+dZs8sYDjz9wa6H0U=
X-Google-Smtp-Source: AGHT+IEPwyeuBHXc16YWp2PsaswycsNtvBeLhw3OhqSksQcjDSoutc6x+hTuokTSWF3yiQ9/FIOLaF5QZZO4MDnJk0A=
X-Received: by 2002:a05:6870:31a8:b0:30b:cce6:a5a1 with SMTP id
 586e51a60fabf-35ee98cef2dmr1645140fac.35.1758891973710; Fri, 26 Sep 2025
 06:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvTdKmpA9o1M-5Shp1vS2Feh3uLR-NdN97v7dj7odFs1YCOEw@mail.gmail.com>
In-Reply-To: <CAJvTdKmpA9o1M-5Shp1vS2Feh3uLR-NdN97v7dj7odFs1YCOEw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 15:06:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hGheN1nckqcGLK3S1m9PrSWuw5ehZhYDwCx-E9ubSUsA@mail.gmail.com>
X-Gm-Features: AS18NWDFKR8SHrbf-UK_doSriZaCrk8bS_xwHs_TNSHE_LyWB82Ab7xsQh1-b5Y
Message-ID: <CAJZ5v0hGheN1nckqcGLK3S1m9PrSWuw5ehZhYDwCx-E9ubSUsA@mail.gmail.com>
Subject: Re: [GIT PULL] Power utilities for Linux v6.18 merge
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Len,

On Fri, Sep 26, 2025 at 5:21=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> Hi Rafael,
>
> Please pull these power-utilities-for-v6.18-merge patches.
>
> thanks!
> Len Brown, Intel Open Source Technology Center
>
> The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e=
8f:
>
>   Linux 6.16 (2025-07-27 14:26:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
> tags/power-utilities-for-v6.18-merge
>
> for you to fetch changes up to 66f430522452fe1a8a0fd2198cf9f335125acbfc:
>
>   tools/power x86_energy_perf_policy.8: Emphasize preference for SW
> interfaces (2025-09-25 23:12:01 -0400)
>
> ----------------------------------------------------------------
> turbostat and x86_energy_perf_policy bug fixes for Linux-v6.18 merge
>
> ----------------------------------------------------------------
> Kaushlendra Kumar (2):
>       tools/power turbostat: Fix incorrect sorting of PMT telemetry
>       tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage
>
> Len Brown (7):
>       tools/power x86_energy_perf_policy: Enhance HWP enabled check
>       tools/power x86_energy_perf_policy: Enhance HWP enable
>       tools/power x86_energy_perf_policy: Prepare for MSR/sysfs refactori=
ng
>       tools/power x86_energy_perf_policy: EPB access is only via sysfs
>       tools/power x86_energy_perf_policy: Prefer driver HWP limits
>       tools/power x86_energy_perf_policy: Add make snapshot target
>       tools/power x86_energy_perf_policy.8: Emphasize preference for
> SW interfaces
>
>  tools/power/x86/turbostat/turbostat.c              |   2 +-
>  tools/power/x86/x86_energy_perf_policy/Makefile    |  29 ++++-
>  .../x86_energy_perf_policy.8                       |  15 ++-
>  .../x86_energy_perf_policy.c                       | 133 ++++++++++++++-=
------
>  4 files changed, 129 insertions(+), 50 deletions(-)
>

Pulled and added to linux-pm.git/linux-next, thanks!

