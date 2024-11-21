Return-Path: <linux-pm+bounces-17909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A079D530D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDF91F23B1F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9841E0DD6;
	Thu, 21 Nov 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iulUX1QA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD91E0B93
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215221; cv=none; b=qMAArbT1uVcWNW1/tDy5sPrLZM3w3ADV3aYcvo6+b22x6Uxt4p3ItEztr1LjvR2pOgVxHiHRGiizeHMlDTKSQPMC+DgGqiKtyPmzqOcjVG3QGkXLXh2Tx+qDQB+3ycKRFUi0V6ZR9TaHSHCcl3yHUu+O5tGaMhQHPbeUOiNOcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215221; c=relaxed/simple;
	bh=J443xY11+FlsZ1O8RFSn4sEVsfffWxAMll4hKwD4QB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ftlCS6cZZHH/hwSfnH1BDhpD04Brur8jDaMEIgauPxxplHwsn9LZl1ChJVgMYyBs9mkFG3OcQmKV5Y2JjV+w3xTqDq0lCJ/FhX5GpslbsQ+/pwYvdT55kwo1ccadtxVg4815fZt5oFApJHRqR4Hbyk9/yQoFJyYyvVibKZX1KP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iulUX1QA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e5a7bd897so1251039b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215219; x=1732820019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf8fZX+l+VoLEVD4pNXnS0cuADuy19dfjl6m0H+bXqc=;
        b=iulUX1QAMitX/+jSG7NTRLVmmstFGc9S3316onneVgEP3o2ky+RLaubbFAwI5YuF99
         pzzIuOpS4a7CU8YORBBJk5K8V33wOgsvhmDz7Oi0yapJl40bXYVWAhop83ZKm/2/wnQs
         SbQSmekbTyBNge6FRpJuuFFY0LrTmjjSfgX2khX7Cyu07Hdurr6kCps+SgUU0t+0XCTs
         lAVET9aMiYtuGVb/pDbhV8Igxi46+FmA1LXu2mQeUlXwDD/CO4hQc6wiP31QZLPo2jNR
         bceTLjHcBLaenZEOhhh44hDyF5k8hZopkLy2Q3+odumVLfY8YKP8G0TB7U4XrsxoiIgK
         LKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215219; x=1732820019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zf8fZX+l+VoLEVD4pNXnS0cuADuy19dfjl6m0H+bXqc=;
        b=T8kFRB9Ws5RArJNpXjIQefiRc3EzLfRrWnvKT/VRUtlU/2UrfKkDw6eH52fRNf6YK7
         7r20bVkEymLOPn+5LuP9sg8c2bSTsYDaJvIS0bBd58aIqBEch6bMi65j/L71Burv7GCG
         IwnVQa4zgzyIYPFYyrdSivQP1M9Nu6eQty/xmWCN3sixZtMxqZfZiNB2gdkRwJLak8S5
         pSpaKrtsgtXMuDvgFEXkb3GvY7+0I/wApQJvSEB9m3GfEINBR1KiRsC40UsVFY8fPRLX
         XMwazD/LnOO8llZpz/dPBHVrzwSj/4JeZ0+qCcIzj9vPn3/Y5U0Ee3+dAfMxuuimEa9b
         JfAg==
X-Forwarded-Encrypted: i=1; AJvYcCUAj0pvrhNJE8ntB1FbyWaKGfQ66JKvodTU3+iHnWAc/aMlMLQBybCap/IsGdZBx3JrLtkJqY7a0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6zlp0KJb/SS2j0VxUxRP8N1uajq4SQnrWi+kqFUFgv+Fgw2kY
	0Fhvbk05iiCXtP7wXLgsGS5Rab4EAFi7lAHdAumE7er9eMk9wdM9HjWmf8isDSp+QM3NNNimGop
	JrtLDEA==
X-Google-Smtp-Source: AGHT+IGYnMzeEjpt0TlemIbCUyvIDYTH0IyT6CjbExrl/UtCJsQ1yD4xmFeiL/4fw9BWaodK87t0RCsIAwvu
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90b:3694:b0:2ea:8548:3818 with SMTP id
 98e67ed59e1d1-2eaca7fa74fmr3986a91.7.1732215218148; Thu, 21 Nov 2024 10:53:38
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:04 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-13-mizhang@google.com>
Subject: [RFC PATCH 12/22] KVM: x86: Load guest [am]perf into hardware MSRs at vcpu_load()
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

For vCPUs with APERFMPERF and in KVM_RUN, load the guest IA32_APERF
and IA32_MPERF values into the hardware MSRs when loading the vCPU,
but only if the vCPU is not halted. For running vCPUs, first add in
any "background" C0 cycles accumulated since the last checkpoint.

Note that for host TSC measurements of background C0 cycles, we assume
IA32_MPERF increments at the same frequency as TSC. While this is true
for all known processors with these MSRs, it is not architecturally
guaranteed.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/x86.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d66cccff13347..b914578718d9c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1918,6 +1918,22 @@ static int kvm_set_msr_ignored_check(struct kvm_vcpu *vcpu,
 				 _kvm_set_msr);
 }
 
+/*
+ * Add elapsed TSC ticks to guest IA32_MPERF while vCPU is in C0 but
+ * not running. Uses TSC instead of host MPERF to include time when
+ * physical CPU is in lower C-states, as guest MPERF should count
+ * whenever vCPU is in C0.  Assumes TSC and MPERF frequencies match.
+ */
+static void kvm_accumulate_background_guest_mperf(struct kvm_vcpu *vcpu)
+{
+	u64 now = rdtsc();
+	s64 tsc_delta = now - vcpu->arch.aperfmperf.host_tsc;
+
+	if (tsc_delta > 0)
+		vcpu->arch.aperfmperf.guest_mperf += tsc_delta;
+	vcpu->arch.aperfmperf.host_tsc = now;
+}
+
 /*
  * Read the MSR specified by @index into @data.  Select MSR specific fault
  * checks are bypassed if @host_initiated is %true.
@@ -4980,6 +4996,19 @@ static bool need_emulate_wbinvd(struct kvm_vcpu *vcpu)
 	return kvm_arch_has_noncoherent_dma(vcpu->kvm);
 }
 
+static void kvm_load_guest_aperfmperf(struct kvm_vcpu *vcpu, bool update_mperf)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (update_mperf)
+		kvm_accumulate_background_guest_mperf(vcpu);
+	set_guest_aperf(vcpu->arch.aperfmperf.guest_aperf);
+	set_guest_mperf(vcpu->arch.aperfmperf.guest_mperf);
+	vcpu->arch.aperfmperf.loaded_while_running = true;
+	local_irq_restore(flags);
+}
+
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -5039,6 +5068,12 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		vcpu->cpu = cpu;
 	}
 
+	if (vcpu->wants_to_run &&
+	    guest_can_use(vcpu, X86_FEATURE_APERFMPERF) &&
+	    (vcpu->scheduled_out ? vcpu->arch.aperfmperf.loaded_while_running :
+	     (vcpu->arch.mp_state != KVM_MP_STATE_HALTED)))
+		kvm_load_guest_aperfmperf(vcpu, true);
+
 	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 }
 
-- 
2.47.0.371.ga323438b13-goog


