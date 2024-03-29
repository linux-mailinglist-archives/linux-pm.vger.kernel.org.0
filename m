Return-Path: <linux-pm+bounces-5636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE5C8915F5
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 10:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E1A287489
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCCA7CF21;
	Fri, 29 Mar 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SUrseKtc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387476BFC7
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704494; cv=none; b=XDSyfLObolXq0fZCWqAz9qU2TByXzGbG93DrqysgChvsqFETwrtZxypXXyjKXm04fzFIz1dqvDfYdry3rFahBsngru+UrXbLlzvlxRfbgvjdACNZ5Qp8qi79snM8a49wpTlqY9vCPyQtfiIXbXwLCPZr+BWevIN8fBjdxw4ulYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704494; c=relaxed/simple;
	bh=S2OuTXD/Hjwavyzf8jEj8OwBxUmb/feid5vEZT5nX48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTm6H4Dg90v19pyLFwM4QAIZUa/Imwo2DiMHiun6MXfbgAqhpgLmCqWvqZOMDx3PlibCt26/LSv8JhmWcKYAuVghk2Oq7dByYK/lxgC11ZSogubfQ3TYb1G2KRuaRikJwhjviozwV2ZpRhogSGdp9X3q9ssUXGaIqphevsoEsuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SUrseKtc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29f69710cbbso1284506a91.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704492; x=1712309292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8h7cMSHewFGFYlfFfESe4dUXe0bnXjUVrh6WZkusMc=;
        b=SUrseKtcyxJkwmPkTHXU9ft56oU+M+9AhtAp7zTnmNFWpQE2BCJSRZ+QCXBvgfyDWn
         XGBWTkddGAxAzQCUq70hQOLNtivzxIYK2Htz9XWaCJuHyrU6uYcQwsolDBqQTuvF5iwY
         fcWxdyYrQwdNXZ5kn1PDtVvetp8zGZe7tzb2XouA3wOfkMz7E7GIGASx01NFCo9EoUjk
         c8VmLJ7VSdEvEsrtnh5dTH3RaMf99WQWVpP3IXn1p4jhejc+5eTincMD8dd5T1VMTGeo
         WnT8+ctptmMCyKVeUCccI94s6t978E7CHsuI/9678lTUpia4RCVs01zN27Aw/k/aoOQc
         dS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704492; x=1712309292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8h7cMSHewFGFYlfFfESe4dUXe0bnXjUVrh6WZkusMc=;
        b=NFwPB2+zRIQknS01GFmneQtRNGt1YPfwV95Sc2HqCe/UXA1V53yhBBNY9P0aBdUtdi
         KGPl7YB8hd1YebS+fTuH4pNtBeZmUV1JrpoS4OlmEzQTgOYvotlKNoARfLLMI8VgNtt6
         KnEJknz/3klymEXOiqY7SigmnTNw5464LLR+B3t5Sps4245JaaR78NeDfC5Z1QtiS+7U
         UflM3f/AKvT+gVyTlBKjZP7bmk7BNkpJNHWdAaOVTeRQ81Kbi8YNdNX7q7NlWLZlIgMd
         TrFeRUa2gVhy2OUjnT1wPB1ILKV8hPdUgwtKFeNTudzQaX/g1DKoAFmQSlYIFAkiEi1m
         UHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlb12PvLxF7MToBRYQl7fqfFEtN0QpyQQVfukTDVk9yrWjWas0feivI8aMHmaZSPW0Tm0Pef/QGx3rZHKRnbB5YOl90rBbSvI=
X-Gm-Message-State: AOJu0Yw8VPyss2JB/Zj5qM/C/RzQFRQyMupuK7Jl+iFj2xA4wjE5lbaP
	LJ4hgu0VwtzE7wDFadNDpW/CgzISVj/fmPngxGeaLb764g1EUADjtwhyycdcRWc=
X-Google-Smtp-Source: AGHT+IHUaxFv/dBvqwWUSlGt4S9YT575kSY8SadSYy/sbeUKbzKaMImn5kh/n16Q0rGOAx3nqMZItA==
X-Received: by 2002:a17:90a:e386:b0:29b:46f0:6f8e with SMTP id b6-20020a17090ae38600b0029b46f06f8emr2770618pjz.8.1711704492529;
        Fri, 29 Mar 2024 02:28:12 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:28:12 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:25 +0800
Subject: [PATCH RFC 09/11] riscv: KVM: Add scontext to ONE_REG
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-9-1534f93b94a7@sifive.com>
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
 Max Hsu <max.hsu@sifive.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.13.0

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Updte the ONE_REG interface to allow the scontext CSR can be accessed from
user space.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Co-developed-by: Max Hsu <max.hsu@sifive.com>
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/uapi/asm/kvm.h |  8 +++++
 arch/riscv/kvm/vcpu_onereg.c      | 62 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 9f70da85ed51..1886722127d7 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -98,6 +98,11 @@ struct kvm_riscv_smstateen_csr {
 	unsigned long sstateen0;
 };
 
