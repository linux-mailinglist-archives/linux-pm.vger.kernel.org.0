Return-Path: <linux-pm+bounces-21514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70ECA2B487
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E323A96E1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7723906B;
	Thu,  6 Feb 2025 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANGVk7QE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19F239062;
	Thu,  6 Feb 2025 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879047; cv=none; b=AsatlGVIGMAHFOSP0849ij4TcdCAx4jL3p2/752JP27bo+X+d2qCVSF+PNynuxA60mrNK/o45hbLnlABmncw/XtFxV8QIyxd2Uo1Bfvy2hApXvS8qtsQOQ2pi6XUnR2tzfwnKbea27/GNHx9ijHatRdVPnhBPtkq6Q2dBy65aBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879047; c=relaxed/simple;
	bh=knsunVTn/LakDXYBTLpd5X3vn52QfjdyZ5aNCI49rcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+FzdC8xSpC9tErHK040DVfmfFanL3nZHi2/T1xeA3r1O1vahc4K8mWjEeAexmiSK71s0SisxteYktPy7Y1l9gQ/qdIJZPBr7CEkzaCGhmswDAefcCJJag9qb6OSD4Nwbg8I8j4IzRnnnjIkwH/ZGrWKctmYowjUfXQJ/9HCqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANGVk7QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABFBC4CEE2;
	Thu,  6 Feb 2025 21:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879046;
	bh=knsunVTn/LakDXYBTLpd5X3vn52QfjdyZ5aNCI49rcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANGVk7QE6J8vgUHdXUrE5BwPettdNppG02uBdObkE50eKm9FI8n6DJtwhMZmI0sGp
	 fYwrLxJH392jpct9+SYG8JTDnIt9VzpM8UhPafn5Yq888T9lYFumPd2dbrJaZ3MNKN
	 d2GH8QR/I9Fh89IqhLNVOVrWbtrk3IUEryDfZ1qLwJCIZpoZ7N/cTiCudx4hYSrMhe
	 PUPqLvTQiE+77cbX60xfNpiC2u/zXbZMZkxs8bEt3wW64ifnJWoR2F4PMpaAYMlq3L
	 al2su48DZGf2FyYxPrS/6Qf4UAmvp55Hrm8oCF7ok3jgA8jlC9NHP117HNQV0vdixf
	 bNPav5U/b9w7w==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 10/14] cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
Date: Thu,  6 Feb 2025 15:56:55 -0600
Message-ID: <20250206215659.3350066-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206215659.3350066-1-superm1@kernel.org>
References: <20250206215659.3350066-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On EPP only writes update the cached variable so that the min/max
performance controls don't need to be updated again.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e66ccfce5893f..754f2d606b371 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -338,6 +338,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
+	u64 value;
 	int ret;
 
 	lockdep_assert_held(&cpudata->lock);
@@ -366,6 +367,11 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 	}
 	WRITE_ONCE(cpudata->epp_cached, epp);
 
+	value = READ_ONCE(cpudata->cppc_req_cached);
+	value &= ~AMD_CPPC_EPP_PERF_MASK;
+	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+
 	return ret;
 }
 
-- 
2.43.0


