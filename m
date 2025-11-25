Return-Path: <linux-pm+bounces-38593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A26C852F5
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CA224E3829
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D7B21507F;
	Tue, 25 Nov 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4E7TNWI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5D1D516C
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077581; cv=none; b=uA7PSw/0suGTIfLtuX/KQF/XXgloY8PO4FLpHf40KCT94o+2DIYhTbOpd3Tdi0U5A8mHXa1CscuXyKTMVXl2wGz+ai+C1LWlXJAarTrreJFC4XiWYSfB17Di3w81GFvXerXVBHMlYx5SLQ1z0Fh68xrp/jXgTz5jQ/D5+UPYm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077581; c=relaxed/simple;
	bh=MnDKOoBSC1TVC+0JyofFcG76+xlRkRQjLfiBE/kEcr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZSCYM1m+4tiT8HdmdgQYyXGNRpz1iP8frKh1XnugMILGZCvRM7lB+qHe4Umrlk9uklslcdVkM6YJHpmr+ofwAn3v1BEdvslJmwKEV/lH+9QsCd0b1+jobdBN3DJLLLQhm3MbJAuMYQC6woKwpFYzAONaNBRTz5+h/qqaVON/h2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4E7TNWI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297dc3e299bso55030105ad.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764077579; x=1764682379; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ8TwQlg6Y5fZZwS5KDal2CdCamjB1K+UNXBBcg3Rco=;
        b=T4E7TNWIFwRVohzzKvf1IhdB7wnqHCQqb6AiJVkZvUXZXHMno9m89q9F3me/PUmEJV
         a0QNQNbx60md3BdyxPh0rkPtwnmav2xz/ZvILZKZrLYVazeLxoaODOIurVQy06Ag5B7D
         E+KrqVClH1lCMH2ONuhGsz51yz+qy0hUF12qdtekadgbtxlfxbO7v+K691suTRGza9od
         8OGD3TzUFi2x6wu2WdxVxRnYRmkoI7fTLRaKjv7g/kbwGeMoDqwYNn3jpaBB8zIchSBO
         9JbPR9IiGwyR79hoTkJmrCCxLmEAIQBgx2OH6y0qprsQf9atF+vMMjTsvvoHwXzXonBD
         KUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764077579; x=1764682379;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ8TwQlg6Y5fZZwS5KDal2CdCamjB1K+UNXBBcg3Rco=;
        b=NoXdcfQuJa5gT+BxNgLwUvJovH9/mavGrlQ08gS42UZLAlSRVxBdhkwpsWDdCiBVq3
         hOuuwUp+mNpcitOVKKQufIcF0fIKP7/4EpFVquBH1zGhs1M5deP5L2Vk4MEXDEqKpOhr
         zlD/5Y1utnB90dI5JmrWUkatAX2mjxjyBLFn56zTh+RHBfSgf3+wCKrWIMf7wVHhI9UC
         jsHFagp0IwAzEKP8elTShQsmTh/gagN1RNRWh0/gvAfqWmz/SfNtUZW/l268BaLAAL29
         VZnDdEbdvd23ZpkIxMRXSmC97By42L4lbfLx3JJjCQtr/0ao5T1RMlBpiGDPdJzFUnHp
         4mIA==
X-Forwarded-Encrypted: i=1; AJvYcCUtRZz+xVB4ohlFvWoNYduS7ssENp02TL8s2BLIsQcxkISEc/TZjRwq2lqS4FHFcdVFI3ozbNDJjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTfkMsXpSp0PF09TCAKG6vjTe38PRzfG37S+h/RsIIxTVFyZd
	1zP+9VFGC7jU5bBtL2zo/DQsixOAPW3AjiwveQ+G9xzz4IbCNi1ul1ZY
