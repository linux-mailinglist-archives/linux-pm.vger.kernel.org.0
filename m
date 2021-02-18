Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48D431E8CA
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 11:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhBRKpC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBRJy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:54:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B48C061797
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:54:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l18so1122818pji.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cA3Vbjv1QbCqSAwzSTWfO1r4QtSmELsNFBlAofM0z8=;
        b=u/4QOfQgdaR3dDIR31aIOvXa5uWPBS0K8zu7mhAvwBunnhMwfj94snONBRY1cb+v8l
         AIPUQR1lN9eKb1w9b5240CEHqzirQFkPctBV/+85Yt8WA6mqAqmAOyGNR3m8HI9NMiWX
         6q7DiZztQL1vOavP2tJJ3goq8RcsJeBwMd8FZRsS5EvqGJHL/L8h1PlyFJa4fJuOJw8t
         tT5dqdP+Tn2e2mVHcH+rIWhMyZS8kbXNZa5n8SEraNPXkPICpvpgrsKBAQE37KoBRLA4
         M2bHqfZwjOl1IKjolhRRd0+hlCi/fdOXKANHxIiVfUgvLAO9v5K+YRo6SV5AhSkUP8PF
         kTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3cA3Vbjv1QbCqSAwzSTWfO1r4QtSmELsNFBlAofM0z8=;
        b=osiiBUZV7SRgujonNJ4sS8XKoCS829mFjO+nrYlu1CUGMGenzmOjK5vdJbYC1nhi31
         bKF1JiBVp7xaPQ6UrjEvHOvk2P7Wj2S3x96RrS5VEKT3FfDL4eKMChhhEGf9mGNZ+ebU
         hBBgpe29EE7W/HCdj2ik8jd31jV+8qlL/n5t6ZX4Q0tu71O6kKq1RgCM1fSh8JyPW8ry
         AKIsWAzFBOcpL1gXfaIqN7mtc/HvnN9bbS2IAiQBnCNeBu1ooNNKUheKe20Dm8FoAyKk
         /Wv1RiughzvHzEfS3ZABRn8Z0YY/9QNwAyI28KrMZWUiF2t3D6bGWdH+ZXnpnBh2qfou
         qfPQ==
X-Gm-Message-State: AOAM533irFFryaQyeVlbKUeNC28nYQWHHdWJRwunT8twmUCb3KHXa7kY
        xk/4hG5+gk6sRQDHL2eNOpJN9GT/N6cG0A==
X-Google-Smtp-Source: ABdhPJyTi5Xw4QPedUwjcvNH6Byv95BkyhIf2TmjWssZ5z3+o4Se6848rO1J1LzmwhPZ/jXtJ2d1Wg==
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr3315331pjr.234.1613642063986;
        Thu, 18 Feb 2021 01:54:23 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k5sm4867267pjl.50.2021.02.18.01.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 01:54:23 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] cpufreq: Fix typo in comments
Date:   Thu, 18 Feb 2021 17:53:38 +0800
Message-Id: <20210218095338.1766-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Change 'Terget' to 'Target'.

Should be Target.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d0a3525..e4ec74d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2101,7 +2101,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
  * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
  * @cpu: Target CPU.
  * @min_perf: Minimum (required) performance level (units of @capacity).
- * @target_perf: Terget (desired) performance level (units of @capacity).
+ * @target_perf: Target (desired) performance level (units of @capacity).
  * @capacity: Capacity of the target CPU.
  *
  * Carry out a fast performance level switch of @cpu without sleeping.
-- 
1.9.1

