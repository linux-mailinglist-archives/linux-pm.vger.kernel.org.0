Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C82F973D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbhARBRg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbhARBOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 20:14:37 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE268C061574;
        Sun, 17 Jan 2021 17:13:55 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id w26so16547981ljo.4;
        Sun, 17 Jan 2021 17:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ky1yRRPYE3K2/PqCBcIuIXx+q8eWWpmi1zq1iqBWRVA=;
        b=q+diSSe2R030qndeAFAfZRgHCAIgGRJ6B4aLARKXHXH5QwjRF7xBWB+T+5FpvOTflu
         jbZp4IVRNExbQlJAYK+fpbxcUSx6lGFwtsi9gV0dX9QoyO14ZmVJ2uPsxNMftGEJW/Vv
         R/PDVc9pkjEmeOK7saEgS2btpJyGdnU6iCFApPSZ5ccAMLaaCfvpjTY1HZS53A45lqPh
         vNwbTjbTUUw1XGKw4mt60ehkKpgGTOZhti25T0MDxWUEPeM3LxTcuOZuLSJFtuEd/RLx
         TiXTuxemmY2hrz2ajxGHR2zUIc0v/M8xiBI8ZSWj5oZrvtYM8OXQcajtJTCJb5sbjYAn
         rk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ky1yRRPYE3K2/PqCBcIuIXx+q8eWWpmi1zq1iqBWRVA=;
        b=bk1eCRaQzME3nsLDPhhakBtf4ByRl1PRW983kMiFwS/xEvTBc4vWhKpPyT4hZOjJ7c
         WApLSgFwONC2U/iFI1H578fm9cHVGUkJBQIPJrPZV7Eac5yB/JqLcbPxbCjm0/LY+R7t
         KpSt/DpTeMwRWytoo+un8WfWQRGcvvuxtqWhtdaa9F5BUIt2m0+t253qAu1ASeeLlFKv
         jQkYfFCRa01DoZFmaCy3AXZFHCeZpCHRZS0qFZkj84uyKjwd/2+aapB02qCvdpfU/YjN
         ukxMQtJSMGGw9oeKa+Yigc06VKUvlhA7Nnw4Xlxy0jol9gDoNdKusFQzWUKDhRoc1V8k
         3I3Q==
X-Gm-Message-State: AOAM533up44qQAcdJ9zxsgBmM9LWgoN3K7V3RvajcXofmEyUzxG4rCzp
        0/qkdViuK2LCLRl5IVF3jFM=
X-Google-Smtp-Source: ABdhPJzP8/KyLz++yd6Vo1A+C0ydVblu+PMmSfSpVzN0iuYCstDuNRogG2NSYmgsci6UsnvRuZCJaw==
X-Received: by 2002:a2e:920b:: with SMTP id k11mr9606381ljg.313.1610932434282;
        Sun, 17 Jan 2021 17:13:54 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id l84sm1710836lfd.75.2021.01.17.17.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 17:13:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 1/3] PM: domains: Make set_performance_state() callback optional
Date:   Mon, 18 Jan 2021 04:13:28 +0300
Message-Id: <20210118011330.4145-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118011330.4145-1-digetx@gmail.com>
References: <20210118011330.4145-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make set_performance_state() callback optional in order to remove the
need from power domain drivers to implement a dummy callback. If callback
isn't implemented by a GENPD driver, then the performance state is passed
to the parent domain.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/base/power/domain.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a14eedacb92..a3e1bfc233d4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -339,9 +339,11 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 			goto err;
 	}
 
-	ret = genpd->set_performance_state(genpd, state);
-	if (ret)
-		goto err;
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (ret)
+			goto err;
+	}
 
 	genpd->performance_state = state;
 	return 0;
@@ -399,9 +401,6 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	if (!genpd)
 		return -ENODEV;
 
-	if (unlikely(!genpd->set_performance_state))
-		return -EINVAL;
-
 	if (WARN_ON(!dev->power.subsys_data ||
 		     !dev->power.subsys_data->domain_data))
 		return -EINVAL;
-- 
2.29.2

