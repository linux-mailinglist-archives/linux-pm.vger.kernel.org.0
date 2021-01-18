Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74E42F96FA
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 01:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbhARA5N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 19:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbhARA5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:02 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA0C0613D3;
        Sun, 17 Jan 2021 16:55:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h205so21609486lfd.5;
        Sun, 17 Jan 2021 16:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRak0qcqqausNC3NGuy0ldW/i7K4KUMaot2CO2ZPoQ0=;
        b=lOxmMs0fqu7dVZvkuoJjfriNTe8c/8xjGC1MS5KGI8dd4cb0OrYRLx0sZjDokLaOWk
         E4s0TG8ODa8TPN1+rsTxxprtHy/M8ooXQkh5JmJsGOb8VOCXXqckAH/p7LitYoewVb+Y
         05rXkUK7UAp2oftsYc5nP8GTb2ReEPPiNo8hg3NlAUKdwzrnFuhbmB4wARYhPJGWCFtE
         iHV1mxMs2m58FJkEHlZ25o8EoAfIgDIPAn76ubde5oNoBXu7tQNL3eS1SqMLVpJyKULg
         abugoTWTn4ftiS8cL3k0oNcF4RpH237b68fd9bHokhWKtHy0+6tujondOQ3NmaeXOAg0
         Ge3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRak0qcqqausNC3NGuy0ldW/i7K4KUMaot2CO2ZPoQ0=;
        b=SCNqfdANDpsZFSyyZ31cx3Dixl9INlkCqbFPh6CKCGOKy+S5ma9XuLGY/tqOT1UyuE
         DauHiXdAIPqFtk900QQkqyue3PwAgzlO9TtFaA4gMf+UqyWNnkk1c2vlcVp02JAir3/Z
         2QwwpS//Ed7Ch0/nACYKZ+irG5HQIdewrdhWYIc7ocBIP6T2jnTuIQ6p1b+6XH/UYl+0
         UpNs59/yJ0i1ihuHk1AW4eXQb6GbAZIepSXHjyKaq+kuBcsk2F6gdeaM8vQWdrJXa4Ur
         KC7zdoFQesLkM+ICN8QsZVo/TqjSOKDKduYPeeB83MJkceNRcEwGrMqg+ScUV/vfKJ0D
         LbsA==
X-Gm-Message-State: AOAM530ln5pG3WwIJ/JWAre8l8KIGbEbnC7CVQCB6XwHfRj3pPJGUmnp
        maGzyIbcHIBwogYwBkQSF3U=
X-Google-Smtp-Source: ABdhPJywi9C7D5cjHUIqLpL2/PD7TA/ggulSm5IBkDuPAlvT/JZ2mdGO2c8E6bK6smkdYH7D6qg2CA==
X-Received: by 2002:a05:6512:68d:: with SMTP id t13mr8416239lfe.472.1610931340575;
        Sun, 17 Jan 2021 16:55:40 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 06/12] opp: Add dev_pm_opp_find_level_ceil()
Date:   Mon, 18 Jan 2021 03:55:18 +0300
Message-Id: <20210118005524.27787-7-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a ceil version of the dev_pm_opp_find_level(). It's handy to have if
levels don't start from 0 in OPP table and zero usually means a minimal
level.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 +++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 341484d58e6c..df0969002555 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -449,6 +449,55 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
 
+/**
+ * dev_pm_opp_find_level_ceil() - search for an rounded up level
+ * @dev:		device for which we do this operation
+ * @level:		level to search for
+ *
+ * Return: Searches for rounded up match in the opp table and returns pointer
+ * to the  matching opp if found, else returns ERR_PTR in case of error and
+ * should be handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
+					      unsigned int *level)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		int r = PTR_ERR(opp_table);
+
+		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
+		return ERR_PTR(r);
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available && temp_opp->level >= *level) {
+			opp = temp_opp;
+			*level = opp->level;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
+			break;
+		}
+	}
+
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
+
 static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index f344be844bde..b7dc993487c7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -111,6 +111,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      bool available);
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level);
+struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
+					      unsigned int *level);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
@@ -234,6 +236,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
+					unsigned int *level)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					unsigned long *freq)
 {
-- 
2.29.2

