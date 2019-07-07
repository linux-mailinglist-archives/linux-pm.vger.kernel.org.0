Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC5617F0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 00:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfGGWfw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 18:35:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37791 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfGGWfv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 18:35:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so11883578qkl.4;
        Sun, 07 Jul 2019 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IcyH64p85F2RB6CqpFfUFyIfEFxLjqbTFsnGfzpD/Qs=;
        b=GOCWtMaD7qq+v6UGSP/g/YogQEjIjd5b2vmMntigEFZ/xSwH5VGvyEEDTE/QfkGgzK
         H8DBJ75DA0UmNwAS9Xe2DlSezwzpe/enTrMTQWHkJbY+4vNLoplXqPHkCR+0QdfVfOaT
         t6D7BQP0ng0zXJIQOTrIpPfgf64WrpLdgSRAn5xyubowX9SzO3itxhk7Vq9M05K2wOps
         PrE/MdyClacI9IRpn817X7BkYd9Fl0gydPA7mwZcSY3a1p8p2BCdH0qmBDyZOGiUqEM3
         NomSnXODpS1rlxqJwEFwCsug7bu49zEWTPw4U5mtQG2/BDr5ybxiJZo28eN/lYde+wms
         zAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcyH64p85F2RB6CqpFfUFyIfEFxLjqbTFsnGfzpD/Qs=;
        b=ICYvLuVcGjtoSHUyrukKRRzpoo0mPxznOUa9wEjwJ9+LBgNRXs8YaLoezV0ird/l+3
         z7vL53Gb4cDDu6jnm+aEZui1dPx1oy3skk0V64isB2JAcwCVdv9zx3qmTUmeHVKSsLBC
         RrPOu3nk1lL3cnJn+qO7IGXQvoBOtJHMqVbaQat+LzwCFYOmVJ8abDYvQzvxdaGTUSSB
         75Smx+ZIpm1ZseSPP6FeDrt5FuYdtx0h2LiRKgwWOyGUbZg67ht9wu9QPuHXAc3XiIMX
         0YVqy6QDQO/BtyukPLbxk+TiLCr51i+dvcMxRHVgW/ucIxljm1K8uBqWeQ7f/gP0BBJE
         H+zQ==
X-Gm-Message-State: APjAAAWB9y1ChQVNLhC+21zVtCLsy3u45H+uHXIKTERSKYI5DlcWw/ng
        cdbwKsab7ecArxlBzmcJVhc=
X-Google-Smtp-Source: APXvYqzN8k+kGXKPHkGWm8M+zOu6/SDKvRi9Aj/GzDbOg6079dXA4DIW5HK/GwhCAfQ4pv32lmD1mw==
X-Received: by 2002:a37:91c2:: with SMTP id t185mr11751856qkd.193.1562538951059;
        Sun, 07 Jul 2019 15:35:51 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id p4sm6998453qkb.84.2019.07.07.15.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:35:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 22/24] PM / devfreq: tegra30: Include appropriate header
Date:   Mon,  8 Jul 2019 01:33:01 +0300
Message-Id: <20190707223303.6755-23-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707223303.6755-1-digetx@gmail.com>
References: <20190707223303.6755-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not very correct to include mod_devicetable.h for the OF device
drivers and of_device.h should be included instead.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 8a674fad26be..19e872a64148 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
-- 
2.22.0

