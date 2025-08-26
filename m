Return-Path: <linux-pm+bounces-33106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C86B35A7B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 12:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC21200B53
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6529D29B;
	Tue, 26 Aug 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XiChvNvb"
X-Original-To: linux-pm@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7D2248A5;
	Tue, 26 Aug 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205758; cv=none; b=Pj0w3tj1XpuZecTjHn8N+J6ypDhVG4km5y89ZtL6Egyl/G3TuksLS9/7y8TUhPymwM3oegXA4FNxgme+zGPlWeH0mbtZYiEg846HfRKGysWP/I4fR+5CMQpjpbOtyDV8/t/r+TT/f71Mr/5EUIfq3RlU4sHzAmATbAGHmgw8fzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205758; c=relaxed/simple;
	bh=HpMXmXyWiHOCQMwM9m6pUVZyTdiCf8166ZcDeX/hpjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbS6P3Woyeg49LEernSzWlLq5hD5JsGZkY2AiV5A8H7u1msbL9Pu4lSSSwBtRqHrrSYccBYgxIp/jFrHcOUze0D5qeEy9m+Y+XkQyBZ024STIaO6UWka22VWolLRjnn6twERNjA8+nL45VnAMz0tSAqeRY+cncSLsLlp7qv5o10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XiChvNvb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZVqiOkm+IDB3wo6ENlUKoe7kWHPIvSPtFHRBKYevkS4=; t=1756205756; x=1757415356; 
	b=XiChvNvbwtSZXx9+k2GBQIBDeZKMhyxG+uo4TghQ4iWNWiHgFtSSd3ngaBQZ1/pvhRdETiUjMuo
	JPL2M44PuBkzt+WeUHCWHAHwTHdHzFOQ2LY1mgHQgbCo5+N+I4Ai80UVZr2vTJxdy5N+V1Sfi9GgH
	DY3tcFoLVcZuuaOAYUTo95Y2p2sLrmP0SqQo4Br+e4/AhQMc4RSWbssskJ4R0YwYNzGeteH67/siS
	fEHHM4rzeV/ml5xfryGjFreI3cT73PVAL9rKNdARPzeRUFTkx3i0aQBp4W7Uh02rNK5PXeDwuSCbr
	BapRarIN2kJhIaYx8yGjvv406m80hjSDPdmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqrL8-00000003X0e-1m4z;
	Tue, 26 Aug 2025 12:55:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] PM: sleep: annotate RCU list iterations
Date: Tue, 26 Aug 2025 12:55:31 +0200
Message-ID: <20250826125541.7143e172c124.I9ecf55da46ccf33778f2c018a82e1819d815b348@changeid>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These iterations require the read lock, otherwise RCU
lockdep will splat:

=============================
WARNING: suspicious RCU usage
6.17.0-rc3-00014-g31419c045d64 #6 Tainted: G           O
-----------------------------
drivers/base/power/main.c:1333 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
5 locks held by rtcwake/547:
 #0: 00000000643ab418 (sb_writers#6){.+.+}-{0:0}, at: file_start_write+0x2b/0x3a
 #1: 0000000067a0ca88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x181/0x24b
 #2: 00000000631eac40 (kn->active#3){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x191/0x24b
 #3: 00000000609a1308 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0xaf/0x30b
 #4: 0000000060c0fdb0 (device_links_srcu){.+.+}-{0:0}, at: device_links_read_lock+0x75/0x98

stack backtrace:
CPU: 0 UID: 0 PID: 547 Comm: rtcwake Tainted: G           O        6.17.0-rc3-00014-g31419c045d64 #6 VOLUNTARY
Tainted: [O]=OOT_MODULE
Stack:
 223721b3a80 6089eac6 00000001 00000001
 ffffff00 6089eac6 00000535 6086e528
 721b3ac0 6003c294 00000000 60031fc0
Call Trace:
 [<600407ed>] show_stack+0x10e/0x127
 [<6003c294>] dump_stack_lvl+0x77/0xc6
 [<6003c2fd>] dump_stack+0x1a/0x20
 [<600bc2f8>] lockdep_rcu_suspicious+0x116/0x13e
 [<603d8ea1>] dpm_async_suspend_superior+0x117/0x17e
 [<603d980f>] device_suspend+0x528/0x541
 [<603da24b>] dpm_suspend+0x1a2/0x267
 [<603da837>] dpm_suspend_start+0x5d/0x72
 [<600ca0c9>] suspend_devices_and_enter+0xab/0x736
 [...]

Add the fourth argument to the iteration to annotate
this and avoid the splat.

Fixes: 06799631d522 ("PM: sleep: Make async suspend handle suppliers like parents")
Fixes: ed18738fff02 ("PM: sleep: Make async resume handle consumers like children")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Honestly, not sure, maybe this should just be without _rcu?
---
 drivers/base/power/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dbf5456cd891..e80175486be7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -675,7 +675,8 @@ static void dpm_async_resume_subordinate(struct device *dev, async_func_t func)
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" consumers. */
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
+				device_links_read_lock_held())
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->consumer, func);
 
@@ -1330,7 +1331,8 @@ static void dpm_async_suspend_superior(struct device *dev, async_func_t func)
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" suppliers. */
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->supplier, func);
 
-- 
2.51.0


