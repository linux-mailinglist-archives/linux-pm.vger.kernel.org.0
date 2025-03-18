Return-Path: <linux-pm+bounces-24253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D74A67565
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 14:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8741899678
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22820D4EE;
	Tue, 18 Mar 2025 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szg2DAS9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D120CCD7;
	Tue, 18 Mar 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305252; cv=none; b=WDTrIadE0nd1wv0djXMDucldEsNHStH1SdZWWA9N+B9b2/jVRlRT1IVq5MrJTc1rmSFnglBndMPwVFnXGf+P6ob697KcLIsgjaZNEDf8MyFVyayPJtFuiQfMqc9HDV0ZVs+Y9H7ZsOldOqeH9yh+EVT1mgZX0LKSvoDMlN5fyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305252; c=relaxed/simple;
	bh=fioJBHLxwt19zt3IPljoDiJm3O2rwT5l4qmonVFLYQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aCGIH+nY+oYNTkrCXtaBYGt78nM4k4eRRmEgQAaUYLUb8Ofq7Cq7UE/SAKpiLGsCy8Hf8Xp/119cvvX3xdXUYgKv0lKGB6OeT3ZN2HQIQ0dE0lJwIK8pWSh10ka64hn2elUJrxOod9ljHBj8JM7xPVHWe4OHtXJ8GAw0aMkN6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szg2DAS9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22435603572so89918665ad.1;
        Tue, 18 Mar 2025 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742305247; x=1742910047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZj3KuC03PFBqju3wnCkyQiTc2XQbkQIR4Z+AXZ4ih8=;
        b=Szg2DAS9tQq9NxVENuTeZjEMbb8o7PJBYgjJOHox2yJeOlmOqAZCE4gro6HHpEtj6p
         4s+scpQqPgFs2XeZnhlmbi7sgheBFpP92B8K76H99lpLPFm2PN66y2YTT+gG/+EUfN8f
         VcEsVFu9SoXkBQBmF/Wn04RN/8mpYOIP2e/tVHmawO04FN8nu4ZrYAt8u1NNcqZs2rW8
         RHU8ZCAD/b5tZFVO94qVSeMWZWKDC/FJrcEYdOssTpT3lERWSgsObuRFR1o92f5ox4AH
         oMBepDkI8zjtXsHt3mXsYegUS4GhVKqSCahNIYM632wJPCObFIE1UV/yFN+mdwSbK6JA
         6ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742305247; x=1742910047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZj3KuC03PFBqju3wnCkyQiTc2XQbkQIR4Z+AXZ4ih8=;
        b=XOsIyedZfTsM3/QReio9S97Chzm2XJK5kwDrhdZsOevZHyyL4u5EpexCzGkI6UjOeR
         7Hgg89Rouy3Jqk/g0dRJZL1Z37NxOLARub8iFTu82gNm/27JmFRheJDvF0ZvjDaVLVj2
         5S146xq45lsX3SHe8wvF8YAckslXc1JedTSZb21JHGbfFAA+pqRjwl0IE6eafMlfBKOP
         2O0vs0lFkbKq8GW2DPDp+iwsTMvam/i+RdYxAOrTxWPx9DAK00LpElhyfacdHEq1Io6H
         NYH8VH79iubJ0/nyyEGR6TI6k5rAGN0nwC9+UZxfumagGSJmPc1QWMZv6aGKtbaEI4eR
         c2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLwbQ2NmU/efBobAwoWu/ITBeLCxs9QyxZ1ZkD/H4v5+eFMjfn2BqWUAdbwP02ldjs17eav/r6yqA=@vger.kernel.org, AJvYcCXxz11k9zv4hu5Dy4NwDVs7NsNjJ9/8VBZ0ZHqqr40puwNwzHCsrDCNQC7Ny3HuwvTMM2LscE/xs32XuG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyDmlbPfEQOX2E+AKmPayYtTQeDFqSPVBHNJs+hlfw9uZKgK9
	LU63oNFcIl1bV9zTc7v3zzm3U4FNM0cvB5SHhWou4nY6BPDSXkXs
X-Gm-Gg: ASbGncvA6FLZB1aFQoscpL9mcyDb60Zw1ODg31uYZz4ogP+gkbTG3+6oVLaqef9LzCX
	vlVpHg1ZV0jV1q1YohJXcaROMELKrSvQEbBhsQPgb+otvOVESY4RKFBasP2CjChGyp4ifyfoIkJ
	CM+oHEPprzcUHreB5eWBIVCGH0hEGhW3lJJZcV9+1I7QZDOQoJTUV/oibf+ZSIX35BBrzB/4GbE
	2U+J+jvOZVZZvGDXk2mdtlIXgdNGTtqGniK+ygxFmdEaQk0PYPeSNRwVdV3G2gKo5DvunWSjroh
	FyKSbKutKJiqn8F8qV8K63szZCjP+cQEcrU520mHqRBuFnAkjDvSWaldiHuivUmJ4L/u
X-Google-Smtp-Source: AGHT+IG4tDji1GK1wb+fgDYp11lB2kyT2SCHhxUNKyzbUpBipTdms3Arj0QRQHVNT00u8FD3uJMu1A==
X-Received: by 2002:a05:6a21:6da6:b0:1ee:ce5b:853d with SMTP id adf61e73a8af0-1f5c1336549mr21452548637.39.1742305246821;
        Tue, 18 Mar 2025 06:40:46 -0700 (PDT)
Received: from localhost.localdomain ([183.242.254.176])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-af56ea7cac1sm9029751a12.48.2025.03.18.06.40.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 06:40:46 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] cpufreq: pmac64: Add missing pmf_put_function() calls
Date: Tue, 18 Mar 2025 21:40:38 +0800
Message-Id: <20250318134038.16759-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix reference count leak when pmf_find_function() fails for one function,
Add missing pmf_put_function() calls.

Fixes: 9a699aefa87c ("[PATCH] 4/5 powerpc: Add cpufreq support for all desktop G5")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 74ff6c47df29..9a5a4fca27f0 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -412,6 +412,8 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 		of_node_put(root);
 		if (pfunc_set_vdnap0 == NULL ||
 		    pfunc_vdnap0_complete == NULL) {
+			pmf_put_function(pfunc_set_vdnap0);
+			pmf_put_function(pfunc_vdnap0_complete);
 			pr_err("Can't find required platform function\n");
 			goto bail_noprops;
 		}
-- 
2.39.5 (Apple Git-154)


