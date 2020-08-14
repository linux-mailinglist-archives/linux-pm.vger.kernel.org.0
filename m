Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A508E244274
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHNAHE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHNAHD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844AEC061757;
        Thu, 13 Aug 2020 17:07:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so8127797ljc.3;
        Thu, 13 Aug 2020 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9G5w7c/hIvGiVCDrZTknQQZfa/cldECq9uSATZxh3c4=;
        b=otxEOoePlNJwWzSvhtqw8dV7okkDaXfkHFp6nD3FsIzs4ZEU1R6d8+gxFI8ZYiTOkp
         C0qBppnBBwCBUZeNmxY83awYyFy/mhxtD99Of9G23/KMnQLBGH+PaMoLVSgR4ZkOLdZQ
         8qMVQH4Yg9CFb/FTgoMJgRTRmTDv3I96TTqIJU+jjLT1mfgrJq8E5IvAuAuPa7fyY1ws
         310KCnzBMNJzlnQ7jHP1bV+0mB20ODMm54GZlx3pYn/CLbKMWg73wrX/TVosHglZdO27
         kTSgg+Zb675q5H9ox0zGBI56MqeL1XSJ7KlL0I+53ti2GayBrOdSsvzk2EtRJswiAQ94
         GG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9G5w7c/hIvGiVCDrZTknQQZfa/cldECq9uSATZxh3c4=;
        b=TVWxtbSviU8QroGksLePDMhFs84gqjZcUHtgbDQD9NCGjF6ZhbnPKHnmOECOEivRCh
         G0FmqwNV8EfP4CH+AiSOcTW8COPqhTi51DCeWE9pJpcc35W0zrTR77upsGykzkjRdtRr
         etiHpPdieClFH7V7ysjuPaSkOInZEsE2Mmnqb77O327HYOW/dvfIJyB75v/Z8J9kBKMK
         y/hQVTb23bKJX9jIOYgI8IwYEGaxzEi+DTroe6pq6H88/Zat/b2fE4spu5KzlwMspTo+
         D6fy3WakB8YyKh5buhviAQVZ1ZBLNOi90652yynFjts1R0VfnC3P6g3121zkFbbQXkUe
         z+Kw==
X-Gm-Message-State: AOAM531cbPPtxhMwVZZLMlcfVF3UyaP28uuP3MsMVinc5rZj5Jiw05d5
        1+r2Y+nqBVNOg9o73Owbp7o=
X-Google-Smtp-Source: ABdhPJz4FEc4x+4JcBBa0eyimwEiNT6FBFi7MpO0vixFhxFCJuQWpOqfcbh3HRTEGm17m7Imhl4bKQ==
X-Received: by 2002:a2e:9d17:: with SMTP id t23mr105543lji.456.1597363622032;
        Thu, 13 Aug 2020 17:07:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:01 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 01/36] clk: Export clk_hw_reparent()
Date:   Fri, 14 Aug 2020 03:05:46 +0300
Message-Id: <20200814000621.8415-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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
index 0a9261a099bd..2cbaede80fe5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2448,6 +2448,7 @@ void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
 
 	clk_core_reparent(hw->core, !new_parent ? NULL : new_parent->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_reparent);
 
 /**
  * clk_has_parent - check if a clock is a possible parent for another
-- 
2.27.0

