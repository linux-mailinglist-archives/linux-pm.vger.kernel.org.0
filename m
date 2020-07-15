Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42330220717
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgGOI1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbgGOI0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC2C08C5DD
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so2969807wmc.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FEE9EyuKEElP2R0dGV5iQicdnI3vcbhmFFoLiz/bvg=;
        b=dNLsriscR4hsRjVJy5HJ61IIk4PpwYkqGkI3F3kDQQeDKRecSXlq3RsNQY2oCbqvYr
         yZK14gsEQVw7xlfvTfZM7JvCMqfvlrQVrrqRtn83MdQ71BOFT0hZL8oC5qbgiEx20dXq
         AhE5zLi6V299vlhGlmf96yVFf+aEYUzYOT21qrkVWe/b5KHV8IjzCsqL+yoJCjR+6QTS
         qoCDhHlD5wC1lXiQlu+TjLdoU+qrC3Egi+XR2EqRUqbwFO56nK2tBacDB/dP9AGYQsp4
         6xzTC0Fl0UxZFy7pe5bgbzmpQWKzHYZ/6nMwAUfRIVIfqPQHKtwzaKcds55p7jwTV7si
         eTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FEE9EyuKEElP2R0dGV5iQicdnI3vcbhmFFoLiz/bvg=;
        b=ZnSqwZEBmjyfdl91y1za2RJIT5vGKsrFbRBhb/2xOB1oLUW2l3uf7pFwuCp83dfCvI
         Nt2cBCNch0t7Pvrf/nYdbLYEt5kHA38nz+o7JLw/Gj/iWsEhE7kqvSVayh97T8zypCe0
         ypnq8j4MQ/VXiEYS+Ci3akLRNq7Yk8ggGVKLCDMap8kyA/lvkiH8ceNT6JWR6lOkPgXF
         fbUGpSIxSmMNsPSW691u0aUGHg2wniPjX4vg5eUHphBL7a4mXrdg+6eij7sZ4KBmru49
         0vx1gVvQ+bY7tkMpDpWmoMqLr1f5nKV3orX/tOLFr3+GwmRqh3suNP6CApHKw2w+cUHY
         volg==
X-Gm-Message-State: AOAM5300wawQatCgVyF/tnc0+KYPT6WSFGx3uceptcg3olv+M+FjZ5OZ
        5NTJ2PUjP32PD2nU2OB0UTsMVQ==
X-Google-Smtp-Source: ABdhPJyFYPMmX9IE6VXwHxqc8TKSlBqseWdICHouNyIBW5KtvQh/NAXsNlCEjrx8/rQmYCNCLa2C6w==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr7896351wmi.114.1594801605457;
        Wed, 15 Jul 2020 01:26:45 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/13] cpufreq: powernv-cpufreq: Functions only used in call-backs should be static
Date:   Wed, 15 Jul 2020 09:26:27 +0100
Message-Id: <20200715082634.3024816-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
 drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 8646eb197cd96..068cc53abe320 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
  * according quadratic equation. Queues a new timer if it is still not equal
  * to local pstate
  */
-void gpstate_timer_handler(struct timer_list *t)
+static void gpstate_timer_handler(struct timer_list *t)
 {
 	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
 	struct cpufreq_policy *policy = gpstates->policy;
@@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
-void powernv_cpufreq_work_fn(struct work_struct *work)
+static void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
 	struct cpufreq_policy *policy;
-- 
2.25.1

