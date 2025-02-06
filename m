Return-Path: <linux-pm+bounces-21505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8DA2B475
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 22:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20B93A8FE3
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 21:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2448237175;
	Thu,  6 Feb 2025 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g21dB9+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8623716F;
	Thu,  6 Feb 2025 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879038; cv=none; b=GDhHH4TsYr442yD2yQ8HLwYO5VSs7JJujt/S8kVpjNCDl29cqGFrMMcONz8Zg8kXpU6wN12MYMxbrTRM0rQk63CAsBfF1QKqOWxutc4v2b6TQ6yFQkacX0zkjrtl7mhkLeFt1T+kVmhb1Vfh7UgMhmUSZaFsOcDCGZvhLH+yFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879038; c=relaxed/simple;
	bh=v1EHsotfTSHicHPDFPC5WimMSrd8dRYscSm3SRD/P2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc7J50L3zivvEMT/AkILmLgaQjTNnWGVa2TU522/OVlDyySjGrIhO3EvKloz6+rV0sZWGWWwCE27UPgBQVLDXBs5LkfUNdVlkRL4frpvj2GQyLmbVA3941SdpPO9zFpGZdke4ZBUeHqg6+sj0Rl2WNFQgbRI4otfdUVk77eq/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g21dB9+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DD1C4CEE0;
	Thu,  6 Feb 2025 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879038;
	bh=v1EHsotfTSHicHPDFPC5WimMSrd8dRYscSm3SRD/P2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g21dB9+GizCTaOdzdfcUgV4B1QVguG+g0rmnmUZXQeZQVWFJ/lJZnLeHs7CwVZt0y
	 pOeeBOx1bBwu1e1laseYbdRh0kkz2FHIYob+QtUO8CPqgDcW4CwJ0IQW4isExWVks0
	 quG6Eso2RAfk29WRsqfU932cqhSdVaFly7eIHTxZ9dppNpMjMv86bkyAIzWcswbfji
	 faxEuCqF1W2A0N4/eqYB5rnc2lcjphpphN/Sqlpi8bg3ocztVSjuOBJtHo2TkTdd6D
	 reTOv865/iF3Hu5OwVbmnXtcsgbvjmnFiFojFYT320fdAxqlvksuCUFkd1Oq9KPKlh
	 LBaX7L4uuHhWg==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 01/14] cpufreq/amd-pstate: Show a warning when a CPU fails to setup
Date: Thu,  6 Feb 2025 15:56:46 -0600
Message-ID: <20250206215659.3350066-2-superm1@kernel.org>
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

I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
populated.  This is an unexpected behavior that is most likely a
BIOS bug. In the event it happens I'd like users to report bugs
to properly root cause and get this fixed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f425fb7ec77d7..573643654e8d6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 free_cpudata2:
 	freq_qos_remove_request(&cpudata->req[0]);
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
@@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 
 free_cpudata1:
+	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
 	kfree(cpudata);
 	return ret;
 }
-- 
2.43.0


