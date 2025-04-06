Return-Path: <linux-pm+bounces-24852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7ECA7CFD3
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320B33AC91A
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7221A2622;
	Sun,  6 Apr 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+qowhqB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4E1624F7
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965905; cv=none; b=nz1OO+H41q8ucVJqMhYpFw5C3A3IRgTvqL9bjxOkwnKQ9QDnQyFawGPuXyneQ9EE8i4K07Ga7CX5FpSeThAX3a+Ec+2bVxmtIAz/j/RdtaKE2AvCkmF64UbzMb/P068VJHsZNhuZ9sO4DqFmIBpW33SrxmIHEA1kAT6apT1/b+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965905; c=relaxed/simple;
	bh=dzAU8ZSgmVx7zBKYso3Uq7kjJjeeUuijfoYlmwJazAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKPHc6Gez+TWqOXocMlsx6aIdPRXPY0vaMTHR6KoXZ9+4nThOVkaWobTztqt1L8CVhK7c9Y8tq5nWkTiqPu4MA58wtHYqhrxK09jhLde3P01rgbmuxtyhWahHj+MmxBPlaVW/DM1kN57ko0EkUIC52KupjAfdOawKbwP5muYChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+qowhqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5113FC4CEEA;
	Sun,  6 Apr 2025 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965905;
	bh=dzAU8ZSgmVx7zBKYso3Uq7kjJjeeUuijfoYlmwJazAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Q+qowhqBi4uHb59yfXbq/HzxiJPTPNWGpCFWca04WspgqFZmQM2HeRROMmpu6HMJA
	 L0HKbC69Q/UVjwlbpw4AgBS5/55h/FTmQdDvdgNj4SybSSgBye04VGvCjG7JOXqV/Y
	 CQqd89S9f/seZb8D9mEuhF/JXF/3HNiGC9G04bPUe/oXYuJyZ3iXqciGgcHsHWJV94
	 Fwb9/WfQwuuERXILr3NKBOvD4nUZwwB7u/1gS5NT3CGan7KhotncDDw9ypbMtulYwI
	 CHhTdRJjHwlV+CEHoB34fBfDY9Nm8Bl7Z0r399UahKbrbQMJ0qhVaQYbSvGKxAeWsd
	 j9bKh1VYNmJZQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: [PATCH 01/10] tools/power turbostat: Clustered Uncore MHz counters should honor show/hide options
Date: Sun,  6 Apr 2025 14:57:10 -0400
Message-ID: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250406185820.765991-1-lenb@kernel.org>
References: <20250406185820.765991-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

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
---
 tools/power/x86/turbostat/turbostat.8 |  1 +
 tools/power/x86/turbostat/turbostat.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 99bf905ade81..ed258f248152 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -199,6 +199,7 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 \fBUncMHz\fP per-package uncore MHz, instantaneous sample.
 .PP
 \fBUMHz1.0\fP per-package uncore MHz for domain=1 and fabric_cluster=0, instantaneous sample.  System summary is the average of all packages.
+For the "--show" and "--hide" options, use "UncMHz" to operate on all UMHz*.* as a group.
 .SH TOO MUCH INFORMATION EXAMPLE
 By default, turbostat dumps all possible information -- a system configuration header, followed by columns for all counters.
 This is ideal for remote debugging, use the "--out" option to save everything to a text file, and get that file to the expert helping you debug.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8d5011a0bf60..5eef95956c2f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6703,7 +6703,18 @@ static void probe_intel_uncore_frequency_cluster(void)
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
2.45.2


