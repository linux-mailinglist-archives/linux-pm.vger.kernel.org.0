Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2137A30D641
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 10:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhBCJ0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 04:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhBCJYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 04:24:49 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA0C0613D6
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 01:24:08 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o16so16920396pgg.5
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 01:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZ6BkzwJWuysG9Ncleyt9tGqJKvRpmo0CkvfsB7TcKk=;
        b=Ann/UFGcEilfP4bbNvsmSpXNxAD6le02tln9ZZDTT8t0N8m2tunukhf/ECBfEAztwT
         78yf8YtmRnWyKRPunIopa4FAFk1DgkrmMMr65nbMX+wzzIvrTfxHI4M5JJf/cdZDFerJ
         1bDMnebwuCPZ86HY5vFXTJ7EJ+w5FFdCEkB9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZ6BkzwJWuysG9Ncleyt9tGqJKvRpmo0CkvfsB7TcKk=;
        b=gjrmMWS3xkWzv3crgHE8KoCSPkbDIRwY58+fnmeLeND8E9NNjkmQj/4SlyVZvlk8sz
         eVpDglIbV/Dj7ZX0XiqU/FqGDzAdnYnZNY5+XY3ElwQXhTMPT4Ey6seJVzAEFwpyWyhg
         43mDE9eZ+J/ypIqjG7Iyg8O3J4MeV61jlJAkv6bUD900fr5D2h4vouFhKGl7/KsLKhCN
         MEtMkm6y7ejHFHiAGyW956EG35ISEraMOuQIXcxf54zqHGrksuRbYS8AT1Qbk3aW06oP
         ns7f8x75CZn0tj+7a0GWSsi2ulh3dDPyRJBTyjWndSvUgaqgiCvxA+V1zz8N+1axxH31
         Jp3Q==
X-Gm-Message-State: AOAM530Le6yj4FsPrHimQoz9kvgqCToRyXIZ6YDFYaoLZ2fDiribJhLV
        4RUjNYrOQOk32/3G9tlz9gE6sA==
X-Google-Smtp-Source: ABdhPJz/j4xh8w6XxMxxJwJ/o/Xf5CJ9htyCuf1i+pbedtZmRSmpT/VYjt4uWrexiDblCLNIHx5RRQ==
X-Received: by 2002:a62:7650:0:b029:1bb:aa42:aa96 with SMTP id r77-20020a6276500000b02901bbaa42aa96mr2211330pfc.33.1612344248257;
        Wed, 03 Feb 2021 01:24:08 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id u20sm932294pjy.36.2021.02.03.01.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:24:07 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 1/3] OPP: Add function to look up required OPP's for a given OPP
Date:   Wed,  3 Feb 2021 17:23:58 +0800
Message-Id: <20210203092400.1791884-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210203092400.1791884-1-hsinyi@chromium.org>
References: <20210203092400.1791884-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Add a function that allows looking up required OPPs given a source OPP
table, destination OPP table and the source OPP.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/opp/core.c     | 58 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 11 ++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index dc95d29e94c1b..878f066b972cc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2398,6 +2398,64 @@ devm_pm_opp_attach_genpd(struct device *dev, const char **names,
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
 
+/**
+ * dev_pm_opp_xlate_required_opp() - Find required OPP for @src_table OPP.
+ * @src_table: OPP table which has @dst_table as one of its required OPP table.
+ * @dst_table: Required OPP table of the @src_table.
+ *
+ * This function returns the OPP (present in @dst_table) pointed out by the
+ * "required-opps" property of the OPP (present in @src_table).
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ *
+ * Return: destination table OPP on success, otherwise NULL on errors.
+ */
+struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
+						 struct opp_table *dst_table,
+						 struct dev_pm_opp *src_opp)
+{
+	struct dev_pm_opp *opp, *dest_opp = NULL;
+	int i;
+
+	if (!src_table || !dst_table || !src_opp ||
+	    !src_table->required_opp_tables)
+		return NULL;
+
+	/* required-opps not fully initialized yet */
+	if (lazy_linking_pending(src_table))
+		return NULL;
+
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i] == dst_table)
+			break;
+	}
+
+	if (unlikely(i == src_table->required_opp_count)) {
+		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
+		       __func__, src_table, dst_table);
+		return NULL;
+	}
+
+	mutex_lock(&src_table->lock);
+
+	list_for_each_entry(opp, &src_table->opp_list, node) {
+		if (opp == src_opp) {
+			dest_opp = opp->required_opps[i];
+			dev_pm_opp_get(dest_opp);
+			goto unlock;
+		}
+	}
+
+	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
+	       dst_table);
+
+unlock:
+	mutex_unlock(&src_table->lock);
+
+	return dest_opp;
+}
+
 /**
  * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
  * @src_table: OPP table which has dst_table as one of its required OPP table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ab1d15ce559db..6f5f72a7f601c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -156,6 +156,9 @@ struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
+						 struct opp_table *dst_table,
+						 struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp);
@@ -367,6 +370,14 @@ static inline struct opp_table *devm_pm_opp_attach_genpd(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(
+						struct opp_table *src_table,
+						struct opp_table *dst_table,
+						struct dev_pm_opp *src_opp)
+{
+	return NULL;
+}
+
 static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
 {
 	return -EOPNOTSUPP;
-- 
2.30.0.365.g02bc693789-goog

