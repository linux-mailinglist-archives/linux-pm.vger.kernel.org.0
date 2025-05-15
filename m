Return-Path: <linux-pm+bounces-27217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC213AB91B1
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0C93BF342
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E729C345;
	Thu, 15 May 2025 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVFb4tf+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D229C339;
	Thu, 15 May 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344019; cv=none; b=VfV+qhA84RXmu0PmxWD932vSxbz51r4/uLFIDIPhFQI1Bph1B0YbB+eYKC5UGbYNgkwJ5B707r1rgWP4u/3vbawC2nPThvemQ1p0SgFcxlrRyX4SGjvczCpDTqgQkK5w/wkaTfiOtjMdiJl9eo+nyW8nz8m/3VgWwJPEOp36bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344019; c=relaxed/simple;
	bh=jwHq1Dgz4Xlf3NTJxaMhCnIsdmCBSmUIMBR+/cZEj8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB+D4yzXiBbkl4WarKcOh7+NDQdNBryUapQaOe3jtskjSVyruzC+lOWw0TyVcnX8caokr2ZnXg3gqArgWFDy2rdzO2ax7+Jp21W0xSUhFZIn11RNo10pp3Eu1ygZ+4NDGO0Lt1hS5cy1xgEslaqLgYhLWanDd5nbf/mopCBet0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVFb4tf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BC6C4CEF1;
	Thu, 15 May 2025 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344018;
	bh=jwHq1Dgz4Xlf3NTJxaMhCnIsdmCBSmUIMBR+/cZEj8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVFb4tf+h3F0gnbuUp/oWHIV5JfiFqkb4Vkyi7JuU6mWrgo9qFl+t+1HEjdxbhIxh
	 HEB832jQkY/lYyTlerK2fiM0b2IzTNHm7CnizGZlyDkqhpl5hckzkn+/P7BqjahTNg
	 x/h6fPZ4gayc9D1BnynN63yT65nLHcyUddoVq+AKyN4322k+Q4S9VyZzLTfdZZHBmQ
	 16HzvetqEpVD/BzvnmzgaGBrOKiEIdD57l9fcEi8dtZlWq6VicbkYy76sgJDOYFF/U
	 5xmRMTzMJP4CPSkE1xTimgl12I+WpOKadAzDqt83D3tui3wdB7mSsHWq/3H8z1qc6X
	 9XnoZDhWZ4bGg==
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
Subject: [PATCH v10 10/13] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Thu, 15 May 2025 16:19:47 -0500
Message-ID: <20250515211950.3102922-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515211950.3102922-1-superm1@kernel.org>
References: <20250515211950.3102922-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66fdc74f13ef4..bdaf2034aaa10 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -801,6 +801,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
 		return;
+	/* should use amd-hfi instead */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI)) {
+		amd_pstate_prefcore = false;
+		return;
+	}
 
 	cpudata->hw_prefcore = true;
 
-- 
2.43.0


