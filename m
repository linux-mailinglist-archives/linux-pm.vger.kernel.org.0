Return-Path: <linux-pm+bounces-36790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7FC070FE
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A5FB5633FC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE232E6A7;
	Fri, 24 Oct 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukjUBXCn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23F32D439
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320813; cv=none; b=oyUwAhzcH6pX9WyQbfXxZVPm/bMJQ61vyoXkstLCFEzSY6WiX+5/rfeBdfAW0IEwm2HqGDPJsq7jfO+BLC0Bm9xGKyZW1VyhLauyRLBMAHKr9P+jKVdnUVn/K5eZglKI2jM+rzLCLjouVVfQtuGy45FIjOtjonTtulQ7PB5aSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320813; c=relaxed/simple;
	bh=adacKI/ATSnis6Y34NhcYNfTYmDY1V5hT6bJM3PL+3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyb8vroPjAeJ43JpgWB75mzNtHB/OhdIOOC8ibBBgiiBnxLNTpMUtVs/OGpdlfSNpC/VLrkhD00ADQx16dKSvr+5tP4TrmPdrBOwTmGHw1AJx3jb5xWJ0nbTMGwNLUjG6ufHA98050nbOYVy9MAYb+Tj5d/9VFMnw+3x7+X6XO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukjUBXCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1693AC4CEF1;
	Fri, 24 Oct 2025 15:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320812;
	bh=adacKI/ATSnis6Y34NhcYNfTYmDY1V5hT6bJM3PL+3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ukjUBXCn0n7ghQNlbGbf0zBaQwpUCiXrrZ/fQydzA2FEBzp7wF7Mbb0TWHqDlH4mY
	 wzi8y1xf2kAgNCbvgwa1ZQ5RsDOdAnTUk9kr6ESTSctfbSMvoUcOrnVrpfuQikC8Ab
	 ruEC268XtffJ+L8LvnSF1dvXlqsESl4dzk8HUP4Y+mBXtofzZjGkpO2LowdR+OI6Zg
	 PqjU7LQOTLfDjF7ySiWZ21BKbnne1S3AZ3NduEgOQM2ungLkbNmnen/MGNHOFnMmgH
	 fapib6KU+UwzByLIU+jzasTy+ewIYiyLlWoAoYx2x/adAQvzNUo3osk5ngvdaWUYK4
	 LxSmde5K+vA4A==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/8] tools/power turbostat.8: Update example
Date: Fri, 24 Oct 2025 12:38:15 -0300
Message-ID: <64f96057a6391a643f4e7c2b2333c445acdec865.1761320252.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
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

Update the added-counters example to print counters in decimal
rather than hex -- now that it is working...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 3340def58d01..ad3fc201552f 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -410,25 +410,24 @@ CPU     pCPU%c1 CPU%c1
 .fi
 
 .SH ADD PERF COUNTER EXAMPLE #2 (using virtual cpu device)
-Here we run on hybrid, Raptor Lake platform.
-We limit turbostat to show output for just cpu0 (pcore) and cpu12 (ecore).
+Here we run on hybrid, Meteor Lake platform.
+We limit turbostat to show output for just cpu0 (pcore) and cpu4 (ecore).
 We add a counter showing number of L3 cache misses, using virtual "cpu" device,
 labeling it with the column header, "VCMISS".
 We add a counter showing number of L3 cache misses, using virtual "cpu_core" device,
-labeling it with the column header, "PCMISS". This will fail on ecore cpu12.
+labeling it with the column header, "PCMISS". This will fail on ecore cpu4.
 We add a counter showing number of L3 cache misses, using virtual "cpu_atom" device,
 labeling it with the column header, "ECMISS". This will fail on pcore cpu0.
 We display it only once, after the conclusion of 0.1 second sleep.
 .nf
-sudo ./turbostat --quiet --cpu 0,12 --show CPU --add perf/cpu/cache-misses,cpu,delta,raw,VCMISS --add perf/cpu_core/cache-misses,cpu,delta,raw,PCMISS --add perf/cpu_atom/cache-misses,cpu,delta,raw,ECMISS sleep .1
+sudo ./turbostat --quiet --cpu 0,4 --show CPU --add perf/cpu/cache-misses,cpu,delta,VCMISS --add perf/cpu_core/cache-misses,cpu,delta,PCMISS --add perf/cpu_atom/cache-misses,cpu,delta,ECMISS sleep 5
 turbostat: added_perf_counters_init_: perf/cpu_atom/cache-misses: failed to open counter on cpu0
-turbostat: added_perf_counters_init_: perf/cpu_core/cache-misses: failed to open counter on cpu12
-0.104630 sec
-CPU                 ECMISS                  PCMISS                  VCMISS
--       0x0000000000000000      0x0000000000000000      0x0000000000000000
-0       0x0000000000000000      0x0000000000007951      0x0000000000007796
-12      0x000000000001137a      0x0000000000000000      0x0000000000011392
-
+turbostat: added_perf_counters_init_: perf/cpu_core/cache-misses: failed to open counter on cpu4
+5.001207 sec
+CPU	ECMISS		PCMISS		VCMISS
+-	41586506	46291219	87877749
+4	83173012	0		83173040
+0	0		92582439	92582458
 .fi
 
 .SH ADD PMT COUNTER EXAMPLE
-- 
2.45.2


