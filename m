Return-Path: <linux-pm+bounces-26391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F51AA1C6B
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5A09C07FF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1612522A7;
	Tue, 29 Apr 2025 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8N0/0pD"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83E259CA9
	for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959646; cv=none; b=YSqm8nxs8OXZ/sWpECa+RTMNV6Hj49iBuWaTKQT7zodTW+zqUH/CW5Gbpoop78jWtKVuZVzHPq8NNYgM81eoGKw/ZTaH+zPWnlWbTV6Yne88u8I8LuW/HuYDEHdGI0HpMNMGQqBmzt2eRk5jowHAkxrznrWhBAK7H7NrtpA49CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959646; c=relaxed/simple;
	bh=QqcOdSbUWOmQ7xOdiF9jBdi+WEKBOn4XoknseksIirU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iybq5j5SwiRyUFUtQSZQlZ2rq9jJFePZL+0vqw9LDTpoOYDqmKc06SQvpU/Lxqxn5DKeSwSezQKz0yyaOlKc5jauCeHcXnqw2+U7BYw7dc8aIPvTBUhzzGSF6ePI+YwKOUQh74e5BmfHndY2LUiSfRXpnmgXQwblz9k9jFnNC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8N0/0pD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745959643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9tDl4SM9LTrmRbXGWLMTTVmXyOXWasgXqOfwSbZ29mg=;
	b=N8N0/0pDwaGq/M2JuBgvd7QDGOWgqtFBGXoL5TMcNTd4jr4mrIAxXmPKnb3LlrluGJkYWp
	HM2xmDDe4EFI/ZpxOOiaCC5bbQyWT1ra5QrqjRSqV+pK+C0LXI6hnCyD5VseiNconexpDR
	3qIYFb8p7vNqV1/Q/P0elonyOftO+c4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-DkDqkMqkMKGOVubLxeWVgQ-1; Tue, 29 Apr 2025 16:47:22 -0400
X-MC-Unique: DkDqkMqkMKGOVubLxeWVgQ-1
X-Mimecast-MFC-AGG-ID: DkDqkMqkMKGOVubLxeWVgQ_1745959641
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c95e424b62so52899285a.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 13:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745959641; x=1746564441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tDl4SM9LTrmRbXGWLMTTVmXyOXWasgXqOfwSbZ29mg=;
        b=tQkuhulN8YO9jOZlVdb3Fh/nUihSBTA0FEd06L7cWjXiSOkUEMmD+0GFVKhEZjgtmR
         UTQbEbYXFq+yRV9oZqzHSbjjp3EhhAjP7MJKRigWUk38pF5C9Zsjm0ubnypvMBDGXWOQ
         gqiOD24mEDSnj0TMfmy1L48IxIrN0GCAv6NadBwC4BEAwJQ8Ysvk1RHdQn+hfvjrV3st
         FNmTvrlUJVOCI5gce7ERpEqYXFuXQcWiJaCEpl5+rZnotZAs1KDBVkl5D+Om1Fv874Xv
         HSM31r94ZO8CO4d2VqdULCy6u2hCc4t+rAe4uiyG0SQlG6psa63wlIyxzRopWJxz1cbe
         akkw==
X-Forwarded-Encrypted: i=1; AJvYcCXCHGVxFhe35WHvlfNfvsab584GBdQPzzBbU8oHdntkVm/yQJn8+Evf0ZKVBzgF7R+y+IhyKtJQVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2IK5W6RzmBkveMQuuPl3EjxQ+qC8sPRRqpB4eu2PNEKuTmFo
	3tKtfq4TYXT8iFBlkgXxMyr2XTYbN3OOUftsy97gDpR+HN6z+BPH4UeUmyK2yMsKrbTWRr9YhFG
	2EDo5S96/0M8Mmsxnk1X1t88UuvQ4nELj466KVEq4eWlYWgc7sbCxJhru
