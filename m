Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9488F3E9D92
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 06:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhHLEgc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhHLEgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 00:36:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9DC06179F
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso7848920pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQGKod+1toETrZZygbeTDI/UD9O56l1AgluTcAmsQr0=;
        b=hpGYNDBGEyQkLVHPIW1XmsAQfqm6lMtcizJZT9wFryqif4CvN6lQx93IkKP+CIH8RC
         3ne6sueHneC5rp8enoVSBifcSV46fJ4r1rdWZFacDGaU2r5q3yG0w1EYLkgwfXhkbpDg
         a7wE0mqWmfyfHb7mozVb34JlMjsJq0P0s/XK6pcoh3YxlMODM8llnCSTngTAthw6U0Ab
         j0+ktxEXSk5SSG29DI1dvgDO9qhDBmMhNWgJI9ScSMFXWzd/w0n/oWZqiptOp710AGFO
         aSnYZDsdnO2aeQ6vNAf11Au7QNAkQcINdZsGQXZwPGb9K5H7Hi8jvqB+M6J6bj3cxvSk
         xvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQGKod+1toETrZZygbeTDI/UD9O56l1AgluTcAmsQr0=;
        b=mLjFlIiVYJg77LD2GBVodKcdYxzPhmyrLyr6l/7LZm7sB8c6DVdGQ27cyAxZcGWW/Q
         H7Zk8nr76tbGQEAC9fBDvcaaWTm8o9YgzDKbD0vdrGOoPN07P9Grpud2+EPCTVGoypkj
         5rXjuquGmi1FM0Z4zQQ0mFfyhAOv31JbJeuLbkHOL1NGUpQJfK1sMMfx/IeLO92NQ7Cr
         fqVsVmRi3FiEQCpnbF3nNr68mA9Pa33DHLsDOVO5nWHUQguifhLU+nlSW7rRBk1UX4dA
         90JOHN5eUL1R0W7pKqoIN7fpq0Ts+3CuujqU3FDSDPmjx2c48DUbxDOKJJVuN+ZBo89N
         hcjg==
X-Gm-Message-State: AOAM532a+eMVUY+vmqqKh/jrkctg2fS48c63+nGyPNgy4AtnLizM5yfg
        uSOP/fZWaHYVS0QDSyqDh8TL5g==
X-Google-Smtp-Source: ABdhPJzAA8MudywLLhjtP/QQ1IdErDufK2tfnse1BeGPHYp5ecjPRoSLdcxO7iykErJEhDI8plZm7g==
X-Received: by 2002:a63:ef02:: with SMTP id u2mr2198232pgh.298.1628742959909;
        Wed, 11 Aug 2021 21:35:59 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id t18sm535357pfg.111.2021.08.11.21.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:35:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/9] cpufreq: omap: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:18 +0530
Message-Id: <361a172d230964807c0b479738749c50d95d7b50.1628742634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to register with the EM core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index e035ee216b0f..1b50df06c6bc 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -131,7 +131,6 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 
 	/* FIXME: what's the actual transition time? */
 	cpufreq_generic_init(policy, freq_table, 300 * 1000);
-	dev_pm_opp_of_register_em(mpu_dev, policy->cpus);
 
 	return 0;
 }
@@ -150,6 +149,7 @@ static struct cpufreq_driver omap_driver = {
 	.get		= cpufreq_generic_get,
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
+	.register_em	= cpufreq_register_em_with_opp,
 	.name		= "omap",
 	.attr		= cpufreq_generic_attr,
 };
-- 
2.31.1.272.g89b43f80a514

