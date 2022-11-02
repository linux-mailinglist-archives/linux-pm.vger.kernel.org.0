Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E192615E92
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKBJAx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 05:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKBJAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 05:00:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406127FDC
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 02:00:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b185so15819450pfb.9
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FT0OTm0z8Frae+X539FGbdzsRWYK/iGZxdOx8XXi/LE=;
        b=Ig3AaOKwaXv4W1clrCaP8ht9oTFJTJo1Q07+8IC4AQqku4WSccnAXUtNfF47HXfycn
         yMl9xYjc9FN7TzblMaY83aki5Bi1NrwwE979V5vosIul1TWadsMnn0I1MNMNPr6UY3+a
         hlBMOg0gpoT3fVxCfwx113dt4hnQVi+wrSIu1Wtjx9y6bQGCIbGDlOqcqGBgt9imRNFM
         kGyn24WPVbNsNZhx6P1R2Dyfz6rH5Jt9EZN5pvLtY4WDRcFswmPIjqKnB5qqyYn1Jl3P
         QXu8/qirt0KRyVqE8yHL1TY1DuxrIhyxXlR8A5LfGhwhQDpKx/w2APECkdvP8XRIaYoU
         R0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT0OTm0z8Frae+X539FGbdzsRWYK/iGZxdOx8XXi/LE=;
        b=ZjnJKkCCvCUnW4ahEKAwjDCks7I2NGT5XHCY/mwX77uatoYjbsbTZEZI5KvPsmnqMd
         2qDpCRMEIoPN2L0iEWpWWStIXO/yBIZlErS1UHZCmFgPeiZSJHh0S+4FKWPzaSfn2yu5
         OyF2qalaVenWcynCE+2q2B6+JG34U5Bd0RTm9qOUn8BxAHEcTe6r4bp2XRKuPnVhZJPW
         b/hRrDcVy6S17Tay/L+OLV+SMSqndx2yZnzih6icJ99mX6/VixCl1l6SwYLQF4Y/Y+Mb
         fL+pl7Km+XTAAJfYWyS3e07C1nr+XeQVrxCf2eORnb85iZSSDkCrt1T43clpDIsBRS/P
         Cz5Q==
X-Gm-Message-State: ACrzQf3EudjMuVxRHOrSQhibTNCUKXy6sq/BK3uu6fg42BEQ+tdNJltK
        YBApExf0G/cKmLu3Z6QGhayM
X-Google-Smtp-Source: AMsMyM6A8PrZycK/qPAPz/hujdmNg7sh4GoiwoUL8lyEDkoBWeQ9zBwvq9rJPp/VyCpGbtdYErn1TQ==
X-Received: by 2002:a05:6a00:e0b:b0:56c:8c13:2a54 with SMTP id bq11-20020a056a000e0b00b0056c8c132a54mr24047174pfb.17.1667379649902;
        Wed, 02 Nov 2022 02:00:49 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id z10-20020a63d00a000000b0046f7b0f504esm7136389pgf.58.2022.11.02.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:00:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Qcom CPUFreq HW driver cleanups
Date:   Wed,  2 Nov 2022 14:30:35 +0530
Message-Id: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This series contains cleanup patches targeting the Qcom CPUFreq HW driver.
This is a spun off of the clock provier series [1].

Thanks,
Mani

[1] https://lore.kernel.org/lkml/20221025073254.1564622-2-manivannan.sadhasivam@linaro.org/T/

Changes in v2:

* Rebased on top of cpufreq/arm/linux-next branch

Manivannan Sadhasivam (3):
  cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
  cpufreq: qcom-hw: Use cached dev pointer in probe()
  cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq

 drivers/cpufreq/qcom-cpufreq-hw.c | 118 ++++++++++++++----------------
 1 file changed, 54 insertions(+), 64 deletions(-)

-- 
2.25.1

