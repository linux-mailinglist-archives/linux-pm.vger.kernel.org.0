Return-Path: <linux-pm+bounces-34442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E2B52B3B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CFC3A4C17
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19962D8793;
	Thu, 11 Sep 2025 08:10:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF22D663B
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578225; cv=none; b=p33ADZIRjnZW8vXXBVNp+BWfW7Z2X5XHo6nxAK6Ezopwb9toC0vCpeckNt978aqeneYn5AzSzt41BU28yBUpMrlV73vgsxRIZdMJL3UeJrjQFasROjzA/KwWqwC8qfhVdOKXcwHmm0eG742RVtox4zZb2f1OjFHHZTdfdXMfAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578225; c=relaxed/simple;
	bh=ExUU+pGBfpALU11Z5pEd1vR0hoXiz55jE/WtOaShvMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX+LRdudsYw89LZx9RFFmDVQt+63fCnbjiiDOoSu8lUrs7pSherkzcAClS3vekO5EQHVQpEB2ifObBZirWjytvp022yvseUIWwgF5j8TBZIgECpe/Q43mb+9ay/1UuiTMVUmKS7BVQnE+Mw+QfSIXfL2gnotze2G1bXxuDgUUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2445826fd9dso5154835ad.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578222; x=1758183022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvA6blgC4IX6hj9NKO9nOSzXLhviVfQZFwPkL/QABho=;
        b=qSBxtUCsKCPbFGuaLl409tVtH8d2NNITPsHYRxQY8YARnnrQmdkMR8wq7ZuZ0+LtUC
         jz1z36+Tr4kQUexcTpTXQDtlSYp/Z/dRTqFDcLiqsA3Mb8AtdrNOus5Uv6wmNHEy9x9M
         1vIiJRbH7rZZMhbCq7BEEXpoxSl+fLbvMe4SK7pdDIRpBUk/IOT4Qe2NnCm2PrhJ/dDi
         PeqTC2H4KHbkclnlZzg5bnURLXo0EpknhfWTwr/QiQ1PhumDjE+VJmH2SrGtvn28TcyI
         MyGIYPDpnzyx8fNmkIJRKpCqgatL6etz4ciJIrm9sKNeQFC0SIpWlRB+T6ZBp1f1fVC8
         VvNw==
X-Forwarded-Encrypted: i=1; AJvYcCUIK3Nw2I4X7Ebf6wDX9aRpdUPiVWxlN29G9KtMPNIUzULj1ovbHU7FoVqzW0nYFr3BB6Ssjto5qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxbcBQvYGzCTeEoTS07SNNfVc2I/v2C9zaHxwx2zEzLxejMV1
	GJaiX59C4f67clmC/x1W1AYtVXOzvqNo1id2G4y1TYrVOV+/8+c43gG6
X-Gm-Gg: ASbGncu6nyk7LX56RmixrxtMxxdYuKWm3KWpwgwi15EqkoozQ08htOYyEoHMpD1wfWl
	WGUbmSeY4GscakaoO78EBvxZmnnA+A9Hq2D9viDhUR1e9DsCOBsszzs+2Rm2uLuGSzJqwK2F3wI
	Yb7pCvM8856Fm+wGzIx1tUbX4lNj1WkuRHSviaLaRSMptL5l4+5ze/9RsrejK6H/REB4M1MZeL0
	gmRrzhfCX3PtELRsn/0cwAoZqBS469FCyVqnFcxpiCt17vHMTQ+RnzpoJfeCqKZ854BoPrvG1wr
	CKmiMFUI50wZtX53h8ShGPZJHiyqrLlr81xWuc+lUjhhpMi1meFXpWpj+GRHd3iV4SLToJlgnkQ
	npEeNTZKmAtf1Do/sTR1a9H4lskPTVAIRAO7uGp9iruClmvoKtlt9/o9V5PBPBTzthZ8=
X-Google-Smtp-Source: AGHT+IEazcvj6u3pgAilsxX3V6tb275sE9wo2VIGekxnEjbg5FCeyDwj2jKeAT3aOOHRd55yYAmptQ==
X-Received: by 2002:a17:902:f550:b0:24b:270e:56f4 with SMTP id d9443c01a7336-251736df030mr234774675ad.37.1757578222320;
        Thu, 11 Sep 2025 01:10:22 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc5671sm11129925ad.22.2025.09.11.01.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 01:10:22 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 1/2] PM: hibernate: dynamically allocate crc->unc_len/unc for configurable threads
Date: Thu, 11 Sep 2025 16:09:50 +0800
Message-ID: <86d4e558707e7b03c248ef67cb76ec635a875d9b.1757577879.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1757577879.git.luoxueqin@kylinos.cn>
References: <cover.1757577879.git.luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation uses fixed-size arrays for crc->unc_len and
crc->unc, which limits the number of compression threads to a compile-time
constant (CMP_THREADS). This patch converts them to dynamically allocated
arrays, sized according to the actual number of threads selected at runtime.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaaba..bd149a54c081 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -585,8 +585,8 @@ struct crc_data {
 	wait_queue_head_t go;                     /* start crc update */
 	wait_queue_head_t done;                   /* crc update done */
 	u32 *crc32;                               /* points to handle's crc32 */
-	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
-	unsigned char *unc[CMP_THREADS];          /* uncompressed data */
+	size_t **unc_len;			              /* uncompressed lengths */
+	unsigned char **unc;			          /* uncompressed data */
 };
 
 /*
@@ -721,7 +721,21 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		pr_err("Failed to allocate crc\n");
+		pr_err("Failed to allocate crc structure\n");
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc_len = kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL);
+	if (!crc->unc_len) {
+		pr_err("Failed to allocate crc->unc_len for %d threads\n", nr_threads);
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc = kcalloc(nr_threads, sizeof(unsigned char *), GFP_KERNEL);
+	if (!crc->unc) {
+		pr_err("Failed to allocate crc->unc for %d threads\n", nr_threads);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -886,6 +900,10 @@ static int save_compressed_image(struct swap_map_handle *handle,
 out_clean:
 	hib_finish_batch(&hb);
 	if (crc) {
+		if (crc->unc)
+			kfree(crc->unc);
+		if (crc->unc_len)
+			kfree(crc->unc_len);
 		if (crc->thr)
 			kthread_stop(crc->thr);
 		kfree(crc);
@@ -1241,7 +1259,21 @@ static int load_compressed_image(struct swap_map_handle *handle,
 
 	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		pr_err("Failed to allocate crc\n");
+		pr_err("Failed to allocate crc structure\n");
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc_len = kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL);
+	if (!crc->unc_len) {
+		pr_err("Failed to allocate crc->unc_len for %d threads\n", nr_threads);
+		ret = -ENOMEM;
+		goto out_clean;
+	}
+
+	crc->unc = kcalloc(nr_threads, sizeof(unsigned char *), GFP_KERNEL);
+	if (!crc->unc) {
+		pr_err("Failed to allocate crc->unc for %d threads\n", nr_threads);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1507,6 +1539,10 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	for (i = 0; i < ring_size; i++)
 		free_page((unsigned long)page[i]);
 	if (crc) {
+		if (crc->unc)
+			kfree(crc->unc);
+		if (crc->unc_len)
+			kfree(crc->unc_len);
 		if (crc->thr)
 			kthread_stop(crc->thr);
 		kfree(crc);
-- 
2.43.0


