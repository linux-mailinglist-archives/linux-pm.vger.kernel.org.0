Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2D12BD90
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2019 13:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1Mjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Dec 2019 07:39:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35735 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfL1Mjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Dec 2019 07:39:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so10624640pfo.2
        for <linux-pm@vger.kernel.org>; Sat, 28 Dec 2019 04:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4pJrCuN0L5h2pRp7MOQkfd0sd+WwqLihlGnkEFbuKkg=;
        b=CkSmL4KadJeaRXr+W7ibOUAh1ewv/4KZJkZyH2I4ignNeb7Vw8fyMAOeiUUhF0Wm4K
         mdHvQD/pxSFMsGjBNPt6OlzBcp/1KjwEn8o7N2MuBW89ldUaW47pGC4vSm0MrfTt41Am
         vt7F0xD95QhQiphpbdkax6/s4FNlGvs8dFgDMU0gGJmEGu4kghMuTsYMbUF+lEjXfkvG
         MWRSffRmtitR8cvJp34/JhFqLcd+bhoFCrVG0iEqcBX4TVk6Or+bt9Y2VPMcW9DUf6+o
         DIAKGatwoh/AvftKaGdLHH3tLeVfpBnQqkQnC63uCoSGQnPlJYO9vTvNNIOnDSzkaSBJ
         4FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4pJrCuN0L5h2pRp7MOQkfd0sd+WwqLihlGnkEFbuKkg=;
        b=NpPLN96Er+jxz3CCvtzVe7ER6naSgoLmoPr1aA5Cj9oDXDVV6lw5rAlhWUnpLZmmQ1
         /jmu8WWI8I1wo29TIxLKHBOZtlhlb7ksr29Fa90+T9Lx1HhDc3tZ6ADE3ebAX+onSTpt
         D7WLs6JVxeKhuvu2wAh1HOkhZJ7pE4KzzaOpKx0YRu/fWLf+GeWXCSJNv7s+aOWq5rLJ
         JAgslGI38wNeK+8fTF1WW0r0NkblUpZIJQV643FHOputlWvlu1PyOb5a88LZs3JX2wsn
         4boETomD9CkqZSK/pxuV1N8m6WVAjT9CX1Y75MRby1EG5eT9vXYak0g6nR1i/xkvtKTO
         XNXA==
X-Gm-Message-State: APjAAAW7Fw+l5zsTc3+e4YA+A7HvbgVwqV9XX68axKZ6n7BG3dYAWMoB
        3QQ7U9MdZSceWtUnwTLbILg=
X-Google-Smtp-Source: APXvYqyFDhOvCHysU4l3DIouO5mcmq97FftOVvq1y/WhnCUf0Ut9o+2exJHn7ZeYo0cbcuUi2MGCDg==
X-Received: by 2002:a62:75d0:: with SMTP id q199mr43137436pfc.158.1577536791526;
        Sat, 28 Dec 2019 04:39:51 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id w6sm46281368pfq.99.2019.12.28.04.39.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 28 Dec 2019 04:39:50 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     mmayer@broadcom.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: avoid a stuck risk and UAF issue in brcm_avs_cpufreq_get()
Date:   Sat, 28 Dec 2019 20:39:37 +0800
Message-Id: <1577536777-24966-1-git-send-email-qiwuchen55@gmail.com>
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
cpufreq_online()  //If cpufreq initialization failed, goto out_free_policy.
    ->cpufreq_policy_free()	//Do cpufreq_policy free.
        ->cpufreq_policy_put_kobj()
            ->kobject_put()       //Skip if policy kfref count is not 1.
                ->cpufreq_sysfs_release()
                    ->complete()  //Complete policy->kobj_unregister.
                ->wait_for_completion() //Wait for policy->kobj_unregister.

A simple way to avoid this stuck risk is use cpufreq_cpu_get_raw()
instead of cpufreq_cpu_get(), since brcmstb-avs driver just wants
to get cpufreq policy.

What's more, there is a potential UAF issue in cpufreq_notify_transition()
that the cpufreq policy of current cpu has been released before using it.
So we should make a judgement to avoid it.

Thanks!
Qiwu

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d..7c4d60a 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -452,8 +452,15 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct private_data *priv = policy->driver_data;
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct private_data *priv;
+
+	if (!policy)
+		return NULL;
+
+	priv = policy->driver_data;
+	if (!priv || !priv->base)
+		return NULL;
 
 	return brcm_avs_get_frequency(priv->base);
 }
-- 
1.9.1

