Return-Path: <linux-pm+bounces-37850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D93FC53A4D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30E515A0355
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A33431E3;
	Wed, 12 Nov 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXdq32sU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8F342C93;
	Wed, 12 Nov 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964070; cv=none; b=d7gmmfJvWAtnrJljkA0bIGv+dYJtcHDmgFwG59sH1A9vA5HhNfaaa2H2wG4qO+M+rPL1BnPntUUFNpIpnMakZSKH+O4HyUV4U7jY/y5H1weu27r+umuiNP+qnu+pF+TA76aUa5/E/+jPHkcLFdcBtS7yg5/0ZW6aL2tz8SXZRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964070; c=relaxed/simple;
	bh=vruLes5H4nqAQml8t7uAga1vRR7ZSnnTSptLtlPqo5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ni7e6ozUdn3L64fGVi0SqHT0LheQDEGOo5ZZ7NdPTKfO36/X3kADyEC04VWzGhzOKaMgq9nKsA7XRv5FXtQIbzW+NCHK4b66PMOSqhy4aWU4DW4I3911osacCmK9dUVzL7hlqdG+222bVAmhVQwuTURhi2tVDqooC2f5stprdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXdq32sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750EFC4CEF1;
	Wed, 12 Nov 2025 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964069;
	bh=vruLes5H4nqAQml8t7uAga1vRR7ZSnnTSptLtlPqo5o=;
	h=From:To:Cc:Subject:Date:From;
	b=OXdq32sU0ihfBmbEie4spdvKLGG/Ny5uaETp0tSNMY5Vom9Og4OcJnK/27FbzvlcR
	 ycc8WZFBgXUeoiesVYZ0icXKgQmnmcanjsk7pgTVga4+YR8LreqMn/m8QoonLAmRVL
	 TzmNvlkwjAebPqSWmbUnWxUF34O1zMd37gay0Ftspo27onlNARQ+XpPn9eYZi4Eye1
	 YoRCLC4rJVJiiEyidXZGg82AzBTXnul9k1NwfvtGQJEpnr98jz1D+j+p4MxH/hMlVt
	 khzC6r7KT2wujHOVZnyv0cNVc+exByC+96O6bq1mDHt00hzsgfr+rSpRZ8i5Z+RRXR
	 ZkCA0QG2M59rA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject:
 [PATCH v1] PM: wakeup: Update after recent wakeup source removal ordering
 change
Date: Wed, 12 Nov 2025 17:14:26 +0100
Message-ID: <12788103.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After a recent change, wakeup_source_activate() will warn that the given
wakeup source is "unregistered" after its timer has been shut down
in wakeup_source_remove() which may be somewhat confusing, so change
the warning message to say that the wakeup source is "unusable".

Accordingly, rename wakeup_source_not_registered() to
wakeup_source_not_usable() and update the comment in it
to also mention the removal of the wakeup source.

Also restore the comment in wakeup_source_remove() regarding the warning
in wakeup_source_activate() that may trigger after shutting down the
wakeup source timer.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is based on https://lore.kernel.org/linux-pm/20251027044127.2456365-1-kaushlendra.kumar@intel.com/

---
 drivers/base/power/wakeup.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -189,7 +189,12 @@ static void wakeup_source_remove(struct
 	if (WARN_ON(!ws))
 		return;
 
+	/*
+	 * After shutting down the timer, wakeup_source_activate() will warn if
+	 * the given wakeup source is passed to it.
+	 */
 	timer_shutdown_sync(&ws->timer);
+
 	raw_spin_lock_irqsave(&events_lock, flags);
 	list_del_rcu(&ws->entry);
 	raw_spin_unlock_irqrestore(&events_lock, flags);
@@ -500,14 +505,14 @@ int device_set_wakeup_enable(struct devi
 EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
 
 /**
- * wakeup_source_not_registered - validate the given wakeup source.
+ * wakeup_source_not_usable - validate the given wakeup source.
  * @ws: Wakeup source to be validated.
  */
-static bool wakeup_source_not_registered(struct wakeup_source *ws)
+static bool wakeup_source_not_usable(struct wakeup_source *ws)
 {
 	/*
-	 * Use timer struct to check if the given source is initialized
-	 * by wakeup_source_add.
+	 * Use the timer struct to check if the given wakeup source has been
+	 * initialized by wakeup_source_add() and it is not going away.
 	 */
 	return ws->timer.function != pm_wakeup_timer_fn;
 }
@@ -552,8 +557,7 @@ static void wakeup_source_activate(struc
 {
 	unsigned int cec;
 
-	if (WARN_ONCE(wakeup_source_not_registered(ws),
-			"unregistered wakeup source\n"))
+	if (WARN_ONCE(wakeup_source_not_usable(ws), "unusable wakeup source\n"))
 		return;
 
 	ws->active = true;




