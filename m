Return-Path: <linux-pm+bounces-35931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F7BCF325
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 769574E2D5A
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4167257AD3;
	Sat, 11 Oct 2025 09:38:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D0257846
	for <linux-pm@vger.kernel.org>; Sat, 11 Oct 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175524; cv=none; b=ZYEuEu5aMV5LCbnRCvqx6euxgpPfTtYF5fBZQU/EK5MfQ6Xhr92tCaV3u4tuPxl9mPQJceAn+GF3o3CrCcLQUjTfIG1BuAGapbBn+J376lv+MPeV3kbfR1YKp0RaQdo8AaCAyLoNGjXUQKCC/Fy46wOJ5O5p0ECSyJdnRImqUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175524; c=relaxed/simple;
	bh=bTB9DzoWH3QIpeBu4xYDTQAzXlJCXk6gbv+o+fe1N3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/F3LDDjDXNgCOZXEECCd9Af54oFPQCQv6DpxGkFc1T9XukllOdAOoIhP4uBXhEQK8BSi1PGfuH7cyHhU1xJNxTeWCHQrucxDQqi7/miRZ9oPQEdBnHgjgk5IepJe3l/yGhkK1Kt05E9bFroQyRz94tEnqae2Ni9/XUXy9XdOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so31742295ad.0
        for <linux-pm@vger.kernel.org>; Sat, 11 Oct 2025 02:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760175519; x=1760780319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVV/uiMu0xHtlKgwsYx2mXd0JzCW14CDL0hbQStIbj4=;
        b=jW2Rvuhf0HzDwF6bOsNbrY9rf7eYnVQqdhS9d4P5v5Ao4AqTiPdTlDj6CMHzGcX+7B
         dq0GjcRURF0UYlLH3IyjTd2p0NptSyHBEp1RoWG5DBNYb5frTYft0qFUNESj7ylLEV9y
         hiG+S2oKEVxYqPc6TGbWTtliG/Nbt/IlY+/LRHIW9EmfduylJeaWx6HrSrjcm99XXHa5
         ybyIBm5pSZc/8m3RMWF1XppUDx5E+c6psH3pyHoZBHgUXw8SbKqlzgrejlOtC+PggT6n
         oCyTD/ckskIF2KRMcr05h7DCBFwx5ADgBS/5ft3Wl53cZcwk12hk4SykcIN2fNw/y0vR
         LH/g==
X-Forwarded-Encrypted: i=1; AJvYcCVNRIuATvCI7Zuowuk6WnGC2/Nz5RusR1FP3hDllM3pMTR3J3l0Rgf+oHe9o9evQuxdfyxTi4/tFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxhUyphzlzD8AmqjvSYlwapMA4zBT76Rm1TggHqHYvfIQCAGs
	wyCfi/1VDlNgFz3yuvFaAVETG9BPioAwfO2K9Czdxp39hTJSB3UPOCOg
X-Gm-Gg: ASbGncvpaZ94AsaxqTdzB0braqyxDIbh17eRHBPgMuaCJTdZp4Lvgnhtylvf4GESKxC
	wPvtSmviRe3QEpjslLODb81rGzVAvJJ61csT8tMx+pwGv4U8by/uxQG/e5w0D9zhP90m4BS2cAV
	bRIJ63iGCaJDAoOaRQ14C/QnHph6NcCAk2gjK6TeGiJe8QFKfylJlUISlOodxyjTvbKftxrtrr9
	5ES5qF7uqu8i1+prCNNIkWez0c4RE5C/yNYx3sfy6Bn069MHrMwz92FD9rWL2LkLyUJqvoFunTk
	uvfaelJsi2fo50KyfPINaJp8MLckoehp/kA0n/IPF6rL5f/TZION+NaATAr7g/FFGYdUfoDUIGk
	jUep25ioBksegCUNEatpDfPR7lAPDJeiPF63Re3b9Oz/Nx5IozXOaUtFulnsdO+8y
X-Google-Smtp-Source: AGHT+IHpGLpU8M9LjptzuKQ5BOFJfe6J4j9z7uO9gDV2SVJTv45LojULgBTU28zYulg26XhrRR4Gpw==
X-Received: by 2002:a17:903:3807:b0:269:4741:6d33 with SMTP id d9443c01a7336-2902737a672mr193197825ad.23.1760175518554;
        Sat, 11 Oct 2025 02:38:38 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6262df70sm5663168a91.1.2025.10.11.02.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:38:38 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH RESEND v3 2/2] PM: hibernate: make compression threads configurable
Date: Sat, 11 Oct 2025 17:38:08 +0800
Message-ID: <1764e5db50a9e6a7809f0ec59a7b59e66c1f155f.1757680816.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757680816.git.luoxueqin@kylinos.cn>
References: <cover.1757680816.git.luoxueqin@kylinos.cn>
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

Introduce a new kernel parameter `cmp_threads=` that allows users and
integrators to tune the number of compression/decompression threads at
boot. This provides a way to balance performance and CPU utilization
across a wide range of hardware without recompiling the kernel.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f8c13f5672ec..dfa9b7c0f96c 100644
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
@@ -741,7 +741,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
 	if (!page) {
@@ -1257,7 +1257,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
 	if (!page) {
@@ -1697,3 +1697,19 @@ static int __init swsusp_header_init(void)
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


