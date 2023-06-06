Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DAE723B62
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjFFIXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jun 2023 04:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbjFFIXi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2023 04:23:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FC9FA
        for <linux-pm@vger.kernel.org>; Tue,  6 Jun 2023 01:23:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so48447075e9.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2023 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686039788; x=1688631788;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqU663avBDGtNA+7qj15+8XcwDxuXpyjVCXFjA4/lfE=;
        b=Qd5AVRy6jVBxdNVPSb++sWTkyA+QxF3QBQC1QWbDnQIAq5K4gIs1F+pwzH6q3EzBKX
         lXQ9CakK0PrnhUxg3QcDl66mR5gp3RcFOAYxayLAGEEYQP3++tb6Q3I/FMWj2n4b9T3Z
         PwihFZgG2GiILNk5IdBq9LuASU2CYN//RPC8PdQGrN6gTQo7DOFrHclOnTObIUZ738CX
         KtFa4ArHdCzrxK1Akmay5A82wviSo02bldl6jsKC8w19oGVFXdsEPdmv6J9w76lzHyoK
         wyEOGn/ek+IPbkzD0+v8blH4hjLWlkUqbeciMffzYu3Z99vaY8PgIJ6hljXI9OqhrUfx
         Qjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039788; x=1688631788;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqU663avBDGtNA+7qj15+8XcwDxuXpyjVCXFjA4/lfE=;
        b=RTY+Rvz8I4sXjJmF1yuowiRw3kkPBPwpSe8L4kMl7nCdoC86DezFqQ6rvs2t/hhm7V
         gFHHwsncrBkfa9q8vQKrfpHrD1i+dlUzIQEj+lGxbzJbmM3BHmcVHG5BKJA7MbA+nklz
         pFzLeKEQ16bE7SBUFe4WznXI4iVu19EloIGWjbURnKejKkmv1ynlGpl4frjx9q3K6TCG
         8Z972wb+dkP059DkYWhMPqjJrxkOhe4rRt+HjnlvC4GV0lhaejKlIJhDBurCwaYUWEux
         et0mgdpo/j8DLO6f4HvSYWh8/xBMHWaGclddf9aUgDmU0BD7P4M21iamVTLYIPi54rYv
         NXew==
X-Gm-Message-State: AC+VfDzL3J1Z3jOHA5ES468YOrEDytysLc3069nWNdDrU0ZL8yLB7Ek3
        SxbMu6uUh6lJUZA+Ra4k2oQnxSNEbtZ5rDlm8Q8=
X-Google-Smtp-Source: ACHHUZ7l32Vj376IpODe04w+e0XBjtDxWNN8qfepBmt6+3to7r/g/Tbpwud1itYVQS0iQk7K1RdT/Q==
X-Received: by 2002:a7b:cd97:0:b0:3f4:2973:b8c8 with SMTP id y23-20020a7bcd97000000b003f42973b8c8mr1293139wmj.26.1686039787945;
        Tue, 06 Jun 2023 01:23:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t14-20020a7bc3ce000000b003f60e143d38sm13144596wmj.11.2023.06.06.01.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:23:06 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:22:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: Fix a NULL vs IS_ERR() bug
Message-ID: <ZH7s0qNJ8a/KHjvQ@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devm_ioremap_resource() function returns error pointers on error,
it never returns NULL.  Update the check accordingly.

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/powercap/intel_rapl_tpmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index c016127b3497..4f4f13ded225 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -255,8 +255,8 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 	}
 
 	trp->base = devm_ioremap_resource(&auxdev->dev, res);
-	if (!trp->base) {
-		ret = -ENOMEM;
+	if (IS_ERR(trp->base)) {
+		ret = PTR_ERR(trp->base);
 		goto err;
 	}
 
-- 
2.39.2

