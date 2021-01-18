Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFED2F9724
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbhARBF1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbhARA5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 19:57:04 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09141C0613D6;
        Sun, 17 Jan 2021 16:55:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 23so21606921lfg.10;
        Sun, 17 Jan 2021 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8BYKrVjCHK2ATkUn9Bn3mODsj1VGuehzu+tpszr3yE=;
        b=RVZ6+QUecC4p1baC6nkw1UzPNHHeQQMMmFiEOBBXGz1hfh/BWaj0eD2AY+hfFcsBM2
         uzfzOk/00N+NJataeb92ZCWAbHC9a5wJ/4sj3KsMyFKIptEEhSQOjv36HLUjsw6mw9uE
         gadSVo7rh9cuTbwNPKOnZR78leJuri0vgA8F2N0n8lWhFC7rF1kMv4d7uvmYpQyDoNFe
         mtsfXXNkXwmh4WIvmWmgBio0u4vr/awNFzT5P6Rd1Xly6GAyVTN5y9NiA9Y5HB7Wv/Z7
         +L0PgnjEnuVhZWwlPG8N+hIJfAGlv4lCGmZU0qHyaE8taXV9HofVPrueJr0HbgMEGMwV
         w4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8BYKrVjCHK2ATkUn9Bn3mODsj1VGuehzu+tpszr3yE=;
        b=Wp9kBDnjlDJbvMbZPJMEQ+acij6uGOL/T+QQooRm+oZrIa9P2VzFnBqNhl94f3Oc6s
         cZlfyVT8t6VKdtL4GJY9gSIyH/JTwTHaqElMrBRPFIAfcYIq2WHbKm4GJB6kRQcK5fHM
         Cdt5tewCLQir4a2NDIqpEqQ8el7HOsRuH7kCgflE+JlO2xeoBoyEEDLZRJgtbg+ztFIl
         gW5gLacmMtmjiqO5GOgvOMyk0S0jb70wJYrGNdaEUOHS4qujxWJSbUafyql8+B+kXs+I
         Bu6MnM+Px1qK/IfIAavFg7D9MoA3clSMA13MCdcMQ0dmXAqKhDnLHAGqebfFfaMlW/XV
         dhFg==
X-Gm-Message-State: AOAM5303NvpmrDAV0+qui1/8HKuXRKfB14ScLhKOl3RIsrobcdCpNjZG
        uitN17zjBXOJCsrs6aZU0bM=
X-Google-Smtp-Source: ABdhPJxkBnLKRUA5i2l0ufZhrcFnHI8gJ0IfG7hUjISt1Y5rErImhyYEtzRaG3xwQVMO5IZkDjePMA==
X-Received: by 2002:a19:6901:: with SMTP id e1mr9465665lfc.461.1610931341578;
        Sun, 17 Jan 2021 16:55:41 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id m24sm1484553ljj.62.2021.01.17.16.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 16:55:41 -0800 (PST)
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
Subject: [PATCH v3 07/12] opp: Add dev_pm_opp_get_required_pstate()
Date:   Mon, 18 Jan 2021 03:55:19 +0300
Message-Id: <20210118005524.27787-8-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_opp_get_required_pstate() which allows OPP users to retrieve
required performance state of a given OPP.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 22 ++++++++++++++++++++++
 include/linux/pm_opp.h | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index df0969002555..fde2ec00ab0e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -145,6 +145,28 @@ unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
 
+/**
+ * dev_pm_opp_get_required_pstate() - Gets the required performance state
+ *                                    corresponding to an available opp
+ * @opp:	opp for which performance state has to be returned for
+ * @index:	index of the required opp
+ *
+ * Return: performance state read from device tree corresponding to the
+ * required opp, else return 0.
+ */
+unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
+					    unsigned int index)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available ||
+	    index >= opp->opp_table->required_opp_count) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->required_opps[index]->pstate;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_required_pstate);
+
 /**
  * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
  * @opp: opp for which turbo mode is being verified
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b7dc993487c7..e072148ae0e1 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -98,6 +98,9 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
+unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
+					    unsigned int index);
+
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
@@ -194,6 +197,13 @@ static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline
+unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
+					    unsigned int index)
+{
+	return 0;
+}
+
 static inline bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 {
 	return false;
-- 
2.29.2

