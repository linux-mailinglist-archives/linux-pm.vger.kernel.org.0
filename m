Return-Path: <linux-pm+bounces-19903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED7A9FFA3F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCC618836CA
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E91AAA1C;
	Thu,  2 Jan 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuryGGV/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFD19E819;
	Thu,  2 Jan 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827128; cv=none; b=nM2brr/zwCfzi+GJf0MkdE1nbBjBYqIa1rd6nJJeQRlTOVw4yagbdlkhozW8gFHQXGWKdYVbja1WA9XyFZ15FTLBI3wvpmQv3US/ojqG/Za6yOtcEtRkBOptBT1vI5bfG55YX+BZQs7EVNEz2PUtuYTcTZWJmikEQXQ78126w9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827128; c=relaxed/simple;
	bh=L6foyfhqB298HrTp42cOyzVK0PjE+59nsjCwQRd+jjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/ZIx7HS/W+RufL9RTAD6AiwnjtKSQkzhwnOtCXpHwU1rOIGJyTq3ENj1VSYl8wrKCRwCS3aY3lEf7we6ZOy8XSSzz2pMP4OWACM30/pUBN1shsn7rd7+fHFh6QK/wL6HW6TPCaB19N7OOb4Sf4JJ6Q1k74+FRoCRB4pcdvKuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuryGGV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63307C4CEDD;
	Thu,  2 Jan 2025 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735827128;
	bh=L6foyfhqB298HrTp42cOyzVK0PjE+59nsjCwQRd+jjU=;
	h=From:To:Cc:Subject:Date:From;
	b=JuryGGV/MWf7qGU7bEM2/HWR7PisOcyYJFoeiQFGTS070PUxPJZ2Xx1f7aaExCqTH
	 cwwjQjpJtH9cj73cCpLpDaOrAdDn2XmqgPiKN5z1QaPJdUY4Km1tvgh77BeUD8fWh7
	 dRifB9JkzL8ARRnT2gQBWXmWMB2UV3g25KlkhqkT7jNmmeAxWXguDkoFFgW4dHvqVK
	 f+woxzlVNpz4+zSL/HwhmLuZPWxlsLxjgdf9nhCV+jQ29LYx/V6MefJgXuke1i2Mbv
	 D53COa9xxrlFZcm+ambGcKb4GNZzeV5aQ+pU7kJxDcs1K6/gRzMbOxkFuBE7dnPQ3T
	 2TLyd5GazMZIQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian <sobrus@gmail.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix prefcore rankings
Date: Thu,  2 Jan 2025 08:12:04 -0600
Message-ID: <20250102141204.3413202-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 50a062a76200 ("cpufreq/amd-pstate: Store the boost numerator as
highest perf again") updated the value stored for highest perf to no longer
store the highest perf value but instead the boost numerator.

This is a fixed value for systems with preferred cores and not appropriate
for use ITMT rankings. Update the value used for ITMT rankings to be the
preferred core ranking.

Reported-and-tested-by: Sebastian <sobrus@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219640
Fixes: 50a062a76200 ("cpufreq/amd-pstate: Store the boost numerator as highest perf again")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 66e5dfc711c0c..f6d04eb40af94 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -802,7 +802,7 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	 * sched_set_itmt_support(true) has been called and it is valid to
 	 * update them at any time after it has been called.
 	 */
-	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->highest_perf), cpudata->cpu);
+	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
 
 	schedule_work(&sched_prefcore_work);
 }
-- 
2.43.0


