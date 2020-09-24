Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8D2771C0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIXNCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbgIXNCq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 09:02:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A24BC0613CE
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:02:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so3502678wmb.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wd72o99dI8O+8Erl62aPyt+op0c7sTjoUw8Lqij53Ck=;
        b=vgTkw2TNrI3qaJi7wfvHs5SXCUj+o0oDCjpQnhdcNZkAi7ShmJ03yyrI3MRrUd34Db
         y7VvUO1XFFmGeKumZnQa9gNI3bTJUpeWE5gM44PI+Y307RsWKPYjRSd2JRWVwjtFCwb2
         c8b/cUeDgNT7EhKZw3DXkzJ53k8NWkyWDd8L6XPfIbedo+j7ySF0v5Q0DqMnune2om6N
         v4spXNLNEnKG9ajWetvtAzybNNLQ6+RyaTXmabXV02CijRM1xP7em57wNw7klz0FN9VM
         wR+y4cwkbTe0OjE7emamEu9zatGvPjrsgaraTo+ormxbFZcEeZut6O4T4ig6KWWDZuJ7
         83xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wd72o99dI8O+8Erl62aPyt+op0c7sTjoUw8Lqij53Ck=;
        b=sQCj3A3suQS9iU8HdxJ0XfdOFAUYKJp9C6O35Yu7ah+nK4DwQzAzmkCRMRIsKs+63n
         s86x7O2OT7oiUY00nmI5ggHjUnKavoaDYwrEYgkfywCHwrkZWO0zEmd/NwtJ5nSAFvQH
         n8dyhqMYC6SufpoJM4vLDO5pZvSnFguDAkJ6uAPmJgRaGWEL8xVcKPCMbQ8cJl7XCq6w
         sXYkWNhiihG69wUvv56DVWY4gHYNyDc6Jz2Efw7Vfd8efHekkAGHP0pPZ/wzvpVr/VYt
         2ahaB8yiPtUy8A6wjl04NPJtob6jUBnDlVQBFxzsSmc7QZI4dotmucax2KO5azo09VCn
         uXIQ==
X-Gm-Message-State: AOAM5332S+39QeWNhc8h+SCX78fzGGRUBRNmVYwWbEl5oa8NPq4TKV2n
        qJh+Jed8nx13eP2lMUfwkzHZFA1YxaKkUA==
X-Google-Smtp-Source: ABdhPJxlNkv36npEGmirFkkM24uP+RpBoZpt4cCa2RcZXhcKgTHRUMCtNZq9fNmdpDxKf8X4qh3PSQ==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr4653554wmc.123.1600952564762;
        Thu, 24 Sep 2020 06:02:44 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id v204sm3498579wmg.20.2020.09.24.06.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 06:02:44 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect changes for 5.10
Date:   Thu, 24 Sep 2020 16:02:42 +0300
Message-Id: <20200924130242.24867-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.10-rc1
merge window. It contains both core changes and new drivers. More details
are available in the signed tag.

All patches have been in linux-next without any reported issues. Please
pull into char-misc-next.

Thanks,
Georgi

The following changes since commit 91e045b93db79a2ef66e045ad0d1f8f9d348e1f4:

  interconnect: qcom: Fix small BW votes being truncated to zero (2020-09-04 00:07:12 +0300)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.10-rc1

for you to fetch changes up to 86d6e5793e0fa3a510cff466894d0d3051fd716e:

  interconnect: imx: simplify the return expression of imx_icc_unregister (2020-09-21 11:15:02 +0300)

----------------------------------------------------------------
interconnect changes for 5.10

Here are the interconnect changes for the 5.10-rc1 merge window
consisting of core changes, new drivers and cleanups.

Core changes:
 - New bulk API helpers for managing multiple interconnect paths.
 - New xlate_extended() interface for parsing additional data from DT.
 - Support for sync_state().

Driver changes:
 - New drivers for SM8150 and SM8250 platforms.
 - New drivers for the Qualcomm OSM and EPSS hardware blocks.
 - Per-BCM scaling factor support.
 - Misc cleanups.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (9):
      interconnect: Add bulk API helpers
      interconnect: Introduce xlate_extended() callback
      dt-bindings: interconnect: Document the support of optional path tag
      interconnect: qcom: Implement xlate_extended() to parse tags
      interconnect: qcom: sdm845: Replace xlate with xlate_extended
      interconnect: Add get_bw() callback
      interconnect: Add sync state support
      interconnect: qcom: Use icc_sync_state
      Merge branch 'icc-syncstate' into icc-next

