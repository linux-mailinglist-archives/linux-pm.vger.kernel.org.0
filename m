Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E378216B454
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgBXWnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:43:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36825 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgBXWmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 17:42:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so11912989ljg.3;
        Mon, 24 Feb 2020 14:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/mPxVay/Hu7K8kphFH3cVYIKPmVTHJMz4OBtoUwnDw=;
        b=pck/NJYXlaxPY/Q2J7OuVN6xmLsa88Uo+1U6VsrkPtynrVeYdq58ngBpPJxUOrd2Vt
         yuwC94w71HwS9MpFJoJwOGJ4soe6WOpN0TVYTOZWZSnCF2Kiuzc1dhBt3Ho7p5LuThmu
         EbEDSmkg+2vzCpnlxld3cUuk6LP76DO0IeeFJGSFVcywbk5Qo8KhIWkpgvrddHtZzqnv
         5Hcn4MNg62vOb7OEAqKS3SQYKUmV8ude/Tytebl0h6RCm3nqG0zuqaH/w7B372Y1CHZO
         kaXf8V9l6Y9dx6iXtFcwTuAMnAg5v0VxJTVJN3M+H+AJ/CjOUG3yNdQ1BEjCf0GOsZUW
         kH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/mPxVay/Hu7K8kphFH3cVYIKPmVTHJMz4OBtoUwnDw=;
        b=bxZTEqVoKLMO3dgjHBei2Gn2SsFE+AcscU3Dp1C8syG6PJQHLUwl8yOYMfyXKLFpH4
         Pl6VVt154NdsGg1G2akqSH44/u10eHBINxS9ds7nLBz/hTH7+fRoqOOMMLebAoYX1Toa
         fFWvuCY7lH1unChhuwC29nB5An0uPzjxD5K6xNHamRCO1Qp1InOiHgvDk/fBfe7y6C6M
         QUt52aI65gUWVTt9cOTAxTc51GoUDvK7xrFtnq8MPMatjqRPKc7O9d9UXtcl/o3n7WeA
         +JuUD5NVOkExeWfYRNNqlWdVpAeKQ5Yu2I/pAYihYQ2rlgdHrNPiHKp8gpJkx/V9AWrJ
         wfyw==
X-Gm-Message-State: APjAAAVGS2uTDRT8EZSLXsh++xu0XElhHkpEqKeuMszeaWp3XbcIxBct
        iU1/TnVh+Z8PZcFTUa0PP5Q=
X-Google-Smtp-Source: APXvYqzSdEcbWR3nCTxQCqY20tMSNhhfhYra8xq6nWa3oEW2qkCRskdNNhiQ6sqd9ohn/Q1yrUTREw==
X-Received: by 2002:a2e:9143:: with SMTP id q3mr30254680ljg.199.1582584172729;
        Mon, 24 Feb 2020 14:42:52 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j7sm6264833lfh.25.2020.02.24.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:42:52 -0800 (PST)
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
Subject: [PATCH v11 17/17] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Tue, 25 Feb 2020 01:40:57 +0300
Message-Id: <20200224224057.21877-18-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224224057.21877-1-digetx@gmail.com>
References: <20200224224057.21877-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index a27592d3b1fa..aa94369bdd0f 100644
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
2.24.0

