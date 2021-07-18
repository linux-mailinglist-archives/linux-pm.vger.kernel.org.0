Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C63CCADF
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jul 2021 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhGRVbI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Jul 2021 17:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhGRVbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Jul 2021 17:31:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA5C061765;
        Sun, 18 Jul 2021 14:28:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h9so23016715ljm.5;
        Sun, 18 Jul 2021 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2TaNdcasZkobL90Ag9/S0mipkwZ8znoNlAL9mBQuBo=;
        b=Bl6ZnkL0X44oiMQCqgLnNGPKYslyWc50Wznp85cs5sA6oaW3AniVEtBW8NZBPOTHO6
         Bs6RlOCO8FqcWVnODZn5H/W6apfnKJ4i6cXEeCFuELlZ9Rbyd4PtzTh7Wj/x+Ff0qYiZ
         tfOf1PVdNsslm3kavU8oPl5zciUL/rVCvDM7LOBcqhvCRSuxOfqSxWO9MWiVqezyN1ie
         kh8FQaTU8vdqaKvIAMXiXPMtPh87hhnIl17YneXTIa/SoQc0wsJGkjlzyMlzn1QwfpEx
         7gRwhpoSacl4MUCs3yPbVd3Yp/iGwP+37zty6HhQ//l19r+855Xj9FeAHKye1S2rJFz/
         DBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2TaNdcasZkobL90Ag9/S0mipkwZ8znoNlAL9mBQuBo=;
        b=MS15VfirGEEa90dQIthavMpyf9LelHsGwoV4RAG4tMZ7E+4sMecutaysqDKxu7lDUJ
         QqAixiJx4YcGn3lb4qzR3p23QeIJD4XLbx8f6wPa0rVf8iTNok2k8+0SGTehbzrZ8mbQ
         u6OCIm02v7mNK5AfQ/zzQorSy4jP9/pPBSPJAxyHPUk2lQBKAjRDobbGhdB12JrZMWch
         nr2+WFi9BcVMM7s975Z3IAg5ZDSlShRDuiCjvaqPqBpTrYkT1KvZPqET7TJMPVDlbRb/
         1oJJLkZd/Sj9CABNn4c4VRTuAM3BkC7y28hotUGXdyTfHUsytKjL9/X4N2cfjPb2UhAC
         sBJA==
X-Gm-Message-State: AOAM531FjyjCR3T1M2E767Ajfg1C3irFsT/dCQFjjW82Y2jqer51jjGh
        O4dWN3oAFVUPiTXrkfIqxJ4=
X-Google-Smtp-Source: ABdhPJwyuF0ScQBajAY8wqquTubQrcfSm3HIoBpZ4sqQwDoxZnLamhQ052JBJbIxTiy1kzGI9g7srA==
X-Received: by 2002:a05:651c:10a2:: with SMTP id k2mr19254126ljn.89.1626643686869;
        Sun, 18 Jul 2021 14:28:06 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-53.dynamic.spd-mgts.ru. [46.138.17.53])
        by smtp.gmail.com with ESMTPSA id c10sm1229062lfv.10.2021.07.18.14.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:28:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] cpuidle: tegra: Check whether PMC is ready
Date:   Mon, 19 Jul 2021 00:27:06 +0300
Message-Id: <20210718212706.21659-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210718212706.21659-1-digetx@gmail.com>
References: <20210718212706.21659-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Check whether PMC is ready before proceeding with the cpuidle registration.
This fixes racing with the PMC driver probe order, which results in a
disabled deepest CC6 idling state if cpuidle driver is probed before the
PMC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 508bd9f23792..9845629aeb6d 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -337,6 +337,9 @@ static void tegra_cpuidle_setup_tegra114_c7_state(void)
 
 static int tegra_cpuidle_probe(struct platform_device *pdev)
 {
+	if (tegra_pmc_get_suspend_mode() == TEGRA_SUSPEND_NOT_READY)
+		return -EPROBE_DEFER;
+
 	/* LP2 could be disabled in device-tree */
 	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
 		tegra_cpuidle_disable_state(TEGRA_CC6);
-- 
2.32.0

