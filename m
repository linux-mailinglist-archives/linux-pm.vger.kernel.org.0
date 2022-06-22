Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C64556E2D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jun 2022 00:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357031AbiFVV7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jun 2022 17:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbiFVV7f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2022 17:59:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2681918356
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2022 14:59:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e85-20020a25e758000000b00668ad2fcfdcso14920215ybh.8
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2022 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ah2iRj02YiwPhgw+fxQ8yR+iMVe2r8+mhYVV0rIvZow=;
        b=i3p4bjKEtbMXzQEuzp8oUcL2dOBUx5t3ouIxH3WFaHxtQBesxVZ95zRpRsbv0rotKc
         DCfLguFUFd9z7qjx0Dt8NAVaz0jRnB1K5Fh9Yi5/ZA7DG9FgX6RK9DwoMGuX/btXSeNY
         jRizfq/806YnP4p7qCTtBJ9GK0YOoKEvQNuF2KL6ayR3OaHneYEgbFUH1cZ3RoYx5Y7f
         2KbJ9cRY3K9bypygWX7MY4tpexszDMtIlE99YgGPEudPytCeem3ndf6dqYBx6cC19AlU
         1k9DIcVe8I+qgmnTG95ADMGi1utSftyTTlGvgR8EUYa2yoeI/p7XaS4EVakP4MZtD+7U
         xgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ah2iRj02YiwPhgw+fxQ8yR+iMVe2r8+mhYVV0rIvZow=;
        b=MJqfkElxNUMSfBpSxqBgfo3pAeeMcEXUScd40dJ7pUCGCC9qRztPKGR9HjHikByFYP
         mwrgxTdZKbfSwTyEtlpId5vZJI3uDTvYjBurjxeDV8dhUp+OWQaRlqqYS5eerU1xYIx3
         ZXyDDrCgHnko3pkOLHshHs1dlfnjjlIrJymIvTrrrW6bx3dx8nHlFMbgCUgDhz7qo0Wb
         O4VVyLO+Hss2o2SXfst8eXU5/QoeSp7rYS3r2DMfv5tmZBDm+lkAzJxNjAF6Y9RVWJ+k
         IGY/DTUMZ5BAu2WLP2jhvnv7/r7r8TXH20eEFXGkpVt8Z/trU/Qtr87X0IUO4xYfjbHK
         EFVw==
X-Gm-Message-State: AJIora+BICANx8xukpPbjGJlvzDO/LVnPPUyY0wA0F9ONB2YvKSrNkeD
        X9E5iFkcRcUCrqka0rU1xdolKFLak5461TE=
X-Google-Smtp-Source: AGRyM1serWNuSMZl/j+NqgnonDe+81gNNUGvZ49e005IqIx08CvB3Gw4PJWEQaMJYGKoe5Xwjqr9aD6KRs6btJ0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:be1f:89ac:a37d:6bb4])
 (user=saravanak job=sendgmr) by 2002:a25:6a46:0:b0:669:1da2:ba1d with SMTP id
 f67-20020a256a46000000b006691da2ba1dmr5894467ybc.163.1655935163161; Wed, 22
 Jun 2022 14:59:23 -0700 (PDT)
Date:   Wed, 22 Jun 2022 14:59:11 -0700
In-Reply-To: <20220622215912.550419-1-saravanak@google.com>
Message-Id: <20220622215912.550419-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220622215912.550419-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v1 2/2] of: base: Avoid console probe delay when fw_devlink.strict=1
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Sascha Hauer <sha@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
enabled iommus and dmas dependency enforcement by default. On some
systems, this caused the console device's probe to get delayed until the
deferred_probe_timeout expires.

We need consoles to work as soon as possible, so mark the console device
node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
the probe of the console device for suppliers without drivers. The
driver can then make the decision on where it can probe without those
suppliers or defer its probe.

Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
Reported-by: Sascha Hauer <sha@pengutronix.de>
Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4f98c8469ed..a19cd0c73644 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			of_property_read_string(of_aliases, "stdout", &name);
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
+		if (of_stdout)
+			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
 	}
 
 	if (!of_aliases)
-- 
2.37.0.rc0.161.g10f37bed90-goog

