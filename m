Return-Path: <linux-pm+bounces-19434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5859F6CBB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D991889624
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02F1FA173;
	Wed, 18 Dec 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkKXDnUk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3421F9A81
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544616; cv=none; b=TncpPF5GGEoUO2e0/0ulhD86/8/aCSceEwP25a/IBhpR1gn/PgPw2P51PRzpNCZSj5BdA0juqYp+Bm99e7JqPimBw9/fzoOciEyCKlWcTiVNZ23GWRxMNJfcnbDepxUdQMDeAd/YW/SO4gTCg9HtUOjvf/5oMxfGQnDkR+fLlyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544616; c=relaxed/simple;
	bh=5NFfw/1FBWOJQrGX3rnXWm1ujFs1pBWnrqytI+C47Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXs2bD1gNQ1JS2zp2sVqMMInAHffFAxL0md9cL4AjO/tXuQXCvWOieRkiqBlRVv3xQvmzmsPgCNBl98VLIA1nJtjIdTf7Jo6IWvwxSFUqjetbxg1MIBx73B5lUvvK3hFqzzdCeLj8epKppQiLveYaJGVMef8fKF78ub2Pc1UWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XkKXDnUk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21636268e43so83042005ad.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734544614; x=1735149414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DypSxFOZrcltTmUlVfCu971X+fsVcLRAvGohZhiEeA8=;
        b=XkKXDnUkcTvjWmLXPc15KvMqMaAa736zl7+y1Zfq8q0ttkPxR4i+uVn39hJZt6X5iw
         zk2X2tZ2yCwvot5VOh90aLc6b33tZINQNrPCfY+idW9x2NFxqvZHuIml3gV4J0zdDpz5
         UH5MwLP/u6JCKfHP9o6z/eL+PZJV6tNyxPbMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544614; x=1735149414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DypSxFOZrcltTmUlVfCu971X+fsVcLRAvGohZhiEeA8=;
        b=v2MQiac/X++ZrcR9nlpa60P/5WEXordbEOxBa3piGetXkFUY4t/DNEcK3w40ThKBKT
         wzkF4dPwJT/DiBeyadYikPTepwiGX1+VC0tGc74B+PV2lODz1WYN/8k+9QiUKiOmKxkN
         7ETxFZIWhEnPOWCgPbL6lP+lo57kcT6gvQj+dSFXORfYewD0S7SV+6TIJ78rYIIb1oYK
         Jc7rGX61Apv3chLRZFUzjY5mEgOHYBfTlJ8ROdmlrjJ5s4LxSpwEBlWiQOa99lSu5xr2
         3lsTj2hVOqScq7PTqIE/lNu/yi+4tC/K9gMrqy5otcqU37lwgKxiD4ac3VuOz8SSQli1
         mpDg==
X-Forwarded-Encrypted: i=1; AJvYcCW0OMuYU6u3W2jHbZl6Mw/yzDPFTE2MCsnHG3G8w/yygOr+KTjpdMEDlLPdpEGlvO8jayK+yITX5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbdm2JzWrdBZJiy2/i3/FQWlFZLsVCawmbdBCa8W0i8BTwWsv
	xSZ+I7fOEIAS2IwT2kQBn1e+s1EWtbi/f6o5p+CX39RyvRu1KWU2UWBt8CO+Yw==
X-Gm-Gg: ASbGncu74vDgeVA7PmRzDDj7XqOkdlLWhD1QTTeSe16Oaqc6n+v1i2W2DVni3cKGFO0
	pKTpEtPhC9FGG8R6NiYez57uv7FsAU/Y0Kd+9Mlqa/JcjN78KXfwi55pEhqF5LUCEggrNvfrzXO
	h2zKl6ysfX85FfrYaRqxRdObwlvJ0y8lBmnytBJKCIA4qixSjNP8u+QnKTBjcm5z1cxNyKZOcLA
	t/VPAM4gGTFADtLT1QZHtObSnf8c1pXc8fgMKeBlFzbxPyd4m9W06r8xG+sKXeZyEF9dX2PbQ==
X-Google-Smtp-Source: AGHT+IHAAP725b6qHHfdwE5KaWK+vxPZotQq2tJUkRtgMiQ8+zRPCejimNtzczuh9Wxuyf5HynQ3MQ==
X-Received: by 2002:a17:902:d48c:b0:216:50c6:6b47 with SMTP id d9443c01a7336-219d96ebe07mr5248975ad.46.1734544614001;
        Wed, 18 Dec 2024 09:56:54 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f9a:1506:578:687c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d0e4sm79079145ad.261.2024.12.18.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:56:53 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM / core: Allow configuring the DPM watchdog to warn earlier than panic
Date: Wed, 18 Dec 2024 09:56:14 -0800
Message-ID: <20241218095613.1.I4554f931b8da97948f308ecc651b124338ee9603@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
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

 drivers/base/power/main.c | 22 ++++++++++++++++++----
 kernel/power/Kconfig      |  8 +++++++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..239bcf93f821 100644
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
 
-	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
+	time_left = CONFIG_DPM_WATCHDOG_TIMEOUT - CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
+	dev_emerg(wd->dev, "**** DPM device timeout after %u seconds; %u seconds until panic ****\n",
+		  CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT, time_left);
 	show_stack(wd->tsk, NULL, KERN_EMERG);
-	panic("%s %s: unrecoverable failure\n",
-		dev_driver_string(wd->dev), dev_name(wd->dev));
+
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
index afce8130d8b9..3387b94e76c1 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -257,11 +257,17 @@ config DPM_WATCHDOG
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
+
 config PM_TRACE
 	bool
 	help
-- 
2.47.1.613.gc27f4b7a9f-goog


