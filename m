Return-Path: <linux-pm+bounces-13790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4596F4F1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 15:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCDA1F256EA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D31CE6E8;
	Fri,  6 Sep 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdTc6dxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723FA1CF2BC
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627668; cv=none; b=u38czvtjukzgQJNDydjuxZd7WIGwkQ6Nfi2tUt/fcHR3kRxHukUqdECyfnEwFs2sfaQUz3Zb90ranD3m3ICrkU968Zqc6EehhrrHQEj+6ekCJJEBqjU7E6XLTh6Q/22Ag4XPceYGNnxQUYyaNTodRPr4XZ7pvs7rZod3v+2oono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627668; c=relaxed/simple;
	bh=m8IdfLpm6dBD3gYM2Cmv0JkyJXkh7XoqGviYibjpFcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMcaO8pgArHT9f6sD1oF1GKJWweE7bwjt/JAG7j/Km+Yvcf7k/jBmfs4AXJuX5qtq+af3lK47qZTm5usq63Zx4Ki+YTOWkRngFkN8KjxVJR6fZl1+LxzawMwObZmK73irrSJmTqbr6g/Fdn9N9RFWRMVMs72VFrrqXw7LVgjOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdTc6dxi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725627665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CiKqAroYWdf43zkRcfKQYQltrVb+7u4tENXGnVB3T94=;
	b=NdTc6dxiUHcPFIF4oVdQppXavNgrPT3Xpb9kA7GTqQk1PWTNRsSQpuwfIyA7gqxeeNTQI4
	+94XIGyftm1+FWbFk3Jr/gpziSmJHy+4BDKyPxwSl0A11WuDFOOdH1uXQVMK39YEUifHHH
	IqUXN6aMLU2pVcrAPoAqqlUrUHrkGaU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-VaDBkYWlNuqmH6XmQkBTUA-1; Fri, 06 Sep 2024 09:01:04 -0400
X-MC-Unique: VaDBkYWlNuqmH6XmQkBTUA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a809183f6fso295160185a.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 06:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725627663; x=1726232463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiKqAroYWdf43zkRcfKQYQltrVb+7u4tENXGnVB3T94=;
        b=NprsSBj9rXwbZf4s6EwjG1XW6noVnm/l4E5++N0Al/zMtHanM7b+3mrGBJcCfZ/UB5
         u9WlLavrNDeKvChK7F0RwjeOrPtPvRguBcnicUGH53J7HrDkr+fJ7+wy5RPLZiiXdAls
         K3noOE1ZJ1HAxDQzzUdEHaaUI9m8UfMNZM+v3jtYMc96Js/A0nl/YThv3TEFIAjlA3Bx
         r4V3cRASKRRvCA2xxEq6C7J8Xt2RnMQBbKOe5hUgXdFvR2vfnpbqUwoMEsq7E5BHP0HU
         YifexWKGaP9UipZt80bo8rX07emdQ/PhmK6SEDqobr3StFvguvP7Wtv9L/yVVxMA9fg8
         miKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfdHEeV2mQgaucvS9xr8W4yDjsY3311GUjQRp5ntFw68kHTzveP6/GLXRobguRQmlULPS8npxg+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4n/nxD2e+mVbw+QRel3PaotYXrJ0tbA2joYM3YFrqlIGKBxx
	wsc+QmQGodbjzX7yjxH06UZ6Ey5YtoIqAdPscHygP+TBZ5qJSITyHVrTpY36ZDXyWB0f4NyqZvu
	EXyZXP2o0oizZqrG3AgsRRUN1lC4o7iAiKkQj8UpmcucDsVcsvE9Q+fr5hFArhovVqBQ=
X-Received: by 2002:a05:620a:4693:b0:7a6:5d39:39d3 with SMTP id af79cd13be357-7a9973307abmr339556485a.24.1725627663043;
        Fri, 06 Sep 2024 06:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZTY7wG+sUUKJ10NlP7XuB3LjDNGb/R+TOag6TwkDr3OPxHFxDGi5l6ZtOPbIEoOShkCSxg==
X-Received: by 2002:a05:620a:4693:b0:7a6:5d39:39d3 with SMTP id af79cd13be357-7a9973307abmr339553285a.24.1725627662593;
        Fri, 06 Sep 2024 06:01:02 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801a15441sm15930351cf.19.2024.09.06.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:01:02 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 1/1] pm:cpupower: Add error warning when SWIG is not installed
Date: Fri,  6 Sep 2024 09:00:06 -0400
Message-ID: <20240906130010.93773-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error message to better explain to the user when SWIG and
python-config is missing from the path. Makefile was cleaned up
and unneeded elements were removed.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/Makefile | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
index d0418f902795..dc09c5b66ead 100644
--- a/tools/power/cpupower/bindings/python/Makefile
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -4,26 +4,28 @@
 # This Makefile expects you have already run the makefile for cpupower to build
 # the .o files in the lib directory for the bindings to be created.
 
-CC=gcc
-
-LIB_DIR = ../../lib
-BIND_DIR = .
-PY_INCLUDE := $(firstword $(shell python-config --includes))
-#PY_INCLUDE = $(shell python-config --includes | awk '{ print $1 }')
+CC := gcc
+HAVE_SWIG := $(shell if which swig >/dev/null 2>&1; then echo 1; else echo 0; fi)
+HAVE_PYCONFIG := $(shell if which python-config >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
+LIB_DIR := ../../lib
+PY_INCLUDE = $(firstword $(shell python-config --includes))
 OBJECTS_LIB = $(wildcard $(LIB_DIR)/*.o)
-OBJECTS_BIND = $(wildcard $(BIND_DIR)/*.o)
 
 all: _raw_pylibcpupower.so
 
 _raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
-	$(CC) -shared $(OBJECTS_LIB) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
-#	$(CC) -shared $(OBJECTS_BIND) $(OBJECTS_LIB) -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
+	$(CC) -shared $(OBJECTS_LIB) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so
 
 raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
 	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
 
 raw_pylibcpupower_wrap.c: raw_pylibcpupower.i
+ifeq ($(HAVE_SWIG),0)
+	$(error "swig was not found. Make sure you have it installed and in the PATH to generate the bindings.")
+else ifeq ($(HAVE_PYCONFIG),0)
+	$(error "python-config was not found. Make sure you have it installed and in the PATH to generate the bindings.")
+endif
 	swig -python raw_pylibcpupower.i
 
 # Will only clean the bindings folder; will not clean the actual cpupower folder
-- 
2.46.0


