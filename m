Return-Path: <linux-pm+bounces-17905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B919D52FB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB481F2305E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CA01DFE02;
	Thu, 21 Nov 2024 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6Wb3y92"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1E1DF98A
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215213; cv=none; b=jnkvJ80vNfkfCVIV4cheIrkktPCJpPuwm/VWBF5l/KGObe74TuNomdbUZGuKazOZAJ1bcvKNIJ291hT4+ZvCX31QYtZ4+fC/QCm8yRoGGT+VN+0fhU4TWkRoF/uPUQukEY25awlikqR54M3KCZ+AK1iRumoxMmQaFe5HmCIyl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215213; c=relaxed/simple;
	bh=AdrfMvymD5zuRqTBBGGoWNJ0DY8WVGxpVB1lhy6aBew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfOnDEVisQSr/icVg75+i8Eqb9L0NFpfrvtOyp3r4HaNA3Ihq4wqUKEimgB2MCFiT8JoPUMF7ap9DEvbRxQO+hdRSyAvFIOxXFvRP2+N31QMKt2m7XyWdkE8QELDP4guN8sh92RDQTKLLKZJWXEXMcFF3CkQkMNObVDJYAlynnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6Wb3y92; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eebd4e7cc5so14915787b3.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215211; x=1732820011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w7D09IdaThZ8r32cYXtPxjnC2nPk7QEMmJJMfReh37c=;
        b=c6Wb3y92jN9o1wPhx1H+KZtjUhOaBjvDEfYVw+FCK3DHZdtS6/wyXVHkn1aWAbJoQ2
         R1pkXJaSF5eibHaUkPoqxUKHZG/cqM13vXaDgvodrGHxiywJKY/NSVA0YNQ6a+cOh1kX
         RgHGXskBmN0IqFYn0xFDxZVFplviQmfREwjmAweHplMDxCDWjnGsIpRubdCLnEeAeKZ+
         ttEeYWv+dA0CRLP7DrOKbfN7TCvDdI0H7iEbGFMTO4yxqqyqcemDkD8P9Kzg3/9DNCwA
         T7J8MX5oaA2r5QoZjSE3Fy9nJsZ6oaCUtQP7EbQGheA8e1DCPGfnWzqsCdlQyMaCsoPj
         qgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215211; x=1732820011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7D09IdaThZ8r32cYXtPxjnC2nPk7QEMmJJMfReh37c=;
        b=mW/TsqVJmM+cH18R8hL+kISQhaWGCTb5bcVMcdq7PaprbPeoqMvIW10whkb5TRG+bG
         r0ixK0r0FXhS0BnnHDMZzTOv2JK0Zr7XbFH9r9DrPooVk5D5EHNVhxrbqlJ+TeYek2dN
         rbjbxAHrJG1ksQPL4nO5r9t1RPRjwZJ2zeEff7XS2N+1xPXtK2IlC0X78elrtuSC1F3n
         a4ZHUh/h8vcM7Vr1Prx1mR13jzxgov1SFbUMkWkB1/pPI3um9yqAt6ovWTM4rHbznOvg
         0e1VsGO+L53XOohQFk5MIukiXPZfGC6e5FM9Pajkn0y+CY6dzszd8E0Xd6cuvY1Stt9Q
         h4+g==
X-Forwarded-Encrypted: i=1; AJvYcCXM2SL8Tcdkno5uBX2I8IVX6IFybM+0uK0y9JRUwuKAMjAA+HVBqMlScMbx8w1D6TmCfNrdU2+Cvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpuMWlGQigK28C4h4BdbU+N3SdSsVUBzySbSbKiv5IJPS1LzM
	bbVDoGHa2FlsxN6Itftk8igv4kIE6NevdT2GGHn2gVEURhIk8J7vC8HcjnOGqOCeLz9dw1i9ido
	gN+fx0A==
X-Google-Smtp-Source: AGHT+IFbxnZIDPmwz4a6QDx5WTc3XPCOUOGBb+6SCxkWJJgfTYLxgm8qVWZQaaUmH8BKA4bQqcQX6mWx6Kh8
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a81:a742:0:b0:6ee:a2b0:a803 with SMTP id
 00721157ae682-6eecd2b215emr527187b3.1.1732215211264; Thu, 21 Nov 2024
 10:53:31 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:00 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-9-mizhang@google.com>
Subject: [RFC PATCH 08/22] KVM: nVMX: Nested VM-exit may transition from
 HALTED to RUNNABLE
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

From: Jim Mattson <jmattson@google.com>

When a halted vCPU is awakened by a nested event, it might have been
the target of a previous KVM_HC_KICK_CPU hypercall, in which case
pv_unhalted would be set. This flag should be cleared before the next
HLT instruction, as kvm_vcpu_has_events() would otherwise return true
and prevent the vCPU from entering the halt state.

Use kvm_vcpu_make_runnable() to ensure consistent handling of the
HALTED to RUNNABLE state transition.

Fixes: b6b8a1451fc4 ("KVM: nVMX: Rework interception of IRQs and NMIs")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 931a7361c30f2..202eacfd87036 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5048,7 +5048,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
 
 	/* in case we halted in L2 */
-	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
+	kvm_vcpu_make_runnable(vcpu);
 
 	if (likely(!vmx->fail)) {
 		if (vm_exit_reason != -1)
-- 
2.47.0.371.ga323438b13-goog


