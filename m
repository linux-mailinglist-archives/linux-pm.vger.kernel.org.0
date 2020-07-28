Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7622FFAE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 04:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgG1Cjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 22:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgG1Cjn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 22:39:43 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF67C0619D2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 19:39:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j10so1829403qvo.13
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 19:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpBwI5rh1VmR9dJCXKb+bJH00mu8Lm9wehnoKvU4jcQ=;
        b=bqUQy7jhnL0rGAZVXzl2pr3NWaTgdIriU12FTryPEPMVY5wt51fHrXJ0vbVkcfIr4d
         WAYoI66DcIz8Z2qRIvZ5yKiv5D8YgwxBTnylMztk4s16k5XUIlc/re9PODqvhvkRtB5B
         TVZSkva+UhquRQULicJzDN9icgzBm2blLaIyZTP9OL8mv9ugJTBJiyDe6iSjRBOZvOBv
         sA1vH0643u/pUW6E2y/lTzK2XhtF6fnFY5q02YCUSNgODaW+bprgm2eXlDdmxyLptMyH
         yBoE+/88gElgn3TEvFtyRfqbBLxv6nxBgMXkuxf+SNdXWTYMbOiK7VH6fSm1eh9enAGr
         DsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpBwI5rh1VmR9dJCXKb+bJH00mu8Lm9wehnoKvU4jcQ=;
        b=js61xhYEV+LWb3gPVUHKyceeC2mFW7pUMltQyv9gXde4Auq1zVy7XQ4KLOiUZ/hwMm
         cFAGX4+T7sDBhXbQDU/8omy3JkutwNwWADz8Skw/xsZqJujGL8Z4tvL2YVVfR+B+ARlX
         IyXRiTNR52xjdSvsjev+J3/voa2rJ2LRMx/3lNfqEAOs8RW4VSILntE0EAU9MjOJd2kw
         cA/BbWO3HVfsRsR0nO6crZJMl5wgpOmFyYIPjXDbiY1IzHbuJEC6/HSuRn37UF756ULL
         1yX1PcQtWMNEy9lbkuuS9oi86/FrImAn3zcA7wxT4FLUv72wyR+3b1OZctoPNB8oStQx
         9qqw==
X-Gm-Message-State: AOAM530vHoy7YikwLYQ6iYYazGsHls/F9luttrimrtKw/Xi3c6litaio
        PgpN+m7pUdWdvyEJlX17d/BW1g==
X-Google-Smtp-Source: ABdhPJz9E9SJY8pj6+WMHEhK2Nhev880nCCsyeRYYub0FM05PwJIPJreA7LDFUu+Z4vWX3RN2jcOLA==
X-Received: by 2002:ad4:49a1:: with SMTP id u1mr7434725qvx.245.1595903982912;
        Mon, 27 Jul 2020 19:39:42 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id z3sm13885548qkc.4.2020.07.27.19.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 19:39:42 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/7] Add SM8150 and SM8250 interconnect drivers
Date:   Mon, 27 Jul 2020 22:37:59 -0400
Message-Id: <20200728023811.5607-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most of this is generated from downstream dts using a script.

v2: single yaml file for RPMh interconnect bindings, drop display RSC
v3:
 - removed the sc7180 example from the combined yaml file, two
   examples with conflicting includes doesn't seem possible
 - Removed MASTER_ALC and bcm_alc (sm8150 and sm8250)
 - Set keep alive for SH0, MC0, MM0, SN0 and CN0 (both)
 - Used Sibi Sankar's suggestions for reg base/size in dts

Jonathan Marek (7):
  dt-bindings: interconnect: single yaml file for RPMh interconnect
    drivers
  dt-bindings: interconnect: Add Qualcomm SM8150 DT bindings
  dt-bindings: interconnect: Add Qualcomm SM8250 DT bindings
  interconnect: qcom: Add SM8150 interconnect provider driver
  interconnect: qcom: Add SM8250 interconnect provider driver
  arm64: dts: qcom: sm8150: add interconnect nodes
  arm64: dts: qcom: sm8250: add interconnect nodes

 .../{qcom,sdm845.yaml => qcom,rpmh.yaml}      |  42 +-
 .../bindings/interconnect/qcom,sc7180.yaml    |  85 ---
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  82 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  82 +++
 drivers/interconnect/qcom/Kconfig             |  20 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/sm8150.c            | 635 +++++++++++++++++
 drivers/interconnect/qcom/sm8150.h            | 152 ++++
 drivers/interconnect/qcom/sm8250.c            | 651 ++++++++++++++++++
 drivers/interconnect/qcom/sm8250.h            | 162 +++++
 .../dt-bindings/interconnect/qcom,sm8150.h    | 162 +++++
 .../dt-bindings/interconnect/qcom,sm8250.h    | 172 +++++
 12 files changed, 2161 insertions(+), 88 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm845.yaml => qcom,rpmh.yaml} (60%)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 create mode 100644 drivers/interconnect/qcom/sm8150.c
 create mode 100644 drivers/interconnect/qcom/sm8150.h
 create mode 100644 drivers/interconnect/qcom/sm8250.c
 create mode 100644 drivers/interconnect/qcom/sm8250.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h

-- 
2.26.1

