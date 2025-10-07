Return-Path: <linux-pm+bounces-35764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13BBC059C
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 08:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A7C188FF75
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 06:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436B225791;
	Tue,  7 Oct 2025 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PqDoZN3I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB222424C
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759818966; cv=none; b=n0+WjJCHOEfjwrmiPdftIgP6AWA8I++sLyORal4ixKYrDtMnOEfdizmybyNFoDK/N1PYZ68ZFa6l23sd5O8fAk2e2Sr9GHJI2R6mvdS7TpBlqI54Wv5+pji1TufvP9Znl7awS1+VdB7zq21raBzhl7eCHjRPZ8ZWV9iXmyMDkr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759818966; c=relaxed/simple;
	bh=uAmhgQ3KcHHqItUYD3sg9xQu/w0vMlXFEkJv6A8Zca0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWL9+xPXbNZeEAKrZf8kuzeGWjA2FZaALGXVxJi6m8co3jXmK4k6Zn+P3AsE96+iBXiVt4JaPnLzh7fD2o2KOnPHhmWm5nfOMTwnNC3N31qQQzNQ+LdsQZVpdz9/TQ/AtF4zldF2v24l0EkK91X6sXr6f8W+P8yBZz/3+sxAwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PqDoZN3I; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d3540a43fso61255255ad.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759818963; x=1760423763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ubg0Ay//TT+HCi0Uhp5LLbc5vBMN2YTOmzPGYDLqqyQ=;
        b=PqDoZN3IDgO9VvaXrLCG+jkb4uRxVeuMkcN3Wn1FJJnTP9jwbqg1KSlcAxEOOPe19c
         heIctDefINfeCOhBxOIor/xshu+lyjwzsZPTVI/ixlf5cS+FKhEUZaqUgDuewdARZUFy
         Lk16oxqzXy9NuVp7ytXQ6i0Cytm789xF6hWYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759818963; x=1760423763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ubg0Ay//TT+HCi0Uhp5LLbc5vBMN2YTOmzPGYDLqqyQ=;
        b=jHhXuFdPAFtAIRUEPnPiRkhXw/op/eJ/d0tSTC8B2r4iaEDo4mWbo3Iu8t7fLQQbaK
         KM2CPyDd7+xbxoHxhREzq/l2F+4dJ03wog83pytjWXqb/MPyKN29ggezrDqCQSO4xwDk
         LVuW+S2b6v7BkwuDswnGxCEfvXYyunY0/OjMsSTowiSX5I2SJILbKleDkb5fdci9YrPZ
         3jQF6TVrUmZHeN2jNHApOF8KfP6LPlxv4D9nZLbf9c11ssJUUhNjlvZv5xgWm30wMRfd
         AM7R8aT4299jyMfPq+7LP2/oaZUGj0g9tjz+v9Gbv2Jo5vM74niJv7/FxXbYW81q0vQA
         H3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUPRjP4oBPfcj+nUw46YvP9GOO/wmudTtC2KXB4WK1KKXsuXMiMQ193fkkdL8cnHcB9ubFXJatxXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3e7HX3uCzzK8OSfXg/tU+VZ7mADKRn8HwCU1AhAb7+iY1O5+
	f7ENn3zBglr12zk9IFAs3HEVsSe7siy8WBnrPzwZDW5K3TnIeDJep3xCKXGwe8Q/HA==
X-Gm-Gg: ASbGncvrHqjMxypnYUuprC4UIQWakCWxtSDjF+z+VXGmbKxaOLnzC3HGSXoLVUKtpSm
	sYcSpv/HdYhaTiSsSYzXHV01c7TsQdFQYq7OCjpaB3Bn6t9crn9Te01ZDxCyKsWVCxG/UmDuVE8
	4FrVpSvXjpOWG4RjShtcCBRYnYUxt4iB5L6TY1LTXEnIE7yVXVa9wn6GV6ksHoNwFqQ+X9mHjKs
	vZXIA/6DQU3HKe51fxgzftlnOWgvxnkQ70z7q0Bfmxn/EMOPkSjURsFn1O7Rub9LYkLCRpdcxB+
	ifiYkWNeUyOlypQ5bqs0aAxkIZ/65L2n3dqLv9C9XOoYe0FDUIloddBSM2HpIYhCuEI//far03x
	vVJTgnDjGJjRunzm3xnBk3k3Zl8sRAt+v7jcytByGZx71K9MjB5g7KxeKLUgjBSJ966nxDOLx
X-Google-Smtp-Source: AGHT+IHvsjv1a9nNOfsdkOgaNDaeaTcF+IkFphTj0pje34rtST+ioTAIoakbqOW00hKZRXsG5OCW2A==
X-Received: by 2002:a17:902:c407:b0:27c:a35a:1321 with SMTP id d9443c01a7336-28e9a66446amr176001465ad.51.1759818962726;
        Mon, 06 Oct 2025 23:36:02 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:51c1:81ab:3622:439f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d11080csm153402495ad.1.2025.10.06.23.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 23:36:02 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
Date: Tue,  7 Oct 2025 15:35:40 +0900
Message-ID: <20251007063551.3147937-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dpm_watchdog_all_cpu_backtrace module parameter which
controls all CPU backtrace dump before DPM panics the system.
This is expected to help understanding what might have caused
device timeout.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/base/power/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e83503bdc1fd..7a8807ec9a5d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -34,6 +34,7 @@
 #include <linux/cpufreq.h>
 #include <linux/devfreq.h>
 #include <linux/timer.h>
+#include <linux/nmi.h>
 
 #include "../base.h"
 #include "power.h"
@@ -515,6 +516,11 @@ struct dpm_watchdog {
 #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
 	struct dpm_watchdog wd
 
+static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
+module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
+MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
+		 "Backtrace all CPUs on DPM watchdog timeout");
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @t: The timer that PM watchdog depends on.
@@ -530,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *t)
 	unsigned int time_left;
 
 	if (wd->fatal) {
+		unsigned int this_cpu = smp_processor_id();
+
 		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
 		show_stack(wd->tsk, NULL, KERN_EMERG);
+		if (dpm_watchdog_all_cpu_backtrace)
+			trigger_allbutcpu_cpu_backtrace(this_cpu);
 		panic("%s %s: unrecoverable failure\n",
 			dev_driver_string(wd->dev), dev_name(wd->dev));
 	}
-- 
2.51.0.618.g983fd99d29-goog


