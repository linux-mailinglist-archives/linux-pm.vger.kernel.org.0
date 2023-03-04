Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233506AA896
	for <lists+linux-pm@lfdr.de>; Sat,  4 Mar 2023 08:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCDHl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Mar 2023 02:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDHl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Mar 2023 02:41:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F52B62C
        for <linux-pm@vger.kernel.org>; Fri,  3 Mar 2023 23:41:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i5so5090577pla.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Mar 2023 23:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onGECTlzCF+rI5jirJ26p2wCglobbVeSGFOjZxWv4BE=;
        b=Qzwq8d8BN11Vk6QP+JlXkVxSkfKm67lP3g4vexmkNImvu+9z1cwPg0hhp6otmDuvKK
         SPjzVbBcGC8ls56aIa6r+wCDGeD1GSKIhax4oZsN38nXMyGF1r2dyhZzZvs8xmlKZjtR
         IpBwDVutBEchavZVIPtceqxQiZU+Mp+xOn+eCrRu+SvKUzyx5Bn6FtQnLv8x0Hi1/SF4
         FyEo+LXXHbrpqWc8xRBsJ1iQVmjKUyqs8j87y2jr9NjRBJhKHYNvhANxKmf+W/Ck0Pna
         qZJjssNDXlP/Ug46LW2sWqJBozWrWK91s5na4Ot4UmbhqC1PChBMetYyMg6RrJZdGtr4
         JJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onGECTlzCF+rI5jirJ26p2wCglobbVeSGFOjZxWv4BE=;
        b=w56YM8ISwnI7WTWHwndkUxraopEWTQd+jR8XA4zT0ZtRqyCCSzKkhdlbeu7OIzWKPj
         Lboy0LEfJ6orjKc1gPZ1iOwjTYUgkI6NVcOr4BV+zYCK703v2AlTKONTGtVn6AxKkljO
         /7TQLlK7KzRh7a2DPiplvbq0kK9crOlgM2auPBO/4Is3Neun2LDGRtqGry2mtKvh6EuR
         SAVQU4g0lcpYRMEHRck+gbpoA0ldnty3wSP8w7E5rrexpgApJ3c37d0T3F3sueb2QGxP
         P0SVL5KVvDv9T+rDAvNcrO4t+2lDBkliUhHDvd3a3teudSGVCturX8jTy6Ws97RmdTtI
         BXrg==
X-Gm-Message-State: AO0yUKV0OpC3Fw59qviASDvVCJkcybsqX983rvx90ON12iqAm0/q49AK
        H/p+GQ6q7iS5K3lZUkpMyob4jthpgFcsIegUSCg=
X-Google-Smtp-Source: AK7set9R7mALzTFfjb3AGkdnIVFGf4fQB2ZSSubUjiTDsQoW3TL60kIg5sRmTb27Wor3JiQiSQ6Izg==
X-Received: by 2002:a17:903:2344:b0:19e:6e29:2a8c with SMTP id c4-20020a170903234400b0019e6e292a8cmr5506800plh.5.1677915686715;
        Fri, 03 Mar 2023 23:41:26 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id km12-20020a17090327cc00b0019e30e3068bsm2713471plb.168.2023.03.03.23.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 23:41:25 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND] cpuidle: psci: Iterate backwards over list in psci_pd_remove()
Date:   Sat,  4 Mar 2023 15:41:07 +0800
Message-Id: <20230304074107.59083-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
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

In case that psci_pd_init_topology() fails for some reason,
psci_pd_remove() will be responsible for deleting provider and removing
genpd from psci_pd_providers list.  There will be a failure when removing
the cluster PD, because the cpu (child) PDs haven't been removed.

[    0.050232] CPUidle PSCI: init PM domain cpu0
[    0.050278] CPUidle PSCI: init PM domain cpu1
[    0.050329] CPUidle PSCI: init PM domain cpu2
[    0.050370] CPUidle PSCI: init PM domain cpu3
[    0.050422] CPUidle PSCI: init PM domain cpu-cluster0
[    0.050475] PM: genpd_remove: unable to remove cpu-cluster0
[    0.051412] PM: genpd_remove: removed cpu3
[    0.051449] PM: genpd_remove: removed cpu2
[    0.051499] PM: genpd_remove: removed cpu1
[    0.051546] PM: genpd_remove: removed cpu0

Fix the problem by iterating the provider list reversely, so that parent
PD gets removed after child's PDs like below.

[    0.029052] CPUidle PSCI: init PM domain cpu0
[    0.029076] CPUidle PSCI: init PM domain cpu1
[    0.029103] CPUidle PSCI: init PM domain cpu2
[    0.029124] CPUidle PSCI: init PM domain cpu3
[    0.029151] CPUidle PSCI: init PM domain cpu-cluster0
[    0.029647] PM: genpd_remove: removed cpu0
[    0.029666] PM: genpd_remove: removed cpu1
[    0.029690] PM: genpd_remove: removed cpu2
[    0.029714] PM: genpd_remove: removed cpu3
[    0.029738] PM: genpd_remove: removed cpu-cluster0

Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Hi Rafael,

This is a resend of the patch [1].  Could you help pick it up or let me
know if there is anything need to be improved, thanks!

Shawn

[1] https://lore.kernel.org/linux-arm-kernel/20220308082931.3385902-1-shawn.guo@linaro.org/

 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c80cf9ddabd8..1fca250d5dec 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -103,7 +103,8 @@ static void psci_pd_remove(void)
 	struct psci_pd_provider *pd_provider, *it;
 	struct generic_pm_domain *genpd;
 
-	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
+	list_for_each_entry_safe_reverse(pd_provider, it,
+					 &psci_pd_providers, link) {
 		of_genpd_del_provider(pd_provider->node);
 
 		genpd = of_genpd_remove_last(pd_provider->node);
-- 
2.25.1