X-Gm-Gg: ASbGncv+y2FTu3e/HoTXxkldPp6tUzg77N+5QUPySmLq0v5aLRTAsRaF6lFSkcfuhTx
	kR56IRxladoaDSh7WLvshzqQkdSStWO9e+s6N9Tt3f90Xsk+F9owb0QuE3RXP59vjL37veNZVVF
	sMtTOVcVB/esMD+fK74DHOGLeRCwWizNgRP8b69Q99oJxczml7z/ny2ux8Fr0532GCmHdWMP1zu
	WRMfDg9fZo+X7xArw5QLOIw+I+8WREckCaW2phUvvZINhF8ON1ew5UBKcgWkweglU3wq/LMTyFY
	WjVQb1qrDLv0Z6rVeaVvrD4=
X-Received: by 2002:a05:622a:1f17:b0:474:e033:3efb with SMTP id d75a77b69052e-489cdce6198mr4990041cf.24.1745959641649;
        Tue, 29 Apr 2025 13:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB3zISEyNjnBvW374QL/ZY8r3V947KW/q/mBmF4gL3xZQoL9JsizIXWMEpRnC+4bSdQAo5dA==
X-Received: by 2002:a05:622a:1f17:b0:474:e033:3efb with SMTP id d75a77b69052e-489cdce6198mr4989631cf.24.1745959641208;
        Tue, 29 Apr 2025 13:47:21 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.50.205])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f1cfc4asm83668531cf.31.2025.04.29.13.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:47:20 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] cpupower: change binding's makefile to use -lcpupower
Date: Tue, 29 Apr 2025 16:47:10 -0400
Message-ID: <20250429204711.127274-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally I believed I needed the .o files to make the bindings. The
linking failed due to a missing .so link in Fedora or by using make
install-lib from the cpupower directory. Amend the makefile and the
README.

Big thanks to Wander Lairson Costa <wander@redhat.com> for the help.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/Makefile |  8 +++-----
 tools/power/cpupower/bindings/python/README   | 13 ++++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
index 741f21477432..81db39a03efb 100644
--- a/tools/power/cpupower/bindings/python/Makefile
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -1,22 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for libcpupower's Python bindings
 #
-# This Makefile expects you have already run the makefile for cpupower to build
-# the .o files in the lib directory for the bindings to be created.
+# This Makefile expects you have already run `make install-lib` in the lib
+# directory for the bindings to be created.
 
 CC := gcc
 HAVE_SWIG := $(shell if which swig >/dev/null 2>&1; then echo 1; else echo 0; fi)
 HAVE_PYCONFIG := $(shell if which python-config >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
-LIB_DIR := ../../lib
 PY_INCLUDE = $(firstword $(shell python-config --includes))
-OBJECTS_LIB = $(wildcard $(LIB_DIR)/*.o)
 INSTALL_DIR = $(shell python3 -c "import site; print(site.getsitepackages()[0])")
 
 all: _raw_pylibcpupower.so
 
 _raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
-	$(CC) -shared $(OBJECTS_LIB) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so
+	$(CC) -shared -lcpupower raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so
 
 raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
 	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
diff --git a/tools/power/cpupower/bindings/python/README b/tools/power/cpupower/bindings/python/README
index 952e2e02fd32..2a4896b648b7 100644
--- a/tools/power/cpupower/bindings/python/README
+++ b/tools/power/cpupower/bindings/python/README
@@ -5,18 +5,21 @@ libcpupower (aside from the libcpupower object files).
 requirements
 ------------
 
-* You need the object files in the libcpupower directory compiled by
-cpupower's makefile.
+* If you are building completely from upstream; please install libcpupower by
+running `make install-lib` within the cpupower directory. This installs the
+libcpupower.so file and symlinks needed. Otherwise, please make sure a symlink
+to libcpupower.so exists in your library path from your distribution's
+packages.
 * The SWIG program must be installed.
-* The Python's development libraries installed.
+* The Python's development libraries must be installed.
 
 Please check that your version of SWIG is compatible with the version of Python
 installed on your machine by checking the SWIG changelog on their website.
 https://swig.org/
 
 Note that while SWIG itself is GPL v3+ licensed; the resulting output,
-the bindings code: is permissively licensed + the license of libcpupower's .o
-files. For these bindings that means GPL v2.
+the bindings code: is permissively licensed + the license of libcpupower's
+library files. For these bindings that means GPL v2.
 
 Please see https://swig.org/legal.html and the discussion [1] for more details.
 
-- 
2.49.0


