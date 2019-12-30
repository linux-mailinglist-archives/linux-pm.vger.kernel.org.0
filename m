Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD39512D107
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfL3Oob (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36627 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfL3Oob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so33512290ljg.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+SgAM3h033e/MLAOZ0d/dorO2oxTfoGPJAEbgrUK1sA=;
        b=TZ7puyOxM+yGMbc3OGs6XvJX2K3hv/kDgeQIRnULYOGBMEJf7MAYGjYEzFkRBHtmQq
         IPa0AzJ36KUXkdzKzwmlplSKsccO970rx5ZZ3m9v+Upw5gJBovxtKLmxzrx/oYtAF/6J
         D5OXvUSkffHvEGQQ77aW9k1QG8eGDi3q1Z9xZH7gNWN4Xo/Bk1SqhvBHZ+HySpzZN2Hh
         jvljaarakC0NGmGNMx/Of1925O2nOinjCd93Ysjf4/e5zhvKfsHScC7nur/jO5RHXC6X
         Fz2b4o+zUWUZR4UhN6WTDZvrWliv8ykVC5+1UMsGrQqKV6Yf8KbR8laDQKfoDH4ozQ44
         HCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+SgAM3h033e/MLAOZ0d/dorO2oxTfoGPJAEbgrUK1sA=;
        b=pZalyND+L9+rD2hs9ob/Fd1UdO9KWzv/lF6IDj35fiMRDgV9ov/SAUkhWkx7KHukgA
         u6b1zwF7yvt0aafALdKGjAeRasf2aadt6LoeEhYDYZaHHgj6PlXFZU+YruAsrA+J0Vne
         BP76Q6BCO6ln+79hivaxjX98OH6y2JwhuZU0mz7lLm3IrZK8r3YYYctFuwAc3nG2rWqt
         YMT/vnum1zrKXfzJgtjHdYIXwb9HvBuJVDC2Q7a+6VqwURM/0eBvzh3AAZ1bJMUFv1fr
         obpOvvq5+XjTGNVIQORXCBEK9t7h7Q1A4ogRaC0XMbIxTEgOloWUaGFaD/WyRV7zi7DM
         deTA==
X-Gm-Message-State: APjAAAVeZUVedk4M9xPj6s29zq5Bmmc7fINpu0Ha2fzsYO0m6yILev3e
        IC9OE/+8X9EayCGharP3hisDFQ==
X-Google-Smtp-Source: APXvYqwtFgk8DWwJIi01w0yOiYq/bVEMrpa/+7NeIkZiIuoO5wszwt+ezEkxoN7XmPdMpQ4zt6kx3g==
X-Received: by 2002:a05:651c:1077:: with SMTP id y23mr38549803ljm.79.1577717069205;
        Mon, 30 Dec 2019 06:44:29 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:28 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 13/15] PM / Domains: Introduce a genpd OF helper that removes a subdomain
Date:   Mon, 30 Dec 2019 15:44:00 +0100
Message-Id: <20191230144402.30195-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230144402.30195-1-ulf.hansson@linaro.org>
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We already have the of_genpd_add_subdomain() helper, but no corresponding
of_genpd_remove_subdomain(), so let's add it. Subsequent changes starts to
make use of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v5:
	- New patch.

---
 drivers/base/power/domain.c | 38 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8e5725b11ee8..959d6d5eb000 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2302,6 +2302,44 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
+/**
+ * of_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
+ * @parent_spec: OF phandle args to use for parent PM domain look-up
+ * @subdomain_spec: OF phandle args to use for subdomain look-up
+ *
+ * Looks-up a parent PM domain and subdomain based upon phandle args
+ * provided and removes the subdomain from the parent PM domain. Returns a
+ * negative error code on failure.
+ */
+int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
+			      struct of_phandle_args *subdomain_spec)
+{
+	struct generic_pm_domain *parent, *subdomain;
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
+
+	parent = genpd_get_from_provider(parent_spec);
+	if (IS_ERR(parent)) {
+		ret = PTR_ERR(parent);
+		goto out;
+	}
+
+	subdomain = genpd_get_from_provider(subdomain_spec);
+	if (IS_ERR(subdomain)) {
+		ret = PTR_ERR(subdomain);
+		goto out;
+	}
+
+	ret = pm_genpd_remove_subdomain(parent, subdomain);
+
+out:
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_genpd_remove_subdomain);
+
 /**
  * of_genpd_remove_last - Remove the last PM domain registered for a provider
  * @provider: Pointer to device structure associated with provider
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5a31c711b896..9ec78ee53652 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -284,6 +284,8 @@ void of_genpd_del_provider(struct device_node *np);
 int of_genpd_add_device(struct of_phandle_args *args, struct device *dev);
 int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 			   struct of_phandle_args *subdomain_spec);
+int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
+			      struct of_phandle_args *subdomain_spec);
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
@@ -322,6 +324,12 @@ static inline int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 	return -ENODEV;
 }
 
+static inline int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
+					struct of_phandle_args *subdomain_spec)
+{
+	return -ENODEV;
+}
+
 static inline int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
 {
-- 
2.17.1

