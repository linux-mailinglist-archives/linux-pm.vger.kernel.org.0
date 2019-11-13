Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA15FB826
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 19:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKMSyp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 13:54:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34061 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfKMSyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 13:54:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so5602126wmk.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=znf7mo4G9jPIzVfiurHEWnDBV3kCfIxmHe1zoQ/j1JI=;
        b=jXqpKJGh1V1p5/zJKPLSg8aHuXISAB+G6IUG18JBJ++ehzluBYs0E7RavYC25cumyh
         zylqE+mpEVyNVyEFmLw0uCdQi1P8cwzPE5q10jbtC157GvZwsg138aXk0Hv7RgOswA1q
         K9v27zdFW1hggQaqzvF9WZ1sz2eaKn/3YM6w9FbLsSPvPXR0K24Bn0jWRdqqhkM+V4ie
         gXaOtkQRnA5oINYeBEzRNQT7bHQO3YhGy+r10vMKcjpJyj74YWSegP0Ka9kz6r6QdKZn
         GkoqMj/u4If5cgtA70HuerUoNfQDA4sUz/4UV3lC+pfcttUY0x6tzv+iJwPQIFK84oUt
         Lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=znf7mo4G9jPIzVfiurHEWnDBV3kCfIxmHe1zoQ/j1JI=;
        b=CL7vA+N4CdFduFuiPKtuR37b+eQCC0J205sejB/6QSGsrZXj3C+/hdqAhIGP7fLp4O
         2p+7zUCasIo8A2z5VLWhHVoMa4x1F3wu5pMOqdVbnBK6gDkkBj4EgyZtnapkVpSVDhEY
         JJDDIiuCoSW38uG9VWxcwdmByCvrJtpTGH8lXTGKFXk5ldlNiDdaRUTUPLdYZ64jaF8O
         njoxd4rl+n7vv6a1KYuJdTuMvdyibWTHVwsJCsXM2lz3L94KAogMh/xf38fxBdW7mRIQ
         2vUaW5KjjDNQsL1bhOORvt2srhPipIDpX1mdahJDDZwyWMIHLac1/1gJxmV7W4BQTg53
         I4Qg==
X-Gm-Message-State: APjAAAUqM/Ai/mLuNwZ5LpEHQ+Rlzi4N+r1fXwxi1/FOS0fDKRiZ4fKR
        wX9kI7pc+Ww2lrAq0Hd5hkn3ig==
X-Google-Smtp-Source: APXvYqwwH8BCjmSktAETpbChLwTN/XW+mm39prw4iii5WPmKfFcupKLbgzRkJjUgZvfEw0qFgCe7ug==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr4491750wmc.28.1573671273779;
        Wed, 13 Nov 2019 10:54:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ec92:781d:6592:837])
        by smtp.gmail.com with ESMTPSA id 17sm2652848wmg.19.2019.11.13.10.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:54:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH RFC 3/3] cpuidle: Use the latency to call find_deepest_idle_state
Date:   Wed, 13 Nov 2019 19:54:19 +0100
Message-Id: <20191113185419.13305-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113185419.13305-1-daniel.lezcano@linaro.org>
References: <20191113185419.13305-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the dev->use_latency is filled with the latency value when this
function is called, use it as a parameter to the
find_deepest_idle_state() function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f68a6c9e8482..659d8b1ece6d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -124,7 +124,7 @@ void cpuidle_use_latency(unsigned int latency)
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev)
 {
-	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
+	return find_deepest_state(drv, dev, dev->use_latency, 0, false);
 }
 
 #ifdef CONFIG_SUSPEND
-- 
2.17.1

