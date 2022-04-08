Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36F34F938B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiDHLNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiDHLNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 07:13:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043CEAAB56
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 04:10:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r10so9662513eda.1
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2022 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VOm2ulUjp1Xi1EM6XOot3oLjmozwpYPnlt3ttE49zY=;
        b=tS9CzrFtVjxXZ5AUABo+Hp5gaupgQk1rM5KYHUfJpQH+SwzoLg7dMBEYCSw5fRMYJO
         s6SUxVvYy287fjN6Ee/+7OaB062Kak4Xz1knuC/xG4aJpq/oS2HGr45t2IQUoIZRmgVW
         RXDNNWfiqLpX1QdVHJjUP2u/oTZI6f0mbIB72UUHoN+i0LocnXGOA5F9iqJOJ6IevxYz
         TtaDjzSyxEuAimVIxPcSDoDgHgUdgnnadsO1NKPyfUpmrYOH1Di6qa+Bh33+wQrDXsPq
         Ho0DGWjgkIXu24Vbc+vpbAV4ZLq8tBmtXBFCZNqjZUQIFJinX5tO0ltngvJC/E9+LSXs
         G/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5VOm2ulUjp1Xi1EM6XOot3oLjmozwpYPnlt3ttE49zY=;
        b=3SSauqroHnx2wvcbNhCE06/x/Efz1LDRFvLPhWqqAN7WQhkhyXC1xnaQKSqLUZi28L
         xfZay+nMxrsJV87GgZ97/ZnC1yofFAcfm6MiL1kz4leP72ZtdzQbqnfkZimfEo++7C9d
         L+M7IJqXBNxCK9LMHNKmugQjs/ehodsYYVs0FQbhMkYz6GcxaXgzPDlkvnp7qu58NEgF
         9uT5xFXBhEJFfFze2x8grbEWdhk8bPafDaiMQFZhSP+y6eJKVUtZPAg2llfXoRGwOgU2
         wJcr0W6CpLVEMUI8Qkd7ybdZpZ+8SnMmPra4r2RCxAP8DiVJHXlyv12KxXQ/wNVmcdD3
         AElQ==
X-Gm-Message-State: AOAM531eTzNCn2jY6mGCrTtUAJtwyuVmhuNVFVaPl0tyxUZKV3tPpCl5
        0fsO3/Y5JqB3YBJXXj8IKh/azQ==
X-Google-Smtp-Source: ABdhPJwlRL2pj3USgiBDJNsWlJmMwWSM7zPTKm3FNdz3np8qsvzP2oXBbKL3aRuSZOA0aHXMY5syhg==
X-Received: by 2002:a05:6402:4407:b0:419:3859:697e with SMTP id y7-20020a056402440700b004193859697emr18850638eda.400.1649416256599;
        Fri, 08 Apr 2022 04:10:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id lj11-20020a170906f9cb00b006e8402c3379sm1219058ejb.58.2022.04.08.04.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 04:10:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] PM: opp: simplify with dev_err_probe()
Date:   Fri,  8 Apr 2022 13:10:52 +0200
Message-Id: <20220408111052.381603-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/opp/core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0b5357b9d342..ed72df835f8c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2030,10 +2030,9 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	for (i = 0; i < count; i++) {
 		reg = regulator_get_optional(dev, names[i]);
 		if (IS_ERR(reg)) {
-			ret = PTR_ERR(reg);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "%s: no regulator (%s) found: %d\n",
-					__func__, names[i], ret);
+			ret = dev_err_probe(dev, PTR_ERR(reg),
+					    "%s: no regulator (%s) found\n",
+					    __func__, names[i]);
 			goto free_regulators;
 		}
 
@@ -2179,11 +2178,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, name);
 	if (IS_ERR(opp_table->clk)) {
-		ret = PTR_ERR(opp_table->clk);
-		if (ret != -EPROBE_DEFER) {
-			dev_err(dev, "%s: Couldn't find clock: %d\n", __func__,
-				ret);
-		}
+		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
+				    "%s: Couldn't find clock\n", __func__);
 		goto err;
 	}
 
-- 
2.32.0

