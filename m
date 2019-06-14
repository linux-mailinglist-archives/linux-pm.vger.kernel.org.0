Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF34535A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfFNESK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:18:10 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:49878 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfFNESK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:18:10 -0400
Received: by mail-qk1-f201.google.com with SMTP id c4so991737qkd.16
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VA7s9ly0lqdagUAyh1uYpw4qgEasvgJFlK1lzvkukqY=;
        b=TrEXlT8djNpXPJc0j8YuBg6jTcfItK6GjAaeUSewHjYjftr5gYxyJuqq3MGH1OUe1T
         F3xdsaC3oKrSs+dlLVQW3XrlXYI+1M2VVTmgutAgeR/C8BeBT2yPpIVqmYf0mybVrYxo
         wmtTS/hWV6UkMbpi0KH7Dgq3wWGTIZtkgefl5OGGmwKX/S5v6YwKVnVU3C1gpFDeO+2I
         FBr4uMGQpUMsUfh59BM9jW4yJHzxtr2LArxfDQbupQodPwMohSfxjbPi3RMe0hpBN2iX
         XKBIGUhfIgNitWDR3R/EHS75rmfuv6cnWhkdhva0AOGRbVQuo7nzNskKg+bmAYvCCtN7
         zNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VA7s9ly0lqdagUAyh1uYpw4qgEasvgJFlK1lzvkukqY=;
        b=BkMUWPH24j6DGb8+YyPWlCOikB5HWjJu3QB0m42Z1zlte8zUQLDs/Fxmc3RDS7ZRce
         +ftQZIWYpNvRGA3APkJ+e5iRUUtBi5UHVl1a7ft2Vv5V8Gzk6JhtP7uujPCColYrN2n0
         Tsm6Wtr2D2ydN5RHwLvl5nRjz4kIpPoBKWxO82nxUuO/0y/MqtUuzM765xkLsR+H1HuB
         fLPQczDgNmqC8Lpp5sXrntN+icTFNid9gBVWjXJzw03L+2145OUl6V0B6Ru03Rhpw6LC
         y+g5jLqGl9FE1DQI8uhombF64mEC0rLy3N+KRyDXIqgv5+OyTIouXavKNh10zDnLNn+m
         xbsA==
X-Gm-Message-State: APjAAAUOqmWgfZF6bXsS7L6FzHoGr/2/1Onxv4XFA0yWfa8i2BPkZSS4
        hgYjuu1MaGsBrW+YoR/UzDUsGAC5Kt8vU7E=
X-Google-Smtp-Source: APXvYqzEU9fWluswZw2wyE1N4COxp8I6V3iABbyGVjD++OlIlQ99JPYxbbaQ1U5BqOb5o+DCUfLqGIKFA8Ys39Q=
X-Received: by 2002:ac8:1794:: with SMTP id o20mr80687898qtj.239.1560485889196;
 Thu, 13 Jun 2019 21:18:09 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:32 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-11-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 10/11] OPP: Allow copying OPPs tables between devices
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some hardware devices might create multiple children devices to manage
different components of the hardware. In these cases, it might be necessary
for the original hardware device to copy specific OPP tables to a specific
the new child device. Add dev_pm_opp_add_opp_table() to do that.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c     | 8 ++++++++
 include/linux/pm_opp.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c9914afd508a..668a377f59a5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -943,6 +943,14 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
+int dev_pm_opp_add_opp_table(struct device *dev, struct opp_table *opp_table)
+{
+	if (!dev || !opp_table)
+		return -EINVAL;
+
+	return _add_opp_dev(dev, opp_table) ? 0 : -ENOMEM;
+}
+
 static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index d9156b62d966..3694d703817f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -81,6 +81,7 @@ struct dev_pm_set_opp_data {
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
 struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
+int dev_pm_opp_add_opp_table(struct device *dev, struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
@@ -158,6 +159,12 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
+static int dev_pm_opp_add_opp_table(struct device *dev,
+				    struct opp_table *opp_table)
+{
+	return -ENOTSUPP;
+}
+
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

