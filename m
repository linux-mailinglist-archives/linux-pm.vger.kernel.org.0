Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8533D1F3BCD
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgFINO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgFINOr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7511DC08C5C4;
        Tue,  9 Jun 2020 06:14:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z206so12447507lfc.6;
        Tue, 09 Jun 2020 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGygXNg/Km//fsZYaJ9FCB7/EL/aLlPnXW30j/MHS28=;
        b=mXB5SnZfqn16vRA4uYMqy5Krd7bygaAo8rS/UK4iy9Z9kcb0GP2JbBZJ1PUtLi8m9T
         fCPj1cgxlUfnjbanOJ59z+2i4USb6ocIGdXb75mzQaSAkiFWMC/UzomMXJfTjyfczbYe
         RXVvwgb35UFtAbAse/tsbcN+lfAZGMuPBqaFfQoXt58bKPjqtMsalIxULD+b7nXd5ya9
         4aHZkhv6K8DB3lf0QU7sUNVpTijh43HR+3A8JpDtUaq3X/6p6uoLt0X7xwOGZRKkjGls
         usKYKWDhrkqo+6X+fV/ZOJ+1Nfbg8Xn2VvYTgqwgpWvrzr0MwVf9K7Tw4ZwnH9pOSEwv
         pp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGygXNg/Km//fsZYaJ9FCB7/EL/aLlPnXW30j/MHS28=;
        b=ISZX2BEiiyx5YfNjMFzrmrr+Tsubzk39iLcTrd0483klOYxF47dBeN1wJTOo1Upr65
         veNWbXADXv+FP0RfnrL0UIA3q0F7Xjstp/0ssfph+ZzkYmW5pt++qjf15ZmIwNGVDVCt
         E560fTiAGbTABZSZcWNohKwgAxBfZM81zaYJeLat0+aU6HO/PzC95X8vhhPbGwvxIguM
         ZPIvrGsPbTPIhwJj+sfjhmeGRAzE4L/o2OZSs2Uj3WH/ozuwNLys/zHGVliTxP5X+vwQ
         cAioJfcl2iS7/A6VJfsq4XspnVvIiMe+fjSpf1+ZYoJCHM/Pd9IyZzEZf74Zr77ihuSC
         KPig==
X-Gm-Message-State: AOAM530RUyTjaPB1IxoJ0PmkowOilq5UT88UYNMFLUcBLhAga63pQLay
        bDBwV6nKvQMNBY4y0YBPVjM=
X-Google-Smtp-Source: ABdhPJw4Dspq+j4OlHVQWELAm+cmFDHSM2hFjfQ0yc7ewczkHde83jPV9VSqWzCREbVJLpyCRkMxjQ==
X-Received: by 2002:a19:70d:: with SMTP id 13mr15601641lfh.60.1591708485971;
        Tue, 09 Jun 2020 06:14:45 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:45 -0700 (PDT)
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
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 17/37] PM / devfreq: tegra20: Relax Kconfig dependency
Date:   Tue,  9 Jun 2020 16:13:44 +0300
Message-Id: <20200609131404.17523-18-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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
2.26.0

