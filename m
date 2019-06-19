Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D028F4B729
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfFSLf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 07:35:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46331 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbfFSLf5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 07:35:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so7089770pls.13
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUQzhVyRtpgFZ3dw7RfFivV0LNUHPBdYdQyIVdE/RIY=;
        b=hW7YPsFmIXlK9HDgxTOiuPX+zosJRHRsgc+QRGwoFJaBdLDS/iVJg66VZe2k/a0pqO
         1QmfKhYvlh0tt+01cUFwHb7vMdABTqGyxnxGLea9iB0rB7UPyqkCG7QNpmAWWePW4nZ4
         yQX/HVyS9whMijJ97tR/wKPLJbahqV21Cu6g5kaLSZu+dQuqmPLjmNQCifc4YwA9E6Fx
         wUNTYRHB4xwiSOBUhl6Ae5WtWQMAKFjQnoCB5/KIfpb5q54cCnT89YMYMm+jVQiowJcS
         QJx1OcKQyDOWD1rdJ1GvIbvYjz7F9FqpwIOx3q+ZpH8/P8Pgj8oqryzDpbBntQjCqeY2
         hDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUQzhVyRtpgFZ3dw7RfFivV0LNUHPBdYdQyIVdE/RIY=;
        b=BcwzJQ/Zw01eit6j2dBnrVR0g43suJ0iH4VeTU/4u0crUnZGCxquQtPz1ff41rsToW
         KXnjXj/0gq0Gt7fjowpewpMvpIG7yuJUr4MVWcjPIHbTd1YfifSiBk8K0vJK5Y/sBqy/
         bXHzET5q/pzFvcilvdLj5iOjaqXSdMgArOvsH0qZwWoP1oVpSP7PywC3Dd2QazoAHiUk
         HtVlbc0Prt2XLOtBDnMLDm3aDPLT347h83oGW3KlPvowQomEj+68D/yk/day8xygPB0X
         GK08EReIpq5mCRkSD+0F4hCxkwI10gnEEaoHKcyxeeJdsSXxDwuN/8psnamFXC47fd+R
         59vA==
X-Gm-Message-State: APjAAAWm2zCXt3PTZQasU111P8Kjzv1/NHWLl+SZr8VvHPB5/owhZdUa
        jTTLHH3s4E+8TNiC3xOLUxNtzg==
X-Google-Smtp-Source: APXvYqyDMJptRrnZN7RvnTreAMH752D29+th75+xEu8HIHoScOqpmHLWtxRpCwJYot/QpAFqwGE6Pg==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr1629125pld.112.1560944156639;
        Wed, 19 Jun 2019 04:35:56 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id i3sm20492174pfo.138.2019.06.19.04.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:35:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] cpufreq: Remove the has_target() check from notifier handler
Date:   Wed, 19 Jun 2019 17:05:39 +0530
Message-Id: <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpufreq_notify_transition() is only called for has_target() type driver
and not for set_policy type, and the check is simply redundant. Remove
it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e59194c2c613..41ac701e324f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -359,7 +359,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		 * which is not equal to what the cpufreq core thinks is
 		 * "old frequency".
 		 */
-		if (has_target() && policy->cur && policy->cur != freqs->old) {
+		if (policy->cur && policy->cur != freqs->old) {
 			pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
 				 freqs->old, policy->cur);
 			freqs->old = policy->cur;
-- 
2.21.0.rc0.269.g1a574e7a288b

