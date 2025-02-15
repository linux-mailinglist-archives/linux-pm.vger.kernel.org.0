Return-Path: <linux-pm+bounces-22136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6032FA36A3E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 01:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9112F1891FFA
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 00:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45A91A3AB8;
	Sat, 15 Feb 2025 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ey6mJy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EA1A3178;
	Sat, 15 Feb 2025 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580791; cv=none; b=PVlKDqjcppd42yvu93/ex+DeNykWNVH/Tr2kjt/t99rSmVNzhc0p0/nHgn8DCoQDJehYWSbIxy12U3ZJ3+T9poMaxcXlL8x+0kMdnnI0Un2/1HTAMNgTZWmfi1l2OYuKOFl0pALkD/eIRUYyy+spIOP3yoI5PSchgRt3cGXhP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580791; c=relaxed/simple;
	bh=xSJlzrYu5QNQA8gI1PWzoccp5S/1Xh64cyHfWRPurvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoskLZKhwoS4IFyKd6Q5g9ONEg0XxVh6xneUB4UVsKXtlTtSzmd6yZxICRSgOuaiQGaUCH+FNHqhDnA8altuEKmdgSbvXPcuzw53ic0wMbTGBh6+IMKPga2gn5Fl9gmBXlcmbNHhTNB3dtpz3u0bmSckyxmBYW0poJqw9X9W4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ey6mJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B629AC4CEE2;
	Sat, 15 Feb 2025 00:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580791;
	bh=xSJlzrYu5QNQA8gI1PWzoccp5S/1Xh64cyHfWRPurvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9ey6mJyiaDe3Nf9ZUD1OxuJrnmALb3pYl9ckNfcABYdUlwJQ7f6SZPjVb6y557q9
	 0fMBKG60U5+cIkglj1ErOimn6alEko55NJddFf89qA0CZmjhVUSN6g0sRexj9/hGxT
	 KBMIXmdljCVIj1y1qpo2lq5VqMW8U84oT1TmTCWxbxHwW7gPz7ip7eBDkQU+Xt2wIx
	 OM0MrYjufFVBZ9SgyoBTLQXEvBvoN/9TbIHFjzA+YV0WngXrfdfhoVVVymJ1QO97eK
	 v05Xua5h+q4WYE1KPZSCP6R3EDSyY27kVQomNwbjbca5UkR1++WuJbHSdYdkLuCLvd
	 Ilhgxj8SOqhkQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 15/17] cpufreq/amd-pstate: Drop debug statements for policy setting
Date: Fri, 14 Feb 2025 18:52:42 -0600
Message-ID: <20250215005244.1212285-16-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215005244.1212285-1-superm1@kernel.org>
References: <20250215005244.1212285-1-superm1@kernel.org>
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fd2b559f47c5c..b39bed12b360f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -667,7 +667,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 	}
 
 	cpufreq_verify_within_cpu_limits(policy_data);
-	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
 
 	return 0;
 }
@@ -1632,9 +1631,6 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
-				policy->cpuinfo.max_freq, policy->max);
-
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy);
-- 
2.43.0


