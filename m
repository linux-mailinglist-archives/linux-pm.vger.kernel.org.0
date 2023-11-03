Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326837E03B1
	for <lists+linux-pm@lfdr.de>; Fri,  3 Nov 2023 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376671AbjKCNSj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Nov 2023 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbjKCNSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2023 09:18:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC8D65
        for <linux-pm@vger.kernel.org>; Fri,  3 Nov 2023 06:18:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40806e4106dso12808795e9.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Nov 2023 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699017505; x=1699622305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5A8Puvc3tXgvKjqlI5JohnMI9TNDved82zD5N88oqxk=;
        b=aVlLMIMwxyE03I3unUT1CvYnTjUZcwFksyIVp43s78P8pwBT0SKEvkRMVt3//Xezn1
         RdgiEprMQ1tEQSw2RWo3oKBehTSME6xa3f/TuLDqew0EH2Pfvz4rUQSPqnLBVy6tZTvG
         rD/TnK7RGgWLdPU3JcTBNf2j3K9u0xRfWPK8chSoBj4wybTzYCc1WaAueyN5PSqYb8hY
         RvIspfgMkV3Rz5q8OhH9+rlVWVFUpGX6MyjZunp6oAy+YH9GcYIrl4zg/3TlqDTuXYRf
         yaD1dEcAxF65pvcGxhabyYDvaBWwlDuWeaqxRPvrOqpHjfliaYwgEqRA7fqORyqZtPFg
         oEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017505; x=1699622305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A8Puvc3tXgvKjqlI5JohnMI9TNDved82zD5N88oqxk=;
        b=FBir5aaCK1M1eRtQsGGE6/0gRU2m100SGQsIqaEg/3CfsQOYolQpy9Mk0jXU9BIE2y
         C/fCbnJtQuu21wJDsZIekC82UwTCpCbsZMrhQ3rZB54r19OE11EGi9rlJt6StBOcXVjo
         i8sGTqMzDQs30AjWslyoRA0h+VSE8ZFzRrW39tXDPAUn2u/D1yZxGKIqjZL9obO93m0R
         Y1KnypeHxKLlod5pqxaj8q1VZ2WffBHSj3+Iw6XoX16FzUURgT8WrUYV5utl+MD7xGl3
         M5AEBtBGAqZlk6ZFvIYLe5UkiIKVuS1NPP+ADyk7UAR64qc6J5mCgcAlypsfwejEID6s
         oUUg==
X-Gm-Message-State: AOJu0YzE6UDAwWCSZIcRXVmW92n3k7hmTdwY2zDGwzx1p+SEcgO64OtU
        XpgD3800FwngDrHrq+oUUPQ7Hw==
X-Google-Smtp-Source: AGHT+IG1kqJfeOvzc/Snj2/C9xmkjqtq0qde9O8tKCR16KEoG4ydWAHxVMWl7YGf0C/DSNjJqaNHvw==
X-Received: by 2002:a05:600c:4f47:b0:405:784a:d53e with SMTP id m7-20020a05600c4f4700b00405784ad53emr2708296wmq.20.1699017504885;
        Fri, 03 Nov 2023 06:18:24 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d68ce000000b0032daf848f68sm1877565wrw.59.2023.11.03.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:18:24 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/2] Rework interface between scheduler and schedutil governor
Date:   Fri,  3 Nov 2023 14:18:19 +0100
Message-Id: <20231103131821.1176294-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Following the discussion with Qais [1] about how to handle uclamp
requirements and after syncing with him, we agreed that I should move
forward on the patchset to rework the interface between scheduler and
schedutil governor to provide more information to the latter. Scheduler
(and EAS in particular) doesn't need anymore to guess estimate which
headroom the governor wants to apply and will directly ask for the target
freq. Then the governor directly gets the actual utilization and new
minimum and maximum boundaries to select this target frequency and
doesn't have to deal anymore with scheduler internals like uclamp when
including iowait boost.

[1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/

Changes since v2:
- remove useless target variable

Changes since v1:
- fix a bug (always set max even when returning early)
- fix typos
  
Vincent Guittot (2):
  sched/schedutil: Rework performance estimation
  sched/schedutil: Rework iowait boost

 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 82 ++++++++++++-------------------
 kernel/sched/cpufreq_schedutil.c | 69 ++++++++++++++++----------
 kernel/sched/fair.c              | 22 +++++++--
 kernel/sched/sched.h             | 84 +++-----------------------------
 5 files changed, 100 insertions(+), 158 deletions(-)

-- 
2.34.1

