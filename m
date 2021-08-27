Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956A03F95DB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhH0ITI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhH0ITF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 04:19:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39077C061757;
        Fri, 27 Aug 2021 01:18:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s15so1352032qta.10;
        Fri, 27 Aug 2021 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaFxkrp8637fDlTGehGI7DBObUsAO7Nljqd1BKOyGTI=;
        b=aqx1grMt8XhxjrHajA6bw0uLj4AuxUGSReY1puQ9R0R1RPOYgJsUzZCNeokiDZPMdU
         aPGfOuiALnhRjQsl3+obyf6gRxsczyvK7QJOs1R/QlX5Gb7ty6TGfNcPBTp+1m0OdxhS
         StZ24YLSTfbW/J5STgjxmjZvfN3SsUFqH/3ctp30RsP5WVAVm2TW9RqvvSGJSjuzxYiE
         fZ1c7N+CdbUP1krhwdlvo1a3SwF6fxTzxVgenf+kgGtI3YgTlUOW/peajVasfImBVrSL
         tn3DFPPqeVXEcSMpzafFeeuQrufcfj0b0JJZV+35MJbjiJuuOPd0sZYWpGe3G7+n4vWP
         vAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaFxkrp8637fDlTGehGI7DBObUsAO7Nljqd1BKOyGTI=;
        b=hPyk/4t7gpUkntilQJ9wJRLp+fn7jlWBOl0gmY04DLyG+ZtIZPPYSIcUS9yNQQpqSW
         I5hI2nHt1fDP3SyuhabPEBcK11XItn97GnIrEU7mPcqL9K8bA8SEe8HYBcX8M8Dq+4Dx
         47O+60ka2ylPHIVWWaxhrGb9wa6wbG5QtVKw7dQ6hWKHgaJm/l1xpXxTNNzpIQBB4obU
         FG+4rPCkXzroqK1X8ffmCaNOxU2RzpcFDaQ+TvDuxNQa4fK8C2QRKUdR6qUjJk3TIWiW
         8Bx1GUruZ61DqtbTU/9qNLWcRRQ42txY1QfEljbr9Xef/sfdpN4gHbRweq58HgLqKnMI
         UEwA==
X-Gm-Message-State: AOAM5327BM4/lFLlY9UOvCJ8w6yj4vByENHiK/TRAWZhg4+4Z5m2n91i
        FwBLfWUvzX+ysj7GW6miTSM=
X-Google-Smtp-Source: ABdhPJwYPTGC8+SNsv4YM1n/gQ3OWe5Us8RPePrAzc8bHZzEBW04Tu5NTsaS7Ki3oc5L6Wowwcpe8g==
X-Received: by 2002:a05:622a:102:: with SMTP id u2mr7349253qtw.149.1630052295383;
        Fri, 27 Aug 2021 01:18:15 -0700 (PDT)
Received: from localhost (ec2-3-142-145-253.us-east-2.compute.amazonaws.com. [3.142.145.253])
        by smtp.gmail.com with UTF8SMTPSA id g1sm4318360qkd.89.2021.08.27.01.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 01:18:15 -0700 (PDT)
From:   schspa <schspa@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa <schspa@gmail.com>
Subject: [PATCH] cpufreq_ondemand: fix bad auto calculated frequency.
Date:   Fri, 27 Aug 2021 16:17:53 +0800
Message-Id: <20210827081752.54337-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We can litmit cpufreq range by change min & max from cpufreq_policy.
So cpu frequency target should be in range [policy->min, policy->max].

Signed-off-by: schspa <schspa@gmail.com>
---
 drivers/cpufreq/cpufreq_ondemand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index ac361a8b1d3b..8afb2c84c38c 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -151,8 +151,8 @@ static void od_update(struct cpufreq_policy *policy)
 		/* Calculate the next frequency proportional to load */
 		unsigned int freq_next, min_f, max_f;
 
-		min_f = policy->cpuinfo.min_freq;
-		max_f = policy->cpuinfo.max_freq;
+		min_f = policy->min;
+		max_f = policy->max;
 		freq_next = min_f + load * (max_f - min_f) / 100;
 
 		/* No longer fully busy, reset rate_mult */
-- 
2.29.0

