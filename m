Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519B9C18BE
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfI2SAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36487 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbfI2SAW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so7113808ljj.3;
        Sun, 29 Sep 2019 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBiJ0G4nRszlIbKqT979ZgjozfbwgChkkqHAh8XRzzc=;
        b=Ww65hc4c5+I5AL++3C23SFXEdnmCzAxIk71g267k94M+ovQ/kxXVYCw6N4YuNJ8sUQ
         MZ1xWOTOEuGAkSLw/5uO2olSYVE9Z7xWRez5ic0BJKENuYKBom41zVzqgumFZHaETKke
         PDR9V660RO4cVNs7Dt38Xv6rX32FgrP7E4wvvKwiG1+PLFUoGQSOoWl7UxrFMYSfpH+3
         lQ8DmmOm7/8iT6ao7nTGDvmy/WPQkRh64MTvK01MHnF96uCMDnUzo9OhHJTWTS18PMMm
         eMFs434J1MdECZSXD95OkacS1JboF8PX6e13zxxVMl+yUDRve9TnR4KKrGeKKRdMMdKn
         5Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBiJ0G4nRszlIbKqT979ZgjozfbwgChkkqHAh8XRzzc=;
        b=bjcLnCnKSCH/dUtDj7fTcTpsV9wibnPNZheoWXay3nGXvwuKgdfvbP690ZefE386Yy
         ZfKpLgSF0ALqfbWcv294PeM8uEKJE1Ywdx793q/Kvqm0M96WlrBh70HDDMtZRN9diEbx
         AQlR1c4NiUbxuX3aflrnScW0h4HtHUt8yLScGSTx/icFzaaG48dkoeCrmOUmSgxdS7X0
         BosRljuQyxi+eIGrTdX0BDzNx9V2lXaZcnNi6Q1pU2WEYE6KwZbQKPb+LGQCGhYpLmQ/
         iU2a/NNEcxtWzJWHHMjl8Vgp7rCz0nVEf4mcPYT7FyFsyxGgV9DBPeRn3z+RXS1Wc9xN
         GGqA==
X-Gm-Message-State: APjAAAULHRhdy8ubgdWss5++0RLnADBxR4rG0Nadbvix09PeBVJLY2ED
        NeKqxriAFfzahpCP6+1mxkQ=
X-Google-Smtp-Source: APXvYqx2ANqJ1sgcatHsXZfvbV1+M89+2YvovJKWBv4cg1bts33OskA18fm/W7rfurwe02I+MzQtJw==
X-Received: by 2002:a2e:8052:: with SMTP id p18mr9182479ljg.198.1569780020068;
        Sun, 29 Sep 2019 11:00:20 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/14] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Sun, 29 Sep 2019 20:59:51 +0300
Message-Id: <20190929175952.22690-14-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929175952.22690-1-digetx@gmail.com>
References: <20190929175952.22690-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 13ba53286901..539bb60069ee 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -110,6 +110,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.23.0

