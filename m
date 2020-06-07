Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FDB1F0EC8
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgFGS5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgFGS5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:12 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078B0C061A0E;
        Sun,  7 Jun 2020 11:57:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j18so4707587lji.2;
        Sun, 07 Jun 2020 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4M3bTUDA74h1lwoV4T2HnrphCh8yThUo/f/7p0LEJQ=;
        b=CkMC2yyRk6883zqpAxX3D1mm05jiHYAU2va3Na9qiT6EcqhE+YCtxioloddd5gIt7f
         kOwDXEteEPBfWLC1auewBMLUK0rtXuKeZSXs7Q4LnRgB/zcp1jsInTnUWcvh+rbJo9B4
         gXnmvVRGMUm3XxXmbdtOxB2BTHlthJlo1eH3rShxEIdvw8xUOo4xKq0hSJLg+c4K9u9d
         AUp0UIv4qrSNp0u68DZjroN1XS0HGXzPqW9TXc3mg3tjUMwAM80UbGiUyoV4mvOIccwl
         Y2l/g88zwG8WC+DPQ4R+7JjgYJ4XgeM3CN7yu485J5ir2ZVC8fA1l0m9gUupKOwbn0ok
         0sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4M3bTUDA74h1lwoV4T2HnrphCh8yThUo/f/7p0LEJQ=;
        b=Cxo3VTnV6z3kju5KJ2Z9m12oOg66ydLmY9zzZWSp6yzEWEu85ZGGJosnr0WBRCglPx
         z+aVl62YIQR0fJwsj/DamOuCXeJYoIqDU2Bs9JY0izJ7nG/7Pt5DDkE8p2blE+/PJ4xk
         xAdhZiOsXIpi9Wc4XoMCaqh7p5z/sEngcH9mfrtS9VpUX5n6DEEpkG4FfbLB8XKZukO9
         4cVfavOIB+wHkUsyDhqmlmWfpYC3/SgfIGxhVWSWuOl3WvzPPcDH15igxB86OjWQac7o
         +bbXf8zq3JWjFOgiY58Rt7JSwHDYt3ZRRrexkfvHA2C86JiQFCvTZIhN66k4m8FqUS2L
         CTUA==
X-Gm-Message-State: AOAM533stnr7foRCIHy9aWeKdkUWaihWKcnPsfXXLg1tNDKT1wTJKO7P
        FDPufJBB99BKZFihKHht1Vc=
X-Google-Smtp-Source: ABdhPJxETMF3Q1N54rcAMjLTroZSTX4jtV3H9y1r8OIF+OopgvIIuIM9/RNrxzek11VHQAuD0bGIog==
X-Received: by 2002:a2e:8115:: with SMTP id d21mr9773311ljg.167.1591556230516;
        Sun, 07 Jun 2020 11:57:10 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 01/39] clk: Export clk_hw_reparent()
Date:   Sun,  7 Jun 2020 21:54:52 +0300
Message-Id: <20200607185530.18113-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to turn Tegra124 Memory Controller driver into a loadable
kernel module. The driver uses clk_hw_reparent(), which isn't an exported
kernel symbol. Let's export that function in order to allow modularization
of the Tegra driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 3f588ed06ce3..2fa6394d9a1b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2439,6 +2439,7 @@ void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
 
 	clk_core_reparent(hw->core, !new_parent ? NULL : new_parent->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_reparent);
 
 /**
  * clk_has_parent - check if a clock is a possible parent for another
-- 
2.26.0

