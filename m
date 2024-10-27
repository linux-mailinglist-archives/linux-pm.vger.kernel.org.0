Return-Path: <linux-pm+bounces-16519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3E9B1DA9
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 13:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1FE1C209EB
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBDE7DA6D;
	Sun, 27 Oct 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkuzILjV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A5210FB;
	Sun, 27 Oct 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730031980; cv=none; b=LoCUUi8HYDBQ4M3xW7FZbOj5U1/NYEikQL4sDjHAtLwkMop92uuc0ZYjRaY1hYqhE6WMwF2ItomoNjmBY6iWIJMRQ/3BQ4eux/cA0+g4IGaJJrgAjoS+OxkrKRZrqibrV3mkZo94Q1tPObK+vNumdT1BJ0g+aIVyoKqtiRdH/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730031980; c=relaxed/simple;
	bh=/4be3FnnCyaaVXIf2eypjsPQZtSzzqpAyH1L61eU3DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6wb7pGAXSs06SxjhRpJY5ANudPg+5wZ5YREbevhom5f64PKJLj3EDgr/Bav5oVUUfY1KEmB63LyaJKnR2zXNuD5oRo8a+bgAxdlT6dCiJmFoBLecvG8rZ5Kbd4azyzBWYI4snEDQ8GV9T8VrS47H6uJP+LzbTFhNKKEx+l/oaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkuzILjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF2AC4CEC3;
	Sun, 27 Oct 2024 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730031979;
	bh=/4be3FnnCyaaVXIf2eypjsPQZtSzzqpAyH1L61eU3DE=;
	h=From:To:Cc:Subject:Date:From;
	b=UkuzILjV9Li/6D+xhR3Oc5WvDIwAmoSSk9yQOE7JAM+8iBxr4gBaM3wImpPjazp6e
	 vMGtltCarajV2kkKyGhfDw8zcitHAaK2l5oa2BBngNgS6NXFUuvNezF7ZWHAXijHTo
	 wu9JJGhBpvYKwlvdefzAFRsFmnDSpfk2rIo0kddGI1uImBzg6bt91THE2TryfSZJq/
	 2CTUE4w+UX/vnjKJ+2Td4BQj/hKgFOwZDzDg4gO0J5E6XHkNH+tcG9S4vkeCoPdivF
	 I94lPTO2ed+uOVwrYVCtJ5FHGSyLwdHKvKrKaq5kIBG4d+k1nkj8fKJOrJsp1Ey+Sa
	 JWL56puuk4fQA==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] cpufreq: amd-pstate: Register driver after static call update
Date: Sun, 27 Oct 2024 07:26:12 -0500
Message-ID: <20241027122612.749674-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The driver must be registered specifically after the static call
update.

Fixes: e238968a2087 ("cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call")
Reported-and-tested-by: Klara Modin <klarasmodin@gmail.com>
Closes: https://lore.kernel.org/linux-pm/cf9c146d-bacf-444e-92e2-15ebf513af96@gmail.com/#t
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 206725219d8c9..2f0e29b05963d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1857,12 +1857,6 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
-	ret = amd_pstate_register_driver(cppc_state);
-	if (ret) {
-		pr_err("failed to register with return %d\n", ret);
-		return ret;
-	}
-
 	/* capability check */
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
@@ -1881,6 +1875,12 @@ static int __init amd_pstate_init(void)
 			return ret;
 	}
 
+	ret = amd_pstate_register_driver(cppc_state);
+	if (ret) {
+		pr_err("failed to register with return %d\n", ret);
+		return ret;
+	}
+
 	dev_root = bus_get_dev_root(&cpu_subsys);
 	if (dev_root) {
 		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
-- 
2.43.0


