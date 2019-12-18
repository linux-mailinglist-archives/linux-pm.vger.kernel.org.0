Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1BFA12543A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 22:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfLRVGx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 16:06:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40717 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfLRVGw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 16:06:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id i23so2720398lfo.7;
        Wed, 18 Dec 2019 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Fc16lLz+PcEOzTBmofFYsXDuW2bZQVydYqS2lFFTaM=;
        b=r0tmA3EThpqI/PxZ/vI2RFxHg4XB5ybzOkVV8CBEi5o0yGL+0rAxGrbgffgpd+anLm
         Z6x3gWjvomu1plPwJZ5et0h6X4kI7dNmh5cKXZf34703Mg0xr8lUGXifhcD8EudtP7BK
         0VuSCR8nw9+q1wyBSdgBhuZjYRE4PK+uxZMclm/bA92CocBtjv8vXs3JlBrnPyb8cAZP
         DIdz9lW506RZrgNH+9/f/wSRM+S82nHiIfRlBCDF1RbrwEGNRSQbs98Ob4nQ96GgyVZY
         VcKj3cpX17hVtH6TFpHwjMhd6uiUHE0rxiIgiUS82EcjsJ0nMyIfn065BvTT+DQrYYbC
         u+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Fc16lLz+PcEOzTBmofFYsXDuW2bZQVydYqS2lFFTaM=;
        b=kAIpZSFmBN6YysifIXEfLQutFuQSFw5GgCD9K8/Rm12bMeOdZISoV5dShh7XCMN9G4
         2Dp4bnwtMpt7K8LoE5rIUPW9r7eocSyi0LcTACLLSSr2C4MJuTYL8ueBpRnCz3h9fnIi
         JFYZxhWvLnlawvOSZh0QqW2FOMCCao+yKt4h37Vo0kDBwmkX2HgqkMzGiaNnmlZ71kRH
         MVQghpgHfSOrY2qHOy8qU23FQBJrG8yGHs18DQ42Q8x9IY+lHyjgvpD71/ari61JiCpE
         m09A/k7seHrBYxBZiK/eEgTUepKU46abha2WZCkHzpJ+DeqphE8X8hsouo7R/GlvRmal
         DWxQ==
X-Gm-Message-State: APjAAAU5dnGBZN+jTzCx+TNzkZdwTw3Fn9N8sTX/KZtzivrh0zkH6wQR
        e5vxfMV8gmldiaA54ZPsXSA=
X-Google-Smtp-Source: APXvYqxULpZ5jzgrz+hAvBDf6HWzZzaPCSAVNAVz5bro2nhaDlG7z/Q1b3BPt3rZ2wYS8Qa4sWPdkQ==
X-Received: by 2002:a19:c205:: with SMTP id l5mr3030784lfc.159.1576703210332;
        Wed, 18 Dec 2019 13:06:50 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r15sm1754648ljk.3.2019.12.18.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:06:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/17] arm: tegra20: cpuidle: Make abort_flag atomic
Date:   Thu, 19 Dec 2019 00:04:56 +0300
Message-Id: <20191218210503.6689-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218210503.6689-1-digetx@gmail.com>
References: <20191218210503.6689-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace memory accessors with atomic API just to make code consistent
with the abort_barrier. The new variant may be even more correct now since
atomic_read() will prevent compiler from generating wrong things like
carrying abort_flag value in a register instead of re-fetching it from
memory.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index bcc158b72e67..ccb8b0aa6c46 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -32,7 +32,7 @@
 #include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
-static bool abort_flag;
+static atomic_t abort_flag;
 static atomic_t abort_barrier;
 static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv,
@@ -168,13 +168,14 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 	bool entered_lp2 = false;
 
 	if (tegra_pending_sgi())
-		WRITE_ONCE(abort_flag, true);
+		atomic_set(&abort_flag, 1);
 
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
 
-	if (abort_flag) {
+	if (atomic_read(&abort_flag)) {
 		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-		abort_flag = false;	/* clean flag for next coming */
+		/* clean flag for next coming */
+		atomic_set(&abort_flag, 0);
 		return -EINTR;
 	}
 
-- 
2.24.0

