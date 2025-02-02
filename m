Return-Path: <linux-pm+bounces-21249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF9FA24F32
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049BE162EDA
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C01FBCA0;
	Sun,  2 Feb 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpLCJHHj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F02557C;
	Sun,  2 Feb 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516611; cv=none; b=UyLqga2Ph7KQGcwJkpLo19+v/JJvYtVEHcQWIkCzNlGbWVpzX0K5PMB8qbb+8kItrhQabbt9cgaBb0XQMvFGon/uSt5TUAwycyaacBR5OOWwyLEk+dd70nMODwElo/xJDG/bm9P7H8HqGvIQPQFYuc1+iKmC/ezuW26AtZtze24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516611; c=relaxed/simple;
	bh=2VKY0kTfoAx3tfZYb+iJ1/HcDwT0KtEPCUUGZkMWgPM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e5zh1Sy9iTkSLzcv6JjOZksRvOtQcExBJNoslJGtuZ1BBTLX3zrk05Kxr+6QHyhD2Y3yJDTev06UmTYMdihyK/OO+EJoDthudiprMyqLyz3UBGcMIyBldmlqIIyY7ZOEyf6txr2rR1RguaVFHFRZdJMtqj5Ndnmd9x2Kdglx3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpLCJHHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36284C4CED1;
	Sun,  2 Feb 2025 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516611;
	bh=2VKY0kTfoAx3tfZYb+iJ1/HcDwT0KtEPCUUGZkMWgPM=;
	h=From:Date:Subject:To:Cc:From;
	b=WpLCJHHjLkzhYm5JLvvERjQ2M7OrZB3VerHSPdO00m743pTCz+dtDlP72Epoi94Wh
	 xKyEwHBr/iIGZfVZ+5qDX/whp1IjzcfQspgjHvB2bSrzbbuzE/14zbrKst6pGfsx84
	 apZz0IsiMWDdQFAGGY6UycLdxz0jFdocLDewfGkq5UV58FA+iTdqnxl+E82fzrXLDj
	 leaslulF0qB7p5ZI2enQ0tvLl6wlNAtjRyDyygoBS7Fv5L3I7558X2GjEKEp4Gn7SJ
	 1abH/Vf7rUxIEbhKnDv5XUZ/vloV4xbssJdmbdfoTxrRChuy0ChzK8ymAYflpnUyXY
	 CeG8FUQ935UoA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a3939a758dso1130516fac.1;
        Sun, 02 Feb 2025 09:16:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQtaDQuvypA8iT5AcyaDmj+rpDJkUBLwRqw10USY1TuTbq/5GGmKvTaFo12BEfidiljl2wNq0eHzbxByc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkldhN69IwvAHXMOB5xsFtywG0HN2X+oENmk7rUtI0f2jqwYzZ
	m/Mkrr7T2Q848B+fND0i6UbkOyHaPGbSMwGIIQEvBW25DLTlTClEUKvvsLL2RsLlAsTRz6XGvJp
	T/d4VOwaxUTSVMotpzWUvTDRpXBI=
X-Google-Smtp-Source: AGHT+IEHcwE5/O8dwxqnjlCLr3B/vr9quhK+mz749ArWcONVjnzDAlmYWyFqfuFciWn07oOal4zB8TGRxoigglX1Jjs=
X-Received: by 2002:a05:6871:39c9:b0:296:dd1d:ce73 with SMTP id
 586e51a60fabf-2b32ebf1bcbmr11899792fac.0.1738516610600; Sun, 02 Feb 2025
 09:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Sun, 2 Feb 2025 11:16:39 -0600
X-Gmail-Original-Message-ID: <CAJvTdKmaGD8YJj4HKuNhE8Kkr_s5VH=DhXcc75xxHtxqcdYp0Q@mail.gmail.com>
X-Gm-Features: AWEUYZmbxtU-5RFoRlSi1kbsB7m5TyfUtbGSUlBvSf2nUjYXn9mzTwgtv__smUI
Message-ID: <CAJvTdKmaGD8YJj4HKuNhE8Kkr_s5VH=DhXcc75xxHtxqcdYp0Q@mail.gmail.com>
Subject: [GIT PULL] turbostat-2025.02.02 for Linux-6.14
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull these turbostat-2025.02.02 patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 86d237734091201d2ab2c1d2e1063893621c770f:

  tools/power turbostat: 2024.11.30 (2024-11-30 16:48:56 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2025.02.02

for you to fetch changes up to 2c4627c8ced77855b106c7104ecab70837d53799:

  tools/power turbostat: version 2025.02.02 (2025-02-02 10:54:23 -0600)

----------------------------------------------------------------
Turbostat 2025.02.02 updates since 2024.11.30

Fix regression in 2023.11.07 that affinitized forked child
in one-shot mode.

Harden one-shot mode against hotplug online/offline

Enable RAPL SysWatt column by default.

Add initial PTL, CWF platform support.

Harden initial PMT code in response to early use.

Enable first built-in PMT counter: CWF c1e residency

Refuse to run on unsupported platforms without --force,
to encourage updating to a version that supports the system,
and to avoid no-so-useful measurement results.

----------------------------------------------------------------
Len Brown (7):
      tools/power turbostat: update turbostat(8)
      tools/power turbostat: add Busy% to "show idle"
      tools/power turbostat: Add an NMI column
      tools/power turbostat: version 2025.01.14
      tools/power turbostat: Fix forked child affinity regression
      tools/power turbostat: Harden one-shot mode against cpu offline
      tools/power turbostat: version 2025.02.02

Patryk Wlazlyn (11):
      tools/power turbostat: Remove SysWatt from DISABLED_BY_DEFAULT
      tools/power turbostat: Fix PMT mmaped file size rounding
      tools/power turbostat: Add fixed RAPL PSYS divisor for SPR
      tools/power turbostat: Check for non-zero value when MSR probing
      tools/power turbostat: Return default value for unmapped PMT domains
      tools/power turbostat: Extend PMT identification with a sequence number
      tools/power turbostat: Add PMT directory iterator helper
      tools/power turbostat: Allow mapping multiple PMT files with the same GUID
      tools/power turbostat: Allow adding PMT counters directly by sysfs path
      tools/power turbostat: Add tcore clock PMT type
      tools/power turbostat: Add CPU%c1e BIC for CWF

Zhang Rui (7):
      tools/power turbostat: Add initial support for PantherLake
      tools/power turbostat: Add initial support for ClearwaterForest
      tools/power turbostat: Exit on unsupported Intel models
      tools/power turbostat: Exit on unsupported Vendors
      tools/power turbostat: Improve --help output
      tools/power turbostat: Introduce --force parameter
      tools/power turbostat: Enhance turbostat self-performance visibility

 tools/power/x86/turbostat/turbostat.8 |  32 +-
 tools/power/x86/turbostat/turbostat.c | 652 ++++++++++++++++++++++++++++------
 2 files changed, 575 insertions(+), 109 deletions(-)

