Return-Path: <linux-pm+bounces-14704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380D19862D2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35301F29009
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0BD1917C6;
	Wed, 25 Sep 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnkKjhtp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6D190492
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276551; cv=none; b=q6r1TuE1qgY4g28ZdMUySHwWCA+9Nhh1vE8GNA7eaJnWs1v1neu09Q7YryiNeWeywBYWDjtk9kgvQCJowSBg+3BoKcWY/7VHIsqN6akYagoZIUFixqk54p/tnpvggMuMwJo3oGc1vvRGQf9H7aKhqditwdbcj/ObtVLb7lGymV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276551; c=relaxed/simple;
	bh=tOVKR1lo4TSaVSSD57+XbfuDxZ/gh43zpiGViV/8Jbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZSggig7/hi/ZWoHDIUJB5xiIXiZrJU+5UqEJwI11BhxYsxBQgEZ5iiMrKX9rzBB6Du7AsxDZMjQK2fJXA1ku8dSuRpLu2ti1atN0DAFWGsaaci4Q/8o4+yRBKFZHtvYOQHr+QDOFV47fQSSN9QGZ9kcRvnfK7Bb2NQbzjyId90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnkKjhtp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbffbae597so115557937b3.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276548; x=1727881348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApY23d/9zEIgxeEREKcGvRSADQZAXD1f0/BrlQ4mdDw=;
        b=GnkKjhtp9zSMZYTexidLqwKc++D8bRxlmP6vfNPPiswSuKsY7b5gjmgIVcyTHNJmXV
         R7cILxiDBk7XWsrqChfpEINGugxqUdT9I5FgI4htYuOm1ROc5WGR59a0jlhTFRO/tjum
         CWVybAqQtX2snhNPb+A1mhvliI+J7VlZ0xZ3USnRGgmL1vakWwE8brOdDD8vlqavUm12
         lanq2ZcCA7IIW/USsG0YE1Oa6h++SWt4alvAWiXjABfnGQRDtvpHHc+Nrb+8CBRvciCq
         nkpjydToaKAfAY4HeApliRfcLdyZvFqwlsJLIYZPyN43lymbKggonsBTZKs6FZRRm5WP
         HXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276548; x=1727881348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApY23d/9zEIgxeEREKcGvRSADQZAXD1f0/BrlQ4mdDw=;
        b=gWhjCHVYsL+v8QAQogLEQXzgOgIR0W8XRtVVIWuOgu+UKXn6+v8YYQoFsUgM1c3FiN
         F+fAWd4JIB3hRjzWUiXwlE4Rb6FO3FkZ/K1CRAxlAVPW34EEaLLblexUVOY7tIuN7QIQ
         z8hYGbqXUNvfjsc2MXLcjOnSOMxN7+nE9V0jkcGX1EDGBTSNZZJodM0V4y9O1ihu6Dh+
         5OnwHIg9NfzTmPd2aO6XVlUlnCEHJ9o4TRuUwvrf1BsM1bWU7UHj1/au2wJDVSjSLB8O
         wsGvGemHVFOyb7K2dHLM9WKvxO6Y2XdMgAw5RN8hpvX2Ua65NF16VXeTY9zUrwErpg5l
         6+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUmnbQ7UT2GjGOGBYaAYSDKFaLL6Y0PFIVcIUPhWKBL/9VBvOBwFVrdIXTzGOrbSYn4loo/UQZl0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJCEE8UeIkpwhSQ1mA4FmrDA9Vvtni5gKQHPGJeMjy0dmYMn5
	8W1gMJ8mjzMlXbkc1MBeQ7QZL1ujZLmH4NiYwSATaHQ0PaSYWyVYGktTCXvraRfeshnkMQ==
X-Google-Smtp-Source: AGHT+IG0+ryHhOjgZiIz9yF/upguc+H1WcXc9rbc3LtAhjefmA+cSn7SHizdSFamvUM2J9fCM9A9Vr3/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:d85:b0:6db:e107:75a2 with SMTP id
 00721157ae682-6e21da5c761mr429007b3.4.1727276548084; Wed, 25 Sep 2024
 08:02:28 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:15 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=ardb@kernel.org;
 h=from:subject; bh=MI3z3hAzDWNLGP+bB6WD9qNMTMv7yb8jTXTlUIfHWCE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6sHwPz3fHPWC8oK2RzHe5nszs/XmM4NX7P1ae3YFv
 bWd+fJLRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI/9UMfwVfxZ9hrm+9xvze
 6zfvw/cKoUe5Kv5w1pmKsYfxH/f4do3hf+75iD2ndC64zYjxsFPZpbpKIrxBk/fzstDCxW8eO9h OYgAA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-45-ardb+git@google.com>
Subject: [RFC PATCH 15/28] x86/sync_core: Use RIP-relative addressing
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

Use RIP-relative accesses and avoid fixups at runtime.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/sync_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index ab7382f92aff..cfd2f3bca83b 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -31,7 +31,8 @@ static inline void iret_to_self(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"leaq 1f(%%rip), %q0\n\t"
+		"pushq %q0\n\t"
 		"iretq\n\t"
 		"1:"
 		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
-- 
2.46.0.792.g87dc391469-goog


