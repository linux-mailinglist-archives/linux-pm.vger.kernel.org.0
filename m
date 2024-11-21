Return-Path: <linux-pm+bounces-17904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D649D52F9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5601F21040
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4661DF995;
	Thu, 21 Nov 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmRG4+Du"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255B1DF731
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215212; cv=none; b=VugVkMIZesad2Zr/arCU6Nxu5UhsUuxTgN7qCH2fCs6Y5KTLIspnhwhpTywcZ0A0djbBBBPrXRj9y4M14+nlmJfZIBUhrCphWzkKiy8BbM1iZ/Js+TuLTBhUU424WTM53RD2YJFNU/INrQJ2BHQASjFic4Fkps1tyZwIhi20by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215212; c=relaxed/simple;
	bh=HIwgyq0n9Pc6IQ1JW0mNNbc4Q1w8gUiM8GLpxz3MNio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uqauNA4MCwbNdLmVqrtCgaKxeeeR7MykYsrIUoitJe+1Ke79IvlkZhjl79S6tEQ1mWlV3DTkP3GCj8IVE/k86dLTNRZLCdWCbI+B90poRI8mVzewmvOw/obvA5/ysQKDoP2SCEzkAIhKLJW8X9blT2vihZYiUwVItWMXLJhXnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmRG4+Du; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eeab4be015so21612567b3.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215209; x=1732820009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=179m8kOvQfRqP37wmtAhsMQnswgm0gukoWaPbObarIY=;
        b=ZmRG4+DuMWNCDnDdrGbuILOaPLCIfuysnoc2coDwQ9tvZBu971oWt8QGQk/v0ZG8SB
         lh5yW9bVqyx41EYwpRhDt36BkHYVPtwoBFU9mOdt9BI4okKYZTl0Y60nUhZiUkXKkGnc
         93ejV7dIWXIb3QafDV6dDwcIWoxGsGmwlBmk9vUh3e2EZ6aRHGpO823QSDtTPjf1VWTp
         4K7z+Gd2pl7/RRaZ/yK1kZVyAxuPbfBXYG55UrptpxAvdQNMc1mU7XR3ZDQL1lPPiRtY
         hYJwGYmF0PTApfT5w1xPuVXyEkO1p2x06sKtUegp7cX4vLjMdy0J7luuiyXrV9yV8mXw
         aBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215209; x=1732820009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=179m8kOvQfRqP37wmtAhsMQnswgm0gukoWaPbObarIY=;
        b=MTaP6YpJUksp7PJ5KKfTsVOuLqGuMWN0GD70hFuAppYBFMZ3YDmesWimJV6MBFFFll
         xVuTgfgIXeqGjPDk16mC3zzGs3x5YCcpxnsnmQmHBJQidTW+N/C1rCP38MVO7XG4uBE4
         4N2rhh38BohbrDs1tZLuvV/8iaTQYMrk8i3Fz+9glw11GQDVJHJ/2LmTQuKOkgD9UJns
         XbsudI3jMpw5H9sNpb/AcHKpW+XeEyQlrnKwRjl77uXbQVy6HY7KcGuylpYg51eTVHUY
         lLy55+mr8sQbdsHOrw9u/+qYA3YCMKS0q1lktXDEpOD8J2NOJubo7BD6t30HM2S71vLG
         4hqg==
X-Forwarded-Encrypted: i=1; AJvYcCWBAZYKTQ7XTleDgk81APPjz7goQ3lVIsdiNYLre5xfswVKGBQ0ESHIHaLRgLnEC1sTBHmdriQ6+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpJ8T7GMQLtUQX0QbJw4+Uv+q1SkzACBIOTWBCCru1mCQToZ9
	zMyO7ntd79lypXUecwAWOOzHHhG2VlNdFERGLrqDLehgiGlqDjr1EUDS505rY2MH4sObkdspR5t
	zM2DyhA==
X-Google-Smtp-Source: AGHT+IHDdAZrVVVtQkbNY+ODhRentmxWbP6Rfzn5FkbIRQBeRGy86k9mMoUCty77jPdE55ldMhNkDkbK1cVV
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:690c:4b07:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-6eee0a26d5emr29857b3.4.1732215209587; Thu, 21 Nov 2024 10:53:29
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:59 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-8-mizhang@google.com>
Subject: [RFC PATCH 07/22] KVM: nSVM: Nested #VMEXIT may transition from
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

Fixes: 38c0b192bd6d ("KVM: SVM: leave halted state on vmexit")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cf84103ce38b9..49e6cdfeac4da 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -994,7 +994,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
 	/* in case we halted in L2 */
-	svm->vcpu.arch.mp_state = KVM_MP_STATE_RUNNABLE;
+	kvm_vcpu_make_runnable(vcpu);
 
 	/* Give the current vmcb to the guest */
 
-- 
2.47.0.371.ga323438b13-goog


