Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2669E7A023D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjINLRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjINLRB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 07:17:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1E91FC9
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:16:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso13365891fa.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690215; x=1695295015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/G1B8RoYbQaDFpfisBrFB3z+4poKkBaELSKoZJGIn6w=;
        b=kDPjxEbUjfBYNY+SmO94i+Teo8670DzQFrQm8VVDAzyYEYuG49ZNt2ws4wn8+X3KaC
         /qQhlTtVGzdTnCpSZCgIXBzldv8cszJAnODIalYsxdBNMwJQoNGgJaG+xxNOcoafBap1
         P4TOBgI/kR9uRzmmu0XDsp/oogRXFMnc6/gAydh3W3AFl8IskJAB8SC1UpQg5qQbs3Kr
         PuoJOScm6IXlEVyLDdOAvkMqxEzusP9HoNaBK8/1MO2aVGR3NgCYLt74xHCp0A3mqqOt
         3qsHnUCfBDHXeSXYOPmr9yFPDuBYCk2PnPlsszt6F25nIIXdXjwnAywgd/waj+lg+zwK
         fISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690215; x=1695295015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/G1B8RoYbQaDFpfisBrFB3z+4poKkBaELSKoZJGIn6w=;
        b=Rq1gWzRK/8xSwgXC3q9kVIGmIbpCWgvZEgghAhImgiPaid3PoGC+WIxmsdIq10KVzW
         Me+jFOC3kQPr6YAdqFfTZ5g+IKUBTGOAP8UVMZp/n7e97dvSAnckWWCDXI3CP8oEOTam
         Z9eMTwpe3zqD6Qu9Q0AU2jmXEI+wcg37zaMmuTCVDEK/kmmEosU4JQ39oOblJfD3Vpfl
         QK/WL7teasj+bzFjhGutcitI3TJqAK6P1nRYWqV8im+XAJDs0qYTcWcVpUNkh0T6mmDO
         SKZjeyAXXpzYsLhKr32Zh01L6hMm9Ou/P9Vqad6lWw3zk19ih6aCdQ0GtcqUYu96vzDb
         o0ag==
X-Gm-Message-State: AOJu0YwcTNDzBTqQZ+o56cVzrhL7WeCKJMmstFowAqOV4cDBVzbjhxnk
        IJG8EmGC3tEzbKiAIAnO9mfqLQ==
X-Google-Smtp-Source: AGHT+IHxEMstyuzhFSypoWAtvEF01jbwfbhJStwXMTx9dgfqeYevn8iU1RhTH/B+foBI07WzfihwHw==
X-Received: by 2002:a05:6512:70f:b0:500:b96a:6f59 with SMTP id b15-20020a056512070f00b00500b96a6f59mr3746522lfs.56.1694690215249;
        Thu, 14 Sep 2023 04:16:55 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g15-20020a19ee0f000000b004ff7250fa02sm234277lfb.179.2023.09.14.04.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:16:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org
Subject: [PATCH 02/17] pmdomain: actions: Move Kconfig file to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:16:50 +0200
Message-Id: <20230914111650.586477-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig belongs closer to the corresponding implementation, hence let's
move it from the soc subsystem to the pmdomain subsystem.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: <linux-actions@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                               | 2 +-
 drivers/pmdomain/Kconfig                  | 2 ++
 drivers/{soc => pmdomain}/actions/Kconfig | 0
 drivers/soc/Kconfig                       | 1 -
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename drivers/{soc => pmdomain}/actions/Kconfig (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1c34484c9b2..6b491ebcf790 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1788,7 +1788,7 @@ F:	drivers/irqchip/irq-owl-sirq.c
 F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/net/ethernet/actions/
 F:	drivers/pinctrl/actions/*
-F:	drivers/soc/actions/
+F:	drivers/pmdomain/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/dt-bindings/reset/actions,*
 F:	include/linux/soc/actions/
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index c32a76b51840..8acb10bcdec9 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Power Domains Support"
 
+source "drivers/pmdomain/actions/Kconfig"
+
 endmenu
diff --git a/drivers/soc/actions/Kconfig b/drivers/pmdomain/actions/Kconfig
similarity index 100%
rename from drivers/soc/actions/Kconfig
rename to drivers/pmdomain/actions/Kconfig
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index d21e75d69294..8b46da40f107 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "SOC (System On Chip) specific Drivers"
 
-source "drivers/soc/actions/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/apple/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
-- 
2.34.1

