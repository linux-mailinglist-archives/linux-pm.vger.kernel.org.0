Return-Path: <linux-pm+bounces-26678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B1AAA703
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 02:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BD816B577
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 00:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4D133281B;
	Mon,  5 May 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS/EAaL7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABB332817;
	Mon,  5 May 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484557; cv=none; b=lMw6mpsJa55xanikGAzh369qxrv98T9b1C5gm44olF/CKVpmgoOsGZkAMUmjCBLDLmhIPMuRM+LnNx6c4ligrP0vfgivTlTGEXJgSEhmfDokcKDrVR63gkzDSwIMa541iPVzl9zCnE3PMjTMhzIYMKj21+14UgS8V7FkKZyHKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484557; c=relaxed/simple;
	bh=Faw6lcy8GRM96DWvlwn0FJjHDv+oz9qshy5X7N2AODY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXEBi6u920P13TbW3/9z+VGt3iXO0nkrE0Fog6Z03JT44vBpOiQ5AFY/YBIwKGm5FwpKB2xBygOUA+UWQrjwAo6lGfABMVgbWEhJSnjAgzqG74qYe9NxRHEx1T6LIwMbqp+nsQ1UKzl6GRLMqkIqb5L7zIs10AXE1LropIdJlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS/EAaL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67912C4CEE4;
	Mon,  5 May 2025 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484557;
	bh=Faw6lcy8GRM96DWvlwn0FJjHDv+oz9qshy5X7N2AODY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aS/EAaL7E0fDHEYllGYfU9oLL7ucHULhZsAifjof/hejdVlDryCRnKN8+Z0tlkCur
	 phvI7Vg7m5CDCpnvHSAtQPZeZpB+HDq7iK2zlE29SMoO5ks/jcYd5TZOEsVXYl80Bt
	 AvleOpzu7u9pOVuzMm4Bnsn378OJL5dDYg7DlSgruDWXxSna/uLiW924f+hG0+n+Tq
	 G342yuQQXWhWO+waRRTfjd+jLEJbE8gN2bGvwjpT9VG7ia/CBIkJ3mpI7/enSI7pzy
	 hYyy8c/R9/MmKaqs6hLg3jG7lFfSSYheME0xJEMiaWAoZ4YTEz5l7tkHJU9qJmGw55
	 bFGM+waqst7LQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 535/642] tools/power turbostat: Clustered Uncore MHz counters should honor show/hide options
Date: Mon,  5 May 2025 18:12:31 -0400
Message-Id: <20250505221419.2672473-535-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

[ Upstream commit 1c7c7388e6c31f46b26a884d80b45efbad8237b2 ]

The clustered uncore frequency counters, UMHz*.*
should honor the --show and --hide options.

All non-specified counters should be implicityly hidden.
But when --show was used, UMHz*.* showed up anyway:

$ sudo turbostat -q -S --show Busy%
Busy%  UMHz0.0  UMHz1.0  UMHz2.0  UMHz3.0  UMHz4.0

Indeed, there was no string that can be used to explicitly
show or hide clustered uncore counters.

Even through they are dynamically probed and added,
group the clustered UMHz*.* counters with the legacy
built-in-counter "UncMHz" for show/hide.

turbostat --show Busy%
	does not show UMHz*.*.
turbostat --show UncMHz
	shows either UncMHz or UMHz*.*, if present
turbostat --hide UncMHz
	hides either UncMHz or UMHz*.*, if present

Reported-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.8 |  1 +
 tools/power/x86/turbostat/turbostat.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index e4f9f93c123a2..abee03ddc7f09 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -201,6 +201,7 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 \fBUncMHz\fP per-package uncore MHz, instantaneous sample.
 .PP
 \fBUMHz1.0\fP per-package uncore MHz for domain=1 and fabric_cluster=0, instantaneous sample.  System summary is the average of all packages.
+For the "--show" and "--hide" options, use "UncMHz" to operate on all UMHz*.* as a group.
 .SH TOO MUCH INFORMATION EXAMPLE
 By default, turbostat dumps all possible information -- a system configuration header, followed by columns for all counters.
 This is ideal for remote debugging, use the "--out" option to save everything to a text file, and get that file to the expert helping you debug.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4155d9bfcfc6d..505b07b5be19b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6713,7 +6713,18 @@ static void probe_intel_uncore_frequency_cluster(void)
 		sprintf(path, "%s/current_freq_khz", path_base);
 		sprintf(name_buf, "UMHz%d.%d", domain_id, cluster_id);
 
-		add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, package_id);
+		/*
+		 * Once add_couter() is called, that counter is always read
+		 * and reported -- So it is effectively (enabled & present).
+		 * Only call add_counter() here if legacy BIC_UNCORE_MHZ (UncMHz)
+		 * is (enabled).  Since we are in this routine, we
+		 * know we will not probe and set (present) the legacy counter.
+		 *
+		 * This allows "--show/--hide UncMHz" to be effective for
+		 * the clustered MHz counters, as a group.
+		 */
+		if BIC_IS_ENABLED(BIC_UNCORE_MHZ)
+			add_counter(0, path, name_buf, 0, SCOPE_PACKAGE, COUNTER_K2M, FORMAT_AVERAGE, 0, package_id);
 
 		if (quiet)
 			continue;
-- 
2.39.5


