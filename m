Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CED3407F83
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhILSrd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhILSr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 14:47:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCFC061574;
        Sun, 12 Sep 2021 11:46:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s3so13032199ljp.11;
        Sun, 12 Sep 2021 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZx+fkLQGOQm9/g48OhQPkP+HxC/ux2/6Bzv6o5U8hw=;
        b=RvONcgMwXanSZ/m652FgRHZAs47qc4f/nJiqCxtCn0NFqmcvwrAnmhfg1CuFkty6yX
         zZxRein3t+AJS4D6m/sSwu9a2aUP1OoBb1SLQMosNxAhoAIS+k/gPFJcbIQfySzwsFAZ
         wkzTVyDrKWdw+sUBck72DxFRt2FTeeqeSN+ckyxRs9dgB/vjFOTxo65bWOV/YEe8gwyD
         vlP1eP6YvCNQlPaYVRMxuaoVjbEAqGEM6LYEEgS8L4+wLhu38Bdm8WwNLPiMXKYyiIhi
         IGPwhyoSpor4PlVKIEbOUQVOIFuY9t6tt9aJ3tP0vsy5qwaszReN1nICEVy/+OC13tOx
         x28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZx+fkLQGOQm9/g48OhQPkP+HxC/ux2/6Bzv6o5U8hw=;
        b=Ngt4RJct1wRUDpaXFks0DF/xePprpcSKzXMNa9+vm6ipUs7Ptw2uKNS1jqKa2SKH3q
         xZN3Y/Y3p2KD2y8hhOmlo7p16f1jK6PHe/v+iNYODKG8bD3mIbQo1DcDfRPyLzi0Tx0d
         fcSZpwk37i+VV1HQzXx0nG0F0b5H/7I6RmiDYsSMEORo8HjvVNRjWXRQNHkfMxO7v9Tv
         YoaOCuKhTfXIJkGAtBrNQCvpAaG/HAalQzT1Sl3E2tUWMK6Xku+h7bjYsSEAVE1qBXcg
         3NLKv2r/Dt8LRrOh9HEetiY7ncI2jYLcClr9/yxbjh9mooiOaI5fCxJOkYjaK3KALowd
         q6vQ==
X-Gm-Message-State: AOAM5306e0kYY070oSktTc8VSHoZr078Vf1mMQeY6YN9SqT6ev4Fwhhu
        Q4koGLx6bN+dzXbHAP+qd20=
X-Google-Smtp-Source: ABdhPJwSX0/yNDmygLn8rBIyXQio8hvAFuX+Qzt5pxB4BKwYGBuhstNzUKLcG42SWlLAXM1YVP93AA==
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr7295656ljj.478.1631472369642;
        Sun, 12 Sep 2021 11:46:09 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id q5sm588570lfg.36.2021.09.12.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:46:09 -0700 (PDT)
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
Subject: [PATCH v1 2/4] PM / devfreq: Add devm_devfreq_add_governor()
Date:   Sun, 12 Sep 2021 21:44:56 +0300
Message-Id: <20210912184458.17995-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912184458.17995-1-digetx@gmail.com>
References: <20210912184458.17995-1-digetx@gmail.com>
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
index 85faa7a5c7d1..d3af000ec290 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1301,6 +1301,32 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 }
 EXPORT_SYMBOL(devfreq_add_governor);
 
+static void devm_devfreq_remove_governor(void *governor)
+{
+	devfreq_remove_governor(governor);
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
index 2d69a0ce6291..0d70a9ad951e 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -94,4 +94,7 @@ static inline int devfreq_update_stats(struct devfreq *df)
 
 	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
 }
+
+int devm_devfreq_add_governor(struct device *dev,
+			      struct devfreq_governor *governor);
 #endif /* _GOVERNOR_H */
-- 
2.32.0

