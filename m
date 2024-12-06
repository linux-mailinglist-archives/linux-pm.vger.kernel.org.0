Return-Path: <linux-pm+bounces-18690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC09E6EE0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A87188345E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154D20764E;
	Fri,  6 Dec 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/sMu5kR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE5207648;
	Fri,  6 Dec 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490258; cv=none; b=czJMPdjAVJ2rzvDao/YSYZ1QS/nm7QHmhDv/MkaHsEpgaRk9M2FfN1zAEi58Q2YIXcbBc5keKOwjOxJpmz6CxwOrn9URpVRS0f0pTvuAbk0GOwJDSm2RaY6shVORck3yKa7+iyTwcJ+a7XJUBz0mLQ810rO32P6xQaLAE6lt0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490258; c=relaxed/simple;
	bh=/GSz7Q2GAWskqDzrTTZh5sVablEwCQ1+AfgGzAj34cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THYb30nLeDIMYewQa5xQjCtEpnc5gPCMrL7MA+ZpTH5edUW0/8uz7O632WXWgbEfx3IDwkMXBT3TJXfGoHWAIvVl8VQA3ZcDyGki60AENdw9arDKs2La/FTNSokDNKai57o0HGR/zFFjFbKUjn9nTKBzeuVMH9kZTq5riNRpCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/sMu5kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B92C4CED1;
	Fri,  6 Dec 2024 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490257;
	bh=/GSz7Q2GAWskqDzrTTZh5sVablEwCQ1+AfgGzAj34cE=;
	h=From:To:Cc:Subject:Date:From;
	b=Y/sMu5kRcdPnW8wLLp1Bro1w4NCkCH9bxD8SLR/IGw1BCjhrlMIZhAQkdfFNp+dS5
	 aKQlgNmePP/GvPNShojyaCAEN1l5OrS4+Wu0S0zBmAbiCLHuYqb6toPcWOZoy67kMy
	 +8oB+sDqRa4L0FACPWR+YSB2u68i5YYtQh3c64vnEHe1DPPmDkEtOjM3A7W7X8qDkC
	 eJTgY1JltEwy3XgNu7VKBnUVEVbroG903Kr2rDedhu3uet2aNs58MS1j9+eWhXIo3+
	 ijtOl2dyU3EWqpaBDVoy2wkqxuU81/aD2BUV1hIiqGjHZgmXn4oZQ4VS8NcF94sp5L
	 uo4E3u39QWbxA==
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
Subject: [PATCH 0/5] cpuidle: Handle TIF_NR_POLLING on behalf of polling idle states v2
Date: Fri,  6 Dec 2024 14:04:03 +0100
Message-ID: <20241206130408.18690-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TIF_NR_POLLING handling against TIF_NEED_RESCHED polling/monitoring
idle states (mwait and also software polling) is a bit messy, with quite
some wasted cycles spent on useless atomic operations. This tries to
consolidate this state handling from the cpuidle core.

Changes since v1:

* Drop two x86 applied patches
* s/CPUIDLE_FLAG_POLLING_HARD/CPUIDLE_FLAG_MWAIT (Rafael)
* Fix confusion between polling and monitoring on comments (Rafael)
* Remove call_cpuidle_s2idle() (Rafael)

Frederic Weisbecker (3):
  cpuidle: Remove unnecessary current_clr_polling_and_test() from
    haltpoll
  cpuidle: Remove call_cpuidle_s2idle()
  cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle
    states

Peter Zijlstra (2):
  cpuidle: Introduce CPUIDLE_FLAG_MWAIT
  cpuidle: Handle TIF_NR_POLLING on behalf of CPUIDLE_FLAG_MWAIT states

 arch/x86/include/asm/mwait.h       |  3 +-
 drivers/acpi/processor_idle.c      |  3 ++
 drivers/cpuidle/cpuidle-haltpoll.c |  3 --
 drivers/cpuidle/cpuidle-powernv.c  | 10 ------
 drivers/cpuidle/cpuidle-pseries.c  | 11 -------
 drivers/cpuidle/cpuidle.c          | 22 ++++++++++++-
 drivers/cpuidle/poll_state.c       | 30 +++++++----------
 drivers/idle/intel_idle.c          |  5 ++-
 include/linux/cpuidle.h            |  1 +
 include/linux/sched/idle.h         |  7 +++-
 kernel/sched/idle.c                | 53 +++++++++---------------------
 11 files changed, 63 insertions(+), 85 deletions(-)

-- 
2.46.0


