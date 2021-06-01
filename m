Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE939746C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhFANhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 09:37:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44681 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFANhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 09:37:50 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo4Yx-0005KA-V7
        for linux-pm@vger.kernel.org; Tue, 01 Jun 2021 13:36:08 +0000
Received: by mail-ej1-f69.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso3345291ejo.13
        for <linux-pm@vger.kernel.org>; Tue, 01 Jun 2021 06:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdrwxPjOVbLLEQao+8w5TJgGCv7vD4c/43FIdShoDJs=;
        b=rMYNAhadkCsXZIIJT2yq8++HMgSRSgPdbfqFdbtVTH4oebqFPehgY+nmD/z3pyd+8z
         h2wZmEzULw/oonMxAUxT2vsFiFl7GytIR/B3yA7da2HSsdhrRUFWjdPT1hmk+nOt2qiK
         vGrgTWis7qFf4nYsMtEK8OML62R8jjLddYd3xFUKQZYENDc7cOAlA5Yjrpl0CT5VNWWJ
         IZgICMl4rLkamvv5tgg73BLPZ0uwA9hu1bmfq3aiKX0LKHoFhuQAoAHSPvviJmYwj5pr
         569pglPguejiiXXUSxDl5zvW8sO2A5z9aOnmWpmDauNnNtxCK1DNHNRKIDypdvqBh/F5
         /XaA==
X-Gm-Message-State: AOAM532iw/HZ0jwSoUBIlPZ/kIxHzO7NahmAi1qzkjfP0iJWrITsMqde
        krUvPcKHhoYyN2tyV/ezykUaoqtXvgPZASGI0axPqLCyqyM408l1iIjK8bmw16MXVRc2HHVB6mu
        8jCXC4c/JbzyWt6ZTCLrdHSOFIPnUeHXX4gpG
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr32131907edc.368.1622554567522;
        Tue, 01 Jun 2021 06:36:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWLv5THL6TSFbxkXvKLAIgNMaFXdmlMfxUSudPIpijlMGKPlOSS/zojznQMGRH1X2l7WAbCw==
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr32131894edc.368.1622554567412;
        Tue, 01 Jun 2021 06:36:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id p5sm7210941ejm.115.2021.06.01.06.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:36:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] MAINTAINERS: power: supply: cover also header files
Date:   Tue,  1 Jun 2021 15:36:00 +0200
Message-Id: <20210601133600.285452-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601133600.285452-1-krzysztof.kozlowski@canonical.com>
References: <20210601133600.285452-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Only one header (smartreflex.h) in include/linux/power/ is not related
to battery or charger drivers.  All others should be covered by power
supply maintainers entry so patches to them will reach respective people
and lists.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 365f873d0077..2f9961310c80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14744,6 +14744,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 F:	Documentation/ABI/testing/sysfs-class-power
 F:	Documentation/devicetree/bindings/power/supply/
 F:	drivers/power/supply/
+F:	include/linux/power/
 F:	include/linux/power_supply.h
 
 POWERNV OPERATOR PANEL LCD DISPLAY DRIVER
-- 
2.27.0

