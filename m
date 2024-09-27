Return-Path: <linux-pm+bounces-14854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D43998808F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 10:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB6F1C21A6F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA964189B85;
	Fri, 27 Sep 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoV6gyWm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823317A597;
	Fri, 27 Sep 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426518; cv=none; b=lzPY9rduxyD1H5FBQy0tU9T+7lbBE4N3LyTxJRVXa8PPZyck4ywA4MIpu6WYjaKNZIjSWdmAELpVpeClHT/ejJjNldxbQ6YazvuuccZ8sLyJlLMuYa9BlFGJTuBekXiwhvo2oXBmRsNM0/JpvJNzV/tDOgPpCuZebVBVpT6JYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426518; c=relaxed/simple;
	bh=ytV+RKWr16EPZnpm5vSULbyMkvu+gR0uEaxOU2ESAeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2tcJLjLJ2sFHqsq6DSkcAbZ3alDLwQ9+eHCE4Ikx7vmgKLFEXYumgx07AqXYzIkVwxWnRPJG87v2SFFSnboJy3hNlaxzQ7mGPESmAUBIXRY18IZKEu+liy7l1kydtbhWPgK2A4dFv+ftnkY6Cj1Thbfqg72rqolhpzh30InVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoV6gyWm; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e082bf1c7fso1412780a91.3;
        Fri, 27 Sep 2024 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727426516; x=1728031316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17j1bSIskFw7QaKC5zjWPgo0WzP70In6+YzSESXBkrw=;
        b=OoV6gyWmrOp/wKIk9sqjgwaH6ZLI2byxh7d76dNN+G77wNIbWyXHWE8mcvBN4wwk2r
         XRidqYwgpq9TTnLPF1m7mCGiJfCtoKbYAm/1UxYXY/pw8+mP3V+5IuPPTxrj8VzxxVBH
         FCGMxeSHNdMjXEbru28ZfArCyN3HP0GU8vdObNvQRKL6KNKXgRCk/P3H46SRZ5sGARx4
         pZYFwjmXRRFLzeoD7+tapDhOgbBOFWkUVR+425+SoE9C2Ux+kww6ms/GuRa7xGEPiEu9
         2XAc2+0OsOoJb/hj+wSETqGlZzSWc/Gd1JS7L/Hm2WDKWb0U/U2w2buzlpWe8lfVEBnX
         Xd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426516; x=1728031316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17j1bSIskFw7QaKC5zjWPgo0WzP70In6+YzSESXBkrw=;
        b=Jnz1OVmXnDMPEMpvfw1BkzOGFMgqLwurC7QrPl5VQMZufgl1whMbks1f9dI2DLm2Cy
         RSKlCQJ38Ne5TPBlNcibLp9zEDkYGfQ7T7TmwevHd5tSvlI35BISUreATm6B4asNbMf7
         0OLvLQgiwN9gi9WQh0cUsWU/62ueBI/9tNiwR488cqsl72ebEMyQBvgOsHRyEvU2MZLb
         vZQqi1TcfwFGygyBCbNqFk+qtmPsfDL8hfBm6pOLwR8SuEnPrZsvftnByacWzdypi+50
         Q15FwakVIUJMJm31NTUt1R8noDgu9cGv7BrL/pTQ4F2jLYXD8GDoYRfeZ3h/JIHpjTg+
         m/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV938jZ8VcjBSDawFuP2zUyNk1qV7vK1F3jhqPtv3yHgLU7cdJYr2+75RGEgi9LsHJj9+mk/r8fKv+mh7M=@vger.kernel.org, AJvYcCXRAkDJjvR5oB6kV0xFWpFLCatqs7aTYa2sHHYSUoJYZbUkmx8iXcxzNfk2QtjXC/U+JO/tTS7y@vger.kernel.org
X-Gm-Message-State: AOJu0YzCm/mmsPsOG+u50syuQhHyQoS7hojoBI3+t8VJQuR/DGLkyc1/
	d6KejX7o/P8rgE+WpGAz3FOCwRaZ62Mu8SfW4uZj0KnEzGu0RSPf
X-Google-Smtp-Source: AGHT+IGVauw5rskXtchfvjLWDwu4I2nJZYoxuqzvTcDMdlGrzH1o8b7kumnQvYBHNLq1gTNMti7uxA==
X-Received: by 2002:a17:90a:ad91:b0:2d4:924:8891 with SMTP id 98e67ed59e1d1-2e0b8ede168mr2650912a91.38.1727426516430;
        Fri, 27 Sep 2024 01:41:56 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1ae708sm4975371a91.13.2024.09.27.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 01:41:55 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] PM / devfreq: Fix atomicity violation in devfreq_update_interval()
Date: Fri, 27 Sep 2024 16:41:45 +0800
Message-Id: <20240927084145.7236-1-chenqiuji666@gmail.com>
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


