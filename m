Return-Path: <linux-pm+bounces-41797-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id szS5IvP3fGl3PgIAu9opvQ
	(envelope-from <linux-pm+bounces-41797-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:26:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09763BDB0B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B4D23006685
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB80837F113;
	Fri, 30 Jan 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="SUckfT6/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FA37F72A
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769797616; cv=none; b=piSp1pYG6tIFlk5Pshh0OuRcDrPgJFOloLTXDhz4tB0D+bHCFiDepl+nlM+ZDRlJI/vwGQZx78JfbwIuLEvgLuXAwMYjVJ/Cy/CqebfOZG+1HDMBS/1rziZBKB7/WYeo7A2aoutPAZjEL+cOS2VWG6eS9sOLtDaGIHpC2bg9kCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769797616; c=relaxed/simple;
	bh=h4Sr6SC+YUs8NqB2KBowcKk0rAehKNogc2lHKQ0E3wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t11Tcr70cAuyFNA6MF3Y8mhABoBVcs5Oxvx/tZe8HW8CVjNFy+DT3h0kG0bSR83djrsbZ0iwsF8MEmp6322X/7o7onxlZFLTpiKSgk6M0JmD/64K4xW0dvXLsznr5/NyCgogCNG2/uwIYHCCRF7VnNvUfLywb+Lf0vI2emtbhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=SUckfT6/; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c715116dbso1678268b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 10:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1769797614; x=1770402414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeoCaVUOs5r7HSAdULQW6Q0LapAIK45W0DvKg7zp3yg=;
        b=SUckfT6/aBoHY679tgoTBtf2kMemRbQLXx6d5F5cyQ28HmIZUrruLEoXVAoCHpJQuk
         Wnd1KB/4jyg24uMlnZNPROJ4YxPuHPVlH67PoQQU3aK4YqVHEOp2zFktQFK0LRRUBoGv
         RvQ0HQJjKTeISo40alVvNKMlsApyzf8os7wiMSYpgLYk3fhFyNfaRekpS3t726oyflJZ
         Mq2lpr4O35Jd+a93P03DucfYQgGGP15KkH5KwSRDddTx+ArzSBYTO+wHJkCSzaWyQl4W
         htmhh+K8IPAfBKconoH1xB9mH+mUwCgmvl7oxYcc/MMKcdrxP28dANAIffiFLq8yGC/k
         sXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769797614; x=1770402414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeoCaVUOs5r7HSAdULQW6Q0LapAIK45W0DvKg7zp3yg=;
        b=RbpL77LnNZAX4nf4CrGs2yjMJkwyKQTwKJswNrs/QsNmkD3q09ziGLt0bwzezg9SG7
         qzwBOzox3hdwqe1EpSbKv06tfvCKWL1izIUaIzAU6lzcF4hEZKdC54lDI2nT3dpOg2oi
         d5OUr25Auc9nvQeeIEXLZnc3zShLkA+YgGzivB3f11tK/V4XHDf3S1egV8oOiUE2h4BF
         YNXwwUi1eK8daNL8KO6vONCdyPRHK7XSNTp9TjH1zn6wFQPYpQ5fvFsu9H4CpfsLR97y
         vzJHQdTidYOs0CVouECvY+zVoXw7Z8KTYRq451MNAnNw0AT0Y7hQlAbhwrSFr6X/bSmN
         yP+A==
X-Gm-Message-State: AOJu0YxO1sFQucWJ6p9Mh4w1Tm3XVb00N//FVRS8j1W45Npbpf+GFLLf
	JZQ9XXlEOVuW8rNduHQB4VVdtudDomK5RtEaeDkN5rXVlZik2jR6xZ/wlzdR2LzZths=
X-Gm-Gg: AZuq6aIRzrPqko1mc2hRv4W7T3LBqU2EenJZQclDlWfogoYSqwbdB+K1sI+zaPQ4MUW
	DGqoY1XHwevziHCqE+OV8hslST66IaQZGpt9yok22PQHxW9E7kliWSKThfHmSED9U9ZJH0DuhG3
	SASWN50jhmO24HnCt0Q+JB0pjX51hlE7V+f6yHTF8DYJvl14yh3lODNVdYB4MS8KD1Hy+5m/Ac1
	0BBv9gf7kAaoBP2MA10ipkSFEx/9gYdoYQKaGIrrPfly9VITiduOzRLW/KjECDK7lmK5RmyFqEZ
	n1tF4ns8msmvam28U0z5CSmIUWo6srRXdy3tPxfBpki8Xb4E5ybd1IV4ZBGkJjVAISCKcv3iRG9
	tZLBcVv1K+1mtVQ6/l0efE4rqiMdZr5P+BtNBS4HvCy8K4CJyNb4DBev23/rE9VgjeR7JO0RmQL
	0Nxm/BUB3sUldgIlXpLEO6an0bZ70rm1hJ4zNCBi4TxPAW/7JmVqZ7vVrjS1ecg9tEifmYC7V3f
	WBkeGIEu9DD7medtVHyuWUYxiqQ8chk4EjpbGW4jA==
X-Received: by 2002:a05:6808:320f:b0:45a:5584:b0fa with SMTP id 5614622812f47-45f34baae01mr2375078b6e.28.1769797613953;
        Fri, 30 Jan 2026 10:26:53 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f37e0d283sm1561728b6e.13.2026.01.30.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 10:26:53 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] power: pwrseq: fix missing state_lock in pwrseq_power_on() error path
Date: Fri, 30 Jan 2026 18:26:51 +0000
Message-Id: <20260130182651.1576579-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41797-lists,linux-pm=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,northwestern.edu:email,u-northwestern-edu.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 09763BDB0B
X-Rspamd-Action: no action

pwrseq_power_on() calls pwrseq_unit_disable() when the
post_enable callback fails. However, this call is outside the
scoped_guard(mutex, &pwrseq->state_lock) block that ends.

pwrseq_unit_disable() has lockdep_assert_held(&pwrseq->state_lock),
which will fail when called from this error path.

Add the scoped_guard block to cover the post_enable callback and its
error handling to ensure the lock is held when pwrseq_unit_disable() is
called.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/power/sequencing/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 190564e55988..1fcf0af7cc0b 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -914,8 +914,10 @@ int pwrseq_power_on(struct pwrseq_desc *desc)
 	if (target->post_enable) {
 		ret = target->post_enable(pwrseq);
 		if (ret) {
-			pwrseq_unit_disable(pwrseq, unit);
-			desc->powered_on = false;
+			scoped_guard(mutex, &pwrseq->state_lock) {
+				pwrseq_unit_disable(pwrseq, unit);
+				desc->powered_on = false;
+			}
 		}
 	}
 
-- 
2.34.1


