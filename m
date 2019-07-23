Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A971A30
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfGWOXq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:23:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35059 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfGWOXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 10:23:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so41292563ljh.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AfmBNaL5E4IPJmKdMV2SCuy4Cu3rlWh8uwGgLbEmbFM=;
        b=W1Hsltn/PzpLrnoaWRqRp1OUKhzZJMMWUI8BCSasX/PgRZd1Qxfm2Und7B1l7R64no
         H8LuA6SkYvaE7USu+iLDJK5unGUtYCMM16I904/sPrwW+5f3rEf2Nxb3JRpw+5Rzs9rh
         mioF/VkNaWj5iXr3XHsGKGmGOjxBRP7fD/Y+TFx7LhNCgywpQWsDAtxHLzNzdWPzDcvo
         G9J3ZHSwZ7Zs0cHB27WlKBQSGB8tlEAQyckUAFG33ZIXoYlhBzgfUEJCSPmlIjkDcTaa
         qo59TIq9HhS33Ao4a+9u5FrgvotNM2gGQsN9Uwn2M8tIV1qBhT/BACmVH+HIbRzp4RjV
         XuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AfmBNaL5E4IPJmKdMV2SCuy4Cu3rlWh8uwGgLbEmbFM=;
        b=Pg0UdixY5BRPiM99Baq8YUnEpt1rHiCPE+bbaeiABieLIR5CqBRKomlSKHfs/3cyH/
         CObuTi3aCvZrGxNXW9OdbUHNGmH9UHhbGdkNdzkH57LErIu+vKhZyvLaOyOYKv1k2X8j
         CRut7JiPJP70poY04RrNRJrVqVZ3x4P7hJeuteDA0FvcPX3mwtUJU1NEpE7YulDYqd00
         3KvrGy60c3Cy0PzHY63gqHJYTMa4S0HDOVQ0waZsUiRBbEkmrlpZYW8ZUU2hwmSCs06A
         voKIGyGiFV0vOM8V4dSgJHyVk79Ozx2GiE/eZauEVCaMgveMRDPvPQ6Y+rd4VaC8BIiV
         Qqzw==
X-Gm-Message-State: APjAAAW6TbyLP/j5toR7SqC0t1BexnNXsDlvLweIUsjqAQi9aO59bx8O
        oKyaBtHwRpcFHsRQvN4iDmqW9g==
X-Google-Smtp-Source: APXvYqyswV5/+ZqUIEC5Sb3W3vsjuQ3xufsmaRFCCm6KVRinDL/Bj8ZQzyK6revZwBx/kkSAwe84tQ==
X-Received: by 2002:a2e:3211:: with SMTP id y17mr3422532ljy.86.1563891823902;
        Tue, 23 Jul 2019 07:23:43 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z17sm8048519ljc.37.2019.07.23.07.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jul 2019 07:23:43 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/5] Add QCS404 interconnect provider driver
Date:   Tue, 23 Jul 2019 17:23:34 +0300
Message-Id: <20190723142339.27772-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add drivers to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

The plan is to get patches 2,5 through the Qcom/ARM tree and the rest
through the interconnect tree.

v5:
- Make reg and clocks DT properties required. (Bjorn)
- Remove _clk suffix from clock names. (Bjorn)
- Use the more succinct return !!icc_smd_rpm; (Bjorn)

v4: https://lore.kernel.org/lkml/20190613151323.10850-1-georgi.djakov@linaro.org/
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

 .../bindings/interconnect/qcom,qcs404.txt     |  45 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  28 +
 drivers/interconnect/qcom/Kconfig             |  12 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/qcs404.c            | 539 ++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c           |  77 +++
 drivers/interconnect/qcom/smd-rpm.h           |  15 +
 drivers/soc/qcom/smd-rpm.c                    |  17 +-
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 +++
 9 files changed, 824 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

