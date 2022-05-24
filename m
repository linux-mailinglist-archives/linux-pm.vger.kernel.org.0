Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9F532273
	for <lists+linux-pm@lfdr.de>; Tue, 24 May 2022 07:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiEXFaT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 01:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEXFaR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 01:30:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC07A827
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2022 22:30:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so14940451plg.5
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2022 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=soFxGQVhjobe324nGpU6ESuuAf0l+3Fy7yoQ524zmCc=;
        b=O/E4WNoCk6m50knmUz8ZmuLEjrYh1mDCMbYrN/v++wgsB8fFK4m1KZkVPGwBaFqGdW
         MKZI0CWyTV0YadWii4i3N4Ggu6s/LToCrXOVC+Nx1/bjw36YAbbjr+mKSB7BWYyc10a3
         9SfwUuYtv+9xwLJhs3DNwM1vzwLznu42zgI5sAQgoDWf/tsQyPPpTBE0fvt6F06JI4Wp
         +ClHEJ6wt3dZa34vStZS2ppS+J69z8z8O7mNzV31m45zGtI85iNjkAhITu9lTndqXD5y
         5787MM4/mZEHryqDhQ00SPu1Np4AsVPruIC+nrrhGof9tbDB4JU0BJncFD88XRT7H7NX
         jp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=soFxGQVhjobe324nGpU6ESuuAf0l+3Fy7yoQ524zmCc=;
        b=Ia7pGdsOMzxMrmqA2owolWduyLwCz0nlPu8a67Di80q1XRxqvrFEtX5+hZAoUOJdUP
         ipCsTeh+P+o4jRhH0i51j1UjdkfByiUitZT76AAArYKlpokihN8Az+nfSTVx1MKHpYin
         akAT4wLGMTrPId583/HtWJw4HD881eAOSqSeSMi1I4YaAM40l0+/twgvr4e4WoRX7SRR
         vwKfl/xN1jSHJe5bygEIkIovhHDr12+OI/vRZXL4Z6fNrhquxlij70eLSiv86aqfL9Q1
         LAPXtDcTwLUJxGEZeJPhvHlpAZB+2Z+wYsjrN0wE7quCJCaXuBbHhk4QNCxhsKzYl8Ow
         OyAA==
X-Gm-Message-State: AOAM5311y0QFzvjbIQ/oTpWoVpO95ybHeaUV4RzcyO+x6VzsYWCK7NdZ
        /gJuLQMNhC2AFzX7Z8fZvjjMTZDeHq4F/g==
X-Google-Smtp-Source: ABdhPJzy06DQzVFJ5EkOnTyusI/MYtAmGk4BTt6vuX1nq39A+1OSVyY4wc2N8x+n0WG2iIxI2XsiqA==
X-Received: by 2002:a17:902:7c11:b0:162:1122:8a7f with SMTP id x17-20020a1709027c1100b0016211228a7fmr12418733pll.37.1653370216053;
        Mon, 23 May 2022 22:30:16 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b0015ea3a491a1sm6037326plt.191.2022.05.23.22.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:30:15 -0700 (PDT)
Date:   Tue, 24 May 2022 11:00:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 5.19-rc1
Message-ID: <20220524053013.ohb46jykdjmss75l@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-5.19-rc1

for you to fetch changes up to 22079af7df5a5dfef1c4d160abfd43035211759e:

  opp: Reorder definition of ceil/floor helpers (2022-05-04 15:40:22 +0530)

----------------------------------------------------------------
OPP updates for 5.19-rc1

- Minor update to dt-binding for Qcom's opp-v2-kryo-cpu (Yassine Oudjana).

- Use list iterator only inside the list_for_each_entry loop (Xiaomeng
  Tong, and Jakob Koschel).

- New APIs related to finding OPP based on interconnect bandwidth
  (Krzysztof Kozlowski).

- Fix the missing of_node_put() in _bandwidth_supported() (Dan Carpenter).

- Cleanups (Krzysztof Kozlowski, and Viresh Kumar).

----------------------------------------------------------------
Dan Carpenter (1):
      OPP: call of_node_put() on error path in _bandwidth_supported()

Jakob Koschel (1):
      opp: replace usage of found with dedicated list iterator variable

Krzysztof Kozlowski (2):
      PM: opp: simplify with dev_err_probe()
      opp: Add apis to retrieve opps with interconnect bandwidth

Viresh Kumar (1):
      opp: Reorder definition of ceil/floor helpers

Xiaomeng Tong (1):
      opp: use list iterator only inside the loop

Yassine Oudjana (1):
      dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM

 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   |  56 ++--
 drivers/opp/core.c                                 | 339 ++++++++++++++-------
 drivers/opp/debugfs.c                              |  10 +-
 drivers/opp/of.c                                   |   2 +-
 include/linux/pm_opp.h                             |  41 ++-
 5 files changed, 291 insertions(+), 157 deletions(-)

-- 
viresh
