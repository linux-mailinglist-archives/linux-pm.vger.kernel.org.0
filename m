Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93311F3BF1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgFINRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgFINOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3064C03E97C;
        Tue,  9 Jun 2020 06:14:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so24988181ljc.8;
        Tue, 09 Jun 2020 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmHb/qTFiuR6DXvA/ffC/nHLs0yGE7r571S6zKct1lc=;
        b=SEopFD6WA6X0oE0yMZuxwxvYBQFHQJCCJua3OwUoX/QqrQlqZ3M+GzRG9yCFrFseZP
         KZ+VpLlPociuyizoUcEgoYDc2D/f2f8RlMbG1zK/GokjMg4umvEjcEmwl8hkk4TLK6IM
         tF61xjPihOqkZaHBYYLssFhno8KgX92dIUtIiLfVbo7+JTImobm6iXLX6gfB3RtJ5DyG
         XKkEb75lI/cBFh6PztCCh/B2uQerDExyOHECRoi7sA+VgHSYD7KRAvCeDqt0GOgOcVFJ
         6NtBgNT9LVFusNmYz3wZSuJN11UhTRhKjbre8gvBXoW09blWoxZd16ni/P2Vt7/5xtgS
         eQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmHb/qTFiuR6DXvA/ffC/nHLs0yGE7r571S6zKct1lc=;
        b=enai5aiH/umStV/4nIXur0XZZ9zZZNy4nVnmXSNnOcu6ED0VSObU6m49KHr6wUnnRO
         7f8o0R0qhYtR4bx7ubcdnRrIw2+KfV3bjBwpGTYPOorrlfiWWTRJv/fGzUaIPPiNw2e0
         Ab0aT1X/p4Jw+W07WoQ1mvsMw3FPlhyborGsLHJdI0kv/6k6wwv6Q31Qf8gAqolw4CdR
         4zNpqf7DeCtmlNjnOfjNkK2+B8Z9W0o0k6eLklkfE9DGKUsMxZUj3IyZwUwIlU5FWxRh
         Mv9C4mTGGu41BV8pqYCCLH9SOC3chfYvv4Wm3d+mGleE3BsXmOBRSNC8r92BOxfS1XSv
         WpCg==
X-Gm-Message-State: AOAM531s+pa3ppgtUltTW/2dKlxHrAmj7ZsfiVIM7GYunfbcOMZIgxys
        e/ObTY2QUHnQQ6wO8tm8Y6A=
X-Google-Smtp-Source: ABdhPJyyEojgVqUPpi4CNo4lhcaSGa8eRgXbgLQjT8AsOnF95049pCzOGKyIKTvZUwaIiCa8veiYMQ==
X-Received: by 2002:a2e:9f57:: with SMTP id v23mr11785142ljk.324.1591708482389;
        Tue, 09 Jun 2020 06:14:42 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:41 -0700 (PDT)
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
Subject: [PATCH v4 14/37] PM / devfreq: tegra20: Add error messages to tegra_devfreq_target()
Date:   Tue,  9 Jun 2020 16:13:41 +0300
Message-Id: <20200609131404.17523-15-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to now when something goes wrong instead of failing silently,
so let's add error messages to tegra_devfreq_target() to prevent situation
where it fails silently.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index bf504ca4dea2..249d0dc44f6c 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -44,19 +44,25 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(opp))
+	if (IS_ERR(opp)) {
+		dev_err(dev, "failed to find opp for %lu Hz\n", *freq);
 		return PTR_ERR(opp);
+	}
 
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
 	err = clk_set_min_rate(tegra->emc_clock, rate);
-	if (err)
+	if (err) {
+		dev_err(dev, "failed to set min rate: %d\n", err);
 		return err;
+	}
 
 	err = clk_set_rate(tegra->emc_clock, 0);
-	if (err)
+	if (err) {
+		dev_err(dev, "failed to set rate: %d\n", err);
 		goto restore_min_rate;
+	}
 
 	return 0;
 
-- 
2.26.0

