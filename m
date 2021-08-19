Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C666B3F23D9
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 01:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhHSXwZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Aug 2021 19:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbhHSXwY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Aug 2021 19:52:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F35C061575;
        Thu, 19 Aug 2021 16:51:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f10so1730393lfv.6;
        Thu, 19 Aug 2021 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UpzojMJeDxBeMajFIkGlxhgCIvbN9PYZ8Vm9UYX53A=;
        b=EULMLoxf8Uh+n/5NA2bT+gbfjybLnoBjUlu0+fhcVXi2pwww2qQQ9X3ie80Gd76+ez
         iluQ4IXi3X2qBkZBNnV3DEC5k6AhoMCsYO3bblSGoH15YRQhn110a/fJ8+zdCjaViIdb
         Rswh0V9hyrF1T5BhOCVtV8eHfSuqk6Inn6AKI3MRebmEl0cjTs4ohJbTjNSyiud8sh/v
         /+uzNKeBkBMUErqhkWLaFhTfUyV8Jz9emT975gOacyj58ugDmFU5JMBAoMVilHYD1PMr
         AwFJjfgo/zco4KCFhEbeUWovSZbBS2qbGH8GXM3BFvo0jMu10TxXJT7KOa9ITMZ+QUn9
         S1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UpzojMJeDxBeMajFIkGlxhgCIvbN9PYZ8Vm9UYX53A=;
        b=cq0eTEmAS2ZdTrPTHGm0euebilmSwXfm6f3UJy6Fn9OE7L705DKJ1cUfdXOOyu31SS
         y/L8jnPjhkpE916gdmzga57myzZXNMoemb2zxkwnpWL2wHBJeKF3QS3L8gXfWmFgE9CV
         Re8W0r+9Lx6m97qXhIk1IbdoX7RYGucKMdZhEADmTM/mMyDe8LjuIcDziwNB6bJdWAYC
         ZQKS55lT5WpzIAiHzSHPN4V9fmxM8BNuXMZktDnPhSV6TyZJ4DxRSouk6yO4ZhaquVpx
         oitC+YrLlOVGwHH6v/3NE53kXysk34SKgnOG6c+bRg4l0Qm4Q4nOn+f1ObwYVMt8znRy
         hFmw==
X-Gm-Message-State: AOAM533rUXq0xbUjErXRzkBYbbWMEu+pwTiHs3b7ZHoku0gPXOTcLgHJ
        Ppu6T/yzMxXsi2A0TBQlAqo=
X-Google-Smtp-Source: ABdhPJwTFFTUmy3uHikXbz+xK1H/x8MEoSVjFIaeAS8QxgwPYeLx8jkXwF2EeW6vxNceWvb1//NDKw==
X-Received: by 2002:ac2:5f0f:: with SMTP id 15mr12592366lfq.25.1629417105649;
        Thu, 19 Aug 2021 16:51:45 -0700 (PDT)
Received: from localhost.localdomain (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.gmail.com with ESMTPSA id a4sm450951lfs.273.2021.08.19.16.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:51:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] power: supply: core: Fix parsing of battery chemistry/technology
Date:   Fri, 20 Aug 2021 02:51:11 +0300
Message-Id: <20210819235111.25357-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power_supply_get_battery_info() fails if device-chemistry property
is missing in a device-tree because error variable is propagated to the
final return of the function, fix it.

Fixes: 4eef766b7d4d ("power: supply: core: Parse battery chemistry/technology")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index dd62c871b2b5..0c2132c7f5d4 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -619,8 +619,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	 * Documentation/power/power_supply_class.rst.
 	 */
 
-	err = of_property_read_string(battery_np, "device-chemistry", &value);
-	if (!err) {
+	if (!of_property_read_string(battery_np, "device-chemistry", &value)) {
 		if (!strcmp("nickel-cadmium", value))
 			info->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
 		else if (!strcmp("nickel-metal-hydride", value))
-- 
2.32.0

