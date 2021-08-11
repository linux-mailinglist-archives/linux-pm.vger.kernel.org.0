Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D73E901A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhHKMHD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhHKMG6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:06:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AFCC0617A0
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d1so2432358pll.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXHghljtL4EI/XqtTqMJz5EFL6+UxuiO/TdGXUvnvkE=;
        b=pGvvmyLgKXMq/gHVrO+ZoqLit5xJiuyTTDJ8SaKmoTWv2du9Ih0MpPYTsTRPbJlCOV
         hghx6irrx50AxT5V8KZGbN9uwrEEfCdHXcGxqT1tPcLtEvwg1uP3fpvWgcPdMLullHVH
         PtE6/eF0rKi+S+kC+vh6dzIr3l1cozoJal4JPPrkJGKni8qrYPFLdCxpQUSLd4lGiYmX
         1bAIHU3WKZFsNP2BQwCSJYT7kv1RZLcP6QK4/UHlHAQhmZcvVZkCd0ZfOQXY2n+eJ5xG
         epdcTT1+J31BHoWqBzAblw3GyVFWPT05aqg8VSHsYB81pxYeuwVgIo2zt45f3PpuVAdJ
         pbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXHghljtL4EI/XqtTqMJz5EFL6+UxuiO/TdGXUvnvkE=;
        b=YZK2QePf+qNmxmBiOdmdwMHfst8vtysj92H4PbacDkUZUiv7CXNSy42tPh0XQDW/gB
         h5yVSi+Bht7lRJbPYkiy0ZKFIL7Z0QQ5C1aEQ/naNzkq8ncYTR6AYMhDZHtW2c2pIvQw
         z9E9KIYM7ImsyPMhhTC2PEBtUxVqyzbNRm5sU+/J1VKpbwLm8FHzBb+jEi3Votku+UkU
         Psi2fpYpQItSicNMz+Aq9hKdokm1muPi43J6cqCu3eRs+AXYo7IQQldRWye5p3Inxv+s
         SUicweuthwaTCpBOAVL4jdUzN5s9GXOc7zN3ryHPsdMYHfW094cw5vO8PxkdIi7V/pSL
         vN2g==
X-Gm-Message-State: AOAM532HFrVrE8Bk3qTmyBjfkaJ9Y08IIZRNmc8aRn0npR2dqLaAyUzm
        i9dUXzPS8uuDqz0ikA7tJRTvdg==
X-Google-Smtp-Source: ABdhPJwJ/mGfSpLjHlI0GUojG9K5o+B+piJZ7HN2yU7A5gnjRZVE9IYg888XxbaTktEE/Q6svThKEw==
X-Received: by 2002:a63:4b20:: with SMTP id y32mr384518pga.382.1628683590823;
        Wed, 11 Aug 2021 05:06:30 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id b20sm26614754pfl.9.2021.08.11.05.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/9] cpufreq: omap: Use auto-registration for energy model
Date:   Wed, 11 Aug 2021 17:28:43 +0530
Message-Id: <e8279c32418c92880c58422800ecd58533e4cb19.1628682874.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628682874.git.viresh.kumar@linaro.org>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to automatically register with the EM
core.

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

