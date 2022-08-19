Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4759A867
	for <lists+linux-pm@lfdr.de>; Sat, 20 Aug 2022 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiHSWRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Aug 2022 18:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiHSWQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2022 18:16:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD640F2424
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2022 15:16:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334d894afd8so97428297b3.19
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2022 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=H3YEiHHCZDHfvJiU4fCYVtnbVB8iHyjPM7ELjaj28Ew=;
        b=X1U73b0XniNLU7Z952Uoe4oLLlOQuH9fMoxIo3YE8wTvISBipZU3kbSsA/PpZc74b9
         GKGrN3RRsS65zQ/iiGgHDkFgLoHu+HT15JxvGOx9hJ2PV56mfIi6fXTua6T4tCzBZCDs
         pidzBZcxXFnAUE6H041z//D5yM40NWB78f6EufBqHmtQf2Fy2jYoy7SMHxtXqD8J18Jl
         tglJU4xpK/iRl2mW5tY+0pgOj4nH9Bx5lesRwnijThCj0o6tZ7h84PrI8aDfHNjuuotw
         33+iubcVMVmM0KnScNcfs0uK//EhpI5sVYu65TPan5KCq2k7mlKkYFPNxSojzIFEnPuE
         wSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=H3YEiHHCZDHfvJiU4fCYVtnbVB8iHyjPM7ELjaj28Ew=;
        b=7sJgwYK6TFVRyx50FBhzEETqUXmTaBjCvJn9r6DjfQD/rTnAe03K7iK5S00WjRMuIX
         LAyVIQd46RRZEOv7y1dhnkClCMbhSHNXBt5AZtgL33gigvWWaHGCZMsxiFEoyvYYlWR1
         DTQ96OAcB33mjAvOymgeUgjQXh2wrkmOlWavbOjx5JSEZSONejrS92KTMrt+bokbOTgL
         CeR707IPAF1liqk6WPfTMcGtVrckHlFrN1jaqKtP/qOe2zpznhwZ89+8cxj9PPfjEOr3
         +lkMTFzuKHN+KZSYrcBK85kludT/o35XkbD9oLeUhU8L2KwCqko2z4AV4kN13PAfGfkR
         F/yQ==
X-Gm-Message-State: ACgBeo09/7zKZS4epSOsE3z74nuhPrMkedj4/MysYMUohr5UMIYBRKG+
        BO2cjLOC7jtxY/wSD2eNkY6tkbCfvwElsMI=
X-Google-Smtp-Source: AA6agR6s7O9ks9P+6MMRLsKupYiohHddIyehPE2rdJmt/AJwJ41rH2q/2hZo31rpF1++hMgFEDboETrWBMyKu5U=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f93e:7b61:ce3d:5b06])
 (user=saravanak job=sendgmr) by 2002:a81:5744:0:b0:333:7505:5bca with SMTP id
 l65-20020a815744000000b0033375055bcamr9459605ywb.315.1660947391375; Fri, 19
 Aug 2022 15:16:31 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:16:14 -0700
In-Reply-To: <20220819221616.2107893-1-saravanak@google.com>
Message-Id: <20220819221616.2107893-5-saravanak@google.com>
Mime-Version: 1.0
References: <20220819221616.2107893-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 4/4] Revert "iommu/of: Delete usage of driver_deferred_probe_check_state()"
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Luca Weiss <luca.weiss@fairphone.com>,
        Doug Anderson <dianders@chromium.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org
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

This reverts commit b09796d528bbf06e3e10a4a8f78038719da7ebc6.

An issue was reported[1] on the original commit. I'll need to address that
before I can delete the use of driver_deferred_probe_check_state().  So,
bring it back for now.

[1] - https://lore.kernel.org/lkml/4799738.LvFx2qVVIh@steina-w/

Fixes: b09796d528bb ("iommu/of: Delete usage of driver_deferred_probe_check_state()")
Reported-by: Jean-Philippe Brucker <jpb@kernel.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 41f4eb005219..5696314ae69e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -40,7 +40,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return -ENODEV;
+		return driver_deferred_probe_check_state(dev);
 
 	if (!try_module_get(ops->owner))
 		return -ENODEV;
-- 
2.37.1.595.g718a3a8f04-goog

