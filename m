Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF6616B44C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgBXWmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:42:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35355 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgBXWmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so11909199ljb.2;
        Mon, 24 Feb 2020 14:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZoylVC2UJJwnJQI/G1aVwYHoPPGDLsbVpFo6bETe7WE=;
        b=GP4+gGkaF7AP+tmYns2QkWJwnCqh0tsrj/n8NdmCwueq30JDSyKy605Kc+V0stwNF0
         SbblPiVvUSuSQ0RvBobQWo7oC6P3LOwb5m6zweDjGjCdi/TwnNVpPi1bG/eZ72a+fxiV
         V9oeEJysOm6AMsk47rjxflnPox8A/lUYJeYTDfqkzxeH55xVS1cn8ix2sHGL+vRObYhz
         FD2pw01AxXIZrs1XlE03s5tc2rOBidl/nKo0SBve3h3wHf92ZE6hnJdYQfOVSj27Ue2o
         aPp/CqxETpzA+W02VyG5G8oFzJgt5G9p37bJp2xQ97pHJyHDXdTyDeY9VUFVzohV+5Rf
         D5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZoylVC2UJJwnJQI/G1aVwYHoPPGDLsbVpFo6bETe7WE=;
        b=am4k1gUNLBUUmaWg5YqH+6VXO81d3CMG0Bepi2b12npkX3CcgADOyv3hr5f4DMNqhm
         MF/IRqGkPBQQjCNkKuCI+3srVEpniRDHb4nZ+ggzcHfXyX/ByHj/eQYhifuTMDBeI9FS
         wwHEPoMEij48HIEdFDxlMPGhZsAPXU8rk6eoLOB4MAOj4iuctZE3rBtfBpEG+RmduSdb
         Qvu+eVzL4e5y2nU2sxNxEc6WKS98SPKxv5EOowXUS8K2rR77ylCSy7U5OSATXOKUFTUz
         X8iAhSQ4w5MalwGBoZsxkPpX7ZRzAKfGHzkY5p2hTauhhwwfCGn1XO6NE7D5BPVfTQ7E
         WG/Q==
X-Gm-Message-State: APjAAAULs0wrLYYAq3+31Otp0Zsjb01xm2gI1i8vz4wCt+AgCg/0yfha
        6JAlhDmgQ4O/TOCsiDHKi3E=
X-Google-Smtp-Source: APXvYqzST2YV207SBFEyLt5fEFLkfQzEeMEpSQJHHQZD19O5jGt0464hAf+CxVMhTf1Pv5dn4S7VLQ==
X-Received: by 2002:a2e:1459:: with SMTP id 25mr32623019lju.189.1582584170367;
        Mon, 24 Feb 2020 14:42:50 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 15/17] cpuidle: tegra: Disable CC6 state if LP2 unavailable
Date:   Tue, 25 Feb 2020 01:40:55 +0300
Message-Id: <20200224224057.21877-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

LP2 suspending could be unavailable, for example if it is disabled in a
device-tree. CC6 cpuidle state won't work in that case.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 2ddbd289e17d..313b0290e97b 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -31,6 +31,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/irq.h>
 #include <soc/tegra/pm.h>
+#include <soc/tegra/pmc.h>
 
 #include <asm/cpuidle.h>
 #include <asm/firmware.h>
@@ -337,6 +338,10 @@ static void tegra_cpuidle_setup_tegra114_c7_state(void)
 
 static int tegra_cpuidle_probe(struct platform_device *pdev)
 {
+	/* LP2 could be disabled in device-tree */
+	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
+		tegra_cpuidle_disable_state(TEGRA_CC6);
+
 	/*
 	 * Required suspend-resume functionality, which is provided by the
 	 * Tegra-arch core and PMC driver, is unavailable if PM-sleep option
-- 
2.24.0

