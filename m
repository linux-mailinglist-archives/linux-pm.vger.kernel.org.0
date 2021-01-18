Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41EF2F96F6
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 01:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbhARA4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 19:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbhARA4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:56:19 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42253C061757;
        Sun, 17 Jan 2021 16:55:39 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id n8so7709970ljg.3;
        Sun, 17 Jan 2021 16:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWDHn2kHepqBlhfwoh/fWAV+Z/o0dseWB+wQwSbUTtY=;
        b=mzEe1X1FOiyM2KN66Sqw8MM4IaAXnqe/GZ80PpC1BblpLlCv2w4uE5Mb/pMIIGoh3P
         BXqvFO9fuGnLsxJuwyFmtyHbekfZbeRTw4C24K4tp0LUcQXo4UZByKtdlf3unsj/LcLq
         Y7QPHiMyGihaWZJn/MmNAArw8Ej9PH02ZvD0vFxqyaPAx7FO/5UtlhXJGG9+GhbG8Y2Z
         s4IVr9huD7p0gBcPt6HwQZBQ8rTzefpi/xtzCOA5o5BbHGbHJhMFPMmRcpVyruLq5Chb
         IeSJSwpQ89/PRIRjzPY1BcnM/ZRkGaiIAVV3+Nakj8WTuXv2bAe3W7v7FuvicN2k95k6
         8ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWDHn2kHepqBlhfwoh/fWAV+Z/o0dseWB+wQwSbUTtY=;
        b=HFplaadYI4fy9SNYIjlz+P8/o2Yxq4iOPof2dwxFh0q6feTcryzbXWqCxXBPRR5Pgs
         YiSV3Cb1Ivv3vNgNdeKKzdp0L15y0gJrWDIs5KdgXNjBaAeSuV6wgJjr9p+jOZbZmsPt
         OLHVTZLzGhTlKQI/vWGxg/phXwxwUr/GIL67XPwpKlrhlAwPvVS7raawOskUGkWg/Oz+
         SssLLuiTnJMKxkDJd0GI6jX0ThQ52bV2db6SJKzgV4WbK1kdih35hNtRDU/DG8MAuNTH
         rYXuVg9Lje2J7duvtnAAhxXXO/DLUQoWyVE/EP2x/atnUr8qYZUTohrwsByr6GFFpYQ/
         MFLg==
X-Gm-Message-State: AOAM532qWQ8ecgV3uuXu5dHa1OcYfH32pJ3LQR1Owqi0CvMAAeUmvFSz
        QSxeSwQRobV+S070eQlG2OU=
X-Google-Smtp-Source: ABdhPJy+hz3BIUUk1wNYjcQ0h/81YCFl5L/xhHLYcQJRmIeC49DpfG8263aOYLk7r+GHlmSiKHkxTg==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr9014741ljo.152.1610931337792;
        Sun, 17 Jan 2021 16:55:37 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 03/12] opp: Correct debug message in _opp_add_static_v2()
Date:   Mon, 18 Jan 2021 03:55:15 +0300
Message-Id: <20210118005524.27787-4-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The debug message always prints rate=0 instead of a proper value, fix it.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 50df483c7dc3..63b16cdba5ea 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -755,7 +755,6 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		struct device *dev, struct device_node *np)
 {
 	struct dev_pm_opp *new_opp;
-	u64 rate = 0;
 	u32 val;
 	int ret;
 	bool rate_not_available = false;
@@ -772,7 +771,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
 	if (!_opp_is_supported(dev, opp_table, np)) {
-		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
+		dev_dbg(dev, "OPP not supported by hardware: %lu\n",
+			new_opp->rate);
 		goto free_opp;
 	}
 
-- 
2.29.2

