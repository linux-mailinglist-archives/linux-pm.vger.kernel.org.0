Return-Path: <linux-pm+bounces-34443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCFB52B3C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0378E7B98C2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D042D77E5;
	Thu, 11 Sep 2025 08:10:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C12D8774;
	Thu, 11 Sep 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578233; cv=none; b=q7Njsk+IpY3XPUa4U1NysxjSYOrHdwtunzCF6KdVM3eFDv0v8CkBKyDQy9G5doMOcPUW2xM9GKy4otBCpLdyoTHoNjkA6pYSim9dvbgPwysJfwTAYsj3GqIeZxQ3L1PdIrOTgOOdVEmNQY4UL+4unmcBRDOcaL6er3FV+tBi+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578233; c=relaxed/simple;
	bh=8XXqdXfPe6eWtsQlvfmXCzjN4ohaMWABdqQKsH/HD+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi6qNshtItUJDcd+fkD6LYqZh25YTHjqEoNos18q8XOdJf7XagPqrye+hXLX8jhIUV0ZrrI0XLsHEwETaVRyh8AlKut0eb1UJ9LY4CCryRa4G3YaQUjN4h9UOxNhnIZboUhUMPsUrVIVEMT/9qQROIKdY10/jyoFFinZ7ouCuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-25221fa3c9bso12408745ad.0;
        Thu, 11 Sep 2025 01:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578231; x=1758183031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+08KUqZSRhNIhJzyo8CBa+9NHM0qanryXoG/IYYe2I=;
        b=CCYgjj5TrmwHqSqG+L4706I0BZxTwRWdjduThupsIOw7p6DCgRN5SO9OR+8sLjypku
         xtt+IHaGjhw1wuPDRVGXpFdx+hPHrQ7XvPIRrayZZC+t+CFit8Z/lc1khHPM3+CGBl6z
         Bz953lXKd+z90iJKfoQYtyg3eYR2Udz8b0X9q7PFJ6eUzM0tBFA0dizZlXbc8YI97iaN
         EvIGlBMdkLzB8At0kmFWwQj6QPKNX9M88VrdqJo1k/+9yQA8QtF6ggSergSIG/BIxWQ7
         UVQPp2UOeT/ciUqKmuLtD/eqOKA7WPsObvjqZ9nylLtDIIK7jmsvQ8sBRe4FuL4MMsuA
         CZig==
X-Forwarded-Encrypted: i=1; AJvYcCVcp10PyqCTEhUp0XumcVL6G6SyRDYq7r6CFoVvppgLUCk7J6pLk2z7eYgWlOaAUC0IFSIwfmIHetg=@vger.kernel.org, AJvYcCWsJVsetymmpbRxyOg51hKYT7tXRO+2EkCPO7C+1CTIubK2ije6mz6nXmOy3E3rIhgLcgpy3mVNhemeu4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsp+VRPfgpRkqLEBHN1xhDQG5TR7XovDpSmLMu38O5wWCg3E8D
	5Wg07Jn+ZrQvvr0YVn5Nvm2MAFwbXN+ILtnKxPAHlL5RGE3fyWMBjjNY
X-Gm-Gg: ASbGncskGmADWi7q50VGjgY81z7CGSTxyBrS01Awmvnd+MCbCMEOM1FY2RpGD/34ma+
	VPwLhFdW1zu2LLSslAcW29AMvsii6dUHOc9QlJ6hpUwTNuJUfzpLT2E1h8Zpbfnfk+3SYEyqtV2
	R5xEhpSZ6gWKQ4YJyat9niLkibwamwySpIv40dlukuqwmIoHRggcsF2H1fNa34XupLMleQN464d
	oKwOeRofcsXpdFgx+njgshptXnpYCQjkt59Eoh0s1/sAly877OVzDcquro+JTec/jmJGfILBW+P
	kbdkTh19lk+qV2yswBXbm9ka3+x3OJba/QCSQv6ykPJtUu4pPp46lWdjpQ7vobgBbJhuwMnRyA+
	uih9sIGv/IjgZeV2Qmdrs7kJRHUvjJGD743FBzWyyGUfJNw==
X-Google-Smtp-Source: AGHT+IEY/3/qFSoSXZTdy4dss/0vPhLEGYLy8mBFQiBp648JiB/Y5hcZqmGb/lWb8JIaUEsQT0SxWQ==
X-Received: by 2002:a17:903:2f92:b0:24c:b571:6f70 with SMTP id d9443c01a7336-25bace93a20mr28437475ad.15.1757578231099;
        Thu, 11 Sep 2025 01:10:31 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc5671sm11129925ad.22.2025.09.11.01.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 01:10:30 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 2/2] PM: hibernate: make compression threads configurable
Date: Thu, 11 Sep 2025 16:09:51 +0800
Message-ID: <b512fe39fc6c03714fb23bf241f9e8d4b6be4ff2.1757577879.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757577879.git.luoxueqin@kylinos.cn>
References: <cover.1757577879.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The number of compression/decompression threads has a direct impact on
hibernate image generation and resume latency. Using more threads can
reduce overall resume time, but on systems with fewer CPU cores it may
also introduce contention and reduce efficiency.

Performance was evaluated on an 8-core ARM system, averaged over 10 runs:

    cmp_threads   hibernate time (s)   resume time (s)
    --------------------------------------------------
          3             12.14              18.86
          4             12.28              17.48
          5             11.09              16.77
          6             11.08              16.44

With 5–6 threads, resume latency improves by approximately 12% compared
to the default 3-thread configuration, with negligible impact on
hibernate time.

This patch introduces a new kernel parameter, `cmp_threads=`, that allows
users and integrators to tune the number of compression/decompression
threads at boot. This provides a way to balance performance and CPU
utilization across a wide range of hardware without recompiling the
kernel.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index bd149a54c081..bf17363ff331 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -519,8 +519,8 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 				CMP_HEADER, PAGE_SIZE)
 #define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)
 
-/* Maximum number of threads for compression/decompression. */
-#define CMP_THREADS	3
+/* Default number of threads for compression/decompression. */
+static int cmp_threads = 3;
 
 /* Minimum/maximum number of pages for read buffering. */
 #define CMP_MIN_RD_PAGES	1024
@@ -703,7 +703,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
 	if (!page) {
@@ -1241,7 +1241,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
 	if (!page) {
@@ -1703,3 +1703,19 @@ static int __init swsusp_header_init(void)
 }
 
 core_initcall(swsusp_header_init);
+
+static int __init cmp_threads_setup(char *str)
+{
+	int rc = kstrtouint(str, 0, &cmp_threads);
+
+	if (rc)
+		return rc;
+
+	if (cmp_threads < 1)
+		cmp_threads = 1;
+
+	return 1;
+
+}
+
+__setup("cmp_threads=", cmp_threads_setup);
-- 
2.43.0


