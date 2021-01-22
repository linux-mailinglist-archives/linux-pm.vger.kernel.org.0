Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7316E30060E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbhAVOvu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbhAVOvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:51:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D161C0613D6;
        Fri, 22 Jan 2021 06:50:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m1so4648550wrq.12;
        Fri, 22 Jan 2021 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2e7gQHBjGp+1X78GlOBpuEvNSo52DSmCUsE/L28b8o=;
        b=mFjbT53IT7qR4mseGJbrY/wPLIvHc9qk8aZKX3QtgPUbsIhBjxICPo3EN+zwEAvH8d
         GCTwulxwohd7fxNlQk+uwqjLFqmpx6EFpRun+fcTF/yStY67mjQSvQsSzk3Oj+5ktINA
         z0iI8V+qqOL8ozqSlqDq+Te5VPrUgu4q8JtBHo11TZENh5+Lij73YQCqDuBcCEuxDvpP
         p72pdyWoM7Fj2Xzi7jv3p0PzTw3JEgYz01Gpn0Xvag6yOL9mkbkn6xj2N9EUiLDd2buU
         fWXZ+yUybUga/EADUubwyOQrmz0ShWXJ5Wk4bIg76v1P0eMasdP0pukjOr6Nr+ABR8Ju
         Xxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2e7gQHBjGp+1X78GlOBpuEvNSo52DSmCUsE/L28b8o=;
        b=TNAFsNotcJW+Jc9rj4T8aXl0vAS983ERXqiSfcOSMuUTWPuKuV7d1l472hd38ZcX06
         Mk1DoUBSChHPQYoYHFx7YQraY4qRP7Q2zKh5WTtg+AybJdpviCT2kkC2Fh4y3GgDgizT
         fvBCYUKO0z/81ArylbC1mdJ0EurwVOPfUnkFZnrY1vwySeDaM5vp1j9KvsQXZ55JfnLP
         BdaFbPKs4d8XfousiAVN8sOAFjHqdiElT0EC2V14bc6rntmKMK8azp81BS+iR4XhCU6S
         iwaeE9fWAiPwUDwK32bfSAEV+vkk2XjwqjMa3XYju4PHUt0QHyubRaX4K+2izGOFlZfX
         X/AQ==
X-Gm-Message-State: AOAM5339yFDOj+BarwciRgsF1ri96ox9Cptsmh8G1jOUMaaoHatWt8q3
        /meihAESDxXa2hlDX6QVJ5E=
X-Google-Smtp-Source: ABdhPJyaU3gNjW6u3LtpweyR4mmw1JpnzoSqk/sE3n6D1X3ZWkmU/mv4S66TG62nw5fInrYeSYIJLQ==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr4806601wre.128.1611327054422;
        Fri, 22 Jan 2021 06:50:54 -0800 (PST)
Received: from R90YT7WC.crto.in (lfbn-idf1-1-1126-251.w82-125.abo.wanadoo.fr. [82.125.229.251])
        by smtp.gmail.com with ESMTPSA id l1sm5240909wrp.40.2021.01.22.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:50:53 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power/turbostat: Prevent turbostat early exiting -13 on AMD_F17H
Date:   Fri, 22 Jan 2021 15:50:31 +0100
Message-Id: <20210122145031.754296-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Running turbostat on an AMD_F17H system, exits with a -13 error :
	[root@host] turbostat
	turbostat version 20.09.30 - Len Brown <lenb@kernel.org>
	CPUID(0): AuthenticAMD 0x10 CPUID levels; 0x80000020 xlevels; family:model:stepping 0x17:31:0 (23:49:0)
	CPUID(1): SSE3 MONITOR - - - TSC MSR - HT -
	CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
	CPUID(7): No-SGX
	RAPL: 234 sec. Joule Counter Range, at 280 Watts
	/dev/cpu_dma_latency: 2000000000 usec (default)
	current_driver: acpi_idle
	current_governor: menu
	current_governor_ro: menu
	cpu30: POLL: CPUIDLE CORE POLL IDLE
	cpu30: C1: ACPI FFH MWAIT 0x0
	cpu30: C2: ACPI IOPORT 0x414
	cpu30: cpufreq driver: acpi-cpufreq
	cpu30: cpufreq governor: performance
	cpufreq boost: 1
	cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000977 sec.)

	[root@host]# echo $?
	243

Commit 9972d5d84d76982606806b2ce887f70c2f8ba60a introduced the RAPL display but broke the AMD F17h support with :
	if (do_rapl & RAPL_AMD_F17H) {
-		if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
+		if (get_msr_sum(cpu, MSR_PKG_ENERGY_STAT, &msr))
 			return -13;

On RAPL_AMD_F17H capable systems, get_msr_sum() is called with MSR_PKG_ENERGY_STAT.

get_msr_sum() was added by commit 87e15da95775a2ffb8c444e84f08ca982b758364 but didn't
added MSR_PKG_ENERGY_STAT as a supported value.
The very close naming between MSR_PKG_ENERGY_STATUS and MSR_PKG_ENERGY_STAT is probably the reason of this miss.

As a result, when get_msr_sum() is called, offset_to_idx() doesn't have
a case statement for this MSR and returns a negative value. turbostat
exits with an error value.

This patch adds the support of MSR_PKG_ENERGY_STAT.
As IDX_PKG_ENERGY was linked to MSR_PKG_ENERGY_STATUS (Intel),
IDX_PKG_ENERGY_AMD is now linked with MSR_PKG_ENERGY_STAT (AMD).

This patch was tested successfully on a AMD 7502P and restore a fully functional turbostat.
model : AMD EPYC 7502P 32-Core Processor
Vendor: 23 (0x17)
Model : 49 (0x31)

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 tools/power/x86/turbostat/turbostat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea5209a83..9ad3447dd439 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -273,6 +273,7 @@ enum {
 	IDX_PP1_ENERGY,
 	IDX_PKG_PERF,
 	IDX_DRAM_PERF,
+	IDX_PKG_ENERGY_AMD,
 	IDX_COUNT,
 };
 
@@ -314,6 +315,9 @@ int idx_to_offset(int idx)
 	case IDX_DRAM_PERF:
 		offset = MSR_DRAM_PERF_STATUS;
 		break;
+	case IDX_PKG_ENERGY_AMD:
+		offset = MSR_PKG_ENERGY_STAT;
+		break;
 	default:
 		offset = -1;
 	}
@@ -343,6 +347,9 @@ int offset_to_idx(int offset)
 	case MSR_DRAM_PERF_STATUS:
 		idx = IDX_DRAM_PERF;
 		break;
+	case MSR_PKG_ENERGY_STAT:
+		idx = IDX_PKG_ENERGY_AMD;
+		break;
 	default:
 		idx = -1;
 	}
@@ -364,6 +371,8 @@ int idx_valid(int idx)
 		return do_rapl & RAPL_PKG_PERF_STATUS;
 	case IDX_DRAM_PERF:
 		return do_rapl & RAPL_DRAM_PERF_STATUS;
+	case IDX_PKG_ENERGY_AMD:
+		return do_rapl & RAPL_AMD_F17H;
 	default:
 		return 0;
 	}
-- 
2.25.1

