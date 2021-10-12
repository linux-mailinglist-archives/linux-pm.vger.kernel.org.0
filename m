Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D742A518
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhJLNK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhJLNK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 09:10:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB57C061570
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 06:08:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id az39so5616944qkb.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=11eSu2ZKdYgEuERztfioRr6aCnjBQslrDoFToZlAcsE=;
        b=ao7RHFmKIIssNsvVmnTufgtTszzYtc5sism6oy3EzLyOFuBOHOFav59C435l+EnSkg
         iGhmssJM70oT1lakHjM5mNZJjvjoen7F2R0S/gv4rlNyTkZkwxecj+PWfGQ5wE/+KKl/
         8iFVJtcbFYAOoy0i5uy1QEKhYNYD9H+HLv2+8W6RjHHNiJT9b6wCgbK147Zwt8RGOug4
         R4dfW5MCB3qlrIyq76tZcZWCtv7MYJKgdy0bjOqsJIczYLLekq7d9x+AFU9QIFYKXNLv
         YVNn0ZlIkpKOby5C2FXRvvtYSa2wx/4UeTstyv//Yp060eqhKBCr6T1LKsxq9qdXE0Kt
         g/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=11eSu2ZKdYgEuERztfioRr6aCnjBQslrDoFToZlAcsE=;
        b=3k7QoYg423bRZVXTk5hukDlMh+Epidd9x5ZjV72cfrcad7AtW1Nw4d4SHXC1fjiv3k
         ELo4TVIqqHVHcZoG67gIiqoL4rQUXPf96EACfk3rkpPGsG6KZLzVIXhB1iyCUJF6Ba/J
         AkH5npRXm3u0vjQ5tYlDkV+iZRNYATsP4e1LS19wUqyUXFbQhyGoZTVdl3FHIdUS9X7D
         6ceNR+SEWd4E4pHykDQD4O9xvypPnf8hbIj97L97W8vZEn+63kcGOHKsEowXTHWKdzXU
         SNrvZeULzJT8A8nqso/t0XC31luw99mNbekQWqAqz/o475Qg3xiRbRdEKvt9On7n1uBu
         0kzg==
X-Gm-Message-State: AOAM533bm3XgDaMU1Dh4QkaY4s972hADNi+vJ4MOkOK+YvvK4P8R17cH
        gCSfm5bCRHKFTAGZAA5VMq6W9LY23uuI3HKS
X-Google-Smtp-Source: ABdhPJyw/z73lT6KYyAZrcnQp55DR7lbmZHJ9CC25P1X3JZ8IwFLag98yz9EqDqNPgG4W/+SRP9CPw==
X-Received: by 2002:a37:2d46:: with SMTP id t67mr19328405qkh.84.1634044104472;
        Tue, 12 Oct 2021 06:08:24 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id v20sm6380774qtp.44.2021.10.12.06.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:08:24 -0700 (PDT)
Date:   Tue, 12 Oct 2021 10:08:19 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, pavel@ucw.cz
Subject: [PATCH] PM: domains: using dev_err_probe() to simplify error handling
Message-ID: <YWWIw1hAQAYjjrfK@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replacing dev_err() for dev_err_probe() in order to reduce code size and
uniform error handling.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/base/power/domain.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e71..e7701b79494a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2249,10 +2249,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	if (genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
 		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
+			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table: %d\n",
 					ret);
-			return ret;
 		}
 
 		/*
@@ -2312,9 +2310,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		if (genpd->set_performance_state) {
 			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
 			if (ret) {
-				if (ret != -EPROBE_DEFER)
-					dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
-						i, ret);
+				dev_err_probe(&genpd->dev, ret, "Failed to add OPP table for index %d: %d\n",
+					i, ret);
 				goto error;
 			}
 
@@ -2673,10 +2670,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	mutex_unlock(&gpd_list_lock);
 
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to add to PM domain %s: %d",
+		return dev_err_probe(dev, ret, "failed to add to PM domain %s: %d",
 				pd->name, ret);
-		return ret;
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
@@ -2707,8 +2702,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	return 1;
 
 err:
-	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
-		pd->name, ret);
+	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n", 
+			pd->name, ret);
 	genpd_remove_device(pd, dev);
 	return ret;
 }
-- 
2.31.1

