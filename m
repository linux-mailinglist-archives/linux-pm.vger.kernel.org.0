Return-Path: <linux-pm+bounces-14089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7A976992
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 14:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FD11C21403
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B51A2628;
	Thu, 12 Sep 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaqTGese"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370C1E49F;
	Thu, 12 Sep 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145461; cv=none; b=opZlApTqg14H51iswR65PfVkHWVLm1v7nFOiZDXTXaJB1CiveUoZa+Q7JQfom91912nM7M6c5lgQEqmAMtvx/NSKDSF6frAJ8vwvZhuwOdPN0/cV9nCKK/48DUrBuLN1QK661+f8t8A5myzgmh85Oq2ob0XmpodcZoJHbcCzFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145461; c=relaxed/simple;
	bh=rhGAFJLZdYULWmqugAH5q22T7v2IoB+sN5c6zKJc6ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqytJ6MDGxgBdEcw+bfQGSoKLscr+j6FyPCIjDpVlbJyx4HE2C30KLqocgLGMVIx6n6gQJfqbq2TCNIRTWRkdQRUlppF0PPI8QrPFXpUG+EKQoJrQfh1BxlfJ7NJnLiKCm3AiSxgp8sbJik8Q+cLOHr5pAE1FxhtPh+2pXdFVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaqTGese; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so654588a12.3;
        Thu, 12 Sep 2024 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726145459; x=1726750259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qbl1iaUR2c4V+S7jU/mCx2/ogYw3sZGuzOxETHSFsSA=;
        b=PaqTGeseY5RzNvbJJkjP5jlAz401rahZhQ6q5F7tRY/+iFPNowxetB5XYEY70W8DQP
         a72srwk3DBKXovsWzfp4PBn8ZvFKR69+sOtZ9vzcqqIhCm/VQNtGBoUAjSIgX/u8TZHE
         nFfvtQLNYNLIMBeSOM+/Hkpzcy24IfB6CRfVwUlh5Bj/t60b26laVp/6hrh0YI2Axq4p
         skJmIDqqDvsik6xjONr/b35QDXjXWoGHEDshyOqvQZVFOxSLBURE/J0saicjAx9l5OU5
         +xcqcoGtR3G9X5Z4pedAwl1kxyidCJ0J1po2K+hyD4pbXv+wewNK98L8nZ3KyiVNShtX
         CeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726145459; x=1726750259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qbl1iaUR2c4V+S7jU/mCx2/ogYw3sZGuzOxETHSFsSA=;
        b=PTGWwPHWnVaytj/z0DqtqBJg60jNb35f9T+iSSM4koXMg128hiyXI7CvrNCF3o8E2b
         sGLKBtQxe8Ou9qktDPj1uaGpC+HwK+90/kHX236FGBQd36GRVbM+/hIPSjCks1z4/evu
         g3Kv0D679F9ypAt6zRcOAWnOSf8jvaX8HBMUmlA546eYTeuXo75v5G6wFRJB5V72lXRB
         vQQa36Ccxdmg+5JpGkHM0reBFu1ab28Efuf2U2ktatMmmPd0ISaEW2B73g23MFPcgCy6
         Z+PVggHoV/c5H9oa00+Jf1QtLg71wshggB1RqtYFYzyeWMwuLAcjEHdsraz6c0bDtdH+
         q9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnwpS8Kx/nHHYrTsmg8ZifXwQvIAkUzIYM6vqpuP0KGK6L0KtMPbPM7dDWhgUGCsCBi7X2S57EKvA=@vger.kernel.org, AJvYcCWwHU9gNuqPcMvLSDXCg88i7Y1bTe8oKd6nurvhHGpgbcN0NCW/qz/D+vSlg3GuwV0FYxJFZwinuzWiWeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA64rbdkrt5t3E7Y3/fyBiNpMUmtLfi//8MOZO8XfglGWHdJH7
	w+QOzc2N+UfjfsjSCfQ4wN3QnDPuYkHiKGhXE2lUZFpCpOAE4SZu
X-Google-Smtp-Source: AGHT+IHSbW/nMzRUM6QhfvnsskqRV7tmDumVfuk+/7jl7+fnHIG6pfyTOXR3vpBb6JLSKFQn/vzQsQ==
X-Received: by 2002:a05:6a20:e608:b0:1c8:b255:486a with SMTP id adf61e73a8af0-1cf761f9aa8mr3526683637.35.1726145458472;
        Thu, 12 Sep 2024 05:50:58 -0700 (PDT)
Received: from localhost.localdomain (111-240-84-197.dynamic-ip.hinet.net. [111.240.84.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc10fa99sm12477739a91.39.2024.09.12.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:50:58 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
Date: Thu, 12 Sep 2024 20:50:28 +0800
Message-ID: <20240912125030.19809-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch is actually bug report. All *.i file will be
removed by 'make mrproper', including raw_pylibcpupower.i, added
by commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")

We can reproduce the error by performing the following command:
cd linux-next
make mrproper
cd tools/power/cpupower/bindings/python
make

We will get an error message:
make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.

Renaming the raw_pylibcpupower.i is just a workaround to fix the
issue above.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 tools/power/cpupower/bindings/python/Makefile                 | 4 ++--
 .../python/{raw_pylibcpupower.i => raw_pylibcpupower.if}      | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/power/cpupower/bindings/python/{raw_pylibcpupower.i => raw_pylibcpupower.if} (100%)

diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
index dc09c5b66ead..de872a1b80d3 100644
--- a/tools/power/cpupower/bindings/python/Makefile
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -20,13 +20,13 @@ _raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
 raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
 	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
 
-raw_pylibcpupower_wrap.c: raw_pylibcpupower.i
+raw_pylibcpupower_wrap.c: raw_pylibcpupower.if
 ifeq ($(HAVE_SWIG),0)
 	$(error "swig was not found. Make sure you have it installed and in the PATH to generate the bindings.")
 else ifeq ($(HAVE_PYCONFIG),0)
 	$(error "python-config was not found. Make sure you have it installed and in the PATH to generate the bindings.")
 endif
-	swig -python raw_pylibcpupower.i
+	swig -python raw_pylibcpupower.if
 
 # Will only clean the bindings folder; will not clean the actual cpupower folder
 clean:
diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.i b/tools/power/cpupower/bindings/python/raw_pylibcpupower.if
similarity index 100%
rename from tools/power/cpupower/bindings/python/raw_pylibcpupower.i
rename to tools/power/cpupower/bindings/python/raw_pylibcpupower.if
-- 
2.43.0


