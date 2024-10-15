Return-Path: <linux-pm+bounces-15664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D999F2A1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EAC1F22789
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DC11F666F;
	Tue, 15 Oct 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4lEanTg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B831EBA09;
	Tue, 15 Oct 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009435; cv=none; b=is2sXQia9zTtEgyKHOhXTqK2YwNF2u1lWFPQlbKKvp+xefNrfmjb/stM9LRpRHk6WueJAOzAW07rnmZS/KH8liWXX7mKFtTrwx2G9E4uBdEbWE9P6i+8aG4drUNNHJpSM5u33gtJf41IGHqR0SdoehFNarx+3R6OT8fS13OLoMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009435; c=relaxed/simple;
	bh=xfI79rRGcda0a66L5yluw3psyRMrTfQn6bvg/mdHebM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eBwG9a1zu5arA8n8fZ9CfGzYEVqEO5UkaDhl0qpdJ/Z4ehsr8zge2QB9csXYEfWmqkKBQ18u/8/dk5ZvDcl1yH/0rs8ycatr7/wbua6YD7mH8KK4gDCJxE7Q3nf3M07dL3PrhgQTGZ/1+NtiSKnRrgMT+4zLlduhSoadzujFjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4lEanTg; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so3380172a12.3;
        Tue, 15 Oct 2024 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729009433; x=1729614233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXS006kl3x2FfCHKdgorpQBPHYthQinsFnXKbdJpjnM=;
        b=f4lEanTg60DzuXrpsgxriPHOelWYNgmV5ji2p9GnB6Ajbvd6/1IKxG/C4uBz7BQdkX
         SkklF8tknkp93Ah0Jd5rzMBhq+iSux5eT7doPAzuAXM7V7IDKf02XJ5bRnovW390gqJS
         KOULb6zOrFRAOkeXQz0+fj1b+adi6UXVSW12O5UaH7M5c8utBcfvxNKN9ooUqYjOsmBZ
         x2fvs2yejLsA8RPlr26j/TyWDH6l1mSzzk+t0m8+Wx3UagS35LkgjoRflTsSitCmrdjK
         /Pmau2jCWyVBeVTDBFSwTF68jVyRRmVI3pd9pjyhj/a3zEf5vTwjNS0IlwfFgzi1ChmG
         RxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009433; x=1729614233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXS006kl3x2FfCHKdgorpQBPHYthQinsFnXKbdJpjnM=;
        b=wEVRJQW3qn7BqgMm8oG14G6nHNtIBUB0G/PaqHDZaHnHc4PExnvFqsk7icimtRZ0SO
         C1g7qdrspoH9D9sOkFGX+853c2HNkrKm5BS3Uj52uI0hS611YzVITM3nvR73xL57JpMX
         uAkeNNxLyIhf3t9gM1z0eShIsddktxJKyVseMa82b82dJjmkXOCvLgbni4uOerGf9EVj
         wK+t7V9wcNJWGU+su73t8k7+C6+Z0o31OYUK0d6slTnP3X3GW0EHhZEPToiDka2EfR+i
         IQ0sXWpEHmpPZ12GzQQWHffGWQjV0KQAnbq+m9ui9DHbA/kSGsmRgwx3O8BmOakr9GJL
         /oLw==
X-Forwarded-Encrypted: i=1; AJvYcCVOo1xQbWsFIuOyWBkLrSY0nF6i6rdV891jfijhHUabMK3YVFGlR8NHPgQEbexGXlzYaMek8RUFaT3g55A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdyD5RDWxItXK7FOT4BwvyM9OFrfgYqdcwpa2XW117L0tjeXk
	9M8+KDu4C42Grgh8mKHfvH8plL+KpwiZjVx6Bh+Cbx08xbTHfef95pcxLMwH++LaRbmq
X-Google-Smtp-Source: AGHT+IE2yg788nvnUHje5q0Qb1Tzqf4E8HD9Ems2n+An7mh6sQu+rtD60/b3phN9F9yLcfbbd6la/g==
X-Received: by 2002:a05:6a20:d49a:b0:1cf:9a86:6cb7 with SMTP id adf61e73a8af0-1d905efd2demr1105216637.20.1729009432764;
        Tue, 15 Oct 2024 09:23:52 -0700 (PDT)
Received: from localhost.localdomain ([2400:bea0:1ae4:f366:689:bf44:c495:13b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a29e0sm1455591b3a.126.2024.10.15.09.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:23:52 -0700 (PDT)
From: Kieran Moy <kfatyuip@gmail.com>
To: shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: [PATCH v2] cpupower: Add Chinese Simplified translation
Date: Wed, 16 Oct 2024 00:23:16 +0800
Message-ID: <20241015162317.6021-1-kfatyuip@gmail.com>
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


