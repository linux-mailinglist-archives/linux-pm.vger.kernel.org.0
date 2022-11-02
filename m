Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBDE615DB6
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 09:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiKBIcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBIcy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 04:32:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2C27B01
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 01:32:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o7so12357890pjj.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GeVB0TEyhDy7j/DKZJYR86bV8vbgA9u9nMdT2SoI+90=;
        b=W7FfdIEIRREb369VaotcUbQZVR3hH/M1/UOHUuAajfyKGmeTwPiSEM34g0cKYHYegc
         faJGJfzYVZ3Rx+ufPzzxEfahbyYhrcPuagR/IMVW8nw4RoOn+xcNXbhDMl2fOsx9+Vq9
         iIa1xL4VNcaKm0XKXFXFet/fxjH1jE8LNsVIR2niAeqyYOR7VfrfTNmv9fUZ973RykYV
         URvJ/sV4XZqVeHmQOFJKNXCIrQ8zhJHxawpQlC64MDYoF0scoPFXggGfnGzHF2Mpiz/R
         jfaALliEyWO1H06Q/z0toE8r4+JHQy/hgCuW83g7FYUG0lzFQmMYFwjHDyhJe6hG1WfS
         cW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeVB0TEyhDy7j/DKZJYR86bV8vbgA9u9nMdT2SoI+90=;
        b=ikDk/ZUFihKqZDrR/T+tGFJ3ZCqRc28QaGeTts5ETdMsgfYCFIjO4TenLu40waMOCz
         tVH4gXJZA6yNEoS6LnXV8xRPJbg5Hid3zk/GuEpUY1nzcMR5B//5JU4yvV70q6Hxg/pQ
         RM9n9wM3VUQGp2dMjYhvDRteepRbCRvrE3enWxnLipId43rXSa466NjPJE+iaXf42nP8
         zwTiS2kYHGFsbQPTph/SK1JmqOzwTiL+XXnqD3qXrj81ttnL2VZZlOhkI3yYtVJ6DKiO
         qLcnk7kU3DZZ5KpBDJv1UCwhPkXXewAd59HDHWFlOlyo8TDoYNcHwz+jjiR7FFviG7py
         hI0g==
X-Gm-Message-State: ACrzQf04AtEpsouNNmFOVHgY6sufXbIcniqbSFQyTdeVzxMBxWCwLZ9d
        YgHcYMXX9EeLyFIhRdvL/aIL
X-Google-Smtp-Source: AMsMyM7AX5prodbruzgE6T5okL6IIYEqP0fZVZGFqkN1+w9TSvSfykyQz3H4jX5BZ1y7qN0AvaQglA==
X-Received: by 2002:a17:902:f551:b0:186:be04:6670 with SMTP id h17-20020a170902f55100b00186be046670mr23323054plf.159.1667377972798;
        Wed, 02 Nov 2022 01:32:52 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00176acd80f69sm7682256pln.102.2022.11.02.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:32:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Qcom CPUFreq HW driver cleanups
Date:   Wed,  2 Nov 2022 14:02:36 +0530
Message-Id: <20221102083239.53826-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (3):
  cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
  cpufreq: qcom-hw: Use cached dev pointer in probe()
  cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq

 drivers/cpufreq/qcom-cpufreq-hw.c | 118 ++++++++++++++----------------
 1 file changed, 54 insertions(+), 64 deletions(-)

-- 
2.25.1

