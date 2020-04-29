Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB341BE955
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgD2U6o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:58:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44195 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgD2U6n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 16:58:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id a2so3117386oia.11;
        Wed, 29 Apr 2020 13:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCsNkb20GktgvT3EVSg7e0Ed7fNCWMt0hSKRdrZhvDs=;
        b=sMDRWWbDbki96lLdasxcFtsMdVea8AQZ6bdNo6DLYMSvfBhgJwR9Ne3CZPL1rZqwjH
         m5m5dx6jGHF/nrzAawvTBr7Lsk5eRk4gmvK/ge9UjGFvbDKnce+BFfelDOpJLaKsijti
         hT1nwm2w38U38tmWJpA1hqwVaEtdezMysyWaFQlGe7Z3ziIi3fn1d1bDd9OlUDDgJnIL
         KlkQMrQHjKEK4gid9YSL9KycehfKpztHzlknWF3Zg3B3ynXKMz3gQodbP4arYs162b2A
         ujsU8hcsWbhC7AxCtHZIYGu+vo+7Ua4uwkrIvnemA6obDZ1MSYxpeCmy6G34ROz3bBwI
         VIEA==
X-Gm-Message-State: AGi0PubN2YC+6OMu6e1Am6ANblwirBvDz9MKfDAvWI/1C9pAmgL9VOwR
        GiRUkztM0H+HzbMZ05x89Q==
X-Google-Smtp-Source: APiQypIMdJYtJ48k8tsFDlemNM2E4VC1cOVOCiiaXWDZFhkxrRyppPOhxj91cmywM1r4IIPVqeGw1w==
X-Received: by 2002:aca:2807:: with SMTP id 7mr123603oix.15.1588193922725;
        Wed, 29 Apr 2020 13:58:42 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z13sm653162oth.10.2020.04.29.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:58:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 10/16] mfd: vexpress-sysreg: Use devres API variants
Date:   Wed, 29 Apr 2020 15:58:19 -0500
Message-Id: <20200429205825.10604-11-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205825.10604-1-robh@kernel.org>
References: <20200429205825.10604-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the managed devm_gpiochip_add_data() and devm_mfd_add_devices()
instead of their unmanaged counterparts. With this, no .remove() hook is
needed for driver unbind.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/vexpress-sysreg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 90a4eda2ba2b..9fb37fa689e0 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -140,9 +140,9 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
 			NULL, NULL, NULL, NULL, 0);
 	mmc_gpio_chip->ngpio = 2;
-	gpiochip_add_data(mmc_gpio_chip, NULL);
+	devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
 
-	return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
 			vexpress_sysreg_cells,
 			ARRAY_SIZE(vexpress_sysreg_cells), mem, 0, NULL);
 }
-- 
2.20.1

