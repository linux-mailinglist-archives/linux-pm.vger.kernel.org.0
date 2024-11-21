Return-Path: <linux-pm+bounces-17900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D430E9D52EE
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CB51F22C3B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3E51DEFC8;
	Thu, 21 Nov 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTkCW21K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9B1DE8A7
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215207; cv=none; b=kAsKyETHXWj2exHm2uJajabTySkh4zy8bF3TAeE5ptyqSyfQBMeEciJKTY3wWjkTzUDgiFqjROASZfQ+OQmHxYPXAJSsmwa35YAGcVLP7u/mDPpJzdRNRJv3TZFWmD+c3TxrfVtKSfLDRgLZrM4ePBjJoyzRFDHOJX9dKRwqP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215207; c=relaxed/simple;
	bh=zQeHQQYxmX3ZzHTtjiFSFfyrCaL0bw/h5dOSf2uFEmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FDnZRqE6Ru6YP4DgI0XvflEFxWYMy4XJdogpCcSmvW7f5OXJI8w2XVRwvZTGLEFWiz5HYRnkzMO9NwtPqpQVHITLNCYwepU6qKPrbZv2e32IKUOtEwhu41xFI0xpmtUF6ocqCBARuf2PNpXusJePFeQaEej6Hhi7Xjs2HYHBXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTkCW21K; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293150c2c6so2280791276.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215204; x=1732820004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wBqsFsDnuHLstZ7Qk2AL8tKHRSfdoFWPpSV+NKxD0lI=;
        b=pTkCW21KMEF2eNcLmI8jpilUsPe92gbjskvw4jUohMNmebEwTMwNdH4BERGVqMh8h5
         xy3ZSu5oy3TYxB1rJ2BuDyC6VtISayiRfobC803jLPxzRX85kbmEqSA4XBgYT1uDV1AX
         BdIphr/jnwCb2lilObf/R4ZK6TVohe+7d5m9N7qzJq4rkOfvkrTd8snZmVof0GuTC3cO
         E/fS5UKY0tYTwZpJtgjjOyGFIUNLZB6GvobHG/t33ImuoGfPaVw0RmNK6bKk4oPV7nJr
         EKuTtGRY4JDTG1l0q2EsgN0ZvHazTc29Y0QeX0Vpz2UNUav/vTdTMf783pEPRx3mHI+S
         dB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215204; x=1732820004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBqsFsDnuHLstZ7Qk2AL8tKHRSfdoFWPpSV+NKxD0lI=;
        b=HsmXsfl/kyYKuEO+OYAdmwJFOVqmxyPpzBf305LPjvCuKvtmpoxxslv2d44NXdSwcd
         pGOMptszkmuLiY9sqy1Zffb1LegZY2gUUhZL45AVmAm6K8m499U0GfYAi9CGMafiavIb
         FVON6UpoiHfE8k3vR3CVJDf5c2kpFeuygck4tThq6jO8y+bItOU0w82amY3sh709iCpb
         s/SqRvJ3FNWxMx8b09qHVMGwxYsUDGQwIvlPUNt8zO5KgSV5pIRbMXmlE7cET/i9zn/f
         QEoWWdrFDQ7PiHrJoOUt5leMRVtiulnRajU5N4l9s7m0zR1iP6hrTNy09nnKklPGxvJ7
         iY2A==
X-Forwarded-Encrypted: i=1; AJvYcCXZe11R3A43UQqNd1wAAe8TMpQPzOMXtadEavLUUcHQqJFQbfjyRcWcSgx0lfxFmW+uKLgsrvIb0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIYWgzMn5iYS//n+vh5e/UyZOlMb/ZResiPcQyL6/hIMcbgRX
	VayreDJZjVSGva75Uxu+/wfoRdTuCMvx1sWgmmestmtux41pFLdAH0Nfsjsy7CzrdgodnfW5fQQ
	nzByujg==
X-Google-Smtp-Source: AGHT+IFR7b00AVpq3w7NzmU3QLKaMUDgzjZ3a4b8x79R2STg6s1+R4EedNLCWPd00E0OkIf55MhuejUtLDkw
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a25:8250:0:b0:e33:104c:fac8 with SMTP id
 3f1490d57ef6-e38cb748645mr3108276.7.1732215204400; Thu, 21 Nov 2024 10:53:24
 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu, 21 Nov 2024 18:52:56 +0000
In-Reply-To: <20241121185315.3416855-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121185315.3416855-1-mizhang@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121185315.3416855-5-mizhang@google.com>
Subject: [RFC PATCH 04/22] x86/msr: Adjust remote reads of IA32_[AM]PERF by
 the per-cpu host offset
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

When reading IA32_APERF or IA32_MPERF remotely via /dev/cpu/*/msr,
account for any offset between the hardware MSR value and the true
host value. This ensures tools like turbostat get correct host values
even when the hardware MSRs contain guest values.

Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/lib/msr-smp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index acd463d887e1c..43c5d21e840fb 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -4,6 +4,15 @@
 #include <linux/smp.h>
 #include <linux/completion.h>
 #include <asm/msr.h>
+#include <asm/topology.h>
+
+static void adjust_host_aperfmperf(u32 msr_no, struct msr *reg)
+{
+	if (msr_no == MSR_IA32_APERF)
+		reg->q += this_cpu_read(host_aperf_offset);
+	else if (msr_no == MSR_IA32_MPERF)
+		reg->q += this_cpu_read(host_mperf_offset);
+}
 
 static void __rdmsr_on_cpu(void *info)
 {
@@ -16,6 +25,7 @@ static void __rdmsr_on_cpu(void *info)
 		reg = &rv->reg;
 
 	rdmsr(rv->msr_no, reg->l, reg->h);
+	adjust_host_aperfmperf(rv->msr_no, reg);
 }
 
 static void __wrmsr_on_cpu(void *info)
@@ -154,6 +164,7 @@ static void __rdmsr_safe_on_cpu(void *info)
 	struct msr_info_completion *rv = info;
 
 	rv->msr.err = rdmsr_safe(rv->msr.msr_no, &rv->msr.reg.l, &rv->msr.reg.h);
+	adjust_host_aperfmperf(rv->msr.msr_no, &rv->msr.reg);
 	complete(&rv->done);
 }
 
-- 
2.47.0.371.ga323438b13-goog


