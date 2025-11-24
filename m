Return-Path: <linux-pm+bounces-38466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9460C811BD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 907ED4E5C74
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292D30DD08;
	Mon, 24 Nov 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccThWqrn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF252283129
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995513; cv=none; b=ZoguidtIF6Nc0ywFGZLWOeArdF9HqtU0aZpU3LvV5hvhJVzVHk2HDtKSsNlg06AdJ5wGUdEQM81jc9upEAhwmphGjLy0ZcGZVGwOHaFv+0fn1iQrGY62q0IwdMAqSYwoehPNIOkB+xtPV9x/fkgi2XsQoJIQeJP62cIaxKBkxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995513; c=relaxed/simple;
	bh=B+OuOxswYIlP6/ox6aYnaT9B0G8uLmPjSidsrAbrFo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gbecwv2guN3SSaOSePPETFggOrjvgH7DDQbTwonrFJUFnQZFLZGvsTh8ekwRHWx3dIorZ6BGSj0qpwJDgonMS0NoM2YhQA8CDPXDTyVGCsf+M8didijcJ3g1RQFhLVOe7woDkdcCcVqP9GPjyewc4vaIlvA2r0TodP8wYhaP9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccThWqrn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so5218649b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763995511; x=1764600311; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+lViCP3JwmJSXa9k9tJRJS2po3psq0GraKP0iUTysE=;
        b=ccThWqrnV5KlDGsNeCXk1Zn9wJ9WByDDGUMkdlqVKtcO70Dit0eSiTp6HNBwplmU+D
         VpgE8TjB6atZU9ztNSCsrg6k6FuDG2lQbj3+GF4a5pbcZtf6535SMcexNrbSOvOv8nQs
         1UrV7SQ6sduXxErgwEyi/l7ldID6QO4BwNUJo2LPuwcrOBn1HaJquc6TA9vBKI8ICI3h
         THWmNcYlogmJxLx3qFOSnuHanq7Q25E80bLyZTJofB8gW0FtWSg5liqIFwfVq352AHfv
         ddcqxcR9Wd2Fy3B71sRxqK1BfVMUl5T0wLTZ3tLKc2VukPmhbneWc6AGiJ0UMxLZRqC4
         yFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763995511; x=1764600311;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+lViCP3JwmJSXa9k9tJRJS2po3psq0GraKP0iUTysE=;
        b=dtn3izrXXQQX+SfeNfFdzwAfsT35Dx379zGHJr7N0uh1SXTXCq9mCsukpVvUxCs47O
         C55XYfWpIOSHZqoZ3NkA9QSUgzIGYi5yDdDX940ygHwQ50WSATXP1LWhwQ3LgWdZSrzJ
         RyZrnKpHzsfs28ovwzaDHuBgDicHGpvkZs8g9XyJh9UMdpDwhEAVaGZhdGDxZVp3g0Gy
         2epBDa/NxNMmCPNd3/IyVkO0KTQL+ObrTxYqf6/Lj7bNE3nNeywDF0915PTkriDXkbd1
         neLmiRFmTDAOu8XVJWX0ADexT5v5XzvoZehqsUJ53r0fD0TtjX61KQ7HkDOs7V65AUia
         DgQw==
X-Forwarded-Encrypted: i=1; AJvYcCXVHQ9RSUUVDJPMvzmWOmJWFJfv1n89CZ1SEXfSKi80eVG5g67x6dMLxLiXG5E1hdRq90cwZOBOTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlj3iL64fn1gR56mdyJ6HsjN71w8fSC/0NWquOP1p+ZNUX1VzU
	DAcy2udYnty0TGo/GLqVNBN2ibgba18CnliJhQgIFo6sJ0YjgzPRlOTr
