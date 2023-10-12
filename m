Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97CA7C714F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347155AbjJLPVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347050AbjJLPVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 11:21:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17944BE
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:21:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50325ce89e9so1564103e87.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124094; x=1697728894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hM2IUyL3dTocxTxwOsznMTNjBlX93NcKqGbt9NreAaE=;
        b=zgEuYLr1Wa+zQOozndi7N1ShMNu7gMlwQCEiwlup4cC529vXgJMrp8XB4/latvbMxh
         Ve0IAw7NXUw4pFpHswTAeC8cMatx6vI5nuz0l3xSRHUoyZJyIoSwJ5izyubXJMr9kK8G
         MN7B5PSnp4IIt7TV0Xx0UMXgXBrQbjyc7artYVhV8Z2+50LdATJrk+SL6VsOvZjM9Gh8
         C5UBA5sS0KkROPWQ40CMNmOKlHzUpH0T06NlBSTlP95s9zYfY/QY9+vojXQwjUCfAMpF
         nskjFoya5c+4IaqjFdxuh7GeUY6elEoL1Ucku0dgRupd9b+0atDtowbeSsAFHgX82Aor
         RkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124094; x=1697728894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hM2IUyL3dTocxTxwOsznMTNjBlX93NcKqGbt9NreAaE=;
        b=d8yqSUSKbaJ7yrNqCTNc2gDLe1xCSkYqBSz6MhWQjujyouBUEd41nK9lOcU64M2/m5
         gTbaJHTX4WrTWeslLkRwYXFRSo4i8acuZ9RnQNAyKyubLzGv6mgFjFf/dzW8T0XcnqeR
         hXSrQbP+rhxrKFBF3BGWFh65YAdSTg9q7G80wc26EQy1Yo6dNFaHEMXZNJ+qUJksir/Z
         AXwwRo+fUb6nPRXPUCuI290wGjzY7XVRi7dp5rLLnjoCxqa9KkclLdh975wgZUKnQprV
         QheuZ0K8Ync6hP2CytdjZL/0v4LOo3VtcL7mnqbrI5H2/aHCYUlNF8jJnCaICERZtOob
         T3lg==
X-Gm-Message-State: AOJu0YxhpjaH3Q2iJ9PHojctQMVNI+ej7+JKv5udhwchy5/YkZ3/bbNU
        8f7/NmwaUIfYujRkhLD8NBNmKQ==
X-Google-Smtp-Source: AGHT+IG99A57kmCU0lF5bXK/Qz13g5IKvmP9fe2U6OPhLsJGd9LUtXHcI4IbRxlw3ObXDNi3cOkflg==
X-Received: by 2002:a05:6512:69:b0:505:98a8:fa2f with SMTP id i9-20020a056512006900b0050598a8fa2fmr19413767lfo.60.1697124094270;
        Thu, 12 Oct 2023 08:21:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id j18-20020ac253b2000000b00501bd76ccaasm2853676lfh.166.2023.10.12.08.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:21:33 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] PM: domains: Drop pm_genpd_opp_to_performance_state()
Date:   Thu, 12 Oct 2023 17:21:08 +0200
Message-Id: <20231012152108.101270-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <-> level
dance"), there is no longer any users of the
pm_genpd_opp_to_performance_state() API, while a few genpd providers are still
assigning the redundant ->opp_to_performance_state() callback.

Let's clean this up so we can drop pm_genpd_opp_to_performance_state() and the
callback too.

Rafael, I would like to take this through my pmdomain tree, unless you see a
problem with it ofcourse, hence I need your ack on the last patch in the series.

Kind regards
Uffe


Ulf Hansson (5):
  soc/tegra: pmc: Drop the ->opp_to_performance_state() callback
  pmdomain: qcom: cpr: Drop the ->opp_to_performance_state() callback
  pmdomain: qcom: rpmpd: Drop the ->opp_to_performance_state() callback
  pmdomain: qcom: rpmhpd: Drop the ->opp_to_performance_state() callback
  PM: domains: Drop the unused pm_genpd_opp_to_performance_state()

 drivers/base/power/domain.c    | 32 --------------------------------
 drivers/pmdomain/qcom/cpr.c    |  7 -------
 drivers/pmdomain/qcom/rpmhpd.c |  7 -------
 drivers/pmdomain/qcom/rpmpd.c  |  7 -------
 drivers/soc/tegra/pmc.c        |  8 --------
 include/linux/pm_domain.h      | 12 ------------
 6 files changed, 73 deletions(-)

-- 
2.34.1

