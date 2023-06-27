Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6673F0C3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 04:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjF0CQv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 22:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0CQu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 22:16:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF321720
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 19:16:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-54f87d5f1abso1855170a12.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687832209; x=1690424209;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGpKeicKALIbacvuoOZRi0lZMVVCp7odB5NsCx0zMx8=;
        b=HK1hD+AZyXT+eFelQ0UmTyrhjfyZnSOknbNhvNARQZDK4MWrCdKIRbI6ZC0t/HhjKa
         q5UjiyU4ZSofEKiBLoPH6rAHc/pANRMVYyu0BJIQEll6RE7ardu6WXC7rzWBRy1R7AsP
         FX0hM5TFDe6bp+jxq9v7rPgdfQEaqzTXw3JrsFg4yh7SB+dOAVphpldxFt3WUVRDxQ1s
         F3uFaGMyZgJ19ktWledT1+mlyNKHCKzqdPeoGdHOqNRJCVz/p/EIlUgduEiTsv/Lp9FC
         GCw/R9vjHZTLSwiiQyrsf9Ad/ZF+1kr4iZ3w5hG52BnLmQe5gDQx0IWklXC4DJjhkPVJ
         jDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687832209; x=1690424209;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGpKeicKALIbacvuoOZRi0lZMVVCp7odB5NsCx0zMx8=;
        b=Kfb46hhzYJDWyfFb43zczyXCnKu7+P4OUvdW0p+4wDDXMhpp5z4H0dGBv9fKdArya4
         bwrNHqSqa5vYvRBRnF9txUaIktqYIiwMPVZrF7Q86yPtrv/LRN6hln5JEX1fUZG3DtnG
         ZF4emjf7xCc7GlEVjJXMgy+LjyUNH44g1ddhwEu0RtKFU7trkcjJjCJ02MmNyBzOknhs
         2F97lmxo3vc6XJmfGPvpebet3KI8u0DGiOJCqCh/45kF6KOuLJOnBc5+3AEiqzRr9Gk5
         k6tVORwX4NN91PVKUCpD356/2r+6I75QaQwMi6bQWbFVmW1Dz1AAcwNFtuKc6lC2wiXP
         30fA==
X-Gm-Message-State: AC+VfDzm/Rih2vbUHn4EM6edL8ga2pKcZBwIdecyq3GNZxPO/LqDc878
        OQpsN2K6ovcYsW5kvRAJQR0WGw==
X-Google-Smtp-Source: ACHHUZ5HB2ywgY3E2h59Klu7lNMkCo4YjUUZZMzOHr+bF78RPia9FBX/DyVtG44mdFefSxinY+SjFQ==
X-Received: by 2002:a05:6a20:1613:b0:126:ee92:2563 with SMTP id l19-20020a056a20161300b00126ee922563mr4502212pzj.59.1687832209083;
        Mon, 26 Jun 2023 19:16:49 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b6a241b67esm4366066plw.296.2023.06.26.19.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 19:16:48 -0700 (PDT)
Date:   Tue, 27 Jun 2023 07:46:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.5
Message-ID: <20230627021646.evsp6e3capqxx6xn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.5

for you to fetch changes up to 5fb2864cbd50a84a73af4fdd900b31f2daddea34:

  OPP: Properly propagate error along when failing to get icc_path (2023-06-27 07:35:14 +0530)

----------------------------------------------------------------
OPP updates for 6.5

- Simplify performance state related logic in the OPP core (Viresh
  Kumar).

- Fix use-after-free and improve locking around lazy_opp_tables (Viresh
  Kumar and Stephan Gerhold).

- Minor cleanups - using dev_err_probe() and rate-limiting debug
  messages (Andrew Halaney and Adrián Larumbe).

----------------------------------------------------------------
Adrián Larumbe (1):
      OPP: rate-limit debug messages when no change in OPP is required

Andrew Halaney (2):
      OPP: Use dev_err_probe() when failing to get icc_path
      OPP: Properly propagate error along when failing to get icc_path

Stephan Gerhold (1):
      opp: Fix use-after-free in lazy_opp_tables after probe deferral

Viresh Kumar (5):
      OPP: Staticize `lazy_opp_tables` in of.c
      OPP: Protect `lazy_opp_tables` list with `opp_table_lock`
      OPP: don't drop performance constraint on OPP table removal
      OPP: pstate is only valid for genpd OPP tables
      OPP: Simplify the over-designed pstate <-> level dance

 drivers/opp/core.c    | 44 +++++++++++++++++++++++++-------------------
 drivers/opp/debugfs.c |  1 -
 drivers/opp/of.c      | 40 ++++++++++++++++++++++------------------
 drivers/opp/opp.h     |  6 +-----
 4 files changed, 48 insertions(+), 43 deletions(-)

-- 
viresh
