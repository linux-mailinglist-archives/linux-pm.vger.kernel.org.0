Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF054127A4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhITVEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhITVCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 17:02:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F7C05935F;
        Mon, 20 Sep 2021 10:23:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b15so52295267lfe.7;
        Mon, 20 Sep 2021 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpp5P4ugre+3Bt1zcMzEqxuMaP87lFqCuB5qRKv8mNk=;
        b=g3edkwtY6cLRoMAGjN5XX0Eogof/sYH0pouYGJGAMIpVwVxrHnbU4bKCPFvhqm8Lln
         MzFnpLDKXQgZNLUCeMJLABIlHoqcBURqrq+iBx00KOWsuYsniwYvBqtXRLfjxG/QSPln
         iJ0Hyiq3zG3lNjYFwV23+MEXGkp1rLhUIh65x59MFBXBBx48BntuqL3txS25dD0I0HvX
         6yYzC1ik6n0cDV25c++olY61/6ExeysD604qpmumlSRuYbLasVwKmgKyqJpfNlURWAUp
         cWhEElCveRwYlbrrhFWIDINK6DtxqID2L3PKQjBWlPBaLjkewn+GR7gC5I8hnEa1RXqI
         L2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpp5P4ugre+3Bt1zcMzEqxuMaP87lFqCuB5qRKv8mNk=;
        b=KoVmRtK+5HvluyhiOAjLdBM5XSjqgSryFHxkaf43ViFhlYXTBK1kFNrYNMuL2EukZy
         f/RfrO7mrVXyvzmtiz7ZPOIkyndTBal4YF/ZayIcQ56OgH79jYO7lyOM1y1cnvYuvhWm
         4BWxSN7mqI/HSHpyKjSknB9HJtZTVq6mZhYCrhkNLIi8WGGl0m/k2E+JLOJ3O1dyFbWN
         kBWyI+WcymvKIIZd93f2e0LpcPCIrLa/19hVoJc10PW0RVc5G9EapKi36Hui5aK41VWz
         G8nYtSMrLH7I0KDFhMOfhgisnjMnGjwlkUbDmkhq+V9PhIDI9gDOvZVscB6U4kADcAvc
         ZbDA==
X-Gm-Message-State: AOAM531V+rkxQW+Fi4qZSfK8OogsalrCxFQ5e6eLw97Ea8WjM2gMMxkx
        h1E/fevQI8rrEVmho98khQc=
X-Google-Smtp-Source: ABdhPJz9soTFZ2UwBv5pkLAGxgJ1zX159icqD41ZzvHls7eFDm0AN6gTPaTc9tL9vUH5voN27nbaGA==
X-Received: by 2002:a05:6512:344d:: with SMTP id j13mr20795746lfr.47.1632158595633;
        Mon, 20 Sep 2021 10:23:15 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id t13sm1311038lff.279.2021.09.20.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:23:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] PM / devfreq: Add devm_devfreq_add_governor()
Date:   Mon, 20 Sep 2021 20:22:47 +0300
Message-Id: <20210920172249.28206-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920172249.28206-1-digetx@gmail.com>
References: <20210920172249.28206-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add resource-managed variant of devfreq_add_governor().

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/devfreq.c  | 26 ++++++++++++++++++++++++++
 drivers/devfreq/governor.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 85faa7a5c7d1..4579eefb8fe7 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1301,6 +1301,32 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 }
 EXPORT_SYMBOL(devfreq_add_governor);
 
+static void devm_devfreq_remove_governor(void *governor)
+{
+	WARN_ON(devfreq_remove_governor(governor));
+}
+
+/**
+ * devm_devfreq_add_governor() - Add devfreq governor
+ * @dev:	device which adds devfreq governor
+ * @governor:	the devfreq governor to be added
+ *
+ * This is a resource-managed variant of devfreq_add_governor().
+ */
+int devm_devfreq_add_governor(struct device *dev,
+			      struct devfreq_governor *governor)
+{
+	int err;
+
+	err = devfreq_add_governor(governor);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(dev, devm_devfreq_remove_governor,
+					governor);
+}
+EXPORT_SYMBOL(devm_devfreq_add_governor);
+
 /**
  * devfreq_remove_governor() - Remove devfreq feature from a device.
  * @governor:	the devfreq governor to be removed
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 2d69a0ce6291..002a7d67e39d 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -84,6 +84,9 @@ void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
 int devfreq_add_governor(struct devfreq_governor *governor);
 int devfreq_remove_governor(struct devfreq_governor *governor);
 
+int devm_devfreq_add_governor(struct device *dev,
+			      struct devfreq_governor *governor);
+
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
 int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
 
-- 
2.32.0

