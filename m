Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38B6394D67
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhE2RMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhE2RMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 13:12:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5167C06174A;
        Sat, 29 May 2021 10:10:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w33so10065352lfu.7;
        Sat, 29 May 2021 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AqIoL8w6UW8nZZQW4Ci4myc0ad3mcz0KynC5WY0Sz8A=;
        b=SC9HOFGn1FJK9Idj7J9epG+7uRSalCCjTpT+ovYZg5X/fmyIftzd/PYsWmCDMADsXO
         yPh5DjjR3mYVTy8UiEpfk3rxnftJAWcleoVd3zVqEK5gmP8l9vO8qADlmNjoUnQglvkL
         8yMl1M+/hwY+5MAsOUcBxkbu5vrxpkxwe1djSjNMMOpYa8OuYe2OfK/F2E9k/FaUDps2
         03XgPUlviicdiF7saiT4Mfke/9rxioHnuk3/v9LLVsKeb+ddABuom9ksPd7RT+BhzYTV
         EZytqkArLyeXYg8axBxn1O2N0f8ReY/ALjK/sQsTbttX/DS58W/u9M+IO8SWBTW1IqP/
         5OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AqIoL8w6UW8nZZQW4Ci4myc0ad3mcz0KynC5WY0Sz8A=;
        b=p9IGAV8nggTA2koMLa8oLEeRu2Rl/SArsHkdFVrXxo//dHShXLm4aQWbZD71F5Azth
         ub6IiC2D0fkSLnveFnzwoOQZJ11E2WDsXnfBzhpoZFz/MzkBHOpHEzo8MBSTpyrkkkPy
         5hWU8iUpbbu0+jq+B7mLMPaVlB7Vc7ZEjxzVxOmEaMFeX/sqpsQoBZhX/Y94xlAQpVvg
         NMOmA3BFUnMKto2hDduBgyWHMcqU4BhH1wWlf4n5WhoCfbRKcG72JKfB1KefNf1yrTB6
         uoT8lu40QJLqV3uMJdhb5guIm8Z3yP57SsY2/eusjnOh2uOH6NFuQ/Zs7vQVj3C0Uewk
         n+5w==
X-Gm-Message-State: AOAM5332Z9/WlY9aL1PybbCOYgwuK/ZEzQdNnrGQZayxKIAFZksFPs+t
        ZwUOkt6r2j7CrFqnvIAxX+U=
X-Google-Smtp-Source: ABdhPJyEI8rYuXtAFA+S1t0ksIcqqd+dZ/oKKiQyHBdppzUjByxCYT0MZPoleGxlZpYZbbkdoS031w==
X-Received: by 2002:a05:6512:374c:: with SMTP id a12mr9779590lfs.420.1622308241224;
        Sat, 29 May 2021 10:10:41 -0700 (PDT)
Received: from localhost.localdomain (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.gmail.com with ESMTPSA id h12sm901715ljh.130.2021.05.29.10.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:10:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 3/7] thermal/core: Export thermal_cooling_device_stats_update()
Date:   Sat, 29 May 2021 20:09:51 +0300
Message-Id: <20210529170955.32574-4-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529170955.32574-1-digetx@gmail.com>
References: <20210529170955.32574-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

NVIDIA Tegra30 thermal sensor driver has a hardware-controlled CPU cooling
feature that halves CPU frequency once a specified trip point is breached.
In order to account the hardware state transitions, which are reported by
interrupt, the sensor driver needs to report the cooling state transition
and this is done by thermal_cooling_device_stats_update(). The sensor
driver could be compiled as a loadable driver module, but this API
function isn't exported, hence export it.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..ab373280f853 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -690,6 +690,7 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 unlock:
 	spin_unlock(&stats->lock);
 }
+EXPORT_SYMBOL_GPL(thermal_cooling_device_stats_update);
 
 static ssize_t total_trans_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
-- 
2.30.2

