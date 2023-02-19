Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921DE69C0F2
	for <lists+linux-pm@lfdr.de>; Sun, 19 Feb 2023 15:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjBSOjE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Feb 2023 09:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjBSOib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Feb 2023 09:38:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55973E075
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2023 06:38:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o18so573301wrw.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Feb 2023 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+m/EU1gXSm6WJAQH5g7filkNUzVF/bX1PoRwHbFLko=;
        b=VfYYkZ5TT/u3ZWOI3DwDBtkU4ce4agJCXU3Arhh4MdTVQZjY/nmlEDLM5bgbB43OrI
         f55PvFEfRJw2pck5/OeJCBh3jAnEeYQdX9AaNdVF1uNPaBwQ3brAINO9GBynjOdxBX4l
         rv36igFYqV3LFOfu+SN44+YKg3vOEhwfvr96D6SD92d4YpRa07EH5NEyzPCXIMmQxJP6
         yAqu/7lVfUTXlixWDPB1FEnVJRvWli3KDCPziT32lNqwGF7JcygstYJ04zOxN+IDhfvR
         HcTdTlRCNxzrMqBa6uSlpjJ+lZJbzhke+SCHS5JoYdvUisdfG1QaaEEbUpzDGx3o1EWj
         OWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+m/EU1gXSm6WJAQH5g7filkNUzVF/bX1PoRwHbFLko=;
        b=UIuwdPn+tKQxuUx5w30BE5pkd3cfwbTZJSITViPh1LCSKH0PyVKuG6zSwrDAeu12MO
         faGNvDUxFlLpkp/0sXuN9L4zY9yrBxyBYUwGOvFU0sedMCZUqZUpg2iuvTpEOoChF6z7
         h41oitOzvgxBPUrhEMbaR2qaMvoKVDfWOiT6TMHfzfu6YVLGUXLGarRNucbZPACkPQuG
         HUX5O48psY2Y/YqE8+RVneMCRb5rPlL28IQ6FkFswmJjM2f+SsmfUtY4zKB1r55IPB4S
         9UAO+dyvLJ4Ht3pCkXxZNvCpShxh4UKo+8WYjOrsl2vczsQEVQOf8FKFso3EGpS4crqT
         XpUQ==
X-Gm-Message-State: AO0yUKWzsf6vCFDKLIx3o4ccW9GWAGLohTehphdCwRbnjnEo2MRHM4jG
        cqXNsCwXQSG/A7D6RJxG4gBYGQ==
X-Google-Smtp-Source: AK7set+ygN2Mpl3h7e/m7umK62T/ytCPFqn8ymKKd5FxSgCG78soAg03RmQLoXiEfpb0tlmYAnxaBg==
X-Received: by 2002:a5d:42d2:0:b0:2c5:7c26:c2cc with SMTP id t18-20020a5d42d2000000b002c57c26c2ccmr870419wrr.29.1676817483815;
        Sun, 19 Feb 2023 06:38:03 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:03 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 08/17] thermal/drivers/spear: Don't use tz->device but pdev->dev
Date:   Sun, 19 Feb 2023 15:36:48 +0100
Message-Id: <20230219143657.241542-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the spear associated device instead of the thermal zone device
which belongs to the thermal framework internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/spear_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 62cd9305eb9c..4598dedb82ec 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -137,7 +137,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spear_thermal);
 
-	dev_info(&spear_thermal->device, "Thermal Sensor Loaded at: 0x%p.\n",
+	dev_info(&pdev->dev, "Thermal Sensor Loaded at: 0x%p.\n",
 			stdev->thermal_base);
 
 	return 0;
-- 
2.34.1

