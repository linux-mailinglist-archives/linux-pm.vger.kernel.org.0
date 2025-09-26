Return-Path: <linux-pm+bounces-35430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC61BA2432
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DA81C28080
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67050262FE5;
	Fri, 26 Sep 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD86zGN+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D88264614
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855268; cv=none; b=LGzspvghgn8OF/Iw0XR16Ka94mo67uIEp56Chuxj71bLE3dhxaB/Vsj1ShoAhC6eAH7rucsxTG8i1zSHMbfCMHI2pyFPnOmoF8zVolOX5gChd+qBf6x73ciiABHnxR01YXwzCJxCjI0M04Qw9peV5avwNmFlX+z4R+QyIQqbeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855268; c=relaxed/simple;
	bh=3qlwnTsUzB5mXJwrvIGrE5OtKZguH1YmJuuDBuAWo5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5we0IrcqJGwkmtYaCrZGQ4ek6QMY1ndqIW9Tbe+hQnE0xvtifz6sor1WK2TEfnTemG30/k3mzm1qK3qo78KRV4P7ID6GklQvHZB90zfM4+bAD+T+O2jRIpWAp8SMBYe+2lsPqKtlLy950QmnbhW26g80w+cvryyQe7hKaB2GW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD86zGN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920BAC113CF
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855267;
	bh=3qlwnTsUzB5mXJwrvIGrE5OtKZguH1YmJuuDBuAWo5g=;
	h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=bD86zGN+d6zHa1RCJihsB7jXixw0Rbc/a4+nqsoAx8zUdo3vk1yPuo72y5ada3yhd
	 tqi7spsJyV0ST+xGMZlakfO++K38F0L6liuatReF7bGIIA4qUzLxJanSPaD3faRKAb
	 esv2FISKDbxrjT8W4ci4jrsjzz2LVgoky1aBvOkSRYAMNX2etwyVtTpXV1PooFMZHL
	 dG50kyTHFUo/ErzfJKiQt+907VUcXG82YLlgr1vScZXKB/DZ4USytqOvfdR2CRAQAL
	 kQL8cxjVylncjCPInIq6ZhWZFKMyYrlVaYBwtTBy2FZjspdWXYlKziYoNoVoHLq0yp
	 YkuaKWO8E6UOQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 2/7] tools/power x86_energy_perf_policy: Enhance HWP enable
Date: Thu, 25 Sep 2025 22:51:04 -0400
Message-ID: <a23d5321b0a9d80fa8f94454c3069fa993f9fb99.1758855052.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
References: <4902665808e17a711200c46558803f526cbb154a.1758855052.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

On enabling HWP, preserve the reserved bits in MSR_PM_ENABLE.

Also, skip writing the MSR_PM_ENABLE if HWP is already enabled.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 822539a06cfd..534e2a70f8ae 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1166,13 +1166,18 @@ int update_hwp_request_pkg(int pkg)
 
 int enable_hwp_on_cpu(int cpu)
 {
-	unsigned long long msr;
+	unsigned long long old_msr, new_msr;
+
+	get_msr(cpu, MSR_PM_ENABLE, &old_msr);
+
+	if (old_msr & 1)
+		return 0;	/* already enabled */
 
-	get_msr(cpu, MSR_PM_ENABLE, &msr);
-	put_msr(cpu, MSR_PM_ENABLE, 1);
+	new_msr = old_msr | 1;
+	put_msr(cpu, MSR_PM_ENABLE, new_msr);
 
 	if (verbose)
-		printf("cpu%d: MSR_PM_ENABLE old: %d new: %d\n", cpu, (unsigned int) msr, 1);
+		printf("cpu%d: MSR_PM_ENABLE old: %llX new: %llX\n", cpu, old_msr, new_msr);
 
 	return 0;
 }
-- 
2.45.2


