Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9552C2798FF
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgIZMvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Sep 2020 08:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgIZMvM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2020 08:51:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A782CC0613CE;
        Sat, 26 Sep 2020 05:51:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e17so1945063wme.0;
        Sat, 26 Sep 2020 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MI3c5KcwwzYOUW0jqHvWGmuOUTV9wL8UEsFB1tEYjo4=;
        b=c7uupTd8U0t6vwT0nCt0nV0u3umAGBG8kOuR4A4jpBaPtoWkSgRohkOiBQWHjy8kkB
         A+cdHS+JdPTgzkIjoaF0ouS6rw2LytsAt+qDs1A/KMVPY4IdK1WntUpYqCVFdi65oyMq
         R8jZLoIdIhS9iRhBF/SbY0I2dZXiZVOXiE1/VLC58wj3sRnXX2OkNwiyuf/4qaXkUVnt
         fBjGgzjRmsrNXpTcAtFBYXAhMFprOFj53Maif69hCAM/3QJfedQL3zxyjYFXEJVgbVw4
         DnOo/vyZF83jp57s0DY1HyLcvHDsapJTu1d3NNNOhgNqWJimjd5zs7t+bZRhS+R6Pszy
         dEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MI3c5KcwwzYOUW0jqHvWGmuOUTV9wL8UEsFB1tEYjo4=;
        b=A44vREdmwlavyGw3IluqK1pKt+CPNkX7E6RLEImsZRv2Or2QwbMxdWWzhGdTcS+iWr
         AxTsooQ33W0bO/P71v5HEzfcwEm9d6vKHEn6pHE1FUaIQK15vxhNIiIqMAg9+Kld17CM
         g7Dp+92u7j08aiHj9ERuCHRh98f0oGk3FCZKwnGcuDh7zWh+/OyUWGglV8lqLlA6bGej
         7G99Sugn+vhDiRpEGxCrRDd9Lg6OEG+xYzH+M+CH7dB/pTEBKtxdjgrY4Vm/TPdtrero
         iQ/2SXDNncJ2HrkD7bC0xPyF1jSvAkJIBrFlVIN5XzvI9qkcazYr7cgTs3uzxR3COS73
         79JQ==
X-Gm-Message-State: AOAM533A0gY//n1ncOpFFrIZl8y2wjluFlFIzpmP9tcRd5il6ouE9pue
        j7EM6MhnXZipYv9hXAhYeLQ=
X-Google-Smtp-Source: ABdhPJz+hddRvqIuoXc8ch23a7hTHDVePwKOJ8LyBfgVbjU+GYw8urCCaK7/zfxXx2q2355ciSxCcg==
X-Received: by 2002:a1c:6487:: with SMTP id y129mr2639829wmb.90.1601124670218;
        Sat, 26 Sep 2020 05:51:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id z15sm6765225wrv.94.2020.09.26.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 05:51:09 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add SDM630/636/660 interconnect driver
Date:   Sat, 26 Sep 2020 14:50:59 +0200
Message-Id: <20200926125101.12712-1-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

This patch series adds the SDM660 interconnect provider driver in
order to stop some timeouts and achieve some decent performance by
avoiding to be NoC limited.
It's also providing some power consumption improvement, but I have
only measured that as less heat, which is quite important when
working on thermally constrained devices like smartphones.

This patch series has been tested against the following devices:
 - Sony Xperia XA2 Ultra (SDM630 Nile Discovery)
 - Sony Xperia 10        (SDM630 Ganges Kirin)
 - Sony Xperia 10 Plus   (SDM636 Ganges Mermaid)

AngeloGioacchino Del Regno (2):
  interconnect: qcom: Add SDM660 interconnect provider driver
  dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC

 .../bindings/interconnect/qcom,sdm660.yaml    | 146 +++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/sdm660.c            | 919 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sdm660.h    | 116 +++
 5 files changed, 1192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 drivers/interconnect/qcom/sdm660.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h

-- 
2.28.0

