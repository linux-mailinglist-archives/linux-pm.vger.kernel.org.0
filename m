Return-Path: <linux-pm+bounces-22280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4101A38ED4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 23:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CA41748C9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF51DED7C;
	Mon, 17 Feb 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuOg9QE9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0D1DED67;
	Mon, 17 Feb 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739830068; cv=none; b=IESjyOONmqT2MFELSNyAZ8A3xF5ax1RAavSpzQb+ah+Zio4ZUyH4rg5SThCdsmigvO8rp69YpDbtTsEZxhN3Lu5e8TQzIyR2V/KZKA1BnBzYXIrnrq0z5eqZ3+7yvbL62JfBPDrPiCY5JKw3k7FPxpKIo3aptW/iKX9rMihGZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739830068; c=relaxed/simple;
	bh=/KzC6QnSkHJXGzPy7CJR/30bx9FgiwFxum2njUVEEt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T13UCxGaD6SPDb5U1FlygHQWPSUzryze4LTegJHcB7DObFJw5hCnA0xzs6Ylv7JD7Gf937SDa1s3JmS7L/4k9jM/jaS7yKusngKJKEdUV7MapQJwhv6UYDZy4ajmfHEfYkWmJhzTcYl8IsvFTcybQ9PUjoj6LrZ7rEcPpEmB/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuOg9QE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4933C4CEE8;
	Mon, 17 Feb 2025 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739830068;
	bh=/KzC6QnSkHJXGzPy7CJR/30bx9FgiwFxum2njUVEEt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LuOg9QE9FFu7G4yDZhJV5Jfv3/Gl3TZm+YVGr1angAGiCPO6a1ZOiw03ZzzbxYs8M
	 GxveMxJS6b5qXBLQOWXVabmS+6HQk1WF4X/KjUi0XqXx9ehHNexKbW2T3nT+SnVvl6
	 rFi3wKQW1ZCHM9hj5sgnbPnOThDL5JzNk1RUBA/d9v3bhoRb8UcFtk9tW4bjJG/HJM
	 ehjnyDlXG/uzFRFh448752BaGjZKc4mfDXzPSXd5Bp8kPmbGLt4G4UuRmZgmNK9dCr
	 aenK8uOceyq9KPrGS5iWSmQLVgwI3u2xtEcaRFCLu0buDSfl5cqjEdBeGBqZekIQ5x
	 IGbHrUMAgoJhg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH v3 15/18] cpufreq/amd-pstate: Update cppc_req_cached for shared mem EPP writes
Date: Mon, 17 Feb 2025 16:07:04 -0600
Message-ID: <20250217220707.1468365-16-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217220707.1468365-1-superm1@kernel.org>
References: <20250217220707.1468365-1-superm1@kernel.org>
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

Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index eb54960f313be..1f4c9d7fe28f5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -336,6 +336,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	struct cppc_perf_ctrls perf_ctrls;
+	u64 value;
 	int ret;
 
 	if (trace_amd_pstate_epp_perf_enabled()) {
@@ -362,6 +363,11 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
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


