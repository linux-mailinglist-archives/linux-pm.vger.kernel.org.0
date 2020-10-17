Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB6291213
	for <lists+linux-pm@lfdr.de>; Sat, 17 Oct 2020 15:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438113AbgJQNhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Oct 2020 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438119AbgJQNhX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2020 09:37:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A97C061755;
        Sat, 17 Oct 2020 06:37:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so6555050wre.4;
        Sat, 17 Oct 2020 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/B1DorI1rXeOT+ayQR9YJ7/grwozrgmltDL9HJq8h8E=;
        b=d1FBxcf97S+nWVgqLHZ4eUT1FOfmLX3F7JULOa6YhcxSOvxy1jsP5VWWjcw04qK9Bh
         cGcx1iAR9hZlwBaptS1hi3NvVhsvJ+e2BpRi2yILWQUoRup5a05ODSXoYIvOMc/1Q/RR
         +ojIy6J9hniGjoKVlNJzGBME97Q4zXdC+ao5cFsnHliTovGlcOGJJL+PWjpXHpMtPS8M
         fjq9TXHkW9UpyUM+exKIGCiLXHutVnvH4d2CSG6Y7UiPLPDLF8pG+jOqIntbGJfoSkuK
         KEtnH0Upuavo8n8xl7MG19mgFpeYXxNCr8dpaWjlw+kXRFxaes0hcepVlXEBr6s1x1X2
         FcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/B1DorI1rXeOT+ayQR9YJ7/grwozrgmltDL9HJq8h8E=;
        b=JXam/ydUr4PotzO5eAAasT1cid3YNO3n0lPeDpiNeqgCi31InfGaqb6fQwqWYp57R7
         K+oOq2W2jDbfGlHe3jYoZJEnLPy/43MbvU0NaQERXQ3lr3M+LAIAq1VFLnoypBY8BvdM
         gDAr9i4NFk/xw5u1YvKSB9x4y1ut+RRloSDqD4RHkiUioWaowk78Tgt7ehvd8UJSz5/w
         lXQZud6eSJ7AQctvDm50qHSnOJeYO+J4ImTmgUqRUUoNTVlaBL3LgjL9jqxQ5McLtfNq
         rD4mopP/fQikxOUuAHg13bk1UYg+w9hDCWVC7v+XjGkQ5y1t1nD6WY6amYrkBH/8ii9Z
         Vb6g==
X-Gm-Message-State: AOAM530wq4AkFfHwnbN2Pq1sZhkALsbSUT5BaS6uXBy9iqtjpQlRdyVA
        +9d4j25FifZJt/QUIXQKCsg=
X-Google-Smtp-Source: ABdhPJxNMdUfMfs9SjzRhMQk7iOoh092+fIO7YHlqJSJKANmKKzSZ7Zf4HVkrZL7fBqbvm1hEf4eTw==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr9865822wre.13.1602941841046;
        Sat, 17 Oct 2020 06:37:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id g125sm2783742wme.33.2020.10.17.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 06:37:20 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add SDM630/636/660 interconnect driver
Date:   Sat, 17 Oct 2020 15:37:16 +0200
Message-Id: <20201017133718.31327-1-kholk11@gmail.com>
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

Please note that this driver's yaml binding is referring to a MMCC
clock, so this series does depend on the SDM660 MMCC driver that I
have sent separately.
The multimedia clock is required only for the Multimedia NoC (mnoc).

This patch series has been tested against the following devices:
 - Sony Xperia XA2 Ultra (SDM630 Nile Discovery)
 - Sony Xperia 10        (SDM630 Ganges Kirin)
 - Sony Xperia 10 Plus   (SDM636 Ganges Mermaid)

Changes in v2:
 - Added missing qcom,mmcc-sdm660.h dt-binding include in the
   interconnect/qcom,sdm660.yaml binding, as pointed out by
   Rob Herring

Changes in v3:
 - Moved the dt-bindings/interconnect/qcom,sdm660.h header
   to dt-bindings commit.

Changes in v4:
 - Fixed code style issues and removed unused defines as per
   Georgi Djakov's review
 - Fixed the SDCC2 RPM master/slave IDs
 - Added an exception to stop writing LIMITCMDS to M_BKE_HEALTH_3
   as it doesn't exist there (it seems to be harmless to write
   that there, but it's incorrect to)
 - Tested again on the aforementioned devices

AngeloGioacchino Del Regno (2):
  dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
  interconnect: qcom: Add SDM660 interconnect provider driver

 .../bindings/interconnect/qcom,sdm660.yaml    | 147 +++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/sdm660.c            | 922 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sdm660.h    | 116 +++
 5 files changed, 1196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 drivers/interconnect/qcom/sdm660.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h

-- 
2.28.0

