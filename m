Return-Path: <linux-pm+bounces-31306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42351B0E963
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 06:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A227A9384
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 03:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5252E36F0;
	Wed, 23 Jul 2025 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHRkDVzN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06572214A94
	for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2025 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243207; cv=none; b=RtAGsgeDHtjTgH3xMZdNbBzEkWPjjdo2y0MKN6BIbyu9mqb78WmrnwfrPqZ3AVG8/bcARubMNM6KW5xj8F/48dYfv3NpC6QgEdmHIQzE1HoELLy8v2nMDHijxzGH8sHlqCxQqx0nIA3qu7tz1yYfF3ISPu28nIs1xC6QBzaiROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243207; c=relaxed/simple;
	bh=hg5ud6emYgmoK5RBRutraaTajbsQ45n0nXZERgtt2A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgenFXeXuBIgjbgOsIhDwe5Ny8U1mwwwpQx77lXXevy+0UtrzqBvivJ/iqUIAJ8TFPq6Qb8PVUOWcTD14EwHGJHFolFmyH+siRREzPcGz2Ky9IVxEvdZ2N12ER/CDfR4hhxEaa7FS1LyVApYOXlXYSInesqHZWrhWsh71qc+Tko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WHRkDVzN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso5248752a91.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 21:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753243205; x=1753848005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q1k3jv3HqfKIyxYBUIJcZUhZRCNRS0iqmlesPw3pT8=;
        b=WHRkDVzNCzM0pFx5XTrLLpsopXxJLWXC6Q1jeza6VmyuuxwwaszYKh9DbgqdwFzRQn
         GiMphPoRnKu8BU63orXtYwOkb+NG1Pn1f/IF6LCVr4x4Z3zr2RPZW5iE/lXjG5vUr4BN
         q/ylh4mSaA80Pq/KVlwfiMbH1RgIFEQu7tBsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753243205; x=1753848005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Q1k3jv3HqfKIyxYBUIJcZUhZRCNRS0iqmlesPw3pT8=;
        b=reytuu5VEDNuIv7JrjQFyNM8hsULZKLqz6ja7FnJmQoMg7dwSyyj59rigrg2Ey+LOl
         CdCXWBl82N5wDTKDZFKRXTnJkZqNrIENKH6wjXpVD9iS4meRO8qn+eHL/r2oqDG2Rwy9
         QzP6FMY1qCpKJq8JQHVCMCDbtKi8mTA47rDN0LXmjCzD4S5HK2R3scm6wrFw9+R4oAtc
         tBTTPou/bKlpR4GLsapxS00N1cBKHeXxY8GdYzCnav6iIpY6PXOsyg6V3z4N2NiTMGya
         LvE8Q7E7+ngdH8ijae9HGxNHVSNR+ZlOaRsca+2iZHOZerNOOj9m7QuIOweVTeBZ2n21
         5rNw==
X-Forwarded-Encrypted: i=1; AJvYcCXpE++ey52wdT2qhvpl7qVQHtvRk4CuTA4mQkdpiPlB2ZO4ifkk8MFsBLHAXYtcv+AUy2mD61CwYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLtSLKik5Ox76WMXs5eZU57dmTzznlckY4WBQFkB0HLDNuKdJ
	oTvTTFvMhMTp51seQTWtnYA6VL8+YCgWRUcgnE0zdNe9DtD4kB4602X6KW1z8ewKxQ==
X-Gm-Gg: ASbGncsAMsFt1Y3uwWOel3KRajoewlHP9E8c00iASMQMnHSWBhTTv+mWyWlnoTycgaI
	m/xjbOnqh1jOvKiifJlyIzOzQFYwXlM/y38qzpI+fx5V5y5edolL5wwQD4XJOIFLBcZrgQ05qlp
	X/hrhMwyLrDgdkveGLP43hT/c7p6FOWLBQAzPInafCHH1thKE0WQQPy/PmsoeCrbtNo+kzWg9MX
	cmYrRBjQ5dR9Ikeu06J4fGDfv7p2jd+iHceEHNWP+vSniE+rma3vy3g5c3SVK0GLWWXOy9xSekm
	olGOIB117Pxi/JvSUdQuXTfEq7oQpQlxMQ02XYJkjYOVQtx1DLxPbe/AB3RHbvI+D/ExIr9oNZu
	P/3HiDukHI7gR2PmoP1QBtmUOdUgBJylc9AeSkA7xt0FAO7DHlKvbMGauCVo=
X-Google-Smtp-Source: AGHT+IEH9eMZc6hbX2Xrl+JGcJWKA5qC6jOj++iObkwiTrt7IqrXEtcvBb/9AVmmw2w+4cnjnKAdyw==
X-Received: by 2002:a17:90b:5845:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31e50817303mr2488633a91.18.1753243205187;
        Tue, 22 Jul 2025 21:00:05 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:fad8:2894:2c8d:4d33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e51a2bc1bsm527225a91.37.2025.07.22.21.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:00:04 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] PM: dpm: add module param to backtrace all CPUs
Date: Wed, 23 Jul 2025 12:59:09 +0900
Message-ID: <20250723035955.486688-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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
index dbf5456cd891..9fb943afe246 100644
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
+			trigger_single_cpu_backtrace(this_cpu);
 		panic("%s %s: unrecoverable failure\n",
 			dev_driver_string(wd->dev), dev_name(wd->dev));
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog


