Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892931F0ED7
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 21:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgFGTAj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgFGS5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A00C08C5C3;
        Sun,  7 Jun 2020 11:57:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so17736691ljh.13;
        Sun, 07 Jun 2020 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpFtIVnKnNndfebpkGzqwkaxd/wyRN7pW9EKTYyaD+o=;
        b=dVzKPShw4KgOD+DsB7SciXodU7w9VUVFbPFuBaWR1s1z0scCvNhSx+hpw7DAJwTx/O
         YXrQ3c7MVoaaRHpVLS7AvmJvyu/ZpsNv0KE89n0nu0ifIdn9S7AruNCHTTpTzT33pB6U
         Ka4/FclAqOgc6eMWkhNE2AefzhqucIaXMO8JtuxQZC6PM/6fmHERV+dTjkKyTnBEUZ4P
         WXfUE3bmKN7JQF+8kpAnyMy9DpCKvYHxvacGsSaMssAinTqBr6DnxGfYTw+Rb43NX8/X
         CH6zbNCCOfnGM54v56VMS5BzpkU8HArHeCfU6yGw/GtdGDo+XW3kYwyA1/suXSHcuQCD
         6/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpFtIVnKnNndfebpkGzqwkaxd/wyRN7pW9EKTYyaD+o=;
        b=YmqlOILiKcSaCkOynOCukg1KjWLk4XNlL3LLsmRbqHcBfXP8vv/LROaH6LtHln+6tQ
         HMdS+J+s0war6ARCVr2XSp5hI5u1duEdWdVWR+cpZj7EP6FtHtKbljDVKoHbzewR9I/R
         +t+LZ4Lf30PktW+EEN2cVWvVzNXrcBkbjt+uLmQ/nkb2xdGts6lkyX9bcJ9tTbqyIS7R
         zEY8oOcugm97RXf+BpQ/KPEY2vDioSXdMk/YyPrjz2oQCGOoYQ6Ag62WJx1J3XUgdCUu
         0Vr+Seu06DGHmcl0/cExrKl4Bou4ofa1qQMhzbAFtw24QBhEod3vdk9YFMpWIulXKRIn
         ePig==
X-Gm-Message-State: AOAM530Cc7frTCiNV2x5b96rL/3PWQ80PAD3srV5w7IQxC3tjKoGnq1j
        8eT5laBHjv1XWsTvnkBHX1s=
X-Google-Smtp-Source: ABdhPJx9HQOg7T9G9DNZloItTqEpDE+zxBogAZlWstcxnU5tM6I+j0lUX/A4nl13lbKimVaBTwXU5g==
X-Received: by 2002:a2e:6f13:: with SMTP id k19mr10267726ljc.364.1591556233270;
        Sun, 07 Jun 2020 11:57:13 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:12 -0700 (PDT)
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
Subject: [PATCH v3 03/39] clk: tegra: Export Tegra20 EMC kernel symbols
Date:   Sun,  7 Jun 2020 21:54:54 +0300
Message-Id: <20200607185530.18113-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're going to modularize Tegra EMC drivers and some of the EMC clk driver
symbols need to be exported, let's export them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20-emc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
index 03bf0009a33c..dd74b8543bf1 100644
--- a/drivers/clk/tegra/clk-tegra20-emc.c
+++ b/drivers/clk/tegra/clk-tegra20-emc.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/tegra.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -235,6 +236,7 @@ void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
 		emc->cb_arg = cb_arg;
 	}
 }
+EXPORT_SYMBOL_GPL(tegra20_clk_set_emc_round_callback);
 
 bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw)
 {
@@ -291,3 +293,4 @@ int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tegra20_clk_prepare_emc_mc_same_freq);
-- 
2.26.0

