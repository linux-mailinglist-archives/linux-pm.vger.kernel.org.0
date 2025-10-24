Return-Path: <linux-pm+bounces-36798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ECEC078AB
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9513C19A73CD
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76123451C9;
	Fri, 24 Oct 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlHMHNTK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C377342CBC
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326991; cv=none; b=AQ53oPD8Kk3roXYZuy1FoWxX78QDoSMEcT9301tZGNGq8XE5pAzn5CsNJ4Ytg1a6gvaMWGg078t/MTnOMk9sIw+zXsFe1FUBmbZ+/lLm2WVobXMdwE9Xs/QvuXu9+QWZ335bo5kjKBLRoMa86C+AaS9a2KI0citsSAF8IpoQg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326991; c=relaxed/simple;
	bh=Xl1ZEjB6ltsTv+GdIk8hnYCDz0VvFiu1/vVtb+GptPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTjugGNE99ox8lbXTPLIrEY7MIe0ztX15mLiM6m1LKKAaJOo8EUDz0J7qFJgg/E5L9Y2DnaUQ02lwryfjORV7bnu8weYaQaa6C/hG+lymeuu5DuwHHjoVBhxeu5GtOwju2Gzc18nEkc7ykBFzwH04GKatpqRG8HPkcFjCUX33jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlHMHNTK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290a3a4c7ecso26356545ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761326989; x=1761931789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YGZjhDld3XGVawWdcLieeak1oetbhYlwZ5IHuvKrKU=;
        b=LlHMHNTKrafpfHNElhVjClNEHSP38WSmXhrhAgbgAHolzTQC3ECaiQ5XaULeBzTuk2
         A8lLOLyc9en+3hEZsgkuKjYx3h7RKUZ7Fc73NCCWPptBcR6t+JaSBzibFAWVbWEvlF3p
         Cy0He5rjOgmj3ZT+358EJtLsgD/2dMQauESSyaPSLEJf74HDAm2PJzbMnAVPl92tyy6z
         zkrx/ZehYjhkokc+XngOyzj3Mc8uAjfe/WYNBCZWfnRdw3VUcTuTj9oqNhvsgUJs2/+9
         2qGjfpxDymto/9lCzcOmmkJEWYmWxIyY2dyJPzWIyfxzaE4xRI6eeQ/6s25tQQ4B+/7C
         lFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761326989; x=1761931789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YGZjhDld3XGVawWdcLieeak1oetbhYlwZ5IHuvKrKU=;
        b=thoONa3+JCKlX/eAQasHj4KP1LnzkQIztKsXc5VD7o2qm57C8DpGU9+ww6YqVrpIrQ
         8vQrXv54egpENNqg9ukkmSaSRmySQY3+SYcN0g/RGsXfcgv0VavLMmTwvFhGijQLYp37
         Y/woHPyKT/Exhgt6Nl5HD0yR2nIrDk6IueZT73exbCRy1f5+C7TSDKRBQqBGJXrkDnBX
         c23Q3kecZU+ovk3a1zRmT05LC6Ca9as5SPg+dr34/0BT9uMrVJqivucS66nAeVYuVS1d
         vDafd1Y6x01MluhC8+/XVcDIrYXZQF1cWDyw7Q39uidWc9xrW46HG5iu8Zu3r4+CmSaS
         ZsMw==
X-Forwarded-Encrypted: i=1; AJvYcCWogKGWVJq8iD0ZdbMPMJ8CuXZv1+41UFDjifOCJMeehgMvV13jppmxc0zCLCRYHzlJmn3LfpAjHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdRVvVKddmewZJzGetYqzkHe6KhksEhM1gsv+Sph6PjxAzabQ
	kfHbh7kHJtz517jYwt4UJ/VjD78El0rp6/3GQFUMnhHWr5rHnHmJYlI/
X-Gm-Gg: ASbGncsnCIEcY32oApNZpNh6SzcnLh51pVYwj4tynNAubJyOQAE10SaDcSZrl7nz4Hg
	KqhACVcmHkpkwwGFpyRvRioA4GhE/hBp5y7L6RM2BaXHnNZDk6War1kfCiFNOylGm394jBENSqk
	6xmiht8Gu9WVoTmY8bTl1iZUeBsvGVzRkD0oYcN7j6dKHmVlcEPRwhFsGYbExwXL3mstHCIBknR
	sFGSwLhqqobbo4cHf7tf5xqEWksZ48qcfJBQaltP0UnvM0DOxNc3X4grQNqQhncFc8nbxWuskL/
	THVnL5k4m0vWd8GljGe9qxX6DJlXhScXygvOJ/weZiSCI2sVNtfq6i2cUtpi8Xv6izWgd2gLJWc
	d1iK5UyGHNDTKt0yXy5bxkhsDaCDWXpBNGjUS+L33YjvDgeh0XkUFGvd/CeJQXAHwVi2lTCuYlr
	Nd7LS8LevCnQ==
X-Google-Smtp-Source: AGHT+IHE0gPsph7LiBH8wgoEMRerWEq6wtBoH2k0IpyoAj24E2cHMZ/NGysGmuXYuYid0ecv9CML6Q==
X-Received: by 2002:a17:902:d510:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-290ca216346mr354011385ad.33.1761326988612;
        Fri, 24 Oct 2025 10:29:48 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f6:d7b0:8f5e:ff90:677:7d74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda85e7sm61719615ad.11.2025.10.24.10.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:29:48 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Date: Fri, 24 Oct 2025 22:59:16 +0530
Subject: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=Xl1ZEjB6ltsTv+GdIk8hnYCDz0VvFiu1/vVtb+GptPU=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ+b68xNKwQFG997/XXQdTxPc8Zo5PSrfsznq83iYrYs
 CXz73/djlIWBjEuBlkxRRZGUSk/vU1SE+IOJ32DmcPKBDKEgYtTACaSE8Hwv56B58GrkLmy/z2N
 XucVS1sIWBZnWpz1PWVW67Naw79fgZFh3w0nwbMLJf8aukYsnrzMJDpWpFOVP2dlZsGhudLnbh/
 iBQA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

pointers with __free attribute initialized to NULL
pose potential cleanup issues [1] when a function uses
interdependent variables with cleanup attributes

Link: https://docs.kernel.org/core-api/cleanup.html [1]
Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 6 ++++++
 scripts/checkpatch.pl                  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 1a304bf38bcd27e50bbb7cd4383b07ac54d20b0a..c39213b814f487290d2b0e5d320a4313ada9bbad 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1015,6 +1015,12 @@ Functions and Variables
     in case not initialized) to the pointer is freed automatically
     when the pointer goes out of scope.
 
+  **NULL_INITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should not be initialized to NULL.
+    Always define and assign such pointers in one statement.
+
+    See: https://docs.kernel.org/core-api/cleanup.html
+
 Permissions
 -----------
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1009a4a065e910143dabeee6640b3b3a4bd3fe06..cf186dafc191f1c39d01b3660f19101f6cc61a82 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7728,6 +7728,12 @@ sub process {
 			ERROR("UNINITIALIZED_PTR_WITH_FREE",
 			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
 		}
+
+# check for pointers with __free attribute initialized to NULL
+		while ($line =~ /\*\s*($Ident)\s+$FreeAttribute\s*=\s*NULL\b/g) {
+			WARN("NULL_INITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized to a non-NULL address\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on

-- 
2.47.3


