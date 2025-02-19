Return-Path: <linux-pm+bounces-22413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BF0A3BD28
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17353189836A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DC81DEFF1;
	Wed, 19 Feb 2025 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OlazLVeq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4B1DED70
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965316; cv=none; b=Hz1bYz+W1EfLVm8GToHKiaCJgwibPXeEpGf8UjhrEleXxGeCuBQlm3dI0ert5DvShc83aQlbHcUZY6aCuivdfs6dG0ihZydtNr8ZexD1feXGbAD6Rrrp1u7qUWvz6IhnG/+gEPhv8xplbtyQObSEiu8vTLaB0ldxs2lYoL1zfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965316; c=relaxed/simple;
	bh=v4Nxihrrot+B12P9jCeJPg6UUTZPQjPI5KJs93sMlZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UdWop6dhoGWAD1zgVIvsS/YXALq9fbeuM9XC3SnqRhQphUQD7YtHUzBuej3FreAKM4n6BD6PZaPk/DkadDDwqycbHJeVaTmGWGSEf65ZXwvARYozvhGV5JZdPL0/1TBCZQkoH3k+eRC+DVuaE7RE5LQTo1+V5EUaZmb0kMTdAdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OlazLVeq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220ecbdb4c2so138000695ad.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 03:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739965314; x=1740570114; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvtQB/lGlc+Tk5xjdqGmPEVFQSYg82f1Tgy36DWvKQU=;
        b=OlazLVeq2uIf4M8VpnDXS+6owHeQOXfJXJ5ZST4DBo2bpjcvQkoqKJ+F65RRSXJbeQ
         icsY7iQr79Rcjh45qhueU1x8fxhV52uwuMrFknjpQm0f/RqDRU2GFieigLcjJgtG5K0j
         FxYFpC10xJWDzSTbZixtIvwLr8IDeg09D/li2xfL3nL4Dp9+ng029vGyd1DzzP3SxSoO
         iMPlBH0tq4FTzc43+mXF5H6K3Z0w0zPyF2t6Y2d1jlJXzF3yPSvRNodJ7vMjWKvLn+aK
         ovG6LtjS9889V9DGulKEbsLzC0GuWTv62Mi9/I9BEL+ILbCVUUAv/gDPDSsWUTxtasdH
         RzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965314; x=1740570114;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvtQB/lGlc+Tk5xjdqGmPEVFQSYg82f1Tgy36DWvKQU=;
        b=erS0aR5qdF4ft4D2o3Gl7T4cBkwh6qm+iK6x6HbgO02KBe32oqHElO+s0QJrQat0er
         6/h0JOicqeVhTMZseGPfSKgC8i6K8UjEACviscE3O8NgkanX4mu1yoOjvMbSZWguQ1vu
         Pt9tyZpNHndLrAFA5Qmc4lApLf6sdtrZEaNwPa/zF8SlW8mlT8kZ46qMhfjgqU3taPRI
         /krguyKTlqAy+Dn2InqNY/Y1q/JAVsxCZ3rBluy3XWq+iiZS/0J+vT3avXtKalm6L+ij
         rkb2PzlGI5WAri0WorGuYEUeM0HL+VqcuZyAn+hqKcoFODudZYFjvOs2iIuNDYkE23Ea
         Yryw==
X-Forwarded-Encrypted: i=1; AJvYcCV7LzaouyxPuhna0+qeLUyD6UG7WVtHxDyLEqVc/0uKrFz4CQpWP1X8yiAH0gdBpJoch6OGg2HZuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwclGyTCp7yAYlRgTC8qAIl2OhFvoCu4jbcGw17+ZW43qTmM9iY
	MtYIenDTDSESVGcLpRba2v5PKDj3zFZmhDE5yICkBvOVNM+YAoWslirsFlUVv7c=
X-Gm-Gg: ASbGncvaqwMgNjj0XS/pLcDv2x58oubKSRqHML40u6mVzP/g871UQpqsPhdqOgsX7zV
	kU/XzuIHo2W11VteYR2IdONIzRYjy7B1xjvTYy+PZqWwJ1/2UrjNspGO+qiW/5baWJjIoZq5PXG
	dtZ4qMwtFRGxR+UVGGefTjbZMwp/lTinuQoAq6u2N1UxQfb+ARPMgL4pEye6U+/m0sXVSg+peVZ
	OPvyqYyK0YQsGV0T+eyPzslz0ErkLE0ZmdC2Giu0OxvtYOf5aacUY5GhDpVEkuYx5NFT7Xe9BJ4
	3owfnV2v2hCehpJqVNElujF7Nd/jdboGeockbw==
X-Google-Smtp-Source: AGHT+IE6NLalTRKF906UogoaqA2vkhz8eL3B86SceRlnQGiSoGs39HTOQJs5eyoh/PazNPL54JFJxQ==
X-Received: by 2002:a17:902:dac5:b0:21f:507b:9ada with SMTP id d9443c01a7336-2210405cc66mr282536845ad.31.1739965313971;
        Wed, 19 Feb 2025 03:41:53 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d507sm103218545ad.145.2025.02.19.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:41:53 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] riscv: Add stimecmp save and restore
Date: Wed, 19 Feb 2025 19:41:34 +0800
Message-Id: <20250219114135.27764-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250219114135.27764-1-nick.hu@sifive.com>
References: <20250219114135.27764-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

If the HW support the SSTC extension, we should save and restore the
stimecmp register while cpu non retention suspend.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/suspend.h |  4 ++++
 arch/riscv/kernel/suspend.c      | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 4ffb022b097f..dc5782b5fbad 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -18,6 +18,10 @@ struct suspend_context {
 	unsigned long ie;
 #ifdef CONFIG_MMU
 	unsigned long satp;
+	unsigned long stimecmp;
+#if __riscv_xlen < 64
+	unsigned long stimecmph;
+#endif
 #endif
 };
 
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 9a8a0dc035b2..24b3f57d467f 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -30,6 +30,13 @@ void suspend_save_csrs(struct suspend_context *context)
 	 */
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		context->stimecmp = csr_read(CSR_STIMECMP);
+#if __riscv_xlen < 64
+		context->stimecmph = csr_read(CSR_STIMECMPH);
+#endif
+	}
+
 	context->satp = csr_read(CSR_SATP);
 #endif
 }
@@ -43,6 +50,13 @@ void suspend_restore_csrs(struct suspend_context *context)
 	csr_write(CSR_IE, context->ie);
 
 #ifdef CONFIG_MMU
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SSTC)) {
+		csr_write(CSR_STIMECMP, context->stimecmp);
+#if __riscv_xlen < 64
+		csr_write(CSR_STIMECMPH, context->stimecmph);
+#endif
+	}
+
 	csr_write(CSR_SATP, context->satp);
 #endif
 }
-- 
2.17.1


