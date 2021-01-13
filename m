Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED842F49B1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 12:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbhAMLH3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 06:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbhAMLHY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 06:07:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EEBC0617A5;
        Wed, 13 Jan 2021 03:06:13 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id t16so2411408ejf.13;
        Wed, 13 Jan 2021 03:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YX793nA8glqiZM8wxhoAMRaUWaqDOXtDUvGcyOuuTxE=;
        b=Ll6IeaTNwpZeKWZ5djowMvUPvSB/AHBX6HhGi0/xdvCkE85dzSPUReZLVo6E5I/Q68
         P6kUwTlYWtK9atlcV4wWnFoRa3A9HEsWrT2HTMbfKTVcjJ8HSWrzguivGgapv/HZcKSd
         p57h/ZrTXtRR1jalsQMymvfgWCtgc1fdmQR2qrK9pRhvNSTEkQ1IljT3LaipfvLvASB7
         lfnZktXfKbrYwf1/ArxRYZGtNk+sJ6s1w0UBTEgtzj5vizmWKv6xYXRtpz4tP6oZtfkO
         poxxjCg+rrFlS0NGELnprX1c7o/L10HI9Z9nPsXXYvZ1KLWd1uDknjy90T0NrNJdiCC8
         GL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YX793nA8glqiZM8wxhoAMRaUWaqDOXtDUvGcyOuuTxE=;
        b=SXwY8cnRytWXIQoiJ5Hqb0j1iU0IhIH+zAKhdrxmR1kdADQbu8hXy0M5hkrqkK5lvB
         0jHlwUHmz0CJjW63uB6sHH0cfhbf/7xPrEJeg0ZWtS+HmE1tnnvWQ5g/q+imHowWyoOO
         Usa/OOvws0XY5jfIOqKWPhRkc+e4MICjyqqXziGdPoGmQ7WUse9QKn5MA1K8NPvzbUdC
         vhAApkLDkIcR4NWcVJwV5dgRVv6UWVCOcwkPLTJAt/Lxi5QeBQSpJZsuomhqInnDHiBt
         8NbEez/50zZnVr6lZHsGL1u9HPVAz7VS5q1Yetu2rGHJj9enAWClDu178MZLg451j7In
         kz2w==
X-Gm-Message-State: AOAM531JiKXkHlPoUH44jB9/EmpARDxHbfAFjZzUL5nI28Xg7XwXEspA
        odC/RGaOUP/r25OPOJ8CZ8I=
X-Google-Smtp-Source: ABdhPJwxPwEm3vlWdbgOjDf1es5xf7Ay8on23IVVrmyjyIiRw/cHKZXCV201CW82DzPJ68uLAysIjA==
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr1156985eju.305.1610535972494;
        Wed, 13 Jan 2021 03:06:12 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id zn8sm597343ejb.39.2021.01.13.03.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:06:11 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 7/7] MAINTAINERS: Add entry for ATC260x PMIC
Date:   Wed, 13 Jan 2021 13:05:57 +0200
Message-Id: <ca8a8d5c150d5d67cd62a67bd20287aa556a8763.1610534765.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
References: <cover.1610534765.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Add MAINTAINERS entry for ATC260x PMIC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[cristian: change binding doc file path, add file patterns for onkey and
           poweroff drivers, fix ordering, add myself as co-maintainer]
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v5:
 - None

Changes in v4:
 - None

Changes in v3:
 - Restored the authorship of the patch to Mani

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 844f05410509..e5e3429a6026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2892,6 +2892,18 @@ W:	http://www.openaoe.org/
 F:	Documentation/admin-guide/aoe/
 F:	drivers/block/aoe/
 
+ATC260X PMIC MFD DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+M:	Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+L:	linux-actions@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
+F:	drivers/input/misc/atc260x-onkey.c
+F:	drivers/mfd/atc260*
+F:	drivers/power/reset/atc260x-poweroff.c
+F:	drivers/regulator/atc260x-regulator.c
+F:	include/linux/mfd/atc260x/*
+
 ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
 S:	Maintained
-- 
2.30.0

