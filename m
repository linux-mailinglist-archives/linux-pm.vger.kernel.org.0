Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08C473F65
	for <lists+linux-pm@lfdr.de>; Tue, 14 Dec 2021 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhLNJaY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 04:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhLNJaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Dec 2021 04:30:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C895C061748
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 01:30:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x7so13919781pjn.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 01:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G5vi0yoD7qRfQWn2e0IRPWaKeo3s9BuljNXhjeAVjIs=;
        b=HPPr1SexI4L2/JHXRCvD2gwTV0S30QfYzyHgnQTGIvO95cFShzJiIvYqhQzEoVDElZ
         kpoO+zaIoAW9ao1MILw6b+j5ncClVfmuKy3QJiMCbA0/PaLQf33HIM3B+W4awSTr3IYS
         SStsQHQJ7vmvi2P+40Iive3mfvqlbses01WeudDtJ33EePNJSv8uTW1kdIlgtK54NxZ3
         OPe/4yJHWpcbpt7wRP3XC6TaldRooqnR75LG1S2MQ7jCo2xrsToaICD4NOCsGNXbsg3c
         Gc2j8ElRbOo27bf66EFPbhpY2HGzE9e2d8nmx0tLic65WRsCIuiMOOO5TDBxmzC8qjIv
         H8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G5vi0yoD7qRfQWn2e0IRPWaKeo3s9BuljNXhjeAVjIs=;
        b=Wafh3XYyNEi8t2G/nTKbgvhTlGfsJoK3JdyqG8EYh25N0BtJvWycydv7D59wzbGQ0K
         nmOjR4vZAZifUm88ozyYGh/UlCWLBlUkux3jE/LwqcM/MTz4X40w8xBpu6cHKtGi9Hdy
         /eJjlPjyQN1XKVKQIcMub+2hlJpixK/03YB5Wv24unpzzS7ZVhgxt+1iVth4CLTo328D
         ruuCDOt3rbMmhuQTzJD1XSqYhTMPJujKqiTPXpLyLAA4h5qg8rp/U2efDdMiXbJDubEh
         relzR0jMOVDwZ7VPzVLvKTFgbtKe0CQ8m8SGq7yj2IBlxG3gvPOsw/xf52rC50XRZvGr
         ORhA==
X-Gm-Message-State: AOAM531q013gvDb9X39uEPtY/S6ClHp58+kvVxvh14GWixVEDbI8GCdH
        jfCLLK+6u5P8tqJBjAiYPACLNA==
X-Google-Smtp-Source: ABdhPJzn4o2J9glLLu1kBIJgkX/w3k8el5p/hk/iYhX9j9YNCx3a/h+wS6biPYnuiNe1hjEYXqsoRg==
X-Received: by 2002:a17:902:d88b:b0:142:8acf:615b with SMTP id b11-20020a170902d88b00b001428acf615bmr4239846plz.62.1639474222866;
        Tue, 14 Dec 2021 01:30:22 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c21sm15143184pfl.138.2021.12.14.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 01:30:22 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 RESEND 0/5] Add QCM2290 interconnect support
Date:   Tue, 14 Dec 2021 17:30:06 +0800
Message-Id: <20211214093011.19775-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes for v3 resend:
- Rebase on linux-next
- Drop NOC_QOS_MODE_INVALID patch which has been applied by Georgi
- Pick up Rob's Reviewed-by on the binding patch

Changes for v3:
- Update bindings to define child interconnect provider nodes

Changes for v2:
- Drop unneeded include of <dt-bindings/clock/qcom,gcc-qcm2290.h> from
  bindings.

Shawn Guo (5):
  interconnect: icc-rpm: Define ICC device type
  interconnect: icc-rpm: Add QNOC type QoS support
  interconnect: icc-rpm: Support child NoC device probe
  dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
  interconnect: qcom: Add QCM2290 driver support

 .../bindings/interconnect/qcom,qcm2290.yaml   |  137 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/icc-rpm.c           |   52 +-
 drivers/interconnect/qcom/icc-rpm.h           |   14 +-
 drivers/interconnect/qcom/msm8916.c           |    4 +-
 drivers/interconnect/qcom/msm8939.c           |    5 +-
 drivers/interconnect/qcom/qcm2290.c           | 1363 +++++++++++++++++
 drivers/interconnect/qcom/sdm660.c            |    7 +-
 .../dt-bindings/interconnect/qcom,qcm2290.h   |   94 ++
 10 files changed, 1676 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 drivers/interconnect/qcom/qcm2290.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

-- 
2.17.1

