Return-Path: <linux-pm+bounces-17907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35249D5306
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A2E281BC0
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374371E0496;
	Thu, 21 Nov 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eszvWBeW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7031DFE3F
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215217; cv=none; b=oiPvmhmtVsF5EhCUGBI8lEHSaLybQehGJmrQG8UhFfZQ0qQvF0FHte4bYN+oKAJuw54Yj3FypTIqCcaHk0vlqbwaz2tisTMJTZzx9QHmCN3yC83Mf9wP6/5dRYR4qiYSZwJeFyBU73LldP+c8uPbi1bPGp68i6/SBH0DIbZJSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215217; c=relaxed/simple;
	bh=+gdgcWuh2O/6zKqknikKz3/xyPeXXjH9mYNuZaRDZ6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SIahFH9KsAoHSnWGpF27cbgoOwT0n09U+3ooFXIqqVxVq6ovTOEBFC+z7kqHcePa/fmzJIKZ0v9DIqn8240nkVn5y1sfu0c84jO7K+pZuK4u1ui/5bZQtEQdWOYPmo20/h+B/TfS1LnnQZXiL/K2NaKTumB3XkURuvZHc+9KGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eszvWBeW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee6c2b65b9so21204647b3.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215215; x=1732820015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QkbV9zrukS41fr5Vait1KqXFkmbxs1DpuaY1AHu1I4U=;
        b=eszvWBeW9u5rRdTypyScDpDEZTsZzFJGx68Js6hEBmg/WkgglnL5/STwBMJ3OjLTRo
         Eoj43QIbw2eMoU0VuDtMJ81dyqxj5QxSSo+CJesbqH/kUsMskNsn41z4LDQxoN0T53Lc
         apHyyk61gey1jhE1gpfDSfCm5VfBN5sjA8cizefrhRHAkpZz7jX8BNJpmcDNbN1mbzsi
         WsD+ILXhlG4IHXJQK2ogUA0rOrjgyaZDLaIhHEVZAUjnP5BbSU3CVCav03UZxDeCG34R
         119x/Wd9ZQ4duW2C34jxb3sWdPHDC1CqxtCRrPeby2Pua+igQsI+GnaiPZoeFn2UJ6mI
         U5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215215; x=1732820015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkbV9zrukS41fr5Vait1KqXFkmbxs1DpuaY1AHu1I4U=;
        b=R/XW0bQ35zfZXjgSRfeu+Zsb2gJQyw2bYB7wZXsQUIjtQBZVc8yfh544VB4xs6DHWK
         BnVxuL11Q87Ons4KdEFd5JUEnI0PUy1V32gDNxiAMbJY6x53jRLCsqVd5eL7XgrvLTsa
         B85yAsyNcjdBjB5mnoscWvbrsx9ULxWO31E3LEkPRDWv1yor9IWKIKodHed4uiyGUdrc
         NEsUuTFq2kQ42Le8kZ3MzY5969islw2WNBz7BqfP0ymAmez4OgbSc3m9/S28e5kwSZVf
         a3ycdQsb3oaNrS0ctdZQ7TyPbAtoSaAgmOSeDdg6eYPxDgZ0Jx2PnlYXsPpcwqRFZXbE
         Xxtg==
X-Forwarded-Encrypted: i=1; AJvYcCWlLA722pTRuocF1AgOQ3fltzfzoRa67lSJUraVSNzM7y3kqL/Ubq0jglvbxytZ0Ujf3ufP8Dbd4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFI1Y2b/Jh+WDLrYNBxeDMfQyFxEM6ns3Xo4LokIvMBEI2fX6Y
	tu6e1Mxv+nxr2gcmicwsvb+ld0Ie+13eRJFFanCsLGP4tAtkKmyzH+3hORzs+8UcMF3B9eRulFf
	aimWhNw==
X-Google-Smtp-Source: AGHT+IGIRJlHME06OCdzxklPerNVnkfO0fBICJYLbM7Zc7eo9Fha71pf7btmtjGjjQ8kbPxByDae0pN7Tpyh
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:690c:fce:b0:6ee:3b47:59a3 with SMTP id
 00721157ae682-6eee08a86fdmr2087b3.2.1732215214711; Thu, 21 Nov 2024 10:53:34
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:53:02 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-11-mizhang@google.com>
Subject: [RFC PATCH 10/22] KVM: x86: Make APERFMPERF a governed feature
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

KVM must verify both host support and guest CPUID enumeration before
enabling guest access to APERFMPERF.

This verification is deferred until the implementation of guest
APERFMPERF is complete.

This declaration enables "guest_can_use(vcpu,
X86_FEATURE_APERFMPERF)". Otherwise, that expression results in a
compile-time error.

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/governed_features.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index ad463b1ed4e4a..fa77d655d2355 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -17,6 +17,7 @@ KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
 KVM_GOVERNED_X86_FEATURE(VGIF)
 KVM_GOVERNED_X86_FEATURE(VNMI)
 KVM_GOVERNED_X86_FEATURE(LAM)
+KVM_GOVERNED_X86_FEATURE(APERFMPERF)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
-- 
2.47.0.371.ga323438b13-goog


