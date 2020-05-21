Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDAE1DCE5A
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgEUNnO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEUNnN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 09:43:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C257C061A0F
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 06:43:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bs4so6682947edb.6
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kv3PB9wb/wTnULVt6rW456QQSCHxUuU+u2kd5HsXFSA=;
        b=wulC+tnglgyhGMSdT6DZFLpctmLDnJNhtEKCeB5npgtmCLRhAFH8453Zoqk9iGsM5x
         pif9liQjJFGBwEOzMOJ/xIiwdSLHH0pt+FEi3eoUWJzprw11Fiq24bWmc4XEirb6zlJV
         /h9AKdWYrTCzKLJzKJUc5k3uRtHzGqkrg04EsnRaCz75nzGkezXx+C0H9LvH9PR/BV7j
         TdOblOQR+XJZYMbd6tKg52mjAiYxT6X+ySn5q6FVAXMnk1wSyf201xuGjx0sjPslh52K
         5EP6lK3WdY/S5bCZswyBCaDP+2YKkx9eC/y73m6kb3AByuToQ2vriW9UXdoZZE1uerGs
         tZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kv3PB9wb/wTnULVt6rW456QQSCHxUuU+u2kd5HsXFSA=;
        b=YFCgHF2YE80VGOH7rKz6Q3gaWspAkHSQKzuxWwI0jQUbKQDwlvNswZMRFbVZeGupW5
         uir55fZEwZioUMW7ncE4s0rzCSsq51A8ekz/7cMFxp+/Nqq8Qt+9pJL9CezVApDmqXmx
         j4V0qefykOEpFR8FJZTftKfU4WtNQZcd3XfFhZj8Tb0tAbbGZxUyKSvsIosk8almYVRH
         2GqldQcejZuvFLf98McibxsspVBy1WFl1wTEXL3ragd743fJ2fcPWdg4Ulr4PAzsQhTS
         cqR1ofiNYpMTaTHgizF/xnO1c3Wy8b/xA8Bh59768SCNAjf8JvC9apNjZzqqzivJPZg+
         +Kvw==
X-Gm-Message-State: AOAM533niZE2/056v9uuBP5Eypj4clD/GN72G4vKajyjiVGM/CrbQI8p
        IgzYHhV0JFC5STNWRXoGyL60dZqeFUZ3kw==
X-Google-Smtp-Source: ABdhPJxcIj6vHTvfT/o9DjWujtWYm4Nk+uepuZSOpFuPq2VWIa5FcqoXYYaVv5zSvsSQgNrtslNcBw==
X-Received: by 2002:a05:6402:948:: with SMTP id h8mr7521971edz.127.1590068591589;
        Thu, 21 May 2020 06:43:11 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id mf18sm4974656ejb.16.2020.05.21.06.43.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 06:43:10 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect changes for 5.8
Date:   Thu, 21 May 2020 16:43:04 +0300
Message-Id: <20200521134304.31099-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.8-rc1
merge window. It contains some core framework changes (helper functions,
conversion of the framework from tristate to bool, etc). Some of these
are in immutable branch, which is shared with the OPP tree. There are
also new drivers for several i.MX8 platforms. More details are available
in the signed tag.

Patches have been in linux-next without any reported issues. Please pull
into char-misc-next.

Thanks,
Georgi

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.8-rc1

for you to fetch changes up to b35da2e86f256a3a4be7c3b31507016100b00847:

  Merge branch 'icc-get-by-index' into icc-next (2020-05-15 10:46:18 +0300)

----------------------------------------------------------------
interconnect changes for 5.8

These are the interconnect changes for the 5.8-rc1 merge window:

Core changes:
- Convert the framework core from tristate to bool to make handling
dependencies between other core frameworks easier
- Add of_icc_get_by_index()
- Add devm_of_icc_get() helper function
- Add icc_enable() and icc_disable() helpers

New drivers:
- Platform driver for NXP i.MX8MM SoC
- Platform driver for NXP i.MX8MN SoC
- Platform driver for NXP i.MX8MQ SoC

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Akash Asthana (1):
      interconnect: Add devm_of_icc_get() as exported API for users

Georgi Djakov (3):
      interconnect: Add helpers for enabling/disabling a path
      interconnect: Add of_icc_get_by_index() helper function
      Merge branch 'icc-get-by-index' into icc-next

Jordan Crouse (1):
      interconnect: Remove unused module exit code from core

Leonard Crestez (5):
      dt-bindings: interconnect: Add bindings for imx8m noc
      interconnect: Add imx core driver
      interconnect: imx: Add platform driver for imx8mm
      interconnect: imx: Add platform driver for imx8mq
      interconnect: imx: Add platform driver for imx8mn

Viresh Kumar (1):
      interconnect: Disallow interconnect core to be built as a module

Wei Yongjun (1):
      interconnect: imx: Fix return value check in imx_icc_node_init_qos()

 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         | 101 +++
 drivers/interconnect/Kconfig                                    |   3 +-
 drivers/interconnect/Makefile                                   |   1 +
 drivers/interconnect/core.c                                     | 143 +++-
 drivers/interconnect/imx/Kconfig                                |  17 +
 drivers/interconnect/imx/Makefile                               |   9 +
 drivers/interconnect/imx/imx.c                                  | 284 ++++++++
 drivers/interconnect/imx/imx.h                                  |  61 ++
 drivers/interconnect/imx/imx8mm.c                               | 105 +++
 drivers/interconnect/imx/imx8mn.c                               |  94 +++
 drivers/interconnect/imx/imx8mq.c                               | 103 +++
 drivers/interconnect/internal.h                                 |   2 +
 include/dt-bindings/interconnect/imx8mm.h                       |  50 ++
 include/dt-bindings/interconnect/imx8mn.h                       |  41 ++
 include/dt-bindings/interconnect/imx8mq.h                       |  48 ++
 include/linux/interconnect.h                                    |  25 +
 16 files changed, 1061 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx.c
 create mode 100644 drivers/interconnect/imx/imx.h
 create mode 100644 drivers/interconnect/imx/imx8mm.c
 create mode 100644 drivers/interconnect/imx/imx8mn.c
 create mode 100644 drivers/interconnect/imx/imx8mq.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h
 create mode 100644 include/dt-bindings/interconnect/imx8mn.h
 create mode 100644 include/dt-bindings/interconnect/imx8mq.h
