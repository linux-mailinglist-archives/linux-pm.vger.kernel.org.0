Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF121F55C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgGNOvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgGNOu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:50:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7D4C08C5C1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so22167820wrm.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqiGjo2A+JuWYmJhOxUeBH7YynB0Z20iJW99N6uR5uY=;
        b=QHrJMslmP0Kh8UfmYvSOG0q4hByvfx/EPXrsCJO7U06cWI5RsbB6FO/K0J4OQ20T3j
         RBSFiYd9YHmUsFIbhn61Ge90cJT0vVd9vMRFr2EWRb1rkIHD8mMz/JY2ZZYwATz7auHu
         18qgce0k8NfkRreMk/6e8YOBYMNHETPxUAHrQe2cFWQJRL/XweHeVtQEfMjN4YFvAnWL
         iIGlreeiHb8EF/eZQZCNRcHzlxKZv4+L5IkxmQFPUubbWI4G7B4xk0u1kk6T2CxnXRGo
         Jhw6lNuhbQ/AQS6p3QF5pvEy8QaJWxBEzyv1VQLjejUm4KkJTim9bBrnVEfdT59BlKQV
         Liyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqiGjo2A+JuWYmJhOxUeBH7YynB0Z20iJW99N6uR5uY=;
        b=cHS5L7t7FgtHY+lJCzcLUpoVqdnaZLRVr6xFkyzs5RoD4DQD3PSSsLUn42DvRmVdSM
         IAMNjdLLdBlpikM0G8j9oL/aInRbnW2pnEx13TKPBWz0TtTfl5KfJPpLQd38AOjMUIQS
         vn/lOckVfcofLFUnSVVYrSdpJdrfCwPmMf/QEVw7raassAOWa9j1vQdkI4phew5YFudx
         lbMfneHS+hP/h4cUthWhxYFLFQS816Crl/ojYwro/sn6VxPQWE6HgqbVbNIa/u0YoFK2
         2uAcEvTH9/ZCvTOddTBURAccIkyyCF2F8SqgVGaGOM7oAMboo1YmdcXJeFq9z+GQ0Wue
         3Zug==
X-Gm-Message-State: AOAM530wE6OGPyTBRF+pffiy9EZV/xxdRH47qH7s70rpSzlBEkfXpn8/
        b54/ibbQ+l5imA6uXa9ZPzf/fA==
X-Google-Smtp-Source: ABdhPJz0D8DB83PkawksqyN2zvcSXy61SCN97inRz7exzjOwhX1N4sU7xjVlExKi+/mgYquJYu+oog==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr6113893wrr.211.1594738255423;
        Tue, 14 Jul 2020 07:50:55 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH 03/13] cpufreq: cpufreq_governor: Demote store_sampling_rate() header to standard comment block
Date:   Tue, 14 Jul 2020 15:50:39 +0100
Message-Id: <20200714145049.2496163-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no need for this to be denoted as kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'attr_set' not described in 'store_sampling_rate'
 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'buf' not described in 'store_sampling_rate'
 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'count' not described in 'store_sampling_rate'

Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f99ae45efaea7..63f7c219062b9 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
 static DEFINE_MUTEX(gov_dbs_data_mutex);
 
 /* Common sysfs tunables */
-/**
+/*
  * store_sampling_rate - update sampling rate effective immediately if needed.
  *
  * If new rate is smaller than the old, simply updating
-- 
2.25.1

