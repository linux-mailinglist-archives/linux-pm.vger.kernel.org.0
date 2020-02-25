Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4A16B8B9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 06:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgBYFIf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 00:08:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34510 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYFIf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 00:08:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so6548323pfc.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 21:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tqUZYiy81UZHq8KwguRSjJqW3NIJKHOMPFN5dA6hUv8=;
        b=HGakzGuddi3jXQkWHnNveg1vOMeIzRUtO/HXDf4I2PUzHfltbjm1Qezj+1200nLeOB
         TQvKVErZTc5ASbCnmw+DEp1J0aTGRROvPcxXLhkOhmFlbwjoca4lTNscoG8v3YySwblG
         Tv7aOi6vW0mj+pArzFrotksKu9IMk6MiwwrmDodrY1/X5U51Le3pXnoRpcW1kF8bicPZ
         d10DqU4SEZ9Imy5zD+ds94sLfJPaFa7cpdFCuxwMCg7xjk/fu8OlPoCLglRW3DkIcCWl
         ZNR7NukXTFSf/c9NrJRxAkIBcaMiGanlWaynkU5LP+2+pVU7o5bb0NWxWW8u3ajLM/tN
         6ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tqUZYiy81UZHq8KwguRSjJqW3NIJKHOMPFN5dA6hUv8=;
        b=kLbFZRx2QA+15EvRxXrcTMfKwarAyteyg0gQ80kTDZhnC3vb6IOyA4LCM468dSxqv5
         88ot6pkbfRsy92z19vHnzl30tR6DgKKSLQ/HQoQwiL7y/hDvFgQQR0pvtRNX0YbTqP8q
         OX7j9ECg/4uaQCOeuNuUk1g96o1l6xmk7FPtVVdnDbboEf7eflQ69vugZkzVwJ5i6VOj
         rLCSqEKO1vLOuumdMqtAljOngg++JYbUgxWotyD/hHwic2f9lV2De9rJ9TzyPdhwPHCa
         WJfBAsEX2G10ZXAKRqkJFBQl2uYkYWUlQ0QADK8OvE8zV0RyGNtxF6oRxE3NgfwFF+cx
         nO3w==
X-Gm-Message-State: APjAAAWQc5KJj59K3VJ47hf7HMpLT2UGuIyTKZqyJnvAXKBTSLFUJb49
        BVomq63QdvCA97Ez9cg8r5FquQ==
X-Google-Smtp-Source: APXvYqz6IE9jh60Xr9+8h5LussuaMmJSlBt6AR00pDT9XEyDZcJ9EfJ4du1eFt5MYekdaXcI574iUw==
X-Received: by 2002:a62:6342:: with SMTP id x63mr54999297pfb.103.1582607314399;
        Mon, 24 Feb 2020 21:08:34 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:33 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 0/6] driver core: Improve and cleanup driver_deferred_probe_check_state()
Date:   Tue, 25 Feb 2020 05:08:22 +0000
Message-Id: <20200225050828.56458-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series goal is to improve and cleanup the
driver_deferred_probe_check_state() code in the driver core.

This series is useful for being able to support modules
dependencies which may be loaded by userland, far after
late_initcall is done. For instance, this series allows us to
successfully use various clk drivers as modules on the db845c
board. And without it, those drivers have to be statically built
in to work.

Since I first sent out this patch, Saravana suggested an
alternative approach which also works for our needs, and is a
bit simpler:
 https://lore.kernel.org/lkml/20200220055250.196456-1-saravanak@google.com/T/#u

However, while that patch provides the functionality we need,
I still suspect the driver_deferred_probe_check_state() code
could benefit from the cleanup in this patch, as the existing
logic is somewhat muddy.

New in v5:
* Reworked the driver_deferred_probe_check_state() logic as
  suggested by Saravana to tie the initcall_done checking with
  modules being enabled.
* Cleanup some comment wording as suggested by Rafael
* Try to slightly simplify the regulator logic as suggested by
  Bjorn

Thanks so much to Bjorn, Saravana and Rafael for their reviews
and suggestions! Additional review and feedback is always greatly
appreciated!

thanks
-john

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org

John Stultz (6):
  driver core: Fix driver_deferred_probe_check_state() logic
  driver core: Set deferred_probe_timeout to a longer default if
    CONFIG_MODULES is set
  pinctrl: Remove use of driver_deferred_probe_check_state_continue()
  driver core: Remove driver_deferred_probe_check_state_continue()
  driver core: Rename deferred_probe_timeout and make it global
  regulator: Use driver_deferred_probe_timeout for
    regulator_init_complete_work

 drivers/base/dd.c             | 82 +++++++++++++----------------------
 drivers/pinctrl/devicetree.c  |  9 ++--
 drivers/regulator/core.c      | 25 ++++++-----
 include/linux/device/driver.h |  2 +-
 4 files changed, 49 insertions(+), 69 deletions(-)

-- 
2.17.1

