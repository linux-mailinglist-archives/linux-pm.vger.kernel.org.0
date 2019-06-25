Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7591754DAB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 13:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfFYLdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 07:33:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfFYLdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 07:33:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so17439941wre.7
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jb+mp+rDj9DLSvOVTi217/rhPZn5ckg46P7fvQWw8bI=;
        b=b8O+q8+prWiPegbdgjjfIFOuD5BkeaA7JfC1MHz+Tc9x43b1tRTTjSTLnGoMlFQ6ul
         6aPkd4to4AnqNt1LUjRofjOUM3WGxDCGW6r/LDUCpIt71dR8i78wdpcep75jh7hjCjlI
         NOB//JopuNBp6KX8Nakjz+38eK4WMv6pIjMIUqWF8hSPUTD1zl9rREM4NNJ/IxniZN94
         n/GrA2nFH/lMlM8bACKhMEzqvlJT2YsaQ4Vog3WehS2DK6a/hp8sBQEf6hVbGRFkKtFd
         Ogqz5CUtiy2m8PfP5NtZ5/BgFkvchuk8P0m9F8fe/MyuaH58/HbhixDhKiZf83g5NjSJ
         4SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jb+mp+rDj9DLSvOVTi217/rhPZn5ckg46P7fvQWw8bI=;
        b=Brko5TZzasCi/NvxZDl0pOjK0QYyYLJ3KaUNO4mKKUd8j+/wYrzHfoRtWlTAa8Gh/S
         2V+FL9nl7RJSs7jwRNSzuDKy913Dc8SPMi8YEPXCjz6eBfL4bea4SzbpQhwiPYllvaug
         t5IYJJGE5yJP6FYrpyxG11C2UYaCYV1p8aCZhJg/UCJFWM6G1nNDc8Lvb5KIauSmT9iq
         gnXUvWzT7iVOaN7tTHPJFUUnyegnlE6TbfppltS7OK1iHbfLcgrfQ4BDoSjLJrh3HLFw
         Zk3CsSC+1uXtXmSyhW9J3pXwgLSdNDHb4HFgnthMarbXrsHOgbxmC10wYACZngsIOEor
         lfPA==
X-Gm-Message-State: APjAAAVSAZgQevH8cZaVPs2vIcqeSNoaX69+j78bdvTYIlcefB5s6sNF
        jhQR1IMYlt60hcPjvk29ognzxQ==
X-Google-Smtp-Source: APXvYqyDTRsg9JgGOVVsxssqrY+oHBPFPg8nvRzQM0sR5MIPPyTAr34aqUlQ3cxCDkSStjDs+UDDug==
X-Received: by 2002:adf:b78c:: with SMTP id s12mr49273824wre.264.1561462379160;
        Tue, 25 Jun 2019 04:32:59 -0700 (PDT)
Received: from clegane.local (191.184.66.86.rev.sfr.net. [86.66.184.191])
        by smtp.gmail.com with ESMTPSA id j7sm19254284wru.54.2019.06.25.04.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 04:32:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH V3 1/3] cpufreq: Move the IS_ENABLED(CPU_THERMAL) macro in a stub
Date:   Tue, 25 Jun 2019 13:32:41 +0200
Message-Id: <20190625113244.18146-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq_online and the cpufreq_offline [un]register the driver as
a cooling device. This is done if the driver is flagged as a cooling
device in addition with a IS_ENABLED macro to compile out the branching
code.

Group this test in a stub function added in the cpufreq header instead
of having the IS_ENABLED in the code path.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++----
 include/linux/cpufreq.h   | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..aee024e42618 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+	if (cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d01a74fbc4db..a1467aa7f58b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -409,6 +409,12 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 const char *cpufreq_get_current_driver(void);
 void *cpufreq_get_driver_data(void);
 
+static inline int cpufreq_thermal_control_enabled(struct cpufreq_driver *drv)
+{
+	return IS_ENABLED(CONFIG_CPU_THERMAL) &&
+		(drv->flags & CPUFREQ_IS_COOLING_DEV);
+}
+
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
 		unsigned int min, unsigned int max)
 {
-- 
2.17.1

