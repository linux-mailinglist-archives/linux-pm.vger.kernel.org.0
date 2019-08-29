Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1360A1D90
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfH2OsV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 10:48:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47062 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfH2OsV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 10:48:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id f9so3264856ljc.13
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KCuLpwKkgO2woISAKHKSXhqDDj9RTnVSFiBEmqI8qvc=;
        b=IUCAvPjTBFoyU9PWJ2c/uU/nyvDbzYckQ6DEt4UvZg+TPRW+wVXsF5o+KwpT09SVbG
         CZHBf9LpzerenWeXgnRULTVrjizGumj5N8M7nQTd5UbJafylDSXX6vxlGL47gWk47gM5
         hyOf0djwLpu6hMhe3xCWdMmDsR2P61YhXVyxfI0cMErFsklKsXOS70e+vGRaNMUg2wxe
         spAj+Pb5gpfyCYLUc5lbRAg4SwvPzqA+V241FNd3jqBVeqhnm5ec7YzvXekJDKuBkaZ/
         xGHlbaObHBUxBpi0ybt9MjEfvktEER9BCzVLVcKcUaHk+USXen82UPG4oVQaJm9cyC5t
         sWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KCuLpwKkgO2woISAKHKSXhqDDj9RTnVSFiBEmqI8qvc=;
        b=cmJ13JLXtcRoFCl78YkhBZjt79EwGrn/IdGNO9RkmmUYE2mv44FxvRqX/znhnooLjq
         /qN0ZoNjnfdlYU/QohFRsfe2c0NFiBBs4awHQzVu4v+xu48DHv01K4aCHYYEhLO57bR4
         NCzfXZ6nL+YhGxSDl0y8iJqxvgfx/92KOeKTqSjbdIvpeol2kuLlEK6oLuSaULzJsXtV
         nfzhWYwb3PS9wI4+u/NSc7qk1kMewOUeTOjJDn8pMOVP/F177/pmC1tezSetGldn9ach
         b/QcVm4qnljv08XGr2oqYzJ6F14uwArWWOjOzBzh0aH2sCyBce6ZBGMyphEHp7vOPVNk
         ldtg==
X-Gm-Message-State: APjAAAXPEj/bhpK07Txr+RON+ajri/9+qVm4tmT1kMRz+fRQrwo5krUM
        f8lAm6AX95oNnZ169s3IeWhE42OhgpM=
X-Google-Smtp-Source: APXvYqxnrAm5LDjdgQ6ZmgGYnHRwFhG95yl/IZaUiH1cnVVXHi49YcAQk26+ugMc5t8NW2tOLWMFrA==
X-Received: by 2002:a2e:9a18:: with SMTP id o24mr5641521lji.235.1567090099148;
        Thu, 29 Aug 2019 07:48:19 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id r3sm385980ljb.96.2019.08.29.07.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:48:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH 2/2] PM / Domains: Verify PM domain type in dev_pm_genpd_set_performance_state()
Date:   Thu, 29 Aug 2019 16:48:15 +0200
Message-Id: <20190829144815.686-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dev_pm_genpd_set_performance_state() could in principle be called for a
device that has a different PM domain type attached than a genpd. This
would lead to a problem as dev_to_genpd() uses the container_of macro.

Address this problem by using dev_to_genpd_safe() instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 27592b73061d..2650ae2f46fd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -380,8 +380,8 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	unsigned int prev;
 	int ret;
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
 		return -ENODEV;
 
 	if (unlikely(!genpd->set_performance_state))
-- 
2.17.1

