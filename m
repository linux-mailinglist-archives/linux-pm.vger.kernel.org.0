Return-Path: <linux-pm+bounces-19449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A59F6DDB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C2D16A0A6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E901FC0EB;
	Wed, 18 Dec 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXck5TcL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFCE1FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549127; cv=none; b=Ue/CKbQhhU4+eWxaP3Mj9pFPzZK7OXYx8b1HNzN+qjS0/exo14iaF+Mces2vFYfF1hlNGEaOT2tn3za0sY03gjyL680h9E/j5kcfSsnkk5gTT1FX0iOpa/Qf/IptKiIONoYJqroULACcXzf7OcuDOPu9Qu5nARqYtKY0i2/AXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549127; c=relaxed/simple;
	bh=CuUZg4845wczGJgTn9sPWKeN9Z7IQqRUSZ9Dsp6GVx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkhMjwMKcT8fosm5zwQSbGzvPdb2XfEPgkKIwJFL7u+wC6nwBM5gbEp5Xw/Tm9V1ap9OJVTAC0bjegIL66NnrHbNiulwskGPpjXqzOWLv2vdlqLjH7aVK7UGlejFna19GjYctOiS0l4gl21aDpLLuV2qlv0RkMB+RhvkkTLpITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXck5TcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91496C4CEDC;
	Wed, 18 Dec 2024 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549127;
	bh=CuUZg4845wczGJgTn9sPWKeN9Z7IQqRUSZ9Dsp6GVx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXck5TcLNHy1GTjdO9CU4UNfnC+dvvII5mJRWHFysjTA+aLMLaEGDJjZgYQHRO5Ce
	 XKsqU5xm1yrjsjbz7AwNSz+dAiPNS2Q6lko8gNffbX4iYkPjvFGQx/XRCqduUtx/gs
	 OdEq0HdYFsDjZTnypG1RAk/QLdXNy2Pfuo+N9UH5Q5DrhOoWLZuQrdFOsKUIoIq09n
	 Ey3T8S52gZtQ3GqfKpmD3Fj3r9XangkIqGuJ+ksFQCOruBXFvMe8kTG1BWzrIWt3gZ
	 ucEfKs0rZIzSEvD/memQLVBCrsTQjUeItbwi3JMDFaMvk/q/8MhMSZbfNTykdM0XZN
	 H6ZnA/jch3t6g==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 3/7] cpupower: Add support for amd-pstate preferred core rankings
Date: Wed, 18 Dec 2024 13:09:52 -0600
Message-ID: <20241218191144.3440854-4-superm1@kernel.org>
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

The rankings are useful information to determine if the scheduler
is placing tasks appropriately for the hardware.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 0a56e22240fc8..090fdd6d15510 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -177,6 +177,8 @@ enum amd_pstate_value {
 	AMD_PSTATE_HIGHEST_PERF,
 	AMD_PSTATE_MAX_FREQ,
 	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	AMD_PSTATE_HW_PREFCORE,
+	AMD_PSTATE_PREFCORE_RANKING,
 	MAX_AMD_PSTATE_VALUE_READ_FILES,
 };
 
@@ -184,6 +186,8 @@ static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
 	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
 	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
 	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
+	[AMD_PSTATE_HW_PREFCORE] = "amd_pstate_hw_prefcore",
+	[AMD_PSTATE_PREFCORE_RANKING] = "amd_pstate_prefcore_ranking",
 };
 
 static unsigned long amd_pstate_get_data(unsigned int cpu,
@@ -240,6 +244,10 @@ void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
 	       acpi_cppc_get_data(cpu, LOWEST_PERF));
 	print_speed(acpi_cppc_get_data(cpu, LOWEST_FREQ) * 1000, no_rounding);
 	printf(".\n");
+
+	printf(_("    Preferred Core Support: %lu. Preferred Core Ranking: %lu.\n"),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_HW_PREFCORE),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_PREFCORE_RANKING));
 }
 
 /* AMD P-State Helper Functions ************************************/
-- 
2.43.0


