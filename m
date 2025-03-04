Return-Path: <linux-pm+bounces-23403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9587EA4E514
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A38887D86
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BE281351;
	Tue,  4 Mar 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhFUfnHg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082724C082;
	Tue,  4 Mar 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101814; cv=none; b=Y42g20Vqj30Zf0d5NhglD3zUmrZFFzNr+5KSm9j3KY9J2G5YcUvhCBZpu79BD9HwEppB+byfL2kmSfeQCKgsJF6dNH5B3CxjG66dwVdJWFKqN1+9QSpH18XNLWt/d+kKp11ei5fz7ojigmVhRWr9OwBe41NUDNHHsaNoc5GAdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101814; c=relaxed/simple;
	bh=n+ykfua8ybreYUwCduFeiirpEQHr6IwqrBaEPGWv59s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVribXTHYpnTTToMsdEheKMv0FsSbXwOWchD6IjAIxumUxMCO6CfPtFDRGNI1+Xm+9typdF+7PeVec6zmvLjTDbra7Eukz/VooS3EoVqgL2hkyL/pf2mRAuSxP1L3P7vOg17pGxoBK2xkkkJzlvcdbdMNAUZcOuVX9sL5skphOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhFUfnHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A566C4CEE5;
	Tue,  4 Mar 2025 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101814;
	bh=n+ykfua8ybreYUwCduFeiirpEQHr6IwqrBaEPGWv59s=;
	h=From:To:Cc:Subject:Date:From;
	b=lhFUfnHgqGC1PIyucoNmsb6Aa7h/Z/sqKnEF7D3iOXKu2XzDfonK0U/hwEVSNTijE
	 PLDMS0gyik3jNh+5rMqi0CCGUv+M27JSA8HVbkV0FoLoiF8sj/0dYW8FdSfj+jq+qh
	 xSGmbvPKKJ6kkpkIrECDN/XIgxNcEXCC7gFGbvoYtWC9Yd47k1vh/vMNPewyisfzSg
	 6ppy/4MEhfdifCnyPC+WqCIkdHSnSh8AJwiCmMhCdQvwxnBQSveNF/073oBe2kznbk
	 5ix3vDg6YuFPGsgybKvdb6t4Bv/Utja6g8DFQmu6laNfsbAqJpW52Zee7pKIq9HbCQ
	 rH2O37m58FSig==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/5] amd-pstate Dynamic EPP and raw EPP
Date: Tue,  4 Mar 2025 09:23:22 -0600
Message-ID: <20250304152327.1561017-1-superm1@kernel.org>
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

v1->v2:
 * Rebase
 * Change some defaults

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
 drivers/cpufreq/amd-pstate.c                  | 279 ++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                  |  16 +-
 6 files changed, 390 insertions(+), 24 deletions(-)

-- 
2.43.0


