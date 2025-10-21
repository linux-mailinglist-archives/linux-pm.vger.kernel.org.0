Return-Path: <linux-pm+bounces-36560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34CBF6178
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B0919A1495
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD432E731;
	Tue, 21 Oct 2025 11:37:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480323F424
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046672; cv=none; b=pRjRZPNkcHoGY2571oJoqtiPkLvtt7xHMbinIjbDcNMOc5pSBG76s1ixJYp6OoGmgFQ6VLqTy90igoasPWbOJERXfgHlToCFMAhYeF7pzcJPu3zuGdhhMxIQ7ENyw2nJAvgDBBImXKjl/Rc6BzGViM5xJoMu5XUVOoYkLQuvcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046672; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQDx0jJEnwzlTsmTEhhpkI8mbzCL+JBHVt/dcbGB6gieIVbwoSePgQ7hhcaQlZ0J6zOjokttgTwjE0ccRgsmfitfSO63P+f91tv32DQXoOELSNWJW+U9Q/wAxumyZ+M2Jb+/Ghi0zDTTfHhmQbA9JUVk+xUG9LDXTgwTuhCU+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so72767875ad.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 04:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046666; x=1761651466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=ZCCBSFFdrDkiov1R5FZeQ0ixeu+MusaTXNc261ixxxpiqqNzHXM4TV916gzExa4AHT
         SxZ59K5YjkgYTp6sLqmS7u6OKc2eTYg5L1qcbDWjRcqSc+wXv+JIpa/ETHFynqa25pOR
         opAy9veBmbUrCuouqpZchbZ4plhAI6lTysZtVJ0PNJnQMGXmoxaI8hCQ+Gz0i40qVGzc
         igi92qw85tODjs26Dxa4tSDJgPaE3XwTs6GRbTWxfm8WUIo9n0GsZTX0Dv0+8ALUK01I
         6AmErfg7FbxZsjWYkp6mjz3/TFhd/uCDkqdOTfp3fngA5VniSwlh67JouBUB8+8wUMIO
         PkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsZmNxDM6pjCWTDYkiu7qVzYLwLHodrk8v9kW5+vzocUpPdikLjjuAAfCtztTUFCCxiG6waHsgzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxliNJA56wNz2ibdh5aW5onvlHeS9v3H3SZg57lhiM1bv7uC2
	LQcKr4wIjtiIdMIT8BSVorMWqc3+Jil/rUCPM8Ax9xeIepHCZicUWBMvhnbHMY5lSoHmxw==
X-Gm-Gg: ASbGncv5EgY2jAjRNRO9nvvanQKpb9DRJbRAfg1TjrIuF6+ePIOocY+16dM18qbTUC2
	ZXkGQwUgE7Coj30paHbiJLUj/70KsD1yukSjTWzvmTM26mUfqgoX9dvf7IwsatFT5/801Q5M6R1
	0YI+K4s9qmVcX9jZ57XO6T/HnqP8GKW+0to7Vdg+eu9EI1H6eesBV8S0PFjU3KQsuBRTS/FgGcv
	3f5p/M/CTZ1YgjTvk2IDFveCJ+f1i29WTznMG3MvsXDTPtmiwsBEUcKRcHP4owxWr01FaC2sqQy
	YPiGZPLJaXV1X2+IUbErYBccnp4k2tpkuRUo7fvRwo3PWCveGkYNBDwy5uL+bcdYL5bx6IpwxVY
	sQpQmqLJIxALh82Jr2g5+jSS0Gf6y9bT6av/8QGW1HnaiFZJCC/M6ZcqUgOUvFlnUPrbGkkKi5h
	liGvRJIVAtvF6ZMam8f5ATR/A=
X-Google-Smtp-Source: AGHT+IHTW4/gF6OgIb2qlrRgINO+x1D8thSVStMWU5wqlHnByPzRDAXjq21hKuIf9on4YFT1CpZNcA==
X-Received: by 2002:a17:902:dacd:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-290c9c93c25mr195327565ad.6.1761046666417;
        Tue, 21 Oct 2025 04:37:46 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm107138825ad.54.2025.10.21.04.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:37:46 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 1/3] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Tue, 21 Oct 2025 19:37:26 +0800
Message-ID: <b5db63bb95729482d2649b12d3a11cb7547b7fcc.1761046167.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761046167.git.luoxueqin@kylinos.cn>
References: <cover.1761046167.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert crc->unc_len and crc->unc from fixed-size arrays to dynamically
allocated arrays, sized according to the actual number of threads selected
at runtime. This removes the fixed limit imposed by CMP_THREADS.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 58 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaaba..f8c13f5672ec 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -585,10 +585,48 @@ struct crc_data {
 	wait_queue_head_t go;                     /* start crc update */
 	wait_queue_head_t done;                   /* crc update done */
 	u32 *crc32;                               /* points to handle's crc32 */
-	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
-	unsigned char *unc[CMP_THREADS];          /* uncompressed data */
+	size_t **unc_len;			  /* uncompressed lengths */
+	unsigned char **unc;			  /* uncompressed data */
 };
 
+static struct crc_data *alloc_crc_data(int nr_threads)
+{
+	struct crc_data *crc;
+
+	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
+	if (!crc)
+		return NULL;
+
+	crc->unc = kcalloc(nr_threads, sizeof(*crc->unc), GFP_KERNEL);
+	if (!crc->unc)
+		goto err_free_crc;
+
+	crc->unc_len = kcalloc(nr_threads, sizeof(*crc->unc_len), GFP_KERNEL);
+	if (!crc->unc_len)
+		goto err_free_unc;
+
+	return crc;
+
+err_free_unc:
+	kfree(crc->unc);
+err_free_crc:
+	kfree(crc);
+	return NULL;
+}
+
+static void free_crc_data(struct crc_data *crc)
+{
+	if (!crc)
+		return;
+
+	if (crc->thr)
+		kthread_stop(crc->thr);
+
+	kfree(crc->unc_len);
+	kfree(crc->unc);
+	kfree(crc);
+}
+
 /*
  * CRC32 update function that runs in its own thread.
  */
@@ -719,7 +757,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		goto out_clean;
 	}
 
-	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
+	crc = alloc_crc_data(nr_threads);
 	if (!crc) {
 		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
@@ -885,11 +923,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 out_clean:
 	hib_finish_batch(&hb);
-	if (crc) {
-		if (crc->thr)
-			kthread_stop(crc->thr);
-		kfree(crc);
-	}
+	free_crc_data(crc);
 	if (data) {
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
@@ -1239,7 +1273,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		goto out_clean;
 	}
 
-	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
+	crc = alloc_crc_data(nr_threads);
 	if (!crc) {
 		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
@@ -1506,11 +1540,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	hib_finish_batch(&hb);
 	for (i = 0; i < ring_size; i++)
 		free_page((unsigned long)page[i]);
-	if (crc) {
-		if (crc->thr)
-			kthread_stop(crc->thr);
-		kfree(crc);
-	}
+	free_crc_data(crc);
 	if (data) {
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
-- 
2.43.0


