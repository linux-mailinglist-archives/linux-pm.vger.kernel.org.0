Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582193F91FE
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 03:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbhH0Biq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 21:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbhH0Bip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 21:38:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F1C061757;
        Thu, 26 Aug 2021 18:37:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y6so8631631lje.2;
        Thu, 26 Aug 2021 18:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmw1NjVNkpP7NqLr3IrTml5TZjd9yVvykZlNgPqPXvQ=;
        b=B7aNfhGHYkW+4kIqxwKdlN1glZOBe/7jv6YBqK+4VfWxusVRII7BlJGJyXRBkTsOt9
         YcKYQ9Eouel0mo8vhrAfNyzZL+DJ4SZnkHQh1ZBcrh1qXnhN+WMC7lQBMblhOycPg47s
         EXnKGPN1kv/JbGXjmvoFRw9BpxorTV1D+puhudKzwrYW9hOkvSDazeiXkGKST0G4zhFY
         IC+c8oiCwRUTXvdGQw8rbJDeRSFwvLZ4/Gytu355gbP+VFSaetGckflL5cVhw6l/+tHF
         UBqG6QJUp+MocC67YVwMffo8UOjQShUJITsKP6tGpfdkNt8pODuOoo2ikMVyUfFFCq5k
         FKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmw1NjVNkpP7NqLr3IrTml5TZjd9yVvykZlNgPqPXvQ=;
        b=tWOkO7AFG9frM1/R5g2ilsuM9pwunT/1dvKTYiUYwAvPMbtTsep/6G3uQ8xfuoC53w
         mpm2hPf021fTB3t51+RbWblm9351f3ujpt1x6vG86m7zofB+0ljoqotrqruEGAOQjbcr
         3NAA9sKKFzQg3IFe2+Ire+P6VFTzpl/y9r/vDdD3R9BomvDy43mdwpSr4FwljMOJvANV
         agt1GNdAWZLNqHzItQBMM+g8oAKe+E7BL8lc6O4P+lH41g211ynyAlSWedMKjfdi6E9F
         GFhWo3/uvA4W4CBCjaqmJZAbwS+je6pZ3Ik/c9B/Xf/QuwFkm1astVUfR5GkQvH0n7+j
         kokQ==
X-Gm-Message-State: AOAM532eZKpLNOP/aQ6PmcDfNL6SpceyreemTlP03RdWou8jOCouvPum
        7sCEHj9M4icqW2SzbJuaHor4S3IpFUM=
X-Google-Smtp-Source: ABdhPJwMdiBcu7ZSV3W3dcoo17qLFpqwgY1EWldAPUJ9duCatbHWStPDFLiFH2PMh6Jfp8gU5ei6zw==
X-Received: by 2002:a05:651c:10a3:: with SMTP id k3mr5459561ljn.471.1630028275886;
        Thu, 26 Aug 2021 18:37:55 -0700 (PDT)
Received: from localhost.localdomain (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.gmail.com with ESMTPSA id y3sm494289lfa.240.2021.08.26.18.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:37:55 -0700 (PDT)
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
Subject: [PATCH v9 2/8] opp: Allow dev_pm_opp_set_clkname() to replace released clock
Date:   Fri, 27 Aug 2021 04:34:09 +0300
Message-Id: <20210827013415.24027-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827013415.24027-1-digetx@gmail.com>
References: <20210827013415.24027-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The opp_table->clk is set to error once clock is released by
dev_pm_opp_put_clkname(). This doesn't allow to set clock again,
until OPP table is re-created from scratch. Check opp_table->clk for
both NULL and ERR_PTR to allow clock replacement. This is needed now
by NVIDIA Tegra 3d driver for initializing performance state of multiple
power domains, where PD driver sets and unsets OPP table clock while OPP
table reference is held outside of PD.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fae5267f5218..e26da1d4d6be 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2136,7 +2136,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	}
 
 	/* clk shouldn't be initialized at this point */
-	if (WARN_ON(opp_table->clk)) {
+	if (WARN_ON(!IS_ERR_OR_NULL(opp_table->clk))) {
 		ret = -EBUSY;
 		goto err;
 	}
-- 
2.32.0

