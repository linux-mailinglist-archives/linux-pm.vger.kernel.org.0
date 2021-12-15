Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4410F475161
	for <lists+linux-pm@lfdr.de>; Wed, 15 Dec 2021 04:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbhLODeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 22:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbhLODeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Dec 2021 22:34:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48253C061574
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 19:34:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so40795150ybf.23
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 19:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ARpa6zPvm9PZGcuhaMPlpvBKRkuGs23E2qbxbopfbZE=;
        b=cD7zqW/uhDSXO2Nvu7hF4M4ZCQ+IZlr4WKfzaMzQAQ0HauisDbgGyIMJvbhqHoNy2M
         k1O1qZ4ekUKYH7GCtzu4bGShA5ts7vp4DINljmL07BY8GcAhlf++L5PQrAeycm8b7vi4
         gXv6+ujAL/qiEX7y/8V6caD1VYkj5nGXrtKGtxY+Z3U7tP+wOSJjn/8HLhAJMzijUzpH
         C9OV6IVwbg9LYCA2dTMe3bUQDwx3twhncsOoafKLfNnKbcNqqalS63+fGzg6rpKirG+i
         W5zZ2b+xjErbYwStSpNEZFW8KVH8dYWUutYZ3HvOG7BbqNn9Dy1arTOwwgXEIlDDr+30
         elvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ARpa6zPvm9PZGcuhaMPlpvBKRkuGs23E2qbxbopfbZE=;
        b=0RvOz3pOK7ft9COc2Rh3KC/8ndGK83E1wn8SSmVliShvzhCHttTmD2VudoJfm/HK10
         q0fOyytQjq82BjL+BYTI/mbMOfvGFnzO6Ui7hasmFFmY2FstWQv74YNx1c8d0Hs/HVWN
         8ztIiv8td9cK+1rC4gO40NPImIMpgnDI0pVbsH/M8TEVOZp5037vNHZC8V25MrAORQRa
         7dAJEZGpT57sy1yQfe7ecbreJH0m1exZ/wtjcU7zC8ONbiSEec8qnlquvGzxfNWFzD+f
         japNLmFZUPqrX5+OJVbdntSEVYNoGK9NCqZxsLJYvNcZriOxteK4+2wLD46cAw6mxkoz
         H2LA==
X-Gm-Message-State: AOAM530HTnZixHix+D1F7ZidIPh/nmtLjREE2YGtGurZ1Wl7+bcylGSy
        j1ygiojXpIfojgJwkcyL3rUBUPUE3Q==
X-Google-Smtp-Source: ABdhPJzO+va1HWEj1DgUKogGq+1rR3ip80sY+XSKJpkRBrs1Qp6FvQ3F6YN1z/bE9PsmqI4i9tPj4kMrFw==
X-Received: from wjack.tao.corp.google.com ([2401:fa00:fd:203:c9e1:5895:c4b3:f8aa])
 (user=wjack job=sendgmr) by 2002:a25:df4f:: with SMTP id w76mr3714297ybg.711.1639539259512;
 Tue, 14 Dec 2021 19:34:19 -0800 (PST)
Date:   Wed, 15 Dec 2021 11:34:09 +0800
Message-Id: <20211215033410.4113857-1-wjack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v1] power: supply: add dock type
From:   Jack Wu <wjack@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jack Wu <wjack@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dock power_supply_type for the drivers which supports dock can
register a power supply class device with POWER_SUPPLY_TYPE_DOCK.

Signed-off-by: Jack Wu <wjack@google.com>
---
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..53494b56bbb4 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] = {
 	[POWER_SUPPLY_TYPE_USB_PD_DRP]		= "USB_PD_DRP",
 	[POWER_SUPPLY_TYPE_APPLE_BRICK_ID]	= "BrickID",
 	[POWER_SUPPLY_TYPE_WIRELESS]		= "Wireless",
+	[POWER_SUPPLY_TYPE_DOCK]		= "Dock",
 };
 
 static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..fa80eaa54242 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -187,6 +187,7 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 	POWER_SUPPLY_TYPE_WIRELESS,		/* Wireless */
+	POWER_SUPPLY_TYPE_DOCK,			/* Dock Charging */
 };
 
 enum power_supply_usb_type {
-- 
2.34.1.173.g76aa8bc2d0-goog

