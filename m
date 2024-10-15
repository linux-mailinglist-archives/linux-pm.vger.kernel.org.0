Return-Path: <linux-pm+bounces-15667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46299F2C5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 18:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C042830F8
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E471DD0E6;
	Tue, 15 Oct 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoF/VWt9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78B158DB9;
	Tue, 15 Oct 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010012; cv=none; b=pwKy2VMF8BI8saqtMj8pstFbZCJNc0QGFru9qBSsaCKJXyEa/syHj/Gf//qThch1k17fc02lt6h9i1EAlV8SLjOmPPm2SStH20dLgwM98VJNPtNaLtRIU6Ir3P7PxhY1lP1NY/bdnKB1ApfoROOmcZrG3hmLx8WuYCRtccsXHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010012; c=relaxed/simple;
	bh=xfI79rRGcda0a66L5yluw3psyRMrTfQn6bvg/mdHebM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p9ml+jb10LYbn8izAl1XdPMjUsuj4EH4M5ra9suqasEG+28/LDz/jkRX+bdnUvsk5FMcGzz21w7jaHxJGj08rOZAA1+3oPOEz24lzroj9WesxYZtNXeSBFtQzNXozcN2wcKkj5RPSe5OpldWDRySwM/OlbKguEcgOCbieJ5BlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoF/VWt9; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20c803787abso216485ad.0;
        Tue, 15 Oct 2024 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729010010; x=1729614810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXS006kl3x2FfCHKdgorpQBPHYthQinsFnXKbdJpjnM=;
        b=DoF/VWt9sJ7vKCxisx2bjXBXcWagWeGDUPRWF3CMyWe1dRoI/qRLATFZ6Z5UjImVne
         nqIpy56I1bbMLalGQKR+GTyn98MA1RafxK23IDklaJN0yYtNuSrFQSCqGOFt/12sv1Ps
         AW7hJuYdUrEAZ9VGVAi9W6F5Bu/2lzgI4N1FZ0kQvd/FVrAkG9BFjd8g0Oh/U4JI3+h0
         4QpMc2dGhXiMmvzWaQb71YGkBhhObh1NfSVGq80vMtv6ydXTQnoQAZnM+yDDSgSz9l2f
         RwBa7DnSCk6EisisV9VMFpkBxiAvfCZJ2O8dYFkFloA/OE5maIs2sdGyVaqD4+XoRQZY
         /y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729010010; x=1729614810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXS006kl3x2FfCHKdgorpQBPHYthQinsFnXKbdJpjnM=;
        b=cxZfLetMYCSJarDCpNtyCA1/rhHh9xIZ1S8+cB6JfBuZaX+y/wxn8/FierOLai4vwY
         HbTEWiP5QIlNv43qW2AKU5gUHvryqoW/1MIWCaRl0bnuthY7Se7zyI+2NQeNwOjrbZme
         TFS7rOgUCr0ZCnyEUxSWKWBNNZBoGJj0BRmZjwW111RHAwoIqBLLFZaLcuJRpz4yOyS8
         sPK/PbDiB9lHG+YUDn/+fInk5PNju0ShYksxXtOn2J3/w/PB0o3z5kg4gGGZ+rLrltcQ
         DTtEyHdCw4S2ZdbWS3vADWC7oy8uk3wywY5IGejCOscRr+VulqurrdFSamCq714M5CAh
         NhvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXW57INXo+AdLIGohBoZCLJUPayRZbchsin5qiIpY6tRxxouL68ASAmU5LId84C4x7lCwDk2rWpn9vScg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtIkodRRAqh5zwJUMlgyntQTOtmKtctcnMpCK8Re4OQdF3Ve5
	YzWvJA2HJRWHmwDeOMcJxZl5Ioo96dEDUwtgz+5MagcAOh2tyx+zEA6cuMmWig1uEg==
X-Google-Smtp-Source: AGHT+IEwSPeJhQ2rLmXfTF1o0rxMiMgqmoPx5dLLtCtqVAxq5kz7Qd1SE2jHoZhngIpgdJyHf0DRWQ==
X-Received: by 2002:a17:902:f545:b0:20b:8bd0:738a with SMTP id d9443c01a7336-20d270580acmr15673225ad.20.1729010009810;
        Tue, 15 Oct 2024 09:33:29 -0700 (PDT)
Received: from localhost.localdomain ([180.119.112.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c706129sm1553753a12.67.2024.10.15.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:33:29 -0700 (PDT)
From: Kieran Moy <kfatyuip@gmail.com>
To: shuah@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: [PATCH v2] cpupower: Add Chinese Simplified translation
Date: Wed, 16 Oct 2024 00:33:18 +0800
Message-ID: <20241015163319.9114-1-kfatyuip@gmail.com>
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


