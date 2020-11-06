Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E892A9444
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgKFK0b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgKFK0Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:26:25 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1FC0613CF;
        Fri,  6 Nov 2020 02:26:24 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so896001pfq.11;
        Fri, 06 Nov 2020 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5gqHPPPCIFok2RSu8jyV1TQKDB5fyzeiP+3iOcRs34A=;
        b=b3iOL2+P+eQTriuEfBioqvDrsiSo9BhwDRznYWp31cFV8f9tiWfAvonLgGSRHrunIY
         cp3Y99y39i/tBfY6nOYhJfhULqaL3cs8rEnaIB9VMWQG0+pfUnWA49j4eVgPWHGocURc
         YRudyfBLiYIBJvxJ6PnI862aShv3JSj5jbQxREdS9zMlgTr/y1mRNsDuy2CitXhRdDMX
         iJnRwJpJhbA6drwpKNQA1hIe0yPluAMDhvS/WqCIszYap+ZsXsGx0YYHzMb9ne00xWcs
         IYdbgnxDZKgQW9LCEufpuTgQ/Rs0TqY4JVkkIc3/ts4WwJon9GCXIdzOuReYaNxV59pY
         PrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5gqHPPPCIFok2RSu8jyV1TQKDB5fyzeiP+3iOcRs34A=;
        b=jJoWlYagD7jw9vJHYJBU43gcRvegOazAkS9GuCBIVtkH2Rpkh/lQigEKlwgV5pW041
         ykmYmkzEvUL4yZHpqReI8wikPbGQp2D55T35+E5OC5gb9AdTzt1tBskkQee1LbTBUwEC
         YzRzpKSw9DRQp3sKTvrEcst/JuGLw1kzBe0mHH5IB8hswc9pzWqPuUIQKKzDKyVY4Mxc
         aN9Y3cwtOxwYpgW2TDjqj5WwZiVjKjNpFf9GJdagpiV//aDFIUaJbPYlytsb7kW2zE5i
         4Cl1AmE4tig0XMzbwiWe19QDYfEqGBSK2CjI6WJ68292iJtXDVAzkiJlp39utfn7SC9A
         qILw==
X-Gm-Message-State: AOAM532g69g3zQ8p0OeqsbpJD6lXRTmdr3mCumMna3zhBKQ+KU+1LOUW
        fe58tuhgidG/Da+EXmRdhF8=
X-Google-Smtp-Source: ABdhPJzgkDd3+la268oMRdW8hfGdLHrD2+RUBL2xH+FGuoyR8aURjd2Fi9K3FJ5ZZ0O+DN9lryYESw==
X-Received: by 2002:a62:17c8:0:b029:18b:5a97:a8d1 with SMTP id 191-20020a6217c80000b029018b5a97a8d1mr1255723pfx.15.1604658384607;
        Fri, 06 Nov 2020 02:26:24 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id g3sm1260633pgl.55.2020.11.06.02.26.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:26:24 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 11/11] mfd: mt6360: Remove MT6360 regulator of_compatible attribute
Date:   Fri,  6 Nov 2020 17:53:52 +0800
Message-Id: <1604656432-10215-12-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Remove MT6360 regulator of_compatible attribute because
MFD device should just instantiate the platform device.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 4bcfa7f..539ab43 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -340,7 +340,7 @@ static const struct mfd_cell mt6360_devs[] = {
 	OF_MFD_CELL("mt6360-led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360-led"),
 	OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
-		    NULL, 0, 0, "mediatek,mt6360-regulator"),
+		    NULL, 0, 0, NULL),
 	OF_MFD_CELL("mt6360-tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
-- 
2.7.4

