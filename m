Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 555A14B72C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfFSLgB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 07:36:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33288 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbfFSLgA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 07:36:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so9598200pfq.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOLcTvq7r2YFvtxjS8uMzw6EOaoZ+9nef/zKHoqPhZQ=;
        b=NcK4VqWsbDFm9dietxUlHlc5OUPdr+DQm+9coLpsk4HrrQuKIwtiLCP0nVmCq/4VxJ
         NYqlr4K3ecz0zAtEiXQxQGhs1ksmfHu8IqjpJen1hRiOwHcGOueF2ef4xdBEL4y3H91i
         sJnc9IOrjoJ0KUO3Fs+I3UwUByYtjIKZJLeiAEGqpSD886CVu+23TlrogwrN/fhOb/EH
         zlto37kC+Cvu4LHB5ca+VIAY58mEfPNX3xHmmCoaHMy4SRFHzqKeBeeMT41qTnPn86sr
         fpKWziov0JvlaRgldzqEQJOoG18VV58hA87r7Qr63dvCjvNF8RWuGWK/KjU2wSOLo7m4
         12xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOLcTvq7r2YFvtxjS8uMzw6EOaoZ+9nef/zKHoqPhZQ=;
        b=m3tFLZD3GmViCczCdhpCah5XL0k6ywn9nK3Vt90TSUx/t+EXHjlfhAp/o0xLkMYkVo
         ABpvWqba9a+yXYUKyKDehDR1nFq6Vn5USzx34do1jQ9IimdLUFJ/0zB1Po55lQMMS+N3
         IQsrPh5jtv0/478Ru8EVr2O0JHZzv+P5JxFBX1WcffCpvKqEHP4i8fmmHTbhnr+D22iB
         v5AECYlgGFcmGhGPzLgii5d54wgtJcB2m7hiT3GpPgs0pXVb14vrab1ILDIYQ7WakLRh
         wzI4DVC9++Ci8/Xm7uLPwgewXaEMvVj+5UagW1N23Q6rc5T279IgNGY2haRdp+FZTZNo
         WLrw==
X-Gm-Message-State: APjAAAUZwdt6KlD3Q0JxvBXhRXpqzdly6wFT48vXxtbXwc3+n9y+y5tg
        QKuImzk07KjwMTB021ZUuDmY8w==
X-Google-Smtp-Source: APXvYqxOlCwhMaq7Jl7Jwodoxe38baqRIiIRg36UykjL5AHvbXiMZnaatLlY1IiT5R+KZoqKvREUJQ==
X-Received: by 2002:a63:445b:: with SMTP id t27mr7352195pgk.56.1560944159424;
        Wed, 19 Jun 2019 04:35:59 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id 11sm17459849pfo.19.2019.06.19.04.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:35:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] cpufreq: Use has_target() instead of !setpolicy
Date:   Wed, 19 Jun 2019 17:05:40 +0530
Message-Id: <8c563c8f3515ceefd88875160302b6fd472c3dac.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For code consistency, use has_target() instead of !setpolicy everywhere,
as it is already done at several places. Maybe we should also use
!has_target() for setpolicy case to use only one expression for this
differentiation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 41ac701e324f..5f5c7a516c74 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -632,7 +632,7 @@ static int cpufreq_parse_policy(char *str_governor,
 }
 
 /**
- * cpufreq_parse_governor - parse a governor string only for !setpolicy
+ * cpufreq_parse_governor - parse a governor string only for has_target()
  */
 static int cpufreq_parse_governor(char *str_governor,
 				  struct cpufreq_policy *policy)
@@ -1301,7 +1301,7 @@ static int cpufreq_online(unsigned int cpu)
 		policy->max = policy->user_policy.max;
 	}
 
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
+	if (cpufreq_driver->get && has_target()) {
 		policy->cur = cpufreq_driver->get(policy->cpu);
 		if (!policy->cur) {
 			pr_err("%s: ->get() failed\n", __func__);
@@ -2401,7 +2401,7 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
 	 */
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy &&
+	if (cpufreq_driver->get && has_target() &&
 	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
 		goto unlock;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

