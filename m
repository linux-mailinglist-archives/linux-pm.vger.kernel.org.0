Return-Path: <linux-pm+bounces-28433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB146AD4949
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1977B7AA40A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4A1E1A16;
	Wed, 11 Jun 2025 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnjG4C/w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DC19F487
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612287; cv=none; b=qoKr3l1F5mGeUlH1SO1AtCjU3yihrRAgAzZY2Rf554OlrwPJQv8kgb3Oo/CNEIV6gEuh3qegAwhHOQFFnKKtRtkcniHQsUjDuFKf4pl6Tj0UilzxAZJ19hSgNT1Cspnh7n84osi/tB2hrTYdTOCEe1rq6HXAefHxL6TCudbNU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612287; c=relaxed/simple;
	bh=j+ePvqnAutgeLU5MULZtbIumcifABsxmTIN8lzY8TOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atbqj7eSXv4eUQZqfkfLKaav5k8QjfdDg+l6YEHjofqrgnMQpF91r+Oj5878VW07bPMxorsZjFuaUMU8C34eUDtDA6PzMzGqhTvN9YNPVON8j0zhrDWlKUzK2YmbfTN4Cn4vzmgInnLR5OFSwqFnZlOe+D/xqqZrTDQvg/NsA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnjG4C/w; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so6551165a12.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749612284; x=1750217084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOyoXZgjAzV3jRvTUuLc0gCfF0dDBZTV6Hidyj1Qbyk=;
        b=KnjG4C/wyb/ageRFPfAFrTchNSzWe16p5iSyzYiGZSxSkyMyQ64Myd2sXp84SwCxHx
         CC0bX0UXsAhz15e2RaAgOn4u1bgzb3UVhJzAxtM1MGa74DwiuLwYtd5rHOlJWHCjjKoB
         Ubev7qoSFteIzek3dyFoIUxMnn3ZHE7u310DUF8iDe8PvpJheqLD9R4CUwBD34SuuwxP
         LNsuiJpp+RRWyMoVJSozYnmu+94wNnOIFgM+FSBkuTvkw5+vF4jj8drsNI8vTGWcsvqU
         ud6yVU8UR7XWgtL3rXiuuFO3yDTS/Bz8UkU+bVQZk4XKh+PUautpaFYRiXhhyYF9DHP0
         fQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749612284; x=1750217084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOyoXZgjAzV3jRvTUuLc0gCfF0dDBZTV6Hidyj1Qbyk=;
        b=HZTx86d+MZ0xenp0CKS/W0xHqGWFYcTHgQAHYumyokuHjNVdro1J7SD6N1pHiQyDMd
         92GU7qBPEn14I91zLGrtraUIImqri4SAPUKd8S9K64JA7YOFNIN/8+ZVy15dxAo+JL0Q
         bPynjuBIJTYPMbsDstpoEMvsvKCWqoCh7IPfOVmDF+WUhBCFaMUEippw8jT3Ueha8zIH
         7JUw8x12erfoolXS7UVspYXo9TOX5E/0402Ac2N6t/jDV8wkMEe32ZqbjzuBv741UY7O
         YiIC4zGFkfGDN0ufIjryCHUk3m1zac5CnuqIgY9bS8Yiu0oWmmSVTK7Vqpwbk1awnw5P
         Z3Nw==
X-Gm-Message-State: AOJu0Yyakj9OA+W7KVdmbWPu5fKtdFMkHWaww98iUI+mMxhfyLsr2TQZ
	YsNRosWzeFk7bFqKtfGi5nGcsrkCVNO0A71rKkZk5PXDEpKlSDaVoigB
X-Gm-Gg: ASbGncuhrwCKg5dGfFLdaRCEizrYu7aeN51b3sJFdZBQw8v9QEtj4mvm79rrpHD8mlc
	j1MNn2pygSZfzruaFM+3FCzticd5ux5VHL4yHcyk4a7fxhyJeuJwbk0jDyjkqIU+kh6Aow4LsZ2
	L94Ww9VeE2kewHuvecVpUgsnQih5WpGDIVOyybxVu10yHT23BBIf+M7wdPXMblJOsV9u3WHHsaR
	dBUAsW0XwAf3cHWxg9V2WpLVs4jS0YbW078oBlL29WUe29+ahfd8c/i8PO11QrfRKCgjxr668ux
	Db1H6qHrtkInUXOpzcmLqLwMtmAPCSkeWgjDicQ2bnzIIST4z3QdIPELTM8qkoiZxUbg/3w=
X-Google-Smtp-Source: AGHT+IHinudkZRB1IaXdp6cZvyrp96hEeGvuMC3fJT60VOjtVXC2DbtKMlqIGKasdF4ql6N5REVPzA==
X-Received: by 2002:a17:90b:3950:b0:311:bdea:dca0 with SMTP id 98e67ed59e1d1-313af23396emr2727838a91.33.1749612283862;
        Tue, 10 Jun 2025 20:24:43 -0700 (PDT)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b2009c6esm328606a91.13.2025.06.10.20.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:24:43 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [RESEND PATCH] cpuidle: add tracepoint for s2idle flow
Date: Wed, 11 Jun 2025 11:24:38 +0800
Message-Id: <20250611032438.10895-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tracepoint cpu_idle in enter_s2idle_proper() for tracing
the s2idle enter and exit events with a determined idle state.

Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
---
 drivers/cpuidle/cpuidle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..9dca6a63e4ad 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -149,6 +149,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 
 	instrumentation_begin();
 
+	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock_noinstr());
 
 	tick_freeze();
@@ -174,6 +175,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 	start_critical_timings();
 
 	time_end = ns_to_ktime(local_clock_noinstr());
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
 	dev->states_usage[index].s2idle_time += ktime_us_delta(time_end, time_start);
 	dev->states_usage[index].s2idle_usage++;
-- 
2.25.1


