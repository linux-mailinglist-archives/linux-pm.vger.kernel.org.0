Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC2401AEA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbhIFMGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 08:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbhIFMGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 08:06:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438BC06175F;
        Mon,  6 Sep 2021 05:05:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id x11so13154739ejv.0;
        Mon, 06 Sep 2021 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5rWzfawpu0XOsLyVwwYFgYCCr8KgHSAplCrfWcEUCc=;
        b=KYUpVbsceN24EZchDkkkol2zEry8/zZBvVe/CMNKasw0zP0fQumSMEkppUrrAB+wGv
         RRfevlklzFRZtH9W/mNoHsu+GG/RjUOIGL6ChoMEHgK7sxD3RvqkLRZAvNQNqvipm7Qr
         cTQlfIPe1GsNW+UvZK7BNiUuMXdUASH+Aqnla+22Ask9dzyDNc6ehe95YdO2q0n8eCzY
         ZuJLzMs8RQ/uItFbxCO3WfXsNP5dywIi6b5gkewTZajSIhB6UdA8pR5UEWq9WTFHWKIo
         1rQjMbJYLu8jsl82JOs/gHoMEf7B+/OHLCbf2CIqSjzSrrFck4NxU3uwEU99O0suf8eT
         7axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5rWzfawpu0XOsLyVwwYFgYCCr8KgHSAplCrfWcEUCc=;
        b=hIkNoBkgUSVSdMB417fqYs7H6eWMWjn7Waj2E+oiXW8hH3i06Ev1dX1YYGdHtxwiW8
         IMy4ZG2qSLqqYtrBxWJGMBAkLTaizXxnYqjY7HDBOzpCVGEZ//JAIdvUzwf4qre4X9oW
         9HoWE+J6Vro+cqOnjxRl+PfhTYGfd1aCUf5MHPys97ARQX9sgcrUfvNKUXeT7qEkA7Pc
         +2fgBUx08h/pB5yl9OKMdT0TsC0JlMYVrqRB/b6qHZsqqjJ344ioJ6YYjXE2V2pSfWy8
         I2WDYX3NMeZKzp5TCYMkuAqrohKaUoSkr3oMQPEUWGitrOiSis2KuSQ/OW20xFbwxcai
         Bmvg==
X-Gm-Message-State: AOAM533MBPuz1x7vQUhdXMWM4AWLjl++sUFUcR9WoB0aRD+YQjX8DC+G
        6qRljWuDsQ7g7IvywW88Wgw=
X-Google-Smtp-Source: ABdhPJxzUl/7BL4o86N4tIBXw9ehKJmQ0k3lSpIaKtVm3BI+0Af3eaSd4+mihFeqKv7n7AXDOZlSUQ==
X-Received: by 2002:a17:907:2a85:: with SMTP id fl5mr13028347ejc.91.1630929934659;
        Mon, 06 Sep 2021 05:05:34 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b8sm4536954edv.96.2021.09.06.05.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 05:05:34 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] thermal: rockchip_thermal: allow more resets for tsadc node
Date:   Mon,  6 Sep 2021 14:04:03 +0200
Message-Id: <20210906120404.10005-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210906120404.10005-1-jbx6244@gmail.com>
References: <20210906120404.10005-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tsadc node in rk356x.dtsi has more resets then currently
supported by the rockchip_thermal.c driver, so use
devm_reset_control_array_get() to reset them all.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 657d84b99..dc3a9c276 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1383,7 +1383,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(thermal->regs))
 		return PTR_ERR(thermal->regs);
 
-	thermal->reset = devm_reset_control_get(&pdev->dev, "tsadc-apb");
+	thermal->reset = devm_reset_control_array_get(&pdev->dev, false, false);
 	if (IS_ERR(thermal->reset)) {
 		error = PTR_ERR(thermal->reset);
 		dev_err(&pdev->dev, "failed to get tsadc reset: %d\n", error);
-- 
2.20.1

