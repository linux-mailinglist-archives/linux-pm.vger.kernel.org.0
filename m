Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1421539DC1
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbiFAHHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350003AbiFAHHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 03:07:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D464A8CB1F
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 00:07:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3077947cbb8so8476927b3.8
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dQEtI1CAczIBuvDz3GZ7U2zzA60s6PfFxMj/9gjiRQI=;
        b=dR7RpwH0OGQgdq5IkjUp0wI+kkXSRbNo+z8wKuVYmhF5jBwh9y6txlMuL3p9oOu2kZ
         wPPBUSqq/aYBuqa517o9bAD77BHGWgYWs4stcLD/c5P5I4GNJdZuDvwIt+YBFb31fdLB
         6zUXWtjdhyChYQDoJ2zR1S2tqwWpzQnMhQv0CP3yR6ExhViYXE39N0bMEhjNOlxU33zZ
         EdAp5EoXLEUNyiLkQ+0mYMQCtOLO1Y/nznitQm8gq3O56AfLSY2rXnJOF6aeB3s/9Rue
         1UCDaLkk9f2RRDPnMVqUDjfwwIppZ6DCFLXO7D9pTdLF04gvr1TYoFoAEKDgJaikerxa
         Zw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dQEtI1CAczIBuvDz3GZ7U2zzA60s6PfFxMj/9gjiRQI=;
        b=MPuva/lOjLDbHwKYk1AnqC5z+rz2wYFdEQjY4Wt28REN857Q5+1oyxDGuKQ0Acc5lH
         jI5FLVTRchX3BbFh+1eKR3puGBca1QIirw/A1xx0++WA8d74LCX1u3Xyb2yDmXwKLpIE
         ewuo857ZdX4Hv8KdG5mscPdf/z1/7SK1ngPe9wqQxNMT/qH9cnKaOX6xVo63bXj0WZ/9
         F5pmoThiA2bWRLvCWtgZCh/KJWv82OwzzoSfKhDUCRytDOZkBdHBsrFlWJvPA+QlDOTg
         oyZikb6fXWmI7HbZlIkJebDCPdUWyJnMFkBuvM43gsyzLtazHG7Vvj81lkS1MobyPp9i
         C+xQ==
X-Gm-Message-State: AOAM533/nU0rBt298MlYXEZ9JzYJ/pbObZrHPP9SXsiaPB9bMVp5ztuL
        UgqxOKklmDphZkNyZdTTV9x5H7AHkCTMa6k=
X-Google-Smtp-Source: ABdhPJzjzqJGs64NvAdSlO/KVC/8uBUgQ7KmMn/05KCKbRpPaPfy2ffCOi3FUKYkp1MN38cKmElXlMfsooa1FsE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a0d:cc89:0:b0:30b:14ee:6329 with SMTP id
 o131-20020a0dcc89000000b0030b14ee6329mr25787073ywd.38.1654067246121; Wed, 01
 Jun 2022 00:07:26 -0700 (PDT)
Date:   Wed,  1 Jun 2022 00:07:01 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-6-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 5/9] net: ipconfig: Relax fw_devlink if we need to mount a
 network rootfs
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

If there are network devices that could probe without some of their
suppliers probing and those network devices are needed to mount a
network rootfs, then fw_devlink=on might break that usecase by blocking
the network devices from probing by the time IP auto config starts.

So, if no network devices are available when IP auto config is enabled
and we have a network rootfs, make sure fw_devlink doesn't block the
probing of any device that has a driver and then retry finding a network
device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 net/ipv4/ipconfig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 9d41d5d5cd1e..2342debd7066 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1434,6 +1434,7 @@ __be32 __init root_nfs_parse_addr(char *name)
 static int __init wait_for_devices(void)
 {
 	int i;
+	bool try_init_devs = true;
 
 	for (i = 0; i < DEVICE_WAIT_MAX; i++) {
 		struct net_device *dev;
@@ -1452,6 +1453,11 @@ static int __init wait_for_devices(void)
 		rtnl_unlock();
 		if (found)
 			return 0;
+		if (try_init_devs &&
+		    (ROOT_DEV == Root_NFS || ROOT_DEV == Root_CIFS)) {
+			try_init_devs = false;
+			wait_for_init_devices_probe();
+		}
 		ssleep(1);
 	}
 	return -ENODEV;
-- 
2.36.1.255.ge46751e96f-goog

