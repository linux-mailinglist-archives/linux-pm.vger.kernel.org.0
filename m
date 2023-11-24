Return-Path: <linux-pm+bounces-198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E087F8629
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 23:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E24A28255B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 22:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678322069;
	Fri, 24 Nov 2023 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhXhw1f/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE413D3A0
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 22:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D35C433C8;
	Fri, 24 Nov 2023 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700865161;
	bh=11MQ+yZzITnqG5iCSLzAR411rSB6tjFg5VyDfzbjJAM=;
	h=From:To:Cc:Subject:Date:From;
	b=XhXhw1f/S1WGDrAxGBXKoFRjkAl3m8ee/Z6PP7+fkqRZHpPw0P1gqNELFuM1dbqSs
	 6fa6akfIxfcqRgbU/Pmj46etXPL+xKU6Z6ucguTJEScf7sh48+bXECbUClAwaFCliP
	 DSFJvBkAlhezpVWCqnSflQWwxjUHTpadGKfM51138/a38+otC8lpu+3wwmKXL9TbET
	 EZcKh68iwwoLw5hpvFBt/LgC4G2GcYm0EGbds/YTx6R/VC1NJfFUzrz8dKuv9weQbF
	 k1yztCZeocTb5l7lFX3QCMRsUJFMbojpa+ROwgIn3OBomvPF2oL6ZcMpJD6VZE/g5s
	 lLzN914NGjREQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/7] cpuidle: Handle TIF_NR_POLLING on behalf of polling idle states
Date: Fri, 24 Nov 2023 23:32:19 +0100
Message-ID: <20231124223226.24249-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TIF_NR_POLLING handling against polling idle states (mwait and also
software polling) is a bit messy, with quite some wasted cycles spent
on useless atomic operations. This is a try to consolidate this state
handling from the cpuidle core.

Frederic Weisbecker (4):
  x86: Add a comment about the "magic" behind shadow sti before mwait
  cpuidle: Remove unnecessary current_clr_polling_and_test() from
    haltpoll
  cpuidle: s/CPUIDLE_FLAG_POLLING/CPUIDLE_FLAG_POLLING_SOFT
  cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle
    states

Peter Zijlstra (3):
  x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
  cpuidle: Introduce CPUIDLE_FLAG_POLLING_HARD
  cpuidle: Handle TIF_NR_POLLING on behalf of CPUIDLE_FLAG_POLLING_HARD
    states

 Documentation/driver-api/pm/cpuidle.rst |  2 +-
 arch/x86/include/asm/mwait.h            | 23 +++++++++++---
 drivers/acpi/processor_idle.c           |  3 ++
 drivers/cpuidle/cpuidle-haltpoll.c      |  5 +---
 drivers/cpuidle/cpuidle-powernv.c       | 12 +-------
 drivers/cpuidle/cpuidle-pseries.c       | 15 ++--------
 drivers/cpuidle/cpuidle.c               | 22 +++++++++++++-
 drivers/cpuidle/governors/ladder.c      |  4 +--
 drivers/cpuidle/governors/menu.c        |  8 ++---
 drivers/cpuidle/governors/teo.c         |  8 ++---
 drivers/cpuidle/poll_state.c            | 32 ++++++++------------
 drivers/idle/intel_idle.c               | 24 +++++++--------
 include/linux/cpuidle.h                 |  3 +-
 include/linux/sched/idle.h              |  7 ++++-
 kernel/sched/idle.c                     | 40 +++++++++----------------
 15 files changed, 104 insertions(+), 104 deletions(-)

-- 
2.42.1


