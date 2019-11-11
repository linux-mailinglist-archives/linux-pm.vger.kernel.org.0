Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A37F81F5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKKVQh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:16:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43549 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfKKVQg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so15330940ljh.10;
        Mon, 11 Nov 2019 13:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Omi0XtqN8Kc5VZbYU+UoqGDpANl8X11C5I6N+y6qX+s=;
        b=Smv+4ZIqJXYeV9ChVgVPBYhHMpgJjkLPGUCdLXjSYFMj5S2KsDwnpgwzQgYgEt+ENe
         nNLZbqFpQYXfb3y5rXSlKS+QZe4uVCnRrA29marMZv8SiLLiKyIVVPxggxRqYGOpJoiX
         SDdVqAxTfCainI1PJ3y7M30lR/alI36SsYguuoAi+93HEJIWKap4bV0a7P0NPvagMk19
         uU156VTPGxzNL/IOul9NU036Aa/QV3fPaH6Qkfy90ItHCP63+u1R6T9zvR24w9mcGdkb
         00B9z9CnJr0UgLCxssnpoEHes0mcYnninZiz/77ffygBGPqSzJ3rqAQif9fe3ixdaeHS
         FoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Omi0XtqN8Kc5VZbYU+UoqGDpANl8X11C5I6N+y6qX+s=;
        b=SbUVGMUfxWBLdoKjGs1TQyrEQ1aXJDSOAAvUyGCuHTioM+N5PTvIwPjHWLrH+aL6k7
         +Qs1HxPWRR7lomjlDYkeW6VDwt1HFOWRCXsBfnbZnBMvJEffFhBllCcdvwOIJgprlEZB
         LiPWI8GQ2YRbqQVGvDnvY5WhCTnp4l29J6X2VwQ7JCvJwsbgFH2waMIZbo2cZhh1O83F
         BzI9PravjMgCKeoYLGT8U0jKeJ6epX07ll5tXsiYOK8MzYjPIRejDigsn5QmkqPVMaqD
         GTbSFGx+vOAJXPasLF88z//N2QzmACjCaRXBImHjNGNwBKXskaMlCfEyfudZKBiEN9xR
         JBVA==
X-Gm-Message-State: APjAAAXnpOcsWSAMzj6hDM39+I9rSoJkd4n+eaxIKYwv/LcbnV6a41Mo
        v94ulD4Rzj6WCO+In2c1Z/4=
X-Google-Smtp-Source: APXvYqxLKInKw5WbXYyqQjzIx7MApjM4IFoUWL45UREcv37Rq1FCUtR58qaEJCX6cvt7pWSMwdLpNg==
X-Received: by 2002:a2e:8597:: with SMTP id b23mr4052321lji.218.1573506994429;
        Mon, 11 Nov 2019 13:16:34 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/17] arm: tegra20: cpuidle: Make abort_flag atomic
Date:   Tue, 12 Nov 2019 00:15:49 +0300
Message-Id: <20191111211556.20723-11-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index bc5873e92af5..fe80f1988120 100644
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
@@ -167,13 +167,14 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
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
2.23.0

