Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD853F3631
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhHTV4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 17:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhHTV4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 17:56:19 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902FAC061756
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 14:55:41 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso2432823ota.8
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KblwPmiHBhylSYmizpG5xsAGTHqdQ0PFtDpHENws1SA=;
        b=ud0UkycghEG90duRWw53xDdlOx2cit2bN3o/e5FmKAvXNmS1aGpkaoU1077mIgU95O
         uPyRk9e/DRfC5CMxAqFeCjvT2HNV/I8i8z9yBf2npG3a2SQIKc5UeLgQifEmianiR3tE
         iAe66JgiJ7PCBgvxirKT1JAdkuQ1+qYjOyYVUU8DiYHMct030TnCbGLcUyl6019JY3lJ
         XBWY/+e4s19T2uiOW9ZfcIsRjBM6Kq5JcQg+VUo32M3G82OoQe4GEBeXmhBlaFd5dIya
         CnyHfZIN0RSYPNVLidPSGgu51e1AcP4aQWpGW8bWz4sAaSvsLugZ2RED+SD2fPtLnT/7
         BvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KblwPmiHBhylSYmizpG5xsAGTHqdQ0PFtDpHENws1SA=;
        b=AHAkbeVoDWAb9BxHk0K7ECRV7r6XR/mdAsoK4bWj/46lfSkJnYIC6F/HSIWDVhUBfe
         OyiJD6X30Dtwmab+tcFug1+yd+6FEAHu1ZnjVj2txOMGH48NpA9EiDD4M17aAzMwhMX/
         737mzl66wcooItiNGQzXNMGTtRL6AOWDj1n1+Bo+HXxc65UC5ceExxsNRw5wXqSyw+qy
         QBnMZO8BZoye+6Eou6ywARoooqt3s5mrs4o9reUQmPnsLmmEaOwrHfK1Vwnfy8HCWYQE
         9WLzMeyKhC4fz29WWw5ob+67xhsoZxT9AVs7eqMNLj+IV0tCfUOr/ms1pqgbuQEdejpL
         TCxQ==
X-Gm-Message-State: AOAM533r1iCCJ6EaPHBmIg6Lo+PXW2A/QC5GCYwHKoR9Qe72nKsFzZik
        /BJ/nW+t5VpIiIsw6Alu4aM3akZG2iSP5A==
X-Google-Smtp-Source: ABdhPJxDcnSXZpY6iwxnZRsIZhUMFzjIxcrKNwrTrcFmM8qXBHhYFof7YBRRiMquso8BMSGWNx54jg==
X-Received: by 2002:a54:4686:: with SMTP id k6mr4665691oic.54.1629496540907;
        Fri, 20 Aug 2021 14:55:40 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i19sm1643630ooe.44.2021.08.20.14.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 14:55:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: [PATCH] cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev
Date:   Fri, 20 Aug 2021 14:57:00 -0700
Message-Id: <20210820215700.130575-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm sa8155p, sm6350, sm8250 and sm8350 platforms also uses the
qcom-cpufreq-hw driver, so add them to the cpufreq-dt-platdev driver's
blocklist.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 231e585f6ba2..ca1d103ec449 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -137,11 +137,15 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
 	{ .compatible = "qcom,qcs404", },
+	{ .compatible = "qcom,sa8155p" },
 	{ .compatible = "qcom,sc7180", },
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm8150", },
+	{ .compatible = "qcom,sm8250", },
+	{ .compatible = "qcom,sm8350", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.29.2

