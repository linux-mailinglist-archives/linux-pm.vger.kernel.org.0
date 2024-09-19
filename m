Return-Path: <linux-pm+bounces-14486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5345497CD6D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CBF1F23E05
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B751CAA6;
	Thu, 19 Sep 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aASGnf5l"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29414A96
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768995; cv=none; b=JP07uqOqPfak4YSPVrRQV1VyDpzSRljr5cHortCzRNTJeg8awN4fSI9fKefWoVdS/hpIG08rOT3DTr34F74SX30mS/lamxqCnGhGjtuxPrqO07i91Sth1Y/Nub5GnTcoVFATcv+A6MYFC4HwXqMW0ooRIBBQiVCEOxQt4EkenxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768995; c=relaxed/simple;
	bh=e0wtT19dYMDMyfhWCQLhYZ2yk+Cou298QlGCexKO5I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALBF1VMnWiu6HMbpVa5UihYl8Mz4sdgT16ACoyfB4IQlApNVuTPFSvxYYSUlasJUsr7H857v1gCMclHHg1heCaGwI/EXSoM0tiYQDT5rnxCm82aQnY/hjUrTVbI3KrVHNfn1daCHwnvl2KxyqSxv9Ayr2k6uluvWNq6YmO3kACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aASGnf5l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726768992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PEVVCV0eXxZeKN06cXXcnbtsFJaX89LX0ix5stsQGvA=;
	b=aASGnf5l9u4QvtU+Ax3uVBz0iEeugjAN2XaZV84qmHbDk3L3uQjtWduprElVZCpaYeQ+78
	iciWYxAFO+tLaxW6GLIaiOiTsRGuSlmr4F8rfjnZaRuUAlotawRIU6Z6ZQxtv3Zt8fYdsD
	Gla7xoZc1cToynTgLXCNo4aPHfiQkNw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-TkXFUe6BM8e3STPDR7bnEw-1; Thu, 19 Sep 2024 14:03:11 -0400
X-MC-Unique: TkXFUe6BM8e3STPDR7bnEw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a9b41d95efso223639185a.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 11:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726768989; x=1727373789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEVVCV0eXxZeKN06cXXcnbtsFJaX89LX0ix5stsQGvA=;
        b=s2o6K7hjEDFdwnUzgbpqpm+bedFU7MnzdH1GBLIvm4K+rRb1oveqJIMPKY2KzCO/wc
         LGD+10IBlC7Qkc/au/4eKnykNCY3C1pYjDYYACxndQBMYcPhv+B5XFt9MkrPCzBXjDUY
         Dgqt9J+zV1U7Om+U/Xo0NYBjNMCdI9+BsFTQfYGqgSwOhBA+2LEqDUu/GEHYAcKm9oLb
         MNp3SA7YUJS0a0+8wO2M1mmJ5xtqexW5W6gMhi6wcjYgXiPLCJR8toXbv/clFJpPQeO9
         SGPyq5aD13UYGmfJxY480UOmcp3v1el6X092ErBOuU+VRbwrLVgtJCvFk4E4lsvEmo38
         zvUg==
X-Forwarded-Encrypted: i=1; AJvYcCUkP/xUe+te8XdfsKJplcdZKu0wpQ2QEFfbC0cVU44ufsNoVT+9v/VlDeScdl1W+wiLEXmcKW8SzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDcfkoeWpUIYQVnBb3fWAXZoBvKqZk4t1Z3oBvdyMeD5sfvZf
	2J9M0R7akurM4TwUIic5HokTMPAHEy64Rhj0/33q9Eyg/o8j6SykATMH9HH4yNh5qtiAO1vWoI3
	oSnTURQzFtDSjVXVU3W5O6ABdFyIiW6gn3QXGv1HuXF/lp6ItFiVjDCRS
X-Received: by 2002:a05:620a:24d4:b0:7a1:dff1:57ab with SMTP id af79cd13be357-7acb80ab1d4mr35906485a.23.1726768989429;
        Thu, 19 Sep 2024 11:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9RkMsz091nt5D4n5G79Ahwqx7Q5einp6ANgb25P9fWEAnjJsSSqRv5u4PVrzdbrAK6h6vXg==
X-Received: by 2002:a05:620a:24d4:b0:7a1:dff1:57ab with SMTP id af79cd13be357-7acb80ab1d4mr35902285a.23.1726768988985;
        Thu, 19 Sep 2024 11:03:08 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb07dfebasm96263485a.17.2024.09.19.11.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:03:08 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] pm: cpupower: Clean up bindings gitignore
Date: Thu, 19 Sep 2024 14:01:01 -0400
Message-ID: <20240919180102.20675-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Add SPDX identifier to the gitignore
* Remove the comment and .i file since it was removed in another patch
and therefore no longer needed.

This patch depends on Min-Hua Chen's 'pm: cpupower: rename
raw_pylibcpupower.i'

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tools/power/cpupower/bindings/python/.gitignore | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/.gitignore b/tools/power/cpupower/bindings/python/.gitignore
index 5c9a1f0212dd..51cbb8799c44 100644
--- a/tools/power/cpupower/bindings/python/.gitignore
+++ b/tools/power/cpupower/bindings/python/.gitignore
@@ -1,8 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
 __pycache__/
 raw_pylibcpupower_wrap.c
 *.o
 *.so
 *.py
 !test_raw_pylibcpupower.py
-# git keeps ignoring this file, use git add -f raw_libcpupower.i
-!raw_pylibcpupower.i
-- 
2.46.0


