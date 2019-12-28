Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3812BCD9
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2019 07:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfL1GPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Dec 2019 01:15:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34358 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfL1GPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Dec 2019 01:15:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so12553192pln.1;
        Fri, 27 Dec 2019 22:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qe6cSiGPXPhmquRmJ+vPfyD3fRySMNawHDWjAW0LBjw=;
        b=mSbekCGB4AVcrFqm765lc5SaSM4aAYaisiGXUoW/1H2dX9x3XCyGFhyYGvJ7CAxF0Q
         i3k//4abu6O5iYqmX0H5lFXruYG78sTBGK3mocMEcU5pUqKdsJ/Qhs8SShcAW1+mvn8k
         LCvJ1sNGbRlpgMJ+nECm555asbw4gIq1l7liz6zRp12cYiCFQUv45axwicQY0n8WbGDo
         ZejPXP7ufiq0d0sC5o/MD8vNS6TVAozMG2QFHE5Q0FzQ4cyMBe0jyc8hxb3irxY86sWX
         AYIl7Le9dcORNFwYb7IkRbUEbB457F+6Urp/7tFbwMHcE6StbYQ5l5MIdz/Vxa1HyEkm
         pGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qe6cSiGPXPhmquRmJ+vPfyD3fRySMNawHDWjAW0LBjw=;
        b=sK5WrDYhvVcuW9mxKeGki681GcSAYAhBdqNrSkp35XBo+8/OtqMm6Qjxju/oOKhyLZ
         V446Uz2YikTtMfCcW496UShQdvEaU3qgmYsgGIqt7k9YisyqbzKRHXxvelh1RHSj5b2I
         ieNBtDx9RBy5ZnJynoPUGlISB9XDYW9zJGVTcRbeCWVuZbzfP87glJzmxfWGGN7GsXYU
         9KI3GYRkIcy1sGQUHnwk/UvNG2SCPLHFYxq0MS/h57vbIawMKH5b6z8eJGEXXYk6zu8s
         CH0sFyvmx4lpU69lmxbHjBKCm7rh1ns1FpmiFatbeUnkV47SWxCGZZp3nRqwDTZ8vw1k
         dnHw==
X-Gm-Message-State: APjAAAXQYBgR0yBymMu6/4vJFEuhQHKEgC0KabOAVZUWbxLl/RDew7uH
        +JybiF6YEVd4N0puklI5dl8=
X-Google-Smtp-Source: APXvYqz2bcxQFOhSNl7uvapbX387WUr60/UnSgG+VSIdTO4YpwUM2lqbK73iE31Un0HN1Uc2lN2I/g==
X-Received: by 2002:a17:90a:300b:: with SMTP id g11mr30676779pjb.123.1577513737609;
        Fri, 27 Dec 2019 22:15:37 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id x65sm44401182pfb.171.2019.12.27.22.15.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Dec 2019 22:15:37 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mmayer@broadcom.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: avoid a stuck risk and UAF issue in brcm_avs_cpufreq_get()
Date:   Sat, 28 Dec 2019 14:15:30 +0800
Message-Id: <1577513730-14254-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

brcm_avs_cpufreq_get() calls cpufreq_cpu_get() to get cpufreq policy,
meanwhile, it also increments the kobject reference count of policy to
mark it busy. However, a corresponding call to cpufreq_cpu_put() is
ignored to decrement the kobject reference count back, which may lead
to a potential stuck risk that cpuhp thread deadly wait for dropping
of refcount when cpufreq policy free.

The call trace of stuck risk could be:
cpufreq_online()	//cpufreq initialization failed, goto out_free_policy.
    ->cpufreq_policy_free()	//do cpufreq_policy free.
	->cpufreq_policy_put_kobj()
            ->kobject_put()	//skip if policy kfref count is not 1.
                ->cpufreq_sysfs_release()
                    ->complete()	//complete policy->kobj_unregister.
                ->wait_for_completion() //wait for policy->kobj_unregister.

A simple way to avoid this stuck risk is use cpufreq_cpu_get_raw() instead
of cpufreq_cpu_get(), since brcmstb-avs driver just want to get cpufreq
policy in cpufreq_notify_transition().

What's more, there is a potential UAF issue in cpufreq_notify_transition()
that the cpufreq policy of current cpu has been released before using it.
So we should make a judgement to avoid it.

Thanks!
Qiwu

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d..31aa76f 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -452,8 +452,17 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct private_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct private_data *priv;
+
+	if (!policy) {
+		dev_warn(dev, "cpu %d: CPUFreq policy not found\n", cpu);
+		return NULL;
+	}
+
+	priv = policy->driver_data;
+	if (!priv || !priv->base)
+		return NULL;
 
 	return brcm_avs_get_frequency(priv->base);
 }
-- 
1.9.1

