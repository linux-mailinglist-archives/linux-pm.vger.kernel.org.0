Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA142FD8AD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 19:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbhATSp0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 13:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404644AbhATSZz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 13:25:55 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C166DC061786;
        Wed, 20 Jan 2021 10:23:50 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a10so18242286ejg.10;
        Wed, 20 Jan 2021 10:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQ5eYd2yXDaG2x8OSmjOsHYCV/m/dRWpKbP4QFtdxVI=;
        b=Nf+cwFcpqBozWZMA63vXzqCZIktkqS/hvWPkFMKkQmL5DeD0ORsBwuagCCyMnplHq0
         8IxcHH6lvv5T0VNYfhxJEAMb+zdYJigIr3GVOrfaerhFaZtfL3UnFogvWSBP3Ho4eeO5
         Mvj+rGwSwkk3RHT683UZkqYf0N7J5XXcwA7qzdwBaggFWC+dd/K7jcHpkOYJ7VaWfyZx
         05GatbBPqODPP0E+cFUce9SJpCdFyhGl+yL7ImGmRbqXnpd2Bm4vfmvoRslYGqcq/ZCU
         Tu3Vc+lQRzVWElV0+BSO0Va0AOPoGewKFwyymak9xHeL+wTgDq2w9e17VzknneYYESb+
         GSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQ5eYd2yXDaG2x8OSmjOsHYCV/m/dRWpKbP4QFtdxVI=;
        b=jp3VRA5stTXsr1FfiRkeHw5/HVJiQIj7/yHQx49NrGGtX836e5HiYExVsyfEWJAtNx
         W2XLPFkWren2zjOZFZtIh2AFmbk3d7TX5as7ATkPDUaGurK6HwZwBorSbMRoyTDkV8fy
         LXHgf4SlImGSTAKsTqWicRA0IHOb1DuwPv+xzFqNwR/NpPrizsFBPIK1SzAAmEgQ+Mnx
         DvoRVeKlw6RNt+4sONSR/SbhY/GuZz+Ewfs1j80StTTRvFOrNzFITm70p79Ig34EQYOS
         6C2pZq3pJq6+9j3mxetbU8u6Av/1zL+idVE4KrZQA3gF5wB3EttJNylV+EXN41ZMvq8U
         mWTA==
X-Gm-Message-State: AOAM530npcPtXRysuumVlt/YNfLLj+i1R3HAgovF+FYutzF4xuxfSwPv
        uULHebymFZCFeF2bcz1du/Q=
X-Google-Smtp-Source: ABdhPJxMs0qf/WL4cqJLAjc99PZlF8qlVeqBHsQfxIq0JF5Pb3ly96KEIrEv7REzfy9lEumw9JEiMg==
X-Received: by 2002:a17:907:3fa6:: with SMTP id hr38mr7106335ejc.24.1611167029531;
        Wed, 20 Jan 2021 10:23:49 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id hr31sm1158332ejc.125.2021.01.20.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:23:48 -0800 (PST)
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
Subject: [PATCH v6 7/7] MAINTAINERS: Add entry for ATC260x PMIC
Date:   Wed, 20 Jan 2021 20:23:32 +0200
Message-Id: <76d4e3e09530dc65f4abafa19af743e9b6e351f5.1611165200.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
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

