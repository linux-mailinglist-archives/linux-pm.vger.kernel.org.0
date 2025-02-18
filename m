Return-Path: <linux-pm+bounces-22333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F2A3A70F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF843A58D7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D401E8329;
	Tue, 18 Feb 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsNJs3Bw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489F1E8321;
	Tue, 18 Feb 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905751; cv=none; b=Axosrbor1ZMW2fX1DcWsO8aik+JEobU4/vWv1EHiB4ys6gaYYdTWvxfwIgk8CXbgtqbREb+1j1srnuk45aMSDjSN5Bl0S58q2G4rZaYEmokDKhZf4NEQHP0+nfiaU8j7HcwwCzzSgxgq+RH8iuDgeNvYNGSRPE3a00hI6MinjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905751; c=relaxed/simple;
	bh=UUsgChwbUHBlYwwpoY3cvOHOZcSsECzzdaCFSYHUK1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkmolRxsnFk0zeBacs4ehZ3uR78hl5SbJfxvFUA8TPvUU8eh0Cm7HecuUffvsmpvPKXPfgoapAI7E1rTwohrMbo577x5CRUKuhh6X+0/59oTjHyA4BLGxxvqBiS4hjiqtRvEVaj4TpOyJ4bO4j5W+2O2TWZaaOI1uw72czK5QF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsNJs3Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B123C4CEE4;
	Tue, 18 Feb 2025 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905751;
	bh=UUsgChwbUHBlYwwpoY3cvOHOZcSsECzzdaCFSYHUK1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QsNJs3BwNqhWKEEIqpqH3/O1j7OeTY+o60cE+ilm+2og2JbnP8ttaFBckXUBHBPD+
	 M4/x2A3SYiXQXSxnADZtkKUQVVn6YVZeIrljNMLurKlOJlN0w+HCsqc+kzxm/Bxn1E
	 MFeDzdlGSlT0PMK8Tljnhb/lee+MGurnu3QCfHEXQGz52631w9JG64H36vo/pRXD0P
	 Qgk4YM6+1r/LbZipXiYztZAdWUPLg3834nsPUBagCA5UbocnV5A8Db/hGdYxpQ8eDk
	 9NiThExB3ZF7w+Tu+U0QI4P797XRSW6vHemVGZMriDxC8T5/KNABAtkG/HPa19TJeT
	 NtvOXaRDRtk5w==
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
Subject: [PATCH v8 10/13] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Tue, 18 Feb 2025 13:08:19 -0600
Message-ID: <20250218190822.1039982-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218190822.1039982-1-superm1@kernel.org>
References: <20250218190822.1039982-1-superm1@kernel.org>
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
index 08ae480768120..f425fb7ec77d7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -806,6 +806,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
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


