Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A880C3E9D97
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 06:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhHLEgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhHLEgc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 00:36:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631A9C06179C
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a20so5675196plm.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HVQrCOVXbcxMp8JFbwYQtdcMjF/4FzEzkmzk55j+qs=;
        b=NNjORvu+ttL+CFOCo7D45Yn4LkvAxOR6f1Gig7ouC62A9kFpKoUe+B2COQqZWaYo6s
         EFIYD1i7xT7d/uesW+whvQ0HXxm6JTTg1qLK54j2OSMtPRCUxl9OXDWyC8e6TB+mI1xp
         vtRGa2cNSu2wpcduh7fOk2wtwcLh54+uC6BCn4VlZkvGvDmkdngjtH59OZwiyA4FCkyx
         LGXgxK5oSvMflvnvQwtENwczgV95ZjV1tURh2AiHsWlbE19/RPL172iKJ5qMJ8E/2ANW
         1awLQnOKL7j4sq0yX8k61HIcI411xUOgD0oF4HwXTYYHiUM9SNijv0EW1LGlI1D8KHhV
         ZG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HVQrCOVXbcxMp8JFbwYQtdcMjF/4FzEzkmzk55j+qs=;
        b=cm0YhoxI4EBVFtN0wkj+eObwgLp4WVnH12PWtVO51ctGLHMFQeI3smh0jwFFQYU5Wz
         xI0rH0GeJn3wLUJlUwYX2Xr5ttgeaWxU9LYLWTShUuuNFNvv0uMUDT3R9QROmyqbu12B
         +UEpw0BtgryqIcFj5PpH+XvHHx77FapiF58VOkAJgjuUemYr+qPc+VppR1yz2kT5PViz
         85A8lTxiMX3NDzt/msEmOOq0AGES0hSDZ4x99tOZV/S11VFxEVEEJr5Zr8YMqSA6/MXR
         ShsSjFYcr3G2K1FdyXON+tQpnxdn9oF5QcNTiDzPuvzER/3UdoBxopSThQBVeNyef4ws
         t+ug==
X-Gm-Message-State: AOAM531uu6T2exMwVVFO5toHkGDqz+DfKzuVBPqSpOMs2Eyda0CuugfB
        0Ovo3GwgNcBskyqK9QGAokoPaw==
X-Google-Smtp-Source: ABdhPJzKJOCMQjx/Zlei5DgLRLP0WZUL1IsXTMITDjm0abr1tzgWWaZnfPz+bwvVAuWhp6gaZXwpfA==
X-Received: by 2002:a62:e405:0:b029:3c8:e5ab:ca94 with SMTP id r5-20020a62e4050000b02903c8e5abca94mr2302045pfh.5.1628742967964;
        Wed, 11 Aug 2021 21:36:07 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id e8sm1433156pgg.31.2021.08.11.21.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:36:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 8/9] cpufreq: vexpress: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:21 +0530
Message-Id: <b64eea485feb5cfb18e74e100dea49c917d4474a.1628742634.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/vexpress-spc-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index ab56813b7256..284b6bd040b1 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -440,8 +440,6 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = freq_table[cur_cluster];
 	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) =
 						clk_get_cpu_rate(policy->cpu);
@@ -475,6 +473,7 @@ static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.get			= ve_spc_cpufreq_get_rate,
 	.init			= ve_spc_cpufreq_init,
 	.exit			= ve_spc_cpufreq_exit,
+	.register_em		= cpufreq_register_em_with_opp,
 	.attr			= cpufreq_generic_attr,
 };
 
-- 
2.31.1.272.g89b43f80a514

