Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E328303EA5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbhAZN0F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 08:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391751AbhAZJ5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 04:57:24 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622BC06178B;
        Tue, 26 Jan 2021 01:56:13 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gx5so22075689ejb.7;
        Tue, 26 Jan 2021 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bLs6/jhlVV266f2Dse0B5k3M255RLfRErwO519Pwyo=;
        b=CdSm0lR7j0E1W7kotMmRm0m30oDKrvEDpA/vsUBb9Vjd/rh6AcBrDfg9SRTIOgAbDE
         2tGvrLbIwu/ukZX3Y3nM/xf7/0Ozv7wP3W2D+oS8wku+WZBI1l34wGHRxGU3/Djdat4Y
         G+JFBEkqRhAhFBgln/TWdZ120yTsQzXs4BILu1WwD52gL1fjWlkBmf5cgsiBLw4CjbWz
         KFzPSMNp0c/O73bQ31p94j8USDYNkwdyy3VjlUV0EE//U9h3sDnsROtSP/6li6wHcyrd
         vcvGgp/zxxzkWBGEAgpJpf40nQdnGvz7is2NJf//xwqxK7jG4C48ykLhsp64Yi+Gq2kX
         +VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bLs6/jhlVV266f2Dse0B5k3M255RLfRErwO519Pwyo=;
        b=J3lbEkyktrHDzYqxy98QQsB4TDy7N20KaLziTk7okO6HI5twgTThXtlzygSp1Ws7no
         ZSHyESJIaKL46dWcmDuI9PyOKqYQc905+GOWHmsv4cVLufMINiHjP3djmaZ//q1YRY6f
         yuC5CDHFO17+AKBWkBPxIF++WpXvmh3BaTeCuTcx0sE94cVFSXIEXHq0J3LxLCFe1PZ2
         jjmK8LiVLBKx5Id66T6pq/NKNVBPkDUskUJrg5VhF3brkQtRSKjJ1mjx3tv9uktopPsN
         BclSDaUq7dg/ZwxzXjws63mycYv1OYf9jsMtumPdU5kSYHaRrmrYBbV87or08ZnYLOOu
         wsFA==
X-Gm-Message-State: AOAM533YkrtfePZ+TOb37pkN4OBjqQQ6pXK5RfdDoQmWh69QEnyQ9KKp
        16/xUpdR/VujjvkSxxV1ecI=
X-Google-Smtp-Source: ABdhPJzQpRUkBDMGdAezh86+55sGvFZIpjRCP7vjBNcuPoj6XDxSgEIQ2V592B9En+BBUiNt0K2hyQ==
X-Received: by 2002:a17:906:a082:: with SMTP id q2mr2919021ejy.483.1611654972084;
        Tue, 26 Jan 2021 01:56:12 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id h12sm11648310edb.16.2021.01.26.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:56:11 -0800 (PST)
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
Subject: [PATCH v7 5/5] MAINTAINERS: Add entry for ATC260x PMIC
Date:   Tue, 26 Jan 2021 11:56:01 +0200
Message-Id: <715ac9a4a87dd8f85c57f9e65abfca9769e9e21c.1611653995.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
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
Changes in v7:
 - None

Changes in v6:
 - None

Changes in v5:
 - None

Changes in v4:
 - None

Changes in v3:
 - Restored the authorship of the patch to Mani

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfb47554b951..32c16d13fe28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2891,6 +2891,18 @@ W:	http://www.openaoe.org/
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

