Return-Path: <linux-pm+bounces-39249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C5DCA84AB
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 17:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D546304F2AD
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930FD33A71D;
	Fri,  5 Dec 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcLPpYAR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C62242D7B
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764949588; cv=none; b=sbhwgNGPjd+ZasyrWXrBOlkEvASFQLdsFktfXfvONNpvmF6+Lpxc8L93nVbhScYjCFc3hJLDDrPsXJX/V4njUY00t3n+AeNMBGkQ18xzgqPHUXXemLPofA6EzRufvNPy8YiWPWk5Wu5Wu1Pr4RgJVTflyhJjy0bTEJQDEr7CvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764949588; c=relaxed/simple;
	bh=N/Jm60MWz7VJIgnSF1AGALjC4UOeRFad7YVXz1v4y0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tsEq69mxQJlpxUG0YZ1TESHWLsLONS7AB/1TKwUKEBtmRvv15bhAKZLPEZcV9FNUJLC+K3F0WQPdVJWxPFfHgpLCmHjE8v4wN78+/TDFHngkbnMVm2wjKnjToFiWqJWAJU4R3wLVk7RFofynL+mBfixwObZYwT+xcNlcC9wL5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcLPpYAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCEFC4CEF1
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764949586;
	bh=N/Jm60MWz7VJIgnSF1AGALjC4UOeRFad7YVXz1v4y0I=;
	h=From:Date:Subject:To:Cc:From;
	b=FcLPpYARvlTut5/Gc+hVIOhY4w7XYfGT0nlfPJt3CCZ5EuHlFImR9PoqquI577PDX
	 eLGYWtIbUMF9pELWt9iV/u9PgrkuPS3ufw+taIb1KV7jHF0TtjeXt/I/idGbmRIwEt
	 NNYT7rASRHr+NS8/nJaDG6/q1uCpk/J6xniwNJpO7DRMo+Uo0EPhyxkooul+0FwFLa
	 xYrOHU1XT08n0PcyQ83TK9fGzec8axARQJk3/p292BMpYTtoFXcq9vr0XeD2jR8PB3
	 3a3fYaTHoFu3voWWvueTlTLOHlAwpyueVs0UVi8yYe52X2uIXgcUV9KTkYoGoepQCq
	 VZb4LfFEC2xGw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4505b05e7b5so757194b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Dec 2025 07:46:26 -0800 (PST)
X-Gm-Message-State: AOJu0YyLciUAkQT2BBXyAGDvU4MFSdH1OSNDAhAz5fwgGaqp4bhOmSgj
	TLS+n91nDukG/dLJ9l9cAB+OJFHS3yym5665wDJ4fhuUTC4skx5zts7lsUbaSuo6zLjRU+nA6Jz
	X4qeiFcPJVAo1FVodqQsQ8KzcipM1AMc=
X-Google-Smtp-Source: AGHT+IEeNeC5h+YdpRRcYH/MxAW8LLVSBjPp/KnnBYhuLhmycSgdOLSb1almK7+XD90reP8pvKgJ/LMV5Dk5rz+ya80=
X-Received: by 2002:a05:6808:170a:b0:450:b947:1d89 with SMTP id
 5614622812f47-4536e3af715mr5428648b6e.14.1764949585842; Fri, 05 Dec 2025
 07:46:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Fri, 5 Dec 2025 10:46:13 -0500
X-Gmail-Original-Message-ID: <CAJvTdKkNX-iyB5Zuk+fRQCaihXSkdZz19FsvB8wD8H+OGw0hzg@mail.gmail.com>
X-Gm-Features: AQt7F2oog-U6VsWT0aSc7twIW2QB47F8udELPSq2UCWPqjPD9pRX77C7OKP-6GI
Message-ID: <CAJvTdKkNX-iyB5Zuk+fRQCaihXSkdZz19FsvB8wD8H+OGw0hzg@mail.gmail.com>
Subject: [GIT PULL] utility updates for Linux-6.19-merge
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull these utility patches (turbostat and
x86_energy_perf_policy) patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-v2025.12.02

for you to fetch changes up to 9c0bad7508a81110b3216231bde2a10baf7126f0:

  tools/power turbostat: version 2025.12.02 (2025-12-02 16:11:14 -0500)

----------------------------------------------------------------
turbostat-v2025.12.02

Since turbostat-v2025.09.09:

Add LLC statistics columns:
    LLCkRPS = Last Level Cache Thousands of References Per Second
    LLC%hit = Last Level Cache Hit %
Recognize Wildcat Lake and Nova Lake platforms
Add MSR check for Android
Add APERF check for VMWARE
Add RAPL check for AWS
Minor fixes to turbostat (and x86_energy_perf_policy)

----------------------------------------------------------------
Emily Ehlert (1):
      tools/power turbostat: Set per_cpu_msr_sum to NULL after free

Kaushlendra Kumar (1):
      tools/power x86_energy_perf_policy: Add Android MSR device support

Len Brown (17):
      tools/power turbostat: Regression fix Uncore MHz printed in hex
      tools/power turbostat: Add Wildcat Lake and Nova Lake support
      tools/power turbostat: Refactor added column header printing
      tools/power turbostat: Refactor added-counter value printing code
      tools/power turbostat.8: Update example
      tools/power turbostat: Refactor floating point printout code
      tools/power turbostat: Remove dead code
      tools/power turbostat: Add LLC stats
      tools/power turbostat: Add run-time MSR driver probe
      tools/power x86_energy_perf_policy: Simplify Android MSR probe
      tools/power turbostat: Validate RAPL MSRs for AWS Nitro Hypervisor
      tools/power turbostat: Enhance perf probe
      tools/power turbostat: Validate APERF access for VMWARE
      tools/power turbostat: Print "nan" for out of range percentages
      tools/power turbostat: Print percentages in 8-columns
      tools/power turbostat: Print wide names only for RAW 64-bit columns
      tools/power turbostat: version 2025.12.02

Malaya Kumar Rout (2):
      tools/power x86_energy_perf_policy: Fix format string in error message
      tools/power x86_energy_perf_policy: Fix potential NULL pointer dereference

 tools/power/x86/turbostat/turbostat.8              |   27 +-
 tools/power/x86/turbostat/turbostat.c              | 1205 ++++++++++----------
 .../x86_energy_perf_policy.c                       |   47 +-
 3 files changed, 660 insertions(+), 619 deletions(-)

