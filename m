Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020F029846D
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419194AbgJYWRz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419189AbgJYWRx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:17:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E99C0613CE;
        Sun, 25 Oct 2020 15:17:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l28so9411383lfp.10;
        Sun, 25 Oct 2020 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxBDmQPM1u3TxsC8gvQqVBRZUJtQqbbcwOXSeprhG3U=;
        b=pMuTcykNw3g9kYCpJ7OFz9qPr2VLTMUmlxgpJ1q6B+Ai4QzKza1brA2TxVsV3t3ywn
         pFOq5EcA6p+7ktWe1yLarZtj1dGRBOs8oDIb3eVD2CSYzbNW9L+wTMHRsdSsyLegSssp
         K9p79pyZq/dqu4DyqjRrAxb5jVL0tgxfyLk7e+WYTd0dSDoTsRwUh2oTZ3eGf0LYo/Em
         6GrUQGdIRxCi/ttEGpZ64bJY7pyoH8fMMdAe5yjsQu2o3QFuOG/KPBELiXgArLxCvTDY
         srhAzu5vxqZVzmfYRiZVnoQ7x14Oh4r7rPKsm34Oopf+J5G1qHuNvvopB77xWfcr3vzs
         Vcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxBDmQPM1u3TxsC8gvQqVBRZUJtQqbbcwOXSeprhG3U=;
        b=VEfig5Qr1m0yKHvNr3cU1RFsuibopyIEe7LJKvDgtyJVHIFOv3lfMHgyAVPOSE1ukj
         vP8iVEXjhHWrHFD/eMaLukR3JKAQOWbtBI57xMsXixGJk7ag639Hal6lEd3R7b4IXFC/
         9wLKN4X2BaEIjA0k6DdbJnfi8nQ2z0QMB48IDEP+uiSyCp1/ORKEEcIvbh9iA0DsUc+M
         bao/O04l21inuTYSoB57AYjlex44UK4IIypJTUE9iR37q2FO6Fm8j6Av+Cc2840Zpa3Q
         sNB5gr4u6sp3zfyYMhCEjqGum/8JhSgfn27XQBZ6gMNLjSu97II8nhb6eFM7A6XXGPC9
         ukxQ==
X-Gm-Message-State: AOAM530cmBsNsug/7snUez4myIuJuQVE6mHBTa4rc4C85KKhRbiraIcI
        K1W+aclPJp2C5mxM/zLezzk=
X-Google-Smtp-Source: ABdhPJzneogPL95UN/cBtkWY5gKTrzlU3UHPgIt2MzqCBff5HU8piBWYDzFE7VGhxY92HYijisvZNQ==
X-Received: by 2002:a05:6512:3455:: with SMTP id j21mr4440799lfr.135.1603664271160;
        Sun, 25 Oct 2020 15:17:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:17:50 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 02/52] soc/tegra: fuse: Export tegra_read_ram_code()
Date:   Mon, 26 Oct 2020 01:16:45 +0300
Message-Id: <20201025221735.3062-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tegra_read_ram_code() is used by EMC drivers and we're going to make
these driver modular, hence this function needs to be exported.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index cee207d10024..590c862538d0 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -90,6 +91,7 @@ u32 tegra_read_ram_code(void)
 
 	return straps >> PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(tegra_read_ram_code);
 
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
-- 
2.27.0

