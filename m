Return-Path: <linux-pm+bounces-34614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D142B56E4A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 04:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E1B3BDA54
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 02:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8242367D7;
	Mon, 15 Sep 2025 02:23:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34122A7F9
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 02:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903025; cv=none; b=i61jsNYGabRBryLSls4Yz8B5LN965ik+tnBH/5qae7lfgTN2fZVKswgUODbhDs5o3LcTbI4IRu6atmerv/4TOjNg+JXrNbXFaB8jnV+/rNHkUMOyxNVY104h1Erdpyrzpd5sTGeLG8ZfcpFoEo4R2njd2PZAp6vq9gr/fa9JY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903025; c=relaxed/simple;
	bh=bTB9DzoWH3QIpeBu4xYDTQAzXlJCXk6gbv+o+fe1N3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQuqfzl598dxamSPFodCq6HuUuOx5B/uDm772y8cdSViURul3t97PkRX4YjbKx6g7Q0sNGgIx4pfppJZTR3VfutVbAHKWD7qy0kNCw6r/k4NTI1hNeN5OuNVlN4PFBBh8MZ9J3Kg/BGNGVNaFWvHGkLSnx/4zqypmxSgyyX6rpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32e64d54508so354412a91.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 19:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757903022; x=1758507822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVV/uiMu0xHtlKgwsYx2mXd0JzCW14CDL0hbQStIbj4=;
        b=Kcsb5fhGMnsTwUQXSVZIPSK3TM0TpxXdMl26+iI4dcluo7i95xQ70i5MVql64/c1dT
         oO/09Fzey4fzQZ5CxUSHKZi0GlzeW0uhtkwZDfrz+bbwc/xte8kHYCmzOhK/ax8MdNjx
         EH5yndXxocSLbTfwNJw9GKXIh5jecB5e1QkfUTRxS2G1Txru4VaUCdXSAFK2OG9vwGRf
         Ma1QMu1p2Cqg1FXQgbbCrik0jHIlXVeBbC2pe8jo9/RX4VSidLt5r1lse59GRJENH9wH
         sjAPXj3AVzsgPJElCobGgiHnoFt/RmROpNTm3WZjE78/1v5I3nKmm1ols823GRNRPmGi
         mnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp+IUX3EjNkfhFCqS+gt/lq9zCULLBtNoaeTvxQuDLt/rp40eGld0JJ9ZOklCUSy5tatZt46iMjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycd6S+r6Q2UyO49MA/55uzmr9ySFNET0jnEGzwgtXRxcDU43Zs
	FZrwiDhzPXUAcG0iD3Unnp2PGtuxObEnUoTCRYG04jIk89nUpqxPgs7w
X-Gm-Gg: ASbGncuKuujqRuGivIzdDzF/FSMV2Di5ccUj7Fh/tbrsiqPqlBGQcI5Knr13dKt0PXO
	DUTQjOaLdAqhBmMaBw0JaEeqQyX4wlNHhDMdIweDENMliRuNeQgUXG/XFzDjQktgRg/l1I448Ps
	aim2ECTBWQ0rJglE2VoR5/2MBS6r8iYJVmjw2fNHucgw2tIijgjKEgn6x2pA9/ishMU/SRDC3Lg
	mha8XN19pjlns9TzrJk/gYA9g3nozRc5kXHUbYrpuz7dfkoDkxtTbuM7wdlKLT6YsL3z2+Pl5us
	ik8rgQg15X4t/kWCh5eHWIwEmlCIClVq4nxj95O5N8JbMlxacRf53y7zmidWPlBKPnouGm/BUEb
	UUMPgzq+Q5xRV/TnoOXOeqFzzwD5dcxFV3qj+KQzp1UfN/YAHiZ+0ZGo=
X-Google-Smtp-Source: AGHT+IF+Y1ivvZp4pAmaUG3hCpveTcj5pGelQEzRTJOfLOyRR4gRbVeT03JbaIBxDc6kfYZUfAWuQg==
X-Received: by 2002:a17:90b:48:b0:32e:42bb:dc58 with SMTP id 98e67ed59e1d1-32e42bbe0c2mr2998665a91.26.1757903022477;
        Sun, 14 Sep 2025 19:23:42 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([39.144.194.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37005a82sm2969607a91.16.2025.09.14.19.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:23:42 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 2/2] PM: hibernate: make compression threads configurable
Date: Mon, 15 Sep 2025 10:21:25 +0800
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


