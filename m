Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2578A379
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 01:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjH0Xc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 19:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjH0XcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 19:32:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1AC4
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 16:32:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3ff5ddb4329so22023295e9.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179141; x=1693783941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaVq8EKAsb338hHMLyS2kCgyppa6AioQRKa23MjmAu8=;
        b=beCesP5oRdgeyDfWa7pN2BKGX+3PRY1EkZrkG1qhlumaoMEQJag/9ZstjRY3+UsXtY
         fVWME8tM9i+C3WJko9hSvweJoZo75zgAUzKRZYSk3vXILLPmFz34iuubjP6f4aeCSfhG
         za305/gB1omBjRxPSVI2DVSpj4D/b6URu0bpwogbUkgk0LHKorwpE/8o01REXhO9i5e7
         B4w6JqT9wjOqAAuE570oWKsGN57owczWf+GWDG92/uZGdFD0e4FWjKgluuh33w7x/ghl
         HNFtKJD38gn3McVrwpm9Kkg0Q2JuHlakS3F84gnJOmG4uUdm/JgzmG11XQgNvPNAp8qw
         Aqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179141; x=1693783941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaVq8EKAsb338hHMLyS2kCgyppa6AioQRKa23MjmAu8=;
        b=KatF0ZkqctGtT0p8Gn3PNE51k35clBDr/tK27eP84eSqMEQZCBpr59R9sQIoDQx7YG
         1pEpFoy5E4x0w9qLF8fxur33mUW+53VKY7gNf9RRtPntsxOfQIQ9kSMjyN2AImayYZbj
         zLJzo6QXeR+sItBkUDa0c5y5vJ1kqWd9Mv+Zxz8+Da1FpFLZYSZ7w41I9lwQ9aebU5GA
         V/ju4xhgDrhYncE0WwgeOo3TQvMk8yQ76N6izX4xP2E3RqHDKurGIXlE2frRGZWe0/0o
         X/mq9EfcgOYMyYi4nqu0rdG0sehp5AA2NGHcLTAKM6aE39oPurIb6B0kTDr9lEapc7F7
         8vug==
X-Gm-Message-State: AOJu0Yydc97hDDrD9JYlC5MkwcXEYQFcQMvNKtWoKdmcoSWTjIrKpok6
        yp3J7NgTZ/pAaiqgyisE0Z1zUg==
X-Google-Smtp-Source: AGHT+IFTaPp/V0wKasX2zg+Lze06XxfW3j0cBoBXVY39qh55XTNU2EFQ7Qja7L7SH5UCiDOVx2K/ig==
X-Received: by 2002:a05:600c:3113:b0:3ff:786:e811 with SMTP id g19-20020a05600c311300b003ff0786e811mr11291195wmo.3.1693179140871;
        Sun, 27 Aug 2023 16:32:20 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:20 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 7/7] cpufreq: Change default transition delay to 2ms
Date:   Mon, 28 Aug 2023 00:32:03 +0100
Message-Id: <20230827233203.1315953-8-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
References: <20230827233203.1315953-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

10ms is too high for today's hardware, even low end ones. This default
end up being used a lot on Arm machines at least. Pine64, mac mini and
pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
it's too high for all of them.

Change the default to 2ms which should be 'pessimistic' enough for worst
case scenario, but not too high for platforms with fast DVFS hardware.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..d8fc33b7f2d2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -579,11 +579,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		 * for platforms where transition_latency is in milliseconds, it
 		 * ends up giving unrealistic values.
 		 *
-		 * Cap the default transition delay to 10 ms, which seems to be
+		 * Cap the default transition delay to 2 ms, which seems to be
 		 * a reasonable amount of time after which we should reevaluate
 		 * the frequency.
 		 */
-		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
+		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
 	}
 
 	return LATENCY_MULTIPLIER;
-- 
2.34.1

