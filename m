Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C54E9F37
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfJ3PjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:39:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45795 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfJ3PjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:39:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so2815576wrs.12
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zoa220jXmWpJ41gMsQ0hUuRQ4kSo+VniK6NVUshbryM=;
        b=wyo3ydyGQnIISMU0jYriaUuAbGrqh7cO9VgyWYCgP7UiB8cKxr7aeP2hpaB0kNURvw
         wKXK0DhyBjfLgQDimAzkqf3NWui8DEzscQeL3VVCaP0jg0n7i2lhpyDZOk3Jgn9xTaJR
         9r90KG3LR54Lk81ILoq7gEWeFHnuGIhkNxzBmOfbvAZzM7XE9VH1ubiUGy9mJ8zKzC4d
         0tv+aXT+gIcEKlos5NJVliZytOi+4RElMSsGcJz1zP8NAGGH5dG+9Ss4caJ/PNMDGaLO
         4S+4V3yHBMTGbcejPX7zgip6I5O1SAoLNRD+dvRrFGCVUg1GsaA7n+3TU18fjXDeN8nM
         F9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zoa220jXmWpJ41gMsQ0hUuRQ4kSo+VniK6NVUshbryM=;
        b=i51OTRH65BMsaSHBPs1xElVFFXlTJY1rK+NYoBn29XXVHyDYekYImsD9vaHkB70xbi
         OpxcbcVzloyf+vRCp6IgGp3/rNqJjk9C6VM4Xnpv4Pf+x4FQU8pNsMQzXfhB8rrA/lb2
         iXFsiGeGzHDTECbKMjTwZrQFgyiXnTR5ACCkJKeLGiN486kf4K1o67QAQTecWsGDOGty
         nZY58bx85NR8iyLeYP6Kc5PgbvsTctWIuaPBY4fc4OX+IooDId6m7ewthpNDRuAD0Gy6
         Io7SS6wEuhIaTRRVmWnlJk+ptrt0304Yq3XJ4s9N97kf7ZrRQaoePsKJTTNbWC24/sZP
         S5oQ==
X-Gm-Message-State: APjAAAVYS2s5CHvcy8QribG0fD1adt8ZcYmoCwZtea/4quRxucX47+kw
        H9qYIO2WV2cCCqwARUCkGNV2PA==
X-Google-Smtp-Source: APXvYqwyj1s84wyLCrVCoj+s/7FLBdkMYP8Eb4htH2OWV6oqvUKOdVl03/LsvMOKt/UiHP3SDc3a3Q==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr459626wrq.70.1572449945715;
        Wed, 30 Oct 2019 08:39:05 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o25sm725524wro.21.2019.10.30.08.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Oct 2019 08:39:05 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, linux-pm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        vincent.guittot@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 0/3] Add MSM8916 interconnect provider driver
Date:   Wed, 30 Oct 2019 17:39:01 +0200
Message-Id: <20191030153904.8715-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add driver to support scaling of the on-chip interconnects on the
MSM8916-based platforms. Also add the necessary device-tree nodes,
so that the driver for each NoC can probe and register as interconnect
provider.

v10:
- Converted binding to DT schema.
- Use local number space per each NoC in DT.

- Rebased the old patch and resolved conflicts.
- Dropped some unused QoS related code.
- Switched to using the clk_bulk API.
- Improved commit texts.
- Minor changes.

v9:
https://lore.kernel.org/r/20180831140151.13972-7-georgi.djakov@linaro.org
https://lore.kernel.org/r/20180831140151.13972-8-georgi.djakov@linaro.org

Georgi Djakov (3):
  dt-bindings: interconnect: Add Qualcomm MSM8916 DT bindings
  interconnect: qcom: Add MSM8916 interconnect provider driver
  arm64: dts: msm8916: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,msm8916.yaml   |  77 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  28 +
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/msm8916.c           | 572 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8916.h   | 100 +++
 6 files changed, 788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
 create mode 100644 drivers/interconnect/qcom/msm8916.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h

