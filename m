Return-Path: <linux-pm+bounces-20162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A49A081E5
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 22:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6720C188CA17
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472A1FCF68;
	Thu,  9 Jan 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pw6iE+zE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619E1FCFF5
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456477; cv=none; b=iGNMGfnDlHUNZffYk/SX4UK0ErmOelulxfAtR4hCeFrLoEXPPBHi/MvmT7wrUzL2sYLIbVz++vOyDlzKT67wA6hKwg+tCt+1T6lkgRb7BBs5w1PuJJctV1koMl4vD9kXtJw3NL+xcZRm4ToPCYrn3C90k82iXmMAwbsrY+8gzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456477; c=relaxed/simple;
	bh=Jhy8nReLTFgKywbASQ+2hQf0BlhFkyZ2YcvMV/yNA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKLJiLtvPE0hW2U32ajugJ3f7nfhtVhrvnx5LBnpanjbgxVpkEts92W10qRc8BD3Vm8A/d5Imm0ik7IuegAJhUJWLmvX4qJba6ymyP7orG/pqeahNHgYyRumXRZT3ZxLZKNJ9YfmaZY+I2LRj3VofTlBh7r9ZCkNJdGIM87X/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pw6iE+zE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21649a7bcdcso21778815ad.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 13:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736456475; x=1737061275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSzfS1hDLLpKmdo2uvTyrYDLllGYGguN1Mm+AUu6f2U=;
        b=Pw6iE+zEkIm/W5Un7maTNkokucrBFvlVSsXfaWs41R+NIgau1lVX0x74ZyHOuTGMAE
         LgI01J4tZy2DrArRkxzVyq4ZUNmza5vqxlSKdVeRzi+uJd5xvWXZ9TC6SMFkD+9wcdel
         NsQoVHtaHOaZb0T8m1tju5vFTvcjmSUMTkiUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456475; x=1737061275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSzfS1hDLLpKmdo2uvTyrYDLllGYGguN1Mm+AUu6f2U=;
        b=cor75/k9NRR/1WkAiEYKQJekN6q3co+VhwMnJIp31L0vyRiAx4jhGlcVfkP4kkLqyc
         8H7iEtDxwfE6+RfwK2liaBIpioQWODpgCSTdGyW8mu3ErOSLIomG8SbOwMdXxIHbYUzs
         glKObkpncJ8DDCWtiWdtE5Di4qxCMlI2OVbrQDIqQVdFB1hexS9FlJZbTOKHdT9ni0B7
         pITvNdFgMDLpnZVY6rCJHrHJJoRi0nOO1HmeNPMPFx7Jyh79f26fgrg6WJ9E0bqlNVrE
         l+tegWp7Lu7oOz8Mengx751tZaN+spkNupVAc3mtfnp1ubOygaE0V/qpz3VhMy5F3jwa
         wStw==
X-Forwarded-Encrypted: i=1; AJvYcCXAEXLR8dtVlB2ldsX/gPwkynxoQ58U0pBX88b18iwotKJgjnMamUDe3ZsGzGbaLAI9A8SNVbXTGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9kiRaV+l9++CXiShupOEE86fk0AHLpIAT8WcWzxU6JlKHQY5T
	OaZVsgclf7wxUtY2PZKBulRV6yC3pZr50gNEfylSaHONN08ADEDwHZzktNbstQ==
X-Gm-Gg: ASbGncus2QR8oZd3coemVtAjQiCdXSvWfA6cMpiyXiWKtUcPVOaI6ymLMmt2To1tPBG
	dLHJxuNrEEmmEuUUjVIoHo338i8F8ggfxbb6EKUH4Y+IommraF34a+4gM/+CSPfoOOk8DvQUCgm
	V0d3i4mpJHdyUiqHsyFqU8djOafBwaeyMbCxCPZa12hxkd8mSA0bXINyv3kShyk+wqrxt7DBZKq
	h7855Onw+A/V0AjwRL0lxoxgKqR89D0QG2BR7nqy3bJlAdQtzIlMBYDO5WpIR5z/duz0Ylbn4rb
