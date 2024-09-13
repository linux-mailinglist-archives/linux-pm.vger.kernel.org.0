Return-Path: <linux-pm+bounces-14201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB69789D5
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5181C2151C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BACC12FB0A;
	Fri, 13 Sep 2024 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JcRgfj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAC6F077;
	Fri, 13 Sep 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258651; cv=none; b=nWyOGE0Yju613TTILRjzgkVMXt43hTB1O+Mc6z6hiJxVvkkqV8bG3rRAkSmqLrLfVHD0ctCi2b7WkS5qQIe+BYJ8ZhpZgSZNdlLfhFKO0L3rHHQEQvyGTrOKMnxWD82xkvjXNktiRz7oRq1Fa+7fGjr2ymRFe2zfr55NQfZUshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258651; c=relaxed/simple;
	bh=88eIVuPmnZtIGAw+EMKNTB/3t5KYG6GUYhxR4BZI0Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcing56C30YQZiDbnncY7r1Ryq9spp5HPFYPUpw0WA3qakYVIKavqgbTOBjGT5C4bNlBC+zHbTJ7/cggnikG1bjIqxGNpc3F4BCZAxLuilUdN29EKbQwIEggFo93wuVXKXmfq2GAWFU4WgAQ0ijlRlBPl9X6a4Ue21IaRdNuhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1JcRgfj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc47abc040so22740945ad.0;
        Fri, 13 Sep 2024 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726258650; x=1726863450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38ACiQq21HRcY9nPJB21d0MtTCj9O/Li+MCcuEZhYVs=;
        b=e1JcRgfjc+05XFpD18J0zMIZ8loHhXGAlAcaZDaU16qEMtMbxVXg2eseW6kEM5G49k
         ITURbSZnbgBwIJyODW/6ByFPyUF0mHS7slQR46/75maTa6t2i45eJexY76FiMe17wBLM
         w7isNLRmTMtzxTxXyUWVf8T58UXbSzGAwHSPZ9cbEu7+GHYCVBueP3NLmwTfjL89qSSq
         eVI5Jv4h6U2/12APtZVrJx1uboWz05PG+aRsk1RyXo7mkeBOg3jBtwpjHXYVAFPAFCLZ
         oENO+TlMUWqajq1wgzc0LH5sol0/NiBYa85WxGtfWWN5OucgKJ1Z/SVWibjMaaEVCmxA
         /8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726258650; x=1726863450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38ACiQq21HRcY9nPJB21d0MtTCj9O/Li+MCcuEZhYVs=;
        b=hiPK5GPRnVI23+LftwaEORHJvcprL+DLSLWyUlst+Jo67BGRjOoGeYkhmOaMIBiv71
         NJHRH1MBQz6ZlTXKcEoCgPqGR+yyJTtcAQfHiVOWzSfrC79fkn4mybaL5VWe8h3ummut
         DigA50KBjFo1HJTah7Jyo6uFicCLXUBBdJAJRAZCL8S2WRY30Ds8xpQ3rmbtNvskdDlc
         VHIxOrsac3sh0rQwJbeGxgUW+j1YuM9+FHtK7E5pOtYcxMlZUcXxp3BeiRqr2miQOmIA
         YKMc6ahttcVUqcglwFpHoLAufHQ+e+OR8ya7zJnol20MFXfJ0aiZ9vmDeeXORN332Sc8
         Hlrw==
X-Forwarded-Encrypted: i=1; AJvYcCUM4JDxtquRyIrG58NyEi3OothE8ty9bNZfEjIvac+VhFu8xg7cMRERClZ9SfKBtCulf3G1UOTezSLqROQ=@vger.kernel.org, AJvYcCVdxTad+AUO2AHxnczDBSyFdphI8nu+oUi5pEtYqQxZ6DdwWCAs4/o47GiF/SQwTb2bShD9ngKBnag=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYcIRGlsXc3z+oSGiVQDfwnFQbx3gzjv0AwG51ia8jDI4uzgG
	g8NFyjz+KmKIB530VUprw+G8154oQixbeSXm9t5uAMCmEdgoDFXv
X-Google-Smtp-Source: AGHT+IHZJQHWLQIcilzzywsR5b4HQd3k+2Uech6yBf/l6NqklFIffNJiwgbfYsfXyaz7j2BXbJQHvA==
X-Received: by 2002:a17:902:fc47:b0:205:94df:e087 with SMTP id d9443c01a7336-2076e31eb57mr95455795ad.9.1726258649818;
        Fri, 13 Sep 2024 13:17:29 -0700 (PDT)
Received: from localhost.localdomain (111-240-84-197.dynamic-ip.hinet.net. [111.240.84.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794602c3asm315765ad.92.2024.09.13.13.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 13:17:29 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 for-next] pm: cpupower: rename raw_pylibcpupower.i
Date: Sat, 14 Sep 2024 04:17:02 +0800
Message-ID: <20240913201705.7764-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw_pylibcpupower.i is removed unexpectedly after 'make mrproper'

We can reproduce the error by performing the following steps:
cd linux-next
make mrproper
cd tools/power/cpupower/bindings/python
make

We will get an error message:
make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.

The root cause:

The *.i files are already used for pre-processor output files and
the kernel removes all the *.i files by 'make mrproper'.

That explains why the raw_pylibcpupower.i is removed by 'make mrproper'.

To fix it, Follow John's suggestion to rename raw_pylibcpupower.i to
raw_pylibcpupower.swg.

See:
https://www.swig.org/Doc4.2/SWIG.html

Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

---

change since v1:
build a non-frc patch
change since v2:
follow the document to rename *.if to *.swg 

---
 tools/power/cpupower/bindings/python/Makefile                 | 4 ++--
 .../python/{raw_pylibcpupower.i => raw_pylibcpupower.swg}     | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/power/cpupower/bindings/python/{raw_pylibcpupower.i => raw_pylibcpupower.swg} (100%)

diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
index dc09c5b66ead..e1ebb1d60cd4 100644
--- a/tools/power/cpupower/bindings/python/Makefile
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -20,13 +20,13 @@ _raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
 raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
 	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
 
-raw_pylibcpupower_wrap.c: raw_pylibcpupower.i
+raw_pylibcpupower_wrap.c: raw_pylibcpupower.swg
 ifeq ($(HAVE_SWIG),0)
 	$(error "swig was not found. Make sure you have it installed and in the PATH to generate the bindings.")
 else ifeq ($(HAVE_PYCONFIG),0)
 	$(error "python-config was not found. Make sure you have it installed and in the PATH to generate the bindings.")
 endif
-	swig -python raw_pylibcpupower.i
+	swig -python raw_pylibcpupower.swg
 
 # Will only clean the bindings folder; will not clean the actual cpupower folder
 clean:
diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.i b/tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
similarity index 100%
rename from tools/power/cpupower/bindings/python/raw_pylibcpupower.i
rename to tools/power/cpupower/bindings/python/raw_pylibcpupower.swg
-- 
2.43.0


