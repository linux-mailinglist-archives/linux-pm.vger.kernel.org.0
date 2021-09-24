Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098C04171BF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbhIXM0U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 08:26:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57328
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244453AbhIXM0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 08:26:19 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31B754019D
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632486286;
        bh=DkGkpzaVc54413YUBT4LyqWFFj4kahuTNwDNF7TcYfE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=rRODUHoxsdc2jlxzia+vCNo713SaLp8O7bvuv6kpX7aL/xTyKfdCdgc7qj/vDp596
         lxoZGXnh2KzeOrgOgrwaYpWtQBjnetqoRmw36xNhrbcmIOuT0G6ji15uF+mWVp9le1
         PRoQeLMoP4khk2wAClPZMuHg7idp8Wsc/A51FUMNaPAHV04QSqDYLeBSleCmPzfHBx
         NP7qQcgjU64vYHc8i6t9Yp6qV4DsPB1ERAnd414EU9ewO6FzpBytoM3FmI3Rt/ON52
         6z7V45yoy6WiVYc0p+A4esYMY4tzaN1P3TlXIHxxOMSZPnQM6s9hGDQ1fa5Q5iS6TG
         7tJAlFHMb3Ocw==
Received: by mail-wr1-f71.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso7910995wrw.22
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 05:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DkGkpzaVc54413YUBT4LyqWFFj4kahuTNwDNF7TcYfE=;
        b=rxXfiR0clE+YbLdJk2ICRzm+8nE1d/L5NoBhmUgKI6f3/HQIM52o1vB0ecoCkqsgvE
         wrQBl+QSsTmTMi419JErWmJEJLWCDf873ci3jyKC/QoAD1OoAV9UlcqvotLoEBZvkTJ3
         L02q8EvEgLepzvyccvbeGTc2pJnk7qjieUZ42IrgfrIzmuauPMdHXzxLp86cndLdU1Dq
         uTpm0fc2wjHyOUKU0BWdo8nYMj3HHGyDnUkVCczlrOWxv15jbiC99iSgCZhtYcRQ4HjX
         YXGYTbPujDpoZiNWIRgG8+o2cILMt3onNJ+C5WBjFRiTWJc3sZ/dcdTfasSHiR4FW677
         YSNw==
X-Gm-Message-State: AOAM532QrD7f/WeUGahdOd1wc2wupWkYjaHUzwArU4Z8tFu4SVeZ7yMw
        j8deyX78riM+a+nvdTTywBZrPrQvkn7NE6xKAXEJY7kYtBtQCnOdVs5HaC3utkbr16IWFUX3AYD
        LTfWMWQvljQ9KV1x8pDMEFDO9yf6jIN3O587R
X-Received: by 2002:adf:d23a:: with SMTP id k26mr2094774wrh.215.1632486285831;
        Fri, 24 Sep 2021 05:24:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEB0qa3TAnqaeE56H4VDw3cxmOzfMwfE8tlyEFcfLPhTr4L4dkNuPDnddVRADKhD2AML7hMw==
X-Received: by 2002:adf:d23a:: with SMTP id k26mr2094762wrh.215.1632486285653;
        Fri, 24 Sep 2021 05:24:45 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id k18sm7865957wrh.68.2021.09.24.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:24:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: max17040: extend help/description
Date:   Fri, 24 Sep 2021 14:24:07 +0200
Message-Id: <20210924122408.101323-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reorganize the Kconfig driver description and mention all supported
models.  This helps when choosing drivers for given system.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/Kconfig | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index fcc7534edcb2..6e4201922f59 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -366,18 +366,20 @@ config AXP288_FUEL_GAUGE
 	  over/under temperature.
 
 config BATTERY_MAX17040
-	tristate "Maxim MAX17040 Fuel Gauge"
+	tristate "Maxim MAX17040/17041/17043 family Fuel Gauge"
 	depends on I2C
 	select REGMAP_I2C
 	help
-	  Maxim models with ModelGauge are fuel-gauge systems for lithium-ion
-	  (Li+) batteries in handheld and portable equipment, including
-	  max17040, max17041, max17043, max17044, max17048, max17049, max17058,
-	  max17059. It is also included in some batteries like max77836.
+	  Driver supports Maxim fuel-gauge systems for lithium-ion (Li+)
+	  batteries used mainly in handheld and portable equipment.
+	  Supported devices: max17040, max17041, max17043, max17044, max17048,
+	  max17049, max17058, max17059, max77836.
 
 	  Driver supports reporting SOC (State of Charge, i.e capacity),
 	  voltage and configurable low-SOC wakeup interrupt.
 
+	  Driver can be build as a module (max17040_battery).
+
 config BATTERY_MAX17042
 	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
 	depends on I2C
-- 
2.30.2

