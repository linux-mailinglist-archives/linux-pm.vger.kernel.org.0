Return-Path: <linux-pm+bounces-41931-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHMFJIlpgWmwGAMAu9opvQ
	(envelope-from <linux-pm+bounces-41931-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 04:20:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C1D4116
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 04:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3DBB3055E40
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 03:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE28E2F28E5;
	Tue,  3 Feb 2026 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8OORg/u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0942E972B
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088812; cv=none; b=heby7P7ggOUaBHGf8F7Ahuk0bq1x5eU1XWEkdVreOXb/l0x4TFLO6GIi2O2T1oAm6b+r1MKvOrAsVY1JxmDM3P/iLmlg3qtANw/qY9Gs5mZQp1DWOZe28x/Jmdv2J+Ra6qifK2LxWPSgXnWbljXwQZTLVe0tcQhJP34i/eKQx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088812; c=relaxed/simple;
	bh=oF9G0ApWjWS9adJt1oJ2Ri1rcg62Byrj2l2qL9jSFzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XAANZQE4mbCTmXVzaO6kTw+Rsd65c4g6+NyPehTvh3nTGOcKj+vjnnviDtLs2k5aEYy8wQjyhaxlCXW6XwqDrGik4OQp9YzkMdSdOWDUj1xLQnA7r804uc47zQyvNn+DVEDL7lm+OwRVsHQgHOQJODM1n2+WA5FFzkepMTxoXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8OORg/u; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso2793667b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 19:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770088810; x=1770693610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvv8w6qOpO5nJgdQm2rHSg/0QYZfhLcS6erT6wL/f8U=;
        b=Q8OORg/uIyhPul1juebvj0ffJ2XikK/WPiIP2ieate9jcmkW5mh5PsGzT+URErueLf
         3CNGzBF4ko9P/7K7UGNZZp+N2MpburD5XnVPbQvggGhtiL7FugEG4UjIl4FDpWjxo0MM
         OEUNKWxsA/9Td4ckeBrXoz13uPiQ+bcz5SlP7CsSP0mlRMAQM/EO6WawCrEYI0yytsUC
         aDBRf2XHjKZMzX0hl3emgcF26vkgguXz022UW4B9ANvC17Xazp8BNoc1x8Q/AyJPAdM/
         Xgq3zycCZNTV4P9mtEgtv5gWNK1tg+ZK0YRI8rxNi3yTRa+jstNY1pnTCMq5IIqFv1pZ
         j5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770088810; x=1770693610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvv8w6qOpO5nJgdQm2rHSg/0QYZfhLcS6erT6wL/f8U=;
        b=oAmqWgixZSU3XBZb4JobDpqkwm7V0IwMNNPvCzdHlhk/XTxgVsofbvw1nGB5OCDI7I
         aC4cxZSzsU0t7Lm1el3G3eiqu1v/hJMn3iC3BOFphSg7Yqp3mJQRnmx2B+IE94U4COIJ
         KA7FdBgTloPdo/ey7/4mM2HgOIcx00BfsSZuFG0SBB1KlsCTDXiVMT+ryUF5GTGQ1AXd
         dwU4VrtcJ/+/POWlIkoT7iKvxqOwOiwSw2DHqpJZUm/Kd8dQvD+qHyl7eWHg1RsrRrHD
         49OR5uC8l0tdPccF3U0E54rpQWIXf5z7RjVEZod41NUf4Q3uLHY3A+g5QPP/nPJO+UkU
         35wg==
X-Gm-Message-State: AOJu0YwM7jjXitMqfW6QrzTCpOmHUfxXWznqhDXi7kFMgCE+DImLAYjM
	ctjinyE9bP4oFWKAESNFqAl+0XH5lhVDArX6IDEfqz6Y4Mwxp/rZaJ5D
X-Gm-Gg: AZuq6aLz/mwC0ITGrhnn1G1N5DRPNTEMfB26M0p/dfeO/e9jwQOXI86A/XPOq5njS2O
	slFDieK7bqE6IiYrSiijSRXJz5ppNIh79VXLaruKs+HQjrUb9dXcI/wE9eJpgtXiJWpk64D6ssj
	Md+GJ5jLy/ySRZLFcKxsvICpikbf+Hh0iGDDUsKl5OXd3s2OY8uk3+2+pef79inFAuOzOk0YgqN
	x95TtJ8oNb40BQN5gX5kmPaSuInEyFIeP0DgB8v2HRadJfqf/QCY0+8WwAyzOv/TheyGIhlp8Zo
	2FGg7sNx2bTlaeCruy/TBRW1xcpK5Z+6iB7sw7rPcl07uBzcZcGmYtjfAE7SFUJ27FJoWybZJOm
	oUZF5hKyVroMRTL+9cux2YNdDfDK9jWolWxHSPZomuRat5PtR1kh8RU+Qb5GIDfTX5rSGQwysLp
	fhxwo6uh2ECDQq5dh0HbNF85TrC8LMMcWqbCpcxv15KGere4qw8yIk8XuGQ9br3YZss9gtpH9S6
	SLit9lc+0UQ5X9rdAbIhxHdH3B+Jt0fwWMbszIpTL7AyceNo5b2sBp9Mhh+qbG8wbdH
X-Received: by 2002:a05:6a00:2e09:b0:81f:7db2:89db with SMTP id d2e1a72fcca58-823ab9853e6mr14526507b3a.68.1770088810308;
        Mon, 02 Feb 2026 19:20:10 -0800 (PST)
Received: from 2045D.localdomain (120.sub-75-226-39.myvzw.com. [75.226.39.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b277sm21511394b3a.29.2026.02.02.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 19:20:09 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	tony@atomide.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH v2] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq() against races
Date: Tue,  3 Feb 2026 11:19:43 +0800
Message-ID: <20260203031943.1924-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41931-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E72C1D4116
X-Rspamd-Action: no action

dev_pm_clear_wake_irq() currently uses a dangerous pattern where
dev->power.wakeirq is read and checked for NULL outside the lock. If two
callers invoke this function concurrently, both might see a valid
pointer and proceed. This could result in a double-free when the second
caller acquires the lock and tries to release the same object.

Address this by removing the lockless check of dev->power.wakeirq.
Instead, acquire dev->power.lock immediately to ensure the check and the
subsequent operations are atomic. If dev->power.wakeirq is NULL under
the lock, simply unlock and return. This guarantees that concurrent
calls cannot race to free the same object.

Based on a quick scan of current users, I did not find an actual bug as
drivers seem to rely on their own synchronization. However, since
asynchronous usage patterns exist (e.g., in
drivers/net/wireless/ti/wlcore), I believe a race is theoretically
possible if the API is used less carefully in the future. This change
hardens the API to be robust against such cases.

Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
@Rafael J. Wysocki: While studying wakeirq.c, I noticed comments for
dev_pm_enable_wake_irq_check() and friends are outdated. They claim
"Caller must hold &dev->power.lock" and limit usage to
rpm_suspend/resume, yet pm_runtime_force_suspend/resume() call them
lockless. Should I submit a follow-up patch to simply remove these
restrictions or complicate the text with exceptions?

v2:
* Remove the lockless check and perform the check protected by the lock
to avoid races, as suggested by Rafael J. Wysocki.
v1:
* Initial fix attempt using double-checked locking.
---
 drivers/base/power/wakeirq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b289..c0809d18fc54 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -83,13 +83,16 @@ EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
  */
 void dev_pm_clear_wake_irq(struct device *dev)
 {
-	struct wake_irq *wirq = dev->power.wakeirq;
+	struct wake_irq *wirq;
 	unsigned long flags;
 
-	if (!wirq)
+	spin_lock_irqsave(&dev->power.lock, flags);
+	wirq = dev->power.wakeirq;
+	if (!wirq) {
+		spin_unlock_irqrestore(&dev->power.lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&dev->power.lock, flags);
 	device_wakeup_detach_irq(dev);
 	dev->power.wakeirq = NULL;
 	spin_unlock_irqrestore(&dev->power.lock, flags);
-- 
2.43.0