+/* Sdtrig CSR for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
+struct kvm_riscv_sdtrig_csr {
+	unsigned long scontext;
+};
+
 /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_timer {
 	__u64 frequency;
@@ -224,12 +229,15 @@ struct kvm_riscv_sbi_sta {
 #define KVM_REG_RISCV_CSR_GENERAL	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_AIA		(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_SMSTATEEN	(0x2 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_CSR_SDTRIG	(0x3 << KVM_REG_RISCV_SUBTYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_REG(name)	\
 		(offsetof(struct kvm_riscv_csr, name) / sizeof(unsigned long))
 #define KVM_REG_RISCV_CSR_AIA_REG(name)	\
 	(offsetof(struct kvm_riscv_aia_csr, name) / sizeof(unsigned long))
 #define KVM_REG_RISCV_CSR_SMSTATEEN_REG(name)  \
 	(offsetof(struct kvm_riscv_smstateen_csr, name) / sizeof(unsigned long))
+#define KVM_REG_RISCV_CSR_SDTRIG_REG(name)  \
+	(offsetof(struct kvm_riscv_sdtrig_csr, name) / sizeof(unsigned long))
 
 /* Timer registers are mapped as type 4 */
 #define KVM_REG_RISCV_TIMER		(0x04 << KVM_REG_RISCV_TYPE_SHIFT)
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 10dda5ddc0a6..2796a86ec70b 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -471,6 +471,34 @@ static int kvm_riscv_vcpu_smstateen_get_csr(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static inline int kvm_riscv_vcpu_sdtrig_set_csr(struct kvm_vcpu *vcpu,
+						unsigned long reg_num,
+						unsigned long reg_val)
+{
+	struct kvm_vcpu_sdtrig_csr *csr = &vcpu->arch.sdtrig_csr;
+
+	if (reg_num >= sizeof(struct kvm_riscv_sdtrig_csr) /
+		sizeof(unsigned long))
+		return -EINVAL;
+
+	((unsigned long *)csr)[reg_num] = reg_val;
+	return 0;
+}
+
+static int kvm_riscv_vcpu_sdtrig_get_csr(struct kvm_vcpu *vcpu,
+					 unsigned long reg_num,
+					 unsigned long *out_val)
+{
+	struct kvm_vcpu_sdtrig_csr *csr = &vcpu->arch.sdtrig_csr;
+
+	if (reg_num >= sizeof(struct kvm_riscv_sdtrig_csr) /
+		sizeof(unsigned long))
+		return -EINVAL;
+
+	*out_val = ((unsigned long *)csr)[reg_num];
+	return 0;
+}
+
 static int kvm_riscv_vcpu_get_reg_csr(struct kvm_vcpu *vcpu,
 				      const struct kvm_one_reg *reg)
 {
@@ -500,6 +528,11 @@ static int kvm_riscv_vcpu_get_reg_csr(struct kvm_vcpu *vcpu,
 			rc = kvm_riscv_vcpu_smstateen_get_csr(vcpu, reg_num,
 							      &reg_val);
 		break;
+	case KVM_REG_RISCV_CSR_SDTRIG:
+		rc = -EINVAL;
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SDTRIG))
+			rc = kvm_riscv_vcpu_sdtrig_get_csr(vcpu, reg_num, &reg_val);
+		break;
 	default:
 		rc = -ENOENT;
 		break;
@@ -545,6 +578,11 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
 			rc = kvm_riscv_vcpu_smstateen_set_csr(vcpu, reg_num,
 							      reg_val);
 		break;
+	case KVM_REG_RISCV_CSR_SDTRIG:
+		rc = -EINVAL;
+		if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SDTRIG))
+			rc = kvm_riscv_vcpu_sdtrig_set_csr(vcpu, reg_num, reg_val);
+		break;
 	default:
 		rc = -ENOENT;
 		break;
@@ -803,6 +841,8 @@ static inline unsigned long num_csr_regs(const struct kvm_vcpu *vcpu)
 		n += sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
 	if (riscv_isa_extension_available(vcpu->arch.isa, SMSTATEEN))
 		n += sizeof(struct kvm_riscv_smstateen_csr) / sizeof(unsigned long);
+	if (riscv_isa_extension_available(vcpu->arch.isa, SDTRIG))
+		n += sizeof(struct kvm_riscv_sdtrig_csr) / sizeof(unsigned long);
 
 	return n;
 }
@@ -811,7 +851,7 @@ static int copy_csr_reg_indices(const struct kvm_vcpu *vcpu,
 				u64 __user *uindices)
 {
 	int n1 = sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
-	int n2 = 0, n3 = 0;
+	int n2 = 0, n3 = 0, n4 = 0;
 
 	/* copy general csr regs */
 	for (int i = 0; i < n1; i++) {
@@ -863,7 +903,25 @@ static int copy_csr_reg_indices(const struct kvm_vcpu *vcpu,
 		}
 	}
 
-	return n1 + n2 + n3;
+	/* copy Sdtrig csr regs */
+	if (riscv_isa_extension_available(vcpu->arch.isa, SDTRIG)) {
+		n4 = sizeof(struct kvm_riscv_sdtrig_csr) / sizeof(unsigned long);
+
+		for (int i = 0; i < n4; i++) {
+			u64 size = IS_ENABLED(CONFIG_32BIT) ?
+				   KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+			u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_CSR |
+					  KVM_REG_RISCV_CSR_SDTRIG | i;
+
+			if (uindices) {
+				if (put_user(reg, uindices))
+					return -EFAULT;
+				uindices++;
+			}
+		}
+	}
+
+	return n1 + n2 + n3 + n4;
 }
 
 static inline unsigned long num_timer_regs(void)

-- 
2.43.2


