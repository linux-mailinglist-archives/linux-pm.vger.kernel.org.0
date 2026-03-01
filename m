Return-Path: <linux-pm+bounces-43368-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFrtFq6To2khHQUAu9opvQ
	(envelope-from <linux-pm+bounces-43368-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 02:17:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2191CA117
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 02:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E3593011373
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2026 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4C207A32;
	Sun,  1 Mar 2026 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieNOfL42"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD023D2B1;
	Sun,  1 Mar 2026 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327842; cv=none; b=i4XJdHo6Ef+PWF2vSGYpGaW0FVYvjU9r9/niXBqb4W4oPuVVulO0HjPAR8uu3sM5Hyfj09BYsY3I66iCm+4edXi2orqopf0+5Zh6K5toh+RFSOVDnT5JDBr/usyLtDE++Q9D7+5CAH+T27+nMnGZ8N21ZOQQt/01RPXXVaD17WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327842; c=relaxed/simple;
	bh=Xv+7u6t1nzE38M1rBFwprNe8XFzm+Rt2244uCU9jpxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cF/pD04jktoDogKW8KdhLd2ksF5L2ZXdzzR/3l2IzpZTNlTKICEwQTkFghQ3e5TH0XAApY1+mpHmmdLxAnZEx5M3N6nTuJwUrzK2gxwx0cSJcV+6/wzEZAVgPtkdqrzt1bDPZdLhiY8nLwepwLKooovyMEwlAR0CXxu+4h805uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieNOfL42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5A5C19425;
	Sun,  1 Mar 2026 01:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327841;
	bh=Xv+7u6t1nzE38M1rBFwprNe8XFzm+Rt2244uCU9jpxM=;
	h=From:To:Cc:Subject:Date:From;
	b=ieNOfL4227XIVDOORfD58SNMJ/i1xyc425gnmN4KzJSHHKJ+kdxS7zK7QbLgHB2ag
	 pGoRSs5cOzkssW7lbVVJvGK/tQrIB3YahuUwI7vYGaIpTvlDuFI4Iwt/QPLQt4zHmP
	 TuKaX1dxgqYs9Zc0C+Nl6A/KWui4SCb5K2jlhs9JKVvIvTO+y+ClgXL7jeJtxQ4hZR
	 A0p8aQFVZaSG5xGee3k81gGMFS2mdD6u7H8PNXeDoIJ7zfLlC1VP4VM0kTk8UVWrgM
	 XR7qEjQdL0FQIa3Z0aiCrKISJ807ey9eqg7PHTa7pqRCbyIitWxozveywkzS96q1tJ
	 RcsMVMlB93R6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	xuewen.yan@unisoc.com
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org
Subject: FAILED: Patch "PM: sleep: core: Avoid bit field races related to work_in_progress" failed to apply to 6.18-stable tree
Date: Sat, 28 Feb 2026 20:17:19 -0500
Message-ID: <20260301011720.1671247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43368-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C2191CA117
X-Rspamd-Action: no action

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0491f3f9f664e7e0131eb4d2a8b19c49562e5c64 Mon Sep 17 00:00:00 2001
From: Xuewen Yan <xuewen.yan@unisoc.com>
Date: Wed, 4 Feb 2026 13:25:09 +0100
Subject: [PATCH] PM: sleep: core: Avoid bit field races related to
 work_in_progress

In all of the system suspend transition phases, the async processing of
a device may be carried out in parallel with power.work_in_progress
updates for the device's parent or suppliers and if it touches bit
fields from the same group (for example, power.must_resume or
power.wakeup_path), bit field corruption is possible.

To avoid that, turn work_in_progress in struct dev_pm_info into a proper
bool field and relocate it to save space.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.yan@unisoc.com/
Cc: All applicable <stable@vger.kernel.org>
[ rjw: Added subject and changelog ]
Link: https://patch.msgid.link/CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 98a899858ecee..afcaaa37a8126 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -681,10 +681,10 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+	bool			work_in_progress;	/* Owned by the PM core */
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
-	bool			work_in_progress:1;	/* Owned by the PM core */
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
-- 
2.51.0





