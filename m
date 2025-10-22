Return-Path: <linux-pm+bounces-36680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F83BFE69E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 00:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC393A35D4
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 22:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E5305051;
	Wed, 22 Oct 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR1CnWz9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193F2FB61D
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172159; cv=none; b=EwhjYVFeg35NRhtR2GOdrq1xEQOCp4Kuy415GyELpBy/xjSq/sOZcudibdee+IjceoGeY/GMQmvSmzoL5SqkOkFMxzhinzTD3SYRTp8h1+FwUXad744vL/uzsoXV82wZEYttMge8VSS9WhZ2VVgYve0zimKZxEsoMhXiB1RxQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172159; c=relaxed/simple;
	bh=n8ISGRabhAFNs3WUlciNSIjwBswMQEjwmH+FuJiXVgY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IHtIj3l7nJzt9i/1IbZxVZJBlqnMfjy9YA5XG5Url4r29Z9OAco2wsa3RkD3XiEoZzIYEq07DgOr/ScfZK80kggcx8aCF+t21+ymxwabgdNR8vqPSG5CKZXNlHfVft/LMWdI+LDNtLSJvsqaJOzluk60HU+wwBlL3JQ66r73wFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RR1CnWz9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2697410e7f9so2312665ad.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761172157; x=1761776957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kCJw8vrTps08USD66tSqWHMpSbjCtAd/5PGnI8+iP/c=;
        b=RR1CnWz9h1j1B6AZkb+WXaZgVxigAc8X1lbJ5is2hajecmccQVwa7Lx+DL2F3SkJB4
         UtQcXoN3cc4ZpXCKrNkg55PyQ/38UMzZuEQwdYTikKOK5H99TEecIRZROoajhELxH6UH
         zZiiAWLyRRDDKuGUphLTNTSk8EFNhbe+RFBj0sEN1NjxbvfzVE0W8vw6VpcVmr2qvl8w
         6Flyu5YbO+ZRnjY5WTVYZhiXDC9U5779I7Limv5kjSESufXE43Qwyr9pSGjB6tiBi6gB
         Dk0sPTQohcGlKHK5QRabSyYKqZdvkPN4z/tn6Zc+jXFAT9DcZPAosHnd46od06T1QLsq
         L14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761172157; x=1761776957;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCJw8vrTps08USD66tSqWHMpSbjCtAd/5PGnI8+iP/c=;
        b=Jx/oZVP+N60h89Hd9QCi+xDjFKFPbtxzRWOLCY4R+iGQ3t1UP7ev0oiwUygxWyCLp7
         7bI02Zlv1pC+yanaM7gmvZSO1TWiVFAM/+47O9FQs/Fot7qOTDcURPzry/Jl28Vsfv9M
         WxnlNKto81LgUanPV72kYyRBW12aHmspoeebs2CvIg1egZkXISLraJ+/SsbK1BJ705Q2
         HLGP0cqoMkqNZM0yDy8RwAJnWLG0fGdmimPldj6/SeSzb5lLpiwl9+KCdjbMhUkicPOw
         Rf8ZPoy8mBmHQ1ltBXxhf5yQxUfrwxu0GjK9iZGZyMY2PrOreceZIhhXouKwE+1yYnKE
         D9aA==
X-Forwarded-Encrypted: i=1; AJvYcCUjagIfwo5/Hnsz9LaUUoExt7qaNxZEfiAfbjj2ohBTP4yIrHi+x/0Ck3yS9it8xLOke9GJofRS0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmJYbhdS571I35FTBUsaCYbgTeQBVuQqER7CDjhD+l+Z0smC2
	1rxM4kkipaXhEMm4ENlWjfDkG1qRGGb/ORJ9X2KLa55V4LM14VafgpVrHnijVipuOY36sDF4FLU
	mpMr0/ehGrEnxUQ==
X-Google-Smtp-Source: AGHT+IGDnhb3gQM49Ot8BnCEQLTjCXnCbba67ygs3SVunQnP3Gt3wyYp/GX4VsBUKR6zA6NfebgaCmX3mUlTQA==
X-Received: from plcq12.prod.google.com ([2002:a17:902:e30c:b0:290:28e2:ce4e])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cece:b0:292:fc65:3579 with SMTP id d9443c01a7336-292fc65380cmr74528845ad.17.1761172157403;
 Wed, 22 Oct 2025 15:29:17 -0700 (PDT)
Date: Wed, 22 Oct 2025 22:28:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022222830.634086-1-wusamuel@google.com>
Subject: [PATCH v1] Revert "PM: sleep: Make pm_wakeup_clear() call more clear"
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 56a232d93cea0ba14da5e3157830330756a45b4c.

The original patch changes the position of pm_wakeup_clear() for the
suspend call path, but other call paths with references to
freeze_processes() were not updated. This means that other call paths,
such as hibernate(), will not have pm_wakeup_clear() called.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/power/process.c | 1 +
 kernel/power/suspend.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 8ff68ebaa1e0..dc0dfc349f22 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -132,6 +132,7 @@ int freeze_processes(void)
 	if (!pm_freezing)
 		static_branch_inc(&freezer_active);
 
+	pm_wakeup_clear(0);
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
 	if (!error)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..b4ca17c2fecf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -595,7 +595,6 @@ static int enter_state(suspend_state_t state)
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-	pm_wakeup_clear(0);
 	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
-- 
2.51.1.814.gb8fa24458f-goog


