Return-Path: <linux-pm+bounces-38101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66366C62389
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 04:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7DC64E726E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 03:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C4270542;
	Mon, 17 Nov 2025 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVAyj0f2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB22765EA
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349025; cv=none; b=nUwYpXyjt8vBAaQY8Lj1BzWJgNi62q/tF/FuhVQFFCgzTm2qKo/hopqzv32+RYrXbZQR88iK93Aq211W3WrHed1OG4Lruv0yF813a1Sb0hb38OJcbb9+2Liqa9FVFzYdWgzKLCAFDv3weg3MEM5xVCChH0ZVf1B6EDaYFoYa5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349025; c=relaxed/simple;
	bh=KwkWTHqIdBLfSjywwKS8mZViqAho/uKguXMaQfCPYEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rmiWSavNFBh1xTgZIahtdEYBMnWLEdVlIyg1ciuaiOia6wAllsHuL5dl4EAmg5NFw7vP/u4DPyfE7scm4JFwFwKyx8EGtQSM1+JsozUWTxhBtmga0GzRO8AqLkI+rhqX0Id4Oiz5HBqY66RhTgxxJzFnZg91NT7pwUaXXtsEhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVAyj0f2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso4159632b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 19:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763349022; x=1763953822; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hwVjAxpOZToTGqfUIP8woZ4spcPPvZlQGxtuhtvS7o=;
        b=kVAyj0f2rOWUn10w6Wa3NWfOmBCVFQrN2yRqsIIpNqRTHtbGAJLnijxskaBTjtLCOD
         zePRCa9XRCT83jKbbQrPV0VT4qv7BsYZBMJtZsHn1xe21KjAuYSopWOFsjIn4sSULEKw
         EkYBA5nL0T2zkNYQUwC0CIXUhlfDENK08TBqMDWyfbZVAkGLergPURolHsdxKG5jesC6
         PF36J0z6Kk3CyMzdCpLUlu3kHtjG+cchHmRGUJZ6KhgHFUE/B8rfYhtlmx/mEVWa5Vvw
         /Ex7KN30dLNJlT9Kj7Nywpecc7QMuq5SsbvrqQUM2X6Jd+0i2FU+ltZjlTyfZv4rBbBq
         HfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763349022; x=1763953822;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hwVjAxpOZToTGqfUIP8woZ4spcPPvZlQGxtuhtvS7o=;
        b=OhmDp+L/JPvL2zMf3YAIa5wR05gDM+68otNeQFPQ+rxhPQWGjDNl5xurXCeLlU2KHA
         IWgKLSTCLhkIm1aTLD7xcdafrQz+QJ1fmEv1yfJVNuLFxQnaF1LhxwG5Wri110RfvFaM
         1lnWvrEtzqadcCSIQK1Yc1r0w99j/kRXY95jHeX/dbDloAl1t6Pwvq5+v8IvBLNOg7zy
         dcp7r1SZS//amCnNww4zl6FK4hZZuzRccjwcc/FtiWNR3NfM8oiDslT95YhUQo2B4bF5
         +WKKqdbC99Hu254Em2CxTjiLOaX6sHlRPPbVysy1UJBbfY3R72YP+GWC/10hk6wDKHIP
         JHRg==
X-Forwarded-Encrypted: i=1; AJvYcCWM6laYWjpdBnqXCp/n8J5gGNG6Bj6ikjKRHSKSYLUIBsIGEOe+q7KHnZyPJf1OtjwiczJF93AcSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UmEbAsi8rU46ts2+ZstTcSpFKDVSLdJ/VwFbCrkxoX7HqTNr
	ZzfECDgjTPit3Q/nuc6JP1HmEHOX348ziA/llf1bRg0Av77nGT2FI+T+
X-Gm-Gg: ASbGncuDgL3MgfY4Vkt6nEElTb7Jcw+KqCTpoVBZfYwBZd4LWFvwrF4qRTfLktobkB9
	Oj9DlU4f+mTGvfCgXtDyGp+OgyArAqFelhy2FStA6Gm+uMs433JS9GpDy3gqHIOiIxmzrq++9mc
	2zMiJVMJgp9R+24D3Ny19sQnl2iqhH5tbu49v1GM8Wl/xe/9Jv4oWACDF2QxXPKqxICBjqwFbfv
	K/bb72ft5S+tniB/Xzukxgl01sPu0iLqSglkYpfry6N8fXMr2SHoGhJCNOLRTLR+O0jZbORMnyj
	CSSmaXQxiGu4mCVHQ38sW7SwsNZRDqkXJZhpl/RDHGUZyBvksJkeDSVXLyTqerAB4uZ/s8qW+HV
	Q5AFRxSo7LxB56CwXRIfx8p1M1N+QRRoQqy3VZoRjIJBh7HgtmZcsur0ixyDqutLDR0zVD6hHcb
	8WWjch1kaMn7jqH6I3BjA=
