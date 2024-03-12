Return-Path: <linux-pm+bounces-4863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49C879C72
	for <lists+linux-pm@lfdr.de>; Tue, 12 Mar 2024 20:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33531C2288A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Mar 2024 19:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BCB142642;
	Tue, 12 Mar 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QZI1LJ2R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2714264A
	for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273405; cv=none; b=uDwZS+J5Nxt543UvgRLac2o6qPj1WFU0BWfQtKLTjswj7WppCSKksswtyBgkeEPRZVFwkHixwpVPuRbS6Z1QUIcJ7BpK7DDc2AJADxn8lxzz/Bw1CuL1tOHlPpv3qzQAYHnx58f6rUmKBfSetCJ0tfK9L7DmHk2xf8Q9mS9jBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273405; c=relaxed/simple;
	bh=NfuMaH7Y/8CSMgzfmLwCZoP8iZSzw8HM7XZf9JY3qEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nnvg2qYshxHpoB3e8H8IbNb6f/GBsjuxWgvauQeLSQV73MjMFgCc5s0PAiPvha0SB3OV5dCbCK5aXL1q1A+06WqSx+vJ4NXxUmljtjI8EOWsh/+bjFMW1W93pmicr9VxXcg3T/JLwJfYFmnEOzU3ETcigx9JOkZTwgoBISqRn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QZI1LJ2R; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dd611d5645so1525345ad.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2024 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710273403; x=1710878203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxEx3iDsM3WrZG2Ndd+J9E+wXDu/hB2Os8/24Q1t3OY=;
        b=QZI1LJ2REYGo1Bsc+3/Zqq2HkKct0LVwKXwjvtRUVdoTYpnvFrLuLNk5jJaNBmF8hP
         KgG7HxYJuYs1yT5N46OP5XurGkntOyZ+8UVrpWeNxRGEbFpLnV95CD91uYzN3tNv2xX2
         +E50mP7/BOglB3SmJVyEH/o7VpJ1OXjbGXeXM2oa6f04MrW69uFJWgL0H6enqnkCSVj/
         ApcqOgCuz+BFQQTLt6oRG/ryyK6ZygjUHNVZ1keJVcmndWfHEZ09gggSeZgokmXR8vi9
         Rxkapb02l9ucsKxnRass5RMvSHXbto/4tsRUyyluvKsNX1xCrgnB5G0Gcq94FOIrQRc0
         CICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273403; x=1710878203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxEx3iDsM3WrZG2Ndd+J9E+wXDu/hB2Os8/24Q1t3OY=;
        b=pMcry3fI/cFYZOAYeErCZ9PfnhlEhpvegJ1OSAqILph4PZLRggw5XG/fvyZUK2bOne
         8TK6IG7B08mvwq5lfxQi7bJzB+r2j1aq27jfaNImAyzjBJ6JG/O0cmr6ELnNHkXVVR6q
         cJxYa0I4BO/ry/KXJ+yarUHsAjQ/9KvhCAxIDzC4e9LK8te67SENq4m8rQDVjspUhzZD
         MJ/O5Jhcwk2Wolxef0ms69HlHn3TX1BhxtKuLBHljkZ/Rlc3Yg+9JkJwapv9VlLKrKbV
         yzuE9CpgmEZkWqDU3t/QnPS0ZWjuTy6e4vC4lNYszSX3JoaGzVylmR8RhSm9/8zPUM5X
         1RDA==
X-Forwarded-Encrypted: i=1; AJvYcCVzfCbusous9Uhf4Sgo8aVQGlJEFxs5+kb9cVG1w2xMKrcvQry4He0Ycxbr3Ox0C4LlOLMx1C4RxGjS41WKtiGa9iUE8WpQy7M=
X-Gm-Message-State: AOJu0YyPu+wikad+3VhxoopqqXbem1aLGv1/8O5oj7Pmqi2pRJpVJgzU
	zQ+riDRCGXv0539aTls+AVN++s0PMvYC4FzQFT8DwiETOQ6XdCEqaqhMi8HOHSNZkPTjcFzjV4l
	y
X-Google-Smtp-Source: AGHT+IFpt7ff6HNFHc9Yq78Z63OwKzFZJ801dFotJRAscTaClrr1h/Au36ogZQmQ69SY/YT0n6oNpQ==
X-Received: by 2002:a17:90a:e54f:b0:29b:c49b:eb13 with SMTP id ei15-20020a17090ae54f00b0029bc49beb13mr628731pjb.24.1710273403142;
        Tue, 12 Mar 2024 12:56:43 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id hi23-20020a17090b30d700b0029bed0e75dbsm4708774pjb.17.2024.03.12.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:56:42 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] riscv: Do not save the scratch CSR during suspend
Date: Tue, 12 Mar 2024 12:56:38 -0700
Message-ID: <20240312195641.1830521-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the processor is executing kernel code, the value of the scratch
CSR is always zero, so there is no need to save the value. Continue to
write the CSR during the resume flow, so we do not rely on firmware to
initialize it.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/suspend.h | 1 -
 arch/riscv/kernel/suspend.c      | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 491296a335d0..6569eefacf38 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -13,7 +13,6 @@ struct suspend_context {
 	/* Saved and restored by low-level functions */
 	struct pt_regs regs;
 	/* Saved and restored by high-level functions */
-	unsigned long scratch;
 	unsigned long envcfg;
 	unsigned long tvec;
 	unsigned long ie;
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 299795341e8a..3d306d8a253d 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -14,7 +14,6 @@
 
 void suspend_save_csrs(struct suspend_context *context)
 {
-	context->scratch = csr_read(CSR_SCRATCH);
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
 		context->envcfg = csr_read(CSR_ENVCFG);
 	context->tvec = csr_read(CSR_TVEC);
@@ -37,7 +36,7 @@ void suspend_save_csrs(struct suspend_context *context)
 
 void suspend_restore_csrs(struct suspend_context *context)
 {
-	csr_write(CSR_SCRATCH, context->scratch);
+	csr_write(CSR_SCRATCH, 0);
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
 		csr_write(CSR_ENVCFG, context->envcfg);
 	csr_write(CSR_TVEC, context->tvec);
-- 
2.43.1


