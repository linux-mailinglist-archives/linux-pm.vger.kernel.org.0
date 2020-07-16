Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A99A2219E7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGPC22 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPC20 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:28:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE19AC061755;
        Wed, 15 Jul 2020 19:28:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so8102502wme.0;
        Wed, 15 Jul 2020 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQxWpRgQb3Xq+P5ehR8ew7q9vK97Ab3OJ4StJNb/DKE=;
        b=sQUaD3sxXAOsgpgXKFdUKklgmD4CXtwOkV7jyW3ViR7K1en83so42tP33suhyvxZV4
         6UBoH/sec3Mh3IfEqQZ4cDZj2Aiq1kvH0BlftUAHU1mkW6Mzcw393JB0LXs8/8M2YKqd
         Y2/MwZisQQciHc7lvhD2hKOyHmlAfJjiVrs/FeqLQmZtCZXz3IXvfqgSXQIj4tNCj/P7
         rwvYtzwzvAo4Fh/Q6iSwc3sKPwo3d+ZhTbygMA342wsY4IadEb6IHE4oBKBRvU8YjfoP
         VN31huP7ZMYfkV3wtq1qb8k46cIOB3IBGKI4hLYngVmax2rnEjJ14qTKVBr5evDeusZn
         8O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQxWpRgQb3Xq+P5ehR8ew7q9vK97Ab3OJ4StJNb/DKE=;
        b=r2sVLSKH9XFCUVxkr937Eqe+jFSXVC1qG/9J29k97hbJ0p4oEL/4Vfne4AQDrUPGjE
         H2WKQJ95xNRqOzLLdLRwLwizxd5ojXT9GGIPXqH77jmFEx3lCbyZ2mj3Ao1afgBp/F09
         ZomqNtnaGPJVuzvUIwV14SPOQ4MuSRH3xhWAzdII/FMLgtkusLQRBjPX72UmWPrexZkD
         WVqadiK2gAPDyYPKcK2rr/EdGdZRIiFygmGELAz6n8kvLxiOAU/86n6hYcYTOej2tY2P
         uC0iqB6e6ySj5PiOyV2ZNnq+NRQzvB3RtyCxMK7LjsFaTYc1C1iWnpl2RKXcuOV5HJYe
         4tbA==
X-Gm-Message-State: AOAM530jYze2trPYSL860W5PmPkxNN5TbeHfak2+eLQNAa2gcb4Su+YW
        n5DNLcpy3lrziDdtHUnHn5cgvssmYYOn2g==
X-Google-Smtp-Source: ABdhPJxAua1mxkgJpGb2tuSl/qOly9wfNZ+5kc8eLGAa+eDIfH2KrQTsZPHVf7buVqvTfZOlRaX6/Q==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr2201470wmc.176.1594866504470;
        Wed, 15 Jul 2020 19:28:24 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id u1sm7477611wrb.78.2020.07.15.19.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:28:23 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 1/7] ipq806x: gcc: add support for child probe
Date:   Thu, 16 Jul 2020 04:28:10 +0200
Message-Id: <20200716022817.30439-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716022817.30439-1-ansuelsmth@gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for child probing needed for tsens driver that share the
seme regs of gcc for this platform.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index a8456e09c44d..d6b7adb4be38 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -3089,7 +3089,7 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	regmap_write(regmap, 0x3cf8, 8);
 	regmap_write(regmap, 0x3d18, 8);
 
-	return 0;
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 }
 
 static struct platform_driver gcc_ipq806x_driver = {
-- 
2.27.0