X-Gm-Gg: ASbGncu/AYdkvRcseDf3Rypo7kZXPK8eLZUQFFj3OKEtFTi3VGKsNUAxAkpEPZ7/LfS
	TPAgpcVeRQ6ApxEgMo/V7fQwTqmUeQXYSCCkK/73xM75xS+Eh36uweB6KjGVVjfWwWEwMK0PCdt
	Kzx7r+8UAxyJbXZ/9mqco4WNe7Wj8GQgCU5h9YobqzshwcyTL8CuAUGKGC8Y8oJPqmqoMP30LJq
	z4LT/MAxMMAOHRIb6FGR6XDn9uIN14Ut8dwr4B07jhuc2SlQXbYd3gzudZ2Dax4C2n72G6d/AQk
	UJbjwtvIP5M5vmOTM6WN2mexnaVDc5ob09Fanuo7G6T+qi6nKgATLh2FhRoPOEOV44CmYenMkXl
	4nUAmyz+vmZf2EFqN2b56/tcNNyf5X6QQVzWLyILAJIquwQD2OVqwRqbrQ6eSUUJIBfftNoMpNQ
	eoOjkB8AuK
X-Google-Smtp-Source: AGHT+IERKAU0E5mkYy8k68ayS93eXKsIcZTlLhzL1OWOICzj8Dn/MB2N3j5/ZgG+kKuEeT9V3EBqMg==
X-Received: by 2002:a05:6a00:94fa:b0:7a2:1b8a:ca22 with SMTP id d2e1a72fcca58-7c58eaff9ebmr10999281b3a.25.1763995510160;
        Mon, 24 Nov 2025 06:45:10 -0800 (PST)
Received: from aheev.home ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174d2c0sm14879524b3a.66.2025.11.24.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:45:09 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Mon, 24 Nov 2025 20:14:57 +0530
Subject: [PATCH v5] checkpatch: add uninitialized pointer with __free
 attribute check
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-aheev-checkpatch-uninitialized-free-v5-1-0c523b1a3f5a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGhvJGkC/5XOMW7DMAwF0KsEmqtCpC3L6dR7FBlomYqIJnYgu
 0LawHevkqVGJhec/h/e501NnIQn9ba7qcRZJhmHEuzLTvlIw5G19CUrNGjBIGiKzFn7yP7zQrO
 P+muQQWahk/xwr0Ni1tZX++AsgyFQRbokDnJ9rHwcSo4yzWP6foxmuLf/8zPocm3oDHS+IUfvx
 zPJ6dWPZ3X3M67NepuJ2mhovNkbwy1U5tms1qbdZlblT2pccNiBx65/Nus/E4zbZtbFrFtEasg
 7bMPaXJblF9OMmsHSAQAA
X-Change-ID: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4077; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=B+OuOxswYIlP6/ox6aYnaT9B0G8uLmPjSidsrAbrFo8=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJV8rNP/j/0gM/vnOS+f51+QUm2Z1eUaOnknPt0fZHIj
 N07tmz+1lHKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBEePQZfjFt0zSfWqKaYLgx
 OP7EB3Omo5tqdPkz7nQenOlzNEe+QIOR4fTndXM6j+8uYBG8VubKcqtnj0o/7+VoDiNBve6diw9
 UcAIA
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
 Documentation/dev-tools/checkpatch.rst | 20 ++++++++++++++++++++
 scripts/checkpatch.pl                  |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324fb2399a5b1bc99c891ed1de10535..865aaaf6dc51b1c3f763b3cbb8713da3d00db960 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1009,6 +1009,26 @@ Functions and Variables
 
       return bar;
 
+  **UNINITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should be defined and assigned in one
+    statement. In this case declarations at the top of the function rule
+    can be relaxed. Not doing so may lead to undefined behavior as the
+    memory assigned (garbage, in case not initialized) to the pointer is
+    freed automatically when the pointer goes out of scope.
+
+    See: https://lore.kernel.org/lkml/58fd478f408a34b578ee8d949c5c4b4da4d4f41d.camel@HansenPartnership.com/
+
+    Example::
+
+      type var __free(free_func);
+      ... // function might have returned here
+      var = malloc(var_size);
+
+    should be initialized as::
+
+      type var __free(free_func) = malloc(var_size);
+      ... // return here would just free allocated memory
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


