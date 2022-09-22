Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB66A5E676D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 17:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiIVPo5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiIVPoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 11:44:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4999EEB59
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 08:44:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so9504743pgq.8
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=X+5aodYFyN3INPL+B3DkuMqahUSDLOnwE8KyhjHJBIA=;
        b=X+hhjF+qP3h7aLQHb1MzTFr5r3+A1IH5oEqjZxo+pcZxxi2+TxZZr3qkY5UxB5cgOn
         Kh96pM7gX0bgF9BKUs9GJbkVfiTMWXg53d/BYM/7417Mlok8u9cvDEl3eMOnWAwwd/MF
         uqw2TCFGL/IRTS7+qi4nUrAzL7LdV4eyBQI8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=X+5aodYFyN3INPL+B3DkuMqahUSDLOnwE8KyhjHJBIA=;
        b=RUeIa3gVS/ihxSGkZLZwYHf73jLH/82vG6jYDoE/VvnRw9ekhk9c+G+QCDzFhMafnV
         3kOSLmwFnNDpmGae8MePK6AzMZYCRPm9zHf/R/OVnZl+WV1/Tw8o6UdMVEDJbyA9kKCE
         7NZTNdRsUWLHKStgyZVTYlWUw3wANXXPFU/UBcNV+f+5qiIHDy7Oea9HF8Cf485Cd2Om
         nTHitNbbTif9rXKodRUtNNruxler4dmEiyyxgc6zgK322DSRn94vltxrbhwgkf1Vk2Ab
         3NRUkgQwJ1YFa19ZNydNqu2KOPnS7RBYYiXRvMtwaAz4fxRsGQkHCriE/L6MoFvCAp6o
         6JWQ==
X-Gm-Message-State: ACrzQf0SZ/9IbvV2hopOIcwvware0dapVRFANCdhTTOwRKl7i1tutPpy
        06PJGeb7mPMUE6nn02W2quG5h7kKSsTvVw==
X-Google-Smtp-Source: AMsMyM7VMYkIC72PErqAfJMLYJ6m6IsKgfBgREzmGhoGeFst5metRcZ1ztaA5aV1ZBVL4F+dxiaDIg==
X-Received: by 2002:a63:340f:0:b0:439:9ac5:c1d2 with SMTP id b15-20020a63340f000000b004399ac5c1d2mr3517296pga.206.1663861445216;
        Thu, 22 Sep 2022 08:44:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5321:6ad9:3932:13d8])
        by smtp.gmail.com with ESMTPSA id a19-20020a621a13000000b0053e8fe8a705sm4685492pfa.17.2022.09.22.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:44:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     rafael@kernel.org, sboyd@kernel.org
Cc:     pavel@ucw.cz, linux-pm@vger.kernel.org, len.brown@intel.com,
        linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] clk: Avoid potential deadlock when disabling unused clocks
Date:   Thu, 22 Sep 2022 08:43:52 -0700
Message-Id: <20220922154354.2486595-1-dianders@chromium.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These two patches together fix a deadlock that I seem to be hitting
every time with my particular setup (a sc7280-herobrine board running
the downstream chromeos-5.15 kernel).

FWIW:
* Others tried with the very a similar setup to me and they didn't
  reproduce the hang, which makes sense after the analysis in the
  commit message of the clock patch. To hit this you just need to be
  lucky.
* I bisected this in our tree and landed on a cherry-pick of commit
  1b771839de05 ("clk: qcom: gdsc: enable optional power domain
  support") as the first one where I saw the hang (and the "fix" of
  that commit upstream didn't change things). Nothing about that patch
  was directly touching the code paths that my analysis showed so I
  can only assume it changed the timing in a way to make this happen
  reliably for me.

While the solution proposed in this patch series doesn't seem too
terrible to me, it's still not exactly elegant. This is why I'm
marking it as an RFC. If someone wants to send out patches that solve
this in a better way then I'd be more than happy.

NOTE also that at the same time I started getting the deadlock I also
started getting a lockdep warning talking about similar locks.
Unfortunately, the lockdep warning seems to be unrelated. This fix
handles the deadlock but the lockdep still shows up. I can also fix
the lockdep without fixing the deadlock. I'll send a separate patch
about the lockdep.


Douglas Anderson (2):
  PM: runtime: Add pm_runtime_try_put_sync() and
    pm_runtime_try_get_sync()
  clk: core: Avoid potential deadlock when disabling unused clocks

 drivers/base/power/runtime.c |   7 +-
 drivers/clk/clk.c            | 137 ++++++++++++++++++++++++++++-------
 include/linux/pm_runtime.h   |  28 +++++++
 3 files changed, 143 insertions(+), 29 deletions(-)

-- 
2.37.3.968.ga6b4b080e4-goog

