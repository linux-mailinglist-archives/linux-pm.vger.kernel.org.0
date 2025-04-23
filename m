Return-Path: <linux-pm+bounces-25993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABBA97C65
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 03:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1211B61228
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9602673A5;
	Wed, 23 Apr 2025 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9zlEHHS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4087267397;
	Wed, 23 Apr 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372838; cv=none; b=QRVXjiCvA/FCYS0rWygxZodpFgJtnl067ZoNTrSc9YPCwUduwyuKXr7vWH7lAHnQi6g4PhXji1Ng4eiPcd2kf3etM6Z7D6wWKpyzYeIP++G3vPWDhfKv0Qw3Wtnnz8lTFLRkJv5EnruZB9oLFRf7dkPLUN5P0qpeY3TVQZK5APs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372838; c=relaxed/simple;
	bh=jwHq1Dgz4Xlf3NTJxaMhCnIsdmCBSmUIMBR+/cZEj8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvYqDd3yAFrGW8rFu1eb0sVR7ZFTcD7zZVxIthxp1H+iRaV4nRd4fSTZjcOqj5qPO9OBhPLol5czu4a2tLG/Q41goyuvQZ6DlJZStOn+GZUkrMUCuDhaxIR3c+aO0M+cS+puzOdz80/9mzDvPzzJp9iHbYON8l9V+QtAAmlfjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9zlEHHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265DFC4CEEE;
	Wed, 23 Apr 2025 01:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745372837;
	bh=jwHq1Dgz4Xlf3NTJxaMhCnIsdmCBSmUIMBR+/cZEj8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9zlEHHS3bTcTk4qBscHkj73WqGtH8TPxbF1tNqJ/n7tjc+Fik7Z1ssQK3eXGgNC/
	 Kv/RyNvQdggcY+67BDl4upe5wKIMrVM8PN+NFGe/A12joBbO4kVVRlTWwJTN0yJmXf
	 aA/uzbJBJdSSyC2UwhkB6iIQJ0alm+ay+aWla6Q5/UXQfQX7oqMKssd1emBvUZWh/K
	 +z7ZOXK1BQJsxbiEi8K2bLiQ8iYm+I2ptpHKWG8JCnAej+QanIEeG5daIyhXdbdYHw
	 Tu7tAkdInzWoTKs/sc2gSONNvIvRC3gtQzVWO7lw2EY35+swaEXGK2f1y7XNH1DElY
	 8PcAqvfBvHqdA==
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
Subject: [PATCH v9 10/13] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Tue, 22 Apr 2025 20:46:28 -0500
Message-ID: <20250423014631.3224338-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423014631.3224338-1-superm1@kernel.org>
References: <20250423014631.3224338-1-superm1@kernel.org>
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


