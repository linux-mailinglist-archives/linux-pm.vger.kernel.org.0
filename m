Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F611B0E0
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEMHKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 03:10:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41310 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfEMHKv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 03:10:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id f12so3966695plt.8
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 00:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMN/PlIc+xmZknm4ZqYo+axnKC9jbJCwqU2FWCmq5tE=;
        b=TpA7ix/AxkIP//ju6JW85dhgRAha590VihGIGmoBF2SkyfAtmzH1DpkcuPdN/C1dkd
         69Y/qYxUl4sToYu2B+lOUt4FOVICFz8JIdMeLonHnW6UDAx0L9i/dVqI7onkUmDn0Fn4
         RFs+tlshjjkWIXEhNm8dxasP2DXPtAi4Zy4+FcTuAK/ykNTlhhS0t1RWQ/Yx3bARdjIp
         k9tWzD4xq1aUC7FdMkImZbq5mzrTlqg56IF8ngufEKkTMCBvX0y08Urj9s9EwqI+yWa5
         oXF3YM+psdEgoy7D2LcRCH9gv6IUoT7mMddWbwK7VCnmv58RFPcXJpTF4liZUOqZV9LF
         XVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMN/PlIc+xmZknm4ZqYo+axnKC9jbJCwqU2FWCmq5tE=;
        b=cLpqbiuapC1ahTC/FKz5VwMxEsTE8QwOiDs5jJhfj+9KQd0DXJIh3lqAeJbW8aXfJP
         p3i6h21lA58EIqEHgTqgYRvEcaVXMYGlDNTMgwdiKAp3HUgt+pStOJ+HE+4089Ghr5Zc
         hbQmcMWb4sQFdy+Nz5HD4Mw8UDhyUi9x6NOUz+rx0vDcqWuHMRKjdkfvYpesAy7qMVgw
         mzkLsq2xGjf19wdhi7/yS/0LeCiMpn0WXZ5qOWRsL5ld2x0FVCsAA9OaAmc0NobbxNga
         ibqlfgYhXNquoqs3WuuEFQkpg8KZfckY64X/pTxrJL92uPvomFjxbyBlepazIg6+0zI9
         vJ+A==
X-Gm-Message-State: APjAAAUf8FGK+7m2FuwhYfIFzyFQj229rxWqiNkjgDossj65ITx7aJWg
        RbBurHwhId6vGezrHqfnUKIK+A==
X-Google-Smtp-Source: APXvYqxYSXh4d9qVBzkIKRwNZleSCdZccazd+LCiWhQxXNw5jk9FFMd4MdJ98iVfPYIPkDFctdOwRg==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr29138342pln.10.1557731449961;
        Mon, 13 May 2019 00:10:49 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id g72sm29732723pfg.63.2019.05.13.00.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 00:10:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Update MAINTAINERS to include schedutil governor
Date:   Mon, 13 May 2019 12:40:33 +0530
Message-Id: <f2badd7ec3afa227410a9f57401bf5ce04aff692.1557731248.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

List cpufreq maintainers as well for schedutil governor apart from
scheduler maintainers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4244dd341eb7..7d4417d862a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4093,7 +4093,9 @@ F:	Documentation/admin-guide/pm/intel_pstate.rst
 F:	Documentation/cpu-freq/
 F:	Documentation/devicetree/bindings/cpufreq/
 F:	drivers/cpufreq/
+F:	kernel/sched/cpufreq*.c
 F:	include/linux/cpufreq.h
+F:	include/linux/sched/cpufreq.h
 F:	tools/testing/selftests/cpufreq/
 
 CPU FREQUENCY DRIVERS - ARM BIG LITTLE
-- 
2.21.0.rc0.269.g1a574e7a288b

