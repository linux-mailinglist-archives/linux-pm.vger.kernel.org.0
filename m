Return-Path: <linux-pm+bounces-29452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9888DAE70F8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 22:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6462D3A51C0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8BB2E8895;
	Tue, 24 Jun 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QD7PKNOi"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18729B218
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797681; cv=none; b=cZ7JufWrH3pYN862J3CFlPzfHveqnP02w66RtFbHIDb8cfjaq4yf3dksgCO/GUAV1iswY0K8ZRxm3waBgIyOksHBQd1TLbY1MIWCy3xCzYaadYelvZEfj/sCcZn4BUT9dGUifRysBxAzYnWuL37RjFp8S9G3I5nt2cLUnvVl2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797681; c=relaxed/simple;
	bh=k+9iPVrz6CfZoG58QyvK5uEAxAws5zdb8ym5cHLYUH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqTxV/zWMaVcvoqsLspvcSvD/SoPVV5VrzamjpvSltW+AmMTvMIElSazd1urFxxlNkmiI2vr4+EyROPKk5zzOb0+HDPT4uEu1k6uP15Xt5sXeTDR2bRHHj5hE1lM8Z1s+n4xUvCyfaKOoes1sxUvECni2FVA3Yx54S1Q8LbAMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QD7PKNOi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750797678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9wY3aAgcrJnnreOkNCbnB1YfCEDsO/C9hUi3tU5Px0g=;
	b=QD7PKNOigGecKCA03C+/7N3hNHWOfCw3ouCafSN6bSOCOszcKjM63OjqkktjRv0JUUPqPM
	h+rETI6QmOxiUCsKUMbqxX3h1IAtV6LFxv8M4dmLnava2n++x/3ZRB4EzeHduvqDaXsRJ1
	nmooYREzVoxMX4wRy1R1BVa7JMCJzBI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-bhoSvTtTNaCTT93K89WaGQ-1; Tue, 24 Jun 2025 16:41:17 -0400
X-MC-Unique: bhoSvTtTNaCTT93K89WaGQ-1
X-Mimecast-MFC-AGG-ID: bhoSvTtTNaCTT93K89WaGQ_1750797677
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fafc5092daso4034986d6.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 13:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750797677; x=1751402477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wY3aAgcrJnnreOkNCbnB1YfCEDsO/C9hUi3tU5Px0g=;
        b=N+5CAQjmD5KjrRVlaqFk2fp79BcosuaFWfcDkylKx0T8xNi3kDA5EuMdm+BttER8vt
         gmpfauCpNx6/yqmVS03XwUGzLSo/z5mU8hzWrQ8HCclGJBYPF88/NAa88EWbWrWK60ZE
         wx4Ofz3wABjbgpQ6CADkI4IB3gq/oYVKCzcNLLsWRyqXmtTBFrBURZi4PJSdmwqBY3pO
         VSmdhF1y12RxZl3zvQ979eFuXmSW93r5paLXNAKP6kU2Ayr6PFu+7H2edWRk1O568HGh
         Qrpd14ARPgQUq09QhCLittTYjYmAI4rPzvhR/R82iIKSUwePRZWKWGd4efHIZc8AeFTL
         f3Og==
X-Forwarded-Encrypted: i=1; AJvYcCW+uWmrGFczzO8tM2zVzaRVQXqugyjhjr/l7ETvRrpUjjgRUCbNcBmqEjLG7xeu1lTQfqVmJfxggg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZkWBl46WJOZmOqZV4LbXA2DYM07+otwJWMdJxHl7p2vRQ5LN
	gienzk35VXoIVcFiNasZeVg7QBbsHOqmL9/BT/2REnp3iMma73pTY2Js88QMiRX5s68Vyl0d+g2
	bcvCOIePhFgA5+1F6ISXtANF/3xQMOfoW/mp2ZNUcwuA+yCvu9PX8w365PSbG
X-Gm-Gg: ASbGncsl8mAFzZDlHwneIT2vmCFcCoouJLMuaksjfxuIDiHl/PpRVP43klkFT+CYwOO
	ChvF/M0n+2VzGZq9egRAIDEfWQec9pgOVDdbtPn2HBon0ac+t2365PAAXVaZpcmfzfofNs4K9OH
	9ygtIiCu62CwS1rzZa5e/jXLJieWvWO2uF14JVT+yrhphTdL54sBtgcj9at+PeaCKvx7hUkjh7Z
	NaiA4DpwgrkENgXoA7R0mEcNyaRN2TyNxlS3cD7RslJFe+EAbPT35Q97Eepn5E1X36srjbMJXZ1
	v9QPWqnXcIGPx21PcbTMcLr2Xc3+LMkyig==
X-Received: by 2002:a05:6214:554a:b0:6fb:6129:d6f5 with SMTP id 6a1803df08f44-6fd3887da67mr72486356d6.16.1750797676776;
        Tue, 24 Jun 2025 13:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5S9LIIzK9+mA9lXLYWbYKd/trucZBeWJrars1+wS2MF8l6jyFMgEhWMuXKpGrcN17UGrc7Q==
X-Received: by 2002:a05:6214:554a:b0:6fb:6129:d6f5 with SMTP id 6a1803df08f44-6fd3887da67mr72485996d6.16.1750797676378;
        Tue, 24 Jun 2025 13:41:16 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.37.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0957f69bsm60875306d6.96.2025.06.24.13.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:41:15 -0700 (PDT)
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
	"Thorsten Leemhuis" <linux@leemhuis.info>
Subject: [PATCH] cpupower: Improve Python binding's Makefile
Date: Tue, 24 Jun 2025 16:41:04 -0400
Message-ID: <20250624204105.457971-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few build variables to make it easier for distributions to
package the bindings. Allow current variables to be overwritten by
environment variables that are passed to make.

CCing Thorsten Leemhuis <linux@leemhuis.info>.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
index 81db39a03efb..4527cd732b42 100644
--- a/tools/power/cpupower/bindings/python/Makefile
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -4,20 +4,22 @@
 # This Makefile expects you have already run `make install-lib` in the lib
 # directory for the bindings to be created.
 
-CC := gcc
+CC ?= gcc
+# CFLAGS ?=
+LDFLAGS ?= -lcpupower
 HAVE_SWIG := $(shell if which swig >/dev/null 2>&1; then echo 1; else echo 0; fi)
 HAVE_PYCONFIG := $(shell if which python-config >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
-PY_INCLUDE = $(firstword $(shell python-config --includes))
-INSTALL_DIR = $(shell python3 -c "import site; print(site.getsitepackages()[0])")
+PY_INCLUDE ?= $(firstword $(shell python-config --includes))
+INSTALL_DIR ?= $(shell python3 -c "import site; print(site.getsitepackages()[0])")
 
 all: _raw_pylibcpupower.so
 
 _raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
-	$(CC) -shared -lcpupower raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so
+	$(CC) -shared $(LDFLAGS) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so
 
 raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
-	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
+	$(CC) $(CFLAGS) $(PY_INCLUDE) -fPIC -c raw_pylibcpupower_wrap.c
 
 raw_pylibcpupower_wrap.c: raw_pylibcpupower.swg
 ifeq ($(HAVE_SWIG),0)
-- 
2.49.0