X-Google-Smtp-Source: AGHT+IHam6C6QuknGeD3kkf4bhbtS71Whx06JMQo1zqax8fpO/s5JVsWS1eh6JI/8lnaqRirI9cq7Q==
X-Received: by 2002:a05:6a20:a11f:b0:35d:d477:a7d7 with SMTP id adf61e73a8af0-35dd477ab32mr6249535637.7.1763349022214;
        Sun, 16 Nov 2025 19:10:22 -0800 (PST)
Received: from aheev.home ([106.215.169.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36db22439sm11054860a12.4.2025.11.16.19.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:10:21 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Mon, 17 Nov 2025 08:40:12 +0530
Subject: [PATCH RESEND v4] checkpatch: add uninitialized pointer with
 __free attribute check
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-aheev-checkpatch-uninitialized-free-v4-1-fbee16ffeab9@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3515; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=KwkWTHqIdBLfSjywwKS8mZViqAho/uKguXMaQfCPYEo=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDKlJokd3vXi8bVnnr+YAyQOPRLUn2qfY3fFyjFg8pnfS
 6+Lng993lHKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBE3NQYGZ6dKFqdFfzt28Y5
 qawOqVG2X2fWmhROC7VzrOC9+v1x7C5GhvbbrqUl1XkSzm41N9Lmv2na+GFFlt1LpfUpAvJ+fGs
 XcgIA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

uninitialized pointers with __free attribute can cause undefined
behavior as the memory randomly assigned to the pointer is freed
automatically when the pointer goes out of scope.
add check in checkpatch to detect such issues.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Testing:
ran checkpatch.pl before and after the change on
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized with NULL and uninitialized pointers
---
Changes in v4:
- fixed UNINITIALIZED_PTR_WITH_FREE description
- Link to v3: https://lore.kernel.org/r/20251025-aheev-checkpatch-uninitialized-free-v3-1-a67f72b1c2bd@gmail.com

Changes in v3:
- remove $FreeAttribute
- Link to v2: https://lore.kernel.org/r/20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com

Changes in v2:
- change cover letter and title to reflect new changes
- fix regex to handle multiple declarations in a single line case
- convert WARN to ERROR for uninitialized pointers
- add a new WARN for pointers initialized with NULL
- NOTE: tried handling multiple declarations on a single line by splitting
        them and matching the parts with regex, but, it turned out to be
	complex and overkill. Moreover, multi-line declarations pose a threat
- Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com
---
 Documentation/dev-tools/checkpatch.rst | 5 +++++
 scripts/checkpatch.pl                  | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324fb2399a5b1bc99c891ed1de10535..c61a3892a60c13f7c5ba89e969e39a93a3dcd5bc 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1009,6 +1009,11 @@ Functions and Variables
 
       return bar;
 
+  **UNINITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should be initialized. Not doing so
+    may lead to undefined behavior as the memory assigned (garbage,
+    in case not initialized) to the pointer is freed automatically
+    when the pointer goes out of scope.
 
 Permissions
 -----------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..e697d81d71c0b3628f7b59807e8bc40d582621bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7721,6 +7721,12 @@ sub process {
 				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
 			}
 		}
+
+# check for uninitialized pointers with __free attribute
+		while ($line =~ /\*\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*[,;]/g) {
+			ERROR("UNINITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on

---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1

Best regards,
-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaQ2YPwAKCRCWPaLUP9d7
HDkPAP9+gFqrD4O5qsYZzxGFwfXPAY7F8TM0lfYy7fLNxA2brAEAwLyLuyN0h7qg
N7da1PWuOGK8tKeZ9dR4r3gFdlbZMAo=
=zo4P
-----END PGP SIGNATURE-----
-- 
Ally Heev <allyheev@gmail.com>


