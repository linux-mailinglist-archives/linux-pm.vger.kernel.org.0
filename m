Return-Path: <linux-pm+bounces-15660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBE99F0B4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 17:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BCE283397
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39851CB9FF;
	Tue, 15 Oct 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGIfYFSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AD1CB9FD;
	Tue, 15 Oct 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004980; cv=none; b=B6quGOoOZhO5l3tMaD5rLahUTGsKb969vwCzzU82RkmHtUcXH7NfMuTT8CSVvsOOqd86ZNOmhbQGQRDbB7nYT+Gn71sjjvYV5W61mBMknM1vyBbz7r3+YmxLCGJDUJKPtMw95afxMSzH/PPrAUey+37dMJe1cgpbdGcwsutvJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004980; c=relaxed/simple;
	bh=B8ChUxBvAFtLMqKDKXjgchdjFht6tXh8QUoy24QiB9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mjkx8qK7Hvsddd5XUquV4anCmqhADditixWA78N6rOczpi08z5Kwe6YfmAziWFCkv4hOni8Grcio0CKGF/UXE5vI46IM+Tl/JBebkJevjJqnADOck16xrol0dmiOts3DtnabJ7MnCLgIL41ljJUMdASJU0FE45MBVMA7J3Pg+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGIfYFSl; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-8353b41369fso353601539f.3;
        Tue, 15 Oct 2024 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729004978; x=1729609778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jFk0JoI0mzXirTKJ2ym3XvHzvgOMMC5dTTxSarG5vI=;
        b=eGIfYFSlYD5bgXLpXBYgFM+RDao93/v+IYb9lgWPgmsmYJKFV8t58p9u+nxgSsExG9
         OnFOJIWTyu6qq06838ArpzOlhnyYJUtP+FU219y2gQ3vLYLMnp3dcQnMcHbyzgCtWBKC
         Y8bP21itMe1HeSrtuzT7rlpf0Avj4MlvzOSQUY2tpZVoVzUMPXZ2uw7NEj3JiWzoMVzP
         xZ+lx4c4F8/+saagH/VAsByG3KDmEwEmHAu/HF9LRD/G+xGjAzJZlcg84s2xqWyMLapp
         lO5p0VMzaEzrW0cGjbi/S6VGSBtKXT+UqGtWYMuJuBN66SHpOxejRa/jcKj5u2KSEXhV
         Hp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004978; x=1729609778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jFk0JoI0mzXirTKJ2ym3XvHzvgOMMC5dTTxSarG5vI=;
        b=ZkOpVO596aQXCVVxlJ7nMTnNkj81sSUeMEQ7H0Vb+YUbx5DVT6cVzWEKpT+AnAwQvR
         vg4QBTLiz/id36LUJDpCeRJ3dEjxz/EIqv6m72pBaie6plXKZpDB2VpehtTXSx6OFi0m
         3IF1nDZxpMkKzNXNLYcZohIiwoTo/MYvOm4xiJc7bXlMtxlvvz+oDBi2g+wPnrKsK3Xp
         INLQWMv+tptvC11gm737E6v3HRCh0qWx6mYw7Y7JhRQcXk+jY8aM2OGlzp7FTea4vc5e
         8b8ZBTol/Y4auMQoIHTB4SWksPcRgIqqYYim/Q23x2hXv/BU6ALQBigAe/r595DuWODe
         8O1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2b927CqWdS8HkoLFvR6TCv7bbELVuW76fQxUKTAePfL1qi+JeWASbOzbp67aty0crhAXVdeNZd2PHlSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8a6KnYNDGrnIpShSoorQ4D7iOqNoauL2gP1Giqzp6CRuvWOeR
	O05/obL89zakWYBR1ojfygDBAuEOfnkK1Zi00zZlW1VC/XXUBrmh
X-Google-Smtp-Source: AGHT+IHdb4DKuD8UI9qQvkOpboqxD26XUGSjN3VyUCARnSUSOGkRglKnUFhhRT2KKjLmh7Kgs5mNIw==
X-Received: by 2002:a05:6e02:1c0a:b0:3a3:aff3:a02b with SMTP id e9e14a558f8ab-3a3bcdba90bmr96729065ab.6.1729004978169;
        Tue, 15 Oct 2024 08:09:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:8dc0:b002:b20f:f975:8fff:9776:9f47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d58ddsm1458406a12.53.2024.10.15.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:09:37 -0700 (PDT)
From: Kieran Moy <kfatyuip@gmail.com>
To: shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: [PATCH] applyed suggested changes
Date: Tue, 15 Oct 2024 23:09:20 +0800
Message-ID: <20241015150921.78678-1-kfatyuip@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

---
 tools/power/cpupower/po/zh_CN.po | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/po/zh_CN.po b/tools/power/cpupower/po/zh_CN.po
index 456cde997..33fb3f000 100644
--- a/tools/power/cpupower/po/zh_CN.po
+++ b/tools/power/cpupower/po/zh_CN.po
@@ -19,11 +19,11 @@ msgstr ""
 
 #: utils/idle_monitor/nhm_idle.c:36
 msgid "Processor Core C3"
-msgstr "处理器核心 C3"
+msgstr "处理器 Core C3"
 
 #: utils/idle_monitor/nhm_idle.c:43
 msgid "Processor Core C6"
-msgstr "处理器核心 C6"
+msgstr "处理器 Core C6"
 
 #: utils/idle_monitor/nhm_idle.c:51
 msgid "Processor Package C3"
@@ -35,7 +35,7 @@ msgstr "处理器套件 C6"
 
 #: utils/idle_monitor/snb_idle.c:33
 msgid "Processor Core C7"
-msgstr "处理器核心 C7"
+msgstr "处理器 Core C7"
 
 #: utils/idle_monitor/snb_idle.c:40
 msgid "Processor Package C2"
@@ -47,7 +47,7 @@ msgstr "处理器套件 C7"
 
 #: utils/idle_monitor/amd_fam14h_idle.c:56
 msgid "Package in sleep state (PC1 or deeper)"
-msgstr "处于睡眠状态的包（PC1 或更深）"
+msgstr "Package in sleep state （PC1 或更深）"
 
 #: utils/idle_monitor/amd_fam14h_idle.c:63
 msgid "Processor Package C1"
@@ -59,11 +59,11 @@ msgstr "北桥 P1 布尔计数器（返回 0 或 1）"
 
 #: utils/idle_monitor/mperf_monitor.c:35
 msgid "Processor Core not idle"
-msgstr "处理器核心不空闲"
+msgstr "处理器 Core不空闲"
 
 #: utils/idle_monitor/mperf_monitor.c:42
 msgid "Processor Core in an idle state"
-msgstr "处理器核心处于空闲状态"
+msgstr "处理器 Core处于空闲状态"
 
 #: utils/idle_monitor/mperf_monitor.c:50
 msgid "Average Frequency (including boost) in MHz"
-- 
2.47.0


