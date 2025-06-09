Return-Path: <linux-pm+bounces-28327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E48AD274E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A1216E3C8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9742225A2C;
	Mon,  9 Jun 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjV2qzMR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E222579B;
	Mon,  9 Jun 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499546; cv=none; b=f64ipbEFbo61Eac5BSXOSvl82SWmIXU2YZULp24pwmkE2It6uCNIVBNePROpSLgRifyyTehu+y+Y/JQxhBUxno4IdNS5euGe/TI7W4FeLrQ3impk2cFonrSgAROjcD9Wq/bzK/2IYuv/UttIBmu1EWpKN2oDpvOnWd77Qhucdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499546; c=relaxed/simple;
	bh=4bssHTqSWbzsmJNwqd3WJzHulDgwe+FA6qh8+k0oGo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0253sauPvWK/ItwUjlxoTYJ2uUnRMjkFHrEmzqTLdYc+czUmwtPuly7MwAZsaaktU4+xZ43XOybBYhpSelI6s7r8hp2miJU8k5nWWItVgDsCNVd6daB/U6UV4VjV8DPvYqGywnWuuLaD+qEnvotxxlAenVBiDbb/sZmaPcURMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjV2qzMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4A4C4CEF2;
	Mon,  9 Jun 2025 20:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499546;
	bh=4bssHTqSWbzsmJNwqd3WJzHulDgwe+FA6qh8+k0oGo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjV2qzMRxYPtazheh66pTCb+v2t/POJnFw8TOndgrLP41qptXchDZNGsVr3BCpl90
	 Hm7ovUSbyGNO6Z6TavPmkG1WZHSFKgWVJZs8egiClUHITkUnGH9sNYXsSSrmc6j5Po
	 VKY2aWQu8Cwk5yOgR6z6xxgUVIvqbaJLmdrlXbwGfrx0jIOiIi13WywTH1BvK50Eji
	 KQWmGKg7FDh6OZLSkY3c8t3BKncAdZruHUmgOkE6USOQ18eHoDKMEPKMFqfz5ykpZS
	 qgdzfy9cm9pjdlZ11SVKUMKteTPwiAgynldi2Q8dJvuilmDv9gU0MQg2DI2AGyalg9
	 bOvC98yeoJRwA==
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
Subject: [PATCH v11 10/13] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Mon,  9 Jun 2025 15:05:15 -0500
Message-ID: <20250609200518.3616080-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609200518.3616080-1-superm1@kernel.org>
References: <20250609200518.3616080-1-superm1@kernel.org>
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
index 6ba0e4478877e..f48b65980ed18 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -834,6 +834,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
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


