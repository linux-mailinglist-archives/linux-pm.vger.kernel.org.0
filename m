Return-Path: <linux-pm+bounces-26700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A83AAB68B
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C203A6067
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC12D4B53;
	Tue,  6 May 2025 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0qMflHV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8A2D4B4B;
	Mon,  5 May 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485660; cv=none; b=SQHHCzwxy9rYQ6sB5koAyZ8L9cnFOWiRjsNKRTGi11in5Bo4EuVe/a/YH0VItI9/j4jebzvBtJN4+sA3APCFnNtaK6GFwYE3SFDqAk5wn9TLh/iFGwv51MmqVy47DwSfEK844h1Zg0rl9HIjqF/GS78r55eZuWSQy389COsk12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485660; c=relaxed/simple;
	bh=jHDzHEFRlHiUhZM1Lgj5HAvwc0oS2yTjB+mbfilmv04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8+pnlh0HgE97Y6LRxf0BsbnidyxMXgdz6rrSevxjWzn4VUR/f/vYYwLZIj4bpluB1ECaUe/5oCle1h5FCOXCNs6L3fxP4lQTw4LhGsiE/PjJCix1x1W2FGrxdXYRiEjFJ3Wsk2B5iVjMZGpVPaaTsMFc6hVHlc04WH0QXhOUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0qMflHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D62AC4CEED;
	Mon,  5 May 2025 22:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485660;
	bh=jHDzHEFRlHiUhZM1Lgj5HAvwc0oS2yTjB+mbfilmv04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0qMflHVmUy5f3v8iX6Zuy40DD9Oz1JLBLrIU7ecRLrf/NI/sgNI2iPflO9f9s/mW
	 NqVJFAbp7s7vmP1ulEs0GhrO9EYQIuW00HdVyvUtnMSobQmB9Rdenvx9dTtJwQbMC7
	 FTuEe5pD3h944HHgKfBwin7BAgIG53FS/8ASj3i9NjfJg25hWahcmBKrG97vmjkI9S
	 0s9b+9V+4kfOHIXedlfGahIR1zIEFe/4S5bDh0utXKNXHOLH3E30YOggOBPy6+Spop
	 ZpP3ST8SsDdiOc//4YiXJtPQT1JGuCpF4EjabD7joLeBrKRmN5s2+a2MVFzz09btKa
	 QnPvOM3HXFyew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 413/486] tools/power turbostat: Clustered Uncore MHz counters should honor show/hide options
Date: Mon,  5 May 2025 18:38:09 -0400
Message-Id: <20250505223922.2682012-413-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index a3cf1d17163ae..e4b00e13302b3 100644
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
index 77ef60980ee58..12424bf08551d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6445,7 +6445,18 @@ static void probe_intel_uncore_frequency_cluster(void)
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


