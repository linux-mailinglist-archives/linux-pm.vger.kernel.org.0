Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86E41970B5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 00:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgC2WHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 18:07:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34358 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgC2WHW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 18:07:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id 65so18970384wrl.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2020 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=ncVvgdoulw7o7+hBR1P2C+5Gs5JoBGlqRw0Sy1xicTm6q81nvOAS+m7a5UAWRL9hRH
         yEbh65k8Qx8xlZhH0t43wKusHLa9vKtTn3P+o7chr1k8b9HOg212dwNDe5UIqqTkPvM5
         NjK59RhAv/AjjS9C+ePeOxUTr8KWfjEGW0BnrhZMLZGYwJHih6Qa7NlJ/q3h/TBv2CvI
         qzt8o6Axgo5Rp3OXRAuFzRgZOB7AaPhJpa0QD51Rx0V4DJiIolUALmRUp3al9xzVNBGD
         TgMdtaHIkMZxLrKJPW3dDuRzt6b6bi9q5B+CInP1E93ReaqlZkh762PlTAokY1xMgBP/
         HxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1LHaTJUSb6YlKNJo8uEXGOXHLnntD8wG0lKLYJJal8o=;
        b=tH89z5Db8QtMoBchc0qDRyedyXOMY6i4jjOcWmOBV2qGdJflCpXRDYKp3PVIFfnWWe
         aqZMo259wqStqXNBQJzm+KoHEdoBM3vj36Lr18Nb+OJWvacajjfqfLt7ZatZQMs6a6+4
         ZEJtGDO4h2fS9wbWIjaU07NVro8Vrz2QjEkg4Xp3iWIAhfnIbpWHXXueen8lCH9E/iC5
         CIoA4UHCzg25B8EJGldrT3v7SnytLYhVeSlD4e+DJJ7TI0nGehtKAlcWMOme3pl5Fpuz
         L/4XXDq084nUgUfiOwUDZFFycR7puISawxPW2AgvgVes4PBysA2GZGlTJLkY+9PQywCt
         ChKA==
X-Gm-Message-State: ANhLgQ1SetKqKo+Caky9jylgrems3C26/IdylCe5NSna1PRoWve152P1
        4q4TudTDiLNPQMlQ/H8+m+Ii+g==
X-Google-Smtp-Source: ADFU+vuZAg1AC05bxtW27+WzlliBGq0FOpLpXh2o2GNXEgxWNashf38ZSEyqqKofOBjuURsc40gIDw==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr11842551wrt.92.1585519639340;
        Sun, 29 Mar 2020 15:07:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:78b1:4459:6959:42d0])
        by smtp.gmail.com with ESMTPSA id j188sm20026740wmj.36.2020.03.29.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:07:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, robh@kernel.org
Cc:     daniel.lezcano@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (open list:CPUIDLE DRIVER - ARM
        PSCI)
Subject: [PATCH 4/4] thermal: cpuidle: Register cpuidle cooling device
Date:   Mon, 30 Mar 2020 00:03:20 +0200
Message-Id: <20200329220324.8785-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329220324.8785-1-daniel.lezcano@linaro.org>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpuidle driver can be used as a cooling device by injecting idle
cycles. The DT binding for the idle state added an optional

When the property is set, register the cpuidle driver with the idle
state node pointer as a cooling device. The thermal framework will do
the association automatically with the thermal zone via the
cooling-device defined in the device tree cooling-maps section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c  | 5 +++++
 drivers/cpuidle/cpuidle-psci.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 9e5156d39627..2406ac0ae134 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index edd7a54ef0d3..8e805bff646f 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	ret = cpuidle_cooling_register(drv);
+	if (ret)
+		pr_err("Failed to register the idle cooling device: %d\n", ret);
+
 	return 0;
 
 out_kfree_drv:
-- 
2.17.1

