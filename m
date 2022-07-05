Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8455663B1
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 09:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiGEHAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiGEHAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 03:00:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625FE0FD
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 00:00:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 128so10672362pfv.12
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 00:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUBBq1ygcQTWcllnQnv9hUGFAmvHHVoH28qY+W8QnBE=;
        b=Xomgl+tX+JuEgJb4L/ud2hR9WtEInetJEz6PnXqPOICEPrbom4zFBSBCMic5H7Kzz8
         yVfeoaxvja7C8QLeqDYfMGx4BfgrNj6P8QjB1/kDYyV8zKDgIlUZw/RA4DjLmlirFnUR
         tpQu5+HvrLVQJva7SHLONoU3657vCOXWCYqJpN/Vrw2VlERsiVXPTPmsmzwNaJTjisDP
         8OUngSWWVvtze8rcVshJhbL+hc8yxO6uKHcI0KtjHy9f/wxJN2w99NVDg5KZ0XBW0jrF
         DQsJ0wkEZCGsrxfH8kdxBUhQ22BrGgHkqNN/36ERzT137mJ2y6FKNc33qXyZlW0q0u8f
         kVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUBBq1ygcQTWcllnQnv9hUGFAmvHHVoH28qY+W8QnBE=;
        b=MQkQDcyUfjfQjpqwgb206lWNJqm0Is8NLN0EcaiUQUIYmxBuIvTlOlxb6h3mgP80sp
         C0ZCMQ3AH1TxYGCkt+rr4vbYYQC2Koe10hk12BgKahhKiAhuT0ZPShq92LELxneb4m1v
         8uas24sXNmaqFfM/kXieXFvZ7Zb1nxfHA3N6GvjrZ4QnRWDeIh/g5WZg7SLIMkNUZOso
         Vn5n+P+vFyrWOBrtsC3KlHTuUYdcqAkX7T30kcqWZBS6hwjylEfCKhBFL8f0IvWvjzZN
         BeqgQt3DAKbd3GHj6G++7HN6KBZQ3oZM8fIswknl6PMZyN+w+S94pjmgLvY7eYSfIsOU
         wHAA==
X-Gm-Message-State: AJIora9LclcjSsIgAd2ORKo17qpHHt/72rsFCFKFduT0gyXh+EAS7J3s
        JFj2dCUT8kDzSTSjNP5XrDUZlA==
X-Google-Smtp-Source: AGRyM1sjM0w+mr8gF005E7+SGsLYRu1tV7qvuqbksNU8g/P0WYbFHA2AstWU3pTrsoJwZWT+SA/alQ==
X-Received: by 2002:a05:6a00:ad0:b0:4f7:a357:6899 with SMTP id c16-20020a056a000ad000b004f7a3576899mr40383862pfl.80.1657004431077;
        Tue, 05 Jul 2022 00:00:31 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm21522380pgk.76.2022.07.05.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Date:   Tue,  5 Jul 2022 12:30:03 +0530
Message-Id: <cover.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patchset adds support for devices with multiple clocks. None of the clocks
is considered primary in this case and all are handled equally.

The drivers, for multiple clock case, are expected to call dev_pm_opp_set_opp()
to set the specific OPP. Though how they find the target OPP is left for the
users to handle. For some, we may have another unique OPP property, like level,
which can be used to find the OPP. While in case of others, we may want to
implement freq-based OPP finder APIs for multiple clock rates. I have decided
not to implement them in advance, and add them only someone wants to use them.

This is rebased over a lot of other OPP changes and is pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

V1->V2:

- Fix broken git bisect for:
  OPP: Reuse _opp_compare_key() in _opp_add_static_v2()

- Include binding changes written by Krzysztof earlier.

- Check config_clks before calling it, it isn't always set.

- Add config_clks for Tegra30's devfreq to handle its corner case.

- _opp_compare_key() supports multi-clk case now, earlier it skipped freq
  comparison for such a case.

- New patch to compare all bandwidth values as well in _opp_compare_key().

- New patch to remove *_noclk() interface.

- Various other minor fixes.

--
Viresh

Krzysztof Kozlowski (1):
  dt-bindings: opp: accept array of frequencies

Viresh Kumar (12):
  OPP: Use consistent names for OPP table instances
  OPP: Remove rate_not_available parameter to _opp_add()
  OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
  OPP: Make dev_pm_opp_set_opp() independent of frequency
  OPP: Allow multiple clocks for a device
  OPP: Compare bandwidths for all paths in _opp_compare_key()
  OPP: Add key specific assert() method to key finding helpers
  OPP: Assert clk_count == 1 for single clk helpers
  OPP: Provide a simple implementation to configure multiple clocks
  OPP: Allow config_clks helper for single clk case
  PM / devfreq: tegra30: Register config_clks helper
  OPP: Remove dev{m}_pm_opp_of_add_table_noclk()

 .../devicetree/bindings/opp/opp-v2-base.yaml  |  10 +
 drivers/devfreq/tegra30-devfreq.c             |  22 +-
 drivers/opp/core.c                            | 404 +++++++++++++-----
 drivers/opp/cpu.c                             |  12 +-
 drivers/opp/debugfs.c                         |  27 +-
 drivers/opp/of.c                              | 139 +++---
 drivers/opp/opp.h                             |  24 +-
 include/linux/pm_opp.h                        |  29 +-
 8 files changed, 466 insertions(+), 201 deletions(-)

-- 
2.31.1.272.g89b43f80a514

