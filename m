Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14F918CC67
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 12:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCTLKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 07:10:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgCTLKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 07:10:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so6943417wrd.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2020 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npvbIJpJHOU/QMgkt/j6Sgv7H0TDgogTzIcvDVQj27w=;
        b=fzmu3H7pFVSFFysiTXVAEQYuqbqxZ9afscWkSb1Seia6EED+CdDzhHQavQu32saqp5
         RUikxe3Q1Rj89zFFB8SCPStDtjsyxnFhp89DkQ2N1GLbZGkqEqKfxBw0tj5nBzsuZRqX
         1PXMVa85Xfx+e8ftTg7IIp1jDkEvaj2gSJWq1dgDxZUGtwyh1Xe0IoMHuQeUTs8EEXWU
         JKCtFnafHv1dxkfhIBKpGja9YwMigLvEyLyiTVRAmpb1XfuCS5oackWfnWU6VOf/35ht
         u3PCgQ7G/ONhcAUvIrp3euFphTcCXzeRm+J3oxlv113vKu37MTq6kg97UJlf/wyFk5Gq
         72TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npvbIJpJHOU/QMgkt/j6Sgv7H0TDgogTzIcvDVQj27w=;
        b=cMDZTkGCnUXKGfWj16gqlP33MQ/Yw4SOxSGgzOglHdgMC2BJhCGcnUTVsZ12ga64YZ
         Vm+oTr72l6BZGjO8ztolp51WKyNMcwTSNvweREiYKLfAdUcGPRS9/eUbOU7V3nMN70yM
         jRFp9NbnK/z9PYOG0LbTC0ajl2TC+1unsI9PzlBZaQrdi5PF8tVDVeT7ZvT+tg/QupKW
         JQa2hKajuKU2KqYWtULSVqi4WWSIXACDhtlwkimUgC4OmQ2B5xTTQ6hH5XcZ/TVMg3lT
         bXzRpO/eKzmnPpwrRK/ykTnIpn5wfCrkanwM4f6K0N1hzIdy4qLl3oBMBikr3q5JDI/s
         oFlA==
X-Gm-Message-State: ANhLgQ34oasjml8cNHMqiTAvvH0zwh8Ay+ME/97PX6nCP5zfIlQFuYQo
        70pcy85PJFkoMO3x9Kk2+v5KkQ==
X-Google-Smtp-Source: ADFU+vsBXxedL1QEHc6ebD5VX+LL4n0+Y+nSWLwTCvzaVTDdF9DKGi8/fQqMPPkNXEYSnv8sZiuCVw==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr523369wrt.213.1584702620903;
        Fri, 20 Mar 2020 04:10:20 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id d21sm7746814wrb.51.2020.03.20.04.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Mar 2020 04:10:20 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect changes for 5.7
Date:   Fri, 20 Mar 2020 13:10:19 +0200
Message-Id: <20200320111019.10970-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

Here is a pull request with interconnect changes for the 5.7-rc1 merge
window. It contains just driver updates, and these are:

- Refactoring of the SDM845 driver, which is now improved to better
represent the hardware.
- New driver for SC7180 platforms.
- New driver for OSM L3 interconnect hardware found on SDM845/SC7180
platforms.

All of these have been in linux-next for more than two weeks without any
reported issues. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.7-rc1

for you to fetch changes up to 03c4e6186bbbe639b5277077c26786069e9e2b89:

  interconnect: qcom: Add OSM L3 support on SC7180 (2020-03-03 19:02:52 +0200)

----------------------------------------------------------------
interconnect changes for 5.7

Here is a pull request with interconnect changes for the 5.7-rc1 merge
window. It contains just driver updates, and these are:

- Refactoring of the SDM845 driver, which is now improved to better
represent the hardware.
- New driver for SC7180 platforms.
- New driver for OSM L3 interconnect hardware found on SDM845/SC7180
platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
David Dai (5):
      dt-bindings: interconnect: Convert qcom,sdm845 to DT schema
      dt-bindings: interconnect: Add YAML schemas for QCOM bcm-voter
      dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
      interconnect: qcom: Consolidate interconnect RPMh support
      interconnect: qcom: sdm845: Split qnodes into their respective NoCs

Odelu Kukatla (2):
      dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings
      interconnect: qcom: Add SC7180 interconnect provider driver

Sibi Sankar (5):
      interconnect: qcom: Allow icc node to be used across icc providers
      dt-bindings: interconnect: Add OSM L3 DT bindings
      interconnect: qcom: Add OSM L3 interconnect provider support
      dt-bindings: interconnect: Add OSM L3 DT binding on SC7180
      interconnect: qcom: Add OSM L3 support on SC7180

 .../devicetree/bindings/interconnect/qcom,bcm-voter.yaml       |   45 +
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |   62 +
 .../devicetree/bindings/interconnect/qcom,sc7180.yaml          |   85 +
 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt |   24 -
 .../devicetree/bindings/interconnect/qcom,sdm845.yaml          |   74 +
 drivers/interconnect/qcom/Kconfig                              |   25 +
 drivers/interconnect/qcom/Makefile                             |    8 +
 drivers/interconnect/qcom/bcm-voter.c                          |  366 +++
 drivers/interconnect/qcom/bcm-voter.h                          |   27 +
 drivers/interconnect/qcom/icc-rpmh.c                           |  150 +
 drivers/interconnect/qcom/icc-rpmh.h                           |  149 +
 drivers/interconnect/qcom/osm-l3.c                             |  276 ++
 drivers/interconnect/qcom/sc7180.c                             |  641 +++++
 drivers/interconnect/qcom/sc7180.h                             |  151 ++
 drivers/interconnect/qcom/sdm845.c                             | 1055 +++-----
 drivers/interconnect/qcom/sdm845.h                             |  142 +
 include/dt-bindings/interconnect/qcom,osm-l3.h                 |   12 +
 include/dt-bindings/interconnect/qcom,sc7180.h                 |  161 ++
 include/dt-bindings/interconnect/qcom,sdm845.h                 |  263 +-
 19 files changed, 2875 insertions(+), 841 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
 create mode 100644 drivers/interconnect/qcom/bcm-voter.c
 create mode 100644 drivers/interconnect/qcom/bcm-voter.h
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.c
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.h
 create mode 100644 drivers/interconnect/qcom/osm-l3.c
 create mode 100644 drivers/interconnect/qcom/sc7180.c
 create mode 100644 drivers/interconnect/qcom/sc7180.h
 create mode 100644 drivers/interconnect/qcom/sdm845.h
 create mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h
