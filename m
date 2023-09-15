Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CEF7A1A62
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjIOJWD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjIOJVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 05:21:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A51FE1
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:21:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so30566691fa.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769688; x=1695374488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHEtnEQv2A2ReqGymUlGz3D//oT7Ku2G1Pe4mdOxqdo=;
        b=rXeqFgqtZ1prGJynVHnLiYul3PCLdeCYfhz517PPzNtxLPom8L3xFI2Et6PD8M/CX5
         y8OF2SxmiWQaQ96aQAsdLPHexlQ4v8P9RzMZJgkR4iP+kyQLAA1VnihbmHpXydLBiBk+
         92P/6i2q5UjWZRAaaV+gvlkUCjeipiFBf39N9dmTjiKRZrYStTvLAxB7Ee4WCLO0/9KK
         /7S/BAmW7TaLEzB5Lpx71Df2kyLxhKpFCS3tllSrUQ/M6bmtg4ws1bEoQcyM39KSlTb9
         M2yW1HdmEbWeJfCRIVluZBreugARBv/aJRjH/xPcLr6u6aoZgenjshAaYeN8bPvdvWu+
         A6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769688; x=1695374488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHEtnEQv2A2ReqGymUlGz3D//oT7Ku2G1Pe4mdOxqdo=;
        b=YS1+k6AseXt8wwcHCCmd46jZJFTt+sxr2mqP8mprx73zM6GBP6CFhSmYYYHzVMJFJZ
         YYEReflJK9aGL0NDugPsNjbJ9z6wOw/NZMqRHiCADQVM8Cog74vGioxkAKOnh/HD574F
         ovDBH7br/sJ6lNeKcrT/isKw3xt8rvYfIijuDCt2G67+EdfxuAwHnc+uARyjCq5bmaE+
         ZI/gl2AUDx5XGm1ZfdRMswAZtprIQ4QDkj3XHMQOGEs6ymGDkyP8dHLiMGsnGMHDLMvs
         Wl6l3S32jmRPUT5Yc/hKaDhY0zfYHQAoU3kzSk22VWVi1bLqwtgV1hA73Y+YZAZBsOnE
         vrKA==
X-Gm-Message-State: AOJu0YwkuS6zGBqRC09mxeTrrHwNVZ+5ga0/BonTUo/u0SiTIstYybid
        P13pniK9hQnSfK90+xiBH7s0MUjgyfWCLL/GiAe55A==
X-Google-Smtp-Source: AGHT+IFK61Er9cAcjOdJ5f7iHl2FE/MjGgnLPUym9+O2jTbIqzOzp8XbomK6ZbZehZ/PX8+bbXKy5w==
X-Received: by 2002:a2e:3e0e:0:b0:2b6:bc30:7254 with SMTP id l14-20020a2e3e0e000000b002b6bc307254mr981025lja.13.1694769688005;
        Fri, 15 Sep 2023 02:21:28 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 13/17] pmdomain: starfive: Move Kconfig file to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:59 +0200
Message-Id: <20230915092003.658361-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig belongs closer to the corresponding implementation, hence let's
move it from the soc subsystem to the pmdomain subsystem.

Cc: Walker Chen <walker.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>
Acked-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                | 3 +--
 drivers/pmdomain/Kconfig                   | 1 +
 drivers/{soc => pmdomain}/starfive/Kconfig | 0
 drivers/soc/Kconfig                        | 1 -
 4 files changed, 2 insertions(+), 3 deletions(-)
 rename drivers/{soc => pmdomain}/starfive/Kconfig (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b491ebcf790..40744fefed3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20515,7 +20515,7 @@ M:	Walker Chen <walker.chen@starfivetech.com>
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
-F:	drivers/pmdomain/starfive/jh71xx-pmu.c
+F:	drivers/pmdomain/starfive/
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
 STARFIVE SOC DRIVERS
@@ -20523,7 +20523,6 @@ M:	Conor Dooley <conor@kernel.org>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/soc/starfive/
-F:	drivers/soc/starfive/
 
 STARFIVE TRNG DRIVER
 M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 08f8a3aa9805..2286c36076db 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -12,5 +12,6 @@ source "drivers/pmdomain/renesas/Kconfig"
 source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
+source "drivers/pmdomain/starfive/Kconfig"
 
 endmenu
diff --git a/drivers/soc/starfive/Kconfig b/drivers/pmdomain/starfive/Kconfig
similarity index 100%
rename from drivers/soc/starfive/Kconfig
rename to drivers/pmdomain/starfive/Kconfig
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 8b46da40f107..10a9ff84ff41 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -23,7 +23,6 @@ source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/sifive/Kconfig"
-source "drivers/soc/starfive/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
-- 
2.34.1

