Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAD607A2C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Oct 2022 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJUPKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiJUPK2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 11:10:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83295AC0
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 08:10:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f37so5593784lfv.8
        for <linux-pm@vger.kernel.org>; Fri, 21 Oct 2022 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TF6XEvFWOEgGd45xR42b2Ik4eFRVeWARvUbr71hDMcE=;
        b=KRmXFvyHUTg36Lgc4C6cPZqipnlxJ3e5OcYFJ4U0hCUoBED3qsJB6IxneioiSPfARF
         Rwbds9KpGW2mFOw0qbHD33d/ya85qVIKVGAq05kp6OyMIvtgII6O+tJeW9Aip9iy3RVF
         xjzZnET80g30lvQpHQDr6O34ocKDoy+aKAYLo9EZ2L8jsUdHfhZhlC659RFyJamBwgo6
         1qs3muh+x4kkc+r6awAAXP4gp9EaaP6KeN00AlLJy7JaBd2O/hD0qZruhkU2SZWvmFI6
         zJLSWvnEXbHqnNHfws7AGmVl6x4/1A/+VCIirmG9DFDkOn/qsxnER+YRYA6TWbScsxPz
         PCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TF6XEvFWOEgGd45xR42b2Ik4eFRVeWARvUbr71hDMcE=;
        b=kplqd4EBkEJiybKUmPk46ADjEWWifzt8pdu9kiOzKfAsmeAhOiWFO/WVFS5dvKmkiF
         fsdfj/a7m1esVeO6B2Bu4eQaNjWgPXlmxfpthtWgodfPauxeFKuvOtriU1shZSQ+IbzD
         tSZ0L5Gt9cXIfb3fb90IzvguzbfRGXQDe+HH5hUvyUqreyQB93DwJ9+YfMRYI+9D6edk
         A1dvAH9L1/GFfVxfc4o+vwVCB5Xy6HyrHeWJNhz/ggD0nX6JqJMauThFrxvZxurWeFXz
         7avrWl9olctDwQB8gb+o5q+f0owA/hrEQqjSvM9vXn8HaDtkUMZGidR+4DORhs9kz0tJ
         6e5w==
X-Gm-Message-State: ACrzQf11uxTNcd6pTmj8CmTlZysDnagY4rC0n9jkXDV7TGGQ6YDFvXjv
        U1h+pdDDwtW+A5UQPVDnAMr2hg==
X-Google-Smtp-Source: AMsMyM40Jny5+piUfDJS2esIl3pFcwenmI+hi4WYUHDOJI5I6NyvqyD45We26A1PjdeXicfFtq4NYA==
X-Received: by 2002:ac2:5e9d:0:b0:4a0:5828:6cf8 with SMTP id b29-20020ac25e9d000000b004a058286cf8mr6450268lfq.567.1666365021804;
        Fri, 21 Oct 2022 08:10:21 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512202a00b0049476667228sm3199764lfs.65.2022.10.21.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:10:20 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpuidle: dt: Return the correct numbers of parsed idle states
Date:   Fri, 21 Oct 2022 17:10:12 +0200
Message-Id: <20221021151013.148457-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While we correctly skips to initialize an idle state from a disabled idle
state node in DT, the returned value from dt_init_idle_driver() don't get
adjusted accordingly. Instead the number of found idle state nodes are
returned, while the callers are expecting the number of successfully
initialized idle states from DT.

This leads to cpuidle drivers unnecessarily continues to initialize their
idle state specific data. Moreover, in the case when all idle states have
been disabled in DT, we would end up registering a cpuidle driver, rather
than relying on the default arch specific idle call.

Fixes: 9f14da345599 ("drivers: cpuidle: implement DT based idle states infrastructure")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 252f2a9686a6..448bc796b0b4 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -223,6 +223,6 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 	 * also be 0 on platforms with missing DT idle states or legacy DT
 	 * configuration predating the DT idle states bindings.
 	 */
-	return i;
+	return state_idx - start_idx;
 }
 EXPORT_SYMBOL_GPL(dt_init_idle_driver);
-- 
2.34.1

