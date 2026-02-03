Return-Path: <linux-pm+bounces-42002-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCEfMqJcgmlhSwMAu9opvQ
	(envelope-from <linux-pm+bounces-42002-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:37:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E12DE942
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31ABE30A453D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ECC30AAB8;
	Tue,  3 Feb 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqWJ1jEr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4F12FF69;
	Tue,  3 Feb 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770151063; cv=none; b=oi265hnz2Qrb5BIBlIHUFW7QN5+HEf/FatDyBs8ZHfXto5gSA8jW2ThNMQ9pyCpvAcLJZeQvHtB8y5I5LUiYoF+b886Ivr7RbJxKPilGzna0EJJjO8/LETaBLnVgntBRBvbBzob4nVhuqiZQZ3Fx0+OasE56FdZBooxekabubMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770151063; c=relaxed/simple;
	bh=xXEC2Lk9/vjEmywObnWZCAvmi8XZzq5yUgKV9ESBRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tqrxZx0cRwHcbMElisQKmK+qfWDCZ1PMW77+M9QY+wVlKOqScbDMu9sd9vozpk8a8B04UZppJDR2np7P1rCTO2tLDDDWSlZnuvh4fmZ29SIE9bapZgA0sVVm/huSWXzXLOOzvKMCKQxmAbva5WzWzchbSNMJtnWw37dQ8DstXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqWJ1jEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2846C116D0;
	Tue,  3 Feb 2026 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770151062;
	bh=xXEC2Lk9/vjEmywObnWZCAvmi8XZzq5yUgKV9ESBRxg=;
	h=From:To:Cc:Subject:Date:From;
	b=ZqWJ1jErB3kejrkVTXlGNJbyl07UdKiO2a5E2GrWvTlPwxbS5QBqp8kGCpHR0fQjZ
	 95wZGg8bmvopr0RvuO+0Vw8VFQSPJdS7z6ajuOf6CvAEG/DjpTiVcv9jl3fD16BFZy
	 b/ivd4TuKT57ZXwOGPpmar8/HA5tmtl+vwu1Sva/dBzWf3zZbSkrLK8JiWQOdbYiRU
	 uF/VnWRLA6HHsgtRT3MemgTf4VWY4CHrC9dGhHGX3f8A0reB2Ht0jOWQhrFC3n0KQX
	 Yx3wktetqSvlaNYoGTls4gsVrTxCHQykQDRbjMyHV0J/H2plyUwHEa79qgHv+w+5+1
	 ToYHMssIESWYw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Saravana Kannan <saravanak@google.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Subject:
 [PATCH v1] PM: sleep: core: Clear device async state upfront during suspend
Date: Tue, 03 Feb 2026 21:37:40 +0100
Message-ID: <12852589.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-42002-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,unisoc.com:email,rafael.j.wysocki:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54E12DE942
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In all of the system suspend transition phases, async state of all
devices needs to be cleared before starting async processing for any of
them because the latter may race with power.work_in_progress updates for
the device's parent or suppliers and if it touches bit fields from the
same group (for example, power.must_resume or power.wakeup_path), bit
field corruption is possible.

Rearrange the code accordingly.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.yan@unisoc.com/
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1527,11 +1527,20 @@ static int dpm_noirq_suspend_devices(pm_
 	mutex_lock(&dpm_list_mtx);
 
 	/*
+	 * Clear the async state for all devices upfront to prevent the
+	 * power.work_in_progress updates from racing with power.must_resume
+	 * updates carried out by dpm_superior_set_must_resume(), since these
+	 * flags belong to the same group of bit fields and they should not be
+	 * updated at the same time without synchronization.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entry)
+		dpm_clear_async_state(dev);
+
+	/*
 	 * Start processing "async" leaf devices upfront so they don't need to
 	 * wait for the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entry) {
-		dpm_clear_async_state(dev);
 		if (dpm_leaf_device(dev))
 			dpm_async_with_cleanup(dev, async_suspend_noirq);
 	}
@@ -1732,11 +1741,20 @@ int dpm_suspend_late(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 
 	/*
+	 * Clear the async state for all devices upfront to prevent the
+	 * power.work_in_progress updates from racing with power.wakeup_path
+	 * updates carried out by dpm_propagate_wakeup_to_parent(), since these
+	 * flags belong to the same group of bit fields and they should not be
+	 * updated at the same time without synchronization.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry)
+		dpm_clear_async_state(dev);
+
+	/*
 	 * Start processing "async" leaf devices upfront so they don't need to
 	 * wait for the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry) {
-		dpm_clear_async_state(dev);
 		if (dpm_leaf_device(dev))
 			dpm_async_with_cleanup(dev, async_suspend_late);
 	}
@@ -2023,11 +2041,20 @@ int dpm_suspend(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 
 	/*
+	 * Clear the async state for all devices upfront to prevent the
+	 * power.work_in_progress updates from racing with power.wakeup_path
+	 * updates carried out by dpm_propagate_wakeup_to_parent(), since these
+	 * flags belong to the same group of bit fields and they should not be
+	 * updated at the same time without synchronization.
+	 */
+	list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)
+		dpm_clear_async_state(dev);
+
+	/*
 	 * Start processing "async" leaf devices upfront so they don't need to
 	 * wait for the "sync" devices they don't depend on.
 	 */
 	list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry) {
-		dpm_clear_async_state(dev);
 		if (dpm_leaf_device(dev))
 			dpm_async_with_cleanup(dev, async_suspend);
 	}




