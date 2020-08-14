Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6EC24424C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHNAJT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgHNAHW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1580C061757;
        Thu, 13 Aug 2020 17:07:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v15so3938600lfg.6;
        Thu, 13 Aug 2020 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L79iwZ0bcQ/bYNErMnkgdiSpet8EKxInzRHfHgz6Aeo=;
        b=NiP4ZDbqClOIWz3kunOdbowHssHlDerKEVLkW3GcU/ITVXqORlahFtc4DpJ823T7Af
         0ENPwrfZBrqMpBHcZWNy1lsAJQe9lPJFaxz5X0U0Uw/qvjvdBB38amJO0/lRoh/2T7rc
         bmC9+TscwV6l7JaKxeBOYJz6Tw6EhIEMVnFJ1/BGO26ek3M0YvmA4qgZODGwVVve8AYs
         DAH8/tlNlcfuooDTjoXqhYxv0Bs2SDyXjAFOn8YAr5INCfa3LZ6Ccec+/mIUyvX6OBka
         lsnEFgX1MBorRQwODElFfUhPq1daWwOQQY8cx3cqLEdL4CZCfszxsgSdTtgBiuPskxcz
         lWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L79iwZ0bcQ/bYNErMnkgdiSpet8EKxInzRHfHgz6Aeo=;
        b=ZkLSgyKTqWzu7CgPcIxPkAb6NtDlg0jc3llUpPKHTXaaKvYC9Q7wRqXe3l1wZwuvT3
         zy1ba0w7LXQKN9CrUMYtkryXaNMSnYzsrzxCbubLcjU305jmvYy/ihmywI2/V9v3W7Ng
         rd2OkJespXYzFhy2vb+SuXvqKPUw7CK7ziPgkIGIz6Nxduk3Dm8onA5fsmGbNQzUEO5m
         wVy639bq2w4F30pM9SQ3LcBPVEYKcD6NK2U2OV81m5XbGAPTh6e7ihM6U2qv599ceK3D
         7E1/U6CXRIxNuo1RCvr3aMhk9qK+Ki9bQP8S38oOhDDCQ2pm1dY+hOqGHA0zjkfPm4IA
         UfkQ==
X-Gm-Message-State: AOAM532bUTqNX3s9S5RYUgcWcFqO+kM7loFPVyzRdDUqTe6KWRLHhvtn
        SZDXddtqYi1WNm8krLmHg3A=
X-Google-Smtp-Source: ABdhPJw1OxzpVPy0ME8CmE74TISYPXIcWkGALKPr7LrdTvMm/viQPl/RwghQDZFc4M8Wqub9nLtTjg==
X-Received: by 2002:a19:c501:: with SMTP id w1mr3142820lfe.172.1597363640159;
        Thu, 13 Aug 2020 17:07:20 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 17/36] PM / devfreq: tegra20: Relax Kconfig dependency
Date:   Fri, 14 Aug 2020 03:06:02 +0300
Message-Id: <20200814000621.8415-18-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra EMC driver now could be compiled as a loadable kernel module.
Currently devfreq driver depends on the EMC/MC drivers in Kconfig, and
thus, devfreq is forced to be a kernel module if EMC is compiled as a
module. This build dependency could be relaxed since devfreq driver
checks MC/EMC presence on probe, allowing kernel configuration where
devfreq is a built-in driver and EMC driver is a loadable module.
This change puts Tegra20 devfreq Kconfig entry on a par with the Tegra30
devfreq entry.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 37dc40d1fcfb..0ee36ae2fa79 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -123,7 +123,7 @@ config ARM_TEGRA_DEVFREQ
 
 config ARM_TEGRA20_DEVFREQ
 	tristate "NVIDIA Tegra20 DEVFREQ Driver"
-	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 	depends on COMMON_CLK
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
-- 
2.27.0

