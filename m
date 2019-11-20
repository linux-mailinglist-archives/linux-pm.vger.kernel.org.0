Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92944103FB1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbfKTPpx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:45:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40863 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbfKTPpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:45:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so14400873pfl.7
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=G8asUZ+0MUW3NBVjjluOo+rKwiQgZJGohdw8KMKLHAE=;
        b=O/nv/MNtvKF9DpaeXdKEfk/PcEKxE00pZPHw6VLh6xy49SJ9dwGF6xydE0Wl9P1l//
         kk5YREZIMKPB5bgJiEqU4S0967vPAXa1c+cSzRVHYeAP7vpfPBTJMjRS5+/aJSU6MqPN
         k2rLEzmv9/RPIrxwNqSZQt8kFtLrURfzYaMjtB46lMMTtKPrAnyio8UO/kyf7pNjHJx7
         8GzsBDhn31VMZvklyMHzs83l8VQ9TyLRzkIo4QUWFKmfJ5Uw6UWvN27jrMUqCCvHOqMO
         4SPpVfQFeJP1h3BlnPrUqmyGGZtuQNPh2m2jW5cVwFDMBFSbej2XumW3mfZw950NYdrr
         xxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=G8asUZ+0MUW3NBVjjluOo+rKwiQgZJGohdw8KMKLHAE=;
        b=iNGaYpv+Tk1OOsMvpNu8cQh/4ygJLD2CywbVwRefxyKM1q1UPE6OYOfl8bVnPFWH2l
         l3T9Zf44dgkyS6Lm7LHtHKg0oie1+uwum4poTZLkIeHC0szs/t/Vr+XXfmXxSzw3Wan/
         kHz69iLkDwybzDxrJZHWQwFQddpAvSuC304AsgHkUKIzS65dG+xrN/7SuTWeD5W/ylmD
         EuEFW5j44Tx65VDYAKXo7ngI3Ay8N+aBNSDa1WG755R9Y526L7GrxiFmEamrneyhyb8q
         fjbcP9vjmi4O7a/aXBxSiGt84doDLhTI7G3RB+934fRdz+SDc/UaNrJBhc8oMZdcR7j5
         V/Tw==
X-Gm-Message-State: APjAAAVDSIP0uk05byx0ogWOiCp0wGINJwsz+mNX+9tamnv5uqbd8XEP
        v38KMi9eaO8xnTB2ArXgfgiRNQ==
X-Google-Smtp-Source: APXvYqxUqCiSUdn+ULvnrFf3ArsbDyDXwRbDbqTZ7g40QzhR4t3RQ79nWHNkXlBdHX86miMfsC6LFg==
X-Received: by 2002:a62:6385:: with SMTP id x127mr4959109pfb.244.1574264746474;
        Wed, 20 Nov 2019 07:45:46 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id s18sm31208564pfc.120.2019.11.20.07.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:45 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 05/11] thermal: max77620: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:14 +0530
Message-Id: <c943d51e7913a4b73cda447547b8ee77c857f7ba.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up the following warning when compiled with make W=1:

linux.git/drivers/thermal/max77620_thermal.c:48: warning: Function
parameter or member 'temp' not described in 'max77620_thermal_read_temp'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/max77620_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 88fd0fbe0cfa..82d06c7411eb 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -33,7 +33,7 @@ struct max77620_therm_info {
 /**
  * max77620_thermal_read_temp: Read PMIC die temperatue.
  * @data:	Device specific data.
- * temp:	Temperature in millidegrees Celsius
+ * @temp:	Temperature in millidegrees Celsius
  *
  * The actual temperature of PMIC die is not available from PMIC.
  * PMIC only tells the status if it has crossed or not the threshold level
-- 
2.20.1

