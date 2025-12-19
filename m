Return-Path: <linux-pm+bounces-39712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD4ECD177C
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1BFE307FC0D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2734B415;
	Fri, 19 Dec 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdTInSxN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B734B1B2
	for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169935; cv=none; b=jeGupnQ0pOj0XX0qbEKhq+h8C4aUVuPkSn4BJJJfKGAi8ekGpaV457+wt5Z8OI2uPsxGEE8poNB9ksc9TjfBVotc8RPZY7EUfuPCCVdOhqFiiqZe/a6FE2BmLHWkNfmQ3gAjZxSy3QOw9CQO6Kr75CcMvuSh1xylb/xDl4CkqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169935; c=relaxed/simple;
	bh=MTszl3Fxs1tXM+UBY05RwWvNC18neY6eriaRlQ/JnRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCdIniEgrv2upamFA0FZIeu0Qy7llIjFzLF7E3m5/HgqioapDjJvSI1hTIw2YrL5ipdQcdEkJtDTm2gN49YkpkDg2MOQSdAYHdkR4CX9KuxJ/oJ4pofmh30wRKXHykz1OnEHyZlcN2fLp4cygJjyPTMNK1hR541FJ9s2URgje7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdTInSxN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a102494058so15788235ad.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2025 10:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766169932; x=1766774732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYlvN5caouTLQVLlVh+1zVVRUvcLyQcfYMgpd8xCt2E=;
        b=BdTInSxNRuFdXvEJMXbDz+3PzIZ98icI8Bs5t7fGY/D5rhOkwARa084YU8asVkNWlc
         3dqWZiMUPM8iz4SnKhtZ6S2+apgtmZs3eBY+a5yxkitFc7MRzHkcoopgKDxlABeE456U
         YJqnTEyictte350AmRsKPNpORjlpS8T4jahR/zZF2Y7PM9it+X3b4OST23edFRpUupyR
         tDFbpQB+B0pIMBSV18JJ96+aDJadCFbm/8p0vZLxFZROiJfAbr0jYXcKWPUB80STC70/
         XV+I0SIvrSKtVkWLSzwlL0HaSPJdsCx2FfLuvR1p8mJ6v5EPBmxy42vbB6t/RUgYbnxe
         QJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766169932; x=1766774732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYlvN5caouTLQVLlVh+1zVVRUvcLyQcfYMgpd8xCt2E=;
        b=Fc2q/LUYxkhbFfWVXlWSplg6nlZu8xY1RHgxXdi8Z7bEMkfuuDkXR9wroj4OMG2diz
         6VBDJtK+AP5PZ87z6mbtTvt8ObIXes42pkZYWxj79cPPIsen4RxdSlT52QlI/GTLbgw1
         rRXBKEOOUWhaoLnai+DE6sRryDR8PKWSBF8/uwvUaQfEF14x5naqJV7NsnC4eyu7lJEY
         P9+ME0NKNjnv7HHs//Nuuh3zY7CvgA9NcwJydtK7bJclFA7Se0ZnVBaOZpCmOjpn1RrL
         bkldlpDFpYGCnH9VS9CcnW/QfWwyR+r9AhNLNDsFPtLMSlhv8YbaCbLXXkzu6Pxqbh5G
         MEaw==
X-Forwarded-Encrypted: i=1; AJvYcCU4QEH91tyMhLvRG7nW76tRr5TjVxF3euSMdG8K/dvuVQ2s3wpFYfnT/WkRgy1P63RYUOqxZR0v8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTl4us1BPjupFmEapC6Z4QAPprRMK8Ssct8fI66a72TfA0AFe
	lewi1um1urv1oes+TlrXl+ybthghDxH3Q2YA+h4TNUL7Nc/qJxlcmkHn
X-Gm-Gg: AY/fxX6Y/cLGKCOGSwjTs/WJVYfahT8fwSc28vHeo9KPGPmR/imSWsMV5UD+AvVv4n4
	AJotvZXkupd3AqIacDjW9oIvmlXlPHTwDNLPstl6ABxArkGoghWbkO4HPwAXveS+ikc4bnI9lXR
	NkRbl8iEH4jlee9zFxKntBZf2iToNouUd+6K+/y6rERFMvH2a4RBCJAL9lzU1WQTPdKYichXNqN
	plGGMciMwt5tIrwGM9rcSKp1nAW84xaksgIGpJPQuJ7ZQraAYPWjEnwYbpiYOX6xld/PuZtv7og
	scGyNqXpEYXenlN/veldT01BXiQ+peADjjvgYYSBIFa3tE9osYYK0SxWdZ9OY4kiy5+tGA6YDVT
	9o/q5vyll9K5wrYlHa0T27OsB3F+eIWjmaLHgU8TsIHHXEOE4PK3S4G2WhOd1etl38yVQGold39
	p/mrcbS5lu8W808xM=
X-Google-Smtp-Source: AGHT+IHIvGucl5A+PQS92+Nx8WN9qI79yGewII6uMKzH9vwvTy9exW5L96rmrJaQeeLr6SbrD1ssgA==
X-Received: by 2002:a17:902:ce91:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-2a2f0bce9c1mr45379125ad.0.1766169931918;
        Fri, 19 Dec 2025 10:45:31 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:f73a:ec78:7a89:892b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82858sm29019665ad.29.2025.12.19.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:45:31 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: daniel.lezcano@kernel.org,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: dtpm: Fix format string issues in log messages
Date: Sat, 20 Dec 2025 00:15:20 +0530
Message-ID: <20251219184521.379599-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix few format string issues in dtpm.c file,
- Extra trailing comma and space in the debug message "Registered
dtpm node '%s' / %llu-%llu uW, \n". This unnecessary trailing ", "
before the newline character, resulting an illusion of some more
message available for this under debug output.

- Incorrect log level for subsystem initialization failure message.
There is an error condition, not informational, and should be logged
at error level for consistency with other failure mssages. Changed
pr_info() to pr_err() for this subsystem initialization failure
message.

- The same error message "Failed to initialize '%s': %d" has missing
a trailing newline, which could cause log messages to be concatenated
incorrectly, making the logs harder to read.

These isseus affect log readability and consistency but do not impact
any functionality.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/dtpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 129d55bc705c..2179f5c0fbbe 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -406,7 +406,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 		dtpm->power_limit = dtpm->power_max;
 	}
 
-	pr_debug("Registered dtpm node '%s' / %llu-%llu uW, \n",
+	pr_debug("Registered dtpm node '%s' / %llu-%llu uW\n",
 		 dtpm->zone.name, dtpm->power_min, dtpm->power_max);
 
 	return 0;
@@ -582,7 +582,7 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 
 		ret = dtpm_subsys[i]->init();
 		if (ret)
-			pr_info("Failed to initialize '%s': %d",
+			pr_err("Failed to initialize '%s': %d\n",
 				dtpm_subsys[i]->name, ret);
 	}
 
-- 
2.43.0


