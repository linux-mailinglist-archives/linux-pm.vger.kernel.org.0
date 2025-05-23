Return-Path: <linux-pm+bounces-27546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB18EAC1D96
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 09:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2159505A6D
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618421CA0F;
	Fri, 23 May 2025 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhh5505D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2321C9E5
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747984966; cv=none; b=ioOi9A0WuaBirdPMRDgL9aRx4lqBZGEMi/SUtgW5w5BUDbi/rHnbBFYsFzUJLp9uRL8hxO/Qldd25j5rsfntqdwfBSiKb97SG68X/rd7dFN08+q6rx1Yk8TVs5koXSlWpPUcjDt5H5CAcLnTGUyUsjIVfy1Ukt367qzQzIc7mNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747984966; c=relaxed/simple;
	bh=49g2FZ21zuwIhaesT481VqF2uEX8nghApMazxmjpb88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1qP8HpEqJnGN2pk4Qp+hcWQNY16Gxis/AIRNMqeJvvimgbKr3GAJW9arEw6Abb1z6oKAMWEEf4Ml7lF+35BzVjtFIUJrASikEeMaAPQ70nO4+6IUDYo1zvvDFWuEimC6q//DHoXYsTDBJpPV/ao0yqp1Dq4pMO1zFbwUzF9VS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhh5505D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e033a3a07so87595265ad.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747984964; x=1748589764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFGz37yb/vFtNyhKsExs1CU40MeNUYSl1aAv3NqX/YY=;
        b=bhh5505DUQyDfstBX44drDwvsYXX6dDgsdMbVQxQvtwJgimGQ6qRuw5jZaPPt7wFqK
         a9djae76zhy7/Hf6OypvWoO7gGJke0UR/iqAqM+lDuQhnAiGuBhbLBnm1hufVTLztHLC
         F9MrhGQRthou8V+IhiuzpGSLHSb0J3idnORTkYwSKtkn92G2c76YspJzY0UBQ1P9Hjww
         2LKyP2M/nUxbYgByRTFf9V9pKxvCrn7hoFJEZ0NdV07WWQCXRvnPbzvwoETicPnuVaiv
         NHU6IGOscO8+SaNS1P5ee4Q0Qu0iTgIj/KwXiM4V9BI9dxXg/ejh5dMthIIOCRjAjMjn
         fbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747984964; x=1748589764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFGz37yb/vFtNyhKsExs1CU40MeNUYSl1aAv3NqX/YY=;
        b=Qm0pPcY/SgJ7V89GNqpveqQXWJHXyEhV9zrpA3UNBeBAml2e8NavQIXwyHwUWHfHPb
         j1KvMZXrXdrxEiwaic4/WPJ3VdB0WLIQz5YCGOLIpoI/llrFbmqWMFCzACNwkgZnkh1O
         5g7kEGbatirtKKoWUWMiI0Y1jrDDUsQhaZ63ivjF851UbK1WpdM4HYk7Ir7nZEGVLSVG
         vC+Bty+86s7kmOhT3EOwNO2MVCbU8vo3eZecm4KKgDBysD/V1JZ69g/Ojhy6j3zpmVET
         SWxRDYdk8zkBI7DX6tUUntR0nQ3qRR/vHwqCQm30Fwt3/UY+ksaxNMtEIrDmFD9+wrGM
         e+iQ==
X-Gm-Message-State: AOJu0YwDxfDouZgBbYxcHtyauVNa9PgV5aBgaucWAY+qRPlPiZTJH4CN
	ZlXJNhK+y6+O1RzE8XHVMhvX0khqPDxuES4uxB0MKXlL6r3/1TYIMcvE
X-Gm-Gg: ASbGncux0fXZjJfjKiLGEZ9vBbiDi5xNjhzfHzpmK8J9PuEILHQvDA2LIyZsfCIcuAh
	0r9GkCxHsHwWXLXHX9dKC6jVtg5boh+E2waEFf+IV6f4tWmHCQCJKHfDTDL3H/gGB8xipd+Nw2w
	2jZm7QJYduGs/COlDT6ShOifxvxGt1SBiza98WesHP5Xm+DmaHx0CF2z42kUXl4UkS4k10RZqy9
	OKIJSTs4CRFAQ2booe5JXvIEK6BRuXafEyNcbD6byxfNjrgLvsh9Ggkbhh92WS1of9O4e7csBwW
	sClVU3kOuMp4v2o8EmTXLeKcTaSW0KZSR/gjoqqiZqzJ0SQcWjPJStTYgwcq
X-Google-Smtp-Source: AGHT+IFdoP36JQaFZ5dKJXmYC3/49t6HL3RB4rilhfzbUZBbQXRIqANWHyANFncoUvoj1eOF+4W0UA==
X-Received: by 2002:a17:902:f806:b0:231:faf5:c1bf with SMTP id d9443c01a7336-231faf5c3a1mr243618995ad.3.1747984964068;
        Fri, 23 May 2025 00:22:44 -0700 (PDT)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm118722575ad.147.2025.05.23.00.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 00:22:43 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [PATCH v2] cpuidle: add tracepoint for s2idle flow
Date: Fri, 23 May 2025 15:22:39 +0800
Message-Id: <20250523072239.181371-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tracepoint cpu_idle in enter_s2idle_proper() for tracing
the s2idle enter and exit events with a determined idle state.

Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>

Changes in v2:
- fix the build warning reported by kernel test robot in v1:
https://lore.kernel.org/all/20250520030922.9505-1-qiwu.chen@transsion.com/
---
 drivers/cpuidle/cpuidle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..9dca6a63e4ad 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -149,6 +149,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 
 	instrumentation_begin();
 
+	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock_noinstr());
 
 	tick_freeze();
@@ -174,6 +175,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 	start_critical_timings();
 
 	time_end = ns_to_ktime(local_clock_noinstr());
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
 	dev->states_usage[index].s2idle_time += ktime_us_delta(time_end, time_start);
 	dev->states_usage[index].s2idle_usage++;
-- 
2.25.1


