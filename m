Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA472C18BF
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfI2SAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:00:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36380 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfI2SAX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:00:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so5337260lff.3;
        Sun, 29 Sep 2019 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lHQRX/0nej0WuuBggHgivhPJMPJeSRnbCLnwWmZEkg=;
        b=pns5X4J1b/chVzmWCaJ9roJwzlzzxfud3orlNH6RV0Yn6ucwHyR1wBJ7087vpaXc/+
         z4nZv3cVNoByARdqV2wJ2JFl7rlhVVmwFgMbgeP4udRh+GLDETUFDwP4rnG8e3MTthrq
         zbzmr3ca5K9TgKget+lyUbU+vlHYOc+NCVwjLgn1iJuCgAhGqOlBLOJLo1qnLcxUcDty
         wWQG2O1mACI2KjcfXQ5+nG0SzPSdn66CuqfK8uYn8F+oYTq4uC6ZFUWBzpsEqqAE4BZJ
         1boP7tN02u6Ck/db1qaMRagCKX4IS174XEG5G3wXDWgDYUYMToheIavQpM1sbcDizJ19
         hOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lHQRX/0nej0WuuBggHgivhPJMPJeSRnbCLnwWmZEkg=;
        b=DK0IfckSmSv3u8yI0Q3pI7VevfvFNIulWsY2q6IaccEIxlxqDtZEuVczXwZBY/Uz18
         YlWc1kfudzojO1BS6EECX3sLqRSbeHRQAcrqtmWu4XXe92E5uVDCIvUOiHN8N0WW3wnP
         2LWkvswOy5ZjpAzfbUjPsnOdTZDL2+wP5xWT2slKvMA5pYVVxmcIrUmj+/2dVkzmKYMc
         4p/OLe7LuGSi/M2nr7l87DK8HMuQebTYv1pev8umaufipP3ByWzDKsBPbxnwtyAtovW8
         L79fV+MPshL20CPOmA6rQx4TUmoYSMMvPq3K4552Hg2MOh5ZSVQkPATITb4drhGJRv/H
         4t2Q==
X-Gm-Message-State: APjAAAXDEEhjaiFfWLWa+MwUMuawPg1Or6E5l/4qrh8zaby6h9X2MaIW
        0FCO7kjP5ZZBueFayMXh0Ls=
X-Google-Smtp-Source: APXvYqwpIJmswVjes73DIsYbkyF58y9adlF3nmlGhQk2yZfZIFvujd7TeVW0RB4eCRfh2ISuiZR+dQ==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr9034870lfm.107.1569780020951;
        Sun, 29 Sep 2019 11:00:20 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.gmail.com with ESMTPSA id y3sm2355511lfh.97.2019.09.29.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 11:00:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/14] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Sun, 29 Sep 2019 20:59:52 +0300
Message-Id: <20190929175952.22690-15-digetx@gmail.com>
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
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8f5c6a5b444c..9a2f11a780a8 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -25,6 +25,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.23.0

