Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE0399DEB
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFCJhs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:37:48 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44807 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFCJhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 05:37:48 -0400
Received: by mail-lf1-f48.google.com with SMTP id r198so4491676lff.11
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rVASeO6Y6OcFufLMrsc56Y+VubvwdMfYIrrp6oq4r4=;
        b=ttTV9dS3FVDeh8gdxlsfE9fqeYyL4RbcrkOc2YpayXaxhjHVSYzHdSkYf8gZGF03ao
         FTogbxZRc6drk/Se9oX7peJvwggvDgXeGtDkyw/3Xv08d9EXgUxfFAxWP7R44czFhBxy
         YRp8d1xzO9W2w2WTbeLM/SXB4WmVUNrPmKHSY+ytmhEPVMbT1SAjeWGwL5t2SWQJjQuO
         EtV3pNVRyEYfFSK8vxVt+DnxeT0KTLj7s7EYNRrVYfL+2GZ7WUeOnjOue+Sp5vkkozMK
         JpZ6S/xnkX2a8JkxH42ozOzEKXBVmz9TURd2ykPpNXhzqc0krruQGo/0dWSw05UgWUqD
         SW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rVASeO6Y6OcFufLMrsc56Y+VubvwdMfYIrrp6oq4r4=;
        b=FcqjsiVcx5RnWwNsgQt2TpeHETTw5d0vD4Oo1BAQEjZoX2DGdyxS0PGcWAZ8PikM/Q
         CUHLi/3li7P78iWEabhXEm8u1R7lOtaBue9ornRDxjk14CPRb4f83oKeZX0tY9EOuKva
         19h3lD9SvvkD47NepTUB/qMBgTqc8QOj6C5PQ13J0c3V6u6RX9SfuCBsTAveHs1J6G9Q
         fuc1Kaq/8tet978lFdArZeqJ3bt8l0+cuvtMkvR61yvODGIcLjUmgHI6ONfBfAnHJUAS
         jwwIvPqnf9ZDb5XeGoIFRtk0rpLyBlqOQT3ueXE1wbacvuFfwhP4ZhRw8p4lQ4Fz0rjr
         hWhA==
X-Gm-Message-State: AOAM531BVr0U3eILW5kDozDtV65RLeQ7DGsSN4uBycf94MeNXyc69r2P
        6RW4/dpX2dL9nzw7VAPaQ53u1Q==
X-Google-Smtp-Source: ABdhPJwTfUiqI1PTAa4Ti9ScSuSpJMZh9fZH533X9DuesqyiUwYZtT+W7JazvFs90129yoD0c46yiQ==
X-Received: by 2002:ac2:5a4b:: with SMTP id r11mr18051551lfn.338.1622712886936;
        Thu, 03 Jun 2021 02:34:46 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id q4sm263373lfc.172.2021.06.03.02.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:34:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] PM: domains: Split code in dev_pm_genpd_set_performance_state()
Date:   Thu,  3 Jun 2021 11:34:35 +0200
Message-Id: <20210603093438.138705-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603093438.138705-1-ulf.hansson@linaro.org>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To prepare some of the code in dev_pm_genpd_set_performance_state() to be
re-used from subsequent changes, let's split it up into two functions.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- A small cosmetic update and added Viresh's tag.

---
 drivers/base/power/domain.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b6a782c31613..5c476ed1c6c9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -379,6 +379,24 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 	return ret;
 }
 
+static int genpd_set_performance_state(struct device *dev, unsigned int state)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
+	unsigned int prev_state;
+	int ret;
+
+	prev_state = gpd_data->performance_state;
+	gpd_data->performance_state = state;
+	state = _genpd_reeval_performance_state(genpd, state);
+
+	ret = _genpd_set_performance_state(genpd, state, 0);
+	if (ret)
+		gpd_data->performance_state = prev_state;
+
+	return ret;
+}
+
 /**
  * dev_pm_genpd_set_performance_state- Set performance state of device's power
  * domain.
@@ -397,8 +415,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 {
 	struct generic_pm_domain *genpd;
-	struct generic_pm_domain_data *gpd_data;
-	unsigned int prev;
 	int ret;
 
 	genpd = dev_to_genpd_safe(dev);
@@ -410,16 +426,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 		return -EINVAL;
 
 	genpd_lock(genpd);
-
-	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	prev = gpd_data->performance_state;
-	gpd_data->performance_state = state;
-
-	state = _genpd_reeval_performance_state(genpd, state);
-	ret = _genpd_set_performance_state(genpd, state, 0);
-	if (ret)
-		gpd_data->performance_state = prev;
-
+	ret = genpd_set_performance_state(dev, state);
 	genpd_unlock(genpd);
 
 	return ret;
-- 
2.25.1

