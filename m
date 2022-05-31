Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB513538E85
	for <lists+linux-pm@lfdr.de>; Tue, 31 May 2022 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245454AbiEaKKT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 May 2022 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbiEaKKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2022 06:10:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9928DDEF
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 03:10:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1807165pjq.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2022 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j57ZrMG+9VBM+p+9s2sRlhsnGkiugqPokE6M298uNQM=;
        b=MLPtGe6XRXBV2B/mjt0vE9YplU+v/G+cS6bfJadMY3EhacRqxBu4vsvkoqM6882X7d
         xsP0PNgam5Z5hcvh1onn2i0erXxi4kjQOQo1V5sDPM9AvJs/dl9M+qZ3I6VBQaEcmzH7
         eMu2dZyNFQvtZJcmMP231SecB0NSGWVWgwukaQsgMnbEXIJ3IYqq8sJhDFe2bMHe1XL8
         a8FaKe5/1OiEukzVH/63wi7BgJL260vUV21WKZ5pss+dN0ojaON1VnXsePXtKtk1yJjT
         b7xBUGcrU3ZK/0PX7eNSuPlqEOJOAqjMBWDIDORaaZDkgJP+LHodoe0uQjzbzmedy0jT
         2tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j57ZrMG+9VBM+p+9s2sRlhsnGkiugqPokE6M298uNQM=;
        b=eEAAVBQM+AYXZJ9gmiWEV4wsg0QwtwyLUN6ZkUF7CZDUnpP8dZvG3mdzqkL8VXTBpn
         RVxMfJXoZB5tX6wXPqUEsIqEipa5teFe6zz9NzUQmoWyoReAa8y+xtcIia4w52W+MbOz
         QjYjeKLQ5M0NXSRilsHw13LlSfO57eYWNWnoyqFBQ3gQO1ioklu9/pX5/ueuXoCdEMX3
         Yc2/7lV9eb5rX1J65vSuF/VoLQ6Vmp4ppPk7nLiYrzKc27Y6Sf2msc5z29I0CQ3wXz5C
         lHLkZmoNuPDCc+b9hh/6VGC1v2iK5XPTYGIOf8yL4YoapbM5UltKwmUiPMSqbHkSLPNR
         Xpiw==
X-Gm-Message-State: AOAM531xW3tmnC+JRgKrrhxrcXe6iovW7AMuEewvqVf1TcXjXEFVOvdY
        C9eEqLHFS3YqpPgb630agA+tsQ==
X-Google-Smtp-Source: ABdhPJxQOJa+5En5BnRKPLbV+ML0lnY/36s4UyK7xqUJmeTLwp7jzBg30gv/nDj+r2ps1UdedNAvkg==
X-Received: by 2002:a17:903:11c9:b0:154:be2d:eb9 with SMTP id q9-20020a17090311c900b00154be2d0eb9mr59498713plh.91.1653991816482;
        Tue, 31 May 2022 03:10:16 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a63495d000000b003fbc60e3358sm6861084pgk.4.2022.05.31.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:10:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] OPP: Replace custom set_opp() with config_regulators()
Date:   Tue, 31 May 2022 15:39:59 +0530
Message-Id: <cover.1653991004.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series is in continuation to OPP cleanups [1] posted earlier and is rebased over them.

Currently the custom set_opp() helper, which is implemented only for omap, is responsible to set
both clock and regulators for the device and may end up doing tricky stuff behind the scene. This
makes the OPP core contain special code to support it.

This patch series tries to streamline the code path in _set_opp() in the OPP core and minimize the
platform specific code within it. The platforms provide a config_regulators() callback now, from
which they should only program the regulators in their preferred sequence. Rest of the code sequence
to program clk, bw, required-opps, etc is common across all device and platform types and is present
in the OPP core.

Keerthy/Dave: I couldn't test it on omap, can any of you do that please ? It builds just fine
though. Also maybe you can simplify the OPP driver to drop all restoration logic on failures, as the
OPP core doesn't do any of it as well. I can add a patch for that if you guys are fine with it.

This is pushed here along with other dependencies:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/config-regulators

Thanks.

--
Viresh

[1] https://lore.kernel.org/lkml/cover.1653564321.git.viresh.kumar@linaro.org/

Viresh Kumar (5):
  OPP: Add support for config_regulators() helper
  OPP: Make _generic_set_opp_regulator() a config_regulators() interface
  OPP: Add dev_pm_opp_get_supplies()
  OPP: ti: Migrate to config_regulators()
  OPP: Remove custom OPP helper support

 drivers/opp/core.c          | 204 +++++++++++++-----------------------
 drivers/opp/opp.h           |   9 +-
 drivers/opp/ti-opp-supply.c |  74 ++++++-------
 include/linux/pm_opp.h      |  47 +++------
 4 files changed, 118 insertions(+), 216 deletions(-)

-- 
2.31.1.272.g89b43f80a514

