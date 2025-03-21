Return-Path: <linux-pm+bounces-24355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DEDA6B2ED
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 03:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC6C886139
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC08E1E2007;
	Fri, 21 Mar 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjeCpGqP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219B7E107;
	Fri, 21 Mar 2025 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524157; cv=none; b=GVN33TARIkZnel6EnQ23f6Ln1btUc/WkPFKYpIQYEIFIAiILcKEIYZIJUJZxoWmi+NuoDWLpZAkJ23Pacwnv7Xj53qQlWnm8/2cv6Y6K2B3rJd24I5TLnByvYEYc/tT6a7z0YkYZos9CHCO+MSXeyegBGgUGcjSQPwdya/ZVrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524157; c=relaxed/simple;
	bh=tQc+USlZhgRmpcXtwh+kxFncbgP11Mjjra2EsV6vj8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cmb+zeD0eKFuu3Ii4uVI9U+e0EzTPOGzECBdODww+lgiu5LfQ5B3B65lYpstjLqMxLPojbKnFU8YtDwZd0rL379OFHNZVDmYrMUSv1gLb946jLXOFZM9gaw+TDEiUkKPU9e4sug+CwvNsvsv5Wd23NIQu4JJKxLuUVFcHirFxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjeCpGqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230E2C4CEDD;
	Fri, 21 Mar 2025 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742524155;
	bh=tQc+USlZhgRmpcXtwh+kxFncbgP11Mjjra2EsV6vj8o=;
	h=From:To:Cc:Subject:Date:From;
	b=XjeCpGqPxiMxEnePvZ0BFDA6YOByL0CydwpCP7mhvI4FGnhdJICynEfoAM03hKhP+
	 LPDIN0FadpR7zbM0dJAW4GRnqlW+WHREanOG/WunUjaqEpovuSI1QL9AGfxieX7eLL
	 jfdoorQ1XMXRCtsHapLq5NogjQzVP/amPEES+1JbkMtjZIykPJLNQrWvKAp0eSQwAd
	 FKgP+aRY+DlnR5mQYnyDzCCGH5QaFowl6aolKOe/tubdrEOiCj5/9f3mvDygp94gac
	 jHbViJqTuQ8NPm+uDL6i0ob3fnTxoN+atoo3+qKXgGxldbZnXD/wxYDy6MGEfgNZ9v
	 xBvM03JmTAmqw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 0/5] amd-pstate Dynamic EPP and raw EPP
Date: Thu, 20 Mar 2025 21:28:53 -0500
Message-ID: <20250321022858.1538173-1-superm1@kernel.org>
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
 drivers/cpufreq/amd-pstate.c                  | 285 ++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                  |  16 +-
 6 files changed, 396 insertions(+), 24 deletions(-)

-- 
2.43.0


