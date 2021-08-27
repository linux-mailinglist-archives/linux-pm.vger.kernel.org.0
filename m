Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D93F9208
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbhH0Biv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243995AbhH0Bis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BDC0613C1;
        Thu, 26 Aug 2021 18:38:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k5so10983600lfu.4;
        Thu, 26 Aug 2021 18:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wojn7XneOlcjLQTZlMLpcmbGjIOEPaqexo+f2WGyphI=;
        b=W4t2zOOZ4bZ2nNmRLYHaIk0yWkLh0KpnagD0BRiVC5AJl+KIIBErft9jS5wIR8DJvw
         5xdJjLwl1FiUSDBedDQlSLsw9jyARpLueKQCgzzMBJEhGr7Hd1UK4rAJfZ3+NOLIMefa
         8myCxZLQsEibMK0HaaopurA22BdjKNTHH0dtI43MX6NXTiH+0BtHdfNWEVS0TH680Lm9
         aAyjuD+l5L/4aUaiYwhuLoi8MAUpveqLtkbVQg5PuLDtunbaIlNdOB9I1pAwWZL/BFcJ
         OJZaglrZzrQNvS6oZ6UFaNmaqVkdutN8BmXF57y/2snistU8mgChNC2H7QeGN7JV08Dd
         ZDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wojn7XneOlcjLQTZlMLpcmbGjIOEPaqexo+f2WGyphI=;
        b=hN2fZYFwB43lzV8kt9WUScNCRwM5aQ5rCihxgBsGWT0dsL5Vgw8fc+BI8QzwyXvor3
         iiaYsE3wW1hxhdiTho6MGDb2V1q9GH7Jn9Ufy/1SI6WbuTOQNHi7vCHtIOwYdwvbI7kZ
         yxBu+TCXyP6L3ZdSoaBMERIcyEC6+D+rwr1kpDUw9Cem2642a5jHk6gaGemeZ9WzcBlp
         3CmmGdsovA4urb0zf4jIu83do/B+Xp1TwRcTILPWCloU7GjUrHYN4WbFBBchK3TrxinE
         xT9e3ewsCOtX3iARx/jcGFAj+dafjhXXIw3Qk4eBHy6utK8OYx6cYyoXOUeMDOdOZFxH
         KAZA==
X-Gm-Message-State: AOAM530d8NJ1EBhuNI/5CNFWuHzfG5uQNjDHwTBYh/sfmwWqu/54d/Jj
        1ClXHuGxOrrVNIJFULNFf30=
X-Google-Smtp-Source: ABdhPJx7BqHfE2QMOV8/kXdvghiTk5xjFtAOhoMnk+4WU2vz2K/eKwpaUjfn4YsA8JDMT+FgZYFrhA==
X-Received: by 2002:ac2:4146:: with SMTP id c6mr5235184lfi.305.1630028278659;
        Thu, 26 Aug 2021 18:37:58 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v9 6/8] soc/tegra: Add devm_tegra_core_dev_init_opp_table_simple()
Date:   Fri, 27 Aug 2021 04:34:13 +0300
Message-Id: <20210827013415.24027-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827013415.24027-1-digetx@gmail.com>
References: <20210827013415.24027-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Only couple drivers need to get the -ENODEV error code and explicitly
initialize the performance state. Add new helper that allows to avoid
the extra boilerplate code in majority of drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/common.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index af41ad80ec21..265ad90e45a2 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -39,4 +39,17 @@ devm_tegra_core_dev_init_opp_table(struct device *dev,
 }
 #endif
 
+static inline int
+devm_tegra_core_dev_init_opp_table_simple(struct device *dev)
+{
+	struct tegra_core_opp_params params = {};
+	int err;
+
+	err = devm_tegra_core_dev_init_opp_table(dev, &params);
+	if (err != -ENODEV)
+		return err;
+
+	return 0;
+}
+
 #endif /* __SOC_TEGRA_COMMON_H__ */
-- 
2.32.0

