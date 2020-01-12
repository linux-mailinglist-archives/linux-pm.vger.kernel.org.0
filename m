Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED87513872A
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2020 18:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgALRNW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 12:13:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44667 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgALRNW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 12:13:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so3532089pgl.11;
        Sun, 12 Jan 2020 09:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=5tkpOty7Kcf+owtmT5rJiVn1mp+mm6nEXaLj/KELc+E=;
        b=s4qL3hA5ExwgUDIEKIczvpQfJixy3CL+qa+2tn945x63QiXL7pnfENtLJR7Md2q7bi
         yaOwoK0OLmkSMfx4yat9MSuYoppwA1HjobiSiTyyo3ultSwnBG8RP8O8RU9bdPmHGUsd
         lO9ZWZ6xQsXg6xjZJBI7Z3fxdQxbHAaWMYSvPb+nBExwH1Iyt5ZuHt/PJk2EqBXjZtsH
         /AyI/YuIjEKZpYq5eL0wcgHGTEBlZFyvUcJGWDQKQQ5OomhRMEjUZ0pl52o3wdhSB/yz
         zxcExwqo9UMaUHTQ8Oiw2LCsnT80oEpWs2WnrS9if0oSVzPt69aJA6yhPYHpClQfgn6s
         8TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=5tkpOty7Kcf+owtmT5rJiVn1mp+mm6nEXaLj/KELc+E=;
        b=DaKac6LSHuQCkn3+6dPuavpH/4nUux3LoaPiMAJfDUACmTVcDOSK/9KUYQIn2K9m0p
         xAbEuKvzJ9YfNr2ref9rQxQkUuAD17zRXGrVnAM85ilmQLVYt28UC++lSTAhjBr5qkSn
         BpKBhDsTYXwv8Ae22fD9/SSGxSeuhFh4/1X68LbskZA9jxzpiGeER1OFEB2DDUlxTasd
         syBs+HFT/poKgw5n+bTyG+FzJw9CNa9t0tR7kl2QtnbIjGIj/QHV45TfTs3g4szXbGUX
         SfYYjtMqmVqAfK5mR2Vd9fVi2eG0+EEf4aiS+Ud6sonOwIeCTk96Y8q2x+8P+gofVEOV
         sYUQ==
X-Gm-Message-State: APjAAAU0El7UjeMDdqJ61tjlYXt0PYmUNAkSewnjX4y06EDZaYF/BO+n
        eDfoO/VmDJMJyRhgo2tzw1n7aeMnG38=
X-Google-Smtp-Source: APXvYqwXQyPBbsQvZdE3cVme0/0ISaLS049ySFwXhAoEuHbV4j0l0wD8lmi61p1T2l4e2ayVL9tGaw==
X-Received: by 2002:a62:1552:: with SMTP id 79mr15677180pfv.156.1578849201813;
        Sun, 12 Jan 2020 09:13:21 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id ep12sm10125706pjb.7.2020.01.12.09.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jan 2020 09:13:21 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        mripard@kernel.org, wens@csie.org, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sun8i: fix using plain integer as NULL pointer in sun8i_ths_resource_init
Date:   Sun, 12 Jan 2020 17:13:18 +0000
Message-Id: <20200112171318.23025-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To fix:

drivers/thermal/sun8i_thermal.c:341:60: sparse: sparse: Using plain
integer as NULL pointer

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c5661d7c3e20..4bcde9491edb 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -338,7 +338,7 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		return PTR_ERR(tmdev->regmap);
 
 	if (tmdev->chip->has_bus_clk_reset) {
-		tmdev->reset = devm_reset_control_get(dev, 0);
+		tmdev->reset = devm_reset_control_get(dev, NULL);
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-- 
2.17.1

