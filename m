Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30A53FC913
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhHaN6G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhHaN57 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:57:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E4C061575;
        Tue, 31 Aug 2021 06:57:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q21so31912137ljj.6;
        Tue, 31 Aug 2021 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wojn7XneOlcjLQTZlMLpcmbGjIOEPaqexo+f2WGyphI=;
        b=qVsfZiyMnP/5jTRQoTxF8dWulzxsSz94iH5tlFNvaAII+VNdg99R2f+8EvePPIchr9
         3ywfK1DPyQcya2uCzEeS5a/YcPsGvQJ67NRGMwUvUWSBFa4Mfd8cjmufzpjdVx86LXhx
         c0qVUwC+5FSifqSa8tIYTbx/PVEQtZ5GER1m63etxy6oiWpHoll47BeO3uEPo73sH1NO
         Rqr76tF7ykOUhOPcGW7RTeWtY1jSjMXx9+9vxF4P5/gvTNPgexO34XwXj+g54oQ7qhSw
         dFnv1iBzDgb+jWRGO3dRzTDiRSWoEsIITlgj67SiuG4FQWTQ2djRmoetBsTqwctmuV2B
         VT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wojn7XneOlcjLQTZlMLpcmbGjIOEPaqexo+f2WGyphI=;
        b=UW0hcFO7CEf0K5LT32MfMa10RJjxZXtLJlxwO1DqVb686UKw6CeltJYrKDmP+d0cRQ
         7g5OgFT/rdntpBujuE5xxWMTybkDLv5Cz3MSxZY0j4K/vW4mxWbJ3whIIjpEyFgStRIQ
         fYH/YwwjgPBLtUPpy5FnRc2niMczRGWWXhE43bxzT0fAXCH7Q7fIr3LjYIQW/svyBOrI
         OaYEtNpKmyHX5fq8/O2KgO5/v41+VasX+8vDma0lWSfRXhew97OudNN2Eqb/xEgiA1sD
         K08bYP4gI/rYStJQphGjGncZQGth/8kOkyPvmQeNRWGKRmL5RA3SScfysDkPHbdIHLYD
         OYNg==
X-Gm-Message-State: AOAM53239xRa0Hu5UlDBVwaWKygJY5luqaH2GWrTaPf0FMui7chPZg5r
        9t7i20QaUNyoqW/mVwiwD/4=
X-Google-Smtp-Source: ABdhPJwPfoUBTBafkRF0UF0+sV9ZaSTJMquVbN7nqg6nVS6mcP8N12osVFg3TeM3zfO9rR3ZtbNHrQ==
X-Received: by 2002:a2e:7801:: with SMTP id t1mr25099487ljc.192.1630418222483;
        Tue, 31 Aug 2021 06:57:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.gmail.com with ESMTPSA id x4sm2203622ljm.98.2021.08.31.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:57:02 -0700 (PDT)
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
Subject: [PATCH v10 6/8] soc/tegra: Add devm_tegra_core_dev_init_opp_table_simple()
Date:   Tue, 31 Aug 2021 16:54:48 +0300
Message-Id: <20210831135450.26070-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210831135450.26070-1-digetx@gmail.com>
References: <20210831135450.26070-1-digetx@gmail.com>
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

