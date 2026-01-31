Return-Path: <linux-pm+bounces-41825-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLooKdPVfWngTwIAu9opvQ
	(envelope-from <linux-pm+bounces-41825-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 11:13:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02549C1814
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050FB3008770
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355BC33D6C1;
	Sat, 31 Jan 2026 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URleIlZc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671333C532
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854408; cv=none; b=SycaXyvknIRUiEP4nitObSrcO12LinOUxe8evWqEMqsvDub4Tuwd65ARAfmHXZYOezLpeXZmZDAIIGW+S0RUdNAyTc4AcHSuy22HdWTee7ln9GmQV/GblKfVPA940Pze13422aRwnPQj4inD+bkJmpFxcTZagheU2J6YJ4pUypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854408; c=relaxed/simple;
	bh=7HfRm2uQhSA/5klzskc0rfKbKQ/BIFWeaAMsPLMktrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnx+qhcz+Xu0N7KjUjaD/jgGwWbDlwhoSXtC8zXyGSQbDyDRT8taPvco+CShWF+RiaCYS03CfNQBP5N58qs81fbR14OC60N22mb910bfhc1Hv6VgBkZzRwQROIREQEusVp3VTk6dzxCduekumqDtF7IbFALdsGtKu3SYk230Uaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URleIlZc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a871c8b171so17635885ad.3
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 02:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769854406; x=1770459206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhZUDYbj88T1m+i7y1ui9FHryoXdNDmT3b+H4WcmQeM=;
        b=URleIlZcZrCxo8OcEW9JPb/Chozzd0GKf3HTgmPb9B1ZZYb4m8ZFrP1V+a4Grg0nCx
         dzTlZ2Ftq/42WSzX4SFZ5R0okO4OmiGpdnjQIQIVgCFzAkc+R636dyfYexXkWoAgQKMx
         KYK6qLY7mjgU1ISfiD1Nda4dYNImXOk5nD8JHqNue+NmJIdUcmSv/m3WjM460OpqUPXq
         Wx/6YbX/hB77K2gv9dukihG7pgc37NW6jkN8UPwpOPQL+sK5SfY/O1UaE8fXEdcpUa/u
         FfZqiGFS15G20eiQbzPSoi8HWY2gWF+QdysR//BHZ9ur/LfA94yg3HB2yn5aHZiWi2lw
         PDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769854406; x=1770459206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhZUDYbj88T1m+i7y1ui9FHryoXdNDmT3b+H4WcmQeM=;
        b=RdEcYXIsr+BxQiLcnY87fVYfmWIaKosgjGOVe2NaA/cBjOCam2tByDqqroHzjmwWfz
         KnUNeKeXZFhmwXeJwzrU6TIAmUb0s90odYjgKIyaQaJYm1aSO7fhc3e02oPVd1aDT78M
         m2bR840KurbCgx8Tp01zf+btALUzBfxtU4WNyLboeo5dhC5CJQjQu0+5X3uhZNp7IPWv
         kiQa0IEu7ZEr/siS0iH1FvnKPdwrqTcHWZmNUEIU7XTJbrEHPvsVTiqK9vOFwSVqEtYT
         ogmrf9krfRMyF8Ngw2S2mQMAEOTAmJ7Y1ATie87xMD/YBNhxBToKPwssfHe8SvRLj/0T
         C+SQ==
X-Gm-Message-State: AOJu0YxnYS71lHieaNQIJTduEaOw1qmjeseVgYkBHWm4sDaQQJeKNzVY
	kxB1cC3BxXWWuXbW6rgfqo0QfeUHAFlUghVr0qHk1nGSORJfzfhWFFvq
X-Gm-Gg: AZuq6aJXAglYMJYAqpD5kHTpgXuB/UUhsXNFBkQgK7yDaEjw8Ic0ItnyuWFUFBuf+JU
	lMlFIjgGp4yJXKDSrFGFz2Dxuy6pHAjmULg/vXjxVL7O+boMZy54lqJdO8KEzFgv4U7GhdFFF0/
	Eg5QPosr1O7vPzSwFr3Iq0vEQS7+1FBkrhkr7350ohgZXT6tZsmRJiZ83T+ad/JT0aetg0/+oha
	8NDBuz6n8/eroC3RxPeWL9kcDAWLKe2WopvEQPB9GL4xFtIMB9cQC+fuESALEef0sG5kbU/Ht/b
	ChyQGh4mZap5SEe/2YdQQeqjiXlGQDmPKewNuB6xAKs69+pgmejYzE6efDDPM3ll9kh4CqsrLC0
	FXV71X11PV/oO7CaIdOTDo7zsdphG9HR8b5Zn+fwsvVj0vjTcI9xCcOTFhwTXU6yK32jvqzBk43
	IEVeKcjLeN0+Vq2HHz854ehL9pnZJDAvbmoEyy9DDDfxHcxGxjbv7dnmO5Znkit2Np/dfzTjVxb
	ckNiyLxhGOkS9BbTA/j8G+WANStbjgc9q5NnMS9il5XWdgXigqfzw0x1EVI8Rs=
X-Received: by 2002:a17:902:c412:b0:295:9627:8cbd with SMTP id d9443c01a7336-2a8d8150724mr60494385ad.33.1769854406060;
        Sat, 31 Jan 2026 02:13:26 -0800 (PST)
Received: from 2045D.localdomain (6.sub-75-226-63.myvzw.com. [75.226.63.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d99eesm95905085ad.78.2026.01.31.02.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 02:13:25 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq() against races
Date: Sat, 31 Jan 2026 18:12:54 +0800
Message-ID: <20260131101254.56423-1-hanguidong02@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-41825-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02549C1814
X-Rspamd-Action: no action

dev_pm_clear_wake_irq() currently uses a dangerous pattern where
dev->power.wakeirq is read and checked for NULL outside the lock. If two
callers invoke this function concurrently, both might see a valid
pointer and proceed. This could result in a double-free when the second
caller acquires the lock and tries to release the same object.

Address this by using double-checked locking. This retains the
performance benefit of avoiding the lock when dev->power.wakeirq is
NULL, consistent with the original logic, but adds a necessary re-check
after acquiring dev->power.lock. Additionally, use READ_ONCE() and
WRITE_ONCE() to annotate the shared variable accesses to avoid data races
as defined by the kernel documentation.

Based on a quick scan of current users, I did not find an actual bug as
drivers seem to rely on their own synchronization. However, since
asynchronous usage patterns exist (e.g., in
drivers/net/wireless/ti/wlcore), I believe a race is theoretically
possible if the API is used less carefully in the future. This change
hardens the API to be robust against such cases.

Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
While studying wakeirq, I noticed dev_pm_clear_wake_irq() handles
sequential re-entry (via the NULL check) but may lead to a double-free
on concurrent calls.

I considered whether we should simply document that concurrent calls are
forbidden. However, since the double-check locking pattern is
straightforward and adds negligible performance overhead (we still skip
the lock in the NULL case), I believe hardening the API is the better
approach.

I also noticed comments for dev_pm_enable_wake_irq_check() and friends
appear outdated. They claim "Caller must hold &dev->power.lock" and
limit usage to rpm_suspend/resume, yet pm_runtime_force_suspend/resume()
now call them lockless. While this usage appears safe due to the specific
context, it conflicts with the comments.

I can submit a follow-up patch to fix this doc drift but am unsure
whether to simply remove the restriction text or complicate it with
exceptions. Guidance is welcome.
---
 drivers/base/power/wakeirq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b289..acb520626195 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -30,7 +30,7 @@ static int dev_pm_attach_wake_irq(struct device *dev, struct wake_irq *wirq)
 		return -EEXIST;
 	}
 
-	dev->power.wakeirq = wirq;
+	WRITE_ONCE(dev->power.wakeirq, wirq);
 	device_wakeup_attach_irq(dev, wirq);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
@@ -83,15 +83,21 @@ EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
  */
 void dev_pm_clear_wake_irq(struct device *dev)
 {
-	struct wake_irq *wirq = dev->power.wakeirq;
+	struct wake_irq *wirq = READ_ONCE(dev->power.wakeirq);
 	unsigned long flags;
 
 	if (!wirq)
 		return;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
+	wirq = dev->power.wakeirq;
+	if (!wirq) {
+		spin_unlock_irqrestore(&dev->power.lock, flags);
+		return;
+	}
+
 	device_wakeup_detach_irq(dev);
-	dev->power.wakeirq = NULL;
+	WRITE_ONCE(dev->power.wakeirq, NULL);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED) {
-- 
2.43.0


