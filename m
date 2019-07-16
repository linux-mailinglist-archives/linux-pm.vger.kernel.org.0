Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A056F6A568
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbfGPJn1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:43:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37436 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732593AbfGPJn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:43:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so13196782lfh.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7PhWAy1xqNZO8fw32oFUdA29pot6GzvOYCImhF+mYj8=;
        b=a0RSKlkPCXLdsQ1UczLSy7igNfNczG7sDZn7zBp6oy371O41PqUW1uRHEsiyFgjc4I
         AmeahOcFSbblE6AvJDAfOHA6fHQl66SAFU+kvYGcFeuOJdCLrwHXkTcEO/2J2DAvACff
         +VDpnreKOet6A8AMNjNbV7FZ1/Z/sOumU0W1ejY0f9ZFVSpJYP2jPUGKy+hTHa4XLqpi
         kcrfVfunB2ZWQYuFr+V6mjD7OrlyAxfj5uMpPFn7Fv8RRm3iUTtPvNMl7mjPVSUdOIg6
         k+MgdRF9afAbKUiwGSVeWYEY23EOvv3miGi+ThpjcEsnS36OnG362HLBNbx76KIpDZiQ
         Dycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7PhWAy1xqNZO8fw32oFUdA29pot6GzvOYCImhF+mYj8=;
        b=tmGSr04/orug1xeSQ0y7v0XjckJld1NCA0mF5EJOFwemj0nXfecndjv7Dg+F7e5Gg0
         nfBvWZ8d+BmyY+PwRz0hbGDR7Gi3wIaCFmFTHHtVVSBy6X517dQtpHVDxx7T1hTLSdJk
         ++sG6nu6f+kBfvxlKumqIOowahiP5UUXlH+r6dvMmv9VZ0tsGig3qaIfsdYx8AtyC5Pm
         PrGh3E3TpdwXlH/Mgkpkk7i2IQI8T/2gUJGtU8A2IvS/pj5hJMTEMrpl3yUYSnE5LZJ3
         FENBKGXVXqJn8Shc9/WhjcQbqJfY/dzlDPf73Ax2wbxCkryxx+A/KROYSu5LWTYeHN4Z
         SCUQ==
X-Gm-Message-State: APjAAAUu8Mu2XIZzC2QODs1EIoMnt5YdAIgt/chUWvvUMDOgMtPeOCNW
        2oP829JYf3beTSsqe8qvm43+kQ==
X-Google-Smtp-Source: APXvYqzYWb7BZlYhV8K+iZrKyJLRi/FJcVjyUAUWrirtRASW3h4stlDb5Ff8/E+tvKdILfnNJxW7bQ==
X-Received: by 2002:a19:914c:: with SMTP id y12mr14210793lfj.108.1563270204967;
        Tue, 16 Jul 2019 02:43:24 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l24sm3654087lji.78.2019.07.16.02.43.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 02:43:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH] PM / Domains: Align in-parameter names for some genpd functions
Date:   Tue, 16 Jul 2019 11:43:20 +0200
Message-Id: <20190716094320.20091-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Align in-parameter names for the declarations of pm_genpd_add|
remove_subdomain() and of_genpd_add_subdomain() according to their
implementations, as to improve consistency.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 91d9bf497071..baf02ff91a31 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -197,9 +197,9 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
 int pm_genpd_remove_device(struct device *dev);
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
-			   struct generic_pm_domain *new_subdomain);
+			   struct generic_pm_domain *subdomain);
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
-			      struct generic_pm_domain *target);
+			      struct generic_pm_domain *subdomain);
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
@@ -226,12 +226,12 @@ static inline int pm_genpd_remove_device(struct device *dev)
 	return -ENOSYS;
 }
 static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
-					 struct generic_pm_domain *new_sd)
+					 struct generic_pm_domain *subdomain)
 {
 	return -ENOSYS;
 }
 static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
-					    struct generic_pm_domain *target)
+					    struct generic_pm_domain *subdomain)
 {
 	return -ENOSYS;
 }
@@ -282,8 +282,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
 int of_genpd_add_device(struct of_phandle_args *args, struct device *dev);
-int of_genpd_add_subdomain(struct of_phandle_args *parent,
-			   struct of_phandle_args *new_subdomain);
+int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
+			   struct of_phandle_args *subdomain_spec);
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
@@ -316,8 +316,8 @@ static inline int of_genpd_add_device(struct of_phandle_args *args,
 	return -ENODEV;
 }
 
-static inline int of_genpd_add_subdomain(struct of_phandle_args *parent,
-					 struct of_phandle_args *new_subdomain)
+static inline int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
+					 struct of_phandle_args *subdomain_spec)
 {
 	return -ENODEV;
 }
-- 
2.17.1

