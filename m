Return-Path: <linux-pm+bounces-22140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ADAA36A54
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B54188AF8B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319CA1624EA;
	Sat, 15 Feb 2025 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opQx0JdA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB41624DB;
	Sat, 15 Feb 2025 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580899; cv=none; b=T5Lsty8woQKYLFoalsvbwFCMwheCFReh1VlH0txa7UFBAtxkbdvaMlxgHov08H1sDjg4uaPAph+otJqzk+qNtZKMfjViCnfUaWPPuKecNq35RGw7HZTfm2gK4hI/0uomM3hg65yyH14JFqW16vrKe/hlSSyUhav4tUFIjbh3NZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580899; c=relaxed/simple;
	bh=8D9wWoWPSG8Zd7NhVZZW45vwBqxTnjmBcb8UqFz6Mho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEhMYF1d6Ug5+I/4uTn0JL8u0lEhwrURjsBpVgnyrAZv20UnoTaKx7tLntBrtPKVM6e7DHjDv5ZwfsvT/Ofuq9TABUwyuQoxeXBDaqKVh7iJ//9FQZGM4O9v8mYzA2i73r/HxFOXSIN+LE9rF/hoKqUFyceBImuvWH1jKwGRf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opQx0JdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE4CC4CED1;
	Sat, 15 Feb 2025 00:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580898;
	bh=8D9wWoWPSG8Zd7NhVZZW45vwBqxTnjmBcb8UqFz6Mho=;
	h=From:To:Cc:Subject:Date:From;
	b=opQx0JdAFwQA08YVDCCMyPtK+V3z40bolkGZF29XgNqeTUjXDJP0PcVMiLG8hPNt2
	 0ytmimFZZzBeEBP42PIevByCe2f4p0AZM4UlJvxwsH8F+Qay6W6B/7aWRO8I0SGMPn
	 WzU15KmcpOOA9YUmXpoMKpTPCy75yOpuEI9/SsOam0G4L2gVe73uvG1yQiNUdkPVnt
	 ocfm90HQEUrLOh62ujof8PTLU6Gej085H3NNpdkWy5N2Iw04/X/X5bWPS7GQnz3e0W
	 DowQye3Ory+6rgLkK6RYW07KScyVp56zNGpWQRJpnTzE+f/CN/b8wvDmWLfkdHmosf
	 xlnDyk/Mdr+Hg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/5] amd-pstate Dynamic EPP and raw EPP
Date: Fri, 14 Feb 2025 18:54:43 -0600
Message-ID: <20250215005448.1216646-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Dynamic EPP allows the kernel to register amd-pstate as part of
a platform profile. It will change EPP modes matching the user's
preference to the platform profile sysfs files as well as power
adapter state.

Raw EPP allows userspace to write integers to
energy_performance_preference.

This series is based off superm1/linux.git bleeding-edge branch
+
https://lore.kernel.org/linux-pm/20250215005244.1212285-1-superm1@kernel.org/T/#t

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
 drivers/cpufreq/amd-pstate.c                  | 291 ++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                  |  16 +-
 6 files changed, 390 insertions(+), 36 deletions(-)

-- 
2.43.0


