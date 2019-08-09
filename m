Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBA86F9C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 04:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404778AbfHICb0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 22:31:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfHICb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 22:31:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so45189223pfg.10
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2019 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMNqVTC61ypu+88qN0eTI1f8hSP5KZE17a9B+Qs+PMw=;
        b=jdzZbjEv1HGQgbPwhfoUEelLmCwVNm7oKg2xTku+3T3d2C+1HpkjpkWFpnrxfeR4N2
         W40UXxyZU0p2lcv1zz2jELuqIZaerygCoJguuwQu0dMEDLsesCRYW3BmBtKrdS9e1mYY
         IVhYzaUvLfXa/KgFxh8bMqIxG5X+Y8QByVIrizejtiFYxqU065gs08u93Z1HpR285MGh
         /6PQMs5j1M0QB6IepHTLIH7JA1Hc0S3Lr2HOXvzbA8fR4lHmU1P2HLMu3+sdXmX+rgKt
         UwQf4bO1S5s9Hxatos5UqPtGR85Wf6BYZqyKn1C1w1//21TrBoD9hBlJx0Nx7fCcUdZg
         gL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMNqVTC61ypu+88qN0eTI1f8hSP5KZE17a9B+Qs+PMw=;
        b=sdfhZoY4Ijp8/t86qIIZjwIe4EcMNhKgMMvh/LjOpHIZGqJEVLKxnIZNULyWbuADTO
         wXbZldX3+LDhDNuHEUD9WScP1xQIcsGuc1ZSsjcXOOZR5eZEA/YN32coGdelVOpDKvw9
         UqLS1TDaKgaWjboVkPR2J/4v3TOG9UGOJ0q2OA/MTE2QTKUlmExebznZrUxezmVQLR8a
         xHuqJuealArQCgqfI5KQzs+gBzAW9Z1St1WxwcCAu3jR5LAEDnXJV5iI0O4jaHvQcbIC
         62hQ6Q6Z8XW8cjJP+C6w/wl2DX/BP2IZedoiA+YhJQZKnf4aXodNI0SNpHOt5FU/gJDy
         a2bQ==
X-Gm-Message-State: APjAAAWubvpftDcMLQMWa6W3G6zuwKOqhYC2j9PIhQWvBqJy0q6uKv2Q
        P8KqA+H4Pa3w5vOa/aOvQqsI07yR/Kw=
X-Google-Smtp-Source: APXvYqxGPCk+7L2t3wh1awq3+I2SX3k9faPUfe81sclEk52lCogdeJYv3C7RfxYp6PJpFiv2mtp3Yw==
X-Received: by 2002:a65:6891:: with SMTP id e17mr15715871pgt.305.1565317885649;
        Thu, 08 Aug 2019 19:31:25 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id l31sm140038368pgm.63.2019.08.08.19.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 19:31:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: dev_pm_qos_update_request() can return 1 on success
Date:   Fri,  9 Aug 2019 08:01:17 +0530
Message-Id: <2b17498122cc3509db4e410cbf6f1d9605f2c70b.1565317865.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_qos_update_request() can return 1 on success, don't treat it as
error.

Fixes: 18c49926c4bf ("cpufreq: Add QoS requests for userspace constraints")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e0ee23895497..2e5ab042abe1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2519,7 +2519,7 @@ static int cpufreq_boost_set_sw(int state)
 		}
 
 		ret = dev_pm_qos_update_request(policy->max_freq_req, policy->max);
-		if (ret)
+		if (ret < 0)
 			break;
 	}
 
-- 
2.21.0.rc0.269.g1a574e7a288b

