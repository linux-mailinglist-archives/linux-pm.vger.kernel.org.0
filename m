Return-Path: <linux-pm+bounces-40256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 742ACCF6BF7
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 06:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D94A230042BF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 05:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC92EA143;
	Tue,  6 Jan 2026 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idlReLuQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E84323EA86;
	Tue,  6 Jan 2026 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767676513; cv=none; b=m9Zrku/SN3KJW86i70Nmd3GKpq8yowA3v5n27y9RuVWfmj50rJ+kDtu2JUeAl8ddc5aaBLBI55eM1j0E2gnsbDVmlCMJuzP0OsbMPVv279B2TAXv/uQmG2jDGTRFsyR8uO30fWnYQgsRGb3dcQ2ql970wNi/ClprFEHkr0g+VTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767676513; c=relaxed/simple;
	bh=P+P6QC2FPiR5KfRXs0bcxeTcfJF/D8eqoTPERvb1NO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nx+U5bgNByVoHb12oUZebu2mtFPY0FWZHxMhS1aH6fxrsDuHG/ELTp85NOxXKWC9xJlZxYd1MxPqf8Qk7zv4p3CrHYaVeFjUGW2mnRMRUqe+PNBE0Dvz3xlU/dHEy9n1DcFzylrbdaXVQ3Grisfn01ga8JKaDyzHNO1UAaxCYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idlReLuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F4C116C6;
	Tue,  6 Jan 2026 05:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767676512;
	bh=P+P6QC2FPiR5KfRXs0bcxeTcfJF/D8eqoTPERvb1NO8=;
	h=From:To:Cc:Subject:Date:From;
	b=idlReLuQDo86wLyVKCEWsbcP8keYBSt1YvlsJZVMVneoIuWfqgVxB1SYdFD0k97Gl
	 4mOLn8DOoo1ttWmQGHvpe80kt+qGdloVUSUkzteOB6LM6nUhxhGYzbMnkaxk1v7B2p
	 8k9D+w/B7hVx2IN49QfVY3twWf98tChwjJMaQqvC6bGo7RmsdFbMt26bcaWF5gBsYR
	 55cCeR7Of/i48WMrAfycKLFhgyHjgbZp0Zz7YL1LsvANDn1ityUVHk71LgQ9LryxmJ
	 yyb41Ak3YmCt0CHH5wpKB8+nfGMyK2daMW4LAENHhAFHyLLm+azDAr8wlnTxJ4ivl2
	 FUV62Cb52ZR8Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 0/5] amd-pstate Dynamic EPP and raw EPP
Date: Mon,  5 Jan 2026 23:14:36 -0600
Message-ID: <20260106051441.60093-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic EPP allows the kernel to register amd-pstate as part of
a platform profile. It will change EPP modes matching the user's
preference to the platform profile sysfs files as well as power
adapter state.

Raw EPP allows userspace to write integers to
energy_performance_preference.

v4: https://lore.kernel.org/linux-pm/20250321022858.1538173-1-superm1@kernel.org/
Mario Limonciello (5):
  cpufreq/amd-pstate: Add dynamic energy performance preference
  cpufreq/amd-pstate: add kernel command line to override dynamic epp
  cpufreq/amd-pstate: Add support for platform profile class
  cpufreq/amd-pstate: Add support for raw EPP writes
  cpufreq/amd-pstate-ut: Add a unit test for raw EPP

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  41 ++-
 drivers/cpufreq/Kconfig.x86                   |  13 +
 drivers/cpufreq/amd-pstate-ut.c               |  58 ++++
 drivers/cpufreq/amd-pstate.c                  | 283 ++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                  |  16 +-
 6 files changed, 394 insertions(+), 24 deletions(-)

-- 
2.43.0


