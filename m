Return-Path: <linux-pm+bounces-19145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F99EF104
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360F71898DB8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881022288C3;
	Thu, 12 Dec 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePv9cUcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A1222D58;
	Thu, 12 Dec 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020183; cv=none; b=Y/FaTVdgnbSsEFmeO4vNkL0lFs4mu0C5BQ2qlfao1h4ZHHP9b+ANVqfo5m0vVU7Euso7gRL0cX3fGKjFF8XpjwSc7CbA3Bg9JLFLS0OK8VZODdL25/dQRF58pBgjHHkv9j10zU3LityxCMDVbVAiiLCS74c69+nDAdhF8JoOp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020183; c=relaxed/simple;
	bh=TjGodR5hu1Gx6t7hM03aocyeOSrB2pegLpifR3VHwd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=og2Mz+oHz7/A/az8Zj0ZpEMgHBo1frZkav1sKJOvJG5Wav4Wa/EapBSTJHXzj4R47fxtnKuQR4jvPqs4mtrxWTEmgh9pDV9KMjoEYUbdKNgB7RRprABBdWNGMfo7pVLPo6FBmYc+MBXljiXW4BF9Ti1Nz+HW6Z7YDIzFTLMfxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePv9cUcY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166f1e589cso8611945ad.3;
        Thu, 12 Dec 2024 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020179; x=1734624979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhcbENBLvyiywWML6Td/u4lWtS/ChkEco8wP+66XFfs=;
        b=ePv9cUcYyJC5VM7YQUrXam7sKOBco1NRnI0JKsKdLHTFc6DBV6K5oJISHnpm2kjmMm
         ptn7SWpHMQSryLtjNxduNmWVu4JoY2yyUK7IE8UHMdjhHkGb4LX7AWvHBIzIixFjjfF0
         IPedGditaJdC3Aca7M1Yn+hzd/XlJqpoOM7iCiATGOiyAuOXmVBiuBQJqlkzV9l+yu9S
         /UF58MRk5BKXwAZUItMsVR3WQqYT0D//mcAkZCRtSn4ryPBBr0rgChtIaMXmXHSeDDoE
         nNH9bkEqSDcHxL0A6osNrNRw5CCo39ec0HBsZGlNyLpIfHGROCVpN7SsOWkVBOLb5B+r
         yZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020179; x=1734624979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhcbENBLvyiywWML6Td/u4lWtS/ChkEco8wP+66XFfs=;
        b=SIgu7PrURb6eob+JY5PL1oQ957IDxIh/MpIvH0dAQtETvsPlJVz6F+s76EUEwXVMwk
         Whw1XCh7VCM0qYKHSumz1kI5eQ5FleS1wzqAXrt407ZVOEtbgQAS3Qw/oaLRuYYLm03i
         8Favup1YniJvR7wKo1iEyKRtertbUwiuT8to+c36WRWYd+t+IIsckk1hIpzRws9G1h61
         EYSeWmaRcS9qt8OK+R392P4qtLyS8GDcZkqCvS9TQXP7U3vzqMI5kxyNnvcRUFrMjbdJ
         hIvjCo8aSlK5khf2m3Uve2HPhAxPOeb4tN20y7lzmPCV45Q29z7pddLPCG0K7r9B/Sd4
         3PRA==
X-Forwarded-Encrypted: i=1; AJvYcCWAk1IxQRRa2cSE81WNzrmBvpxtHpq4bT0wfLZRl1PB9UsPAt1NHsw4IFYR4wqXD0HAZBye0n3lmN2PLLc=@vger.kernel.org, AJvYcCXvrsSghDKtuQq1BB/oP7PUGQPKZeahcDQ9k4s4Ojx6PPJFLnQMLKr3ASr5sZ7KKrrn77hK6KMKA/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4+LjekEcoig5d9UUxF3I3f4uaX7K64GPJRqSVCMGuEawwVnG
	8nmNpWM9ElTQ09NKZT4pF7JIF1ejU6GfhvzHcHAHxWe7ZgScDABq
X-Gm-Gg: ASbGncuvu1tDh7OcFH6gleLAv4bx2ZMVZ1IugiaRLTlw4Endo/RFsbZZPZfp9MetBdW
	Itmj/9pNPvXg5pNB2+mEj6RMW15w+v5DjzsB91P8cWy8ZhvjgJJAHvb64zIeSiInJRXUCbnI2Eb
	yiwI1+4jaHJSSftWJ5RDHfi8WALzL1CAIPV0YqcdsomdviLGr5R2zKlqXhnTe+HeDSXP6gbJM7k
	qbLPMyqEi8qC7h6ZiHcdDnch2JQmeWcOfER0ss0XCCzTd9XB+uGnh1eUyhvoisC
X-Google-Smtp-Source: AGHT+IHEUWdru1Ja1yJorUunulqsObj/yJEncvR3Tslnwit0r8PnlnPLzyb9G4POrBy4PJ/RnSlv3Q==
X-Received: by 2002:a17:902:eccc:b0:215:5d43:6f0e with SMTP id d9443c01a7336-217786a9b73mr118702355ad.41.1734020179166;
        Thu, 12 Dec 2024 08:16:19 -0800 (PST)
Received: from prabhav.. ([2401:4900:883c:16bd:f11e:c756:2c8e:6cf4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21630fee27bsm90295755ad.269.2024.12.12.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:16:18 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] doc: power: Add missing parameter description for memory_bm_create
Date: Thu, 12 Dec 2024 21:46:08 +0530
Message-Id: <20241212161608.24730-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the parameter description for bm, gfp_mask and safe_needed
for the function memory_bm_create

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 kernel/power/snapshot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 30894d8f0a78..690dd1f467b9 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -680,6 +680,9 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 
 /**
  * memory_bm_create - Allocate memory for a memory bitmap.
+ * @bm: Memory bitmap.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages not used before hibernation (restore only)
  */
 static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 			    int safe_needed)
-- 
2.34.1


