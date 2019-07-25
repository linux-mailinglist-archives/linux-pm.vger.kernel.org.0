Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4574BD7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfGYKmM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 06:42:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32958 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbfGYKl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 06:41:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so47541907ljg.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OV03WyWjTcjS53n3WcFXDQeGooA4dZBwGcCk2JpHvuY=;
        b=cD7WEF1d3w11OaswaTxy8+jt2pkiE/tHnii41Xg5HuGHyfS+QOx8FWWNiKSeRF8H5r
         jMyERhR7jsC2WM+VCEyOIYhHb86Trnpcu5JKHOLnAtN7BgqShaSnN8V2YzCqrBLPdqf9
         iMrluiDf2YQtdR7gDDDuT417DPCGaX05oZNsT7MUvkOU/3xvwkHoN+oWnprXZJ83oGUe
         4YA6RXLTTqkBzQAW4zg1x4n4bDzLdHT0DrfsVoQnQf/i0yTipf6KGyX/KD7AEZ9OKfyo
         kpc58nVx8ZxkOD6T6IsEc6n3vGgRAOk2xVCFw9hCMbJSzH3qE6GTvJFNA6wV01xCpeCF
         IgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OV03WyWjTcjS53n3WcFXDQeGooA4dZBwGcCk2JpHvuY=;
        b=eLM67Pd6OJGAGT+FF0uHwffZ3w5KK78zJh+54hRSqdnk3fPoUJJuBtWd1Y1RRno8TE
         YicbxMHN/5fKBZpmg488v6/E1E3WUbHZZHkZjiR7GcmCN3nPC7DvREiJtfXNorelqqre
         vVHmScMUJYPn2a49hib3mla4ws0Ub/UDEVFcJ76PtKcb6IwlC4LjwEbCAWAy2CmXnEDY
         4VEgCgkqAmUgtes6vBFRtGquBqBsMA1e1A+Iw5tZJbUYkr0otKDBfo6gOEBU5Qx/FL3d
         pHV6KQ0cSoGc8V7e0BBeoBWLw6LBZtJWfaz3QXBtKZ8yr/8veyttFpxXDBMNnFcMDzLa
         MOJw==
X-Gm-Message-State: APjAAAVz7h5bf6MROzfFdiZcnjIYX2jd4FW7i1upETw2Lcuz4sqmbSjf
        omyLxHB3wA7LWUakbRmmLa0pfA==
X-Google-Smtp-Source: APXvYqxE5SyuhwVeYnhksrReyEUqQb+IQB3asKBPpbIrmQFz8JyFDfn4ogT9B7Ict5wgw5mOl0Kdzw==
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr6292605ljj.24.1564051315743;
        Thu, 25 Jul 2019 03:41:55 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id b6sm8268306lfa.54.2019.07.25.03.41.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:41:55 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] opp: Add dev_pm_opp_find_level_exact()
Date:   Thu, 25 Jul 2019 12:41:29 +0200
Message-Id: <20190725104144.22924-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When using performance states, there is usually not any opp-hz property
specified, so the dev_pm_opp_find_freq_exact() function cannot be used.
Since the performance states in the OPP table are unique, implement a
dev_pm_opp_find_level_exact() in order to be able to fetch a specific OPP.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/opp/core.c     | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 +++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cac3e4005045..3b7ffd0234e9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -401,6 +401,54 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+/**
+ * dev_pm_opp_find_level_exact() - search for an exact level
+ * @dev:		device for which we do this operation
+ * @level:		level to search for
+ *
+ * Return: Searches for exact match in the opp table and returns pointer to the
+ * matching opp if found, else returns ERR_PTR in case of error and should
+ * be handled using IS_ERR. Error return values can be:
+ * EINVAL:	for bad pointer
+ * ERANGE:	no match found for search
+ * ENODEV:	if device not found in list of registered devices
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
+					       unsigned int level)
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
+		if (temp_opp->level == level) {
+			opp = temp_opp;
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
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
+
 static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5bdceca5125d..b8197ab014f2 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -96,6 +96,8 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
+struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
+					       unsigned int level);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq);
@@ -200,6 +202,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
+					unsigned int level)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					unsigned long *freq)
 {
-- 
2.21.0

