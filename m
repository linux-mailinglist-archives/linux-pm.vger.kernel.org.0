Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FECE11B6
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 07:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfJWFfW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 01:35:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37895 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJWFfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 01:35:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so9515886plq.5
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 22:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0WH9bZEqSCmBlUnIay8PI2Apec3Jt+76dMNWpxlS9u8=;
        b=mIIm2xEf3LQspDuyPfTQbkLRccKi8vi7Dx6wHjhjjZsDONrj0LjOfKoN9xE+hnI0uf
         7ijvsWhdgHxMC59hGR7bjc2c2GjeHYRZIa0w6M5X8wDj5Y+HkC33pxlDEBYLSpeNJaDP
         JTB6Pr6RSyItz3ISDVYl4+CV8Pzc9mTxnZn+zVmH3ytwsO7DK+A0x2EjiAGs2+ZMykVz
         LUSFKJFBZADAewss6Px2Nq/w9ajLr2CifHZvABju1snUOiDUfqH30S+5nVjQEi6/nN7o
         WiihxD1qIPhcWVHBR6fQVU8pv2NERgck+8ZC5g5Zs6qWBWsSfeIXzqxYOd61C81DK+uy
         vwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0WH9bZEqSCmBlUnIay8PI2Apec3Jt+76dMNWpxlS9u8=;
        b=I1FJVhq1yPfrbl6aBZ3vtf54RUDBHgRZ1tYQ8b34AhW1E2KKtPKH+ZC/2FKrxpz3n+
         ZLZbmRTM04n8pvvkqvBaUZwULxWcWr80euA4QXcezbok0LglOswKjL0qeEaFpxJE1tHV
         h8OdRnM6mbNdeAcNzUk2VKCLR/CEoUPv8VWjYzqu2UToGpNpjSEAYcQNo7ywvfPBAhMa
         GANeXRbU2VgrmagVVBYarZ8cE9wU0DXD+ez5V+tvhVneD1LDfHhhLxsIF5ZS8/6K2BFr
         Dqxks/byiwf/OGi/n9iTMDv1Q1z4Pezbfb0futYM1JKT0dbOj1ufmfSmHmR0zcKoMhYm
         u/Mg==
X-Gm-Message-State: APjAAAUAfRHTY7K+wO4Go3noXgodX270w28ZtAFbn6qJjI1FHSZGafRG
        ZwQce9haqWNk73EmLi4W0R6lLw==
X-Google-Smtp-Source: APXvYqwpmhmr7WaqGyp1H8svEPGzdM4fVLR4myzWbkBxCSWCAM4xT6q3MeKScdDEgf3M1C0V7vTH4A==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr7803705plq.168.1571808919839;
        Tue, 22 Oct 2019 22:35:19 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id n23sm19817868pff.137.2019.10.22.22.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 22:35:19 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:05:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] opp/fixes for 5.4-rc
Message-ID: <20191023053517.aa7not4zqjt5tvtw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Patch to revert addition of regulator enable/disable in OPP core
  (Marek).
- Remove incorrect lockdep assert (Viresh).
- Fix a kref counting issue (Viresh).

--
viresh

-------------------------8<-------------------------

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes

for you to fetch changes up to b19c23551be8de0d4e59fe6af70f10763e3cc595:

  opp: Reinitialize the list_kref before adding the static OPPs again (2019-10-23 10:58:44 +0530)

----------------------------------------------------------------
Marek Szyprowski (1):
      opp: core: Revert "add regulators enable and disable"

Viresh Kumar (2):
      opp: of: drop incorrect lockdep_assert_held()
      opp: Reinitialize the list_kref before adding the static OPPs again

 drivers/opp/core.c | 16 +++-------------
 drivers/opp/of.c   |  9 +++++++--
 2 files changed, 10 insertions(+), 15 deletions(-)
