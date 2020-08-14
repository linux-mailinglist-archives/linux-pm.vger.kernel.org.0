Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A852441EC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHNAHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHNAHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72558C061384;
        Thu, 13 Aug 2020 17:07:11 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so8091724ljc.10;
        Thu, 13 Aug 2020 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pct9NC8VO0a8nghXwi5ctazbfo4aqrjWxTsK8RkybFc=;
        b=nH8/nuDXiy+4Qdh4ChCGp+9h4XJ/9orptXrVOfCGXo8g+bGPVp+4G6DKAvwtXVNGcw
         3DJBl33KCs4+QjqTqoZ/qQgzaXBlsIj3EIL6WnA7qEZsl4chs+w/DA5HaJ+hgepPgCFH
         JLZMbAQO86mgVlzXaZ/zvut7677+7DAwt34OYK8h2q6Azv+5UC1p5rjW1S2K8j+Xgm0y
         oNaD/QUFefOibo4csQeD6FlxP+oiNdtWiVSyLuViPMRiAf7A5cwwDMdCqsM8bSeNu/id
         1N36EyGbl/SK/faEi5nfVZOvfGGtpvidQqg0ZX+6SksOzafnhQs1lXcXd4jT7QN0hB8E
         +lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pct9NC8VO0a8nghXwi5ctazbfo4aqrjWxTsK8RkybFc=;
        b=FPw+C5+IlAIsVdmsIZt017ugZkBLqqzPNezUiWptWAaR35mJOd9mh3R5mOM0/g2yWH
         kCLDW7fWbQXnapKGpBcmyicuUd5KcqzMrI98s71SWcfJjRMqN47zUr7cyoVTec6b0pq4
         XN8cESL8MC3DYuZA/jqd0dLsFZs3xMNdFa0pTZlEUt7R0lTTNOd/EPfSqqsyMeJh2G7D
         G/g73hEHXO2tfAmpzitvfC22CkXLKCpiF3rRPp5voppm7FMBwW1uGs9E1dHm8EDvatfE
         AYpCQraT386vzujonqB3nZQ6XyCshfuHCHjpPu8NFtcfI6np74g7FyhfaM1p1t+mtR3u
         AGbA==
X-Gm-Message-State: AOAM5324BhZWhvNpoVVyXMtJ3gARCJWdAwv8TD5LfWzyTHi4qRCvEUXJ
        BYI9GThosa0rI15HRBLIKLc=
X-Google-Smtp-Source: ABdhPJxPiJZrWxjd5umBuvDpZgsGH2/Uz9/ZQbEwecYHehDNeedDfyMunYNlTn8uBO3uFSmir3TMrQ==
X-Received: by 2002:a2e:9d91:: with SMTP id c17mr102359ljj.131.1597363629992;
        Thu, 13 Aug 2020 17:07:09 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:09 -0700 (PDT)
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
Subject: [PATCH v5 08/36] soc/tegra: fuse: Export tegra_read_ram_code()
Date:   Fri, 14 Aug 2020 03:05:53 +0300
Message-Id: <20200814000621.8415-9-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra_read_ram_code() is used by EMC drivers and we're going to make
these driver modular, hence this function needs to be exported.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 8e416ad91ee2..151eccb6069d 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -65,6 +66,7 @@ u32 tegra_read_ram_code(void)
 
 	return straps >> PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(tegra_read_ram_code);
 
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
-- 
2.27.0

