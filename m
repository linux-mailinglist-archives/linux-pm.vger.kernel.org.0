Return-Path: <linux-pm+bounces-28244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 493A8AD13BC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6694518834DC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E713C1AA7BF;
	Sun,  8 Jun 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8BN9oJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD585191F66;
	Sun,  8 Jun 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749407036; cv=none; b=FLvkr9emyE0mQPKh52LApIVer2j1HBA83wTzzzRAkju88Kfj1hjazIoJAw56cyXwpGTBfp640nvwupa3NRUmxiVwiczil4spgNJmogN3Iqj7z64/1N5hCLnS/tv+u80+TeR/Fx4ylV516dzTua9faUDiMEYxpgwnr+GFrDJnpto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749407036; c=relaxed/simple;
	bh=DBJ8R+2fo/qT97sNm/n8vppoQeD7u3dmalSYk9+3nNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PahC1L+0XbO38m42SEN3zg71bzomBPr6hNpxDaO17GgXXAHbDjoZoAjIPnkM6b16iVXykwCZDLEoFYjurjFz/kxMQtXGztPd1mrv+FXLE4QaauxG/xJNRODgqgnANNIHjHYSN4Jmewf6dQj5lXT1hPhLQ6rZFs6RNw4Nx1wMnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8BN9oJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C1AC4CEEE;
	Sun,  8 Jun 2025 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749407036;
	bh=DBJ8R+2fo/qT97sNm/n8vppoQeD7u3dmalSYk9+3nNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n8BN9oJM/1Tn5r+9fYeLCUCA5t/xRQKW/mS3foLhLcfUDmpMC9eS+h1qIfnu8eScn
	 N/zL3kQ2ZNgEQldTjNciAZ4zP6d/sjRgzUUTimNhj3mj9ZfFTw71abW5PcIkUk1EIu
	 79Ye0QRzvO2DQRi+PUskGW1yqpLme8eWxrteNYPTp81esCq+3eYu5ADQGxoRewqflE
	 r2iA6Hxj8bkKwbQTWF56NH8QD4lYldBZ2L0VFRnFjMQrG0SDSjif7zv+lJcpxTDebP
	 hAsagaJVaEJEmysUwU+KiuuKfbc1Qb4LuIkSO/EFOVKI2bkBXBk9u3/NtQwqeU7N8Q
	 05qWyBXHI25bQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60657f417c4so1644723eaf.0;
        Sun, 08 Jun 2025 11:23:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVF39E4Q8gzeiW9oH8uYsNNrfmYXL04RJT3KcRPIbRM0SvG5px7S7iWnBqKZqpIwIukpUqFt1omTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBbEv01sywtdMOiXX5XiPzUm6tMQ4TYTKYOsuGnxJK8oKHsb3
	7Pde/xiU5rfjYi+HggaQjq4ZmPVwBPFLsEq8VcxycxJO3ZRYBYA0GrUFCj6YmHqE73W3BwcWODx
	D21SLgHGFh7x8LPIXH1ilPke6DAorQtg=
X-Google-Smtp-Source: AGHT+IEGIZl4Mi0OO01RfgmKmP4T0SfenKlij1MqAUoNsAS6oJA52KObH9TM9Nx6KfabW1jyAxruVovjd7NYDXu1C+M=
X-Received: by 2002:a05:6870:1996:b0:2d5:2955:aa57 with SMTP id
 586e51a60fabf-2e9ffd8a37bmr6341720fac.0.1749407036035; Sun, 08 Jun 2025
 11:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvTdK=9R+A=b=NY5OM2jiSupofrnJOKXrFCGeXfAfN57VhE_g@mail.gmail.com>
In-Reply-To: <CAJvTdK=9R+A=b=NY5OM2jiSupofrnJOKXrFCGeXfAfN57VhE_g@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Sun, 8 Jun 2025 14:23:44 -0400
X-Gmail-Original-Message-ID: <CAJvTdKkpMWWtfSFqEqzjSxcvSqUjjcTC6+Yub8Q+Twu+PM99mQ@mail.gmail.com>
X-Gm-Features: AX0GCFs4KLBkdaC0tFEpuG7djQ1MopgRJr-NzEqRxK7UAO4wEXEUYPFL9sUzVRs
Message-ID: <CAJvTdKkpMWWtfSFqEqzjSxcvSqUjjcTC6+Yub8Q+Twu+PM99mQ@mail.gmail.com>
Subject: Fwd: [GIT PULL] turbostat 2025.06.08
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull these turbostat patches.
(same as previous message, but added list cc's)

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 0ff41df1cb268fc69e703a08a57ee14ae967d0ca:

  Linux 6.15 (2025-05-25 16:09:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2025.06.08

for you to fetch changes up to 42fd37dcc432df1ea1987232d41bb84fcb7e150c:

  tools/power turbostat: version 2025.06.08 (2025-06-08 14:10:17 -0400)

----------------------------------------------------------------
turbostat v2025.06.08

Add initial DMR support, which required smarter RAPL probe
Fix AMD MSR RAPL energy reporting
Add RAPL power limit configuration output
Minor fixes

----------------------------------------------------------------
Gautham R. Shenoy (1):
      tools/power turbostat: Fix AMD package-energy reporting

Kaushlendra Kumar (2):
      tools/power turbostat: Add Android support for MSR device handling
      tools/power turbostat: Fix RAPL_GFX_ALL typo

Len Brown (3):
      tools/power turbostat.8: fix typo: idle_pct should be pct_idle
      tools/power turbostat.8: pm_domain wording fix
      tools/power turbostat: version 2025.06.08

Zhang Rui (12):
      tools/power turbostat: Always check rapl_joules flag
      tools/power turbostat: Quit early for unsupported RAPL counters
      tools/power turbostat: Remove add_rapl_perf_counter_()
      tools/power turbostat: Remove add_cstate_perf_counter_()
      tools/power turbostat: Remove add_msr_perf_counter_()
      tools/power turbostat: Introduce add_msr_counter()
      tools/power turbostat: Clean up add perf/msr counter logic
      tools/power turbostat: Allow probing RAPL with
platform_features->rapl_msrs cleared
      tools/power turbostat: Avoid probing the same perf counters
      tools/power turbostat: Dump RAPL sysfs info
      tools/power turbostat: Add initial support for DMR
      tools/power turbostat: Add initial support for BartlettLake

 tools/power/x86/turbostat/turbostat.8 |   6 +-
 tools/power/x86/turbostat/turbostat.c | 468 ++++++++++++++++++++++++++--------
 2 files changed, 364 insertions(+), 110 deletions(-)

