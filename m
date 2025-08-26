Return-Path: <linux-pm+bounces-33111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4BEB35E1A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223351880733
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894E307ACC;
	Tue, 26 Aug 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vZzNp7Yj"
X-Original-To: linux-pm@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A529BDB8;
	Tue, 26 Aug 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208638; cv=none; b=HZG0jw54p/cOL36cbNy6le9QIuOj37gRpLDQbGq2/LtCS3iHpQaPhREi1DXnY4W5jOtEu59Ycu7CAz1uZB7tnnVnrNHbO5qQp8j4yVerD1cvo8S8e4u/TNHZQArzmmJQDV0/yMmJJ2UhntcrXTeLpTsQspfxqpHMml9TP7qTyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208638; c=relaxed/simple;
	bh=QSEAgY/4EIpwLjSF0UditM9YciFdBpY5ZaWNPPba63I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcA1Bi9bJSUsfNpg7E/vc4TbCxFkqzd94BMeltcEQavbYsqn/ZbO2RCnUkYS72cy/VMKjGzz7DQk3kjSBfpnswHC0r7fJFNwumtJTHhnIBQJWof7yA/ubI3aO9wEgZGciq5jiXJtOl2TBcxeh4QxMjOha26NRrSH+QMhlH2RtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vZzNp7Yj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=DrahZQ5dl9N7suF3X5T0/TnwKkz5813d5miREUhMfug=; t=1756208637; x=1757418237; 
	b=vZzNp7YjvW7pZ4ohVNGNLJyXXc1jBRH3MzIuHtHY8k9rTMKoYu5YHnK9IIRddoRR160QLpce/ul
	/hgxLq5NVYNG+sD4x0wa8xFZmXPxr76K2PpKiCJuXovdbgU/o4pfbjV7AehQOzfU04oKlJdWuhvMn
	mq8KFsBiLLkT/MCjG29vyX0aZlYPWMk8tiyPE3BztdSU7kBGPN8heh0TPc9gSTIm2ReH6+lIooizK
	zIoLB/Vm/mH6d/t1ddl+gYGc6CsSIHiHVFaQiyGFOhQzo9n1THuufedMnKHbp7LjEjOY3knd8rGIA
	7WeMa0FGHIhWHvboeQMwWLCzdSeL987der6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqs5h-00000003aLy-4AIN;
	Tue, 26 Aug 2025 13:43:54 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] PM: sleep: annotate RCU list iterations
Date: Tue, 26 Aug 2025 13:43:47 +0200
Message-ID: <20250826134348.aba79f6e6299.I9ecf55da46ccf33778f2c018a82e1819d815b348@changeid>
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
v2: use list_for_each_entry_rcu_locked()
---
 drivers/base/power/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dbf5456cd891..2ea6e05e6ec9 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -675,7 +675,7 @@ static void dpm_async_resume_subordinate(struct device *dev, async_func_t func)
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" consumers. */
-	list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->consumer, func);
 
@@ -1330,7 +1330,7 @@ static void dpm_async_suspend_superior(struct device *dev, async_func_t func)
 	idx = device_links_read_lock();
 
 	/* Start processing the device's "async" suppliers. */
-	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
 		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
 			dpm_async_with_cleanup(link->supplier, func);
 
-- 
2.51.0


