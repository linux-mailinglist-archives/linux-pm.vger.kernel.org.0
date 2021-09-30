Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D272D41D85B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350319AbhI3LHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350289AbhI3LHJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 07:07:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4FBC06176D;
        Thu, 30 Sep 2021 04:05:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so20352221edv.12;
        Thu, 30 Sep 2021 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5rWzfawpu0XOsLyVwwYFgYCCr8KgHSAplCrfWcEUCc=;
        b=YIAyiuXj/TtHZgfD2uNj3qmZAlvslgwfgTNImQjcTdmg+Y0ntcaFbzPyE9bkbxkgAN
         M1ASIms+oiGJu6DgPXnYDYGFcGuhw7XKUf/d8oW8XpG/uj+r23Klbf55Ztl73wo08hoT
         U72PM3uKbn25ZloGgWDhNv6s1jnsujztSXFgPaxIhjHWwkFwfLSSyY+VYTKsYm1YFXsT
         soB47kM8dNuT5XZaQzy1oP6v2YzhJtjW6ei2LLj71QUvIkxzfF1QOtqOLuR7m5hPmGNv
         +rREb7AzVX29OMe3HXeg0CnDZ2ZYHHMBau41t9PJiLNu+Zr67jCrfAGBWbMii0HYO2h3
         +p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5rWzfawpu0XOsLyVwwYFgYCCr8KgHSAplCrfWcEUCc=;
        b=z7cs9HSDyKBdmwCsfcS7soblI5QL6x8DrVNISlrdttEhts8L/18sX0jV8tNdJOugtc
         U6X97qR0xjgSPlGOV4i5eWzw7PTEpZt0Ops3Ma2+WN4in986r7kYOgDJ2JXQhI2WK6PA
         lZz5jzTqw8SuW+nv0gGxoB9Ii3AfuMun2UyRgkKV37SYxH8np5edq5zY+nOGYaq3dc/w
         PW4WHeCfaF9fKj1lbWKdYHZHKtcJH8cyPMYOrpbb4Z5lDriDEkenfpX9T2O0hmjJzaZ4
         d82Gpos5K2z2F5H0HI3iPtblhEe5AJirHR7Ie7jkTgClDhxI4IBc3eYAl6YY1DyVkYko
         tVfw==
X-Gm-Message-State: AOAM533JEFvG5AwYYZRGDj+fgJibJ5EdQ+/6REXxq7EUXHQ+MnROJTeb
        U/324MDjQ9WrloBqhUlymNE=
X-Google-Smtp-Source: ABdhPJys89Pj1f3j26d8H23T31HD0TxjB/nOFlM2aklDPRJ+eXJfAdNX+76pkVAgrcgwul3T4YRm/Q==
X-Received: by 2002:a05:6402:203:: with SMTP id t3mr6332502edv.69.1632999925589;
        Thu, 30 Sep 2021 04:05:25 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i2sm1305158edv.7.2021.09.30.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:05:25 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] thermal: rockchip_thermal: allow more resets for tsadc node
Date:   Thu, 30 Sep 2021 13:05:16 +0200
Message-Id: <20210930110517.14323-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930110517.14323-1-jbx6244@gmail.com>
References: <20210930110517.14323-1-jbx6244@gmail.com>
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

