Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEADE295108
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502591AbgJUQml (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 12:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441517AbgJUQmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 12:42:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B4C0613CE
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 09:42:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so3786222wrp.10
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JS933voy/5ulGI3fj+GAntyF9rpzNqa0lFnIF6+V7Ss=;
        b=rOtvEQODVH17lLAdMVAKe/rIbWnNmfZ9BUkou7mb0yCv9F9XG8FRyBqy7VWOePZr3t
         B6bbFjV03umYPLuX1VcNKtC2+CLF3fFCFl2q6l/awYyDs/BPpvcVSF9hOKgrR5iLrW7b
         lEm+Km9Gh6CM0VkcmjHZOWplxr2pFhg6TscQAupU+C1yKCKQCW+rbog6Kl4pnvdbyEOn
         SzNZDXQVvd2fg/Ldq9HJBqhckN6lqdOML4KTnrtIsEdnInApEh5uCDhpgf7zIM3SZdVC
         WBK4gtXt1M8PfiI28v7ZS6ch4/9+wOq0c5udn+GBaDfNq9KzPkdqpzHy/MbqAzoo1fBS
         JMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JS933voy/5ulGI3fj+GAntyF9rpzNqa0lFnIF6+V7Ss=;
        b=LeIxPkcVuJJt1b6mTX/UcllHbM2jS1Gzto6QNuUD+Y7XvieRW2hxvCNk8lBvJPT/U0
         3PuTg6Jgs71PoFbs9gEk1CLvN9QI8sA9EQ6Y7ppH8+KqLKCxH2/XhIqkM9mfkDbaciEu
         9cdpIbnfr7iQ1324lGTOmS0V450tQMLglWsWnVZ/wz7tLm5oFvLCbH0Dv8mGgvgBKx9D
         aTFG27/p7hLt+z2ynFWkPei3sDFiPw3/vaxYJ29cRsqwyxZ7BTsTbIzRmtzMEVNYyfXz
         0gJMc1B9tK8BQ7i0iS6UOXXXhlKc7QSeyw0uuu6jpa4RgHaWThpqChzzv7ocNAiSpgoM
         NMaA==
X-Gm-Message-State: AOAM532yOZefWTZQ9RTiWd8VenehZXKlenqfE2Z7OmjHZLhPDcOoSLh9
        q4tvr2T7m0Y8hnAyAoqRb4rp4g==
X-Google-Smtp-Source: ABdhPJyYyY/I9sCo3RstG+oqSDx3Z55fChra8Y/tiA2UQ+4pfA1kyDm2nohjoWskkdTymeEFd2UeCA==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr5613554wrs.240.1603298558589;
        Wed, 21 Oct 2020 09:42:38 -0700 (PDT)
Received: from localhost.localdomain (58.164.185.81.rev.sfr.net. [81.185.164.58])
        by smtp.gmail.com with ESMTPSA id a3sm5321724wrh.94.2020.10.21.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:42:37 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 3/3] thermal: mtk_thermal: make device_reset optional
Date:   Wed, 21 Oct 2020 18:42:31 +0200
Message-Id: <20201021164231.3029956-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021164231.3029956-1-fparent@baylibre.com>
References: <20201021164231.3029956-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MT8516 does not support thermal reset. Use device_reset_optional
instead of device_reset.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/thermal/mtk_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0bd7aa564bc2..149c6d7fd5a0 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1052,7 +1052,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = device_reset(&pdev->dev);
+	ret = device_reset_optional(&pdev->dev);
 	if (ret)
 		return ret;
 
-- 
2.28.0

