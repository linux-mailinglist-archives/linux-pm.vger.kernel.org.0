Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D483FC901
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhHaN55 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhHaN54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 09:57:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE59C061575;
        Tue, 31 Aug 2021 06:57:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g14so3788389ljk.5;
        Tue, 31 Aug 2021 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0/cqGavEHwgsYtk4vTJO+BDi1z8O7toXfeYU/faT8s=;
        b=fhwxuRbSDKX/TZ2i6TzSrxfeiG763DDq9XWavBnavi1jgPfM7KavrpOghI7hIPNTiL
         ZDzwm6WBycm5e4C4tltQ3ofeWPSMqphDZkTKHxkRSV8xmsdaU6a8nxbR4Q8ZwYA4Xj6L
         CREmgJ4ERebr3FOduMDSNkl5vjvTJjL/KScW2KeqkjAo7g7YIoep3Ew5cq9WfQm3zi0n
         xCjdHrXU3sEzQM8J9UbcTsfGztvi31HE/pC0sqkHZyKhCYc5XrybVCGWysQZihUst7TW
         KoH3A95F4IZrQrazVIzNBRuix99RbIKOMtjOpao0OLPsygMyI0H9eP/5w7YfO+/fBBbd
         lzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0/cqGavEHwgsYtk4vTJO+BDi1z8O7toXfeYU/faT8s=;
        b=MiSJzC4nX3OxHL7e5JbBnClUpctwczOEjnVrSYRi+tb17OwZtNi4NVLd2lWlZbdiab
         Deo3b5uEbyFC/D4D7zWgDnjbOMu2YdRKx2sQj8XIcwmo3IcwSFp6oW+WZm1T9m+ysbxR
         sgH4vpY2Sm/iHotnjexQUciZDRxu8qU1auDNG2paJWIkGPSHgXXVIJrM/UqvB9dt3b44
         8DzvvNVpmFdvR7nj0g9njvGuoUTYx58GPLDGSYekLx5cCwJpv0R9YNdzf1IwANh5noNh
         uPuyXzoUQ925S64mLG2vO7Qd7HBOkkFzEI8f0Ll584rSynQF8XzA0nqUlSCAr0gVOLLY
         Soow==
X-Gm-Message-State: AOAM5331hTddZ7fHaKmxag+ySLKGrciIo3XhAw8dA65QRhqFBQx7mNtF
        VSvgGKUK2FctUuUXuC/O8Gc=
X-Google-Smtp-Source: ABdhPJymsO0TUupAbW3s5AjqlceExa694368OtSMKsTx+2Ovkae7LbJU2Gn+zzlQcybuJZV6cdMvmw==
X-Received: by 2002:a2e:8881:: with SMTP id k1mr25360627lji.443.1630418219389;
        Tue, 31 Aug 2021 06:56:59 -0700 (PDT)
Received: from localhost.localdomain (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.gmail.com with ESMTPSA id x4sm2203622ljm.98.2021.08.31.06.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:56:59 -0700 (PDT)
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
Subject: [PATCH v10 2/8] opp: Allow dev_pm_opp_set_clkname() to replace released clock
Date:   Tue, 31 Aug 2021 16:54:44 +0300
Message-Id: <20210831135450.26070-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210831135450.26070-1-digetx@gmail.com>
References: <20210831135450.26070-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The opp_table->clk is set to error once clock is released by
dev_pm_opp_put_clkname(). This doesn't allow to set clock again,
until OPP table is re-created from scratch. Check opp_table->clk
for both NULL and ERR_PTR to allow the clock's replacement.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index dde8a5cc948c..602e502d092e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2146,7 +2146,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	}
 
 	/* clk shouldn't be initialized at this point */
-	if (WARN_ON(opp_table->clk)) {
+	if (WARN_ON(!IS_ERR_OR_NULL(opp_table->clk))) {
 		ret = -EBUSY;
 		goto err;
 	}
-- 
2.32.0

