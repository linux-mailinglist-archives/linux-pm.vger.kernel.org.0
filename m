Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729377C0DA
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfGaMO1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 08:14:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40583 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfGaMOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 08:14:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so59629993wmj.5
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dy6tDwrDZyQwCbBNtI3rvHog6QhVWeb1hPHlqbhReg=;
        b=kzR+HTfyhqOF5B0psynwHitDS5M5lgyvesQmRWyJVlV9jqMOaUnE+AVFRXp1M4H1Yu
         xn4FMMwB3LiyZTWnm4rZ0nOG2r4OZqBi18gRFUqxrC9weYcDY1E0FavjRHhW5pTtUjuu
         gxUa5C1VfZtk9MXIbl82EBNGyUinA5CXVo/4O4u9V33NHCjscxUt0eSYo2B6krLA3bk1
         vKc85SttiGAvhvj2dTxKNq2vUcVJzUvA8dKoZlBzDKrMIJZL7WArbqHaQSRLTi/lwxCi
         m7RAxchFhPRZBW/pEkGuLftOLhfeEP3DBP283XWvwLO7iAb1GllGbdMntPm9eOZWUx1o
         hrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dy6tDwrDZyQwCbBNtI3rvHog6QhVWeb1hPHlqbhReg=;
        b=rgEYhyAJ61risb5ovloCejwDGoMgtnfn6WT5V4HfM/ppJSPxzZ8Q0Nag8/5dcIyqik
         yDuKpI70dZvl6NVCdOFM7QDlwG0L3WWSOk5Fh7BhZTblSVMfFUDPalTaFNooAB2B+8or
         bJxD9BitYWSbsDL5ckXxU1BU4rRhmOKtKehgRrgrksuKwwh1r4av4eujfcqFmG9Z60gY
         aiAJCV/F2WrHXyzoziNsCQ19J8wVQmxqHQs+KhOQq7AgFtnH/B1bVB68oJ8aGBBrE8sT
         NeLxa2Rvad3S5Re3cuPZT3IOHxsSPP9UmUv3Ks0b66KwEhZYpWpnrvQA3bBiyoshZlsY
         pReg==
X-Gm-Message-State: APjAAAU/desy+XWB8PuaoglZUNzxwljLZwiUKl23Ti1zCxwFM4kBTauG
        ykexDjg3F+8BdBCQ51YA25v1xQ==
X-Google-Smtp-Source: APXvYqwiXLefKrRh2int86J1ClmPTnKB6ds2eofOnlZxzgE2XsT6NJ7qlB851jUxzNz+12Fsd6Bh7w==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr114572270wma.90.1564575259044;
        Wed, 31 Jul 2019 05:14:19 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a64sm3613713wmf.1.2019.07.31.05.14.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:14:18 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Wed, 31 Jul 2019 14:14:09 +0200
Message-Id: <20190731121409.17285-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731121409.17285-1-glaroque@baylibre.com>
References: <20190731121409.17285-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add myself as maintainer for Amlogic Thermal driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2b12f75c37..299f27d11058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15910,6 +15910,15 @@ F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	drivers/thermal/cpu_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL DRIVER FOR AMLOGIC SOCS
+M:	Guillaume La Roque <glaroque@baylibre.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/thermal/amlogic_thermal.c
+F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
2.17.1

