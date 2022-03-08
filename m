Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85384D0C89
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 01:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbiCHAL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 19:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbiCHAL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 19:11:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411236E36
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 16:10:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so772873pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhX5SlYl7BXLmMZAasTyx4ByzRymbQLodzBvBVJqn84=;
        b=YFKkSZN5IsoC+uHTyxgHguq+/wJgkUo4bsSgIDnrz0qlLwM6zV1HBalJ2kha3O/owJ
         LJmHd4tfW2regTgvT0rLqWpbvn9pJ/Vv0B6JBEy4/AEB+LvnKAtudJkxXyD8mO+wmytX
         PcqNKd+sH5JSzBCBpRfrOAwrGbAL4obRvkteQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhX5SlYl7BXLmMZAasTyx4ByzRymbQLodzBvBVJqn84=;
        b=4oJL5n0ao/HXH2U58rNvdYrnNe4ETtQcchEKpWwQBBRJhDyB4hJM6p2AuyfTgjVyo3
         41tQidHzdIgNSF9vSDGT0hBlUHRQIgkgqcqEKhE4tEbya7rw5NHsHCFR/25yb2ebFmux
         TFL/Wd2fE7VQxPME6unWCZbp4SrMMVPrw6GdCpZiIWOJq5aoaL0KRCZI2PzFvWAMh0jI
         pqCGyzpaRg0vmEleia3nTyrJKlrCqWH9DibjEuM0D1KiPKRwc/1TMQTOYvixuuZfBSv6
         4tiKpcIMJO7P6c7tC0OmpOxmuRI+2/hRa8N/JVgy14KEHv7toDZ8Zom12IFgxkDBb9Z3
         s/2Q==
X-Gm-Message-State: AOAM531JNIGKxR1LGkO0qAdkVlZKtSAvxKB1aOhAqYhEIeAeMOZwQbCd
        w92uXnK+VdFeGI+YLT9Z01XLFA==
X-Google-Smtp-Source: ABdhPJxQUs9wwprlA9jOWSx+o7EiW9t5JGe5afQ9CcxF+0aKMeDDa1CF1TKUG2Hj29RvKz6CgwS0Lw==
X-Received: by 2002:a17:902:cf02:b0:14d:54cf:9a6a with SMTP id i2-20020a170902cf0200b0014d54cf9a6amr14320856plg.137.1646698217819;
        Mon, 07 Mar 2022 16:10:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id ic6-20020a17090b414600b001bf691499e4sm463733pjb.33.2022.03.07.16.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:17 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 06/15] PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
Date:   Mon,  7 Mar 2022 16:09:36 -0800
Message-Id: <20220307160918.v3.6.I4bd77eb751d5bfce8346bfed576bcacb28e4550f@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308000945.706701-1-briannorris@chromium.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These properties are:

* undocumented
* directly representing software properties, not hardware properties
* unused (no in-tree users, yet; this IP block has so far only been used
  in downstream kernels)

Let's just stick the values that downstream users have been using
directly in the driver and call it a day.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/devfreq/rk3399_dmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 293857ebfd75..e982862f6ac2 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -430,10 +430,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		goto err_edev;
 	}
 
-	of_property_read_u32(np, "upthreshold",
-			     &data->ondemand_data.upthreshold);
-	of_property_read_u32(np, "downdifferential",
-			     &data->ondemand_data.downdifferential);
+	data->ondemand_data.upthreshold = 25;
+	data->ondemand_data.downdifferential = 15;
 
 	data->rate = clk_get_rate(data->dmc_clk);
 
-- 
2.35.1.616.g0bdcbb4464-goog

