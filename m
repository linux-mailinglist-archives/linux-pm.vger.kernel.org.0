Return-Path: <linux-pm+bounces-26701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930FBAAB690
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 07:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027693ABC1E
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F524222E6;
	Tue,  6 May 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS/afUhk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748122D6420;
	Mon,  5 May 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485681; cv=none; b=SXQj9+3ufJ3ccYX1bKLw3Kzmhc2WDThAVfvefinyHaNhjZPK+MLD9pg/coIibKDD247//snwm7OcDneYZnEyw7YxkBnlcl7P9ilhza00RhRoV5u77IjHWnrM3aAh++IkZ+uAj4cf7g5J/mlewy6I3aqKYHide24u8Fiw15N7Cvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485681; c=relaxed/simple;
	bh=M99ajY+gRd/zYONgX/3GChhp/+oj3XzSD9eZVEY1q0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RfcvtjblOhkHU1/wAs9hzJoohf4kyhBIrw+lEK5TWPVBTYxK5clRaRy1F2KO9nFGgUTri+JFEFC+rgjbwxW7PlYGTFWXnUIkKsz0fHtvtuu+DYKAHKksydfB1YUtPuVN2wZGZ67ZmuPgJvAEo7MeKMOHqI9ViQJq3Ld3/IG46no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS/afUhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44440C4CEE4;
	Mon,  5 May 2025 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485680;
	bh=M99ajY+gRd/zYONgX/3GChhp/+oj3XzSD9eZVEY1q0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tS/afUhkDo5c5mAtnr7uVcMDoTHEVRHT8q9/A09yvaRmwi4Gh2jPIsviFr58f9b3i
	 ro810zOyc8zt1YRtjN09hBHaiAeKiyqJmVwcAva1+qIpYU4JaGoI4TFJuJYqlArRC+
	 xOAK6iYZvIQ55Xr/ienczvVOWKi2zi6xveFswAjCQgj5FCrDyrq3x8A/6d6FuIdSlK
	 9RYxka998DrfHBcfIYu/59xVj5fjX3Wgr4q1lAMdMifLBf1knCkNmBsATw+u7Lpv85
	 ozVRbWr4PJBKg07MEGt6lm5AuLszQ5p1lXrB2KBnRnfb8FBCJb8gmWfOSl0n2haqsd
	 HK5OFMHIP5Zgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 423/486] cpufreq: amd-pstate: Remove unnecessary driver_lock in set_boost
Date: Mon,  5 May 2025 18:38:19 -0400
Message-Id: <20250505223922.2682012-423-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

[ Upstream commit db1cafc77aaaf871509da06f4a864e9af6d6791f ]

set_boost is a per-policy function call, hence a driver wide lock is
unnecessary. Also this mutex_acquire can collide with the mutex_acquire
from the mode-switch path in status_store(), which can lead to a
deadlock. So, remove it.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9db5354fdb027..7a16d19322286 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -696,7 +696,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EOPNOTSUPP;
 	}
-	guard(mutex)(&amd_pstate_driver_lock);
 
 	ret = amd_pstate_cpu_boost_update(policy, state);
 	WRITE_ONCE(cpudata->boost_state, !ret ? state : false);
-- 
2.39.5


