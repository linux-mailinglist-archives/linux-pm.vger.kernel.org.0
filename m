Return-Path: <linux-pm+bounces-15666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53EC99F2AA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5ED1F21457
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DE1F6690;
	Tue, 15 Oct 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmmJScQK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33E1F668D;
	Tue, 15 Oct 2024 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009496; cv=none; b=WENIo87tFzcSSao2O88wdXhgLNDu3ayKFrzxRB0A9lS6pVRUF5b3q4Bps6whjZvyH3fzastYywn8dstKj9W84QwAQ4AI7tABs5rAehE2qq4tmaPXdNpUJoaPb+hFrcpUM3rQKV3Yk5bylfMGeYoYAVthHxEs8FlNjf81GwZO0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009496; c=relaxed/simple;
	bh=xfI79rRGcda0a66L5yluw3psyRMrTfQn6bvg/mdHebM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAWdC2QkFkxKHnV3XhC2ktkFIlbXwVnzi6HsCEnTJGVHdRZjUHs5xLs9IniS5lNyzNLaHIddPqLyMJiCavgEdxifwfm68FDSJXQI4egWlSFz638zRSgcEEcxIfueB1oDVUHqhRhP40Xez+U6+nW7qtrUHR+xhZK4U7u11wlaHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmmJScQK; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso4028301a91.3;
        Tue, 15 Oct 2024 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729009494; x=1729614294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXS006kl3x2FfCHKdgorpQBPHYthQinsFnXKbdJpjnM=;
        b=WmmJScQK1oq5JOuifQrse/COL2OU5H+xEYF49XkuBUAW35leQ5hr9kXNSU80YT/vcZ
         JtrXwBCdmP58Sn7ZUheuQ0JlQgbje9M+wxwbMGxb4OF5RGzDye4xHeHscSI5ckPLi5XN
         eGGc/0cEENKgbbbnvZB7awRtdSn3iSV1BpTtey/30a49Ypjn6bOuSFBDsyso4PnlnIeJ
         Dj0Tn7fTynjwJNm/eGt/0fVdRE1cquJBgPOg1P/xa/PhdKyI4ENzFejhE0NpqNl0qVRB
         vwI1hqfAJ6ot31Rz6RteStCXAhHPZIv8U8l+l+WaxT3xjepVuOVNMAXaRCTnfBTTRmji
         sjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009494; x=1729614294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXS006kl3x2FfCHKdgorpQBPHYthQinsFnXKbdJpjnM=;
        b=U5gmkNc+0oy1xl95i5rawz6NE0YuDw5Q4g1rYpysH/MtBRmJ8UiwXUd6yByYk9x4JX
         Vaz6/j9fvtZeuZ9ospAt7eNkiE7tXYBt1OnSHbBKCZe85qUg1+UsNuIPOHoM7Knb+1Ia
         Zf1JKdbVPyQt9+JgtfVOTI9b96VUbenJtaUPRKBOTOzPiIRAxMXL9UY2XjkIyagDK0cm
         oCK8HHM+0Zzr9KqaV3RZ4BrZN2g5zsXntKossijR9nSn9ZibKQAX+N+n1hhsyMdtwdV8
         k7eoiMv2iLtptPAgGUmqgeVp60OSiSDd4mblKF148POKf+7WS+jwS1B4Y24SSKwxnyTG
         +yJw==
X-Forwarded-Encrypted: i=1; AJvYcCV/r6AgaiXKLk/la6b94eGltHZ4zhPNk+E8R0nYwOxLXt4U9I1Rr2oKzI/o6aiZoKI2r11gPiRbyCXvQco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR28c3XtdctbANfhXJujpOcN4ft7DeM2zdskipmdbFUOb4YP7k
	S7l9pe649jXKlTc3m8+AhaXf23tMIwxn9jJ7GldlKHAd8KNM4CC2
X-Google-Smtp-Source: AGHT+IFeYsQpBZbe5BmW7p2hC4qXUhN+Iemt1FHPgD/tvdeKyRro8xzQT8H464BizgGfIdyTFWSCJg==
X-Received: by 2002:a17:90a:17e2:b0:2c8:65cf:e820 with SMTP id 98e67ed59e1d1-2e3151b7869mr14867224a91.2.1729009494395;
        Tue, 15 Oct 2024 09:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:eec0:5::d9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b734sm13867975ad.222.2024.10.15.09.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:24:54 -0700 (PDT)
From: Kieran Moy <kfatyuip@gmail.com>
To: shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: [PATCH v2] cpupower: Add Chinese Simplified translation
Date: Wed, 16 Oct 2024 00:23:53 +0800
Message-ID: <20241015162353.6156-1-kfatyuip@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for disturbing, here is patch v2, thanks!

Changes in v2:
 - appplied sugested changes

Signed-off-by: Kieran Moy <kfatyuip@gmail.com>
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


