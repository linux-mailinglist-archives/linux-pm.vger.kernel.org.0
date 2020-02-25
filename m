Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38D716B8C0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 06:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBYFIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 00:08:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43670 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgBYFIq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 00:08:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so6266571pgb.10
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 21:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UKu1DiH1aE4gWTyQt4rVDR13BTjgcFDoUNycgrJmwbg=;
        b=Cu6ZP2ZIv35GFagdY+/LcLqaOOw+CLP2oG+i36khDGnV8jZqR9+fcfjmtSi8rmir7L
         Jx1LaoZjn8k7/5orzjhIAxTgMTS++qpZ/WATeHeqfZ4jMF2TstYXaTiMIt63Hf5rFPkU
         HLBZsZV3viwEcdZFWD4uZ3ZgmCzB54Q6z++Xu2LdT8HN4JDEUwYeMU+o2G6oG5cftukM
         y7ej0sQ3QrmZg8WvRtkxYZ4OdyjLUJTBxEIivl+4yyyqBrytgZceKBvx4/TkxTvlIbFa
         dfRZhnCHnKcjjZePiKQqRzKAcc0sYa7DHxrLEP68JvuQDo+Me44fthyCMhq4WUVHAtib
         OSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UKu1DiH1aE4gWTyQt4rVDR13BTjgcFDoUNycgrJmwbg=;
        b=tIC9WOuDGZu29FZvpgP7wRwyAB4C6pcl8xXvu8Ilx8mJ95mHQdmLTdQDUmYWgullsj
         K5G0WNdQnw1sd6zVgxHKMreKZclFgCbjuV0Gc3EKMCK4Zejx408nwL8pTAgD1P1EIBJR
         xmltRk6TmaVWAnVb4u38SQr3ZAaKq9uUEEsIoY8uHkMYChMD0H1Qxn4te+rnL+6KOFvb
         a2gXRE5ehwaLoY2Q4ULKN0p5zgxp6EV7fdkh8qz7hoEmuAjftcmCVwRnnyI1Zry5krkD
         bKImfD5fw5shO64i+L9RVKbi1m1tKGR5tIR+gm2W3RaE2dYt/A7cKLd2/gYUq3lOL3Xe
         oR+A==
X-Gm-Message-State: APjAAAXhPB7hq63xEoaWN3IchOElca5Z/yiIGybX8N5fRCeQ8vqrXzOK
        3qV+rgBFvXXNpkKzVbAa/El8hw==
X-Google-Smtp-Source: APXvYqzJ+fEVi/wIlI9WBB1N7Ce1uB1pgPc8Gi+KC1Np/LBZigKmj6Z4U+C8cgQ72ykCwoffntxxsw==
X-Received: by 2002:a62:5bc7:: with SMTP id p190mr53865844pfb.16.1582607325037;
        Mon, 24 Feb 2020 21:08:45 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:44 -0800 (PST)
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
Subject: [PATCH v5 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
Date:   Tue, 25 Feb 2020 05:08:25 +0000
Message-Id: <20200225050828.56458-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225050828.56458-1-john.stultz@linaro.org>
References: <20200225050828.56458-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the earlier sanity fixes to
driver_deferred_probe_check_state() it should be usable for the
pinctrl logic here.

So tweak the logic to use driver_deferred_probe_check_state()
instead of driver_deferred_probe_check_state_continue()

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
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/pinctrl/devicetree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 9357f7c46cf3..1ed20ac2243f 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -127,11 +127,12 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
 			of_node_put(np_pctldev);
+			ret = driver_deferred_probe_check_state(p->dev);
 			/* keep deferring if modules are enabled unless we've timed out */
-			if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
-				return driver_deferred_probe_check_state_continue(p->dev);
-
-			return driver_deferred_probe_check_state(p->dev);
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
+			    (ret == -ENODEV))
+				ret = -EPROBE_DEFER;
+			return ret;
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
-- 
2.17.1

