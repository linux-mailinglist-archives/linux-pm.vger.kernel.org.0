Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD22217FF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGOWpn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 18:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGOWpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 18:45:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0CFC061755;
        Wed, 15 Jul 2020 15:45:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so4734237wrw.1;
        Wed, 15 Jul 2020 15:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7hfnd49qzQu+v3pW4+QTWy4zDs6kHByKCCdtVpj2B8=;
        b=KZL24XKzrPPkNZ0tREld/Dbmj74vqwi5XukLRQ5rcwQNCfFXJfCSQ58+hQjGwrdXbo
         iuE8GSCK0zU2MiIA5xGh/akZIEtip9ryXt3LBPTBlNogZ7TOR3oVoC0v3bKdmll2AppC
         Nngf/VXC8C4N4fmliCl2s+8xr6p47SbUUhLO/2oCIjY2qfrc5wXueNB17zDsYbHjfQZq
         O6HvxHXBxrQ4l6Ri/5EH3TD/3xr61QypVbTOV2zTjNteWfSc76vlfystMcLBfeWfM1zx
         0RcwZKvYVxBoGwmvsKXqy9348B1s8Q8hlXe8hWsXv+Li5c1Penhw6aVea0MBYHuGs1IV
         MA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7hfnd49qzQu+v3pW4+QTWy4zDs6kHByKCCdtVpj2B8=;
        b=qfi5TW4PtI09fI/pgmDYt9fqTcUiq6LLTz+qvE//EipOZkp/2vR+YPeo4gRakAtZp/
         QfGOgmPoTGADY/yNPfpNrOIDotdVvFcXBHll4BAY2yykOyLKFfh6RSFLwGzYrzWnsgzd
         eKHT3pRULPytwf/YsdCRbZ06gReWDI76ohbraqQaFg7nG4LYXx2vNEioXAdi4N5pQAV6
         6pf1xtEpqC1bVH1pLTg+AhonTiyN8rQmAaPb9zycUm1N0/w+OQNxjHTdY9Tw/c87Qfyu
         WIRYaKh4IxXNoHN6MteipEveiOqzyoX2mMGBiAoWE9dYkSGLXXIzWB6hQT8aQafKeU7f
         X2Uw==
X-Gm-Message-State: AOAM5315Lg10k6XBI0b4grpna+Mt+RhmfiAmu8hoXJUKZKWNjmlntwtH
        gUhPdWo/xwL8ujP/sGGBegA=
X-Google-Smtp-Source: ABdhPJw+sRw023UQ9OoaCzEgBNyuSx+iXUOQt5tFvnnXqskiKzHH09rtVQzDd0XDIphacs5qhkvlMw==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr1934547wrr.296.1594853139122;
        Wed, 15 Jul 2020 15:45:39 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id b186sm5759898wme.1.2020.07.15.15.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:45:38 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 3/7] drivers: thermal: tsens: add ipq8064 support
Date:   Thu, 16 Jul 2020 00:44:58 +0200
Message-Id: <20200715224503.30462-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200715224503.30462-1-ansuelsmth@gmail.com>
References: <20200715224503.30462-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ipq8064 SoCs based use the same 8960 driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 39c4462e38f6..2985a064a0d1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -907,6 +907,9 @@ static const struct of_device_id tsens_table[] = {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
 	}, {
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8060,
+	} {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
 	}, {
-- 
2.27.0

