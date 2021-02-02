Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FAF30BB34
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhBBJjm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 04:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBBJhY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 04:37:24 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48701C061793;
        Tue,  2 Feb 2021 01:36:59 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t25so14549335pga.2;
        Tue, 02 Feb 2021 01:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUmYo+i9Y52nCah86q3Rs8ybGgrYM0WWRYANG/BUZ1o=;
        b=iafXMRDzualY8p0SjI/m/BtR7KFJ/DLJ3EeyhCuqXmHTQDrSia0hOyb3uJq4e8fSEO
         XiZYYq8foXyc1e7B4SUMGKnygcW0I8M4Z52JvudjoRBhrZ+3QRlm9tvb8Q4Mm4Pon6FM
         ewHctegqB8KZ0rpJuCI33EeaZD1Eu+Gs17MtBM1No0+7FXODMO9S7XBRM6f83jahKBf2
         tQ6pegJJt3Znf3SClhEKiDwrV+dg4e8AbPvED1OKm0Z5CKLIpx1aBsixVVNkua61SNzA
         Rl026xTnyDiP1WRWuz1KgZJv9k34P6SliVPe8QIKJ5BDBziD8kzFrKSdxj0BHNukw5hl
         CiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUmYo+i9Y52nCah86q3Rs8ybGgrYM0WWRYANG/BUZ1o=;
        b=DlntnvTps5z0j/VpOL1IIME7m14ge3PmDL0PfTp6BFF1+eq3lR0QB4H9k3O9SZP8Bh
         Zf0AE3fL3LgUVXoAe64FTC0dP2w3iTF3CynXTsNdD4SmKHp2C5Z1jDcmvVWygpJNz81U
         y3UuG0S7ix81iusl4vSrmWbDhFR3HyjZ/7P9Eg30FqVqrHITRICfjJEGlt605etYItJS
         zptT/INkwjDw0hEEGaErwA/pFIo+7ZZnpNypdFT1wNH23c6UJRdhvfWhSlPq/2zsX5j4
         SfOSCMZMaTMQQqlrE9hLIO869wvxSGlIzNijhzbZH9+vnW+TnfXSDHs4azS6czTZ/9zc
         laEA==
X-Gm-Message-State: AOAM533BbJ6JL27OosWXJEIj9FNcaZl22lgo2EIURPRsYaS2s8sYC2eh
        AlXCs//kxHlsgxSxJp6QJ8stnoIysmY=
X-Google-Smtp-Source: ABdhPJz72s/U4xC5lIBP9Gun95cBcJWTxYoVcofjBYbO+N4OPrf/K0iQUJ7x9Yly5D8HScIgnPX/Jg==
X-Received: by 2002:a63:5309:: with SMTP id h9mr20887966pgb.19.1612258618605;
        Tue, 02 Feb 2021 01:36:58 -0800 (PST)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e21sm20595596pgv.74.2021.02.02.01.36.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 01:36:57 -0800 (PST)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewyan@foxmail.com, Xuewen.Yan@unisoc.com
Subject: [PATCH] cpufreq: Judging new_policy before update related_cpus
Date:   Tue,  2 Feb 2021 17:36:19 +0800
Message-Id: <20210202093619.543-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

When the policy->related_cpus are all offline, and then
bring up one cpu, this time, if the ->online is NULL,
the code would update the ->related_cpus with ->cpus,
and now ->cpus is only one online cpu, as a result, the
->related_cpus is different from the origion ->related_cpus.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/cpufreq/cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d0a3525ce27f..3d512ac463a5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1374,8 +1374,10 @@ static int cpufreq_online(unsigned int cpu)
 		if (ret)
 			goto out_exit_policy;
 
-		/* related_cpus should at least include policy->cpus. */
-		cpumask_copy(policy->related_cpus, policy->cpus);
+		if (new_policy) {
+			/* related_cpus should at least include policy->cpus. */
+			cpumask_copy(policy->related_cpus, policy->cpus);
+		}
 	}
 
 	down_write(&policy->rwsem);
-- 
2.29.0

