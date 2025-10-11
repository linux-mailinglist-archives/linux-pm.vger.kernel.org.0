Return-Path: <linux-pm+bounces-35930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B2BCF31F
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 11:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A454319A15F8
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB12561A7;
	Sat, 11 Oct 2025 09:38:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D620D4FC
	for <linux-pm@vger.kernel.org>; Sat, 11 Oct 2025 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175517; cv=none; b=g0OXADYwltaGOgV3HA9LT4O0ct13ICUha4CKG1tcfcsqeuXrkw84LoV6uPjLvgvoc/8Yz01b2GBJdWPMgAeXuniQhsPVc6/0EELc6MHa9WPcOurWJEVnzh+2trZdMcGstyQOYeVJidmgHM4E7reyPTQwis7sgg0rpUFtwFEJ/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175517; c=relaxed/simple;
	bh=aCy2csDSH4NEvv662sDoSXSiwfuvuDlxu5yKYcovueo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPB6zIbXejUl+5SdcUiwM9fDCJPiUWkTQhOMBhH/DlATaddZ2dT55U1krUnb0cx8dYhnPGb4kE8cy5XaLhtJXbQtfpjeuQMT1fdVD9WB7b+cK6tlYxkbCXQ2blXqO/1OUO2IXJA4oPHNrmRZqDGs7PXPhk10fO5Z4wguvK9lB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3306d93e562so2908844a91.1
        for <linux-pm@vger.kernel.org>; Sat, 11 Oct 2025 02:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760175511; x=1760780311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7DuRByH6tRMefMdlYheOmO3l5XpqkwYrruxAOXY3Ks=;
        b=VbWlk+FWSUTcc6//oCtH6Ka1YdS0GMc4ZLMyqR9dNzd4IFgGjRiZeuli3KAs9EKa/0
         gmP5Zl9sW+UTdwEXB754yaPdtvLNzW/yGJw2Ed+pCXmK9B4abY9KL0PQKqfRbZvXOb2Y
         rrNlPAKNQ7C6u6YBsBat21yY4ji6dfMrw5xA4tZwhr4yh5bw4ZZ7Rbj+VWb6YuGumeda
         YatYAjhA0X2lFvwabY4bDwRgDta2NMz9e3HhioOYiLuGeBSg0J7izJc8hj3gIZ9UsR+D
         7BNuhm0DR+A9jY8bX5BpnRrd2BXAA2pt+HAOnGKAymTmCO2sZbaH5xCOeFDPCkwAfvgS
         lZCg==
X-Forwarded-Encrypted: i=1; AJvYcCWkUPW6Gq5Au9RRlRda6OmEDzVwHdVzcAdRr+DL5w4x/hPLZGvKSIAou0MoxfNPVCDg3emrXo3m4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDcpTnbpRlR3m89MOwuitTWz4xQptlhQTEgBrtmaw9Yf+Wv2n
	nSh/aFnPJNnmwuO09NDxsNY1dMYxqipvFT6SUdyfMO3HTjV5O1V0sVb/
X-Gm-Gg: ASbGncvmkHS/6Noqdz7d5Gqfr1s8sFUbVgE/Kcyps6kds2xXg/OMMndXefNOFeCERJN
	E8K24Mr6Jyi5V1uqR+cPfMZc8t2+cRJHVpLHgDuyLW6NOEtv7wqOn/xTu9/MaYh/Pm+U7AY6l2C
	MztsoLaXjgHrXcMkRzC9CMcXY2sQf0i1tbXvhCMyexvzmFybAqjVwi47Q2v6QHQKagan+qk+wpm
	J/uJgqzrBqo8KeUSQATClvb4RysiyzjJ5EJ5MJ+Fcy7tie9SQyvHhRmYngs0tmgoh4yUqNv0PE3
	wglQNnDefU6zj5CLX7dfOBE8wp/LBxLhmIfOMxZqe7T+bMpq26eNEwVfSZnC//FNS3Ml86g1PCe
	PyCIIvA1OfqOlcabAGGTUwdoa43j1Qa8IQg+f9/RlOuchkxhPZih3rY8OXhla6Oe9
X-Google-Smtp-Source: AGHT+IFiEJTgEZ7gITg0ltZOAeTCgaHrlxDzUZUaCp1bwW8p5kR4VlJsyoL6nwGwLe7Q6nTphvU0Bg==
X-Received: by 2002:a17:90b:33d1:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-33b51149673mr21624129a91.1.1760175511334;
        Sat, 11 Oct 2025 02:38:31 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6262df70sm5663168a91.1.2025.10.11.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:38:31 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH RESEND v3 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Sat, 11 Oct 2025 17:38:07 +0800
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


