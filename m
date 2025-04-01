Return-Path: <linux-pm+bounces-24705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2CA77E09
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0263F3AFD90
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC521204F6B;
	Tue,  1 Apr 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jz7A4Din"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFB204F6A;
	Tue,  1 Apr 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518449; cv=none; b=JvLveu9IQJPb6AURcCYWc7Zvb/7mOjNTfaOizVjfiuQ8EevM6/Urg6SSdGak53DwCPwPgrLb9OTFp/IgXqVteeacBZzrjGEHsoqSp6gClK7tEC0yOS9xphL62UpQKZQu9UseDaCBym9g82VwwQ0TJPH3l4os1MrJGQ07LpmipjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518449; c=relaxed/simple;
	bh=Mu9MHZa3fft97on/5nyitcoLVmWrL9uWsEPwIreNy8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XL6ngi2WR62ZOX5/N1jYthNTf/QYsXbD/YykwAa1lCus5mzC9LZvOyxMPiVY316CYEwjkvrSkifuukEJOi9hQy68XLam8idhYjphghnAoVBAC0GeOhPiOHpWHTkvU2M2A+aPQn8R2Xp3kIv6R3gawNBm0Gl+FbHMWCxtVuIaRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Jz7A4Din; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 531Edwfb3790452
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 1 Apr 2025 07:39:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 531Edwfb3790452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1743518399;
	bh=ZcgxQiKrDYB/GpBLGYEzKqgEh7UmE7j84JDP2jnMUIY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Jz7A4DinHGlQDcHQcNzNjsQopdBFsBQ7QUgSGXfKBsLhOGsq7mA8gv1rXwCFVS/Mg
	 3HpHcFgEu7wLsCmPzMMIYUdsFbrSO6E1SQWqCu3eg1YhfuI3psqy9zmXT9M57TG/rw
	 +0LvJkVNxTMwPWC0cYpvvyQj0Fc3RpmLVm5h7OAE+L6WCfmGPgpZff661s9zCmb0Wo
	 ES6YqJpgUXXGCb1ZxYA+05YjHAbwrqUx72zaxCmQsKTlnOXJyi2zK8Oi4PIb82zl9a
	 3JJfvEXa8iQg2SKYnL+qJHwHt+ly0vUL6rJD8fhrxhYUShn7QeNSB9fUeLGt+DOFn/
	 jZVYMbG7KGklQ==
Date: Tue, 01 Apr 2025 07:39:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Xin Li (Intel)" <xin@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: rafael@kernel.org, pavel@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        luto@kernel.org, brgerst@gmail.com, jgross@suse.com,
        torvalds@linux-foundation.org, xi.pardee@intel.com,
        todd.e.brandt@intel.com, xin@zytor.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_x86/fred=3A_Fix_system?=
 =?US-ASCII?Q?_hang_during_S4_resume_with_FRED_enabled?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250401075728.3626147-1-xin@zytor.com>
References: <20250401075728.3626147-1-xin@zytor.com>
Message-ID: <2C7E3D1D-0391-43DF-8D72-02C4C742573F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 1, 2025 12:57:27 AM PDT, "Xin Li (Intel)" <xin@zytor=2Ecom> wrote:
>Upon a wakeup from S4, the restore kernel starts and initializes the
>FRED MSRs as needed from its perspective=2E  It then loads a hibernation
>image, including the image kernel, and attempts to load image pages
>directly into their original page frames used before hibernation unless
>those frames are currently in use=2E  Once all pages are moved to their
>original locations, it jumps to a "trampoline" page in the image kernel=
=2E
>
>At this point, the image kernel takes control, but the FRED MSRs still
>contain values set by the restore kernel, which may differ from those
>set by the image kernel before hibernation=2E  Therefore, the image kerne=
l
>must ensure the FRED MSRs have the same values as before hibernation=2E
>Since these values depend only on the location of the kernel text and
>data, they can be recomputed from scratch=2E
>
>Reported-by: Xi Pardee <xi=2Epardee@intel=2Ecom>
>Reported-by: Todd Brandt <todd=2Ee=2Ebrandt@intel=2Ecom>
>Suggested-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>Tested-by: Todd Brandt <todd=2Ee=2Ebrandt@intel=2Ecom>
>Cc: Andy Lutomirski <luto@kernel=2Eorg>
>Cc: Brian Gerst <brgerst@gmail=2Ecom>
>Cc: Juergen Gross <jgross@suse=2Ecom>
>Cc: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>Cc: stable@vger=2Ekernel=2Eorg # 6=2E9+
>---
>
>Change in v2:
>* Rewrite the change log and in-code comments based on Rafael's feedback=
=2E
>---
> arch/x86/power/cpu=2Ec | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/arch/x86/power/cpu=2Ec b/arch/x86/power/cpu=2Ec
>index 63230ff8cf4f=2E=2E08e76a5ca155 100644
>--- a/arch/x86/power/cpu=2Ec
>+++ b/arch/x86/power/cpu=2Ec
>@@ -27,6 +27,7 @@
> #include <asm/mmu_context=2Eh>
> #include <asm/cpu_device_id=2Eh>
> #include <asm/microcode=2Eh>
>+#include <asm/fred=2Eh>
>=20
> #ifdef CONFIG_X86_32
> __visible unsigned long saved_context_ebx;
>@@ -231,6 +232,19 @@ static void notrace __restore_processor_state(struct=
 saved_context *ctxt)
> 	 */
> #ifdef CONFIG_X86_64
> 	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
>+
>+	/*
>+	 * Reinitialize FRED to ensure the FRED MSRs contain the same values
>+	 * as before hibernation=2E
>+	 *
>+	 * Note, the setup of FRED RSPs requires access to percpu data
>+	 * structures=2E  Therefore, FRED reinitialization can only occur after
>+	 * the percpu access pointer (i=2Ee=2E, MSR_GS_BASE) is restored=2E
>+	 */
>+	if (ctxt->cr4 & X86_CR4_FRED) {
>+		cpu_init_fred_exceptions();
>+		cpu_init_fred_rsps();
>+	}
> #else
> 	loadsegment(fs, __KERNEL_PERCPU);
> #endif
>
>base-commit: 535bd326c5657fe570f41b1f76941e449d9e2062

Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

