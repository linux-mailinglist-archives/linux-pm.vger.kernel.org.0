Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B76A3F28
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjB0KHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 05:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjB0KHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 05:07:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2B16321;
        Mon, 27 Feb 2023 02:07:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r18so5587820wrx.1;
        Mon, 27 Feb 2023 02:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqNgqAJx/n0S7+BoW8AS5oVR4jMes+tqXU99MEBiNwI=;
        b=E1ROgjIM1XNegAMpfrYyY9kkIvGBVnqPPjdVsHT4VHjei6/6FcJ6ycWizoOrBesIdF
         jtc4IG/+Nrwgwi/sw0Wyss7OYRGBhwWS3KmJcblbx0KtADk7dXpVnxBGnvWUWondngo1
         iNxNVC9kRih5IbgqIghKKdZBdB26NPToRhvuVKhE2UoXMtTUbVEB1Nya9wwNrGF899w9
         fOkWG2o7KM1SYCn2yRijDfrqiX1n55TiqvPJ1wVUj5DOAtSp5opGadsbDccFknndUJoL
         rqxZ1VnLUDHi9pfp1dDdHY+E74ehBrxaere1HDL+zzvfgiHU8DjCkPlesbq6VqhMI1wH
         mvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqNgqAJx/n0S7+BoW8AS5oVR4jMes+tqXU99MEBiNwI=;
        b=eKDSVb0gukMM9D6d7Sz8NJPxXzdsPNOw1wuJYeMOEWG2QAULjTBYsggtBQR1IMJ/7z
         QE1Hr33hRcjvsVDVKBfC29PStKEuPVcWooCzgExhipmRHxcwYCFAzeb8P+089jwkFjOt
         wip1TAsTY1neX/y/5GEDTotN/YIhQIWJRffN8raAKWf17EJKNcPv2uj5tk/ohWLtsrYF
         Zow5FPiaY4uwWKAh/2YfYO5M5S+VzYRqymzQQ+k/JvWNAzGcKxtuHCEDIEdQJcPIrBu7
         WezO9hOtU7GDOmML29Bm8mZFMUOLmXzWmc2zHROPnRvklSewRqqKWMd3uj/HsgQrWGNB
         bkuA==
X-Gm-Message-State: AO0yUKWbV2iO4gP9CgGLiIB8MJgIjX81iWJ4o4jfWLGhQkNe65FdSJZA
        FP4gpIgm4hRLZcxIHtQUxa0cZG8ZG4nzQA==
X-Google-Smtp-Source: AK7set9olwW5SckjSIZrQELzNrVlnXDXFuOGW2+7Md6ZiEesbCdx5GrGgnDZEgw7EmgSd1m2Tc88XA==
X-Received: by 2002:adf:ee8f:0:b0:2c7:ffd:f483 with SMTP id b15-20020adfee8f000000b002c70ffdf483mr12018660wro.41.1677492433585;
        Mon, 27 Feb 2023 02:07:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b002c794495f6fsm6475314wrx.117.2023.02.27.02.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:07:13 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:07:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cpufreq: apple-soc: Fix an IS_ERR() vs NULL check
Message-ID: <Y/yAzR6sWvPedLej@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The of_iomap() function returns NULL if it fails.  It never returns
error pointers.  Fix the check accordingly.

Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index c11d22fd84c3..021f423705e1 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -189,8 +189,8 @@ static int apple_soc_cpufreq_find_cluster(struct cpufreq_policy *policy,
 	*info = match->data;
 
 	*reg_base = of_iomap(args.np, 0);
-	if (IS_ERR(*reg_base))
-		return PTR_ERR(*reg_base);
+	if (!*reg_base)
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.39.1