X-Gm-Gg: ASbGncvW/kdSUb1E3fyi/UJMPap5KovDi/14k5240OptvRlGRXihPVoxZn87isd3yYZ
	wxNhEWgyJsXbwGvZzPOnGTYtG59icZJplvX6y2V+X1XkNJakkUHhIo1PpnPmLXj2uw2ke8fG0RD
	267THaEuXmVERxXLncLbW7OKo3k0CqSWHLoAwKnrwHZen9mSoBo241Cw4d3DbWrXbqfNXZl7l0r
	EI1clIdC1ptTBZKtPfHTppJHUzcR0ppIW0ndClqIMAlQ4m3hRYB02QRs92tK6nn54lRTyICx1Pf
	bja5HjW/bcA5LKL990lqxn9qqHhvTlz9Zgle8JUZpHs1EmXrObq4rQdcPSfRfvPkzf2xEFqVncs
	h5iWSTp561ZlKtAaj3EVYikW/wn/x2qBoSlS4xAn5YU0T/WS7lIe6u1PVkKUXsc5IsmnKi0JjBu
	sEhVY/Ct/L
X-Google-Smtp-Source: AGHT+IGXR44l9YhEkTAV/tXptPvUsAeyj8n4KxA+qB/DgxfpuEhRvUm9603/BVTN30Wte9JOmQR6xQ==
X-Received: by 2002:a17:903:40cf:b0:295:2c8e:8e56 with SMTP id d9443c01a7336-29bab19b205mr27432545ad.44.1764077578706;
        Tue, 25 Nov 2025 05:32:58 -0800 (PST)
Received: from aheev.home ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b12f988sm165605945ad.27.2025.11.25.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:32:58 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 25 Nov 2025 19:02:45 +0530
Subject: [PATCH RESEND v6] checkpatch: add uninitialized pointer with
 __free attribute check
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-aheev-checkpatch-uninitialized-free-v6-1-70e8bb1e9175@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 James Bottomley <James.Bottomley@hansenpartnership.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4311; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=MnDKOoBSC1TVC+0JyofFcG76+xlRkRQjLfiBE/kEcr0=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJVNzC/EhJqW/4hXPWR7EmnKvU1ehMZDjC1qm2f6sNhM
 uVsYvXdjlIWBjEuBlkxRRZGUSk/vU1SE+IOJ32DmcPKBDKEgYtTACaiLcnw3+XEop7ZB7fv8/rl
 NOPWOkWftx5iMl0HdwTsZeNf0uKqvI/hv+Nlp/sh/8+dLDx269Naweyjpx4GV23NXp1p5pFpelF
 nDQsA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

uninitialized pointers with __free attribute can cause undefined
behavior as the memory randomly assigned to the pointer is freed
automatically when the pointer goes out of scope.
add check in checkpatch to detect such issues.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
Link: https://lore.kernel.org/all/58fd478f408a34b578ee8d949c5c4b4da4d4f41d.camel@HansenPartnership.com/
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Testing:
ran checkpatch.pl before and after the change on
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized with NULL and uninitialized pointers
---
Changes in v6:
- added declaration at the place of use suggestion
- Link to v5: https://lore.kernel.org/r/20251124-aheev-checkpatch-uninitialized-free-v5-1-0c523b1a3f5a@gmail.com

Changes in v5:
- fixed checkpatch doc
- Link to v4: https://lore.kernel.org/r/20251107-aheev-checkpatch-uninitialized-free-v4-1-4822a6ac728f@gmail.com

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
 Documentation/dev-tools/checkpatch.rst | 23 +++++++++++++++++++++++
 scripts/checkpatch.pl                  |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324fb2399a5b1bc99c891ed1de10535..b6e02fb91e85710fecfc0a5e5c83a8e7f32d1d3c 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1009,6 +1009,29 @@ Functions and Variables
 
       return bar;
 
+  **UNINITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should be declared at the place of use
+    and initialized (see include/linux/cleanup.h). In this case
+    declarations at the top of the function rule can be relaxed. Not doing
+    so may lead to undefined behavior as the memory assigned (garbage,
+    in case not initialized) to the pointer is freed automatically when
+    the pointer goes out of scope.
+
+    Also see: https://lore.kernel.org/lkml/58fd478f408a34b578ee8d949c5c4b4da4d4f41d.camel@HansenPartnership.com/
+
+    Example::
+
+      type var __free(free_func);
+      ... // var not used, but, in future someone might add a return here
+      var = malloc(var_size);
+      ...
+
+    should be initialized as::
+
+      ...
+      type var __free(free_func) = malloc(var_size);
+      ...
+
 
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
-- 
Ally Heev <allyheev@gmail.com>


