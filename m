Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB7283131
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 09:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJEH4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgJEH4m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 03:56:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C47C0613A8
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 00:56:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so5464612pgo.13
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYf6GPt1wRUI8w200qpKr/LuqlJa9al57JJ7Q+opvEQ=;
        b=hLbJsgCZapLKk39/1FZQk05+VxQTPVQ/ckuhiTIxrxmFV/QyEuRSE6lK3Dcjw/Ttqn
         UnlrYEshMpTMNfxszZk+OBg5SQaP5abwxlOFb/T6t7L/xK41J4YazhiL79Q+YMlhX84V
         G8Wl/cIdDjF7siv0rrPvJgBO7mesydHLLiVy7TW6baA2NcTX4n7eJSDnzj5pJjLqzyua
         dGCSv5KhJEzt6IGyXiXM/jfob8zu8oc3j2bqMuLMjrs8L6Y8z3h0R0SZkM+0iz8bankW
         Tx0yPYJENsA4Kd35xc7sbludoQlQecrIYmcqEhyCKGS0X21HN+ej37A1gZOskLRjIJaO
         bX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYf6GPt1wRUI8w200qpKr/LuqlJa9al57JJ7Q+opvEQ=;
        b=REphwcweFEJbzLFK3IUZoK9BnmG5eQ0zYkcfgwP1vG8Vx3kXyCNon/jzrsOOKqxJtI
         xgxiEsx9pCkG0MIkv0t3PHEtZ6r+cvEi+Du6hCupcKQ9Bli44L4jVY9eBvMmbg306CDI
         fnJwHHxad/jySPkp5j/AS6Kq63tQKoB3CNbUZghpOXRgMqoVr7NZPEnnSjwICXXu1P3J
         QA6/hGgRTvBFenFK6d2l/9wZfjHDLgByeWddHbZNRWZr1xEBG5vGMTs6hr/l2OfjBhmV
         KCZBz4MtoFNWBu2Yy0bzwNwCYmTOlxXjYi5nIkR9EpNY/kPnA4XMyX513bCLvwnYSP1F
         9ksg==
X-Gm-Message-State: AOAM53069x72EUOQx94e7cuo42nTVS42s8ywnPLe4/y0ycOzcEbqjgFg
        wXnluMENkPnpuiF0EkdOyU9Zjg==
X-Google-Smtp-Source: ABdhPJy2AkqRQJNbK0grU2beG+3LdlZf199gBlJg2TQ13yIuW3jlQ2yx9MrZj/I0egK7qZw1Lg9X/Q==
X-Received: by 2002:aa7:8e43:0:b029:151:3e50:afa6 with SMTP id d3-20020aa78e430000b02901513e50afa6mr6668641pfr.59.1601884601412;
        Mon, 05 Oct 2020 00:56:41 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z1sm9798018pgu.80.2020.10.05.00.56.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 00:56:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/5] cpufreq: stats: Mark few conditionals with unlikely()
Date:   Mon,  5 Oct 2020 13:26:03 +0530
Message-Id: <bcd08a46937c3c4f36853e8be1b11aef5a290248.1601884370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1601884370.git.viresh.kumar@linaro.org>
References: <cover.1601884370.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since this will be part of scheduler's hotpath in some cases, use
unlikely() for few of the obvious conditionals.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 45a067855367..bba04da3a278 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -260,7 +260,7 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	struct cpufreq_stats *stats = policy->stats;
 	int old_index, new_index;
 
-	if (!stats)
+	if (unlikely(!stats))
 		return;
 
 	if (unlikely(READ_ONCE(stats->reset_pending)))
@@ -270,7 +270,7 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	new_index = freq_table_get_index(stats, new_freq);
 
 	/* We can't do stats->time_in_state[-1]= .. */
-	if (old_index == -1 || new_index == -1 || old_index == new_index)
+	if (unlikely(old_index == -1 || new_index == -1 || old_index == new_index))
 		return;
 
 	cpufreq_stats_update(stats, stats->last_time);
-- 
2.25.0.rc1.19.g042ed3e048af

