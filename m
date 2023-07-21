Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038875C335
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 11:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGUJlX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjGUJlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 05:41:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E530E30C4
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68336d06620so1531173b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932476; x=1690537276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VfRkQPrBQp5nkzs4j3nyKArLBvoZpDkodHX3J6rbBs=;
        b=iCXPQGvwGph1wJcfy5vSSwH6shKYOGyynlju+9gl4A04h/yKW9uOhJRBt8NLnwxmo6
         ED0QoVvs6hdXY5QsxX6AlkkaG3tj4o/XB0FBmWbBrdJ4GUM2T2TK9pSZlsKQMyYgSYz6
         MppgzuZZ56SOT1Tr0Ti7X+g2ov8t+2tuNznc+FukPQ6mIK3U1fa987bB+yHh8svg4oRG
         LNSXvTbC2fYdX9P2hR8XRhia9Bo1em7EHAzTCySDUy1u922uOvaoLOAMBpkF0Hbs+Pci
         M9LFscK0/EDqwEY7zgmjhW9llglYBLEfJ8002K2wHzkSlgT/0mOG3qbc9JRMk4pjQSoQ
         pMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932476; x=1690537276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VfRkQPrBQp5nkzs4j3nyKArLBvoZpDkodHX3J6rbBs=;
        b=gyO7F7c9UoLBuzUdE3ER6ZlrQee7euyTZDw88bs9xVon7jNvPkWAKOYI1HZGzlQkVb
         0nB7sL7uEd2LNGsPzNYU/fa/s3gDmx40uoMGxcSQ6Nu4RelujAtXOW/hOk361OcaEwm8
         S+t7sLCFMJjgH8HOvcmqgYsBBy8Dhej4qBuu4ZGw26+dD0PSX2K+zJ8UQloQwKlzk3I7
         XH1XUY59I5lZ59rIJxCsdsCfyEWVmemkvw6xbDlqNAwV0y0McPYKusOZBGG7cznVsOgt
         JbzEebNFPEQjc1X5MTAVrxBzcIgSjuRNB5YRajSg6ZHXAMKaKEbcAftBtwNxBQECt2t+
         TdEw==
X-Gm-Message-State: ABy/qLb+Tr7OZfHNECZj3GiDG4yrlpHKPmDYDN7HBhGvWBotQCb4Mvdk
        49Du4g07KicLi3V8rKD51WG1Fg==
X-Google-Smtp-Source: APBJJlFFaDABXjfj3teUYbjZ3xP8/Hta2nJG2IfmVTu/qm200JNmynpvTbbWjXkG9w7UAXArYfhCQg==
X-Received: by 2002:a05:6a00:22c4:b0:686:2fde:4da with SMTP id f4-20020a056a0022c400b006862fde04damr1949197pfj.15.1689932476347;
        Fri, 21 Jul 2023 02:41:16 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b00654228f9e93sm2584934pfv.120.2023.07.21.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
Date:   Fri, 21 Jul 2023 15:10:55 +0530
Message-Id: <142e17c1c2b48e3fb4f024e62ab6dee18f268694.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1689932341.git.viresh.kumar@linaro.org>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

In the case of devices with multiple clocks, drivers need to specify the
clock index for the OPP framework to find the OPP corresponding to the
floor/ceil of the supplied frequency. So let's introduce the two new APIs
accepting the clock index as an argument.

These APIs use the exising _find_key_ceil() helper by supplying the clock
index to it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[ Viresh: Rearranged definitions in pm_opp.h ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 56 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 18 ++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3f46e499d615..cb4f47b341f9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -658,6 +658,34 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
+/**
+ * dev_pm_opp_find_freq_ceil_indexed() - Search for a rounded ceil freq for the
+ *					 clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	Start frequency
+ * @index:	Clock index
+ *
+ * Search for the matching ceil *available* OPP for the clock corresponding to
+ * the specified index from a starting freq for a device.
+ *
+ * Return: matching *opp and refreshes *freq accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *
+dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq,
+				  u32 index)
+{
+	return _find_key_ceil(dev, freq, index, true, _read_freq, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
+
 /**
  * dev_pm_opp_find_freq_floor() - Search for a rounded floor freq
  * @dev:	device for which we do this operation
@@ -683,6 +711,34 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
+/**
+ * dev_pm_opp_find_freq_floor_indexed() - Search for a rounded floor freq for the
+ *					  clock corresponding to the index
+ * @dev:	Device for which we do this operation
+ * @freq:	Start frequency
+ * @index:	Clock index
+ *
+ * Search for the matching floor *available* OPP for the clock corresponding to
+ * the specified index from a starting freq for a device.
+ *
+ * Return: matching *opp and refreshes *freq accordingly, else returns
+ * ERR_PTR in case of error and should be handled using IS_ERR. Error return
+ * values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *
+dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq,
+				   u32 index)
+{
+	return _find_key_floor(dev, freq, index, true, _read_freq, NULL);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor_indexed);
+
 /**
  * dev_pm_opp_find_level_exact() - search for an exact level
  * @dev:		device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 3821f50b9b89..2617f2c51f29 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -125,9 +125,15 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
 
+struct dev_pm_opp *dev_pm_opp_find_freq_floor_indexed(struct device *dev,
+						      unsigned long *freq, u32 index);
+
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq);
 
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil_indexed(struct device *dev,
+						     unsigned long *freq, u32 index);
+
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
 
@@ -261,12 +267,24 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *
+dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq, u32 index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					unsigned long *freq)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *
+dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq, u32 index)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					unsigned int level)
 {
-- 
2.31.1.272.g89b43f80a514