X-Google-Smtp-Source: AGHT+IHtlbXKB8nQGV8Na+mbl+3fLCXplg925dK4lhdkih8JRZ1GimXiwwWjEtm2kYaEdd76Ln3JJQ==
X-Received: by 2002:a05:6a00:190c:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-72d21f304d1mr12928976b3a.3.1736456475072;
        Thu, 09 Jan 2025 13:01:15 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:52e9:9ded:c8d2:20ba])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405493d4sm237565b3a.1.2025.01.09.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 13:01:14 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] PM / core: Allow configuring the DPM watchdog to warn earlier than panic
Date: Thu,  9 Jan 2025 12:59:58 -0800
Message-ID: <20250109125957.v2.1.I4554f931b8da97948f308ecc651b124338ee9603@changeid>
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow configuring the DPM watchdog to warn about slow suspend/resume
functions without causing a system panic(). This allows you to set the
DPM_WATCHDOG_WARNING_TIMEOUT to something like 5 or 10 seconds to get
warnings about slow suspend/resume functions that eventually succeed.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Print the warning at warn level, not emergency level.
- Add help text to DPM_WATCHDOG_WARNING_TIMEOUT.

 drivers/base/power/main.c | 24 +++++++++++++++++++-----
 kernel/power/Kconfig      | 21 ++++++++++++++++++++-
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..7d60610437a4 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -496,6 +496,7 @@ struct dpm_watchdog {
 	struct device		*dev;
 	struct task_struct	*tsk;
 	struct timer_list	timer;
+	bool			fatal;
 };
 
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
@@ -512,11 +513,23 @@ struct dpm_watchdog {
 static void dpm_watchdog_handler(struct timer_list *t)
 {
 	struct dpm_watchdog *wd = from_timer(wd, t, timer);
+	struct timer_list *timer = &wd->timer;
+	unsigned int time_left;
+
+	if (wd->fatal) {
+		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
+		show_stack(wd->tsk, NULL, KERN_EMERG);
+		panic("%s %s: unrecoverable failure\n",
+			dev_driver_string(wd->dev), dev_name(wd->dev));
+	}
+
+	time_left = CONFIG_DPM_WATCHDOG_TIMEOUT - CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
+	dev_warn(wd->dev, "**** DPM device timeout after %u seconds; %u seconds until panic ****\n",
+		 CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT, time_left);
+	show_stack(wd->tsk, NULL, KERN_WARNING);
 
-	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
-	show_stack(wd->tsk, NULL, KERN_EMERG);
-	panic("%s %s: unrecoverable failure\n",
-		dev_driver_string(wd->dev), dev_name(wd->dev));
+	wd->fatal = true;
+	mod_timer(timer, jiffies + HZ * time_left);
 }
 
 /**
@@ -530,10 +543,11 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
 
 	wd->dev = dev;
 	wd->tsk = current;
+	wd->fatal = CONFIG_DPM_WATCHDOG_TIMEOUT == CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
 
 	timer_setup_on_stack(timer, dpm_watchdog_handler, 0);
 	/* use same timeout value for both suspend and resume */
-	timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
+	timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
 	add_timer(timer);
 }
 
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index afce8130d8b9..ca947ed32e3d 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -257,11 +257,30 @@ config DPM_WATCHDOG
 	  boot session.
 
 config DPM_WATCHDOG_TIMEOUT
-	int "Watchdog timeout in seconds"
+	int "Watchdog timeout to panic in seconds"
 	range 1 120
 	default 120
 	depends on DPM_WATCHDOG
 
+config DPM_WATCHDOG_WARNING_TIMEOUT
+	int "Watchdog timeout to warn in seconds"
+	range 1 DPM_WATCHDOG_TIMEOUT
+	default DPM_WATCHDOG_TIMEOUT
+	depends on DPM_WATCHDOG
+	help
+	  If the DPM watchdog warning timeout and main timeout are
+	  different then a non-fatal warning (with a stack trace of
+	  the stuck suspend routine) will be printed when the warning
+	  timeout expires. If the suspend routine gets un-stuck
+	  before the main timeout expires then no other action is
+	  taken. If the routine continues to be stuck and the main
+	  timeout expires then an emergency-level message and stack
+	  trace will be printed and the system will panic.
+
+	  If the warning timeout is equal to the main timeout (the
+	  default) then the warning will never happen and the system
+	  will jump straight to panic when the main timeout expires.
+
 config PM_TRACE
 	bool
 	help
-- 
2.47.1.688.g23fc6f90ad-goog


