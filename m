Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73496129A54
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 20:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLWTT0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 14:19:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42588 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWTT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 14:19:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so9615555pfz.9;
        Mon, 23 Dec 2019 11:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4psQtWa90JQilxXsmGId8ARflofhAVS5Nu5SDmjn/4g=;
        b=cdxjrTgxNE4436krgq5tzOVmG2nYo+ZXj9106NQMnj/n7qcx0yGRnpiPPSV0NMwTMz
         8QGY/kv3u/vbc7/dILKMb3h1h0l7xBmgZSNRucKj5D//JpIcyel9Ztjcv2I4o9LI8+PI
         bPmw5aV9lS+Gh80O2TFL/0FxwoP/zJA57WaNbDC72FndUeiEuHQGo6FtHCOTyCm5vyyI
         GDUjzD7nrEij04BTpH18qWhML9jhKQTqPRWx6h2yQ96TZQKINLJpfv6m53860V14vBjB
         k9Xqmxcl4c8MdibdpKSUXCoa/GvwHKTbdT9eP78OgM7j2ZAUBIrvTkq6dtXHIcs7Ld2z
         qW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4psQtWa90JQilxXsmGId8ARflofhAVS5Nu5SDmjn/4g=;
        b=sR5CsmxqHHRp4Vpm2hDXHPjfTnR/s8sZeimimmEUkJmYMxHk/kMNOeBUIoDARHy1T0
         eR6xercH8I+EWDvs5Ny4NYxRbitwLlNv/ecLW2j83ufBZ8U/ien06Wj8X3YwCmSsgpui
         uz9GOfM+sUPpZbyKma3bogLoXUlOJa6bZzVuBZ8x/+YJM51NSA24yp3ZOIyvXJb74Y+1
         UXSj1l9YChXj95XQvPxntVl/9zQnYNYjQoifZAcuiumpXI1dqzyVpRiG3yx4nfFA9FPk
         zo3v6FLVTNKLkWj1eo9GsxB+AmmHlQ5CU2Kh7pUvz68SDkZjesQ9CDH4d6IqMOUJPke2
         bvCg==
X-Gm-Message-State: APjAAAXK8RN1agJHQMo0NLcgagueWP/89sqJc/QHnoKSFlpjHN9rnOlP
        qfRKA8+Ko/XHkgFS53TrIFo=
X-Google-Smtp-Source: APXvYqxJoI9edkamQRQwobrhpyZtT7J3qbiDFkybKTc/HflCC2LJMWXBcj1bU3zoVC3UyW+JX9lxKw==
X-Received: by 2002:a63:7b44:: with SMTP id k4mr32966608pgn.140.1577128765493;
        Mon, 23 Dec 2019 11:19:25 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id h7sm27175292pfq.36.2019.12.23.11.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Dec 2019 11:19:24 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / devfreq: exynos-bus: Add error log when get event fails
Date:   Mon, 23 Dec 2019 19:19:23 +0000
Message-Id: <20191223191923.10450-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding an error log makes it easier to trace the function's error path.
Because the error code may be rewritten on return, print error code here.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/exynos-bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 948e9340f91c..634d63fd00ea 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -126,6 +126,8 @@ static int exynos_bus_get_dev_status(struct device *dev,
 
 	ret = exynos_bus_get_event(bus, &edata);
 	if (ret < 0) {
+		dev_err(dev, "failed to get event from devfreq-event devices %d\n",
+			ret);
 		stat->total_time = stat->busy_time = 0;
 		goto err;
 	}
-- 
2.17.1

