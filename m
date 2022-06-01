Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0677C539DD4
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350152AbiFAHHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 03:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350110AbiFAHHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 03:07:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D278CCC8
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 00:07:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30974094b5cso8176157b3.20
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eS/2TM+GfDlfIh94cuHfgXIohxcqeVLl/51vayxOGcM=;
        b=nEbS5SUQKPV2uEuRcyqOCeYxkIcVm6QtbRuafH1IWgffM/UiSk4n7jieCoUxjX9Oaq
         WdF2MZAjtTV+A+oRtPcrP2vyYILJP7A+Sg3USDA4WMYh1mFqe4FUjmEsa0guT0E1V4tj
         CRvpIOw9ggRCgKvj+BCr2MskAML9dPYYf+XO0/d9/Xj9Uc/+LTk7YMR8wiug+nW8uluL
         vowkrv4PAa7gy873wiXvd7t6in/QuT1Qpd5KLLyCXllUZoQDqvWM1KUKzksMRYWJwumF
         +1QzKxLzBi0hg9GJrGLwC8SMCfssBQpKzUmvRevuplmTStk4Ali/UF0v2Vw1hH1Gn3Yl
         JBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eS/2TM+GfDlfIh94cuHfgXIohxcqeVLl/51vayxOGcM=;
        b=Y6C9jQ9+CNT/mUo8IY/NrV3GatrN2srHo2G2P6Ecz9uZlwDV1+0ZDgRZrj8/KM4dUw
         87t9irNGBUTDcfJtiopTqfBz7LLPPdzvYqiKUFdrL+2I/TTMLdEYXZEpjJfS4xs2UlSR
         H4z3ZqF5z09cVDmUAdLWkJtfTDG7EqcCBsPbxO/Dw16POFLcn68OWbtXNkWDinC/eXaC
         kPzVASVwMD/mfDij1TrZJ5sig5OWlWvvn42JjgLO0vMt1bDYBh7PsOQg+NE9gY14UT2K
         zZRVWFQfulNgmzSTUcBTnIUInutBBTXddljdbzypeTRCruJbJ9oqfpA2wqB4yw+xaKED
         cyrg==
X-Gm-Message-State: AOAM533Ld6BlQdfmCLEU2n5okOuWKQ78vut6nzzcG+sFlFwHFrdQUtJG
        UoyRR4hW6qBlQlv5R31BJtBB25t96K7C/lc=
X-Google-Smtp-Source: ABdhPJwtAnnXhJAd8leQI7IsJQYpPEGmerba49yF9GJ2QPuTWzcc40IB9+ccBefvJrVmInskP9rGOF8g1cQWJjY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a81:ac67:0:b0:30c:4692:77fd with SMTP id
 z39-20020a81ac67000000b0030c469277fdmr16106442ywj.180.1654067249191; Wed, 01
 Jun 2022 00:07:29 -0700 (PDT)
Date:   Wed,  1 Jun 2022 00:07:02 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-7-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 6/9] Revert "driver core: Set default deferred_probe_timeout
 back to 0."
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61.

Let's take another shot at getting deferred_probe_timeout=10 to work.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 4a55fbb7e0da..335e71d3a618 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -256,7 +256,12 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+int driver_deferred_probe_timeout = 10;
+#else
 int driver_deferred_probe_timeout;
+#endif
+
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 
 static int __init deferred_probe_timeout_setup(char *str)
-- 
2.36.1.255.ge46751e96f-goog

