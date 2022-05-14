Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA9C527283
	for <lists+linux-pm@lfdr.de>; Sat, 14 May 2022 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiENPUn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 May 2022 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiENPUn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 May 2022 11:20:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36692F031
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 08:20:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j4so19111311lfh.8
        for <linux-pm@vger.kernel.org>; Sat, 14 May 2022 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgEQZGj7XdPzKpml1xZjmFHRxmKWGvcEYL2lJUBaVsU=;
        b=m4skFe/fjMkgPeZRXHRT7lmXSxKYhwE0VfUTRb6cHXLVXCDTZt5kYDzRQN4cIad6Nx
         +FrVOkwHES6FDU42vMw/5rykZLePnGTUoeBjEXJhQVZj9Qayk2t1n9YpZg96DuECzAME
         RWTlrtbZOW5GSCumUcHWt8Vgpok46Zj7DOMqdhszEG96AbuK+JjKEn44NbI9ZV/v8eMJ
         oHVzLswLqY3uTDBt8WWlevlNynqtJwst1Utjvj5kO8EQz115KPb2lymke80pTSum56iq
         yTXeFxnJ4UcTJsWXwiHotDVDytOGWrJsF4W8vUSNznvd98uO07FIN8XePxzJBGDYh7Ng
         ZSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgEQZGj7XdPzKpml1xZjmFHRxmKWGvcEYL2lJUBaVsU=;
        b=R0tV9HvEkl74Oafks8kN4mjswhmfBrZKN6/rpdjaLtXC2i/N4h6O9O7g4YKLkTUEJY
         h5rddpMBEnhT/L1YBZFmihmVtxEVsQfpjnrdyTaEa5kZhN7A36cY7qQN9urmVzMPR1uJ
         /sSxX5wvA6PQexNzK2lcWv+fA5kbIvTqr6MRcmGV36i6xGtTKrKQtMXD+Nh9u+s+Djgg
         j5e/EXmdRN+wQcz0pGz9KWh7Ahk0Ga29OFvxf/ekpfh36/CS9tD4/JWmhxYfpZdMArAy
         ST/iaa6Nn87qeIIcuXKwKAYV7RYRlHOVW9ddKS7p/fNouKgRMqU/EgLt4ApimVADHdB9
         GETQ==
X-Gm-Message-State: AOAM533Nj8TcmLeyZu0I/HLNAM74zoPZmsFsDbgxQuiO+4klRaTHztBe
        FYNhb+N7zOk2AkZfgDsYgQvk9Q==
X-Google-Smtp-Source: ABdhPJzzPOWb8YcOcXdI0jUpKc7cMAmRKte6m/hGPjpztOpdV6al6mOvoJFC7cx2XnwypmlVC4xSzg==
X-Received: by 2002:a05:6512:553:b0:472:205b:97ba with SMTP id h19-20020a056512055300b00472205b97bamr7001418lfl.314.1652541640290;
        Sat, 14 May 2022 08:20:40 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id q18-20020a2e9152000000b0024f3d1daee5sm830413ljg.109.2022.05.14.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 08:20:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Anup Patel <anup@brainfault.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpuidle: psci: Fix regression leading to no genpd governor
Date:   Sat, 14 May 2022 17:20:32 +0200
Message-Id: <20220514152032.758738-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While factoring out the PM domain related code from PSCI domain driver into
a set of library functions, a regression when initializing the genpds got
introduced. More precisely, we fail to assign a genpd governor, so let's
fix this.

Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 755bbdfc5b82..3db4fca1172b 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -52,7 +52,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	struct generic_pm_domain *pd;
 	struct psci_pd_provider *pd_provider;
 	struct dev_power_governor *pd_gov;
-	int ret = -ENOMEM, state_count = 0;
+	int ret = -ENOMEM;
 
 	pd = dt_idle_pd_alloc(np, psci_dt_parse_state_node);
 	if (!pd)
@@ -71,7 +71,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
 
 	/* Use governor for CPU PM domains if it has some states to manage. */
-	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
+	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
 	ret = pm_genpd_init(pd, pd_gov, false);
 	if (ret)
-- 
2.25.1

