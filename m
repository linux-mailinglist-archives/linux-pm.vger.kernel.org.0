Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07CC605F75
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 13:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJTLzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJTLza (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 07:55:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A62F13332C
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 04:55:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a29so33181436lfo.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsYCCTAqbxl1nYegcA6XVTC9x8A8DOyUVzkeALJAq+8=;
        b=NBtRzRBtf3CHp+ZqCc1ugzJAxtf+FQVKg2znqKAHKcyqQD28FLc1pZigowJDa5b4cx
         T14yJBOg6h/DCw82V1QIGM5NujztBo7z5POKBdEh5+GvZIpQO2i62wrTbaUya4zjj0Jw
         nGJDa6LGC2eIuoWcU+F57K/9Qxd4SMDa/bgId48bb9tHTIDzwE95NvzZQyMscY4iPcD6
         UZwmxGMzeB2fHWb5jDfOtSSwUjZ3KGnLsHuHwaicwmoEa7hdVRhuEFI3rTONtWv3Ijlv
         OvKXGcaJibok55AsceVFipb8FoGx2bs8Kyk/0c5y0e2+o4xRRqSkc+sJnYg66ADBpmj8
         VOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsYCCTAqbxl1nYegcA6XVTC9x8A8DOyUVzkeALJAq+8=;
        b=muHdaTooqrnxfHhG3sWUTk61iLksb4c+FVetTfLm0fGtQVYDvSlxDlxrrXp1NNbAeV
         vxYf2FkB0Z7eV64Kw6HWASvg5S1tbn5bpd8uU685JKIlSiV0la1GPvffV1dNTbINnDJH
         i/J8Cl6IDsQ5P6iZ3xMlDG1bxP6Rgnvku56KT1c8V+0oKprMf6gCHnQIzezGsGTkhxUt
         q+2mfsyh51BO/k6jRxGcI3R0Q1hACxxRdTs4UAH9/k7miiWlwZfnRl3NmIjNEP3BqUzD
         zIOF07DmPTXVXDyQEptp4Oa8lAh7XKbpnVEXnIu/PalR0bL61lgdVvVy8A0a7aT/M7Ig
         R0Gw==
X-Gm-Message-State: ACrzQf3qoZj4+0pqeC3TfVQV+B4f3YPK9+85siVZX9F57uKe7Ws0Na/n
        RP0Rwk3MZmgZ6UZCT+nWb293rg==
X-Google-Smtp-Source: AMsMyM5ipN3ArP3zHYOiQQl4eLE64TxXPn3wOxrn/2+hiWFMuiv5mEYk8Kq5Z/mO5CmICg29fehyZw==
X-Received: by 2002:a05:6512:40d:b0:4a2:d61d:6c82 with SMTP id u13-20020a056512040d00b004a2d61d6c82mr4378263lfk.381.1666266927538;
        Thu, 20 Oct 2022 04:55:27 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b0049adf925d00sm2701626lfr.1.2022.10.20.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:55:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: psci: Extend information in log about OSI/PC mode
Date:   Thu, 20 Oct 2022 13:55:13 +0200
Message-Id: <20221020115513.93809-1-ulf.hansson@linaro.org>
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

It's useful to understand whether we are using OS-initiated (OSI) mode or
Platform Coordinated (PC) mode, when initializing the CPU PM domains.
Therefore, let's extend the print in the log after a successful probe with
this information.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 821984947ed9..c80cf9ddabd8 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -181,7 +181,8 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_pd;
 
-	pr_info("Initialized CPU PM domain topology\n");
+	pr_info("Initialized CPU PM domain topology using %s mode\n",
+		use_osi ? "OSI" : "PC");
 	return 0;
 
 put_node:
-- 
2.34.1

