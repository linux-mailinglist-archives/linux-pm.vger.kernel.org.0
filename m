Return-Path: <linux-pm+bounces-78-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2087F47E9
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC981C2091A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98E56448;
	Wed, 22 Nov 2023 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9/ogQDn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04CED52
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 05:39:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b344101f2so934355e9.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700660350; x=1701265150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbsclafXVbhvsS395bqo3weKnHOeQwA8LuBg6N0OZoI=;
        b=s9/ogQDn14KWxJpVfgJ8ef3vbg35WtFMAN9FUzrGRWgPxpDpx1RUhyXj5ia4caA5Cd
         UhmYMNHXJQ1LEpSNPFzC7DhaPzdV8dplJzXr19FAMrInGy79uiqQfpotVcEKUVeWehds
         LbG6QtJMzkGKApU4lKD8qo+1UPlQtjrotD3NLhCPqgfLd3DqPT0cRLSARHz0O3Pt09W/
         CZ4KYppzCbOzKUPQZ/73Jvc0ZNbgba6MgLfLBOVu6sfwYU3FGAXkXvXvU5juhsfJS7mv
         X6s1yW1vYzneSCSeIIXrR5dbxksus/jdcqFG+wtiAI4HUiH/j7NKw6ovbQFJxjj6BVPD
         2owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660350; x=1701265150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbsclafXVbhvsS395bqo3weKnHOeQwA8LuBg6N0OZoI=;
        b=vRRKF7o+OR25+GoFRHPBy9whq4S0txed8ASEB6Z7tXmB+Ht7v5409ulNESZrH09Ae8
         YsgnC+aJkCd2KG1eOCl5z0kaq0BS8Z+RyPzJjHlDc6miyPO3/uNAMNSBjI8i4WgiJ/GJ
         i7r7w8YY327X2mLNwXK45pHDfWSj18nByvQWVIEgrbrZeil0hhSEA1uKYsyc7LM3loFU
         B/DR/cnAWiNr5c2yFq9Y7BZhfHW7Kp6Vu4rFovC0j6HUaLjexltZJqahBfKZpCPGQE4w
         G5KondSGxkiiFr220eNv4FrR1HaVZqGq84qD4qltVRoZF6FrlEGtw2vLbztM5qmLrwbw
         FEtg==
X-Gm-Message-State: AOJu0Yx6WgF8OX8Q+rHBAeNJN5Eyw+vn1yABRC0y1BYIIamGkDCJSUht
	vrGaRvCO2aHINhm4cxfX/D0Eb7vBf1E9iFlSTPU=
X-Google-Smtp-Source: AGHT+IFgJrbH8nkXN/tv9V8BMOmt2L5BDf/1VsasDQLVsnZ8+pdd1f6xmRFoLb71L9I2UNHbQaCBvQ==
X-Received: by 2002:a05:600c:1503:b0:407:4126:f71c with SMTP id b3-20020a05600c150300b004074126f71cmr5521605wmg.6.1700660350268;
        Wed, 22 Nov 2023 05:39:10 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:3a2e:a7f5:93e6:508b])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b00407752bd834sm2307386wms.1.2023.11.22.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:39:09 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	qyousef@layalina.io,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	wyes.karny@amd.com,
	beata.michalska@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/2] Rework interface between scheduler and schedutil governor
Date: Wed, 22 Nov 2023 14:39:02 +0100
Message-Id: <20231122133904.446032-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Changes since v3:
- Fix freq selection with runnable RT

Changes since v2:
- remove useless target variable

Changes since v1:
- fix a bug (always set max even when returning early)
- fix typos
  
Vincent Guittot (2):
  sched/schedutil: Rework performance estimation
  sched/schedutil: Rework iowait boost

 include/linux/energy_model.h     |  1 -
 kernel/sched/core.c              | 90 ++++++++++++++------------------
 kernel/sched/cpufreq_schedutil.c | 64 ++++++++++++++---------
 kernel/sched/fair.c              | 22 ++++++--
 kernel/sched/sched.h             | 84 +++--------------------------
 5 files changed, 103 insertions(+), 158 deletions(-)

-- 
2.34.1


