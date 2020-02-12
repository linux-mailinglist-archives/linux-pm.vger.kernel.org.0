Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39CE15B552
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgBLXwX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42863 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgBLXwW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so4427842ljl.9;
        Wed, 12 Feb 2020 15:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3O1HMuzT815KP/fiKiNHhisNV4yTz5j0lwdEN1r2gA=;
        b=LjFPmiKtXUf4Gcbj9Ksipwu0FpomMDO71t+hfsdeWAeatZ2h/MPpUhVAiwKjtEDCXd
         ziKaSJgxemoR+HHFfu2I+90ncgoiXzFGF72HkNsfsaNaM5IUYmOsnMpIBCFM0cwnsa6I
         nxqMHAhU6Ri7t5OqOZtVC+QwFiRG432QoGGSLNOf9wGXVKMdalgMZ1K9/H3xxw37d0bm
         l51YqJGoY/xD4DTZyuFzHJ4DQz1T/8XfzncIolFHZ27vZsMVKpeMg1TDQ6GfSfQQtn8P
         WBel7S0GA0gaf9F9JFPpvJdR6ZXI4/vYigVyopEhi9TTD+yycl1gp4c6jRYnSK9kwd8N
         eJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3O1HMuzT815KP/fiKiNHhisNV4yTz5j0lwdEN1r2gA=;
        b=igfEC+YeQPBX91/DQ5Cmrluz2ppRegcw9yF/FkDt/UGEdnme5J+Y0VEnuigId99x9f
         UT652vur7S9CL+cq1ozEs2FRA5iJV7+VYWV0tPkCTXBSdD/rgEGWIDSoQs+nhYVZHVhr
         SeRyR8UTbEAC0AgJsJjoTzqmuWdXYxt66Q83WtmDzcaPpLalTj27Uk+z7P8kYj0D3E6v
         TK6ymlogxZFnM3E1yNgXng6j7pATZdwOwmkbXBlp67Dp0iQK49ZU4DwbTi2CMlK7wsW4
         p3cHzjXni7Z6wFhzdMsMcXYS+EUY4XFcpuS2vr3aVWRh/tVWegtGpffHHgw8Zh2PwnUh
         TtbA==
X-Gm-Message-State: APjAAAWAEr/rjVvWB7HHdQ+ZDCbCsHSIQtMlYw6duJHd/CIzZ3ZJ8dn6
        7sBzsI1d4K3koHxBd6kPEk3gN8iF
X-Google-Smtp-Source: APXvYqwoQrEHepz5UakbmcPEYM9Zx2wf91PR4MfdnpAcwmLQ+KDgn+ElMeslvJGG09O5cM0k7IXTQw==
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr9458679ljc.39.1581551539810;
        Wed, 12 Feb 2020 15:52:19 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/17] arm: tegra20: cpuidle: Make abort_flag atomic
Date:   Thu, 13 Feb 2020 02:51:27 +0300
Message-Id: <20200212235134.12638-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
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
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
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

