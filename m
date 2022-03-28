Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A014E952C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Mar 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbiC1Lkt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Mar 2022 07:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbiC1Lgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2022 07:36:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926EA1ADBC
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 04:28:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so18270735lfa.12
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsDsfeasp5tKbQLAMLbAm3wkIbuJh65eJnV++lPkz3Y=;
        b=NGByWSqXd3ExlsCaJCTzTGpe3MlJt1+4jeJpNTcNLonj5IOrmqzegnmQOIo7XaNYSS
         5nGgIEjvW/VP4bHHDMMq9R56O77dwCbMsxfcWyq14fc51ZlWRK9MkeWum0G7PQ1wVMV/
         EKlVTHrt+CSCVDlqkke/JXOxEOP39MwLtz3iGFhdhHnP2RQgUnRLNwPaHXf++6Hg/D4u
         8NMSKrzwx0Vs4c6EfRSoVfznMl5QvfMs4mOpSClWO0gxwJGsK49eklSWaMtv36vTH3eV
         +AAiO8Qor5JsKkp/umkM/X+cBEV0asmLojhvah7EjCO6P2xXYz/VBAgsYf4xLpDJ5HzC
         HQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsDsfeasp5tKbQLAMLbAm3wkIbuJh65eJnV++lPkz3Y=;
        b=iGDVH5Hd+hKzniHu8Si/RShQ91teAVp/miY+NSZecnFd0G32v4nme2c3wbgoj318Py
         ZdMUUpLiRmf8OI2dm4fabt/5aF9MBXLWlhNXgVFNZeEQN9hWAaz9IdXi1o9R8iIOExHx
         zFepnTMOqIpRCIbRtZd2BL41RzghhAijInPCV2g7OlYmfwlW80tPe4JKzAcWXhHBdCos
         QFHb7a/Le2hxOsPXcO0sgFXJYf3If3HyTUQwjsZPm0sw1m8Tvij6xq27V4L9eNPdu8nE
         waA3XwIJUPpg8krQLCDpX0S3WVVWr38QtH+jBmOCn8Rcl+Fuz7B5r6YM6yiXnrmlRuvp
         VYlA==
X-Gm-Message-State: AOAM530y2uK/Ha7WVtyU275yT6EvME/G9dMYLdXd0W97iNVh2Wdvp46b
        a6hG89/9QRgfzMufm23fACV14w==
X-Google-Smtp-Source: ABdhPJxFJbhwfO+F9o+TSYzpt7aS2Z10YvphFxq/7MdNqFQUmb4PuAKwxJo0S/ibkN/6OaQo/jojmg==
X-Received: by 2002:a05:6512:c03:b0:447:7912:7e6b with SMTP id z3-20020a0565120c0300b0044779127e6bmr19391258lfu.508.1648466919016;
        Mon, 28 Mar 2022 04:28:39 -0700 (PDT)
Received: from localhost.localdomain (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e9084000000b00244cb29e3e4sm1700373ljg.133.2022.03.28.04.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:28:38 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] cpufreq: qcom-cpufreq-hw: Fixes to DCVS interrupt handling on EPSS
Date:   Mon, 28 Mar 2022 14:28:34 +0300
Message-Id: <20220328112836.2464486-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The series contains of two critical fixes for QCOM EPSS cpufreq-hw
driver, the fixes correct runtime issues discovered on newer supported
QCOM platforms such as SM8250 and SM8450.

The changes are based on next-20220328 tag.

Vladimir Zapolskiy (2):
  cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
  cpufreq: qcom-cpufreq-hw: Fix throttle frequency value on EPSS platforms

 drivers/cpufreq/qcom-cpufreq-hw.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.33.0

