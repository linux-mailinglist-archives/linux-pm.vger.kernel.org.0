Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0523B9900
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGAXbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhGAXbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA77C061764;
        Thu,  1 Jul 2021 16:28:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u20so10739354ljo.12;
        Thu, 01 Jul 2021 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rjt72BrK6zM3ojSq5raXIazBYQfzGXAb+ry7eKtvkM=;
        b=Z3kIPHE8uHdC7RoITeyonHoeWs+0fBCqtYcAx/hFHCee05ngXRrYULOxgNpx/qufYH
         Ka8IjizoSNgsDz0K+GP3eSeJXo6DsMIe1CHZ6hM3OWtJVqJPSEoMipowduNEdBeYDGsW
         UPtcbBSOUl/p4T4xv0GimyQtEvgp7l9ADs6KOTsEXUJRd/rJbAqlBxMfa30yuTt/4z+t
         5YR9eps0EoJFlPeuxzCOnTAGLtm0UOG2lB0TAPBPYALbKFgwrge0Z8xtAWhIhF0DSKBm
         2cgR0OZcZcprGBl5QV4tcyoDYIvHWqZdHYlVfJUNAmSfYsyV5Ou+Bt/iTfEXWP4qPgDC
         TgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rjt72BrK6zM3ojSq5raXIazBYQfzGXAb+ry7eKtvkM=;
        b=dUAc6gtbcDbQ1xMLaxBEjxqw2orq//UGw+xMboxMABpt/OMB0LnOKxPyC5RousxTbw
         bIcrKOCZtg2OSdol/+OrW88hZN8oKkPy6DFNEiqt8nLAHLe+uU3C/+KJTbvdDqvIEXLw
         9A3iItIxcfKKGDuLT50ODUaNRCqUKI7W3W3OmnroAJFSSCXIqaqxiLSsn9YWRX+3N3Du
         uvu37rqhpJk0C9L495bjGm3EsY/PR1rTtp11XPU3vBC8FuJ6j6reqJcuv52F1nfiSKvs
         opk6QXJn8bkbaSx2/bbB+VK7oS1ZCijk04IOwy1V5AB6cRuXF71qXgxaOz2yXse1t4se
         GG0w==
X-Gm-Message-State: AOAM53100935kp9963FOSC+XWwBv1IcpL73cc/PZNqlAjkmK9mkOx2rQ
        k1zXsTQkPkIn1GMHx+lLGpM=
X-Google-Smtp-Source: ABdhPJylSTpB9cCgB2CTj1z4ymkAq7CXVLq3yIKc7gqoUzqHlLeJlcI0UmHa6sxwMUKXjyvwwed6jg==
X-Received: by 2002:a2e:581a:: with SMTP id m26mr765247ljb.86.1625182111685;
        Thu, 01 Jul 2021 16:28:31 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 04/37] soc/tegra: Add devm_tegra_core_dev_init_opp_table_simple()
Date:   Fri,  2 Jul 2021 02:26:55 +0300
Message-Id: <20210701232728.23591-5-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
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
2.30.2

