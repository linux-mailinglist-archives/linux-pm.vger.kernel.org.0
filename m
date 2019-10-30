Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A097CE98EB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 10:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfJ3JL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 05:11:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40066 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJ3JL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 05:11:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so1236374wmm.5
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bOJ34PW9YadKMWVy7Lq7RFshOmanpmOaFJ0/LQDvOqk=;
        b=cPwCZVCovU/2CggOdtlONW+HZ6vJ7trmhL6nPvJqYuw/oD1PyHK17o3Tz6pwRytnQ8
         CrPypUXTHXlG8BoCEPtuwAzA9U1uWgHRJQwmCInvns67XnF+kWFy0hMm3NOG5UyoT/cq
         0ycPALIj/Vgu//Ye9inmkdYDNjuKDw+Hrd34RhvLlFEbc/kSbr/R3mRY1RMC4gZiT9rN
         EhnO++bBeYFzwPbTyiwXLJy9yvyiFFpxsBU07mk+fw/ft6vj7n0T73TZxecfbyBi6YRG
         vHcwmIrVz1R9pDf4v4cEcKi7LrjFnFzQ2c9pm5tvv48nHEtON21c7C45Avw6axIGDOI3
         6ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bOJ34PW9YadKMWVy7Lq7RFshOmanpmOaFJ0/LQDvOqk=;
        b=YcywIc4iaZgazfM7T5cJbEH4O4dgneUc7rBLw1SiI3D84CiPw4Ar9QMf51zVkxGj/l
         q9hJV5Iy9m70SnUmk781iNMSOqV+LDgnmqo/VCT1YStAuWfbheaUh5n3XDtNnqQ86CSl
         DU1owaUd4QynspLUrij1J+7N1LMBU31kAqPIOozFGE/OgvjMYae4AysYA6ixjhGuUelQ
         /z8LcaWUs/Bn/q4cqJ3VJKFtyknAr+wgZbcUX0DUAlYwR2jIsiVgz0CYTTrS9NMpef/b
         Ttfl55RYRYooIP5cSNHTfdPAPzqzsbzHz4p82l1wSA0wlZmT+8cTruT14k19tY17uGLM
         SUvg==
X-Gm-Message-State: APjAAAX/keDBrnXdbCRTsk964TypOQpEsK/JM4t+NqVE1+tIKbPsuuc6
        76qii2JmjnwplnZA4JZzXSgE9Q==
X-Google-Smtp-Source: APXvYqy0w7naVwNgnhQ/SgNL4RSoXuzbGVisLCeRIfRNlMZSRXD/MvlZHZRncQDBE1MAoEA51vnfOg==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr8250697wml.8.1572426686603;
        Wed, 30 Oct 2019 02:11:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2c7f:2fc:5551:ee55])
        by smtp.gmail.com with ESMTPSA id t24sm2608394wra.55.2019.10.30.02.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 02:11:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal: cpu_cooling: Remove pointless dependency on CONFIG_OF
Date:   Wed, 30 Oct 2019 10:10:36 +0100
Message-Id: <20191030091038.678-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The option CONFIG_CPU_THERMAL depends on CONFIG_OF in the Kconfig.

It it pointless to check if CONFIG_OF is set in the header file as
this is always true if CONFIG_CPU_THERMAL is true. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpu_cooling.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index bae54bb7c048..72d1c9c5e538 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -47,7 +47,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 }
 #endif	/* CONFIG_CPU_THERMAL */
 
-#if defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL)
+#ifdef CONFIG_CPU_THERMAL
 /**
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
  * @policy: cpufreq policy.
@@ -60,6 +60,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
-#endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
+#endif /* CONFIG_CPU_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

