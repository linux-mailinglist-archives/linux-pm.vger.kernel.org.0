Return-Path: <linux-pm+bounces-14120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D49774A4
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 01:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8891DB21DCE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67D19C54B;
	Thu, 12 Sep 2024 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcmrkDC+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABEE49654;
	Thu, 12 Sep 2024 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182089; cv=none; b=hPHqN0477HCuBfj7eiW1WhAd/0t6kVJQvFlNRzos4HTEr/ASVD3s4uqOw7e3vnsmaWFPKAqExDpnda1xFRByRwAhxWurtsjSYAT/d8T5T1EtuQzWvQl3mQii4FZwh7bbkrgC6JyyBD0q2rrYmELZpxvJlWesz4cOKWmvnWyumwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182089; c=relaxed/simple;
	bh=1RRhyzzot8M+OzmNpGIM6ngou92I+qH69yeps2lCQVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtlhFY5sfKjF8ERdj3DL6ZP/kRLlaZt3lB7VB98tT8s+UfF7D7cfhzSH87cWFGYe0+hU7yID4pz0m43/LfCS610DvshXHMusU3nxkByD7Vf+0SPakrOyf6pJkhl2zX6CtLHAwYE+3V7bSR0Cc59pGnEmrY4nueROLWTL9dmBfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcmrkDC+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so1268018a91.0;
        Thu, 12 Sep 2024 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726182087; x=1726786887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tuq/qwh3p/xqQg6vD3Gwn7KcfnrMZ+zcgC0C8gCmIbY=;
        b=IcmrkDC+Fc/JLBNqL+bUu4meRvKIZzYY2fjerGnicaq8s1RtIigioTdxiSoUUc+sOV
         KAEsOuNjdk6PtHS1S2Zdc1WkufJq/eERiQSuQkyiUx8aTwaX0V+lEZfDJtJWQiH/+cMX
         h+9weQYUjeEdseG0XN/nN1qjEcvK6kTvhFFi1Y4JTggfD/yKJ3OxcfuzcadakFtwaCgY
         E7Ht48ph/st/uo909kLlwD7BOOTkGtjuquTpeyynDtV+4DRsgDDQGVJNyZqMgcIdPIkT
         U/wN00t1dlAAOt4tmnyxlgD/j70FrnWX5exvAMa0K9EzYb3m2or2gc5qldOIzDUAXZmm
         xxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726182087; x=1726786887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuq/qwh3p/xqQg6vD3Gwn7KcfnrMZ+zcgC0C8gCmIbY=;
        b=XrQIYYv9gHnFmXNgsihn5tunbH/wTVcoJlF0fczQS8EnI0wFYFN2riElM9wVlwhjM3
         2mm36oTAsekvFTJHwKmIV4vCHz1JH3nLdw3hfU8HFJVA15rnjrdJYfQV5fHXvKjLqV30
         +TWIvFa+ba9z+L5OgGxSCbGIlL4b7NxwIZldyFdod8zCkHdTXhm4+003Y+CsIe/r37BZ
         UKR2U50GMLG2O7SXfyHVfurxfvdrkt/qbV/saB78qSeDV6Bjm5Ws4tstHJfMhGngTkdS
         paPiekpYaD0YNxfoOvqh28jaFEEEk6lTTL+tAdBcxN852w0Z4gQVTnmnE6+9cSDC48oa
         dAIg==
X-Forwarded-Encrypted: i=1; AJvYcCUwt3GUXel027L6CffjXtRRtud3gh9AdbafishVOKVh7f8/8N9drKKBByUa8XqK7LfuWNF+nUsUWo4fVOY=@vger.kernel.org, AJvYcCVvChWiGfRBc5JwpeinPXBqi4mItwi+maybOLP3S7LwpVlHKfrBJ4akVHrrmPzBkKMcu4Ld+NtjWIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh9ZfcXb3TytX0meJBssfy8GX2o5KJHu3VcRlFgnLBSbhMqpj5
	Lpx6pOTHIKdNUJWl4bEgk3UiyYMuS3e8HCaMCQlAMD+bTET6jwLE
X-Google-Smtp-Source: AGHT+IH5MYPu1JmDxwSKc5VR1TQ7RPQZ9jLD7DOL/fmFhC5p030rPg3T6VUe3IBfeKA4U0Psw4hC3A==
X-Received: by 2002:a17:90a:fc85:b0:2d8:baf1:e319 with SMTP id 98e67ed59e1d1-2dba0068195mr5160486a91.25.1726182086915;
        Thu, 12 Sep 2024 16:01:26 -0700 (PDT)
Received: from localhost.localdomain (111-240-84-197.dynamic-ip.hinet.net. [111.240.84.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9cadb0bsm257819a91.27.2024.09.12.16.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:01:26 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 for-next] pm: cpupower: rename raw_pylibcpupower.i
Date: Fri, 13 Sep 2024 07:01:00 +0800
Message-ID: <20240912230102.157534-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All *.i files will be removed by 'make mrproper',
including raw_pylibcpupower.i, added by
commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")

We can reproduce the error by performing the following command:
cd linux-next
make mrproper
cd tools/power/cpupower/bindings/python
make

We will get an error message:
make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.

To fix it, rename raw_pylibcpupower.i to raw_pylibcpupower.if.

Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
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


