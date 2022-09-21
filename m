Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D795D5BF5F5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 07:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIUFih (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIUFig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 01:38:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E479605
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 22:38:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y136so4868132pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2022 22:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=zkS588wwQozFVoD8zpAR8mFDb8Wl6jeJSAikk+zd1as=;
        b=pRnRN7lMggRKlYI8JB1/UmNvMC0luIWRIFhi2mmqtGwJTa9yMFbKBlncOCRR5Pu1lF
         v6sb+RfL0xXapXqT1OUAmIfOpZpKCNSGqvXNzDbLFy/gDOh9H3coYOaB6/omzfp+/91+
         Ed9uAP6juqWGJV9pkSz3gSWc9RahE2Ii8r4yRkZriVQ7WQ15DTpVwB8cJnOJbeQfKLGZ
         8wWs7hZ3OY4jXTKgdCiGdJS+u5S11sI8bWitTttw4iyiniaQvyb4gSSssar8DWki5/Pj
         T77HYap3/hei6aQWh6WXxzRwJDiuEjYIql6KbkfqiyrjDR95lFg2pOAs3QZHGxz55scx
         qTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zkS588wwQozFVoD8zpAR8mFDb8Wl6jeJSAikk+zd1as=;
        b=t0idq2Qy7BGSso7G4jDOvWwS+G131prQESpfLkb3Y6vnpdXASo7aD4t/TwQBSXki8C
         1yJZWTC78L1LBnsBf5GHiySVRkUrgJyvHhIT+eixDZrlYQjeNfOzBtEoorfQQJOptnnv
         6PLrwadrdNN4txhYPMro2v6rr1K8Roh2yzMNZTUK704LCMBS1ZcJbovlWA8n+3eM3xNk
         PPvCnJgAnwDfNP44lAhMl2AKkyev2R0ndC/pGUAjOVFxN1cAdeBG6LWN/pj7CPFFdfGz
         0XC5ghb0VHr+Ja3coQw3sQzqdfo8qeJsrXLNojcLl18afgNEBbG/I5GeEldXV0xMxv4L
         9oPA==
X-Gm-Message-State: ACrzQf1nN+su0tDezNRpN6fWwVPcq88CKdhFkXiK3QY/6x7r26fGDd8O
        0oVKlu7rHfBj53QUtAVQl+CINQ==
X-Google-Smtp-Source: AMsMyM5a0DVWnfTbiDHhkfnAcj4mBUQerBqLMeFHFkX3T/uPj7HGm0mA5kAhiPsGxluhxJVCgSqVGg==
X-Received: by 2002:a63:8a4a:0:b0:434:c99c:6fd4 with SMTP id y71-20020a638a4a000000b00434c99c6fd4mr22740572pgd.24.1663738711506;
        Tue, 20 Sep 2022 22:38:31 -0700 (PDT)
Received: from localhost ([122.171.20.238])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b001754a3c5404sm896815pld.212.2022.09.20.22.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 22:38:30 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:08:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP fixes for 6.0-rc
Message-ID: <20220921053828.i7vtgycrtetithnn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-fixes-6.0

for you to fetch changes up to c7e31e36d8a262eb0bc2daf8f9b7481c83284386:

  dt-bindings: opp: Add missing (unevaluated|additional)Properties on child nodes (2022-08-24 11:34:22 +0530)

----------------------------------------------------------------
OPP fixes for 6.0

- Fix un-initialized variable usage (Christophe JAILLET).
- Add missing DT properties (Rob Herring).

----------------------------------------------------------------
Christophe JAILLET (1):
      OPP: Fix an un-initialized variable usage

Rob Herring (1):
      dt-bindings: opp: Add missing (unevaluated|additional)Properties on child nodes

 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 1 +
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 1 +
 drivers/opp/core.c                                           | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
viresh
