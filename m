Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831C72441EE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHNAHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgHNAHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD9C061385;
        Thu, 13 Aug 2020 17:07:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so8128138ljc.3;
        Thu, 13 Aug 2020 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enQXWXa7CxfwNeu1ctQcEFbFznRpVI/PIPqSe3dmn9s=;
        b=fT2X/WHGIWN9qFvv6TLNL4L+JH4lBV6w7Hw9xzB7m7YipcGaPXAe//qgx/6I/G0ner
         VOE80Q9FSV4cV6ccz6c3xU4CX35rsHAXuGvk1PbKEFX4oW2B6tieZ28GoBWH2rxj02xY
         QYA9pta3/aKbi16nYk+a4BpINAtv6LkZbhpI1Qfh6/Us3NH4WlLpBkqKiLsHMb4bPuGc
         +vBEMAM7Nde5Js1uzfDIt222+JPm9Ro8p6CJIX5aNhcar/SxNv4XnaQFVud97yueoSTG
         EeDEtHGhJOIh63/OV5uoq2eGYPWFfVKVupvYWFX9yWKa4jGKrkRtppVhpkNzDjd1ghwj
         dgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enQXWXa7CxfwNeu1ctQcEFbFznRpVI/PIPqSe3dmn9s=;
        b=NL7hHkMNYt7q1hkxJad73NeIoN6iDoAxZYbGs0hkBV5spXYzfMpZwjAq34CxiL79KP
         UZ4nb4wPasA9giYFU+MndAHh3ln725ZxY1kLS3smDspPg36Md1NmNydT/Mlw979lN00W
         x3Ycy/1XeUM5dbOzS/RACcjfoJlTK6zACBNSg3GdYhUvSTesnSUFQ4wY1ZJ1kMsJ+SJr
         71GBHCf7k90bcuRl5ObdI+SRIN1AAVztuf7f0m8XwB7pd6NMK8r+p7BXbL6cm1IXCe3o
         +hX3JGPNJyn8CvFflxQrLrfm16y0GyBI3XkECYUtbQ5zra3y0gfvdOUC9vCwAKQcunTY
         G2PA==
X-Gm-Message-State: AOAM533jzTBY/aVeZF984/OlSmv/4/oiEayQNe2W03cGYi8eFddM3OMK
        xitBHMBsVAh6veVIpgneWzk=
X-Google-Smtp-Source: ABdhPJzfIHAKIWQU/LUL3hX6UDGeCUZOy/9fZTDOZx4s14uO/SyEtUjHIPep24IM1BlpBWm+N3r5ZQ==
X-Received: by 2002:a2e:b165:: with SMTP id a5mr89666ljm.269.1597363632216;
        Thu, 13 Aug 2020 17:07:12 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:11 -0700 (PDT)
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
Subject: [PATCH v5 10/36] PM / devfreq: tegra20: Silence deferred probe error
Date:   Fri, 14 Aug 2020 03:05:55 +0300
Message-Id: <20200814000621.8415-11-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra EMC driver was turned into a regular kernel driver, it also could
be compiled as a loadable kernel module now. Hence EMC clock isn't
guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER and
there is no good reason to spam KMSG with a error about missing EMC clock
in this case, so let's silence the deferred probe error.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index ff82bac9ee4e..6469dc69c5e0 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -141,9 +141,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	/* EMC is a system-critical clock that is always enabled */
 	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(tegra->emc_clock)) {
-		err = PTR_ERR(tegra->emc_clock);
-		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
+	err = PTR_ERR_OR_ZERO(tegra->emc_clock);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get emc clock: %d\n",
+				err);
 		return err;
 	}
 
-- 
2.27.0

