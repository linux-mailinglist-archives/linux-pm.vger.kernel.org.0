Return-Path: <linux-pm+bounces-17919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98EC9D532F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3267CB296A3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601A1E47C6;
	Thu, 21 Nov 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBvZSRdW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A461E4101
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215239; cv=none; b=MlAhfVRJe8sKBiR+m97u42dyKyRg7tRwUvjSKpE8TulDXWgv10qBKkcWUQKlu3ST/MUCxZxJzYfTMp/sWzww9vz1tZuUD7gjDIlxlCrIqieMvn4KHNCx+QUReQNFxRY8QycVS2AXKonrAjWZSyAy+sphFVQOwap63SYQxxr+bTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215239; c=relaxed/simple;
	bh=+IEAVeNUG4Wwg4+URCtcn5c0HktTlRe4I+YksLsQipM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZYz9lW8xKiNzWaRl4u/ea82mjSyigEZYDMDuyPLBBrgZYvJHYG5Fc71Wcp1bnFAR9AIEHlAH+FWXQD/P3GxClizvjJ/KZNUQDjHosdDyaXPnrOOhGapn3oIqzja7Z3MRcjt9AurHp1LnmtqwzmKdHSDWIuMjZBUh4cFnCSi63Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBvZSRdW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3884e5e828so2179582276.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215236; x=1732820036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gotUN9en8Y0fM6dWMvs2gnDnz6g25DbjxDMa+m4kWZA=;
        b=fBvZSRdWkJzqhgJFySJ/5j+Ob+y+qFT6F8PvOequJBzv91rnJKEBBSM1G2qcasTX+S
         2ZAZPX57xzIs1m6ZDgrzMCxzWBrcOZG20biKtecqY5bY6lCVNaZi6KpupnwOWJgvN7xC
         3N7qWsOfDgPkaqHg2Ele6txJvt0v+xxvbnSrPLiTYMr6AfRd6FrAg8bJQWgHgDGNnvhE
         nPuANWArzUQrM9sblqCRccDObnUy9TurbQSFyixwjFApMFddtW3v24gvapHwz56LBArP
         LudZdNXfCqZ2jbHNSzIxqE0zJW/haaE/5JbQnvdBSnMU9QHy+q3x5kOoD6RqiBz6Geok
         OOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215236; x=1732820036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gotUN9en8Y0fM6dWMvs2gnDnz6g25DbjxDMa+m4kWZA=;
        b=CphkirLlCYhOCpMEmBhcBCl0o1YEGeUOc3Ez55E7bQOiCk2ENuFHqasKvVtCHT+NxE
         AshhZvBI0wlBWBD2xHK0sCBK8A4SpYVluO3RxEXVzf/cfD5wmhxx4j4t4PKNWeRllTFs
         bZvhQEsMj/rBu23wVp2oAgg4925Fh/gIyBQkjCWhB1nbYN4Pa6tDADIep11KAb76QYKj
         wh++GI4RNtPr471IuJn1XwNviojhsPFjwdu127BsK5T6w+RYMLVUFA2YVfVUt42DwTzm
         o2Oy6/xOZ61s7bXHYyGEGrloQgp5d9EK9v9sldkP8wxTFtWQtmUyeyp/ZL8+hpl8hGfI
         YluQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlkzAwW4eCCA/13GeZYa66ZUGNhawnM2v9ohUw+4/IkJlt013txllJmEck548nm5sgIi798D9qPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbz67XR7XcODNA+Xx8wCfboG/cC6WDEw/YQTAag1TXqSRkPGq5
	0SQvYZSAN2lkBRJjcQfHUY3Yu/7PRbf3jXWNyVf7PCN9PRmL9eamNnDCDKRV4SXQqpKlyOUCIcS
	pHxN/CQ==
X-Google-Smtp-Source: AGHT+IEW6YOy45p6Yk1pt6xc1BV0LA1vh8Rz0MnfiWsd57OUw2v6XIc4MXun1tG0SfU3T/pcelgNrQXa7DSZ
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a25:d890:0:b0:e38:b443:99e6 with SMTP id
 3f1490d57ef6-e38cb72ee91mr9764276.9.1732215235622; Thu, 21 Nov 2024 10:53:55
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:14 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-23-mizhang@google.com>
Subject: [RFC PATCH 22/22] KVM: x86: Enable guest usage of X86_FEATURE_APERFMPERF
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Perry Yuan <perry.yuan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable support for IA32_APERF/IA32_MPERF performance monitoring in KVM
guests. These MSRs allow guests to measure their effective CPU
frequency by comparing actual CPU cycles (APERF) against reference
cycles (MPERF).

Only expose X86_FEATURE_APERFMPERF to guests when the host has both
CONSTANT_TSC and NONSTOP_TSC. These features ensure the TSC frequency
remains stable across C-states and P-states, which is necessary for
"background" MPERF accounting.

Guest TSC scaling via KVM_SET_TSC_KHZ is not supported:
- On Intel, IA32_MPERF ticks at host rate regardless of guest TSC
  scaling, making passthrough impossible without intercepting reads
- On AMD, guest TSC scaling does affect IA32_MPERF reads, but handling
  it would significantly complicate cycle accounting

Record host support in kvm_cpu_caps[], advertise the feature to
userspace via CPUID.06H:ECX, and enable the governed feature when
supported by both host and guest CPUID.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 41786b834b163..309fa7fef6b7b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -399,6 +399,10 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	kvm_hv_set_cpuid(vcpu, kvm_cpuid_has_hyperv(vcpu->arch.cpuid_entries,
 						    vcpu->arch.cpuid_nent));
 
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_APERFMPERF);
+
 	/* Invoke the vendor callback only after the above state is updated. */
 	kvm_x86_call(vcpu_after_set_cpuid)(vcpu);
 
@@ -697,6 +701,12 @@ void kvm_set_cpu_caps(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
 		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
 
+	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
+	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+		kvm_cpu_cap_init_kvm_defined(CPUID_6_ECX, F(APERFMPERF));
+	else
+		kvm_cpu_cap_init_kvm_defined(CPUID_6_ECX, 0);
+
 	kvm_cpu_cap_mask(CPUID_7_1_EAX,
 		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) |
 		F(FZRM) | F(FSRS) | F(FSRC) |
@@ -993,7 +1003,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	case 6: /* Thermal management */
 		entry->eax = 0x4; /* allow ARAT */
 		entry->ebx = 0;
-		entry->ecx = 0;
+		cpuid_entry_override(entry, CPUID_6_ECX);
 		entry->edx = 0;
 		break;
 	/* function 7 has additional index. */
-- 
2.47.0.371.ga323438b13-goog


