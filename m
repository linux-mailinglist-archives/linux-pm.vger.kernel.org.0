Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9046F539DB1
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiFAHHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 03:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiFAHHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 03:07:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7A636D
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 00:07:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc7bdd666fso8452587b3.7
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 00:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Eq6nH6aGeuKpMU9nM7ibONmheABIDjQM7t9UjsNcl+w=;
        b=dvfs6aw0o9enYr6q5JvsoITL1cIodQJtPwQKFVNV/ElWQiITwvlgBGIYVXYubJ0EWb
         hQZknjUn8hWhfVG63Q26ahXT/ybuECTh3IQ0hlFzpMrRfffJaSxehOVATgqcGdOl5B63
         UAGusDHfZ1+bZx3UPXTCMA74yfTvat1qBDbQNIwN2gBcEL0s2lgJJxBkvLKW4seHwHfy
         yy/kVDyKrdiePicpV782RiPioPYMYI6dNrIPSqSRQjnVUQlBHfFoZNPq2vXgAhQA5tJ2
         qPRfgtRDz89n2glwq1xvIPHXD3I9kan+rQBxaKWDF0fkq11SsjvYI3DlubXtUCtJ5N2t
         udoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Eq6nH6aGeuKpMU9nM7ibONmheABIDjQM7t9UjsNcl+w=;
        b=kOvOsx6RJXSav56UaFoXzuKd6GHtsmNvQtT/VSLlclfW6SphmcRIRcdm0Ji4isjntG
         nlRtYEuuAApHbIbG5rqzkfM8t+Wyh2S8YPh/bU1t0MikjZxww7ZC1sg2hOtOJgl89GLJ
         tc+JouQay5JgpBVzyRs+CEC+Tvbhs9DyWzwPucYTEB/xMvVDJz1jvRvCFf20nXZ/Km++
         +tq4ZTvighc7mZpJYgvruBKJ1RLgyJSE0EWJGdGVP8oFfIUWs2m6OeM48FK5xg7CY1ww
         28C1OhM4u41htxDYd9M+gbTnVKEIuXfgVVXjV+YtDAexd+EnBXxsqpr+Qvjab45y8hYN
         A8Lw==
X-Gm-Message-State: AOAM533sxrTVG1iPoT7D4i/R45fG8c58x1eImtheeZxEJX5ObQUQXjDy
        bPmro1bXKvhAWMLzddO1WkPHalIjUafbucQ=
X-Google-Smtp-Source: ABdhPJyEEJmzYE3LJbKEPxep9Txd8IS2Y3Ohb4w4RDlkBWekTGGi+00/Yu83BjSHoAA0YZYV1qdNB+xcoJAZ8NA=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a25:2e06:0:b0:65c:ed2e:31bd with SMTP id
 u6-20020a252e06000000b0065ced2e31bdmr13135711ybu.244.1654067234572; Wed, 01
 Jun 2022 00:07:14 -0700 (PDT)
Date:   Wed,  1 Jun 2022 00:06:57 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 1/9] PM: domains: Delete usage of driver_deferred_probe_check_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        David Ahern <dsahern@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that fw_devlink=on by default and fw_devlink supports
"power-domains" property, the execution will never get to the point
where driver_deferred_probe_check_state() is called before the supplier
has probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 739e52cd4aba..3e86772d5fac 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return driver_deferred_probe_check_state(base_dev);
+		return -ENODEV;
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-- 
2.36.1.255.ge46751e96f-goog

