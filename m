Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FB1F3C19
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgFINSJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbgFINOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA4AC08C5C2;
        Tue,  9 Jun 2020 06:14:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 202so12459918lfe.5;
        Tue, 09 Jun 2020 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzjWXOFJZUWh4EJTzInOXHHEbdt+siqMf/YejHURVDA=;
        b=VnryWu+aK7L0DcpiyL1N3EE7vSAAw1+NT32TBAV1tcBb/suSZax3CH7mFh6FHpLDM8
         87OUFDzWVfo6qk3nbUEHkvI9kH21D+K6986gejHq+PeXGdN5AsW1CZIGo+SIbcMz7F0J
         +F4XLpJCSLPHX/BpmPlFdGd/Ur+gu3ozUYLTCQMGnaBERJYvYSNUL0bDKIG5DxlVBljg
         cqNlOz1kuqV60AHRNZuWl3kxJm78d4zTyXd1IFik28f9SlGmfBeovETkWgYl1dbbS1bf
         SHgzmt9BMXIUa+oqWX/w6adLSx8GqSkglDqU9Yg3+TnkUfxTPqvXnDhFQCIQs+Ujp11A
         YrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzjWXOFJZUWh4EJTzInOXHHEbdt+siqMf/YejHURVDA=;
        b=WZ982JHuvyTF76S+Cb+nlAILmp7lHMtMydJE7Mh2F8poRxbPg7V8ja5cB8iPyTb6z0
         TcBdyRPZGJA6uP689vjg8zdAWbMOR7vmzlgm8K2Pt6kiQtPl3w6Mq/3cPAoeogvcBZPp
         3TPDrfVzX49ymFaPU9PrRMv7GOcmA9EM7h4hUKzo3r8QzpAq2c5QqBsIjJFHGpFeOvLN
         1ipX2bP1nARHy+6vT6Hwwk691PuowZlrOkAcno6/cFpGtz+DiQHi+9AU5kGoQwb/GsTL
         xoENl/SCzyk7404BHh8FkLpx+84WsFVsdqnpwPmUCv1MVnL87FQ9dopZ4KNvfF8+rfzU
         5/2w==
X-Gm-Message-State: AOAM531LAhms8rzrSXQ314nbOdMRKK7QZzNyDFB3WwlVAgmmgtbWEhoN
        N9NZlGw4q8naVBqvv39oZgw=
X-Google-Smtp-Source: ABdhPJyeHIUP/pqKNcqji83du0vLJY5MSz/ENMwIxIYDajj/AC39DJqr1Xg3KQnU0hJWGNaSztmNng==
X-Received: by 2002:a19:6914:: with SMTP id e20mr15497190lfc.27.1591708474918;
        Tue, 09 Jun 2020 06:14:34 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:34 -0700 (PDT)
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
Subject: [PATCH v4 08/37] soc/tegra: fuse: Export tegra_read_ram_code()
Date:   Tue,  9 Jun 2020 16:13:35 +0300
Message-Id: <20200609131404.17523-9-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
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
index 3cdd69d1bd4d..b3c930b805c5 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -65,6 +66,7 @@ u32 tegra_read_ram_code(void)
 
 	return straps >> PMC_STRAPPING_OPT_A_RAM_CODE_SHIFT;
 }
+EXPORT_SYMBOL_GPL(tegra_read_ram_code);
 
 static const struct of_device_id apbmisc_match[] __initconst = {
 	{ .compatible = "nvidia,tegra20-apbmisc", },
-- 
2.26.0

