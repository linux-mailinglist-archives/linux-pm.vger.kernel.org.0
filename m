Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473A51A95FF
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 10:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635730AbgDOIQU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635530AbgDOIQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 04:16:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B24BC061A0C
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 01:16:17 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q22so2729472ljg.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0qOETrZoEuB/v/v2DIKaf1AzjYUQKI4o/HWYtk5Q1I=;
        b=BBJ4B47pV461JB8hafdD1HSs9rFcq4u/CFI1vxC2XLf+nY9DxQMFZCO0wkA8fnwRzV
         z5EByMRPSpTtdRUAtlJVw/h/Veuw28jcYkYxdKA7e+qhX7RysmAnOB+Pbp2bt3qxX6oK
         KusrlgqE90QTNG5/FaUlh8qhzaZG/XVFCYE+7Y7ZPpwMUmRneVlBQDGvPIAOm/4MxaA0
         h4xwXWCkU2z8N1Bp2mKuTmugUO5q4BcMEHynKVTeNOBL8/9FYNqHYsntP548HpyRZ5sx
         cTQVxQLrF510PYD//23HZ4zPqP5UT1RohIHiwBj8iyugPb6xjWcaS4vbdQAfs7UPNS5C
         qOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0qOETrZoEuB/v/v2DIKaf1AzjYUQKI4o/HWYtk5Q1I=;
        b=kXiAcjzxsBOoBbwJZO3qM30Id8i/OkuxpxYuITsXbjTcxWgVWJthGLgQhzjugDbOAo
         Vkzlu8x387Z9i4EDUpGM/MVnQPSJIBpsLc3i/xBcaQi4eeVgsN+j8rGXfhJi41s/Dh68
         GfNZL8IVGGJ1sRscMNELHFA1QDGWUiJdhEQ8XBi7UmdJxWnT4k7O2H10hcyHVFa6ztCE
         mGMTTsBE76oKgaaqrafi4FrNenGKQp0stuNOUYfZTYqPv0WF8o+7vJXQNK/doT/j0Rzj
         Ev8fBEe40nm91O0j+jKF2ig+m26yLmunKsjA5SgYSoDtuH/qVszxSoEVaJeWKiY7Eulu
         my3A==
X-Gm-Message-State: AGi0PubmCsMl+hEAYAdk9/NMfP/QCWHX6/3EcfoW+sr5H08DJtCKv7K4
        j2i2LzsH54Q+XpTEL2675Akd+Q==
X-Google-Smtp-Source: APiQypKK2eFrxitYeiW5ZObqNZGRMQRvh8bM+g566NNhmNjDwnVsifl7LxVz7UJKIboEFl0ITTAVoQ==
X-Received: by 2002:a2e:914c:: with SMTP id q12mr2538316ljg.124.1586938575988;
        Wed, 15 Apr 2020 01:16:15 -0700 (PDT)
Received: from localhost (c-c33270d5.07-21-73746f28.bbcust.telenor.se. [213.112.50.195])
        by smtp.gmail.com with ESMTPSA id f21sm12066627lfk.94.2020.04.15.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 01:16:15 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] cpufreq: omap: Build driver by default for ARCH_OMAP2PLUS
Date:   Wed, 15 Apr 2020 10:15:59 +0200
Message-Id: <20200415081600.29904-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When building the mult_v7_defconfig, ARM_TI_CPUFREQ doesn't get enabled
evenwhen ARCH_OMAP(3|4) is selected. Build ARM_TI_CPUFREQ by default for
ARCH_OMAP2PLUS.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 15c1a1231516..9481292981f0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -317,6 +317,7 @@ config ARM_TEGRA186_CPUFREQ
 config ARM_TI_CPUFREQ
 	bool "Texas Instruments CPUFreq support"
 	depends on ARCH_OMAP2PLUS
+	default ARCH_OMAP2PLUS
 	help
 	  This driver enables valid OPPs on the running platform based on
 	  values contained within the SoC in use. Enable this in order to
-- 
2.20.1

