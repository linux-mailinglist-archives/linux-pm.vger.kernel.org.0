Return-Path: <linux-pm+bounces-22323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6BA3A6E5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DE91668C6
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69121EB5FC;
	Tue, 18 Feb 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpxBBL9g"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E421EB5EF;
	Tue, 18 Feb 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905730; cv=none; b=qgvidEVNWIoD8+P5im+C31fySwoF+tZuEzZw2hyWSOkSKZM2BbJK6faLy1EZKwQR+FpuOLmrxaCQqVmOfmQbD7vKeUdQIEq72Dmc9Xmo/CXD/eet5zGf8lSW5VyWnGD5vULDGrxpiT12VhsctohoKwcEnRszaeSdnfkcOEjyBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905730; c=relaxed/simple;
	bh=K3sJ5nwbX7JLTwQvKdPj0CaC9qj7MLTP0Lm01nfHmGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cEVOmF+Cvl1fjai6vTH/803XK3DK0d3APNdLXLTplxvAli9VluQR0IzS5QeKI+/BmJlsWXP/v+xkR920fXH5i0I1CmQltkfKVkOdf+s07Qg+GddbS8LSVI21y2oP5uQreoOBHB0CrIHqRrtL60P0HgiefXbh6RC8/vL2+NstWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpxBBL9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28818C4CEE2;
	Tue, 18 Feb 2025 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905730;
	bh=K3sJ5nwbX7JLTwQvKdPj0CaC9qj7MLTP0Lm01nfHmGY=;
	h=From:To:Cc:Subject:Date:From;
	b=kpxBBL9gmLdj94qp0jUz2wl98Gr+uaX2RCTYfx/+fSiCHMG1r4l0SUcGL4hNkR6P2
	 V+u2Ju8HIFkai23Zm1Rt7KSmOrqMN8eHYXjhz0Cucj0Lx4Mu3AYncQ5g2bJs3c5vKD
	 7vsI81VLqfVbs/UulbEa8NIHd334f7ivLITImIzyPRHyNbCxKA3spBD5uEKOXZyp1/
	 gdcx3CMMoKQ+2ZtEVuDFGSqUlPEe76JUVe0V275Zho/c/v4o5bjFIS+19tPInQ0LtC
	 WqFkU78xdvN9hoJOWiSkerWgJqke6h8a9LCjct8RoeDSBsdQx73siTJGIcwDgjmJdL
	 YVX4qHbCAAa3g==
From: Mario Limonciello <superm1@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
Subject: [PATCH v8 00/13] Add support for AMD hardware feedback interface
Date: Tue, 18 Feb 2025 13:08:09 -0600
Message-ID: <20250218190822.1039982-1-superm1@kernel.org>
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
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

Threads are classified during runtime into enumerated classes.
Currently, the driver supports 3 classes (0 through 2). These classes
represent thread performance/power characteristics that may benefit from
special scheduling behaviors. The real-time thread classification is
consumed by the operating system and is used to inform the scheduler of
where the thread should be placed for optimal performance or energy efficiency.

The thread classification helps to select CPU from a ranking table that describes
an efficiency and performance ranking for each classification from two dimensions.

The ranking data provided by the ranking table are numbers ranging from 0 to 255,
where a higher performance value indicates higher performance capability and a higher
efficiency value indicates greater efficiency. All the CPU cores are ranked into
different class IDs. Within each class ranking, the cores may have different ranking
values. Therefore, picking from each classification ID will later allow the scheduler
to select the best core while threads are classified into the specified workload class.

This series was originally submitted by Perry Yuan [1] but he is now doing a different
role and he asked me to take over.

Link: https://lore.kernel.org/all/cover.1724748733.git.perry.yuan@amd.com/

On applicable hardware this series has between a 2% and 5% improvement across various
benchmarks.

There is however a cost associated with clearing history on the process context switch.
On average it increases the delay by 119ns, and also has a wider range in delays
(the standard deviation is 25% greater).

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

 Documentation/arch/x86/amd-hfi.rst    | 127 ++++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/itmt.c                |  23 ++
 arch/x86/kernel/process_64.c          |   4 +
 drivers/cpufreq/amd-pstate.c          |   6 +
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 550 ++++++++++++++++++++++++++
 12 files changed, 755 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.43.0


