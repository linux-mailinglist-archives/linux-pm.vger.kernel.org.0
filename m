Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642801F3C13
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgFINSG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgFINOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ACBC08C5C5;
        Tue,  9 Jun 2020 06:14:40 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d7so12448130lfi.12;
        Tue, 09 Jun 2020 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psA+m6s/YQ71wfUHabJ5pnZ0YjIiMWnkB+97bmL+R4g=;
        b=fqZ0bjYiV00boOxgS6onhvxlQ9S9CyK3l7dXy0+pQya1ipNEALmG2AE+b0GtFfTX0E
         vBjEsRnSHwVAdypxjN9AQ2RE4tkQZ0t+9Hf3LaX9zHdNqdEe1Qg1A/U2ia5X0z6CcRGi
         t0J+k/aYVe6Txy1mcz9mZWMRvJePE5u3/N7uCD4keohE5idEl7dR/6UzGLoOYPglryhL
         wkGjmcYEZKZc8ooE6EYKNJe1/Kpg1wIVDBWoOTPec9spYFSBMXwBElXLXFDP7fRDLtTr
         q7piTUsA/Wc5Fp/zWhFf9Ysp/qLz0okGyK9WdMN6ZXG5+iG3Bhm44n25wTIvyX0f69GI
         7Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psA+m6s/YQ71wfUHabJ5pnZ0YjIiMWnkB+97bmL+R4g=;
        b=jJH9BnKv4g+Z3HYeZD27IMd697N10vR8aflgtMfPE1Vr7PHlrTSclrOVwn1khdZRRd
         Z3ZigveK3nfF9gb8VVJNWXcC9TS3DdfhT2S5tExUcLbvh8Ii9HNaOjphmNQbJuJpRetH
         kYdwEMPY1ZXS4mTlgKV6PXq8Q9Xv05dZylRhPAqjBav8YXTFBYlR+C4qfSyPyRjuEgJV
         yb/VTsHOLOWfl4nlo0uoIhcZNo0mlgOYN2XZlXJO4AFyKZJYM0wd0pQ1d5QoOLqieCqF
         OVJIzCtu1297VMAFVaJbiqIDbh/PBcf/5pJptFObN5cHJIJKhkEGbcE6Gcg7YzkssRQp
         1txw==
X-Gm-Message-State: AOAM533e7OidFP7c8m19TSeVh1sSbivn4Sj8ngKQ387x9J7sKsnRYV49
        INaVPVNIoLZ0PEly8e3h/ac=
X-Google-Smtp-Source: ABdhPJw/wnzx53uI16yvdGqHv0RalaBGuElHs69YM/FEdoHZHRzNhx+369sS1v+B+hNO8kRF0AeYRw==
X-Received: by 2002:a19:f813:: with SMTP id a19mr15271550lff.212.1591708478731;
        Tue, 09 Jun 2020 06:14:38 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:38 -0700 (PDT)
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
Subject: [PATCH v4 11/37] PM / devfreq: tegra30: Silence deferred probe error
Date:   Tue,  9 Jun 2020 16:13:38 +0300
Message-Id: <20200609131404.17523-12-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e94a27804c20..423dd35c95b3 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -801,9 +801,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(tegra->emc_clock)) {
-		dev_err(&pdev->dev, "Failed to get emc clock\n");
-		return PTR_ERR(tegra->emc_clock);
+	err = PTR_ERR_OR_ZERO(tegra->emc_clock);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get emc clock: %d\n",
+				err);
+		return err;
 	}
 
 	err = platform_get_irq(pdev, 0);
-- 
2.26.0

