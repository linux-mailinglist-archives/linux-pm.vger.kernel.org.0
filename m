Return-Path: <linux-pm+bounces-39119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DBFC9D0F8
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA6FA34735F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B32FAC12;
	Tue,  2 Dec 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddvw2Pju"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11C2F83AA
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710326; cv=none; b=Y83YR327elew+Mv9T9HluFJMdaS7Xu+y+weq+ttccUhjb/hcaSBSVltNYVJc7YYbJ9/xCYfJMM6MuHkDSetwK7Re7Iak3TfGBuhvAzY6sOaYRMItCAiPQ17Z8vbXUI4ls14q5yVUSc5l4OgCI2YT2rja5SFydUOrbXVr4oR2grc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710326; c=relaxed/simple;
	bh=eBYbLczjoxlV0ucjD3dwrdM9kVyEtGDPRECClyQTrKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQZ5bjx5zPUfNLJNhqINxWrTVzF2rw/d7EP9Z4eZf+lUuIxlA3G3HwNAUdwRC+GW/78lKje+V1OzIL2J6ENoqUGl/Yxe8vTncPln1deWwejIPtwaA+sX9q49LsOqtu2LhKw0MnjdkSWaU93wYwaGr2qmNyrgkQuLerCjv590WLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddvw2Pju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B659C4CEF1;
	Tue,  2 Dec 2025 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710326;
	bh=eBYbLczjoxlV0ucjD3dwrdM9kVyEtGDPRECClyQTrKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ddvw2Pju8Iakj83Vefdd0cPhyt5d8BS6RgKTuV1KVSkpX81Skb/JZ5CWEs6D6L/bQ
	 aIN9NBLuew46vqzeJ079pNoVdGYMbw4vwaTyWARyEIR/1rtakKtCs8nf1KIKcyGpQl
	 DTVm45U9IBYRGdl+/oaOQJhYXxKG2d/cKpwCyyAG8aen3ePf+mpJtScrNn3Jap6CFT
	 GmzNXkGlZaC3VhWstjFDNcPvwtjj2kgE0OEUOxAJ70KHHIEVkALk5ReEwwKjwN2qjz
	 4J75bSU6asR5ugv/P4CWZG16aNoT31iEcVffKaEpKOmNp+JDidgetL+8uHTIHJuT67
	 fUWC9tSWv3c7Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Malaya Kumar Rout <mrout@redhat.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 13/21] tools/power x86_energy_perf_policy: Fix format string in error message
Date: Tue,  2 Dec 2025 16:13:31 -0500
Message-ID: <7446bd6119fa77f75a41d7870953dbf467ffd40b.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Malaya Kumar Rout <mrout@redhat.com>

The error message in validate_cpu_selected_set() uses an incomplete
format specifier "cpu%" instead of "cpu%d", resulting in the error
message printing "Requested cpu% is not present" rather than
showing the actual CPU number.

Fix the format string to properly display the CPU number.

Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index e68eaa9f7cd4..b2125275c69e 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -372,7 +372,7 @@ void validate_cpu_selected_set(void)
 	for (cpu = 0; cpu <= max_cpu_num; ++cpu) {
 		if (CPU_ISSET_S(cpu, cpu_setsize, cpu_selected_set))
 			if (!CPU_ISSET_S(cpu, cpu_setsize, cpu_present_set))
-				errx(1, "Requested cpu% is not present", cpu);
+				errx(1, "Requested cpu%d is not present", cpu);
 	}
 }
 
-- 
2.45.2


