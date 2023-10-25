Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8B7D69B8
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJYLDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYLDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 07:03:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7AA6
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 04:03:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bee11456baso4577976b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2023 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698231822; x=1698836622; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2pAfuEafsipOzqV1amhSCetLC9FMT9CjTuTTPR3400=;
        b=aGLliAoAdYGEExZ+sNIDiZwYhba/cS2iY9/D4Z2xl650D9SJ1ZPz0YOyi2QxgDouUk
         SnArNkw2g+shEw2K78g4Exv4XSg6S00wYHFywJUFpZt4JrgqJ31UwtMNB4L2YExRy2pQ
         P/8OAeQmlxNS9VSbjUQdJ5sZfZHY3ZZlalbLTQFVYJhwvAIGyxTB90eHgLMc3Y3KqQvP
         5LdKPashoGWQvA2Dh8Iwsn7EVfl7MlniIQxq2D7Pqm+KPCSHNfZDUtt7qbhOe+E1DAqV
         CxquqKMO7vz3pKrQL4Co49ax9FXysU+w+TPu/gRFMuHmFK3GjorCm6J6uH/qqBVStjRh
         60zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231822; x=1698836622;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2pAfuEafsipOzqV1amhSCetLC9FMT9CjTuTTPR3400=;
        b=bF46XFkKVZkvDFRUOINz7C/rdVTQKXFoZFc+U4dmUQ+QzS2KYkWnnKZdoRRlyXstnu
         kXeJWwktZt/nco1cdVbPgdLxzxC/yfQ4B29+ulC5WBau/ZF+hrDkNe00Xgy+Jdd4JP7V
         mkbwu1Gq2aDtWh3CscqPH43t5KNz4rwKD2oAJEF8QOJIG+BKQXH7oT0NUONF09albjnN
         wvG5sBj7WZ94KXPgMxZQ/NW49L7UwvqV81IR0dDZGwtXpVAIQ3HzKz5z5xaxUa2Qw8aZ
         zg7AO37TM2xcPR7jaw4Hna5xVU5GJ24vNyr64gdfbxl4KmWyFrVOla9VxzkbaRth6AR0
         iLZA==
X-Gm-Message-State: AOJu0YxVMineaLuODHhSe2chdKp3mQdukiwwt8uf2/9uIsSsogUAbf12
        rSpwNS3ntr4Urk+s7xSPyTy24A==
X-Google-Smtp-Source: AGHT+IEUA4GxVhrvqPM/hJhdYEnY9EFYkMZ+0IUtvnqG4SBDtGyx5A7zVRolqS0YWRWuCY1g8R+zcQ==
X-Received: by 2002:a05:6a20:d39a:b0:17a:de38:7416 with SMTP id iq26-20020a056a20d39a00b0017ade387416mr5002099pzb.61.1698231822135;
        Wed, 25 Oct 2023 04:03:42 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id t8-20020aa79468000000b006884549adc8sm9130208pfq.29.2023.10.25.04.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:03:41 -0700 (PDT)
Date:   Wed, 25 Oct 2023 16:33:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.7
Message-ID: <20231025110338.zxl2yhg5lkcgpwbn@vireshk-i7>
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

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.7

for you to fetch changes up to 35e0964e4876c4d77ed0d6d49678f7f6270f32e2:

  dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt property (2023-10-19 12:16:11 +0530)

----------------------------------------------------------------
OPP updates for 6.7

- Extend support for the opp-level beyond required-opps (Ulf Hansson).

- Add dev_pm_opp_find_level_floor() (Krishna chaitanya chundru).

- dt-bindings: Allow opp-peak-kBpsfor kryo CPUs, support Qualcomm Krait
  SoCs and document named opp-microvolt property (Bjorn Andersson,
  Dmitry Baryshkov and Christian Marangi).

- Fix -Wunsequenced warning (Nathan Chancellor).

- General cleanup (Viresh Kumar).

----------------------------------------------------------------
Bjorn Andersson (1):
      dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps

Christian Marangi (1):
      dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt property

Dmitry Baryshkov (1):
      dt-bindings: opp: opp-v2-kryo-cpu: support Qualcomm Krait SoCs

Krishna chaitanya chundru (1):
      OPP: Add dev_pm_opp_find_level_floor()

Nathan Chancellor (1):
      OPP: Fix -Wunsequenced in _of_add_opp_table_v1()

Ulf Hansson (6):
      PM: domains: Introduce dev_pm_domain_set_performance_state()
      PM: domains: Implement the ->set_performance_state() callback for genpd
      OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
      OPP: Extend dev_pm_opp_data with a level
      OPP: Switch to use dev_pm_domain_set_performance_state()
      OPP: Extend support for the opp-level beyond required-opps

Viresh Kumar (7):
      OPP: Remove doc style comments for internal routines
      OPP: debugfs: Fix warning with W=1 builds
      OPP: Fix formatting of if/else block
      OPP: Add _link_required_opps() to avoid code duplication
      OPP: Reorder code in _opp_set_required_opps_genpd()
      OPP: Remove genpd_virt_dev_lock
      OPP: No need to defer probe from _opp_attach_genpd()

 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml |  36 ++++++++++++++++++++---
 drivers/base/power/common.c                                |  21 ++++++++++++++
 drivers/base/power/domain.c                                |  33 +++++++++++++--------
 drivers/opp/core.c                                         | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------
 drivers/opp/debugfs.c                                      |   2 +-
 drivers/opp/of.c                                           |  74 +++++++++++++++++++++++-----------------------
 drivers/opp/opp.h                                          |   4 +--
 include/linux/pm.h                                         |   2 ++
 include/linux/pm_domain.h                                  |   6 ++++
 include/linux/pm_opp.h                                     |  40 ++++++++++++++++++++++---
 10 files changed, 254 insertions(+), 195 deletions(-)

-- 
viresh
