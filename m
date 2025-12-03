Return-Path: <linux-pm+bounces-39165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B340C9F749
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82EBF3006986
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0CC3081D1;
	Wed,  3 Dec 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xviz1rHb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237625B1FC
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775751; cv=none; b=DKWuAhVqXdBAGr8QQBovqzPf4oIXkrxjSnV+yWBYdYTwKo0XsnePccy8caa7yx92AXSoPeERSweicjNzKWBcUr0QggGTWO0CcVrZFrSp9SASjbH23HPQ/hRL7za89Xa/cYgXHIs32I+NNHuqYE2l2F46+WkmVho/xDhsiwmcA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775751; c=relaxed/simple;
	bh=ZP+a/lYHROshZoFv304670YZenCoDJjMnXixZoDRcgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KP+e0X1B1bp2Pdrd6nj0sDhvmvL26WOXuxzSFUwGlVKDc5nJLq/n0aiMQl9rgDljZhAQcEB79wFysO+EWYvKhQm0WNPTu+KSw5KrIDJIwWxoG5hQ0AgiLDfehLG7kJfYjuXiABW3TmMi+Kr8NZ3JNZCiM2VjXUbTO67Qlv4ib1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xviz1rHb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7baf61be569so8106097b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764775738; x=1765380538; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUOVPTJ4/dC2kl4p1iy88YkrusyzdxkNbRXdJXMfw68=;
        b=Xviz1rHbGcfdYpeIXa5gf/WA9MybYBa1huMRugdC6ykOw5nZHD55WSMYDfkyjX3X9t
         3la18H483WdyE3HbJ7YT/D3BWWbCbC1+71NlR6yM9RxVlRvKUSSzMfabABA9/dC0ZPay
         ddWDzoXVwUudqZH8nOhsqIwL6er0TQCWIgiTFnUU2sU3BC9taNRMe8J91eoQzSCIyREB
         tkdAlhVbQeV4TTB5nPqvP28JBhltgCadvchqwajt4N3otylEI8/m6jB5uKmLSzXY348k
         QntQzlvpotDIYKlo56ECX3GA2GLQuErACEC/RL2cehIvG2+Egq+tQoMHcOH9nLXWFWIL
         /KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764775738; x=1765380538;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUOVPTJ4/dC2kl4p1iy88YkrusyzdxkNbRXdJXMfw68=;
        b=nZWHzD3REOfpevDRYTR4U4rR56hpa7JdapjPs3AItH9JRWZCiPP+uPhDJ2sNOLv0fi
         333ij+m/YxkbTGM3NhV4a/hml2Ste5WiRp5kTKup4OKb2pkWvOABx2VAAezr1FtNzNK7
         yDrQXG3enory806DXqjPdnBU4Mg+WTREWTyf6PRdmIrQZKVuXuyllKC0YU0CF1G2k/yw
         gL054jhipfll08+R1IOWseWdRPbHGt3aXJfnSrrDFJaQs1x2HSii1lTfLcZ/EkJQgDGm
         panMgZmayyJJi95t/VDxzQvUp5Pzm02Q//sbVm4kwT85ak/dvGTksBN7PbKvs6oH7wHu
         xzlg==
X-Forwarded-Encrypted: i=1; AJvYcCWhdt2QEz9zmPrzyJjkm7IW8pCiRZ7QRx1lm6gd2uoxnE9y2jeILaDxBMHkYzcmZeVSgQbaxD3GUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywrmmT2hnk07rbmBGonWsSN0JejUrr/dqKWhN6u2eRDpmqH5e6
	dGHLNcYOI5gwJ8J8rRm5VxknDbJfeWCikT1T8xB68F0pjE0YOQi5F+VK
X-Gm-Gg: ASbGncukHhPaTOlStnX+tayEEZWOaY+XTsrtJjNdDEFeG0VE9pLcDfAf3wGZ4QQlkju
	aBEORCIdVFmU6j5T2rHzn9wBb7uH4rn9v234AJVoBkvAgpaJhSwJOohHFFn9TqH6SpFQSf/ICYZ
	5Alixp6LYq2l7ALjGB5vwHbcqnUXx3s2+1awMwIrhj+EP5AnQjtowgBL33cwkCh9cd/RZcH4Ys1
	hR1XbIvI2brJ2USheqPzjqJVRB38b1lCh+zd7wJzEK3Byih9Ok9FFJwQtvvwmOPYeCCjjd7lR36
	uNlr+QysOAGjRkt22HJws9hDmajsR78nOES9upeFNoj0kPw4hG7NM9p48TLcsD9F4AoarCLHvQk
	2zlXmgn7zc7zxRCl3owB9YO9Es+wwdj4pN4oGwTbMqqT8o2C09hJn6vyisGjuASYc8MelEn0rf3
	dsCFk54KSS
X-Google-Smtp-Source: AGHT+IEOsz1PzZbs/DYjU/JrirTTGiHXDESPnE5swa/vQS97QPodviOkxWFtzWwuhqltw1FaWZbskg==
X-Received: by 2002:a05:6a20:7346:b0:35d:7f7:4aac with SMTP id adf61e73a8af0-363f5e7a28emr3846587637.47.1764775737421;
        Wed, 03 Dec 2025 07:28:57 -0800 (PST)
Received: from aheev.home ([106.215.171.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be509f4ee3fsm18234837a12.34.2025.12.03.07.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:28:57 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Wed, 03 Dec 2025 20:58:49 +0530
Subject: [PATCH v7] checkpatch: add uninitialized pointer with __free
 attribute check
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-aheev-checkpatch-uninitialized-free-v7-1-841e3b31d8f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIADBXMGkC/5XQO27DMAwG4KsEmquCpKxHMvUeRQdapmKhiR3Yr
 tE28N2rZKmRLi44/Rw+Pq5qlCHLqA67qxpkzmPuuxL8007Flruj6NyUrAjIIhBqbkVmHVuJ7xe
 eYqs/utzlKfMpf0uj0yCibTT75K0gMKoiXQZJ+fM+5fWt5DaPUz983YfOeOv+z59RlwqpBqyjY
 88vxzPn03Psz+rmz7Q2q20madDoIuwBJKCBR9OsTbvNNGVPdj55qjFS3Tya1a+J4LeZVTGrQMS
 Oo6eQHk27MrfebosJ0ZKpkU2yf/7p1ubG210xKRnGxofkfFiby7L8AB9DT/p6AgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4542; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=ZP+a/lYHROshZoFv304670YZenCoDJjMnXixZoDRcgE=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDINwo0bpqxoOe038Uu9NjN3jfKUyjfq81Y4MkxhtPu35
 hqfv8iljlIWBjEuBlkxRRZGUSk/vU1SE+IOJ32DmcPKBDKEgYtTACZicZKR4ejxkwtn+4UkB5rV
 hN+NfvVD8f2DVPX17Nqp77iv6d6LWMDwT9OJkWea+xYlRXb22Iab1wWttdelcfyZ8ahn7byo6m1
 NLAA=
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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Testing:
ran checkpatch.pl before and after the change on 
crypto/asymmetric_keys/x509_public_key.c, which has
both initialized with NULL and uninitialized pointers
---
Changes in v7:
- RESEND. Also, added Reviewed-by trailer
- Link to v6: https://lore.kernel.org/r/20251125-aheev-checkpatch-uninitialized-free-v6-1-2f3a1d78f678@gmail.com

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


