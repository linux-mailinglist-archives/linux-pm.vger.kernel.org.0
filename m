Return-Path: <linux-pm+bounces-22969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97573A45727
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 08:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B3D16ECDA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBCF281362;
	Wed, 26 Feb 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haqOJUcZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9B26E17E;
	Wed, 26 Feb 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556204; cv=none; b=pAOLBl3Y/0DQSTQTrmCbxOR4nOYGTONfMdWIqTd711xIZ1pUgVM9uGoS/xXcp6h10dIZei4VB8oHW4kZ6cKVJvRHD3/QDbNlbmU4yRMmrTwyrJulG9ZtPFEJYXFn8wObICynufyy2rFBOuFkDUuK/83HGYIjx/fsaztx6my4iPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556204; c=relaxed/simple;
	bh=LdFL5aOQDU2ldqURtyrrF9S+KVf7RvVGOnxYwvzO5oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeSbbSIONeM62hug3+A2AJHxVJUJAbfBuy2pzJdvWl66p5slTZF9TSTIbhTkcTAelF4HUbGZaIzEH4havRGh+OZoWyGx+uxIjyCJojx4J3gqHeef4IR9qPNhXqyDUJlxsGLctanKWOvk2cjk9sOceFktSklnYe4hxBKTC7HbWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haqOJUcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB74C4CEE7;
	Wed, 26 Feb 2025 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556204;
	bh=LdFL5aOQDU2ldqURtyrrF9S+KVf7RvVGOnxYwvzO5oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haqOJUcZiCQ4F1kyX/DIKUdHREYSzxjS5tcvWbL3z9cC65L6auHY9S694Jg8mauSG
	 T9Am9e6Kfhgdt5m2AVtGJEoOTQq17nX9bJcUw2b9iSGiK3SSkPs7ecwdmAWNY0Bjg4
	 mOm+A02R8+rt6u/oAirBON369vuk8rNZCqnKnLToBv4z6QStA4R8hOSEmQgfQ/iDwQ
	 78jax51YjIKrqvh1x06bxbRFUn8EpHrh0GiTwVjYwBT34t5HcN8/rkNvjV2CSV24/I
	 jlSJAB7zQrIXOSQAD3L+dJ+WfQg+ztCG1kt9cZV5awRBAQ/QSr/kIh841XrWSdFI9F
	 OylNg+Ku8uzFw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v5 16/19] cpufreq/amd-pstate: Drop debug statements for policy setting
Date: Wed, 26 Feb 2025 01:49:31 -0600
Message-ID: <20250226074934.1667721-17-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226074934.1667721-1-superm1@kernel.org>
References: <20250226074934.1667721-1-superm1@kernel.org>
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
index 55b6231e6a092..f0d9ee62cb30d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -667,7 +667,6 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 	}
 
 	cpufreq_verify_within_cpu_limits(policy_data);
-	pr_debug("policy_max =%d, policy_min=%d\n", policy_data->max, policy_data->min);
 
 	return 0;
 }
@@ -1636,9 +1635,6 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
-	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
-				policy->cpuinfo.max_freq, policy->max);
-
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy);
-- 
2.43.0


