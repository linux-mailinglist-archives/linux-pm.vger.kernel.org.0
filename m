Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B025A698
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 09:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIBHZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 03:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIBHY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 03:24:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3027C061245
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 00:24:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g6so1935084pjl.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2020 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jzMZYoVKwDdmao+58sFzZ/CXFeupmKrayPkTlA4XixE=;
        b=E0/BSbuSPpbXLYOMMXyaUHNxnQ3tUzUVqYOpieWEbT2qOzkNODpjg9XY/ClTXLllz/
         gmqTDGD1TqF4jmX/0icaIde6OBrsCAEJJWvktUPkgIQ3Abw7EY5nmYS2M8XXQwC+Vc1o
         kn83b7CBn/U7TapHGOgNskPmpoKC6RRYQjlxvJUpu8RjxCJlRe4T7lCJRXMV/g6N0IQP
         7Hf4f6atIEUA9x06GnjmMfiVHz92M+w6iVP6+7ExTr6p9TqWmnaCATwADBfp5Ho0J3Au
         XXMdDsW9X+2X17BQlN5wS4w0ISNN+HfhyPLTDTMgdSzQPtTb2qhfH2UWRvVr4OtnyC6l
         5fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jzMZYoVKwDdmao+58sFzZ/CXFeupmKrayPkTlA4XixE=;
        b=AcTv6bUyhvSBb/AfuDeQZcBrK7/AfVcoxeRdAczbr2v5+xCiDWrKLFJvFb/PtVQ7wD
         hkbn4G3/t095bpDZOrXA1xUtCOL+J47moom3H8hAO1fNk8XamQWs7+v/PpzI5QNDdZQi
         mWnSuEV7D+fOUlGixTZTuOh3On/Y6qxbLKjzUNZghaz7Nek6QZ2Ff1mND1V31DsQmgdW
         lvQiIGYvJ9YcNIBj+VG2r45Qzgfv7LvzUS1nfsAFLrppZi/GlbdCk5qU4JFcE8IyTAHl
         Ffu+eIe3DDkr456yAjYIfcqrPoBNhRl/dBt4BSpa9KVICDKNUerHwS686T29qMswCSdH
         DUcQ==
X-Gm-Message-State: AOAM530JpApPWjl6hllIuki5Ct0FLCUhl66Qq6kTKRN56m0UJFaLckQ7
        baJXnw9KaH+xz9z76EW/NKOVuA==
X-Google-Smtp-Source: ABdhPJxcrLNX45rZJ9+2vEO70afE8r94mzy9Wa+nZEObcHVhSiGQnzZBwiaBcE7S3cl7jVwMFiqh+w==
X-Received: by 2002:a17:902:ed14:: with SMTP id b20mr1030492pld.310.1599031498295;
        Wed, 02 Sep 2020 00:24:58 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id e2sm4272366pgl.38.2020.09.02.00.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 00:24:57 -0700 (PDT)
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
Subject: [PATCH 0/4] cpufreq: Record stats with fast-switching
Date:   Wed,  2 Sep 2020 12:54:40 +0530
Message-Id: <cover.1599031227.git.viresh.kumar@linaro.org>
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

-- 
2.25.0.rc1.19.g042ed3e048af

