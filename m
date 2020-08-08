Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE223F675
	for <lists+linux-pm@lfdr.de>; Sat,  8 Aug 2020 06:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgHHEfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Aug 2020 00:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgHHEfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Aug 2020 00:35:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D01C061756
        for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2020 21:35:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so2210431pfw.9
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2020 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FLH00sdB350zJ9xfj23oogVpb2S3tQu3JW6EcRNgLew=;
        b=jxsmsVrPMXk3ia55RuurLWnSF4l/zKLQ3vl9KAAZyocpecHvuHBmvqNZ3/XplYR3Gu
         n64wEa8PfUTVNoNBErV1lJqro5vuj1nM156YV6puxX0VwIGA00GjYcltZ/n0CHtTmuzl
         K2dCPiCPxd74wNDhXQLkKGBo2IVHvYaeYFNG01vgjfXIz8zc4ApEPfoR14VwkWPo/3jX
         gsEkm2oobSufzAL5Borf0uY3W1ZJuoPEjN+7yEoaVyebCPQbU6AoPggfRtKb3JqQ42/A
         JwqVVpbzfnkJNscvxEW48HhBsrwYsNzeGeVgzqGq0KhbSns0HdL3r9jTSBsMGRJ+8XlJ
         8GKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FLH00sdB350zJ9xfj23oogVpb2S3tQu3JW6EcRNgLew=;
        b=jy3SgdKyX52TW15EZgAMyQbBqVNqJcisJachSE2bbeesdOcOtemrRN6jZoaoBHBFPm
         E1miBEMUtYsNaKrADHTKj9LeEXtBdu/dY9Uvv5JmJCylS5oeiw2JZbJSVvpdMip6m5cc
         iSuFTRBnYmbJGY+5CYblFciGAEa89bZvxWsKt1VCF5yqSoe+TOIu17VcyTkyAd0r9HIz
         TYSgyBgAtCmxYsGKO1ei/GbviKq6EzvkP1aFR/H5z/ByrJgc7WxUefixjCJ/cjG7dUk5
         X278gBb5aRIYiKkfpuGN0aXvJx+MLvq3DNhwa68ijJaGRQUK0+eNKPXUce7OTiGLhgAE
         HZkw==
X-Gm-Message-State: AOAM530mv4L5cOPKA6f3YA2KsJfmZWa5p/iOJY9iSab5J2OGer0h5uL/
        dJNCE03RYYnVh+khm+BZt7avCg==
X-Google-Smtp-Source: ABdhPJwNTHQJhOGti3fSdIgHT3N5Ze4RXdBPrXTV4+YSlALH9wv8HLqMwbWjlTEZZ6jWzuIuQz6l9Q==
X-Received: by 2002:a63:485f:: with SMTP id x31mr14308176pgk.49.1596861315980;
        Fri, 07 Aug 2020 21:35:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id u24sm14607963pfm.211.2020.08.07.21.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 21:35:15 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>
Subject: [RFC][PATCH] pinctrl: Rework driver_deferred_probe_check_state() evaluation since default timeout has changed
Date:   Sat,  8 Aug 2020 04:35:12 +0000
Message-Id: <20200808043512.106865-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In commit bec6c0ecb243 ("pinctrl: Remove use of
driver_deferred_probe_check_state_continue()"), we removed the
use of driver_deferred_probe_check_state_continue() which
effectively never returned -ETIMED_OUT, with the
driver_deferred_probe_check_state() function that had been
reworked to properly return ETIMED_OUT when the deferred probe
timeout expired. Along with that change, we set the default
timeout to 30 seconds.

However, since moving the timeout to 30 seconds caused some
issues for some users with optional dt links, we set the
default timeout back to zero - see commit ce68929f07de ("driver
core: Revert default driver_deferred_probe_timeout value to 0")

This in essence changed the behavior of the pinctrl's usage
of driver_deferred_probe_check_state(), as it now would return
ETIMED_OUT by default. Thierry reported this caused problems with
resume on tegra platforms.

Thus this patch tweaks the pinctrl logic so that it behaves as
before. If modules are enabled, we'll only return EPROBE_DEFERRED
while we're missing drivers linked in the DT.

Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
Fixes: ce68929f07de ("driver core: Revert default driver_deferred_probe_timeout value to 0")
Reported-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/pinctrl/devicetree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index c6fe7d64c913..09ddf567ccb4 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -129,9 +129,8 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
 			of_node_put(np_pctldev);
 			ret = driver_deferred_probe_check_state(p->dev);
-			/* keep deferring if modules are enabled unless we've timed out */
-			if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
-			    (ret == -ENODEV))
+			/* keep deferring if modules are enabled */
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
 				ret = -EPROBE_DEFER;
 			return ret;
 		}
-- 
2.17.1

