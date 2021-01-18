Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877C62F96EB
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 01:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbhARA4Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 19:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbhARA4S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:56:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463BC061575;
        Sun, 17 Jan 2021 16:55:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so21663619lfr.3;
        Sun, 17 Jan 2021 16:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rAaB+AsgYLTzk06vBkAuHfvf1ltC1dHjM1bYPxIHb7s=;
        b=J8mEDAPD0EcjLZcMHcAbJjC9hcLy2rm3SN4E+ax3mPVISyzsIvu2oyAzOXKm+OsYsR
         xlDG8twVdSdGLBsJiNT7uZajZpf587v+kNzZLHB9tvKO6/WRp4DQGIwArMIdPo6QUdMV
         2SCzwCcA5MTFmI5moEAfwhi1XBcJTFCfLdBh4K8Sk+gccojEoqtNmfbBQB3/Pnb+c45T
         THHS0M8lZMUxc64y+gDzpUpE85XH+WRsvev62fe2JiXOBPLzSaAtXUXcZLfROF2GUgh6
         Eaoj9kwThdJzSS7N39fznjc4eZhqKY/Uogu4SkqjPP6fs83Fwxyj5XI8EZK98SmlIylW
         GDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rAaB+AsgYLTzk06vBkAuHfvf1ltC1dHjM1bYPxIHb7s=;
        b=g0Kzq3kWOUQH4buMYazb9GcgcRhtg8/gxEe5thz/8wazTuvOd8pbcKr6UeR7YTBDQa
         1S6L5NeJDjXsjdwgFXenq6RkbM4HjeSWjp7mVwZkMHdP9dM/DXc+B3Zwq60q5p+312wi
         fbcOlYUQz78NH6IIUfu/zHMZ3M4DA2hJ0pZbwKXL5+y6mmK76XAC66YIuHNNkdJEVe34
         DSaZs0UgkGGHR5Nnawm56DyblglyilSPXRNJAAJ4d//nbVs9kAQcaViTfnEQBnq6ldfP
         dfkt7o9PrbJu2ozHnNzyUqZF3Fujdj4r3ZhjfYwiX+aDA0t16CN66iEBMal5IGGQt6I8
         u1zQ==
X-Gm-Message-State: AOAM531Rdtbi2nWf3gQVjcHoFCADnXzuozzhFTqGnjV3HClBVrCT9h34
        ofiWYKZp7QAmkNKX9mepSJs=
X-Google-Smtp-Source: ABdhPJw12X/R94f7RMUuVxwu0L5qc00LFbojuOSNdaocbFYaM6tX343QCGjKtw2Pd3f4sYOjm5O9Jw==
X-Received: by 2002:a19:c001:: with SMTP id q1mr9766157lff.55.1610931336835;
        Sun, 17 Jan 2021 16:55:36 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:36 -0800 (PST)
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
Subject: [PATCH v3 02/12] opp: Filter out OPPs based on availability of a required-OPP
Date:   Mon, 18 Jan 2021 03:55:14 +0300
Message-Id: <20210118005524.27787-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A required OPP may not be available, and thus, all OPPs which are using
this required OPP should be unavailable too.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 48618ff3e99e..7b4d07279638 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1522,6 +1522,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	     struct opp_table *opp_table, bool rate_not_available)
 {
 	struct list_head *head;
+	unsigned int i;
 	int ret;
 
 	mutex_lock(&opp_table->lock);
@@ -1547,6 +1548,16 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 			 __func__, new_opp->rate);
 	}
 
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		if (new_opp->required_opps[i]->available)
+			continue;
+
+		new_opp->available = false;
+		dev_warn(dev, "%s: OPP not supported by required OPP %pOF (%lu)\n",
+			 __func__, new_opp->required_opps[i]->np, new_opp->rate);
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.29.2

