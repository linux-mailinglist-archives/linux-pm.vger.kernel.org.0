Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FDA4C5A9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 05:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfFTDGY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 23:06:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44121 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfFTDGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 23:06:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so747518pgp.11
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbHOn34+83W+J2f3XHDBG84b3Et0zmkMSETpfTN9TuM=;
        b=UT17hYIwO07T+JXmCNzUy25KZuNg7TFnGECmDQriV9z5Zc5iK/562PnnVfxwrM6+/z
         NN9S6GFPYLifZ84Wh7XCcbJGNkV5Y7UWS40WSuZzMCL7Z0Qt34GwRoKObd+F35Ng7MKB
         D1UOxmySiMuh5cLXRmvJ0EuTneYj6dlX84Fg5tPOac5vsS/WUkniFmlUUTY2F8CnwDM1
         NrPVz78uVqELIPnN25wEg7YF4YXExqJvtPk8NbE+K8yrNvtiY47q8cUYa8GpX0KWbK4i
         ded7OAYwOaUzU6wiTK/rOLNSus+CjQO6rUy5BKlxEdZn8ZA3EkBVeMThnnUkTQDmTfrb
         OLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbHOn34+83W+J2f3XHDBG84b3Et0zmkMSETpfTN9TuM=;
        b=pU+OEoPMf6C4HnLByy3enS+sDHRXcmV7MR5Gy0PM/UxaCApB1pgh/EQ6u5X14fFvoK
         nZa5nhUrtM2zqCu5dqEpoEtH5dWYlHasl79FBFp/aEN02PECsM/mTbkko8rya2pt7djO
         YnkP55ctJJm7edjxmTONusjaBwKUE2P6Lv5q+nrBYHdcaTc5h/eQIsTB3X1ujNZg2RKw
         +LqGMadEu+a2dPFN7lvyIyNpKSG3vRvVHLK8v/NreAKiLwkJFa9xMb8p8rozw1tVgcSt
         5dvQMvUBzrq8KX5lWitCDL5qYK4XJyhF/X0jRL9pMGOchbMiholFNLlqrsCdC/wqgguM
         rkHg==
X-Gm-Message-State: APjAAAWB9a5oUZ3m4YKjNNDNNcdcrd/leA1XjuohmnXgQ7VYWsdMEcpw
        stt9X4y/518lT70CqboQurR56/ixwVA=
X-Google-Smtp-Source: APXvYqwJTRDFmZNAIEaGMNDIRyAWQI1nd69Xf4gQfwcFrHb5UyE97h39NTtwabsG2oSB4Bjr2oCrzw==
X-Received: by 2002:a62:28b:: with SMTP id 133mr5409487pfc.251.1560999983761;
        Wed, 19 Jun 2019 20:06:23 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id g2sm18949048pgi.92.2019.06.19.20.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] cpufreq: Remove the redundant !setpolicy check
Date:   Thu, 20 Jun 2019 08:35:46 +0530
Message-Id: <b9bac95bcc36f5f70e910e4801be5d4f8fd32d0c.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpufreq_start_governor() is only called for !setpolicy case, checking it
again is not required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..54befd775bd6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2153,7 +2153,7 @@ static int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
+	if (cpufreq_driver->get)
 		cpufreq_update_current_freq(policy);
 
 	if (policy->governor->start) {
-- 
2.21.0.rc0.269.g1a574e7a288b

