Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB0128F17
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 18:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfLVRlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 12:41:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36656 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 12:41:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so5547157plm.3;
        Sun, 22 Dec 2019 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sq1nZxgdVlOFdZ13j/feTQWw6xV90se6Ya+xGUWD2w8=;
        b=nn4+IngbVUi2MOy8sEb17xGRRJWcWgHlbgkTtGiYKDZSaa8GUNLuJPygCllvkWx0Ii
         I9xiiujiey6lyACnlOf05QnTH9uQibuyGCT0hspRupDaWSAAM8RtzgBHS6bAsPAAvBcD
         /ldoOe347ktrCssPFEOsWHL8gR/t1RKAclID8F2Dv2+0E7/c8acpf3dPYvIbFDTgSVR1
         olR9wYx/dTOjKNSooNoPc58rtOw3+Gz/5InaKK5+3ybhFUGkTLuhYxa3mJyy9nmlwuT3
         37fyYZFCdBFnYZLtmfSDnrMBRg3cxt2KEWR02H7NzWsnR5AEqnhIaxysZ8MuID1Sjrln
         hONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sq1nZxgdVlOFdZ13j/feTQWw6xV90se6Ya+xGUWD2w8=;
        b=MixksT2hRpTGkz0cuWrsin99go1oKsnlxeoRrrms04K7JOczTTj8HTOE9WAuCVXIoy
         HZeQE739zeaAeEHINvIOtP/E3b9Hiov43lKaZDYX0zZF1IuwojKcqS9/W8woEv4MfPnx
         wmEPd6+OgGvnfENXJ6YGcLoqgiFIt0g90xLIRhH/sBTBqP7yzWvFuq4jtn+t1ArgfAds
         68nPoWuSa66LN2IMKWQlO5vHb+1flSTjIGhcm8fTDT8cqMtDRdrJkTPd0muaMwRnHLXK
         JuOPEw0B2Ssj2SsEMW1cOHSpHSLocwvqaJBtY9FXRFFKw5bOiC6va3kBMVu7umN7Q0zV
         zLyg==
X-Gm-Message-State: APjAAAX/Qpeg4tb9mA7EFoAG/DRoqBerZfBnOnMo4VWm2X0Qyxq8zsz+
        hDghE4A6lnjIX1gaimyrnkGCmXtDeFc=
X-Google-Smtp-Source: APXvYqxT5s6ngv8ij7A1pTe1bgYyWS6Z2EYVa48gRLQTHFu8lG8IxBYiOFE+eCCDweL/ZVHdWTx1MA==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr26002206plr.52.1577036497923;
        Sun, 22 Dec 2019 09:41:37 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id r28sm18703054pgk.39.2019.12.22.09.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 09:41:37 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 2/2] PM / devfreq: exynos-bus: Disable devfreq-event device when fails
Date:   Sun, 22 Dec 2019 17:41:32 +0000
Message-Id: <20191222174132.3701-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191222174132.3701-1-tiny.windzz@gmail.com>
References: <20191222174132.3701-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The exynos_bus_profile_init process may fail, but the devfreq event device
remains enabled. Call devfreq_event_disable_edev on the error return path.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
-change subject
-rename lable to err_edev
-add return value check
---
 drivers/devfreq/exynos-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 7f5917d59072..948e9340f91c 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -335,10 +335,17 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
 	ret = exynos_bus_set_event(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to set event to devfreq-event devices\n");
-		return ret;
+		goto err_edev;
 	}
 
 	return 0;
+
+err_edev:
+	ret = exynos_bus_disable_edev(bus);
+	if (ret < 0)
+		dev_warn(dev, "failed to disable the devfreq-event devices\n");
+
+	return ret;
 }
 
 static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
-- 
2.17.1

