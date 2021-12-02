Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C40466CFF
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 23:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349591AbhLBWl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 17:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349666AbhLBWl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 17:41:27 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA96C061758
        for <linux-pm@vger.kernel.org>; Thu,  2 Dec 2021 14:38:04 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id b11so986803qvm.7
        for <linux-pm@vger.kernel.org>; Thu, 02 Dec 2021 14:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5afaaM0805LUmQgPUN1I+DhSjSFQ9XpkfKGuyNc/Ca8=;
        b=aQ0R7X+tpwHkc/q0VKwlqrUgxUEzUB+wukJTP7/buH7nSJ7EroNcy41LIRlWMeW+Zy
         xNlihRPus1RiftmAxFcWDryRV2LR/sVNdKfHETNCNtu87NT/W7dXIrKBVYiADACTyO0U
         jsa6DeAHmBkf6VO60EHNcmvDcGV4/ya28ptdMS4UPq7lUCv7/uUgsDEgMNl7FdlGnN1J
         plAMt4RFv5+Lfxti0zk4qLInhkMERmlyltPGdYbCPSUV4kGrb8nhXyyPYjHlAHG/EATu
         9ZCTPT3tMYk4oFdhywx+7W5vDUknALJjguKd/Jamc37q1x96GcmzX+hnvl+DiVCOUbc2
         byjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5afaaM0805LUmQgPUN1I+DhSjSFQ9XpkfKGuyNc/Ca8=;
        b=LqimblSyUyVz+It1m5RVxvnFsQyvB2cNYoZyvaDiaEWm7JZG6QFyofhoWp4KBGlAjX
         jANvqhR2BrFGTkLp9CIcfWCRc0sWpXLKcprczHZZl8VAMuWCv+M1Kkld+uT++WnvC4RM
         zVWOYSNFayI6QRa3EiXtj6irLHGTBfj2OT9R14I56GBhSObrqKkliPk6srG5QUNS0qWj
         yjLyF6+irNeU427Ujqf/uHATywy4Ka+lRppoIwGg7SNCj877hd5ccqPq0AsaKWKpVNxK
         gm46985zer8Q3ivaTHBlYoQrjcYy3X02QxbFtJfp5ti091YGt4185FmJJQ7srlfz2ak6
         6J6A==
X-Gm-Message-State: AOAM5315mAH8Y8iVJjhrgkRBRwuXNXnjWs6ITACGsTR5g/7eLVKdFK7G
        8rPIGzfdVc/KgWa7HMSsbFlJrVjqEO11SA==
X-Google-Smtp-Source: ABdhPJw+owMF6hF0Gp7XNn59yf/Ugra6tB/NM9+vVVsZF74gt7UMDFay7tIyQ5BoxIxHl160eSgCCQ==
X-Received: by 2002:a05:6214:401e:: with SMTP id kd30mr16533713qvb.80.1638484683768;
        Thu, 02 Dec 2021 14:38:03 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h3sm961152qko.78.2021.12.02.14.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:38:03 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Extend LMh driver to suppot Qualcomm sm8150 SoC.
Date:   Thu,  2 Dec 2021 17:37:59 -0500
Message-Id: <20211202223802.382068-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for sm8150 in the Qualcomm Limits Management Hardware(LMh)
driver. Also add required device tree entries and dt-binding.

Thara Gopinath (3):
  thermal: qcom: lmh: Add support for sm8150
  arm64: dts: qcom: sm8150: Add support for LMh node
  dt-bindings: thermal: Add sm8150 compatible string for LMh

 .../devicetree/bindings/thermal/qcom-lmh.yaml |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 24 ++++++++
 drivers/thermal/qcom/lmh.c                    | 61 ++++++++++---------
 3 files changed, 57 insertions(+), 29 deletions(-)

-- 
2.25.1

