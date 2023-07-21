Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829F75C332
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjGUJlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGUJlO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 05:41:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA57F0
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89d47ffb6so10390115ad.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932473; x=1690537273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6yDwHR8CjSzLvtEor6MI6CE+UiAGOZc12BD4oiDuSo=;
        b=PdKQDS+1nlXydb+5R8TxjZ7RbKzetxDiuD7HuGUHno/JNfMOM1u+Wugb/3enYlBk0a
         /yJRnGtbDQsFLP5Vhtcis/4Q0J2RY5Jvk1NWjHcaBmvu/RgtuWqDmAu1uMk4YoeqtNxp
         iyUHSBJydok2kBv/ryvHmscoax+3oJELdtfRGtyX3zf9qdxnN5E8N6nWLvy4rpkmOT4o
         hRLSF8TeHyf1FdQgQvchDb/1d+iNwbwiMdFQtZE3BOcPI4Nm2W2XM1aV5U21xenx9YR4
         6qLMKQhJBb1JrYhh5dsRcdbVTcrrrhYgSEkDq0I/7XhH7qQUISf3qrSnpBlXHl+RGbS/
         /uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932473; x=1690537273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6yDwHR8CjSzLvtEor6MI6CE+UiAGOZc12BD4oiDuSo=;
        b=eQ67RA1Jwq7y0ivyh3LvSLvV9PRFKrttvKjqzmpjn0lSpew52ATyjnnGCEhD1h1nrd
         EwZPJif+baytH2t2Hk0/yGnzT+onhcp+ssidnQErYCzMcAQimfFAdauQNhawwKtn9KLA
         4gn7mPAymOiT8s2TDVTxLi/E5UeflCeFAwDlhc7vuWKe1b4M/zkKxq6AHcI8WZUtWsOo
         ZEdGKETToSn6X3eo/+0Vk9w4R5CaXGR9ymKQwSUoRTyQxDoRRJGb59v6urNUDERdLI5/
         dKT2HwehponC4vkJMRLmHHcUQOyTO7zCOw0ZDUnxxFjLnT4/ZQ6Xg8whFnZWzy0ICJsL
         uShA==
X-Gm-Message-State: ABy/qLbkeJEw9ZbvumT77989CFtk7WMgON+vR873wDZdZ67/poUgVOSt
        KWx+JtB2ZTNQQuBRiRdBhCxc9A==
X-Google-Smtp-Source: APBJJlHHO7Z+R2tpbCR19q/21EKGqsi2PifbH2YSzzeeHwz2+Q4HfzwBny+9uk4Oi5w4pSHQKKM8lQ==
X-Received: by 2002:a17:902:ce84:b0:1b6:ba60:77f0 with SMTP id f4-20020a170902ce8400b001b6ba6077f0mr1347225plg.10.1689932472961;
        Fri, 21 Jul 2023 02:41:12 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902d48100b001b895a17429sm2959770plg.280.2023.07.21.02.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] OPP: Rearrange entries in pm_opp.h
Date:   Fri, 21 Jul 2023 15:10:54 +0530
Message-Id: <754833b3194c30dad5af0145e25192a8e29521ab.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1689932341.git.viresh.kumar@linaro.org>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rearrange the helper function declarations / definitions to keep them in
order of freq, level and then bw.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dc1fb5890792..3821f50b9b89 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -121,17 +121,19 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
+
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
 
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
+					     unsigned long *freq);
+
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
+
 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level);
 
-struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
-					     unsigned long *freq);
-
 struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
 					   unsigned int *bw, int index);
 
@@ -247,32 +249,32 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	return 0;
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
-					unsigned int level)
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
+					unsigned long freq, bool available)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
-					unsigned int *level)
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
+					unsigned long *freq)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
-					unsigned long freq, bool available)
+static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
+					unsigned long *freq)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
-					unsigned long *freq)
+static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
+					unsigned int level)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
-					unsigned long *freq)
+static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
+					unsigned int *level)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.31.1.272.g89b43f80a514

