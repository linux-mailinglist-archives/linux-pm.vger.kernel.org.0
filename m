Return-Path: <linux-pm+bounces-31646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 732CCB16AA0
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E1518C78D5
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553519F101;
	Thu, 31 Jul 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvzORfuq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08EA187FEC
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930898; cv=none; b=h5FzU1qQbwRsxaIVQGrH7vbkTNfNqjBzLKjFEnkAveY+n1rHTnBUz2VLyM2uWpWVMoahxun2EF5OkHCn8hw0Bsvq74fbQ0SDkY99f7Wvkqj884XcMQ9t01plQdU2VFK0YgHq9KGcd54mQX3+P17UBoFCj3JneMZquAEFzAbbCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930898; c=relaxed/simple;
	bh=QdQlM5yMQAEwRneaaxLhcq9g0/bjhiVLJ3LCkWRWd2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wn5rLGxV4+iOMklCy4o38L3QBm6Lja/W29/NomAyQI53/XkwZxfIB1VNcqwoIL7Yw6YtrNJERPttcZO86dDnd4LRH+LiEvP+5im5f8/igLypdpuEFJa9cSrNsMlCp6r877WDO1WziNXxzzQsfhlXLpHCXSfQ6FygNcOdJIVJ+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EvzORfuq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74b54cead6cso296778b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753930896; x=1754535696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WphqwsREfEv0c6rKHtoH+E0qlMlDl7K7sqJR1TqWs4g=;
        b=EvzORfuqEkML2k/kZwd8Pr/3DBSm4z5pNwnvbTGalbEl/Cs3XqLpcGPjLAEBzeAxzv
         Byyf4OSCBvT3DAQI/3N1RPRWU/3QLUsNhWI410DpIPKAkIgfLLSl8HtnRFY1X53j6rcG
         xPPEvIqnlwGOyCjsawAgVGSzrjW8zuXKKuf6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753930896; x=1754535696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WphqwsREfEv0c6rKHtoH+E0qlMlDl7K7sqJR1TqWs4g=;
        b=JuC5oXeLpzBn9vsWEH58FxS+FD8sCcAM3sHX3oq9ZuahQnYpSiNz/hNxk6BeLd/UJ8
         BBNdMmV3KWo1w6qSrp1F1+EwQgSFTCl2ADjjDVyPWrHbfboQUhMXrFUUEcB8aL+srpey
         DTr4sdo8W371cboTlu0Pvye94AbkKT3z/rWwifdIyM4UaeRkRuv89BE9YXBqxBqpcere
         SqN+J9Rno3tmQ578rTdE33u9N6pacelTidvZoV7CrQ6iSPVxewBAiwkHqn46wWCWNGED
         qjFHCb2X1yQMWUdu1GH6Ue74RfJioB71hc2rg1SPCZ4AmZtFPHhKugY1oqXWXXTcJpCY
         suUg==
X-Forwarded-Encrypted: i=1; AJvYcCUQzc0g/M311gcwOZbgoBGPNpGQ6q5/rMRWMzfXMcDmntf8dHI4CE2rSLL0GUChAZjzoaog2gdeyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgq9mJsa0q0NewGjUc4OwdCXBTGo+woU+dwc2JmP4drwK5RZ1o
	z7S2OGYP9MvrVdYy1syZMm1swf6HiF3GtE9VSkmygFAq/w2r0llbclQLWQk8tv3tJQ==
X-Gm-Gg: ASbGncsRUgxLtW168FtOMKrTPhmD7o9otwNl8SD6aR5SD85wvQfKEk57LUJnflUEyDg
	gHCP1pRVTepgo56tN4lJLlo1izS82B4Sm9flL2g8b73rvGIKBBDQJaNvpwqSnIbOgDsuu69dtF3
	h6YjUp3QqWhgUfLEjjoY0WSmTO1YYZPYSKjPOtmzXuKt0Y3+Pju4ioTjB1yCOExLux4CVLMDFic
	bvRhKJ4ViS7udhNDshKBV73V1Wc1tP6vqrA84h8zWTKeRjHsDYU/A+88gfHW4gC/KwOAT0n8X+p
	NpqOxQEEz95XK7c69k84J74b+bOpqNGXNRwdqFmCOu5surB62bC0hP6pzTeoBz9H3kIOq5xnbov
	2P0ixXsxFYzhlDN9N4MFk7/faMWwpn4zA7ba1NN4qZCTWc8M=
X-Google-Smtp-Source: AGHT+IGf1Elb5/v72sFdHsDdA3IITX1NlNAge4BGlFtV8tf2Eu+DVvC9IJvUfXSKnV02Hza0sTy7yQ==
X-Received: by 2002:a05:6a21:32a6:b0:21d:a9d:ba3b with SMTP id adf61e73a8af0-23dc10a54edmr8712455637.39.1753930895774;
        Wed, 30 Jul 2025 20:01:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7ccsm4531435ad.57.2025.07.30.20.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:01:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] PM: dpm: add module param to backtrace all CPUs
Date: Thu, 31 Jul 2025 12:01:08 +0900
Message-ID: <20250731030125.3817484-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dpm_all_cpu_backtrace module parameter which controls
all CPU backtrace dump before DPM panics the system.  This
is expected to help understanding what might have caused
device timeout.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/base/power/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index dbf5456cd891..23abad9f039f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -34,6 +34,7 @@
 #include <linux/cpufreq.h>
 #include <linux/devfreq.h>
 #include <linux/timer.h>
+#include <linux/nmi.h>
 
 #include "../base.h"
 #include "power.h"
@@ -517,6 +518,9 @@ struct dpm_watchdog {
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
 	struct dpm_watchdog wd
 
+static bool __read_mostly dpm_all_cpu_backtrace;
+module_param(dpm_all_cpu_backtrace, bool, 0644);
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @t: The timer that PM watchdog depends on.
@@ -532,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	unsigned int time_left;
 
 	if (wd->fatal) {
+		unsigned int this_cpu = smp_processor_id();
+
 		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
 		show_stack(wd->tsk, NULL, KERN_EMERG);
+		if (dpm_all_cpu_backtrace)
+			trigger_allbutcpu_cpu_backtrace(this_cpu);
 		panic("%s %s: unrecoverable failure\n",
 			dev_driver_string(wd->dev), dev_name(wd->dev));
 	}
-- 
2.50.1.565.gc32cd1483b-goog


