Return-Path: <linux-pm+bounces-5634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B38915EC
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B2D1F22B55
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9176A034;
	Fri, 29 Mar 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wv3Se+ip"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F36A035
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704487; cv=none; b=QkgFIyxhbH3k4cVHCtuZlOw80SM/s9UKCSmQnYg2S9zLOX7HIXgUfs2QFivF68aPPha1PlPrnnuuEQexIAy9PPrGVw7vw00LxoQzzAJPJtLSvO8hz2i1GbmwJ/Dmf5SNQg22Att1vYRlCDM16NbBsGoVfdR5ht/BPmXz4vcau4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704487; c=relaxed/simple;
	bh=aYxwIoa5oYGQg8jCIXD+qDStt+bScyurvWfoZf9ca1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+UyhIeksc0bEEbx3ccAtw5c5M4QeXUxeixm0iacIk2RvUg2xX7XkYsRNn7hJ2niX7z0d3OV3i0DGjNcLwWEMvmhg7BkMGcZcg3sILGwK+J3UOD0UDyWo+KsmZ0L1VUlb0Pn4KJq5lfuwAgxMQLg95EYMcR7Jpt7i61lzKz/G9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Wv3Se+ip; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29f9af2e0b7so1305688a91.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704485; x=1712309285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2me2ctA/QJ+WDbqGcKl2bMmK6E0Eh2HMfIwB//6qG84=;
        b=Wv3Se+ipLwX7BaXC8mc9OVgZLMWWwl2aQ5g0wKk7JFUVqgpbxaIkAz4jAIQvr5zPR+
         wJI6gc1xj5e45Le+xmGkj8FRc5cSMqpYGdPlnF1GXJUqniLGUunR02g7KHc+JzvRv4N6
         Xdt1BN9vHfz/gujH+Ls7JrlWKjlHhVGBMx/IlOFioZpORbH3km2aUylELqEVdx4BKFEh
         OXroAsuI1Ru7h1ry6MKwusQ1K/UlCJ/hjrF6UFr1n+e2XOCjGYid9x7vQ4wRL7bCOll9
         ockv9yKI6dWdk3xXwOeIMINnH+vCgzJPiWwtABBZOc32d9CcOWRjL7y6toOgQjsQo/o/
         tdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704485; x=1712309285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2me2ctA/QJ+WDbqGcKl2bMmK6E0Eh2HMfIwB//6qG84=;
        b=DG92L8Pag393qVSSY0IJKs1LEkxjIidhUhSvDqf5GU8mSUEtCYCRQN7AvieGL5GfIC
         UCJ2sXWWII90yRlmC3VW/RI4e9W1AiFgBHgv2jpiqfiSxAOPb3c6oFB+bn7HrpeW5hU3
         lM/7FBlyG6oiP1vqQgP81KelC/BONMURxDM895FAM7IO/2dOTzdOTRyo9qLwKkx4ozbm
         /eLJYnTVBj48ot8V7/+9drAErxKLU4mnpd+HTst0jri0L31Iv93+wZ/Z1rxkPBIUVdFV
         F1sW1muCAxpkbx0DKaYTIofgh2BcakfqeGORzMlYu4vmxiNrgKdDiWXoBnTCbQZiUkoY
         v9sA==
X-Forwarded-Encrypted: i=1; AJvYcCVDRofM/VvVNFBMo2YgghuEuNpzYxczVKc1tAtBLboPUv5V76PwZ2RW8KGYuF08RaowXDHG1qK5avOvbGafkJMgIzjr+BAP8O4=
X-Gm-Message-State: AOJu0YyDfmPIsHuQ9oppVmfgSRi4x76DsHctOOsUkGjEyud43pmw/Ylp
	U1RYyh/Hen414MyxH8Xzo1YFDYmBibmADplXKJ5nNrEaB4/WKuPCEVQeNzXKbMQ=
X-Google-Smtp-Source: AGHT+IGdY03xWXQByMBRxphQC1Vc3BZVaeHeBgA9jftNMkoc3op5kWSNSp3jA7sJf0LUKMcaom5H1Q==
X-Received: by 2002:a17:90a:7f84:b0:2a2:d48:9d50 with SMTP id m4-20020a17090a7f8400b002a20d489d50mr1744971pjl.44.1711704485323;
        Fri, 29 Mar 2024 02:28:05 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:28:05 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:23 +0800
Subject: [PATCH RFC 07/11] riscv: Add task switch support for scontext CSR
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-7-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>, Nick Hu <nick.hu@sifive.com>
X-Mailer: b4 0.13.0

Write the next task PID to the scontext CSR if the use_scontext
static branch is enabled by the detection of the cpufeature.c

The scontext CSR needs to be saved and restored when entering
a non-retentive idle state so that when resuming the CPU,
the task's PID on the scontext CSR will be correct.

Co-developed-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/asm/suspend.h   | 1 +
 arch/riscv/include/asm/switch_to.h | 9 +++++++++
 arch/riscv/kernel/suspend.c        | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
index 2ecace073869..5021cad7e815 100644
--- a/arch/riscv/include/asm/suspend.h
+++ b/arch/riscv/include/asm/suspend.h
@@ -13,6 +13,7 @@ struct suspend_context {
 	/* Saved and restored by low-level functions */
 	struct pt_regs regs;
 	/* Saved and restored by high-level functions */
+	unsigned long scontext;
 	unsigned long scratch;
 	unsigned long envcfg;
 	unsigned long tvec;
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 07432550ed54..289cd6b60978 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -8,6 +8,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/sched/task_stack.h>
+#include <linux/pid.h>
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
@@ -75,6 +76,12 @@ static __always_inline bool has_scontext(void)
 	return static_branch_likely(&use_scontext);
 }
 
+static __always_inline void __switch_to_scontext(struct task_struct *__prev,
+						 struct task_struct *__next)
+{
+	csr_write(CSR_SCONTEXT, task_pid_nr(__next));
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -86,6 +93,8 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector())					\
 		__switch_to_vector(__prev, __next);	\
+	if (has_scontext())				\
+		__switch_to_scontext(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index a086da222872..6b403a1f75c3 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -11,9 +11,13 @@
 #include <asm/csr.h>
 #include <asm/sbi.h>
 #include <asm/suspend.h>
+#include <asm/switch_to.h>
 
 void suspend_save_csrs(struct suspend_context *context)
 {
+	if (has_scontext())
+		context->scontext = csr_read(CSR_SCONTEXT);
+
 	context->scratch = csr_read(CSR_SCRATCH);
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
 		context->envcfg = csr_read(CSR_ENVCFG);
@@ -46,6 +50,9 @@ void suspend_save_csrs(struct suspend_context *context)
 
 void suspend_restore_csrs(struct suspend_context *context)
 {
+	if (has_scontext())
+		csr_write(CSR_SCONTEXT, context->scontext);
+
 	csr_write(CSR_SCRATCH, context->scratch);
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
 		csr_write(CSR_ENVCFG, context->envcfg);

-- 
2.43.2


