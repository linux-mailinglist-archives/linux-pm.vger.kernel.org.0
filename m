Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F71F3C2B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgFINOa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgFINO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A1C03E97C;
        Tue,  9 Jun 2020 06:14:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so8494562lji.1;
        Tue, 09 Jun 2020 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o4M3bTUDA74h1lwoV4T2HnrphCh8yThUo/f/7p0LEJQ=;
        b=WubWCnlkgI26pfDVw0Ep1IhBhHdHzkVOBYEPckyx1O/SSzugmHx8umh0venYLUw/Ro
         mfDiF91/57n9ZKeX48nhhr3xmtVLkLmP8/aoMTjbmywRLYKaZeSd53ZXy9mqDLnhedCH
         S3lBChQtwGUrZlKCvD8arJfsrruaX7nvAAwH5PLSoA1mNy1OqZCTFKZxW6Zk37QKK3So
         yd3LTmHTyJXjSfb8Uc+4nUf1bGJUVgEGZJ7gr/nNpjwmINI2yKy2tVqq5QS43LkptZ8P
         wCbHInI+KPaGs9kvstdV2zsM+mECcDcGDHnppOC73x608s71jfurL6wgGky/aC7rcNm0
         d4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4M3bTUDA74h1lwoV4T2HnrphCh8yThUo/f/7p0LEJQ=;
        b=IlpiRaF0OjBFV2/oAG4LsBTyA0bgqIrTf5asDSmpniO5nMh2OYAOb7MmgzLT60s6Q0
         PAF9OjHE+RSlYM+VCz2QPq5e/rZ4P5RqWnLmn0dD5oyyviYvfdD371WEnDAQfAJ3U2Hb
         7U6BDvfXFGYT0dgK3GkqfSndjhO9COWauWq2Mu1o+mtJnEg7PWhBlw5iDXLpY8jSvP3o
         H0690dOWVayrhoCJn0rg6ezRp7WhM6Q2oP5Kg/kBBvhfgywKekzUFEvhZOHsOQtsD4ut
         1AaK0rDH+3zcipHcLy2cLY6Jh/felf+QPkSr3ohT0ar6yGVON+Or7pMPDMOSPqk7pjo+
         RMKQ==
X-Gm-Message-State: AOAM533NuJ6BMQ+V6jekdvCIdf6TddlhpLR0nhJtzS7huRqyRhmjviGc
        TqdCOI2Nq1c9rHQ+ELPzgDI=
X-Google-Smtp-Source: ABdhPJz0i8282/FJQIGDuc8pcHuZXMNEm+kWgDf2nK40LNBw6s1gDJI5NwQ3Sx3CyiBJD1F+eVni3Q==
X-Received: by 2002:a2e:961a:: with SMTP id v26mr3973130ljh.296.1591708465781;
        Tue, 09 Jun 2020 06:14:25 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:25 -0700 (PDT)
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
Subject: [PATCH v4 01/37] clk: Export clk_hw_reparent()
Date:   Tue,  9 Jun 2020 16:13:28 +0300
Message-Id: <20200609131404.17523-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
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

