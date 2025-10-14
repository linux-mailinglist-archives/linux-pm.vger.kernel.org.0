Return-Path: <linux-pm+bounces-36036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6ACBD7D85
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1C014F83B8
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26622BEC21;
	Tue, 14 Oct 2025 07:20:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A230DEBE
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426434; cv=none; b=FCNcwkxUDM5/pmSPCLOMW/cuHlLUoz8F0K7z65S78kGWAmPQWh4uGkuH71yF6Ak+LVp0sBJ0ZQqDTS+934EzzERd01yu6ks/05QE5dcPpoz+O0uXONNEcJ9LT0ySTGaHStApm+eJjbPZ/o2UdMqCCsTO7FwdL9DMBUvfR1Xdz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426434; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmGQ1ygFIjdKgnuCujhZen00/AbeT283NlMwJ9UPGl1o/PujwPCqzW62FPw4t7E7i7P3vUgau5P8D45XdU556NDX64W5+c4XT7DeieNGoJSyF6wSLGq32ylhTxUUxWypUmO7O+L6xSJPu6zs/jwa5Yynten+LHbg2EFD8bGtKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-781997d195aso3558940b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 00:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426432; x=1761031232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=NVGX8FQ1sHCGEiclysSiyRF/jfl0HtqnRPt7fD03/vEgDFylDauSxT/NOh4YOsVRtN
         AFCm6AJ/Vib+IyDuzKstX3o06q4W0bklJXPmG3k1GYHdDkPJKlYzd/jWiTj+xbqlc+kT
         vMteDdbHAxICcKwnfre7Ll2L+1Hq2r3bZlTEHzsBr1kULav7/qTsT7ab55LX0JQ0GWVZ
         4XTq3PbD2YTe/uKqYiBuUvpbZ3vEdtixKe3j9+979wXxjxoKks+bmTQ9DO8ZYId5XQrw
         lgxl9UJubXUp8C3VQ3rLzukKBD3Zahs+eBOyhsTm9R0xFd+d2nrXFDs380hCos3W/vUW
         BSYg==
X-Forwarded-Encrypted: i=1; AJvYcCUyEmmVRE6DR8hXRt13c2q7rkX3PFu7z2mjoJSNBMTikUZefAKEIw8reKgFpyO0Vw6BBqQvoscScA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYY3hEV4o0ghFlzCV2jHh1iRz5MhwxFU0GAT0FUuRt2akoW34+
	zbs8RiofY6wkhtfbJ744j15MP5kY33o63g5BEnCQ9Q/ce2DS0uPRsLsK
X-Gm-Gg: ASbGncuDe/+iEmoRy1MSHnHlVRV3odJ79LcZPp1iYjAFH3g372lNXgfzzlymcStgQxK
	hjqmcio8EtyF2kG98E7S06H9QOa6ZprYWWCh+wH4S7iszMBSVuF2LsQjqdeg+Sj6vUQStGb2cu9
	BwdTcMZxsH1B1KY4ENjb6Mp43SCX7XtK6AcPJsXRXtlRrclWwwDvO+EQQn+pIychbIkZF4SbbVS
	kYKPlz7L62fwJ/OMqvSkWdjZraRC2VX8PDfB6rj02QQ+9ls/ZXLmGGNBhKD7O+FXb6K1hP2wkIg
	UzV9XJv1YOZZgK2odtieJ4/PzTDvrvA68mij7RPHJhuh6U8ueM8FCMLvosa3a0GyXoUhEIJBHoK
	VfqFVlnKFNssjZBdqw5JGR/Gh+dlJvhlEPYozq9X/PA4s2IgU2qtc1NVEMIatMI3cLJOEE8gsVJ
	E=
X-Google-Smtp-Source: AGHT+IEw3WpKRLPky5hGUBO5huOhqVNP1ah3SMKVxkWxHR/Z2RFXVp1UIm3gDbOY2/fxjjj/eCNjwA==
X-Received: by 2002:a05:6a20:6a29:b0:304:4f7c:df90 with SMTP id adf61e73a8af0-32da845fb34mr31580352637.50.1760426431693;
        Tue, 14 Oct 2025 00:20:31 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678de09cb3sm11937092a12.18.2025.10.14.00.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:20:31 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v4 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Tue, 14 Oct 2025 15:14:17 +0800
Message-ID: <b5db63bb95729482d2649b12d3a11cb7547b7fcc.1760423687.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760423687.git.luoxueqin@kylinos.cn>
References: <cover.1760423687.git.luoxueqin@kylinos.cn>
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


