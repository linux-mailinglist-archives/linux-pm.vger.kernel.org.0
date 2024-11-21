Return-Path: <linux-pm+bounces-17903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478EE9D52F7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82931F21B11
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE41DF75B;
	Thu, 21 Nov 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Hirfohn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1F1DF26D
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215211; cv=none; b=RVkkRFKgMpCAfTbEQ1rGo7SrISlIwNX854NSFA9IFoiAkzpwvcZEctlWW7bPXNFiWOqXybLjiTwovSYCdywn5vrEMkMmtiIdrfm2RrSy0zHSTvTmycaZL/Vpu1FiqxPR+NQyrBkPzJGL2IKtgfb4aieSUccOj+IOmX2dh7ABz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215211; c=relaxed/simple;
	bh=SxrvpTqqakO+SE1JSfeW2dZ+qSHPbHK7pKymKVP/ZXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iy0hMTaaYexr0uq+ngHxB7cb9d8ARMPbPL8jePOB/0N1gFo1Dr3ywkJOoEjJRITTZwOrGXGoQM2KSO8YFUGLWdDIqvcijyAcLxQlfroEhl3KHsOnGKYYCGPylUlbyynZUutCK2/Bb5jtTRWbBcNm7hhfLJN1+pqlOEyBXkQnhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Hirfohn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eeb8aa2280so20398697b3.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215208; x=1732820008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+b6W97BMpWzJsRkR70E8bmCkFexWmOp62HeJxz267S8=;
        b=3Hirfohnw5OR/d6y1tUuuQruToXiIzqE+NYWUoNDJQrLP2VQqsbreE68+fd9kLwfXL
         0+zqCw8gktyAgpONx00PVqaJMf5boSxD5ffnGZVDiA4/q9z6vd9vIgoEl1XItwAMIxiA
         /ZAfoQADeaal9BKGF5eqCIVJJ0FTop+qjX/LX4lqlK05SgM+YNak8KkZlSR3XYzzuKSb
         jYJ7+zU2ZVxiyMCeJiMW8z15HQceERfGfz3yWAfsAYJniFZ5J5mM5dErHDkxfPaNJ64X
         wY4tm+Cwb8kRHNKPBqX+evyLiQICl8b8eZxii43Y3ZKQ2sgNZwqxFEYxKSYMtSiRGuNK
         pb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215208; x=1732820008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b6W97BMpWzJsRkR70E8bmCkFexWmOp62HeJxz267S8=;
        b=Au3E7rLovgpbzb1rDq4SsgEWBKNszuQ/IZaqqbT4QHSQrKdaftnNCXOtgYU9F9kVAT
         45j+iLoyJVk1OnPIacgqV2XZe1y9EGe4HItljYdUMQv7GIg5pDS0LCsyMc/cMjxQe4W6
         PXAjn3YfKyLHM8No2zgdG2oldrRpXA8cUS341xjfCj/ofByG658e+wW8IoZ5QCxxNFJE
         NaOUKLkrXDe/CD0gVVuVpMZ7SoNDfbLAPz49ewrwcRie4tMublajg2SfwDTR7h6eYKqG
         NHJbKdL2QP433qH4ldyrr5DZEd/YKpqFGyf3M+13hi5zeDTEFfjb+hRh0VpcTlpsXSlO
         BrIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb7Yug3kxDaEnrbHMMeV42t8c09im5cyavhvlV8I8HdWHvQx5We00r8x1S7U5L6El/P657sX3ZmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWPA87MD7jrPNA4DwZLR+kBCGdwBUGMzmfv6/LKQkDdYKCB/rZ
	HCuxzAPQef0+j5Pq02WYXRgBDPiCHg47D7rEBxcA0oQClLhoZPnxrnnf46ah6LZbfhKkyCid5zC
	Di0tCkA==
X-Google-Smtp-Source: AGHT+IHA/LlqfVC4cB578a8wvHBObnhD0lyB5qPv6+RAzcNl/mZXGlIBsUax3fhUb5PzQtIk0zmfwsAkpA1H
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:690c:6709:b0:6e2:1713:bdb5 with SMTP id
 00721157ae682-6eee0a39166mr21687b3.5.1732215208089; Thu, 21 Nov 2024 10:53:28
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:58 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-7-mizhang@google.com>
Subject: [RFC PATCH 06/22] KVM: x86: INIT may transition from HALTED to RUNNABLE
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

When a halted vCPU is awakened by an INIT signal, it might have been
the target of a previous KVM_HC_KICK_CPU hypercall, in which case
pv_unhalted would be set. This flag should be cleared before the next
HLT instruction, as kvm_vcpu_has_events() would otherwise return true
and prevent the vCPU from entering the halt state.

Use kvm_vcpu_make_runnable() to ensure consistent handling of the
HALTED to RUNNABLE state transition.

Fixes: 6aef266c6e17 ("kvm hypervisor : Add a hypercall to KVM hypervisor to support pv-ticketlocks")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/lapic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 95c6beb8ce279..97aa634505306 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3372,9 +3372,8 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 
 	if (test_and_clear_bit(KVM_APIC_INIT, &apic->pending_events)) {
 		kvm_vcpu_reset(vcpu, true);
-		if (kvm_vcpu_is_bsp(apic->vcpu))
-			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
-		else
+		kvm_vcpu_make_runnable(vcpu);
+		if (!kvm_vcpu_is_bsp(apic->vcpu))
 			vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
 	}
 	if (test_and_clear_bit(KVM_APIC_SIPI, &apic->pending_events)) {
-- 
2.47.0.371.ga323438b13-goog


