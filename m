Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8526BD71
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 08:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIPGpl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 02:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPGpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 02:45:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA177C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z18so859496pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hNl9ITrOlajUMgfeY7jtp0iUw/AIlMS1zuHDQ3GtgZY=;
        b=PxfXjSTSmEEAg0XRSuDnRxTu6Nbxb9kijG1V/9xC3o1wNdR+/WiKc6ioEbvKguXR1c
         S3u3kuf15rxHpqpttJ+2uv8MkjVWFP+lip0kK3Q9mPRCni7npeX3xFY4KIocJJveyZSO
         6KsnrmzeyJyW26LiwnpT05Pxt6AlCJ7FS2s377Jr+xEimNPggqL0WUtinTKgRhLn4Weq
         mfY2b3RDapNZS5VkkyC8/FXQwGH8Mo0/y8A1UAQI0HripqRFBaxDUgJVKM8AR1KLh7kD
         bF6xAFMsZ8nSeGK9Yqt6y2TOkiDO5Xezq0RlT/KW7Gd9yHJrTGGinXrf+fUt8KASfZv2
         jzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hNl9ITrOlajUMgfeY7jtp0iUw/AIlMS1zuHDQ3GtgZY=;
        b=FGDGqqzKgxYJQC9u2mPCXsNfQ857fg8NwFRRMsPFYA2TJFvlWB4Kk4StWQsS+0UVKI
         Vf8hmJrx5WmpU9EKo8KI1LZaYi5caD00QK1QibC9iP3cKn8FpH6frUIIrwMfRxJX0loT
         Qcu/v6573lYpz7ZsfiIB0PxOuM8y/mMaAnMBfrXKbj50F85SEwmbKBkfkQwZ6tWBPIE9
         OW8s6d9j9iVsBfGDl0/EF+s8b9OFz8itVnfbMPeVAXtIBv+dU9eWZkUOSVufReVrTjz5
         sm5B3nS8WXZXjiHt16/x1G5Al3XO2MiPoxRjKsNA5LN2Oyn2Q0+2CrB+xFRLIMUftMtl
         vLlA==
X-Gm-Message-State: AOAM532DZQe5SQPNl7fxsC9ENN9iCVb+JwuAtVCCrVSwGCZBfxV/Gfd5
        UgLzrgeSMXO49vv3Lo7ThYysZQ==
X-Google-Smtp-Source: ABdhPJyF8u9Cgnqm5WUErB3pmar0qZDxVNDnl9YlNmZw49yxUFnLXwHu7DPX5//hssQihUTP0vAWHg==
X-Received: by 2002:a05:6a00:14cb:b029:142:2501:34eb with SMTP id w11-20020a056a0014cbb0290142250134ebmr5088248pfu.68.1600238738255;
        Tue, 15 Sep 2020 23:45:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id a9sm1426588pjm.40.2020.09.15.23.45.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:45:37 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/4] cpufreq: Record stats with fast-switching
Date:   Wed, 16 Sep 2020 12:15:27 +0530
Message-Id: <cover.1600238586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

We disabled recording cpufreq stats when fast switching was introduced
to the cpufreq core as the cpufreq stats required to take a spinlock and
that can't be allowed (for performance reasons) on scheduler's hot path.

Here is an attempt to get rid of the lock and bring back the support.

V1-V2:
- Use READ_ONCE/WRITE_ONCE instead of atomic in the first patch.

--
Viresh

Viresh Kumar (4):
  cpufreq: stats: Defer stats update to
    cpufreq_stats_record_transition()
  cpufreq: stats: Remove locking
  cpufreq: stats: Enable stats for fast-switch as well
  cpufreq: Move traces and update to policy->cur to cpufreq core

 drivers/cpufreq/cpufreq.c        | 16 +++++-
 drivers/cpufreq/cpufreq_stats.c  | 87 ++++++++++++++++++++------------
 kernel/sched/cpufreq_schedutil.c | 12 +----
 3 files changed, 72 insertions(+), 43 deletions(-)


base-commit: 856deb866d16e29bd65952e0289066f6078af773
-- 
2.25.0.rc1.19.g042ed3e048af

