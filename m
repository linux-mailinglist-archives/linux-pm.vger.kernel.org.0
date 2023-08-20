Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437CC782019
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 23:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjHTVIT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjHTVIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 17:08:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71BC4220
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 14:08:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3196afc7d4bso2403597f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692565683; x=1693170483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKIfrxoX30OyxGGV0Yso8E9kMyHpJWBVJoFq5vqFQs8=;
        b=eatVI5m3PpJWv0B8wu5Q1/LKN0tSq2di2XEZw5h56kMRq2tH/GfRFOem3MIIXdzMqX
         YV3p6UoMvw68WSUOVTjmA3jl/Rgytqt9V9ZAFwLNJb41c2jeQRrSy3qgG/SKLANmfnlM
         YCAsnIUGmmW24KaldceMXo7cK7Ef3izNr9SMjadDL7r/OZIgQUYG4T/4U2D+P4VJ7AYe
         9BtYJk8U2ctHJ29v1BWdIufZTLybYOXdMcPJH9jHOWDpNqf15wSjNXxr2bxrRDzc/ufB
         /QKylHkEDzvM7rXs03ltrUrBD/idaE8lH3GrMmZGr4T61XZWGH30XtMUlu2KEYjbG1y/
         CraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565683; x=1693170483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKIfrxoX30OyxGGV0Yso8E9kMyHpJWBVJoFq5vqFQs8=;
        b=ehc2DaRLOkfTSIFeR7867B08uJ2Ckrz8Mp56HeL/GLR4Uskl0IT9z+hWfC+iMxSHBr
         OOtK/W+WPGTbJ8qgy0GYPeZhq7VqXyoiLvdDxGPPsudMiM11N94u06HE9sZ+AEwQ7ynE
         JOe3ZwgTLGxDL4Wr8EvtFTnVTfIEyoazAIHNRGGEOjrqUeGAfO9culeEbhN7C5cgzh/E
         06i+/Mhnux+jw7ToLC9C1VNEQBL1J+R+O6JUHpJuNW7bTGiFyAVMG5RBKP9dJgDmK7Vc
         AK+PEGjugG2YRcUJlqaj/nou2muaC5vYuU/PD9m4ntspvJZlDAlkWCntxC9WCjjekjTU
         1ZCg==
X-Gm-Message-State: AOJu0Yy/u7YFj3p5HoqpdHbz/zWTyI07rxKhf7vbX2Y00mwS1kdio8N2
        R0l7mqVja6RfmtVyY9i/yQgeiQaJitnVIHzsg9Q=
X-Google-Smtp-Source: AGHT+IHIpkC6rZSeHtP9enNvDDH6WRYjXxRdIhQ4tHieCUbY8Q7M72ioVNYe7OBGlc5RFQYpOJnqRw==
X-Received: by 2002:a05:6000:1245:b0:319:8979:8fcc with SMTP id j5-20020a056000124500b0031989798fccmr3499253wrx.70.1692565683139;
        Sun, 20 Aug 2023 14:08:03 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id j6-20020adfea46000000b003197a4b0f68sm10336800wrn.7.2023.08.20.14.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:08:02 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/4] Fix dvfs_headroom escaping uclamp constraints
Date:   Sun, 20 Aug 2023 22:06:36 +0100
Message-Id: <20230820210640.585311-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DVFS headroom, or map_util_perf(), is applied after uclamp restrictions are
applied in effective_cpu_util(). This will lead to two problems for uclamp:

	1. If util < uclamp_min, we'll run faster than uclamp_min. For example
	   util = 50, uclamp_min = 100. map_util_perf() = 125 instead of 100.

	2. If util > uclamp_max, we'll run faster than uclamp_max. For example
	   util = 900, uclamp_max = 800, map_util_perf() = 1000.

First patch rename the function to apply_dvfs_headroom() to reflect what it
really does. It is not really mapping util, but provides some headroom for the
util to grow. Provide a documentation for the function too.

Second patch is the actual fix.

Third patch moves apply_dvfs_headroom() to sched.h as there are no longer
users outside the scheduler.

Fourth patch is an RFC to redefine what the headroom means for RT, DL and IRQ
pressures.

Thanks!

--
Qais Yousef

Qais Yousef (4):
  sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
  sched: cpufreq: Fix apply_dvfs_headroom() escaping uclamp constraints
  sched: cpufreq: Move apply_dvfs_headroom() to sched.h
  sched: cpufreq: Apply DVFS headroom to CFS only

 include/linux/energy_model.h     |  1 -
 include/linux/sched/cpufreq.h    |  5 -----
 kernel/sched/core.c              |  7 +++++--
 kernel/sched/cpufreq_schedutil.c |  5 ++---
 kernel/sched/sched.h             | 24 ++++++++++++++++++++++++
 5 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.34.1