Jonathan Marek (5):
      dt-bindings: interconnect: single yaml file for RPMh interconnect drivers
      dt-bindings: interconnect: Add Qualcomm SM8150 DT bindings
      dt-bindings: interconnect: Add Qualcomm SM8250 DT bindings
      interconnect: qcom: Add SM8150 interconnect provider driver
      interconnect: qcom: Add SM8250 interconnect provider driver

Krzysztof Kozlowski (2):
      interconnect: core: Simplify with dev_err_probe()
      interconnect: imx: Simplify with dev_err_probe()

Liu Shixin (1):
      interconnect: imx: simplify the return expression of imx_icc_unregister

Mike Tipton (5):
      dt-bindings: interconnect: Add generic qcom bindings
      dt-bindings: interconnect: Add property to set BCM TCS wait behavior
      interconnect: qcom: Support bcm-voter-specific TCS wait behavior
      interconnect: qcom: Only wait for completion in AMC/WAKE by default
      interconnect: qcom: Add support for per-BCM scaling factors

Sibi Sankar (6):
      interconnect: qcom: sc7180: Replace xlate with xlate_extended
      dt-bindings: interconnect: Add OSM L3 DT binding on SM8150
      interconnect: qcom: Add OSM L3 support on SM8150
      interconnect: qcom: Lay the groundwork for adding EPSS support
      dt-bindings: interconnect: Add EPSS L3 DT binding on SM8250
      interconnect: qcom: Add EPSS L3 support on SM8250

Stephen Boyd (1):
      interconnect: qcom: osm-l3: Mark more structures const

 Documentation/devicetree/bindings/interconnect/interconnect.txt |  24 +-
 .../devicetree/bindings/interconnect/qcom,bcm-voter.yaml        |  20 +
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml |   2 +
 .../bindings/interconnect/{qcom,sdm845.yaml => qcom,rpmh.yaml}  |  42 +-
 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml |  85 -
 drivers/interconnect/Makefile                                   |   2 +-
 drivers/interconnect/bulk.c                                     | 117 ++
 drivers/interconnect/core.c                                     | 140 +-
 drivers/interconnect/imx/imx.c                                  |  13 +-
 drivers/interconnect/qcom/Kconfig                               |  20 +
 drivers/interconnect/qcom/Makefile                              |   4 +
 drivers/interconnect/qcom/bcm-voter.c                           |  36 +-
 drivers/interconnect/qcom/icc-rpmh.c                            |  30 +
 drivers/interconnect/qcom/icc-rpmh.h                            |  21 +-
 drivers/interconnect/qcom/osm-l3.c                              |  91 +-
 drivers/interconnect/qcom/sc7180.c                              |   3 +-
 drivers/interconnect/qcom/sdm845.c                              |   3 +-
 drivers/interconnect/qcom/sm8150.c                              | 635 +++++++
 drivers/interconnect/qcom/sm8150.h                              | 154 ++
 drivers/interconnect/qcom/sm8250.c                              | 651 ++++++++
 drivers/interconnect/qcom/sm8250.h                              | 164 ++
 include/dt-bindings/interconnect/qcom,icc.h                     |  26 +
 include/dt-bindings/interconnect/qcom,osm-l3.h                  |   3 +
 include/dt-bindings/interconnect/qcom,sm8150.h                  | 162 ++
 include/dt-bindings/interconnect/qcom,sm8250.h                  | 172 ++
 include/linux/interconnect-provider.h                           |  24 +-
 include/linux/interconnect.h                                    |  22 +
 27 files changed, 2490 insertions(+), 176 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm845.yaml => qcom,rpmh.yaml} (60%)
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 create mode 100644 drivers/interconnect/bulk.c
 create mode 100644 drivers/interconnect/qcom/sm8150.c
 create mode 100644 drivers/interconnect/qcom/sm8150.h
 create mode 100644 drivers/interconnect/qcom/sm8250.c
 create mode 100644 drivers/interconnect/qcom/sm8250.h
 create mode 100644 include/dt-bindings/interconnect/qcom,icc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8250.h
