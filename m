Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537B6408181
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhILUat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhILUai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 16:30:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3737C061574;
        Sun, 12 Sep 2021 13:29:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so4092822wme.0;
        Sun, 12 Sep 2021 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AyR2ZkcURDXZDRYrzrABh/RSFyxFVolgF84p/Vdxxs4=;
        b=PHowcovkSxmFNc7rDqbAaw/nK3EGGSgworhe+XIqHDgcpV4uR5CYEuiVVaSPJLdHm0
         WhONSaRXZBV/FYrpLbtHGLLuS2bOwIRYDiKZzehqbk3wZzcJTGRFBklJrvyvCq2np4QF
         55lrWUqMUjsKYh9bVY0wrHy+MvaMmgMeNeWm09/AaQxhk+wi+jk17L56Br+w0YN/WngI
         mupvOvCAqaNsxOBQJcxw3IpGYf6nqcOynnFWNE5t3XGCaSsmwEz1+QTTRg0JpJcdIuRI
         7ih6+4MXjWW7KyjjByqtsoFW+GHfSO6DH/5W0mySd4jK7v+81TtQfhTLqp8TfXIh8igq
         2zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AyR2ZkcURDXZDRYrzrABh/RSFyxFVolgF84p/Vdxxs4=;
        b=msZrLQvuoJ6DRC2e6jW/6OyVRQInNR2DYi6vLawj1wwLrZfvLxXc09+LTc9kDmLyG7
         BZJSa1vity3A9Y5BEEuo9wc/QRBbs+WLpSGFBCAcyS4Kcc9a4FjAEMfrR4u+2IpdFRYl
         xDXn4UCGXN14oZlQhHRxyfqL4dS6XQbp2eCZ8YaKo7kQcXsHULNz4z7bBgl8C1JFw/QP
         vbxFJLC+wYVFKjqumwAxmYbZC+D/I+LbRs7MxDvs9dIRilCT8AOLr6BCpIfaTuYf9KAx
         aSV/3ypy/1XObRhrSF8cAwjZPYRtR99Er01F83L/zm0CsFnMA7cUupPkGcWXZuVUZd+X
         cPcw==
X-Gm-Message-State: AOAM533Xujo4ZNP0MlJoJfxmWGMSyiB9gY2OhftOUhTvlRFaXBDlyO/K
        og1l368mCrEkN8X/5qlZvTU=
X-Google-Smtp-Source: ABdhPJwaQJpPBxnSEbswZ3ufsNkRQ98oLdVp8bOzBFhqsGULp3N+srvHJAL+Obyl0243K8JIXkf3Gg==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr8193149wmg.132.1631478562295;
        Sun, 12 Sep 2021 13:29:22 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id k29sm4847466wms.24.2021.09.12.13.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:29:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] cpuidle: tegra: Check whether PMC is ready
Date:   Sun, 12 Sep 2021 23:29:07 +0300
Message-Id: <20210912202907.28471-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912202907.28471-1-digetx@gmail.com>
References: <20210912202907.28471-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Check whether PMC is ready before proceeding with the cpuidle registration.
This fixes racing with the PMC driver probe order, which results in a
disabled deepest CC6 idling state if cpuidle driver is probed before the
PMC.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 508bd9f23792..9845629aeb6d 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -337,6 +337,9 @@ static void tegra_cpuidle_setup_tegra114_c7_state(void)
 
 static int tegra_cpuidle_probe(struct platform_device *pdev)
 {
+	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_NOT_READY)
+		return -EPROBE_DEFER;
+
 	/* LP2 could be disabled in device-tree */
 	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
 		tegra_cpuidle_disable_state(TEGRA_CC6);
-- 
2.32.0

