Return-Path: <linux-pm+bounces-14777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12741986D0E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357691C21DAB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 06:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5E18C03C;
	Thu, 26 Sep 2024 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BC/yuJOI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89AF18BC21
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333754; cv=none; b=Hrymhq1xy60/D8ebEAENjgcLnMbDxkckvaQgvdAUJEuD3FIi+vm/bBiYisVW2S+AGxqi148qT8B9gf9xQKF9Gs8rsYiH2VAe6oENcKOZ90lxMDQEu71LNhR9dSjcy4GwcT8R0oqT8qI1232riIX6BrlNk2Mh5DCKMDd5e4mTjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333754; c=relaxed/simple;
	bh=FBGeqsWhtUXKanzZVpX8tx8GNN2ZBAo6zLyDQdumH5Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AWvt1i/Zj/f3HJku1HyT6RuBqSKU1eLHvu202rs/oLJ5VrVsQELzeTWV2heBGy4VTltiDpRv1Q41OtItKA9xSndHeIGMBdgduNECxjUvjBt4gp/z0FYXC2UDs4N5at2AZa+JO4486U+our/ufpODlnOyZquOmvuJSOUGKTea/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BC/yuJOI; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a0cdd77dbeso2508845ab.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1727333752; x=1727938552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dz6nXOQPpHKKg/2POW9sH3ldlFQk4LGlQ9pIvX2kgEo=;
        b=BC/yuJOI/LdgNCbiAaFwxIatqiKzv1jzovilRe5+LrbqAv+8Rg99WcXpfSerVFm3rE
         2L+PiMI79BZU5XNE0GGGSy32xvUp1CbT82/XF07jKd7JaVV3OPs8uCUv0Ntr0yhfcCKU
         umLqT//XCZYF56KGffTtvdEzFsUnBAiYuvQj1z8Sdv5ykMf/rtyP1LuN5b5+cWBkpMZm
         LyFfiytW6gR49TARKGSRJBs2IsKuJjdv3kSmR0B64vDLDQOX97B2qJn/VqVe4H9sFEY3
         4fTwFQVJycQwwzKzLxHJ4Vy/uN6sZWIrHuI+0nsIl30PA35piKJTFah+IhGvgmdrooCK
         Z55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333752; x=1727938552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz6nXOQPpHKKg/2POW9sH3ldlFQk4LGlQ9pIvX2kgEo=;
        b=CQfluNG+XzJqKXUT+0kfwT0Icbr/Zygy6cH55MQFwrhcJp7VuCMWLYnXvFyO2ELwCh
         6RF/yoAe++VHLDXRWiC+ggucP6bE5PMLVH21CxD20QWl9GRPZzlqxYPmnLT/XinAO7SJ
         xVcAkBLNEDK3mqKLpQe1+EBEps0S0WIdGbQRTlXQrjs5kE8OYsHXYcTjZd5dWcIxVj6E
         b1NUvXrhVbRaI69a9dmwVkxplGD1ksUxyVD/8bCnIjL45PoGxmAugMxipbT6uav9wPED
         Di+Y3cM6QbvuGq/4iy0E4y5m58ZqylZN3PFrjgQwgCeHqNeiNXj5aKyEr6zA2aGuvRcG
         Agkg==
X-Forwarded-Encrypted: i=1; AJvYcCXAMIIELmKQinUfiTkHC9/HgikLSMPlw2UQqbIWDCNUjLrXzOb7X1nSSLW65fSQfavavm/bYyjHFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGg9noH2D/tHkB12UblZ3m15bczfnLEwpg4DIJHq40IM0Pi7Pt
	7T29NplJLiZ4ij7Jqk3AiTgBuyW0Kr4t7pZjNd6kBF4n3DN1JiGJ8VVqSWQQJm46sYzdzpOiebA
	wAZI=
X-Google-Smtp-Source: AGHT+IE5HtHveKKLfQie2ZdRESQAIt2gsyCcJcr3zDTArzQG0bYH4n5mBiG2zxUxyKL4arsG6HYvQg==
X-Received: by 2002:a05:6e02:1fee:b0:3a0:9ed2:67b8 with SMTP id e9e14a558f8ab-3a26d6fc9a9mr60527305ab.4.1727333751901;
        Wed, 25 Sep 2024 23:55:51 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73120sm3592352a12.68.2024.09.25.23.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:55:51 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nick Hu <nick.hu@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] riscv: Add csr_read/write_hi_lo support
Date: Thu, 26 Sep 2024 14:54:16 +0800
Message-Id: <20240926065422.226518-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926065422.226518-1-nick.hu@sifive.com>
References: <20240926065422.226518-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RV32, we may have the need to read both low 32 bit and high 32 bit of
the CSR. Therefore adding the csr_read_hi_lo() and csr_write_hi_lo() to
support such case.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Suggested-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 arch/riscv/include/asm/csr.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..54198284eb22 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -501,6 +501,17 @@
 	__v;							\
 })
 
+#if __riscv_xlen < 64
+#define csr_read_hi_lo(csr)					\
+({								\
+	u32 hi = csr_read(csr##H);				\
+	u32 lo = csr_read(csr);					\
+	lo | ((u64)hi << 32);					\
+})
+#else
+#define csr_read_hi_lo	csr_read
+#endif
+
 #define csr_write(csr, val)					\
 ({								\
 	unsigned long __v = (unsigned long)(val);		\
@@ -509,6 +520,17 @@
 			      : "memory");			\
 })
 
+#if __riscv_xlen < 64
+#define csr_write_hi_lo(csr, val)				\
+({								\
+	u64 _v = (u64)(val);					\
+	csr_write(csr##H, (_v) >> 32);				\
+	csr_write(csr, (_v));					\
+})
+#else
+#define csr_write_hi_lo	csr_write
+#endif
+
 #define csr_read_set(csr, val)					\
 ({								\
 	unsigned long __v = (unsigned long)(val);		\
-- 
2.34.1


