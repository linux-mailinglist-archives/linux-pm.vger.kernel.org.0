Return-Path: <linux-pm+bounces-27207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DAAB9184
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3FA4E5C60
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F277A28850D;
	Thu, 15 May 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl0odddf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091A2882D7;
	Thu, 15 May 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343998; cv=none; b=dPcG7ITFGDxG46+HfCJktKg3yTnxiXhUPZE/xe8Eyqd50gnGox0DxVDaCZ+V32xDYUDXqfoZ2n0ZF1p+bLnKtW/IOkwPilejupmJHG3Cl5SVGkIV6MlNopywsEJ79MJxVR2aa+CpT1FGjsCPUqc3BzNB6Ilwi8uQiiJsdRwcOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343998; c=relaxed/simple;
	bh=fHVC1J1XphBXTDfiK/wyvSeNKYjXfXohLeLwr7PRBI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvjzM/6HpVnkCzIsd0GljKuNJ+vI0/9dVALxD7YsFZ3JE8hm6yXPRn1HHjDsupaHMVb7xwkPAopsAiN0H9Mh10u3C+d6x7Lc28GcZH9yzKH5gdyPXsvq8Geepx9OG7xwMuotQ0EX6jAI22ZpaBqpM6PmB7E+O4zply+ip7ABcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl0odddf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5444C4CEE7;
	Thu, 15 May 2025 21:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747343998;
	bh=fHVC1J1XphBXTDfiK/wyvSeNKYjXfXohLeLwr7PRBI0=;
	h=From:To:Cc:Subject:Date:From;
	b=Jl0odddf4S9BcnMvEGD0jYot9ToZJL2PvRdNxqn6pXJOON5RZu8O1jKx8FyhFy/ov
	 +5/YmcYTT4euR3p9sKIc274NlT4D/gHbR+Qu25LvdVLE/ZiGtZ3AcZezKDMIPs30xU
	 Fq99NpL2cxYWEDl+Lecw6vaYLGCYr0VOqRJFbyUiWjBP7dNCdnbwEiWmyrW1hN3YVw
	 QFkvFQzizFkjADwZnI6UMDpGr6kmNCZPBvKbc/ao0ia5dJoORS81X1m5HVSzrg3Zn8
	 vTzAD2YfML+VlrNH0ify2hFwmwMoGtSW4+eeBWq8lupnBgm0IIzDzYrmTR2x5CQStC
	 /DZhEP49hfMrg==
From: Mario Limonciello <superm1@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	platform-driver-x86@vger.kernel.org (open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-pm@vger.kernel.org (open list:AMD PSTATE DRIVER)
Subject: [PATCH v10 00/13] Add support for AMD hardware feedback interface
Date: Thu, 15 May 2025 16:19:37 -0500
Message-ID: <20250515211950.3102922-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification of tasks.

Threads are classified during runtime into enumerated classes.
Currently, the driver supports 3 classes (0 through 2). These classes
represent thread performance/power characteristics that may benefit from
special scheduling behaviors. The real-time thread classification is
consumed by the operating system and is intended to be used to inform the scheduler
of where the thread should be placed for optimal performance or energy efficiency.

The thread classification can be used to helps to select CPU from a ranking table
that describes an efficiency and performance ranking for each classification from
two dimensions. This is not currently done in this series, but is intended for future
follow ups after the plumbing is laid down.

The ranking data provided by the ranking table are numbers ranging from 0 to 255,
where a higher performance value indicates higher performance capability and a higher
efficiency value indicates greater efficiency. All the CPU cores are ranked into
different class IDs. Within each class ranking, the cores may have different ranking
values. Therefore, picking from each classification ID will later allow the scheduler
to select the best core while threads are classified into the specified workload class.

This series was originally submitted by Perry Yuan [1] but he is now doing a different
role and he asked me to take over.

Link: https://lore.kernel.org/all/cover.1724748733.git.perry.yuan@amd.com/

v9->v10:
 * Rebase on tip/master
 * Clarify in cover letter that this series lays plumbing; scheduler changes are not
   part of first layer of plumbing.

Mario Limonciello (5):
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  cpufreq/amd-pstate: Disable preferred cores on designs with workload
    classification
  platform/x86/amd: hfi: Set ITMT priority from ranking data
  platform/x86/amd: hfi: Add debugfs support
  x86/itmt: Add debugfs file to show core priorities

Perry Yuan (8):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86: hfi: parse CPU core ranking data from shared memory
  platform/x86: hfi: init per-cpu scores for each class
  platform/x86: hfi: add online and offline callback support
  platform/x86: hfi: add power management callback
  x86/process: Clear hardware feedback history for AMD processors

 Documentation/arch/x86/amd-hfi.rst    | 133 +++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/itmt.c                |  23 ++
 arch/x86/kernel/process_64.c          |   4 +
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  18 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 550 ++++++++++++++++++++++++++
 12 files changed, 758 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c


base-commit: 9cb2eed7986ef6fb197b75bc7e559d300dd9f04a
-- 
2.43.0


