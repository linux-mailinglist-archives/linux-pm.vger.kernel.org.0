Return-Path: <linux-pm+bounces-19904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C79FFAAF
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 16:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AA63A15FC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604B71B2522;
	Thu,  2 Jan 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/axxqCk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB018B492;
	Thu,  2 Jan 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830128; cv=none; b=m6cRcdpbBwXr6HjqFaB/LIXBOQxuufodTWvNpIOLFYWKocafoQsHjq7fEiG8CtDbeaViJt3AMqHg1RnpaB88sygOMR7FkJ7zf4IlIe8nmyCkV29xCFIYvFwGLkSx9zrc5FHriyQifMbnwgZT6jjDs+CviIZdARDV6JEElTmDfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830128; c=relaxed/simple;
	bh=xt43zsb1kTVdravRw2KfgwLpvDUZRbJHOcpla+U0hMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhGLqyoQdPRA13ik3dLmsRtZc9mvmkynjVbQQvhwT6S2I3WXs2/9Yz385M5HLmG/XkeSFsbQE29rh/gx72yzqkbH0mx7DSHYybT00dVKq5h8fxCvdkNj562v5RjX+0bdaPJ9NnV/1iQ+f/SKuQqSj2mPcrJg5Mpo+qKg/I2fJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/axxqCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D06C4CED0;
	Thu,  2 Jan 2025 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735830127;
	bh=xt43zsb1kTVdravRw2KfgwLpvDUZRbJHOcpla+U0hMk=;
	h=From:To:Cc:Subject:Date:From;
	b=M/axxqCkw65Se1gZliet/2m2SLhyFFGbL9e6lEBzKa+O/IO0YwnY6U5ouPukwTwV6
	 gwkvVVCFD++cm/CCD3W7hi8EuLrX2X3sdxKDwhfzZijhp9iR/ps1r8VtygjwTT/MEN
	 71wXhmCA2SkWDg1ZkFeW/iCIt7tF6dwa9nYn0KtynIRzskjGuP1xzRt7IPHGy8ZwdB
	 7mWsHswDmU+khLNY+coE4Cxc4uH0c3NLa5Er+C9fGo5nEdQ5+fuIvWVPnPL1O8sqeA
	 ujZ0z8K1iJNcHlgYac3Snyecfd/n6VLPyi9sQW7mejb5ouOqf2tco9P5XmJylz6xdN
	 Z88qMYgaSXrmg==
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
Subject: [PATCH 0/6 v3] cpuidle: Handle TIF_NR_POLLING on behalf of polling idle states
Date: Thu,  2 Jan 2025 16:01:54 +0100
Message-ID: <20250102150201.21639-1-frederic@kernel.org>
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

Changes since v2:

_ Handle buggy mwait implementations (thanks Rafael)

Frederic Weisbecker (4):
  cpuidle: Remove unnecessary current_clr_polling_and_test() from
    haltpoll
  x86/cpuidle: Move buggy mwait implementations away from
    CPUIDLE_FLAG_MWAIT
  cpuidle: Remove call_cpuidle_s2idle()
  cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle
    states

Peter Zijlstra (2):
  cpuidle: Introduce CPUIDLE_FLAG_MWAIT
  cpuidle: Handle TIF_NR_POLLING on behalf of CPUIDLE_FLAG_MWAIT states

 arch/arm/include/asm/cpuidle.h     |  2 ++
 arch/arm64/include/asm/cpuidle.h   |  3 ++
 arch/powerpc/include/asm/cpuidle.h |  4 +++
 arch/riscv/include/asm/cpuidle.h   |  2 ++
 arch/x86/include/asm/cpuidle.h     | 12 +++++++
 arch/x86/include/asm/mwait.h       | 27 +++++++--------
 drivers/acpi/processor_idle.c      |  5 +++
 drivers/cpuidle/cpuidle-haltpoll.c |  3 --
 drivers/cpuidle/cpuidle-powernv.c  | 10 ------
 drivers/cpuidle/cpuidle-pseries.c  | 11 -------
 drivers/cpuidle/cpuidle.c          | 22 ++++++++++++-
 drivers/cpuidle/poll_state.c       | 30 +++++++----------
 drivers/idle/intel_idle.c          |  8 +++++
 include/asm-generic/Kbuild         |  1 +
 include/asm-generic/cpuidle.h      | 10 ++++++
 include/linux/cpuidle.h            |  1 +
 include/linux/sched/idle.h         |  7 +++-
 kernel/sched/idle.c                | 53 +++++++++---------------------
 18 files changed, 114 insertions(+), 97 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuidle.h
 create mode 100644 include/asm-generic/cpuidle.h

-- 
2.46.0


