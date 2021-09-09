Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E48405CFA
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbhIISs3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 14:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhIISs3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 14:48:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EBAC061574;
        Thu,  9 Sep 2021 11:47:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 6so3782137oiy.8;
        Thu, 09 Sep 2021 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwRbqLlU+vBHhW47NisueHvIdwrZ6Y450qWdiG8r04I=;
        b=IEjG7MIbBit01JAJsfL5xw6XzdLMiYT2+87sCixlJI06HjAKa8YhHwriizaoCci/NS
         Ym0sLagJeuHTfDYYluYYljTDosrYAneJtpHaRPOfV2vh2yHlceWYGfLKxxBYk956Bafb
         jCEJ/J97pZcbkZImJ7Re9Xrl0dIuofp21PFjfu2aqsnUYmy0xB3/KpNPEOlJWpa63Z5I
         5vmWwerYB7qLzlhjvyYq7cSqpDvy5fx5Js6pZGK3PYjesv44hC5Q2iLgLISwiaFAlpJo
         o2TslzGHMkNGtbWaNrRAjMauhxcIy6aICpt46t/mNxeI6kIbV7LsNuUFi1mPO6kaijvF
         DF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qwRbqLlU+vBHhW47NisueHvIdwrZ6Y450qWdiG8r04I=;
        b=8KKAmFGaVYY1VZ4fx0W6uP11CCWxTrbUmFISgsp/SaSlzytocTUEd4vMAYd/xOa9d1
         R6A2rwHdz3VDaug9xr6RYAahvge7PevIWvrDZzYWzm+OghH5/KI0YhAa38sy6GPRDaa3
         NmQwI1yeizKOtwg2Utu0t6+B8XADPS+40nuX3dY0Jd07gQjq73HsIbis2BYFlK55tsKA
         fC0y4XJQrgwjb7Hhpb9TNOoDOzM/Kj7aJBu2CSJhJzJMsdSxaR74PB/G2kC/Lf+hY3NL
         I+nRuyPngp/SdgHgFn/vHB3oaV97aaOeY5oDQL4pjxYS52O7lGhE8NpOyVmOACQXL6mE
         xsUA==
X-Gm-Message-State: AOAM533o259voxgMjwLpw1kuZJCdI3esXwrVbXJVainjYBKoThpU8f0y
        X21LWddz82EUHtFeiLiwuJ4=
X-Google-Smtp-Source: ABdhPJxbizi8vQ6oU6WAqJ7E1k0GFTGnx1TglkGdYBFWfzCsOSZTq5LnrTwpxdsgUAWWMzUFqtiCgg==
X-Received: by 2002:a05:6808:2116:: with SMTP id r22mr1014325oiw.128.1631213238100;
        Thu, 09 Sep 2021 11:47:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l4sm634203oth.4.2021.09.09.11.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] cpufreq: vexpress: Drop unused variable
Date:   Thu,  9 Sep 2021 11:47:14 -0700
Message-Id: <20210909184714.153068-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

arm:allmodconfig fails to build with the following error.

drivers/cpufreq/vexpress-spc-cpufreq.c:454:13: error:
					unused variable 'cur_cluster'

Remove the unused variable.

Fixes: bb8c26d9387f ("cpufreq: vexpress: Set CPUFREQ_IS_COOLING_DEV flag")
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 284b6bd040b1..d295f405c4bb 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -451,7 +451,6 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev;
-	int cur_cluster = cpu_to_cluster(policy->cpu);
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
-- 
2.33.0

