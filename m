Return-Path: <linux-pm+bounces-19453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B069F6DDF
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F34188893F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC801FBEAC;
	Wed, 18 Dec 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjEjB0WR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8A1FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549131; cv=none; b=mHiTm1mtGlIxeDSG6vEYYLVbiKOWBOWV8biy9XaJEYuTvYZJekhCJQzc54bNbvmrc6TNXdNnBt86dj2LnQLfAyYsu3MUgK4LW5qMjLR3TRxzS/Xf+NaTcViQfW2raiv/U6R94S/dh3HZJPilOI4FOV6Bk/CsNU2u6o5RrxWiuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549131; c=relaxed/simple;
	bh=DrB2+b+1jQ9/2cQwpSUJx0otoaYdhEjQwLycpVXD0j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evrFcMofL/SXYleOg6jwhRFTpLg3mbhUcM9fjXuL4QPUugBKmNYIGTIYhom/1zOWXvEpeRwV0E6hFAeko78ao5ci1RlATxCT9lTwkSHHSVmk+iunEtB1t5nh1+la9amG3+oh+haDxXp0BHbcy9XQnBCy6NhQE7L17jkhyKm5kj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjEjB0WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBAAC4CEDC;
	Wed, 18 Dec 2024 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549131;
	bh=DrB2+b+1jQ9/2cQwpSUJx0otoaYdhEjQwLycpVXD0j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjEjB0WR8nTJpIk/+rSEKe1RZJmYxsxFwSg/7+TY1wD8BOj5WJHliOYJld8IcWcyJ
	 KKiAc8oRoUIv773TrQIH7kjiEQfXcwgUggQ/F96vuhJGPA3Do7iAchULKgg123pDcb
	 q12KieoYNbjK2JE/SdLr0yM3mgXMmct8C+EiRl6ckOkoLflbd/gn/iaxlSyOj5Fld6
	 ShHAyaUaSuL7KpPM/qHka9zoHwJSoWwqEtzcWzmTb9FoDq/xEoFR1wtXu5pYdv5j4j
	 R44QUNtS2jec44sNb7/MN/5p4NsqHMj7h0heoVnP35ePZknIkmb+YQUxJmF4jZA9BH
	 wr9eU2xJf7KbA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 7/7] cpupower: Adjust whitespace for amd-pstate specific prints
Date: Wed, 18 Dec 2024 13:09:56 -0600
Message-ID: <20241218191144.3440854-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218191144.3440854-1-superm1@kernel.org>
References: <20241218191144.3440854-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The amd-pstate section is grouped under boost, which isn't appropriate.

Adjust the indentation so that it is it's own section.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 090fdd6d15510..795562e879dee 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -219,7 +219,9 @@ void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
 
 void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
 {
-	printf(_("    AMD PSTATE Highest Performance: %lu. Maximum Frequency: "),
+
+	printf(_("  amd-pstate limits:\n"));
+	printf(_("    Highest Performance: %lu. Maximum Frequency: "),
 	       amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF));
 	/*
 	 * If boost isn't active, the cpuinfo_max doesn't indicate real max
@@ -228,19 +230,19 @@ void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
 	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ), no_rounding);
 	printf(".\n");
 
-	printf(_("    AMD PSTATE Nominal Performance: %lu. Nominal Frequency: "),
+	printf(_("    Nominal Performance: %lu. Nominal Frequency: "),
 	       acpi_cppc_get_data(cpu, NOMINAL_PERF));
 	print_speed(acpi_cppc_get_data(cpu, NOMINAL_FREQ) * 1000,
 		    no_rounding);
 	printf(".\n");
 
-	printf(_("    AMD PSTATE Lowest Non-linear Performance: %lu. Lowest Non-linear Frequency: "),
+	printf(_("    Lowest Non-linear Performance: %lu. Lowest Non-linear Frequency: "),
 	       acpi_cppc_get_data(cpu, LOWEST_NONLINEAR_PERF));
 	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_LOWEST_NONLINEAR_FREQ),
 		    no_rounding);
 	printf(".\n");
 
-	printf(_("    AMD PSTATE Lowest Performance: %lu. Lowest Frequency: "),
+	printf(_("    Lowest Performance: %lu. Lowest Frequency: "),
 	       acpi_cppc_get_data(cpu, LOWEST_PERF));
 	print_speed(acpi_cppc_get_data(cpu, LOWEST_FREQ) * 1000, no_rounding);
 	printf(".\n");
-- 
2.43.0


