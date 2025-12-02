Return-Path: <linux-pm+bounces-39125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CFAC9D0EF
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE02E4E4C1E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC192F99B5;
	Tue,  2 Dec 2025 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa/88nAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97B2F7AD3
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710334; cv=none; b=pXucYVUJLmSYba6c/grW4uqhk27WtPV+A9Q9V3YNf4Q0RgXISwcr0gSZnTdhp73NbFjbFVPHIKjxjW7Rf2MZ4qFOyp3pXmofCtZ3YNpOdxphbNh5ZSk/zsVoLDvPFrg5fql7HabG6oU6JfJkH+NmDwn8FDRW4u8G/hfZ0uqMYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710334; c=relaxed/simple;
	bh=ZmWgmwEYKc7RXjBcJogHjBYs5Mg4VQe8OqvaEmAepbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOqm1tH4NDB3mUqm8xgC/YfEmecwa2MUnnrf4zLuBXNFJlq+EVvs/iwjT09srwuHkHdmKAhif+VWZFz+UGpl7SF4ffZRnaFCtKbB+H/E/KnYVqH7yim7FBgefcZDPiI/ICI3vYdtZAEcW1eZGjbbyEHOHrDWlQ8rBtwaO4X9IEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa/88nAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D50C16AAE;
	Tue,  2 Dec 2025 21:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710333;
	bh=ZmWgmwEYKc7RXjBcJogHjBYs5Mg4VQe8OqvaEmAepbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Sa/88nAdhrENV+uqlVDHizg9UuBhPPI8HmWxlqIQBc8BZmydfgyNTuP5DOUuPnfS3
	 VQnVyy1Ug3fA3MNCZ3aEgsnbmiPWK7YGciUe//jYkWeOwOhiqu+l8XF7LYT4T1exPI
	 A0F1giH0+NoIs59Pjma8V09exugedL8f2/zFkFxoBUgfZL3tjYrtiojNsczMa4nxi9
	 ipocqp26uU0U44gtvU0OsnPOsGezrZ7B/5+rQAIH8KR1CgYTZ2GnunuGunYMXzdQz2
	 nVvS1WS2H2UWoKmDipAoBBovlV6v/xAjXzc2TlNwPTvXFM4bgnp/FL0leXi4MQv0BG
	 Zojy/nrb3Y6Dg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 19/21] tools/power turbostat: Print percentages in 8-columns
Date: Tue,  2 Dec 2025 16:13:37 -0500
Message-ID: <2ba8b24e9da49ea25fdae82c2f093a1c688d7b99.1764710012.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Added counters that are FORMAT_PERCENT
do not need to be 64-bits -- 32 is plenty.
This allows the output code to fit them,
and their header, into 8-columns.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f59dcee3c816..28625143a1b9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3482,7 +3482,7 @@ int format_counters(PER_THREAD_PARAMS)
 
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (DO_BIC(BIC_Totl_c0))
-		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100 * p->pkg_wtd_core_c0 / tsc); 	/* can exceed 100% */
+		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100 * p->pkg_wtd_core_c0 / tsc);	/* can exceed 100% */
 	if (DO_BIC(BIC_Any_c0))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), pct(p->pkg_any_core_c0 / tsc));
 	if (DO_BIC(BIC_GFX_c0))
@@ -10997,7 +10997,7 @@ void probe_cpuidle_residency(void)
 		if (is_deferred_skip(name_buf))
 			continue;
 
-		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_USEC, FORMAT_PERCENT, SYSFS_PERCPU, 0);
+		add_counter(0, path, name_buf, 32, SCOPE_CPU, COUNTER_USEC, FORMAT_PERCENT, SYSFS_PERCPU, 0);
 
 		if (state > max_state)
 			max_state = state;
-- 
2.45.2


