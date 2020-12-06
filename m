Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D12D0035
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 02:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgLFB2h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 20:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgLFB2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 20:28:36 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674CC061A54;
        Sat,  5 Dec 2020 17:27:24 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so14328809ejb.3;
        Sat, 05 Dec 2020 17:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cs/lUEeChxzyNHNrjCnxi1B73QI8d98MA/xB+ouymeE=;
        b=H+nlZAgCu9tJBGIOv5j6l5Gj04IQn7sdYQf3lT5HvyR7ds1qspc7K120gylACsPRuG
         lHE5ps/LcnkCQWZlFtiqoEmoCnWc7ELiDlZLd/78ncqVzTAZ6YAkM3TYj/lP3VqKPtdU
         GVERQATZ3wOV6QqCa0ELxHodI0qEBonBM24fPTA1vMCNaypeq8BdEArP1Omi5u/5H3Km
         1AGVLlxEIf5H1NDklzPLvLnog6GfVQqc6egNdyX2Qqgw1VOg70gcujEAOhed9/cBgX6y
         184SaPAIPyv9DsHN4ggZkQBW99aFPJf532h4cHvuM+BCj06ASsP/cEoyM/T69THgkXuv
         OxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cs/lUEeChxzyNHNrjCnxi1B73QI8d98MA/xB+ouymeE=;
        b=OFjfgqz9eZ+YFgPv//DzucsTOH62+Y4DTaJzeL3NNvqaXkULrd9mcmL3qdYZNMCbbO
         92OOzdYbDMX+plLG4A2PpfVLjF1gkhflZQVtvYIG4zEez3JC/0PAjOEhS0onBU2Q9x1K
         fukLFJqhUyLMrc8h19HSgZAzsYZ5AlrVul7iEwNLM5dxuMwJS6Sf/evZwuj58Hv1INgS
         Wuf+OegulgqcLpHiYyvY+axZiPtZ4qL0RYqri1irq6+Sma5Jn6opDOpCtjwu8a0Q3mFJ
         N5dvrDKmVKlAxBEGxP/0TL/6txm/XtuWxqhqEnhwoKlSEYWON7rZ35LTxrK4QCmMPVS4
         yvUw==
X-Gm-Message-State: AOAM532aiO6KLh3LANa3EUnTD5EQ5X32CGg9p0MIE7EmcwLZf6/1skOv
        iUMV2QBte27lyQOfUtTDcXf+KhhwZFWHHA==
X-Google-Smtp-Source: ABdhPJxD4tnmn/G2eHMrBv5FJ4bWyM3Ck2WREUOTtiorzmPSKj1B5h8+Ic/bu5+ixdjG5nf98d8P/g==
X-Received: by 2002:a17:906:40d3:: with SMTP id a19mr13132056ejk.98.1607218042832;
        Sat, 05 Dec 2020 17:27:22 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id a10sm6157023ejk.92.2020.12.05.17.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 17:27:22 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 7/7] MAINTAINERS: Add entry for ATC260x PMIC
Date:   Sun,  6 Dec 2020 03:27:07 +0200
Message-Id: <c8bcf4059906a35e066a6cc464948df1aacab872.1607216141.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
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
Changes in v3: 
 - Restored the authorship of the patch to Mani

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfb92005eb3c..740134ce8449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2875,6 +2875,18 @@ W:	http://www.openaoe.org/
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
2.29.2

