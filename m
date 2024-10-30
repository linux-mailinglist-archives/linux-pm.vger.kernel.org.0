Return-Path: <linux-pm+bounces-16701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4389B5C01
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B94B2212D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD91D278D;
	Wed, 30 Oct 2024 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV/Cq4NM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8FE1D2781;
	Wed, 30 Oct 2024 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270984; cv=none; b=SrTcTy/W5E7Y0gLX6GsuCC6Q4uvi3sFarePNy7B2kSEXh33mrYwhXEeQGQlpQEryS26p/9q3D8+iHtmzZXaI3LYiCI3kTEsaKV2CTgN8P2s5uKrtqmICxgwb7slOhDO7xzx13FNKffFiZuO6uBCX9sZG+NneQ1Jo58yHaHUy37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270984; c=relaxed/simple;
	bh=N+bvHTyzJU6MGrUyHaDxxgZLQuhGQZuxN7Jy5KqlAqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dT00yCDTXa4b/Tt9ZjgrHdYqYpoNWW45oCyONZ10h1lTS22X7Oq9Lj7dCHQyhsA1BwCzWZeljYPV8qeJlPjf5/O52PLmF5D49beA79J+CtpUNpNZ0pT7KY3wYXDbykyOQ9MMtlQkVzpUyIygHtOgtckO4H2o2dYYBfpoVJ3/voY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV/Cq4NM; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so5092469a91.1;
        Tue, 29 Oct 2024 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270982; x=1730875782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJLRA9hKd8P4WBkPOOsNo6YWjtbaOCHONHrwdMEReBc=;
        b=PV/Cq4NMHVkF5d4V3ryyrSqyelE1f25OHR4ppNjnFHlPjRr/7WEmTcsM3qhwTmU32A
         fYECTdKuOVwUzQq5MTIJbN0ozgB7clKXgA+qPqNcPXpxtPmFghPKWgYLAt5lQqWz/V7C
         UGY+j9qH8LzXHqYTpBHb52J69ylELXAlz57yM1F7SSSs0kuw2ba8e3exhOAA5Z1pyY64
         u6SaEuDrGwMrvtTDIjUeNvNLYbIdVfw7UoXGg+yk+u2/9Uf5CqTie8WOt+o0j1WB1fN6
         TOi1QejmdUrj2GQkeZscvWpugsKBQ69p7w4wnh00GMAXuKnWByXbqhqC6oLDPRNuTWc0
         /JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270982; x=1730875782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJLRA9hKd8P4WBkPOOsNo6YWjtbaOCHONHrwdMEReBc=;
        b=LOeiTU5LEEuZ/MhDD1a9Yd5R8nWNIxm1FVyKMNfpIHfDlLcD47JwJSIJKGM8KJU+nX
         uawQuxipUgi3fpwji0H9OZtSQ9InqlHtVid/tBktCtylPlEgRNoGfbE87C4w79EYu3Uq
         sq1fM7NX+CbLsq1f6CAJteqFYdm61czPIJELU3OXr6c3Z19cvcLb/6uAUC0PuEEizrLd
         yH9FHj4BP8xCNkxdNN/MQ+nFgvq05rG5Dl3PzwqF/g+ZhWOCAUzFT8ZI9ZfEz7xtx2xg
         h1HvF16ELd/NzLZsnmPLHXs7jKkXJWVAnj1yi23fsGKThY8bXOjEGxnliBNvE7MRK+Yx
         j70A==
X-Forwarded-Encrypted: i=1; AJvYcCUBYahcD0gva0TwSg+wyF6QwvPUyxl2KBMPxm6X5wHYClsOfiqX3XhMA9jYRwPhSqFGW4j5au6sAEHnjMI=@vger.kernel.org, AJvYcCWb+cSzhiBMAQD2mgKv+2i4i+DSVXjQkBl7vjBHURZ7DictpdDnbGQwEl+FkWHa9Jv/hmrVWZ1y@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMOe3sSjzazUM285/vW1g5cc3NyA1YBQ3rdxSZCa86hOSARKV
	AVX8KrSLCD/XVUbbNmhq2uyY0O7Jxan38xH62wJgL/9NBkgixBtgp/APxTmyDz35zA==
X-Google-Smtp-Source: AGHT+IFY5IujUBsk9J3uMO2aqVAVQ/7oUPd+gXProoXdiguw8eys0SEB0ePmmL2irn6tPl3AgfkBeA==
X-Received: by 2002:a05:6a21:38b:b0:1d9:1584:9131 with SMTP id adf61e73a8af0-1d9a85349f7mr15597105637.50.1730270982100;
        Tue, 29 Oct 2024 23:49:42 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a21ccesm8647717b3a.167.2024.10.29.23.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:49:41 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: Fix atomicity violation in devfreq_update_interval()
Date: Wed, 30 Oct 2024 14:49:28 +0800
Message-Id: <20241030064928.6180-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atomicity violation occurs when the variables cur_delay and new_delay 
are defined. Imagine a scenario where, while defining cur_delay and 
new_delay, the values stored in devfreq->profile->polling_ms and the delay 
variable change. After acquiring the mutex_lock and entering the critical 
section, due to possible concurrent modifications, cur_delay and new_delay 
may no longer represent the correct values. Subsequent usage, such as if 
(cur_delay > new_delay), could cause the program to run incorrectly, 
resulting in inconsistencies.

If the read of devfreq->profile->polling_ms is not protected by the
lock, the cur_delay that enters the critical section would not store
the actual old value of devfreq->profile->polling_ms, which would
affect the subsequent checks like if (!cur_delay) and if (cur_delay >
new_delay), potentially causing the driver to perform incorrect
operations.

We believe that moving the read of devfreq->profile->polling_ms inside
the lock is beneficial as it ensures that cur_delay stores the true
old value of devfreq->profile->polling_ms, ensuring the correctness of
the later checks.

To address this issue, it is recommended to acquire a lock in advance, 
ensuring that devfreq->profile->polling_ms and delay are protected by the 
lock when being read. This will help ensure the consistency of the program.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices which can idle")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2: 
Added some descriptions to reduce misunderstandings.
Thanks to MyungJoo Ham for suggesting this improvement.
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 98657d3b9435..9634739fc9cb 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -616,10 +616,10 @@ EXPORT_SYMBOL(devfreq_monitor_resume);
  */
 void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
 {
+	mutex_lock(&devfreq->lock);
 	unsigned int cur_delay = devfreq->profile->polling_ms;
 	unsigned int new_delay = *delay;
 
-	mutex_lock(&devfreq->lock);
 	devfreq->profile->polling_ms = new_delay;
 
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
-- 
2.34.1


