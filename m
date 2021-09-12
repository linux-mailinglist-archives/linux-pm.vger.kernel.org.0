Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6876A408179
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 22:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhILUam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbhILUag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 16:30:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A050C061764;
        Sun, 12 Sep 2021 13:29:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so4092794wme.0;
        Sun, 12 Sep 2021 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+ldZ6zVWXwe3g3Zo8gamYTapy9Dc2w3F5/3/sLNYtQ=;
        b=Tx8VwqZ98CsA/xnJcPa67JWpsLa0ggEdSMyMfWGPbSpFXirGrCzhRFb+/9IGTtYQfn
         AYnZQY9iOjqT9Ixdgpr4bBpKA9AucXADQZs13opRWGWvjC4ODHry1tRFvys7PzZ5+922
         obyhYjdVoXNSomVoOWAM24JrybXBTau+9oroafJGaki5WlQ5ZfxJJxdbN50igu/IFr92
         Tq8q5TUWCePqk0W75uzK84hkBrw9a0/ETEEHH4WTOdasX4PWAP6/vY8amR6WUVapsVN5
         nDF7UuxvcSFfAjb0FwCzYt0qZUHPzPsTDPIaS7hGM9+fAY8HPHrhgS32EpsMSJW0fk8Q
         sGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+ldZ6zVWXwe3g3Zo8gamYTapy9Dc2w3F5/3/sLNYtQ=;
        b=JJwujND+Cq9kzMFxqJYh5seb/4zh2mN9aJn9PR+mwbobiQeV/vq9pPXltVmekIi8wv
         54sYd8dITSSBk9yaDaVEdDjoO7t7of8+gIoDYpFu/UPb5YttRxEpGvn8lbzgzirAMP8s
         05DzvXjMu1UTfr+xxvRKiJwpkL+eCFWGheKCuefGh27mhkP9cykQPTe1EPJcxCuqGFrY
         hMmFA0ytcsyFcEIzeTP2K5bGylg36wgkdl4i8lC9cEqp1TQfzeTBeXkGL+5/rheGGvIp
         iXLwmEZZRa3mxC+nt/HHJfJltSvVvtTQqo5w3U+7mYS7j02DYCQIX/Y6LcmfqCccS0hJ
         Bjhw==
X-Gm-Message-State: AOAM530zfIU0cwFD+IxzslZVa8oEs6yUHIfvnmdbOBSnHMmgU6JVQfuI
        ggRyLPtvGHwfC90TiC2kYcQ=
X-Google-Smtp-Source: ABdhPJx15WYSxITWAhHDQmYgMkWxC0uVFyH3DGO4sYsZC64xIT4caSMc1pqFtEVVN9C301vvdiA/vQ==
X-Received: by 2002:a1c:d2:: with SMTP id 201mr7735259wma.67.1631478559796;
        Sun, 12 Sep 2021 13:29:19 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id k29sm4847466wms.24.2021.09.12.13.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:29:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] soc/tegra: pm: Make stubs usable for compile testing
Date:   Sun, 12 Sep 2021 23:29:04 +0300
Message-Id: <20210912202907.28471-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912202907.28471-1-digetx@gmail.com>
References: <20210912202907.28471-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The PM stubs need to depend on ARCH_TEGRA in order to be usable for
compile-testing of tegra-cpuidle driver. Add the dependency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 433878927026..ce4d0b1bd0d6 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -17,7 +17,7 @@ enum tegra_suspend_mode {
 	TEGRA_SUSPEND_NOT_READY,
 };
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA)
 enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 
-- 
2.32.0

