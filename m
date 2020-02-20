Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28C7165679
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 06:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgBTFEt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 00:04:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40133 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFEr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 00:04:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1056846plp.7
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 21:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SnxfHJcH3dJfaGTadw6bDQp2VaipWSYONj5VWzxr75M=;
        b=D82B6Jl8GzSqPhqK3gndl940M+e/p4RQ4dcJD+Il3Wl28R8uKElrD4Dcf4Ln1l1Jj5
         tgh4qBdLTgNeP6q4cgXK6W6AhqUQi5QFV8P2OqsSgenyi8Tk4QT4WgYo7mtQw7N8aNLg
         5IqJv+0BdKWBZYJVeHo0JB0frJE6SebarcgYR9A6H5TVZA49g825fAsaFUvcZFJT/c3/
         f3Yq1QKFehUNcF3+V/5l2+HY7OnSBCA4BbsnEPxSTNDHNZToNb0eyW0f+hXSTpD0FHuJ
         82BJBfgIfCF+UjlMuJyXcn2S3KLONmzUqYAbmPrihKNm2IDZnZ1qJcwx73ZNGClIuKCx
         QKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SnxfHJcH3dJfaGTadw6bDQp2VaipWSYONj5VWzxr75M=;
        b=PS5KMNHsdTSDODLagkbaz7GYPZXmbugvfUx/6zzjI9nwl4/VTv1Dd2TmxQHssA2k6E
         WKxYanitPwGKdA9wA+mIh599f4J8yOOYNjAztucyvtUtpsyvtr/DRgTeLrZNRNQxouvo
         Jn/moMcAlxzwSFGKDAnrlzY54oyLxDNRSkIJHPes0TfNPxG431YCEQsAbb3VWqFfv96T
         6fSt0zv4f/DNU4HBWTmlbU9okKZ1p4sGFzWVrIBgfCpLYSpOjsGaFgmXN+KEFm+tqB2s
         v+DKG8crvS/2fWblwLEXhUkjKi6FI1XhipAxWp/vtomqTw0xIC9Ctw8eXhIqeq1s46x+
         wVAQ==
X-Gm-Message-State: APjAAAXHTTRtLjFk13ObFHkNhKqvQ8XMZxaKRTnAP8/D1puFdZUhttmk
        ZQ3WW6nKUhgZBh6FjLvL3bq09A==
X-Google-Smtp-Source: APXvYqzLkWrpUiPoCfJrHFXtM/ZLRzMES/WG77gcztnA8Jv+vkT8aXnXJVoRLKX27cVA5hi5qJHsWA==
X-Received: by 2002:a17:90a:9311:: with SMTP id p17mr1466208pjo.140.1582175085036;
        Wed, 19 Feb 2020 21:04:45 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id z4sm1400847pfn.42.2020.02.19.21.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:04:44 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 0/6] driver core: Try to improve and cleanup driver_deferred_probe_check_state()
Date:   Thu, 20 Feb 2020 05:04:34 +0000
Message-Id: <20200220050440.45878-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series tries to improve and cleanup the
driver_deferred_probe_check_state() code in the driver core.

This is most important for being able to support modules
dependencies which may be loaded by userland, far after
late_initcall is done. For instance, this series allows
us to use successfully various clk drivers as modules on
the db845c board. And without it, those drivers have to
be statically built in to work.

The first patch (or two) is really the most critical for me,
but as I was working to understand the code (and with some
prodding), it seemed a further cleanup was in order.

If folks have concerns about the tail end of the patch set, I'm
fine to defer that. The main issue for me is the inability to
load module dependencies after init starts. 

New in v4:
* Split earlier version of the patches apart
* Defaulting deferred_probe_timeout to 30 seconds if modules
  are enabled.
* Deeper cleanup on driver_deferred_probe_check_state_continue()

Feedback would be greatly appreciated!

thanks
-john

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
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

 drivers/base/dd.c             | 78 ++++++++++++-----------------------
 drivers/pinctrl/devicetree.c  |  9 ++--
 drivers/regulator/core.c      | 25 ++++++-----
 include/linux/device/driver.h |  2 +-
 4 files changed, 47 insertions(+), 67 deletions(-)

-- 
2.17.1

