Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0221F570
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGNOvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgGNOvA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:51:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2617C08C5C1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so22219174wrv.9
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pwz2ffWzBJ40s4OQQcEx95BGb6IW3I0JlI9ImusOaw=;
        b=YaPkEvwkRMrXCrAr3GD3Lq5esr1zvrFowgkVtFLyXE9aeQ+n6qHPlhaUhK4AYO4xUs
         hm5M2HAtd3m5JHJjY2xKUYjnMD1tdtfs5OPz2xXGUBp2zizzY0ZWTKvQ9U0A5cXFSIRJ
         j3yMdMtUprKvhoEl35KqZAv8e37m9RfHJ9JDTy287GDX+MDLsV7UmkJ7LDgRcd0qsysv
         Ia93V3kAPH4VDyioq5fO47gOCGnLqoR2QLu1mPSgJAUAUCITRKMczfB1Ec4oXyA2jWHx
         PQLY4by7vk9xQhpkcw3oZfR/uB2heai2vAqu8clRrz2QEmp5oM3aCK3aViE9BDI4b5mz
         3u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pwz2ffWzBJ40s4OQQcEx95BGb6IW3I0JlI9ImusOaw=;
        b=D2cYdilliLHs+11YcX/UfcZDhktikgVH8cjaFWw5YunoWXg2aDB4lro5I/1edRiXMx
         P8Cd5VqztCwyAaideFvvFiYDUVTLVphYPKwEVZM0eb4sK7VCgGcCbZ9TIGHY/0iC0jzW
         ecCXdeuCcTu5T8wG01QthbiG1oHk1uYXNz2uRnjcjYsY+344sZEQUh9vOPYo0TeL1dMF
         Y3EQr7RJB/2+1ER2jKcf90M1COcBCdv2chU7yVkOyfHmHCxaZCxPeKrXlTMZWSWdF/iU
         ZFrj3xrVAhs0oyDG3IJJWDbQwkC4zs6Z9Kc+xSfcRN9yWJHFQCnAZsx4q9YLpX5ceLGD
         VBbg==
X-Gm-Message-State: AOAM532fxIZDrE8QUoQ28b65I9BNZ6KGRHG6EJL7JIZMw8k24VhGxfFV
        By/9Pj9covh8HDZnV1CIq5JF5Q==
X-Google-Smtp-Source: ABdhPJxR1XkWPEdO/OToyZfeyPk6VSF/2G2O+HfpfRXS3rTqGgoQ4md522X2INCeZPPwNAHNuFWGZw==
X-Received: by 2002:a5d:650e:: with SMTP id x14mr6401946wru.187.1594738258660;
        Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/13] cpufreq: powernv-cpufreq: Functions only used in call-backs should be static
Date:   Tue, 14 Jul 2020 15:50:42 +0100
Message-Id: <20200714145049.2496163-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
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

