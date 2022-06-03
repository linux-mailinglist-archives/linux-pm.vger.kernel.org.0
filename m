Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D4A53C4CD
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jun 2022 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiFCGUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jun 2022 02:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFCGUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2022 02:20:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F3D31DCA
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 23:20:29 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g205so6478387pfb.11
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2022 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtqSGSpcTYMhqEhiOK8deMmsDpT+y77WgcKMAx0xXi0=;
        b=x561OUt53M0UXGNsOFsZ+zaKCUzTGqTkew0UeDthOgHX3JQ4WVtTCji+ahD8BPJRso
         7k39vcNQsWRwp3SCRX1nLP+zQvs4ymDVI0pJz+sqIaSotC+vJFJf9JWo6XbokVZoeW1q
         NvcCSgVRTH9krggLTZ/XvBABxZnWGrUxphO6kOj1Sl78xovk+Xfd7U/7QUCLYfvdFXMq
         U8TvBcc+5WSM8WTuWZ5iN9Z+H+evmAqJQ4ihAinRyb2xTpXa7Tkc7xJlavZ+jEskurs3
         fPbvotzmPQXfk/cmqpzOJk2KfDO0arubZRS4C2jHFjUTdO4gcspkn99IxWNDVW/EThDs
         5MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtqSGSpcTYMhqEhiOK8deMmsDpT+y77WgcKMAx0xXi0=;
        b=fxKwjGBAf7e+EE03FAAw7bYkFmc76FaxiTXR+ImbwBM4BJqLAl8h80e4X/IFm2U1O8
         sKf9E3t407cUTa0haKD3oZ4FQv2SYwgMfa+Vcbm8PEFxhVZ1N1Bw56arhmNcaCONA5mX
         AMDCGT1M3ZK+kjek0AIXjByCz2mANZH98L5ojR+nRrRcQJ39OGu+vGRsGiCl8rNApAUX
         FRq9307xOQATkXeb2gZ5mpJzaC1phe58ui2aUOnPDgieBP/lPaggN60AmxGU1OZO63vs
         akVA6Z/AJXfDvn2vOetyFTGCdB6NLLRzmcEHGAf4/3681kJxOiUmccisQkVrSXlgl8ek
         Fs/Q==
X-Gm-Message-State: AOAM533YMpHnL4StcVdCKeAPcfICAA6g81NRpHZ3bo2x7Eu+EfYiVWGh
        xw/qToLvN3h4yBlJhEg9wND5Kg==
X-Google-Smtp-Source: ABdhPJxXOUS7EM/9384o4OYGzgHKDDVyzIFQnrK0vG1J1No1ZfoxjwGOqMi3WjHSf8PDzrED76RTRQ==
X-Received: by 2002:a63:85c8:0:b0:3fd:1851:3d67 with SMTP id u191-20020a6385c8000000b003fd18513d67mr2440586pgd.520.1654237227929;
        Thu, 02 Jun 2022 23:20:27 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090ac25300b001cd4989feebsm6815158pjx.55.2022.06.02.23.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:20:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] OPP: Remove dev_pm_opp_find_freq_ceil_by_volt()
Date:   Fri,  3 Jun 2022 11:50:15 +0530
Message-Id: <7b1d7a692f91e52da49b93f280ccba7014c139ba.1654235445.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654235445.git.viresh.kumar@linaro.org>
References: <cover.1654235445.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This was added few years back, but the code that was supposed to use it
never got merged. Remove the unused helper.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 54 ------------------------------------------
 include/linux/pm_opp.h |  8 -------
 2 files changed, 62 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 554a043bc225..1ee218dcb0b9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -600,60 +600,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
-/**
- * dev_pm_opp_find_freq_ceil_by_volt() - Find OPP with highest frequency for
- *					 target voltage.
- * @dev:	Device for which we do this operation.
- * @u_volt:	Target voltage.
- *
- * Search for OPP with highest (ceil) frequency and has voltage <= u_volt.
- *
- * Return: matching *opp, else returns ERR_PTR in case of error which should be
- * handled using IS_ERR.
- *
- * Error return values can be:
- * EINVAL:	bad parameters
- *
- * The callers are required to call dev_pm_opp_put() for the returned OPP after
- * use.
- */
-struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
-						     unsigned long u_volt)
-{
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	if (!dev || !u_volt) {
-		dev_err(dev, "%s: Invalid argument volt=%lu\n", __func__,
-			u_volt);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available) {
-			if (temp_opp->supplies[0].u_volt > u_volt)
-				break;
-			opp = temp_opp;
-		}
-	}
-
-	/* Increment the reference count of OPP */
-	if (!IS_ERR(opp))
-		dev_pm_opp_get(opp);
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_by_volt);
-
 /**
  * dev_pm_opp_find_level_exact() - search for an exact level
  * @dev:		device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index c6d8f01ef9fd..fde202b1f5a7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -117,8 +117,6 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      bool available);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
-struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
-						     unsigned long u_volt);
 
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
@@ -264,12 +262,6 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil_by_volt(struct device *dev,
-					unsigned long u_volt)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					unsigned long *freq)
 {
-- 
2.31.1.272.g89b43f80a514

