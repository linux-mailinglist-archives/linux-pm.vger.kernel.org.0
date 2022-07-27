Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB3583313
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiG0TJt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiG0TJR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 15:09:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7DD6AA2C
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 11:50:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s6-20020a25c206000000b0066ebb148de6so14008196ybf.15
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0gBJh1/DX5M6n5W65xmbWPerC4xN3qFPSKf5chwOdiw=;
        b=bg8ph5OtD7AxG1zxeIOzd4c3YvuKJJwgTI0Hgqzl0BLzrOKqjOjkJROWso5PVvlwaw
         SKFanteSKc7afiyOqABcwFH+hyZFpEQAOqasHcqh2f7L+Bdn+8xIYU+sBCOKIrfuO6vp
         FADBwkrq/HXNQGrAFEpCfdTvNxN8H4jPOptrzVphWdjRaTQHxjniaTf7OmRYFPnKFrO/
         zUbzV2HK8KGT3gR4BAIFqQtcSk3OB5PIqZkQQLX3UNakY3l4kaXGHklmrW+5TWobbdBt
         SQhKYvoAqOFXhYx6Xbyj2YbePvXd9wsyZwbIquWXadlDeNtWsPMCAFj+S5VHWE/2enUi
         JMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0gBJh1/DX5M6n5W65xmbWPerC4xN3qFPSKf5chwOdiw=;
        b=X/+NSttWoGSpHs6rXflH1CpjYcRw1M8G7efEgtXFx+gcdcxCDoDJI1O6UsX7vCRbbK
         CBqUDFgUNaDA3d1NP+vjVOU+s323naQXOwq/qKF3QGQR2ZlaSJXyaiwKtPSzUm0oFQ/C
         YIgnVDdA/2TmMrXfFW6HugMVy6UZQYBMrcmZYeYEAGsjkAZEacCzhH9zmqgl0ZlNafcj
         reH14v4jd5NZHBJZLVYTQE1Ryi5HriedcXXNG+dTMobomrkU81PAeowD3O1Lo0YR6xvg
         xNIurtW4aDbfB192ohomc2xfdrALuPamHjvQXjNe/pX4c0tcM691p55gTKtcfd13M1K/
         qKmw==
X-Gm-Message-State: AJIora+2t9EawTedcEV0iKDBKQ2GPtofKaeQy8jQCdLGwDlyjOhlIYts
        ngTTR1TbZEP+qRD9CldXBbe8nOqipKZzQc0=
X-Google-Smtp-Source: AGRyM1vw9acn4WN7zKTrz4jHGTc3N/jAqDblTKq2t1lpN8G1rUtuPz0iWs9j4VcBcTn0CpXqkKAHxpdMjKm+bSs=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:40ee:bae0:a4fd:c75b])
 (user=saravanak job=sendgmr) by 2002:a81:54c5:0:b0:31c:7731:e1ac with SMTP id
 i188-20020a8154c5000000b0031c7731e1acmr20280110ywb.190.1658947823995; Wed, 27
 Jul 2022 11:50:23 -0700 (PDT)
Date:   Wed, 27 Jul 2022 11:50:10 -0700
In-Reply-To: <20220727185012.3255200-1-saravanak@google.com>
Message-Id: <20220727185012.3255200-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220727185012.3255200-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 2/3] Revert "net: mdio: Delete usage of driver_deferred_probe_check_state()"
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Saravana Kannan <saravanak@google.com>, naresh.kamboju@linaro.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit f8217275b57aa48d98cc42051c2aac34152718d6.

There are a few more issues to fix that have been reported in the thread
for the original series [1]. We'll need to fix those before this will
work. So, revert it for now.

[1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/net/mdio/fwnode_mdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 3e79c2c51929..1c1584fca632 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -47,7 +47,9 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 	 * just fall back to poll mode
 	 */
 	if (rc == -EPROBE_DEFER)
-		rc = -ENODEV;
+		rc = driver_deferred_probe_check_state(&phy->mdio.dev);
+	if (rc == -EPROBE_DEFER)
+		return rc;
 
 	if (rc > 0) {
 		phy->irq = rc;
-- 
2.37.1.359.gd136c6c3e2-goog

