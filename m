Return-Path: <linux-pm+bounces-32083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2EB1F7F6
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 03:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1359C3AF7E5
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 01:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD4142E83;
	Sun, 10 Aug 2025 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvu2dLrK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160928DB3;
	Sun, 10 Aug 2025 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754789848; cv=none; b=FlDicfLHULqakmp0RuxZODTejy06y2ReW5SzZ0GPHqlCcDCd0pdsOpd7LVdzTCixf2p8sWK0v2JbdFBUIPPQ462aJ4dJ9dHDttBNc2nala1pmQbjSLSdvVaMeU60EfBePCkmf8L86tRTXK2fpEx1j8WyRT1TarHzT43gLZw4uKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754789848; c=relaxed/simple;
	bh=RUdGfNwnNUyS9Ti5y2wrAeY7SHI7G331y2TwD0SWvzU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fkiehorNfUHUaEcShTAAvxQI6hqLPoWNJnY0H4cSf5fwEu6Uq1F+gZnn531bY6muZ9qofvl2DWZ5FQ3k+gdk/EXC/Qu2+YCsKs2SHCsAuPirlZnqvAnJcbhX3zTbWxDwL3bV2JbUoR/1obFj70ScZCpbvC8u8ltINizZGvbELoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvu2dLrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A311DC4CEF1;
	Sun, 10 Aug 2025 01:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754789847;
	bh=RUdGfNwnNUyS9Ti5y2wrAeY7SHI7G331y2TwD0SWvzU=;
	h=From:Date:Subject:To:Cc:From;
	b=hvu2dLrKms8Q4JxDaZRjvbwmM2ZJNhMvSgUmaFugvbfM2x71UExJztZywb5+tzbmv
	 79PKsdjGurA4tNBpWtWDHD11Q4ByuCExh+uqsFopmu1tsBOCewb7/2aZmVIVWiRM78
	 vuGcSB5K7a4ys6JFtazdO1+CgMFxo17ZZnOJFt+/R8BjUd6J02wGpsZD8RUSKz5dcF
	 I+kljgMMxCZuT6cY+4P9UPgaC1NDxdeKfcisSUt52ItUOPgiiKbs9fs0Obh4jPt5jz
	 qyLKfbCx45PPxFsVU3pjVNB32UTjJKFwPPvbpIK0iU9Nes7Nl2SUHdErDGKy5pH00h
	 gBp85VyGO60sA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4358a73e8a3so1808565b6e.0;
        Sat, 09 Aug 2025 18:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeFHxkKSQSScYfzcxxMOMla9iQfD+qQPYgZ6EOEPbNkcmuMgIBCrTel4BRpmU0zU/bHi7XBCdLV+DN5wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkE4A3u8P09FaHQntk/YucITpOJbqjqQ7rgwVACUYaELN4wqkc
	6psZ6MpQswIxkzW1HCu8zitdXulvrH0hZPTbBpli+Tqu27kAXzl4D/TchMBGIij8vrYPOrubT3N
	+EbD4QlSSYhYToDD3fbYMOXk7hj+bPM0=
X-Google-Smtp-Source: AGHT+IEXw6o66pBSsh70Q7k7zl8u/vugFOkb8apWk8ZS4cTRN1nDh+cCaoI3JJTDBYrG9efeo8zkgRaWiuG2eUo7Wvc=
X-Received: by 2002:a05:6808:309b:b0:434:f62:691a with SMTP id
 5614622812f47-43598032d8fmr4304097b6e.36.1754789847086; Sat, 09 Aug 2025
 18:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sat, 9 Aug 2025 21:37:16 -0400
X-Gmail-Original-Message-ID: <CAJvTdKmaTvaQiRjgz_Pr6a+XEkLzEnedujV=vqwv5thEE63fdg@mail.gmail.com>
X-Gm-Features: Ac12FXxsmKmN87fte09-lg5tsvYE2_C0QurvuoMpmGpwONLtJ3qUZ_Z5Hpi0L1U
Message-ID: <CAJvTdKmaTvaQiRjgz_Pr6a+XEkLzEnedujV=vqwv5thEE63fdg@mail.gmail.com>
Subject: [GIT PULL] turbostat v2025.09.09 for Upstream Linux
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull these turbostat patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 42fd37dcc432df1ea1987232d41bb84fcb7e150c:

  tools/power turbostat: version 2025.06.08 (2025-06-08 14:10:17 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2025.09.09

for you to fetch changes up to 5e98a5e73edcc4114c5ad10596db87e24f50ee4d:

  tools/power turbostat: version 2025.09.09 (2025-08-09 21:24:46 -0400)

----------------------------------------------------------------
tools/power turbostat: version 2025.09.09

Probe and display L3 Cache topology
Add ability to average an added counter
(useful for pre-integrated "counters", such as Watts)
Break the limit of 64 built-in counters.
Assorted bug fixes and minor feature tweaks

----------------------------------------------------------------
Calvin Owens (2):
      tools/power turbostat: Fix build with musl
      tools/power turbostat: Handle cap_get_proc() ENOSYS

Len Brown (9):
      tools/power turbostat: regression fix: --show C1E%
      tools/power turbostat: verify arguments to params --show and --hide
      tools/power turbostat.8: Document Totl%C0, Any%C0, GFX%C0, CPUGFX% columns
      tools/power turbostat: Support more than 64 built-in-counters
      tools/power turbostat: probe and display L3 cache topology
      tools/power turbostat: delete GET_PKG()
      tools/power turbostat: standardize PER_THREAD_PARAMS
      tools/power turbostat: Handle non-root legacy-uncore sysfs permissions
      tools/power turbostat: version 2025.09.09

Michael Hebenstreit (1):
      tools/power turbostat: add format "average" for external attributes

Zhang Rui (2):
      tools/power turbostat: Fix bogus SysWatt for forked program
      tools/power turbostat: Fix DMR support

 tools/power/x86/turbostat/turbostat.8 |  11 +-
 tools/power/x86/turbostat/turbostat.c | 768 ++++++++++++++++++++++++----------
 2 files changed, 554 insertions(+), 225 deletions(-)

