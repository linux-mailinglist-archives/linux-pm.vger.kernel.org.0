Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A738F4E8EA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFUNX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 09:23:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38221 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFUNX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 09:23:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so6596327wmj.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2019 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ivwcwk4wjlXTEFrBezW9m8Osb/vrzZPgsbaTndGY63w=;
        b=lTye1pRrvYZaUqUpAY6fIcyP/rdkZZeh1TaiSOM/mfknHGEy22SVpna5CjRIIwa1bl
         Dgw016BteCVdF+4HcJTkyQLXjmxEnozwPGmJwAJ1Nc+nP87UN6B8j1uyHwMEmJHqAmau
         byssz6VnmjMEZmF/DPqgWpfYmPBXNmeItqpwu56fXX/y4S77vtGkOxSkHsRrxpR/rBNj
         k3e+tXOsg3ycq1FtK/wrwuCRt8bOTCRyfzyCv14YsscKyFOeVWYZUYFeaxC5EORYMgk5
         Ds6ek3TI/7ZxwqWYSuz5MseJ0ww/p1NukAJLbKQ69SSdCpI0Z6KgPQxjntLWq1XfKeQt
         leBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ivwcwk4wjlXTEFrBezW9m8Osb/vrzZPgsbaTndGY63w=;
        b=cNtS3v42Lm338LkbLxbM2oy5/T+dXfnQCVH2Gm91KxWSOSvNk5VRmSVIcnbMN2Et4h
         dKpvjbvQr0JDoKczK6qdVNAsaHEyPjtP1gkEdkCM//3bD1GSCqO2fYNIWGorquhxt+5J
         F2w2L/vPb19F4Vvt21/1p3U+HzLcRUWUMvzPFTPPB8ZJXDnXQKpuBjzG2c/9CS+33VUE
         7ke07sm/NnQcHNzAbSfYjYYEkvPLlKT7E5Qqt7oPJIetBeEWjvBByvylxDs1Y84nvYuP
         zdsnPZW+8/bPZQHjo1AY05nWIdgsc+Fq3eTZ66LPLe/SzMMO5kevZi+YCUFF0UVDrDT/
         1LsQ==
X-Gm-Message-State: APjAAAWqu8WxBemHHs0BlJBgLPF7SCxabicIy72JiEEedsWc/moQC4CM
        BhawfTOlzegn4lWD+/ftxX8o2Q==
X-Google-Smtp-Source: APXvYqx1UH9Z6qhqH1hBWaKqMdMAjh/YvMf9a9gg5RQh/ezlTfhGqx0ecaIVn/Ru2Plm8dK5aI0fFw==
X-Received: by 2002:a1c:39d6:: with SMTP id g205mr3957146wma.85.1561123404531;
        Fri, 21 Jun 2019 06:23:24 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH 1/6] cpufreq: Use existing stub functions instead of IS_ENABLED macro
Date:   Fri, 21 Jun 2019 15:22:57 +0200
Message-Id: <20190621132302.30414-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The functions stub already exist for the condition the IS_ENABLED
is trying to avoid.

Remove the IS_ENABLED macros as they are pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..7c72f7d3509c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
 	}
-- 
2.17.1

