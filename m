Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFBE2E72B6
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 18:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgL2Rcs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 12:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgL2Rcr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 12:32:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39EC06179E;
        Tue, 29 Dec 2020 09:31:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id w1so18953626ejf.11;
        Tue, 29 Dec 2020 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O4z4PPAfMQG+koE9MA8XVXddPnXre2EJoT6yNQ4Wyrk=;
        b=YhrRGrZ8pXHNgnzpyr1lBUplvsIDc5amXJ45qiaepAkpnqWq5xb2oAaoposiAG3lFw
         x1QF1Ts9sp+4pw5LAEwAdnYL4DQ6rRa4tLEdKksVH8ul4QV0OPcEWrzj1T5qQZR2hlik
         Zzg7IkEgGZ2XoGUsSVNg2RGnygy3OITzZg9Y54mSkLi0JnHPO0Lx4744QrwzzsPgnUlc
         5g1eCERWOnhooAumqxkqGPAlcikR/lFdeMecMjRa7Vwxux+edX2vKGvGBe/DxuDS1xTg
         +eyqgXReLtyDZZIIW6CFjFausKEUsY35p0AHM9yxZucw4R93eZM7EqtzAsDnjJPc6tVW
         8o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O4z4PPAfMQG+koE9MA8XVXddPnXre2EJoT6yNQ4Wyrk=;
        b=lOYYTc6nRQevFLS2I4eT0ha4JekEtwBqZNdXJf6+JrDlqjo4xqa99ehx1wXQkVzCQJ
         5Up7GFYVarwm2gGr800A/+Lfn/9MDIcwAZAWFFrl9BBNKwIPDhVQu8+2BZ4aBi5Y9aZL
         ckvYZOGt77ZxGAnABTqidXaQAza3xGSq0s/CL1dQxEbBrXa1fqEu6N+9KXtGYM9Vx/om
         FYzjyE+r09NBFMlOA+lzeDsxQhGbwS7NN2/ed2sP1EyYtDtIhJm4zgXO+j3J0vKywMNB
         cSz39z2+cgZ6vl7jgCg2wer+g8xtnGQusWprVtHtVbVB6UrpwMpUo9Wg4vXbeKqeyJib
         fApw==
X-Gm-Message-State: AOAM532WVffKFuzoMhKdHeDeNfL99LvAgU4eqCK6qsD5W/U5XH/LhDIN
        46I8wDkAJ36zu8horZLYyGQ=
X-Google-Smtp-Source: ABdhPJz2YOtH94yzVysMbDLaw1EUZL6X9gL+49yWlXtDdMnq2CMPuQKa3v9+ZBBkN5FNLsnurFH+lA==
X-Received: by 2002:a17:906:5043:: with SMTP id e3mr6757205ejk.260.1609263098128;
        Tue, 29 Dec 2020 09:31:38 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id q25sm37385362eds.85.2020.12.29.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:31:37 -0800 (PST)
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
Subject: [PATCH v4 7/7] MAINTAINERS: Add entry for ATC260x PMIC
Date:   Tue, 29 Dec 2020 19:31:22 +0200
Message-Id: <8b592d0b6d9ae96117ac9ff3b959be6f49b2e317.1609258905.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
References: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
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
Changes in v4:
 - None

Changes in v3:
 - Restored the authorship of the patch to Mani

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74a6eaae7b31..8bbf7d9b8f23 100644
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

