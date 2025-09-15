Return-Path: <linux-pm+bounces-34613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AAEB56E46
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 04:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC3189AE6E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 02:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512ED220F5C;
	Mon, 15 Sep 2025 02:23:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BCA927
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903020; cv=none; b=IfeRjB7R6qIoSqE3X1mpFKDj6SL+tKZerREqsImmUBUBM/mpwxk8+YfLQ1VUbZI7dwDyfzRtyKrMnBv6pvc2Zh0Z3mJYaCQmDb9joPKzkT223MtJvPDkOe/X0JzHRSEd7nc1+YOKBG5ouLRDSr14S0bix2CHlYP9sk0mgTCXMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903020; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh/1nMTcT3V6XgTo7g5XPcmm8w2VT8xI70gQ7lUi43Zl6sinQzGQhXEGvgwO9vY+vcxNBcyneBtXlYgkSjonEb5KY61n4jHcjv/YwACpDl6tbegO/AnuVlZPlntWgfTM64ANzso6TYUKH47nnNB/B9kPyBirLHxkYq/ruEKy8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-32de2f8562aso2919183a91.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 19:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757903017; x=1758507817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=gdlbDKENss0W7ZKKm2urETMS1LOhlVllf5YmZ6G2v0cHZbTiMhIfLY3ntMJA2ZF9de
         o6OKYTpvy87dklbZRsf7BPI/AElIqfmVZNSmcv7UpQSsObvYorPoSKQ3gzIFTQJKu009
         iYjo5kLG+wEkT/xfwK5HaPn168pVc0H+CDrK9mH6S6tyALcH/FTgXzDoVxudFiM/TlJm
         eYbdS01cMunIMJwd4XuQ7/vIjuKIzmTEBAYhiqo9a18AaijrfnecwtP/kpec3cfjbwQn
         6Uol71xCHF+OP39cieRt6IO6qe7QD227kdM3p/7qTFohIgHJ/kbW9De80Uqi0uvNsYfs
         gx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHngbdgUlFDmjmR9nUUVN2CM0cCK0k8Sg1Pg466p5LNHTwZVla3hTTg/rtnKdldw1//aB2hCLf2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPpZun35vAZHL/hVcEmhy3IP48WpZyLA4yDvvtNuCbDalLqS5
	P5YPAil0zqOq0Av0Oeeho2SeUNslsItdGE7vXYWwVnduMYYG4Ie7wYlF
X-Gm-Gg: ASbGncuYBxmf79EaAZewATobIpLX2DqkZQGE7N1DHye4AEwzMT3a/2n7db4U5wx1gAa
	iziSOYMoeNRt8644OMF9g1OiCpVtvjpxr2E23LBE0Mp6XGm6yaViXnAu9rX6H3GNLzoxIOpuLjC
	aPk2PdsX2y+IxLb0S8cj9zt8z21/gwkiNCxv9anTHkoAQ8LwU6hkrEZT3sSRaMTSxoc6XdC02M1
	RW/VOYtygIgeIzztXNslAxr+LXpoqgAxRgUMlTpOObuBj0wBA+XU3SV5SnyH28bCuFSGmuxYDWJ
	05nROoTAXk/YVzLdaMMIDb7dRHdL77okV5vDYrg7QygfuKUrgxoQjJwl5ANpf+6L8oA4sfZQGUp
	D2iNALsyKJvhAemRyfhVFfc7J67pp7bN5d3CdKWMqwgOFMlDXubOOsns=
X-Google-Smtp-Source: AGHT+IGCzMqjyIxY+q9axKvsWCWGBNWWCtm+onfNcg3p7CY3kXX4t1UCWQ/s9984z5mMtiLmvvhrnQ==
X-Received: by 2002:a17:90b:4b89:b0:32e:38f5:e875 with SMTP id 98e67ed59e1d1-32e38f5eaddmr3605344a91.14.1757903017266;
        Sun, 14 Sep 2025 19:23:37 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([39.144.194.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37005a82sm2969607a91.16.2025.09.14.19.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:23:36 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Mon, 15 Sep 2025 10:21:24 +0800
Message-ID: <1bd58d2398ab79a9ecdfe239d6097051d8606724.1757680816.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757680816.git.luoxueqin@kylinos.cn>
References: <cover.1757680816.git.luoxueqin@kylinos.cn>
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


