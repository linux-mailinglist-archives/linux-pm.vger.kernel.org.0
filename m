Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF9589C2E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiHDNH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 09:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDNHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 09:07:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D0F15738
        for <linux-pm@vger.kernel.org>; Thu,  4 Aug 2022 06:07:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a13so22042772ljr.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Aug 2022 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2mPVyeBFtaU3RdKAsQho6cTa5+HorQ2Exu3btIiOUzk=;
        b=HmvDXaTStmNuX98PFb429ubH/UBs4kLSFIFuBj8o7ihM5eWHZj1Wzke9jRa5+sSWSO
         ohjRd2oFwKCQGNrORfIoLK9v1wxT+5tIUex3QZokknCXn3hAJ9tYakOCAi7DFPRi87ZW
         wrUlHjNyySKG9BIyzCzFkx6HDpjo9vn28k8MHNkRlL6jqrh6IFckUw8CpMoUtJWorL88
         qxX5DqKldk0EZkhaUhVZYgRG9oUEvn9420nNSDTkS0tsDHAfzinAvXH+UCeeMI4aw8kk
         GB5t1Q1Sb7Wu9QQQYeoFyUYivOkdad8UyZVb6PEy65Oswwhr5xxG5Q/R4Bmg9pHAyxD+
         6RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2mPVyeBFtaU3RdKAsQho6cTa5+HorQ2Exu3btIiOUzk=;
        b=lInqnDGhFA1/xdpc2OhC1hSHZSg/UQxH+F/2ZFS9MenJvLkFndL//8XM3/fH3hA4t6
         3L9kkl3ac6VkwhAXNQmmhe+7EUNn3nZ+ggmQaR0IX2xGIpHkvEx4v7RmySNDtz7MWa3z
         GZPJMGqjwhf1zTED22dBaNWo5XTad9uRevxM/HYHA+Z5dHdd+P0IUSssNGZtw8sMdi/I
         g8m+YC994STQa1VDW1+QPu8YLKo4SI/BJNAKWekCvmMO0fbeSMtWmQ2Cl48sSM6Gi7bk
         GijtXBR58+9XZqCRoUTWfH0V/WLYcaV06oausrP+W9O2V/hdEPdo8CNOVXOkGywTm6QK
         Dj9g==
X-Gm-Message-State: ACgBeo3PhKOqTsqVzyv7t+vjc15Piq/r6urLKbSxp9Hqw6YCrEy9MJsf
        Z7jmsCSIPHJEARrrWWBAu2Uvlw==
X-Google-Smtp-Source: AA6agR4P3wAFSoGlT84eB+C6qr4BOR//C22QuoriJle9qYybcIXddWfc6ZqOhEJZc5bOFU9JechAYQ==
X-Received: by 2002:a2e:82c5:0:b0:25d:83d8:41b with SMTP id n5-20020a2e82c5000000b0025d83d8041bmr548955ljh.140.1659618472301;
        Thu, 04 Aug 2022 06:07:52 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o20-20020a2e9b54000000b0025e2c5a12b6sm115743ljj.129.2022.08.04.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:07:51 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] firmware/psci: Print a warning if PSCI doesn't accept PC mode
Date:   Thu,  4 Aug 2022 16:07:50 +0300
Message-Id: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function psci_pd_try_set_osi_mode() will print an error if enabling
OSI mode fails. To ease debugging PSCI issues print corresponding
message if switching to PC mode fails too.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
This is a replacement for [1], now moving the warning from
psci_set_osi_mode() callers to the function iself.

https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/

---
 drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
 drivers/firmware/psci/psci.c          | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 3db4fca1172b..821984947ed9 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
 		return false;
 
 	ret = psci_set_osi_mode(true);
-	if (ret) {
-		pr_warn("failed to enable OSI mode: %d\n", ret);
+	if (ret)
 		return false;
-	}
 
 	return true;
 }
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..1628f1edef4a 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -163,6 +163,8 @@ int psci_set_osi_mode(bool enable)
 			PSCI_1_0_SUSPEND_MODE_PC;
 
 	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
+	if (err < 0)
+		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
 	return psci_to_linux_errno(err);
 }
 
-- 
2.35.1

