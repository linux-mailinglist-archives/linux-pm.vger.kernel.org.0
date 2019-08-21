Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C65987BB
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 01:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbfHUXRr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 19:17:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44719 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfHUXRr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 19:17:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so2470644pfc.11;
        Wed, 21 Aug 2019 16:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FU7aS4c8r3DI9MJLtX68651RnQQMYkzHAkQK9w3MzVU=;
        b=fFY4wLbH+FYNp84w0k7iuK4xp6dwv4nZRC4+jQ+HSAwiOC4QufpOen8rbWwZZzj7/X
         NaBOQg52Yd6O+k200QyeIFiYVzHO9M8KbdqgFhXqooVcsJp9h0ZFHFoCUXscBBeBocxZ
         AK/JKWB5+1IAPHwHp+C8GwBUsH97+tjqaFNIWOH838M81iUqqqLLwHExSdR7380APYVn
         pFhazFS0zPDwN3clTNXTDZB48uOGhXetcDmUXHktigoisOiBiE1VcD+WcYTGsQgOmGM0
         SSp9acGbbczoUz6425h2uYLsXItDSDBY6Y54fodEhdo0VwplJzgp9hqYVv3F3HPsupba
         qM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FU7aS4c8r3DI9MJLtX68651RnQQMYkzHAkQK9w3MzVU=;
        b=GnDRVuERlfqUQ+TibnemggYiFBURoaGj6TmUl90v9WFwbHEnGBSRs142cTILzdcSQ8
         4kCuBRcPUzgxQ7xKtTWJXs/Vg+l4Reg3fFNOcAaqLdScH/4nG3C2KV96ODzWVx/joh1f
         e78xu1nDm1/f9j40Uv+UouB34Ks05aQnzg3JzZYphdshWnYzar31C44gu9IgocNg4DES
         T0YAZfROCAqFQLoRfLNvviRYStDBK+AN8JMJaVGNb+giTdRg0naEjo4VIICSZCl07Olc
         kb2IRKriraMMsyj0ewoEKj1C1HGieH6ISn0KsabV4TYOQs2GpAx/+C5Q56aH4yKqvAkh
         M3Sg==
X-Gm-Message-State: APjAAAXu6f5AdWjg3mk4B3dvH3ud7DX/zDCVFoY1xUKXsaw3nkBy3EfM
        /Y5Met8ObkBCNud0JN03Zp2yBDpE
X-Google-Smtp-Source: APXvYqxTQXZanuOiof2/sVzu3XHROVEXvykvg7UR5Ydi0eoMxQhnQ2zV/+5ZczfLwx+FHIKHaIsjSQ==
X-Received: by 2002:a17:90a:2525:: with SMTP id j34mr2479573pje.11.1566429465655;
        Wed, 21 Aug 2019 16:17:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q69sm1250493pjb.0.2019.08.21.16.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 16:17:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH] cpufreq: Print driver name if cpufreq_suspend() fails
Date:   Wed, 21 Aug 2019 16:16:32 -0700
Message-Id: <20190821231632.29133-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of printing the policy, which is incidentally a kernel pointer,
so with limited interest, print the cpufreq driver name that failed to
be suspend, which is more useful for debugging.

Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c28ebf2810f1..330d789f81fc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1807,8 +1807,8 @@ void cpufreq_suspend(void)
 		}
 
 		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
-			pr_err("%s: Failed to suspend driver: %p\n", __func__,
-				policy);
+			pr_err("%s: Failed to suspend driver: %s\n", __func__,
+				cpufreq_driver->name);
 	}
 
 suspend:
-- 
2.17.1

