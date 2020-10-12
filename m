Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7B28AD5A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 06:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgJLEuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 00:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJLEuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 00:50:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA66C0613D0
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2020 21:50:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so12395272pfp.13
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2020 21:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EKZs60ksc+C2mu0NsIjhHU08u0xHxXWsdgv8V8eFP0=;
        b=Li52b2kHX9x7ticLBS6QsQ9odgPel9CR8bmvd0J2IN4ss5soWyxOpqU2jbJeDsr/jv
         RLmf3LOU6o32xIuqRBWOO6bHY++nXMGO50y+0mWjuMHtZ+RcEKArkPygJgPJFMi0+uPS
         iB0QFKRKza4OQzr7qkVA5yFzitUPVjyIsamhm6+6873ZL+AcrsoJLYvX5LsBLE+4LTzw
         qjG6zGHmmuIi1eUEWnkgQfvGJtc3q3XUeGpmuFKediuL8+rdekQ9lHbiZQ3S5AiD2B+K
         qU2LGCw2Cp7xCsEIfCkFWCXUFDJ8uUE3rzkYa7IOHrDklrCqLpEtJWZkodF+VZlXm3pe
         yvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EKZs60ksc+C2mu0NsIjhHU08u0xHxXWsdgv8V8eFP0=;
        b=aZa1ykEcbZKOW9pr+BpyE+z2k761UggV/RaT8+n+PzpiK3noZBWJfU0jV/fCginrm7
         CtrcQaWvnMY0ZPyftR8i4cj7ZUBHqfBnV984XnJhdNRvo3kBnGHjDwZnPA2tkPMafOFQ
         L9u5VKWlOlLPyukEb+gTVT6eMhK4uis/bPj6tnqZAzTs9NLS1cuBczWbqz9lMj/cGq37
         SIQzCrrF4jcq6lZnfN5Q3LqAvuWqw6VbMIEuaSFal55/tSM/058+BTtjajwxCbBvh5s5
         qNL9bn9Ib1kmjyC5oVh7cvBfFCTBbYxbFjwW4HYCNetJlOtzQeRgdobh98B65X/frwL+
         Kr6w==
X-Gm-Message-State: AOAM532AvUgs3jnLId+pWu8tpvUNzfW8DpZ2ZBVogR5x3wTpWMw26U+r
        aw3CE3Rc/EuPwUfvaPmrOEo7rDEuvPDNsg==
X-Google-Smtp-Source: ABdhPJwgPGyOize8k9X+CFBTrgh9pPEeE3nVg6DLQfoivM2ZpN/FvLmtpOFwEwo4Op6xTL2lxrI31A==
X-Received: by 2002:a17:90a:6f21:: with SMTP id d30mr17643381pjk.165.1602478215616;
        Sun, 11 Oct 2020 21:50:15 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s20sm13091945pfc.201.2020.10.11.21.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 21:50:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: stats: Fix string format specifier mismatch
Date:   Mon, 12 Oct 2020 10:20:07 +0530
Message-Id: <9c499a132d06f31e81a516c91bd92d619eb118ba.1602478204.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix following warning:

drivers/cpufreq/cpufreq_stats.c:63:10: warning: %d in format string (no.
1) requires 'int' but the argument type is 'unsigned int'

Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1b1389face85..6cd5c8ab5d49 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -62,7 +62,7 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 	if (READ_ONCE(stats->reset_pending))
 		return sprintf(buf, "%d\n", 0);
 	else
-		return sprintf(buf, "%d\n", stats->total_trans);
+		return sprintf(buf, "%u\n", stats->total_trans);
 }
 cpufreq_freq_attr_ro(total_trans);
 
-- 
2.25.0.rc1.19.g042ed3e048af

