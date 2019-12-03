Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8067410F404
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 01:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLCAmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 19:42:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46866 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfLCAmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 19:42:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id a17so1357495lfi.13;
        Mon, 02 Dec 2019 16:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Er4Vc+z2ksR0zUUT5Njd+rmUl7+6DjOG6u4eDEnuSc=;
        b=J2lygnRYWnx4vzwi7HKXIyWtwvTVa7tK3dNI4j4nA95IjTgMVi4JQDgC171S1roy7z
         EQgJ/44YN9JumlaBJhIJYcpy7/YPktUH8i4CsIDC72ETHaQKX3XEC4Wm6YaSbhFT8Jpv
         TC8tM0wbxCrZ+4BsdNrNcZr8eiNOkejli/lJV9rMxTOtCQ+PwNx7YxXEL67RemehOzeT
         /4LT2QF2KrNTuovlKGaoZ7G+MEaT6m2husWmouNoJFFZjZlWWiuMXMeKy8DAc/gfX3r8
         r4OUEe1P8jDFxw5EUamNPuadg4ybTggOvdfd90k3E8UlndMFkYY4RJwfrn4SQ7RqnJgK
         R1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Er4Vc+z2ksR0zUUT5Njd+rmUl7+6DjOG6u4eDEnuSc=;
        b=ZJvslJO7PeNuoc5S7f+814jE3ag8QFp6hgFb5L9H9Zga911kDXgFyoSGP33FKEGG8s
         jGDoXuV8WJdsfPJWpEVfYs6xj5fawSb4QyyhyOGBJF7UgSlZ44pjOJEHWzIAGNh6JXib
         0e93Ljb2EPkcHKfoyjvgLPMKKuzrqhgWuWEqyaAHiLJ2RZK+fiAOEHsm+7RHZkx4/N19
         sAXgV4xQsJKgn2SkLv1MRckd9mBlkK/YJTT94cCQBL7QWVKitfjURfH8e2yKlBkGtxwX
         ZYLhXuMVwAbzHtD725KtRaQfTmxj/zDKyjeG61CwqOZGuG1R9bDNmN37dqqIfXDb25AQ
         KRcw==
X-Gm-Message-State: APjAAAVfVzrCMitX2CTADTrW4aqXgRuMjVs1rT6DXAt8XgynOBwOkh/I
        oUmqE/MFKW82nFoA+/b1+gmmjmOV
X-Google-Smtp-Source: APXvYqyYdC1ZeK54TKY4uYq4h3iOkIzqyAkex3VOXAi8DuXLsCh/MVu/UxqF/KaUTz75e40PMLK5Sw==
X-Received: by 2002:ac2:508f:: with SMTP id f15mr992482lfm.146.1575333733523;
        Mon, 02 Dec 2019 16:42:13 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:13 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/19] cpuidle: Avoid NULL dereference in cpuidle_driver_state_disabled()
Date:   Tue,  3 Dec 2019 03:41:09 +0300
Message-Id: <20191203004116.11771-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpumask is NULL if cpuidle_driver_state_disabled() is called before
cpuidle driver is initialized. This shouldn't be a problem for now because
cpuidle drivers are registered quite early. The NVIDIA Tegra cpuidle
driver is going to be moved to a later init stage and thus it could become
a problem if PCIE driver is probed earlier than cpuidle.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index c76423aaef4d..f8164f56c420 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -403,6 +403,9 @@ void cpuidle_driver_state_disabled(struct cpuidle_driver *drv, int idx,
 
 	mutex_lock(&cpuidle_lock);
 
+	if (!drv->cpumask)
+		goto unlock;
+
 	for_each_cpu(cpu, drv->cpumask) {
 		struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
 
@@ -415,5 +418,6 @@ void cpuidle_driver_state_disabled(struct cpuidle_driver *drv, int idx,
 			dev->states_usage[idx].disable &= ~CPUIDLE_STATE_DISABLED_BY_DRIVER;
 	}
 
+unlock:
 	mutex_unlock(&cpuidle_lock);
 }
-- 
2.24.0

