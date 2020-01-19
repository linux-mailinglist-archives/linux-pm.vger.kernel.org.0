Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBC6141CB0
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2020 08:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgASHJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Jan 2020 02:09:16 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53292 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgASHJQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jan 2020 02:09:16 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so5201094pjc.3;
        Sat, 18 Jan 2020 23:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sbvECZSSaHMAVDSY442RQUtEQVv5nwhO7gX5LMPOXE8=;
        b=qPhDIkwPUi53pqaoMKRqIfieeqj1ieqrpyJEMQPUUMScs48YcTxa7ImvmRv3k7/AMi
         doIoxyETRKZEkj6NCki5WqfOCBvcRRzaBP3ysRi29m8PlKmdNY5hfO/afpv/uQKyYaWu
         QW8Mm8XJjO8WYObFpBZwFUpXm+8Pnf2Jp1kdRZCdFWch7kFbe2hZDa0yfZIgcvYZelWW
         LRj7jwDUQi4ryg/+zDUrpKhX2dGGMkejfsU4SqMGMxiLrBBJppdmanqIHHC2Bgbp/J/+
         52MDikL4ufrTNtXDq3iZY2MsHGBDwKnbRAxoFRY6gf2uMW8OSev4BW00KWiPDsQ+NZqm
         Vbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sbvECZSSaHMAVDSY442RQUtEQVv5nwhO7gX5LMPOXE8=;
        b=FWaRwqRRf5/yUgTuncqRbyPALls7fntQqLXxU4jcf+jWQdKrXI8w54dA4OY+U1rDpl
         wmD3iVzayIV742rynsR3+umrWTvj+SHmI1NjqA8+IN44cxAwXU00P08V9UcH8IBLzogw
         osJ8iELTgz6LIUDs6G4DR9iYYuTsP50sP6KqdHndtxMAkmTg6Bd87zgCAYtzAPfNqpx+
         ieAWNlmb/DSiA9opv1vzuipq8mU1Niwq6zUolIL8k1hz7Emn/aQ7ryg1hOvVndlPKoZ3
         DfvBHLQ1VX+vTLohpgliZCd9MxUEXNFNCk3ngnPN/0SHujrzEt+l4H4RWqYlwBvoK8Lh
         ufTQ==
X-Gm-Message-State: APjAAAWNs4tjP6ugTQ2uwtWGgGTZl3uYqJa6iTrHJxP96miTUdX3FPAK
        sFZithDbt3E/T+xpERVi9y4=
X-Google-Smtp-Source: APXvYqylvUE9U5kKGJKKCtFF5R4wOSj4PgYC36wH2joJSvO8f1bw+0REf9K1UBn1pMFr84tkV4BQrA==
X-Received: by 2002:a17:902:6805:: with SMTP id h5mr8058684plk.275.1579417755652;
        Sat, 18 Jan 2020 23:09:15 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id c184sm34015130pfa.39.2020.01.18.23.09.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 18 Jan 2020 23:09:15 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mmayer@broadcom.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH v3] cpufreq: brcmstb-avs: fix imbalance of cpufreq policy refcount
Date:   Sun, 19 Jan 2020 15:09:10 +0800
Message-Id: <1579417750-21984-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get the cpufreq policy,
meanwhile, it also increments the kobject reference count to mark it busy.
However, a corresponding call of cpufreq_cpu_put() is ignored to decrement
the kobject reference count back, which may lead to a potential stuck risk
that the cpuhp thread deadly waits for dropping of kobject refcount when
cpufreq policy free.

For fixing this bug, cpufreq_get_policy() is referenced to do a proper
cpufreq_cpu_get()/cpufreq_cpu_put() and fill a policy copy for the user.
If the policy return NULL, we just return 0 to hit the code path of
cpufreq_driver->get.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d..ee0d404 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -452,8 +452,16 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct private_data *priv = policy->driver_data;
+	struct cpufreq_policy policy;
+	struct private_data *priv;
+
+	/*
+	 * In case cpufreq policy has been released, just return 0.
+	 */
+	if (cpufreq_get_policy(&policy, cpu))
+		return 0;
+
+	priv = policy.driver_data;
 
 	return brcm_avs_get_frequency(priv->base);
 }
-- 
1.9.1

