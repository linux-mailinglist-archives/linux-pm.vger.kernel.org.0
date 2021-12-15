Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C231F474F10
	for <lists+linux-pm@lfdr.de>; Wed, 15 Dec 2021 01:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbhLOAXq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 19:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbhLOAXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Dec 2021 19:23:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE35C06173F
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 16:23:45 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l10so7669178pgm.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Dec 2021 16:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9JW3yyJwaNZhtBuZJ3jDcXTPLUxJwHsCr5uKwfCfrj4=;
        b=agigs3ZY+UFqmXiA74+p7leMm6bCpcAFw7Wv0bhdIXJAzuy/RNsZhpoR3WKP87+bbg
         WkFD+JYiP0ZPC/RgQqhdl16Gzm6jHHmg94YxVmeuHvkGunyjnVnH1GinHhGSBGJQ+i2P
         kvOnTcAy+AmfdQRDFNo4RMWvuQxL8GFrSxsFP/LD2umNzfkijAbupJmGwglG6TC9zAfp
         cSyX5j2OdesN14VKcpNvswKjt0fnzbni+VghtiNPOrfxB56sLw+fIqy+lk8mv22HNRz4
         elrDCpBOUXG3EUcCxb/fxe6vXAoErolEIxcHmoBfRyi4l2wUZpTAc5jZxrTxx+xgwWhr
         ZbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9JW3yyJwaNZhtBuZJ3jDcXTPLUxJwHsCr5uKwfCfrj4=;
        b=KbIEvvN5o7vB/h2+nGGssBVm2b+nJ2xBSOPwOxkkDb+bTKDU6+3Ec6XOqFAJLz3AOV
         rUD3IktGLrya3DuzvTEWMSwAH4exqpxsRrHgOMoMxVcPZm4W72CeVzu8VPE1hcjIXXes
         kJDQ5+PXQnmHZHstXj2nM3bs93228CcAxjMfaspHFpbw2z0RUK2u18QNl6C8xP9zUpaD
         hZTsypVfi/zLV7ENx+61/47M99STSnQSngxhD9dOzNDmtLjcX3rtQ6IoWvCI1/NmkUEN
         /jPeJxlJ4JW4ylaZgoiLzrsEPdZqHIIAB9a8/KslsA0nDY9aUZbvBuwsU/xrLIX02Ige
         WRTA==
X-Gm-Message-State: AOAM531uIgyPC+Ig+NHT6ZfmV+ATslvQRmK8UgcU+P0ewldaUIjyJFcj
        iPbdnM05XLrAdkqMhwA044Mvlg==
X-Google-Smtp-Source: ABdhPJygzKgajtWbWb3H4ho6iZNsIhQPk7qNBbFUmunw7Zkup7CRkh50BFi/TT+duaxtSIjZb5XYCw==
X-Received: by 2002:a63:8f02:: with SMTP id n2mr6005844pgd.270.1639527824621;
        Tue, 14 Dec 2021 16:23:44 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a12sm185840pgg.28.2021.12.14.16.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:23:42 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 0/5] Add QCM2290 interconnect support
Date:   Wed, 15 Dec 2021 08:23:19 +0800
Message-Id: <20211215002324.1727-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes for v4:
- Fix the compile error on msm8996 driver.

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
 drivers/interconnect/qcom/msm8996.c           |    9 +-
 drivers/interconnect/qcom/qcm2290.c           | 1363 +++++++++++++++++
 drivers/interconnect/qcom/sdm660.c            |    7 +-
 .../dt-bindings/interconnect/qcom,qcm2290.h   |   94 ++
 11 files changed, 1684 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 drivers/interconnect/qcom/qcm2290.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

-- 
2.17.1

