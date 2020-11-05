Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484012A7CCD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 12:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgKELTu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 06:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKELTt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 06:19:49 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969C0C0613CF;
        Thu,  5 Nov 2020 03:19:49 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so1232293pgm.2;
        Thu, 05 Nov 2020 03:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6LlDxVopvTXrZYYwDpHLRIcnyqCk1QP6hWaB4YmXDAA=;
        b=GioMw7Qm8dt/8OrRBSfFZcZij1xGKpijpxDX/rNUGH2jXMCEFlGKkOO/9VZm7Q7OpV
         vf1jlPButpWSR/f3tQKeNnyeaO7VIKVvmHBYLszKQiEI9FUw8UCxbH5HkuQZ5G7NG8RC
         zacmnv1IZi4ZSmIGH1t9ryoc5bz4pmSpOdOqwajgY3vB8O6EnFBL3+I7Cm/L8RIoUWoN
         0l9k54AnhZS3EYqnLD0Mg+HTa3fJIh3GgaOyHJEKbiImvD0KLA0TBIuH+1Hu1R4ZGbuh
         y5/KGn97iLlFyuh9vUcVNhM7c4ACKW1DkTajPJgyXSZ/bl6cfre1WqMKeNvjT3At7+At
         Imow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6LlDxVopvTXrZYYwDpHLRIcnyqCk1QP6hWaB4YmXDAA=;
        b=mY4S0yvdv+pynggv75c+QYEWTeljlu0/7akX91uO2m/hnXZAC13N5LL1kn29TXsTIz
         PIQH+TwgwGNVRxpBrZlsWmUl1tTplNK0FOw5o1TkHfBkNMFEHS10gRWAgShNHQvsj+AR
         p7NFxKbC5QpxVso5zhyWjiGWBn42Z+VQqUG0Zh3lVdjwKwtiuaLLZ3Q6nDOK9PFwixQC
         qIfh+IGbiIKVo9f8jZq83PZPLkXoiNjKU8w81BJ+FEPPPxlLaqfMGSZg2IRpV9tjwlSp
         4ki/ACFQQlkdB/uv0MRijEwWLJAflfSDHcL/TYXXEmO6vREE2fSzIQK3vcHnIsb6snvO
         uk6w==
X-Gm-Message-State: AOAM531xzzograKMCIqhjvIccVR/YFC7KOuJ9edeBL+RaCGSnSAa7gq9
        bR9EHCAWoy/zXrM/BkKH4IU=
X-Google-Smtp-Source: ABdhPJwk+TpXZaS0XUcMx81Tj+dEYl+/2uiSGrGIMLNt42cLWXgtYqMJfpmDk6AZgW2BP1FCGDs9Zg==
X-Received: by 2002:a17:90a:f2cd:: with SMTP id gt13mr1956116pjb.179.1604575189185;
        Thu, 05 Nov 2020 03:19:49 -0800 (PST)
Received: from mi-OptiPlex-7060.mioffice.cn ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id n64sm2203486pfn.134.2020.11.05.03.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:19:48 -0800 (PST)
From:   zhuguangqing83@gmail.com
To:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH] thermal/drivers/cpufreq_cooling: Update cpufreq_state only if state has changed
Date:   Thu,  5 Nov 2020 19:19:14 +0800
Message-Id: <20201105111914.9324-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

If state has not changed successfully and we updated cpufreq_state,
next time when the new state is equal to cpufreq_state (not changed
successfully last time), we will return directly and miss a
freq_qos_update_request() that should have been.

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 drivers/thermal/cpufreq_cooling.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index cc2959f22f01..00dc26c33899 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -438,13 +438,12 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	if (cpufreq_cdev->cpufreq_state == state)
 		return 0;
 
-	cpufreq_cdev->cpufreq_state = state;
-
 	frequency = get_state_freq(cpufreq_cdev, state);
 
 	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
 
 	if (ret > 0) {
+		cpufreq_cdev->cpufreq_state = state;
 		cpus = cpufreq_cdev->policy->cpus;
 		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
 		capacity = frequency * max_capacity;
-- 
2.17.1

