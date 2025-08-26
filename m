Return-Path: <linux-pm+bounces-33103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF0B3589D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 11:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7D21898FF5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10727303C91;
	Tue, 26 Aug 2025 09:19:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79F2F6593;
	Tue, 26 Aug 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199996; cv=none; b=JvMnnt+06iHBoozAHg92ij9C92i6T23PyKDmAvG7RuF3h5zmssagft2EyDgnSFAJ9GPeGRCcYnCQg9OdbiLhxiMcxRpGsWBpnVbIVeiQax3xk4EHSRQZ4fThlX8+BCgXZF5qLwa3jw+c094ua3xRQOviGWh+EDZkR/ID/YJmQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199996; c=relaxed/simple;
	bh=cSVhgzXTN1fIYCAwVwg103cSNkVWu7dW0EFjmdAvC68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iu71Wgob8CAP/vY2QnsAdzdbimwzNelqznJ8nzknopEJxvXNLlJ/yWxJigYoZqhNH850rSxzJRmcESgP0nnglvsoTzUD+2NPTg72O1N3EF5rCTxOr7YOmRuliT+qlILwmqCxsd+d0cbnmf4dioCeS+DsEVr9TvYJA8FixEcbtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso5978974b3a.0;
        Tue, 26 Aug 2025 02:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199993; x=1756804793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiotA2JV4z/aoaoQuJaHJfZjyCmN/l/UIOVo8YNVBQ8=;
        b=JeSlr0xMxOC8os6X1dhDKGj2zbcpyvTLOJk9Knwu/ZGmOYoruhE81A5j/NXER3LteI
         HpxFe3Y8XyWiVnIhQB8xYeF8J/rmZ+FjLe7XcdTfREDfrSSOxQx2mr6o3GIAyMtYRcWS
         26KL5DflpiW/8D6yUh333SX1rjgp5MMzxs3EZNt/13zY8vEWbEbTeutlaVWPI2fCoA/J
         rHhQyfMRsYd4fCKzfioqxlFyA5v57D6/QqZH/ctP6Z+v3zkFq3P/r5dHDF0Kt8IRbbBF
         Z8DkrT1zj5hkQKXlTjwiyEzeFH1RtgSqCrCvifEBnuRwX8ghFHpS0fucA2w+5LzJlSI+
         Virg==
X-Forwarded-Encrypted: i=1; AJvYcCWS3zl2rk+8h1LN0LvA5/Mgv8KdmETqsJI6sGprcGtpqP9cQYZ5ZHvg5pi7bn3SXV+EJoL9VYypwt1jcBI=@vger.kernel.org, AJvYcCXYeBAxQ6c3oJmSYAGXrsMaC1wSHOPxORL07lfIg/U8j/GVOUA8nsEPVajDGp+qyKqu6KNU/gzF5vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrWJzVRYxmIgfWn4wIOuP2ScMLEm2742maHTK1Pjzdrt0edEd
	zH/XZNL+qAqd4jHKJUftb3Zr0a2F+uyLYLmSJZHTA2A2emOaqn4v7BrfY3n2H+Z8TCs=
X-Gm-Gg: ASbGnctSX+iuRuuC3bwfb3DtLGbU+1uVjflyXt9JaAfz0QSd/LA2yHGwV4/Qo/pL8rh
	g2JB52mGsvcPn1d0+t6MmgmhX5hXWeVZ3tXNp2GOtvyyAFxI3HYtisDbgCRDDPfvtSoOVIuhbq+
	ca7ciPp9INQ3OCltI9tbuYpe+WOro8wZKwSKzpP9L/d2QgsOe4jNaLLHFL2E+CYAn/Lo0Cg1wKc
	li0iRWCVabv7PrcGXeM9lxRpmEPsEV9+haFbZKytDIggG6LXFlAsrvArAOFjGQmfgy++8XtOC/r
	ByQQGMgmMBD0J617iMtNN9kOa4ea2kmUPIS6PGeXdZOKlrK/n9dLp1BJ4eba0I1HvrJZHcv7yQx
	iie3uP6Yc7E7H+LQBwKc2Gqq4MJGwDaZMRdMjlnBKLfftcQ==
X-Google-Smtp-Source: AGHT+IHH7da/LZmAZnM0fJkvDTf4zlk9MLG128qdfl7Rl/ZDlQrAKSDlDVnlaMHDaf0NYEI0QrOebQ==
X-Received: by 2002:a05:6a20:4304:b0:243:15b9:7656 with SMTP id adf61e73a8af0-24340d231damr23290148637.48.1756199992578;
        Tue, 26 Aug 2025 02:19:52 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cd272648sm8332063a12.27.2025.08.26.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:19:52 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] PM: hibernate: make compression threads configurable via kernel parameter
Date: Tue, 26 Aug 2025 17:19:37 +0800
Message-ID: <20250826091937.991667-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new kernel parameter 'cmp_threads=' is introduced to
allow tuning the number of compression/decompression threads at boot.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/swap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index ad13c461b657..43280e08a4ad 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -520,7 +520,8 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 #define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)
 
 /* Maximum number of threads for compression/decompression. */
-#define CMP_THREADS	3
+#define CMP_MAX_THREADS	12
+static int cmp_threads = 3
 
 /* Minimum/maximum number of pages for read buffering. */
 #define CMP_MIN_RD_PAGES	1024
@@ -585,8 +586,8 @@ struct crc_data {
 	wait_queue_head_t go;                     /* start crc update */
 	wait_queue_head_t done;                   /* crc update done */
 	u32 *crc32;                               /* points to handle's crc32 */
-	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
-	unsigned char *unc[CMP_THREADS];          /* uncompressed data */
+	size_t *unc_len[CMP_MAX_THREADS];             /* uncompressed lengths */
+	unsigned char *unc[CMP_MAX_THREADS];          /* uncompressed data */
 };
 
 /*
@@ -703,7 +704,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
 	if (!page) {
@@ -1223,7 +1224,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	 * footprint.
 	 */
 	nr_threads = num_online_cpus() - 1;
-	nr_threads = clamp_val(nr_threads, 1, CMP_THREADS);
+	nr_threads = clamp_val(nr_threads, 1, cmp_threads);
 
 	page = vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));
 	if (!page) {
@@ -1667,3 +1668,14 @@ static int __init swsusp_header_init(void)
 }
 
 core_initcall(swsusp_header_init);
+
+static int __init cmp_threads_setup(char *str)
+{
+       int rc = kstrtouint(str, 0, &cmp_threads);
+       if (rc)
+               return rc;
+       return 1;
+
+}
+
+__setup("cmp_threads=", cmp_threads_setup);
-- 
2.43.0


