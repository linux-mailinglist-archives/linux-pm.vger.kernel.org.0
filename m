Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2093E43980
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfFMPOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:14:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42140 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732264AbfFMPN2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 11:13:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id y13so15363296lfh.9
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oy4WRzt4oy7DKEhEUsk8mM+TKtbIR/SxiJkzCANc2S0=;
        b=jMyVNjAHR90qecUAhRrWQnYr3j5JfbQWsYrzQvWMbwWRPL0Z7nP94qt24V2i/E3l+a
         ZIvy9FmxmrQ2duSB2wqLIJDUZtCMYd07SgfkxP/rrJsQY5NilBYJej4YfiPEshJT52Lw
         mbC4J9qi3ZrY9C9o3nloY8heK6ApIxvZcz3KVAkBbGHPjnVjUCOdxZ+t3JVxn+dLbgDB
         rZoDDcp1kQykVvuwSqmhTgqgMlqyntHU71iS6oJVCAUd6/QQvjkYi8VZu+O5LpEmeSE7
         Jeoao2k+CmmIvF3A7/aq407OY7qRgIb9NEu2ypnge/Bou2ibNgLJNZ+0CNSmKd/W1/Ml
         Q80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oy4WRzt4oy7DKEhEUsk8mM+TKtbIR/SxiJkzCANc2S0=;
        b=IlHIjKZROhmqU0IFJUw8w99zh7KeahZ8QS9d+U72+J9ecl2ERsap43jL/WFJxSCsVU
         5jZUqQVy4TlhkgyPocETL25/3QqvsipMUMjqe/712yWkj+yJJkZMkbrBxyr3UT1sgjwF
         Do20p0MEFpO4w36LpkCmZzTsh/9hMU6JAn1xGkY6lGg3ThKoMXKUCN2UY2Zu+F/1DqZV
         Yg68+xuWdpWhuTjnXqjdL5O8VOHmdtk4EBAdLEHIlW3IT+3BtUeB5vbC1lctj77vQfYA
         vWzA5OcOqNGexx9zuCxswId4m7UqcAGK6vkxCPMPt+zKuBUxADrRYRcsY0nwZBURW6Tx
         XQeg==
X-Gm-Message-State: APjAAAWSzf4mq4HAw35Zyr0HJohu52Fw4+2upJZc75HVRzNYG+UiKyVR
        xpEbKLCxajh5Mt30wlYIdfQ0aA==
X-Google-Smtp-Source: APXvYqw2pOxAB+cTtgkqIYSoU5XivAmb3YXGBRWP38d8Pc5gb206woR1gl2jQ2aHzJG36QtgigSvNQ==
X-Received: by 2002:a19:e619:: with SMTP id d25mr1335729lfh.34.1560438806327;
        Thu, 13 Jun 2019 08:13:26 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k4sm42923ljj.41.2019.06.13.08.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jun 2019 08:13:25 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/5] Add QCS404 interconnect provider driver
Date:   Thu, 13 Jun 2019 18:13:18 +0300
Message-Id: <20190613151323.10850-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add drivers to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

v4:
- Move DT headers into the dt-bindings patch (Bjorn)
- Pick Bjorn's r-b on some patches.
- Return error if platform_device_register_data() fails (Bjorn)
- Use platform_set_drvdata() only in the child device. (Bjorn)
- Hide the smd-rpm proxy driver from config menu. (Bjorn)
- Add remove() function to zero out the rpm handle. (Bjorn)
- Move move the qcs404 driver patch later in the serie. (Bjorn)
- Insert the DT nodes after rng to keep the list sorted by address. (Bjorn)

v3: https://lore.kernel.org/lkml/20190611164157.24656-1-georgi.djakov@linaro.org/
- Drop the patch introducing the qcom,qos DT property.
- Add two new patches to create an interconnect proxy device. This device is
  part of the RPM hardware and handles the communication of the bus bandwidth
  requests.
- Add a DT reg property and move the interconnect nodes under the "soc" node.

v2: https://lore.kernel.org/lkml/20190415104357.5305-1-georgi.djakov@linaro.org/
- Use the clk_bulk API. (Bjorn)
- Move the port IDs into the provider file. (Bjorn)
- Use ARRAY_SIZE in the macro to automagically count the num_links. (Bjorn)
- Improve code readability. (Bjorn)
- Add patch [4/4] introducing a qcom,qos DT property to represent the link to
  the MMIO QoS registers HW block.

v1: https://lore.kernel.org/lkml/20190405035446.31886-1-georgi.djakov@linaro.org/

Bjorn Andersson (1):
  interconnect: qcom: Add QCS404 interconnect provider driver

Georgi Djakov (4):
  dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
  soc: qcom: smd-rpm: Create RPM interconnect proxy child device
  interconnect: qcom: Add interconnect SMD over SMD driver
  arm64: dts: qcs404: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,qcs404.txt     |  46 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  28 +
 drivers/interconnect/qcom/Kconfig             |  12 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/qcs404.c            | 539 ++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c           |  80 +++
 drivers/interconnect/qcom/smd-rpm.h           |  15 +
 drivers/soc/qcom/smd-rpm.c                    |  17 +-
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 +++
 9 files changed, 828 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

