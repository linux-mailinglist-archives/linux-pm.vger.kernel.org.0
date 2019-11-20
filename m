Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9333103FAD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfKTPpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 10:45:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46107 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbfKTPpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 10:45:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id l4so13990809plt.13
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 07:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LB0mFTtKkHmo2cL12xdptGbf+C8Nvz2KFyNdinT86Hs=;
        b=Ozv7hJZqH8HGUR9P7JW0bGRieZObuXO21O+rOP+m+JocLXsFbjmIS6wZqm2AAlU+ns
         tO6Ukn+1PEnZi1PyTTv/o79FJhchMEw+I02xkgXAocUiVyy1QPPcXYNGr4oeEZ7eAADS
         /q2CKsqN8t++k8KFeA+U8Ykfs+Yi1UHvZQxH3ad7wUea8s0STHkCYkxxj5+DxgDDMVJ0
         UfC6nlhol5VLPIaphGXQLYuN+3g9u38AgNbOWe16OyZIzBIaDVUe/ZJJU5XW39KBPFSB
         pvzEvWKJcd/yolqJz/n+1tX1QL9gEQQw3GQTLdBnqqoOSUM7ZwfFcHota0z0NYHrmcG4
         +M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LB0mFTtKkHmo2cL12xdptGbf+C8Nvz2KFyNdinT86Hs=;
        b=ug++vVP4InKiTbbMPeL7KXRWCYBZLoJfIwsVijfbxXH7EIqQy+41+jktgZ6fWBdm8p
         QqC1KJfInXQw1Bw4rSfJDrWbhrVgCVKlfFu+poVBm4XjQPMYlkrmb5IcX3gTQfXV0jNI
         Nr0DR6RY7/5ReoWDHN7vSXsTAsbkYULCYaLMMnVVOzc0RuU8/5e0gTErcSV5RWlLRvv9
         Yv0F0qPW6JGFYtzxOS6z7ksqKSQRi1MINi3Bi+NVgo9e+qmbQxOPItkN7xBWy70YmjnR
         UNY+ZbMrYTGt5SRUKk91zPY0Ia0F/Ru9WYSkV0fDs0nHsZmJIlcaEgw9kl4f6j8ffL7S
         m5aw==
X-Gm-Message-State: APjAAAU0oQspU+GwZamgUST2/2biUkjwUi/atCESyGzWf5CdOAdD5GMk
        KwStOzWqTJNMahBhrhQquHwzIg==
X-Google-Smtp-Source: APXvYqyB42bSl+V4AlIGVMjAxYwx7VypP3HVgpqXRen6G2VGgOnmLvy7kE8oL/ksozcdL9YR6IvUBA==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr3666727pll.333.1574264742918;
        Wed, 20 Nov 2019 07:45:42 -0800 (PST)
Received: from localhost ([14.96.110.98])
        by smtp.gmail.com with ESMTPSA id i102sm7833530pje.17.2019.11.20.07.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 07:45:42 -0800 (PST)
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
Subject: [PATCH v2 04/11] thermal: devfreq_cooling: Appease the kernel-doc deity
Date:   Wed, 20 Nov 2019 21:15:13 +0530
Message-Id: <7059d82472fe12139fc7a3379c5b9716a23cce5c.1574242756.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1574242756.git.amit.kucheria@linaro.org>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix up the following warnings with make W=1:

linux.git/drivers/thermal/devfreq_cooling.c:68: warning: Function
parameter or member 'capped_state' not described in
'devfreq_cooling_device'
linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Function
parameter or member 'cdev' not described in 'devfreq_cooling_unregister'
linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Excess
function parameter 'dfc' description in 'devfreq_cooling_unregister'

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff..a87d4fa031c8 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -53,6 +53,7 @@ static DEFINE_IDA(devfreq_ida);
  *		'utilization' (which is	'busy_time / 'total_time').
  *		The 'res_util' range is from 100 to (power_table[state] * 100)
  *		for the corresponding 'state'.
+ * @capped_state:	index to cooling state with in dynamic power budget
  */
 struct devfreq_cooling_device {
 	int id;
@@ -587,7 +588,7 @@ EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
 /**
  * devfreq_cooling_unregister() - Unregister devfreq cooling device.
- * @dfc: Pointer to devfreq cooling device to unregister.
+ * @cdev: Pointer to devfreq cooling device to unregister.
  */
 void devfreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-- 
2.20.1

