Return-Path: <linux-pm+bounces-22507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA21A3CAE4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D821895BD4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391025B672;
	Wed, 19 Feb 2025 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPjmojKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01D25B669;
	Wed, 19 Feb 2025 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999012; cv=none; b=SViZlQ9Ghettu3h7pvYgtJ+9qqXqLp8QzNxvzbL+cUncUhrKGa8HGtEiIOlYKPVxfNoUlVrdS6+CtnVAFYgfAJJnr0HF1uyQQwvaUmu7rOEGB703W1cUpEKPWEwcXlgupKHxekja7Smz6oJuPYG0yaP4y3zrTYlJadoc1LiaRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999012; c=relaxed/simple;
	bh=c/FeA8W7jlIHd1+Trze7w65DN/I4yJyVWw/W7PcI67I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEbROq0WRGZPEFFJuhcAZACQNpjxjh/ofnmHhzbX5/5BwVG7yYt+ds9QIHxdqqyjF2BY6z1k7zLqUSEhcf4LG07dw5CyjqeYHdl+QDgJtEe189LCobNDy9B3HRCCvC7thHM6nab1BZnrqwpTAjGYWuYwZPL7RN55my+505WlnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPjmojKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B77CC4CED1;
	Wed, 19 Feb 2025 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739999012;
	bh=c/FeA8W7jlIHd1+Trze7w65DN/I4yJyVWw/W7PcI67I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPjmojKRJbQ1IRuoPSCfiWTB1LWeHcuYeIwkNqiKPI3wcH+3Ycs8U5TbDcmmgnI9t
	 bk9u6YSmIQblrJaH066mb3oblQjI+VthvAltJl0uwfJyBP2Yr3DlM3tlDR/PrKloBu
	 cahmCG+qTvzjxhaqjz7T6hdtDGVmyGlNuZV7LopgZrUYf2eiju3Na2Ty+DpTo5kvP0
	 Ton/T0LErKWWtYstOhv+QHrZtTNL1luu+WDIorQyZYAGQloghZk6nFHV+xIL0ZtHz1
	 k8yy0GuK+gXxE/k/Nacg30szqwmvH3O2CABSbF7HyCZ4KKEXDJzlyXFfqfbnoAt9hF
	 QDwu2+PCXn7lw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v4 16/19] cpufreq/amd-pstate: Drop debug statements for policy setting
Date: Wed, 19 Feb 2025 15:02:59 -0600
Message-ID: <20250219210302.442954-17-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219210302.442954-1-superm1@kernel.org>
References: <20250219210302.442954-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

There are trace events that exist now for all amd-pstate modes that
will output information right before programming to the hardware.

This makes the existing debug statements unnecessary remaining
overhead.  Drop them.

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3c87e7cde2a4d..fa9c581c68a39 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -667,7 +667,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 	}
 
 	cpufreq_verify_within_cpu_limits(policy_data);
-	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
 
 	return 0;
 }
@@ -1635,9 +1634,6 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
-				policy->cpuinfo.max_freq, policy->max);
-
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy);
-- 
2.43.0


