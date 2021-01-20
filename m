Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30832FC745
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 02:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbhATB54 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 20:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbhATBvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 20:51:37 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49220C061575;
        Tue, 19 Jan 2021 17:50:57 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u11so24156794ljo.13;
        Tue, 19 Jan 2021 17:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybcPr1W3M4zWRH/hwFZaxAvSfw+Gc9d6ovp3laSwDH4=;
        b=h3NWcY2gyn6aWdF7c0CY5VtTcvP58xqEnCnQU05TXtCUOsSIq3frqt9BDynCuYAYsG
         fjzB1TIYAX9tE5e69lNzQMsA4RL9FYuXTIMMcSSf9ynqg5DTZz6kDxMzQOc4K4kSHSLV
         3jQ0/4FnglqMzK70jzOgG080bjMHfT7ffjyfU44dYWpzpGTEkPcEc9ptUSIswGF6VLZ1
         kSh5A596bHTvrif3QlgwjjTDr8gDbeuhgsEBIFnyk8JPDeHaSMeYs+BhyRYcF7OPJxB+
         urra11Og+l5o86L7f8iMcXU7+K1hJaO+8N2dnJ/8u5FNjCyPKOVAh/Os7iW+l6H14PTI
         xGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybcPr1W3M4zWRH/hwFZaxAvSfw+Gc9d6ovp3laSwDH4=;
        b=guS7giq3xANOifGYXSFus1HncoFJH76PSQf0mmT+SyPhNO6tZcdFofmQv7GD8YjKvb
         EHKhMh0C1QkIslC6TeAaf/7iEnk43PU9CQv1P/FkfDxCN9N/6IgsYn0aPwpF2asYDSAz
         12IE6Y5OkkP18LduZgG0pLdtys+Flm4aOz2b4SXPwxXNJsb0lBaJzoMHh/SgFyIxGJ/u
         Kj1E5YToQZxJFwoSvOT7/UK+Lts7kqoBQgus3gFrhqd3p5NAc8OmXrQApv+97QwKuAcN
         0vgidhpyxyWP8zG5R9fv9GfvttpkQ6E3eCAeHhsU09oET5QOJq76WmODlx57gCVjsEoM
         NSHw==
X-Gm-Message-State: AOAM531ctjUrGMG+kRmbjoYaB6DSb6vk1jDQwG8zPZeophBwdUK6+0op
        IJeNjfgtfNv/NiZCEPraalE=
X-Google-Smtp-Source: ABdhPJxpaR3X7eLcrmcRa7Kuigbz4QgkpPiGYAJSMBuIQVhwyJJOodVwzQaNGnIzl140AIFoNAnbuA==
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr3180904ljm.507.1611107455786;
        Tue, 19 Jan 2021 17:50:55 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id o14sm56163lfi.92.2021.01.19.17.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:50:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 2/3] PM: domains: Make of_genpd_add_subdomain() to return -EPROBE_DEFER
Date:   Wed, 20 Jan 2021 04:50:09 +0300
Message-Id: <20210120015010.14191-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120015010.14191-1-digetx@gmail.com>
References: <20210120015010.14191-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Driver of a power domain provider may not be ready at the time of
of_genpd_add_subdomain() invocation. Make this function to return
-EPROBE_DEFER instead of -ENOENT in order to remove a need from
power domain drivers to handle the error code specially.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
[tested on NVIDIA Tegra20/30/124 SoCs]
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0bd0cdc30393..def1299ad085 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2466,7 +2466,7 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 out:
 	mutex_unlock(&gpd_list_lock);
 
-	return ret;
+	return ret == -ENOENT ? -EPROBE_DEFER : ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
-- 
2.29.2

