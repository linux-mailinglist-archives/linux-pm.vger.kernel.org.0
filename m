Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF11F3C0A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgFINSK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgFINOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:14:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C118C03E97C;
        Tue,  9 Jun 2020 06:14:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so24969602ljh.7;
        Tue, 09 Jun 2020 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQ3h8Ane+DGwk19e9LoUjeH+6kuRPH+cvxzXdTjxJoI=;
        b=sr9smtd/X2TAtj+jB9Xt0hR75GzF+z9QEMDVwFu/VhYMicUKng0kG80Vs+otUE3E6e
         OT8MlEj7ng0+A/YXa3upxyT1+xitxML7CL1pmQ6sFiJsHTRufjHjBdSWzIIJupI/2LwM
         iAcSajC9XDB5SXxSpHwLyK9wuRp8kIMiL0V3TP7aCn4UZrMyagGowSfjZtIeX+5+T3Em
         CgFnf5kKqegdAD1c4a9gT62gxmFaVxuInAEi52qng/n86OURvvDTdan7p6rHgNCmhXyk
         y9gZJUiePCLkW1ueC+0ds06ZdHKlOImsS0Hht/TYCkie+SgGDM7IBDTY3WFlIBoGLGjJ
         hKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQ3h8Ane+DGwk19e9LoUjeH+6kuRPH+cvxzXdTjxJoI=;
        b=fy+fpTYYS02QEzNdq+TSyYYG5tAkRKzUZSwCsF/S3vBhxE4cfLahCamnHxa4Rnc30H
         i9JWzEJjE7xd4SDS3FuTBQ2TfIzEHE1GGh7ubB7tSp6FbRQi3ecweEayXMjYvSvAISA/
         vSMJuVfA6G5FnCfI5ibS+KMiEK9/Ci+IphADehSkzBMkYm/9wMWgaPE1w32O6jhEJ9rH
         3vLFjaH5NF1ZdkFQlGazq4yB6isGuKJTSSDxnWLZMhqvN4BeHSd7Tg8pJwlVk8wH6JGW
         jCegE5/RMDfxADwungyXO1LzyslBUZsWS00f5xFsj07mcl9RRt4OGdv08OitquHS0nCM
         rgKg==
X-Gm-Message-State: AOAM530212iPhbYUdPG0QJfD4Axw0gMrb/cMdmBQ/sUcCG2zZDkXyu/Q
        f86xpyPL2fyfYJ1WH6mPWuw=
X-Google-Smtp-Source: ABdhPJysLy/ytBXckY4POgNUQGKQ4QlbcnhjoNkfFQXjUOYkxP+flvZczjNtCZMYL6RWbQxYJYhw5Q==
X-Received: by 2002:a2e:9c1:: with SMTP id 184mr14667970ljj.241.1591708473574;
        Tue, 09 Jun 2020 06:14:33 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:33 -0700 (PDT)
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
Subject: [PATCH v4 07/37] memory: tegra124-emc: Use devm_platform_ioremap_resource
Date:   Tue,  9 Jun 2020 16:13:34 +0300
Message-Id: <20200609131404.17523-8-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Utilize that relatively new helper which makes code a bit cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 98d98d09b00c..6d2897d4dca9 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1193,7 +1193,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	struct platform_device *mc;
 	struct device_node *np;
 	struct tegra_emc *emc;
-	struct resource *res;
 	u32 ram_code;
 	int err;
 
@@ -1203,8 +1202,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	emc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	emc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(emc->regs))
 		return PTR_ERR(emc->regs);
 
-- 
2.26.0

