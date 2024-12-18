Return-Path: <linux-pm+bounces-19450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37769F6DDC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0D6188874A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE51FC0F1;
	Wed, 18 Dec 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAmhhtVM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D41FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549128; cv=none; b=p31GIQ7GW5fYhLBOHw5tQgf1antCSvFcU9Wdf+mTYPJ+iQpaj6husZPXFD3sd0ZO/26BP9qk2xWqLU2R2NkfH3yUiFCaa8JwKa2c9eXoeVqX+XGajvyVTOF4yQLzSQCFnJUgJJ04m/Ed608qppP+K9kM6cBp99pQdv8X5fKVEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549128; c=relaxed/simple;
	bh=4oO1EcVm33bIsq/HWyN5rzW7cr4ThZfhyYM7ahaK10M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb4K0PKfqnEJUwiimiI6CtSwPnI3VGZ+M7pPQUuX9G9PZP8c58EmADqN9ZZMKW3FKSEEznPM0Nst0ZcpqvSCohoWnHTpoQbPvrzka0Ix7RPWkbYUpGMMb5uKOTJNFyD3GuOiy/zogpjUSz+qrD/5q23ccG4YhdcWCzn2YXZEbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAmhhtVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA3FC4CED7;
	Wed, 18 Dec 2024 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549128;
	bh=4oO1EcVm33bIsq/HWyN5rzW7cr4ThZfhyYM7ahaK10M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAmhhtVM+HllD+p/erPDLVUjSNIXpCN1Fhr79caMM7mZKA0CKSLyBGhjh4gW90b++
	 wInXOZbYJbEof1+IJMTG85qMrQ6VRqwCHLKuLM28QVeheuX1601NwwDyyYl+Mm+dQd
	 PGHqLbH/+jyaPI39T6ypRTizk2COVlEqLKqWuRWlbSwo2z/GBFTkrI5wHbYAu0cDGP
	 MUqPapZiEvv5kD1BmrmQt9sS+Z426z1SfDCdSFWXoiIPKFYmYbb0hbLFes00ltWktm
	 brzfDqfxzSMDPuiIN/AFFMcDtwDfGOSKYWm7jPLOxOi1aNhu2dH635fIhPfmHBBPju
	 YUZKkIOlrlAug==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 4/7] cpupower: Don't try to read frequency from hardware when kernel uses aperfmperf
Date: Wed, 18 Dec 2024 13:09:53 -0600
Message-ID: <20241218191144.3440854-5-superm1@kernel.org>
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

When the amd-pstate is in use frequency is set by the hardware and
measured by the kernel through using the aperf and mperf registers.

There is no direct call to the hardware to indicate current frequency.

Detect that this feature is in use and skip the check.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 5f092f3c729e7..3df28e45be421 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -254,7 +254,12 @@ static int get_freq_kernel(unsigned int cpu, unsigned int human)
 
 static int get_freq_hardware(unsigned int cpu, unsigned int human)
 {
-	unsigned long freq = cpufreq_get_freq_hardware(cpu);
+	unsigned long freq;
+
+	if (cpupower_cpu_info.caps & CPUPOWER_CAP_APERF)
+		return -EINVAL;
+
+	freq = cpufreq_get_freq_hardware(cpu);
 	printf(_("  current CPU frequency: "));
 	if (!freq) {
 		printf("Unable to call hardware\n");
-- 
2.43.0


