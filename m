Return-Path: <linux-pm+bounces-14708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE379862F6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575F628BC81
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F1193067;
	Wed, 25 Sep 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wb3LCK7b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EE192B90
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276562; cv=none; b=cN+N67OYTxeqW7/k/nYd+LfeovPKbWydv/QK4UZtFKHc8a73Duk72ZwDi9NfBa8LVEqL6jFZ1rKEs10Ofpie9rQrvOm+k9BumuNw0O+GP8Hl57sfVPMerpJvZW2U8OEUs22EYe0FW6ICYU8D0itQaifearKd6mazpY65bUWmHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276562; c=relaxed/simple;
	bh=jP/irMOJlRaYkkcw0c6zTUJt0fVtAuXqgia734+CBv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lKZFsH4nuQXnQYSaNEGhm5Z7E0sPd9pqWnTo1q33FuJ3jwuLgEH4HGvooKGaoWm3+i3ubfB0oTLajCDZR7EWz5Bf1W7HgjtjLoaLsnQbQB4VsbNVSPA1YaIc2XP7wlm1Hht1k3pEUZy0org5wbjPFFPkiHfe177/AS34j6cYTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wb3LCK7b; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42cceb06940so47939195e9.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276558; x=1727881358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=If2fzGYCGwBnqYyJZ9PtA7MpTD5EDRXIER0Mmi+qoTw=;
        b=Wb3LCK7ba3HMiyiqoZoWtKhuoZSMqXPKUYnmqyXbXA8sc9bQ7g1Ayt1Hi3pfkhMzDY
         eXWJNLau0OwPd2pT27ntqDg1AIpkhE4ir33pSpotvLQ6C2zQbBT8gzCzBJ0Jyd9cKdov
         9efhTkRNel+3uw17iMxB4v/jEbepMyDxWS22XCw71TJCVYSOvZBAlbU0ggK8hwbrKHz6
         UE9d6To4UXIs9nQVln1jcy7+FEhGH1trXfiP/m/GlyiPVRZ+XLlHynakSskC5XJGA/lM
         D1Af4Ib0poxC1uf/z+7EVimyDRdO+1jymWnke+Qi/CC+dy1RnzBaoi8BjuJ3gzejYLNH
         mvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276558; x=1727881358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=If2fzGYCGwBnqYyJZ9PtA7MpTD5EDRXIER0Mmi+qoTw=;
        b=S7uChQDLjXIp3+i8+PIjremUXFYXtImg/wVMgThZUnHVU4O+I7VqZ6mB5SZGqQGZ7u
         4XZbMSP8i0qEkazkLIzzS6bDun+viORjiFqhg6dkDvQya1cVLarbu9TZyFK1fAF+dYQM
         1Bnj+LOvw/UB7NKhIBzF+S36MQJ/dz5yNy+V3YF4Zf5PM0S/P66tVi4kShYnlfb/cxWX
         jZvODSdt4idJVnVpRyJwcG9jjAfTGWqiWXoadI0iJVmFFBvp0uRUzoZim8PDw0BNOBrI
         8DstF05DLnHeHJ4Zt8VlVPgOHpFyVh1E4DajXnpDF45VaOiEofi/CF4frNPQbQICEv/b
         /Uyg==
X-Forwarded-Encrypted: i=1; AJvYcCW3SBcVi08Z4gGpHTyLeXdX4oA4UEsgSNgGoIQUQVdgJ+sozAVyJf1vYJJ1hDL2tHdaMpcICiseEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK6vTyzeARznWV93tfbZk+jK/D7qaTN9D9RKtummVhzq787/pI
	4xCTFpuOQ6Yd9VMjwXZTZEl41A6ChfpIYY7vVQkIsdJlruEp6a+1F2z0vzwSVLpybQwaHA==
X-Google-Smtp-Source: AGHT+IGkF5zmfUWW4O6+9JFmmh7xBD2vdGsjZEUVC3p8TPU+fzBQ5QlHTxnNWj2zBWn7gVrNU3EsN2Rx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5d:5547:0:b0:378:89be:1826 with SMTP id
 ffacd0b85a97d-37cc2473cc2mr1714f8f.4.1727276557999; Wed, 25 Sep 2024 08:02:37
 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:19 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681; i=ardb@kernel.org;
 h=from:subject; bh=1WKyFOMOSweUVoFxWBVIeZQGadqaqXWeT1GGGyj8jAA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6jGPaQaG+1hu3Z0QvW9R+99QHb2J68ydL88WzUpdH
 Hf1+4blHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiex8y/GZ5P9H2XQc705Yd
 pyrK5txZNU1B4+0LjklBfTe9r2ed6mlhZNiZU/rz52b9K88lGacbreAU2ufVkfLX5bhxnpO8ivb mR0wA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-49-ardb+git@google.com>
Subject: [RFC PATCH 19/28] x86/boot/64: Avoid intentional absolute symbol
 references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The code in .head.text executes from a 1:1 mapping and cannot generally
refer to global variables using their kernel virtual addresses. However,
there are some occurrences of such references that are valid: the kernel
virtual addresses of _text and _end are needed to populate the page
tables correctly, and some other section markers are used in a similar
way.

To avoid the need for making exceptions to the rule that .head.text must
not contain any absolute symbol references, derive these addresses from
the RIP-relative 1:1 mapped physical addresses, which can be safely
determined using RIP_REL_REF().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de33ac34773c..49e8ba1c0d34 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -91,9 +91,11 @@ static inline bool check_la57_support(void)
 	return true;
 }
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+						    pmdval_t *pmd,
+						    unsigned long p2v_offset)
 {
-	unsigned long vaddr, vaddr_end;
+	unsigned long paddr, paddr_end;
 	int i;
 
 	/* Encrypt the kernel and related (if SME is active) */
@@ -106,10 +108,10 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		paddr = (unsigned long)&RIP_REL_REF(__start_bss_decrypted);
+		paddr_end = (unsigned long)&RIP_REL_REF(__end_bss_decrypted);
 
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+		for (; paddr < paddr_end; paddr += PMD_SIZE) {
 			/*
 			 * On SNP, transition the page to shared in the RMP table so that
 			 * it is consistent with the page table attribute change.
@@ -118,11 +120,11 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 			 * mapping (kernel .text). PVALIDATE, by way of
 			 * early_snp_set_memory_shared(), requires a valid virtual
 			 * address but the kernel is currently running off of the identity
-			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 * mapping so use the PA to get a *currently* valid virtual address.
 			 */
-			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
 
-			i = pmd_index(vaddr);
+			i = pmd_index(paddr - p2v_offset);
 			pmd[i] -= sme_get_me_mask();
 		}
 	}
@@ -146,6 +148,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
 	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
+	unsigned long va_text, va_end;
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -172,6 +175,9 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	if (load_delta & ~PMD_MASK)
 		for (;;);
 
+	va_text = physaddr - p2v_offset;
+	va_end  = (unsigned long)&RIP_REL_REF(_end) - p2v_offset;
+
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
@@ -232,7 +238,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
+	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
 		int idx = i + (physaddr >> PMD_SHIFT);
 
 		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
@@ -257,11 +263,11 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
 
 	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+	for (i = 0; i < pmd_index(va_text); i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
 	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
+	for (; i <= pmd_index(va_end); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 
@@ -269,7 +275,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	for (; i < PTRS_PER_PMD; i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
-	return sme_postprocess_startup(bp, pmd);
+	return sme_postprocess_startup(bp, pmd, p2v_offset);
 }
 
 /* Wipe all early page tables except for the kernel symbol map */
-- 
2.46.0.792.g87dc391469-goog


