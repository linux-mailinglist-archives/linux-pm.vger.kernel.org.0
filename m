Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB5539DCD
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350138AbiFAHHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 03:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350136AbiFAHHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 03:07:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38A691581
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 00:07:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a252e46000000b0065d5168f3f0so691745ybn.21
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ieoVojKSMClytLuQ+M5eO4VEou/nUlDXxOmFZvVOEG4=;
        b=o1NgvjMPh9PX/sOxZuAomHF5SvSarttRyUSV3kNkszadpGlu1uv6IEIjpGGDSAjniU
         E+y2y2wqIU4315xblR8C6Asgjg6o+j6pIfl3cWTp5f6IIF8NSWAIG/pQjRNIrVGQWK7u
         bzAAetgfksHssMKIVk0hlZADR3xdCXjBT8vitK2WoFnP2URYF0j2EP1rZoglOShrtvyc
         qAmvvhmnvASj9V9HiH5wLl89R+mdMxkBbulwCtyo+WdMxZ3Z/DsCo3A3fxYxfN42mW3a
         VAxw0DcJTPmpGr9QH/1qpkX+NneJ0635SNXlJEe3vHn5G8/WiRW8ZSO9HaJRlXugDi6q
         shTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ieoVojKSMClytLuQ+M5eO4VEou/nUlDXxOmFZvVOEG4=;
        b=FaP1tVnws7EK1tkX3lPs6Unfdo53n9BeQ+He/ALZA5aMwIOyxnAfkOfxFmOGqdLB0c
         SmHsr+D4xHKyIxogJfxC2xXAnm+EZltDnGtL7jx5dMZdDidkiNbqK/P7rrl5OTWRluOr
         hC/H5EetXcaW/r4thDSc876Vfk31lA7it5PumAYxzqG/rtjR1vFXQTX5F7azLX3g1b3X
         dnB4ti9ytl6hcZM5CDhdT3wyh4aSJXkDWPjrkYeszJwPQsWf87SHwWcr6NigtYseCeF0
         t2HqhRSjbvT/W46enxIsJwJ2XqvSDUNZ4lkdwnDNjlnZev0eY+6bI/HruN61OwWvuJTH
         XyDA==
X-Gm-Message-State: AOAM5310pETmCWHj6PygE6I6oM3iTe8rRmNG7gnwQsCSiKx0rPPMDrvQ
        6/ib0ECWQIaKTRuKe/PXeollBCdlO26epm4=
X-Google-Smtp-Source: ABdhPJwf9glz1eZgtG02b9iYSiXC0SdBQLNg/Oicnn+CPlVJJtTU1MQH2shYhTd2HU+NOooR1foe3NkSdi1e0Oo=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a25:c884:0:b0:655:f0bf:9da4 with SMTP id
 y126-20020a25c884000000b00655f0bf9da4mr34185430ybf.468.1654067255211; Wed, 01
 Jun 2022 00:07:35 -0700 (PDT)
Date:   Wed,  1 Jun 2022 00:07:04 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-9-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 8/9] iommu/of: Delete usage of driver_deferred_probe_check_state()
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

Now that fw_devlink=on and fw_devlink.strict=1 by default and fw_devlink
supports iommu DT properties, the execution will never get to the point
where driver_deferred_probe_check_state() is called before the supplier
has probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5696314ae69e..41f4eb005219 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -40,7 +40,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return driver_deferred_probe_check_state(dev);
+		return -ENODEV;
 
 	if (!try_module_get(ops->owner))
 		return -ENODEV;
-- 
2.36.1.255.ge46751e96f-goog

