Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F259378AACD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjH1KZY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjH1KYw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 06:24:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6CDC
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 03:24:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so2113766b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693218289; x=1693823089;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZoePIRoTO2ELVeUOOowzDlyK7gqPgB8kbG2bl45KFQ=;
        b=sLp0kag/uuZyKVbGu2rHNECwSwU1WQY/YLJhaoWaLeXeOwlAVnNWYNjtoJoXpJX8rT
         95eTUcla5krXJNQa53f1htfT9bde9/P9EUbn2jxba5WxjkwunjXNUe08frIPrW4Qzkmz
         On7YG+1uKEBIdGPlNUvkSlAcHVISa9EFK52LaD2A76qiQnpxwo7qTRp4geu2djf/iHB+
         IyIrHa2C007Y4SwB31tsZHZiPoaDaQhs7pHSkawrioISTp5vyXCixg4c9aOFoe3sP3uJ
         6XK6y1enK+QwQ3buPJ4s19x6A8Iv28qyKKEwzMdmnNLOWzoNSnhAtHnuRIV1itDJKFT6
         GzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218289; x=1693823089;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZoePIRoTO2ELVeUOOowzDlyK7gqPgB8kbG2bl45KFQ=;
        b=l2yp5rT0vTIv9ozXlURg9+q6hyUDyKUTDkniVSpBeKzM6y/zbd+x/NEAyxjuh+OFtr
         Py4yIe/0RI6Vr0eF9B8sTFHrEk8uiEnM3ZaTnV3MGTDRqE5iU+Q07tg/cmZ9wjGsc5MY
         TXC8Fu5lPgeJfBTE3sVXH5mytVQzkG0ZKm2GfUuktWzkyWTdve12fDFgAb+ksR5qgUGe
         WAj27Jm9mEXHJLGP0WX2EH+M/R2n9Tihvq5A5e5UMSzDZhvYVyjO05tc1ubw3CRMVL/9
         OpEsUqquFG92AdRExCQQFf3H+PsEmH0EWQj2q9V34uNaUZexKmVRe8Ud2bCWZqcU2Voq
         o/uA==
X-Gm-Message-State: AOJu0YxunvY2l/fE45WBguYyeINJyBv4soC00t+vijU1yUQyOnv3uPZk
        eL1lxsunHrQaK38Ca07JzfIwKA==
X-Google-Smtp-Source: AGHT+IE6JUeEWrdwmb9UDzxdlNPkQ1MDIrBW7WNNFXzTMJsGMo1eUf/QzMEyIgflOvggqIvElRQ+Bw==
X-Received: by 2002:a05:6a20:432b:b0:13a:12c2:359e with SMTP id h43-20020a056a20432b00b0013a12c2359emr23256413pzk.2.1693218288682;
        Mon, 28 Aug 2023 03:24:48 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id ey6-20020a056a0038c600b006828e49c04csm6337794pfb.75.2023.08.28.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:24:48 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:54:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.6
Message-ID: <20230828102446.egoeuhxt3uwy7lr2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.6

for you to fetch changes up to e576a9a8603f7c6f8fed5159e2fe33f6d67a49e7:

  dt-bindings: cpufreq: Convert ti-cpufreq to json schema (2023-08-21 11:23:34 +0530)

----------------------------------------------------------------
OPP updates for 6.6

- Minor core cleanup and addition of new frequency related APIs (Viresh
  Kumar and Manivannan Sadhasivam).

- Convert ti cpufreq/opp bindings to json schema (Nishanth Menon).

----------------------------------------------------------------
Manivannan Sadhasivam (5):
      OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
      OPP: Introduce dev_pm_opp_get_freq_indexed() API
      OPP: Fix potential null ptr dereference in dev_pm_opp_get_required_pstate()
      OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
      dt-bindings: opp: Increase maxItems for opp-hz property

Nishanth Menon (2):
      dt-bindings: opp: Convert ti-omap5-opp-supply to json schema
      dt-bindings: cpufreq: Convert ti-cpufreq to json schema

Viresh Kumar (5):
      OPP: Rearrange entries in pm_opp.h
      OPP: Add dev_pm_opp_find_freq_exact_indexed()
      OPP: Update _read_freq() to return the correct frequency
      OPP: Reuse dev_pm_opp_get_freq_indexed()
      OPP: Fix argument name in doc comment

 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt              | 132 ------------------------------------------------------------------------------------------------------------------------------------
 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml |  92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml                |   2 +-
 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml         | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt         |  63 ---------------------------------------------------------------
 drivers/opp/core.c                                                    | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 drivers/opp/cpu.c                                                     |   4 ++--
 include/linux/pm_opp.h                                                |  62 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 8 files changed, 344 insertions(+), 229 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt

-- 
viresh
