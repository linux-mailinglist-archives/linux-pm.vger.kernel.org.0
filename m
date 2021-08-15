Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED52D3ECA44
	for <lists+linux-pm@lfdr.de>; Sun, 15 Aug 2021 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhHOQpK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Aug 2021 12:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHOQpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Aug 2021 12:45:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F303AC061764;
        Sun, 15 Aug 2021 09:44:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h17so23542987ljh.13;
        Sun, 15 Aug 2021 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wwUsxLg/WYVWZRouSC9RVU7s5eN3R0tYr25LfLFM90=;
        b=krHN11ptUcTM0bSyeL3R7FBs+/rji6khsY6D5GcUX2zGvF/Fb46yNQksf3mnTuREmm
         HjZ/En8LaZwEdKaOVyjDYDsRl+adOJbP/CbtMK+JAKs81GkfliCmOMNJN7DxJgB5UmaK
         bhBh7geOM4pXG4Un3nHABZppqdodYjXostI9/JE8AXcYfl2PsOBxFp08rJZpD+AGGeO9
         MjULIuMP3l/oODb2SZprtzUodaG76wY5hb5S8mY9KEYBgJX29GAQn1Kzk8mqJDI6TmVg
         INm/KR+zizLye6Luj1wTvo/c5KYzlg5fsR+H9C/PGvy0tWwacMEyJH3/7szEegjh6NbN
         u03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wwUsxLg/WYVWZRouSC9RVU7s5eN3R0tYr25LfLFM90=;
        b=a8U0cpDGi1rSLS88uJhnzAWmMQwN5VqBdW4/4SvPMlTiyy3pCsZIKpKR8jaS9PABJp
         ETVf7FjyS/aKqaqciPTv4Wx1h0p+SQjgdjKE0y/v+JlKprRS9FnM/tyutuktNOER5afe
         SKtkN1tzAhjIPXCY6OpW166Rsj8o7zHsO9fCc4RUUE3039zJhxbFaIwrzQpcdyURHRpI
         xlrXExQS00uhqD8bMHjd39LN6LPGwxAXrCjEvzUYzp3GNZrMZ9X3cH1Esw8N5YP4UR2I
         uFyuVlAD19/oBvaUypfp5DFId7ljwIbvGIWCI0X1xzQh0na5CmbMJ1VfN8E9bBztmNrH
         6vkg==
X-Gm-Message-State: AOAM531vLhAw+VDR6Q0CXsW15rczpTjf3C76yYsChwMg7+Jgbpa6YMa2
        iORXFZzv3Iw5CCFg7CTagXs=
X-Google-Smtp-Source: ABdhPJx43RlHuMFPhM62A7GycFIUk5ABVI3QoY2wgw3sQjDqHBEJQSYoUveLtCh7vmU93g5BkQw2Cg==
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr9519683ljk.502.1629045878183;
        Sun, 15 Aug 2021 09:44:38 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id n7sm584907lfu.95.2021.08.15.09.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 09:44:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1] opp: Drop empty-table checks from _put functions
Date:   Sun, 15 Aug 2021 19:43:44 +0300
Message-Id: <20210815164344.7796-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current_opp is released only when whole OPP table is released,
otherwise it's only marked as removed by dev_pm_opp_remove_table().
Functions like dev_pm_opp_put_clkname() and dev_pm_opp_put_supported_hw()
are checking whether OPP table is empty and it's not if current_opp is
set since it holds the refcount of OPP, this produces a noisy warning
from these functions about busy OPP table. Remove the checks to fix it.

Cc: stable@vger.kernel.org
Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b335c077f215..5543c54dacc5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1856,9 +1856,6 @@ void dev_pm_opp_put_supported_hw(struct opp_table *opp_table)
 	if (unlikely(!opp_table))
 		return;
 
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	kfree(opp_table->supported_hw);
 	opp_table->supported_hw = NULL;
 	opp_table->supported_hw_count = 0;
@@ -1944,9 +1941,6 @@ void dev_pm_opp_put_prop_name(struct opp_table *opp_table)
 	if (unlikely(!opp_table))
 		return;
 
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	kfree(opp_table->prop_name);
 	opp_table->prop_name = NULL;
 
@@ -2056,9 +2050,6 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
 	if (!opp_table->regulators)
 		goto put_opp_table;
 
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	if (opp_table->enabled) {
 		for (i = opp_table->regulator_count - 1; i >= 0; i--)
 			regulator_disable(opp_table->regulators[i]);
@@ -2178,9 +2169,6 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 	if (unlikely(!opp_table))
 		return;
 
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	clk_put(opp_table->clk);
 	opp_table->clk = ERR_PTR(-EINVAL);
 
@@ -2279,9 +2267,6 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
 	if (unlikely(!opp_table))
 		return;
 
-	/* Make sure there are no concurrent readers while updating opp_table */
-	WARN_ON(!list_empty(&opp_table->opp_list));
-
 	opp_table->set_opp = NULL;
 
 	mutex_lock(&opp_table->lock);
-- 
2.32.0

