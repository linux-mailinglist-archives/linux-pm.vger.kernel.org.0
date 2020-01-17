Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575AA14070E
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgAQJ6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40625 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgAQJ6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so22039913wrn.7
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DpksFiKzXK/7fbjaj2c/nORGzAHYKUMZjuznhKyE/A=;
        b=nuMqJZxdVCCX+n+/YxBgdJ4TpjiSJVZnJXxlMxWZRz5RgIOiFYS+B7F9Lalf7GYqD5
         gL4X5DKiJkg23Ks1lIataIP1G38YOHhmqbGFGR9w24l5SsL5EaGvN11+LkOFTPgGLCxW
         6Rbgrn/5iqPZWPvBdqxaKDmOEY8NBgyexRv6+dHdeTT9geZrYol5UVWoSwjloEyGGgS5
         bzxP1eQHhfo2m5Ym9d0eTLPNIrwFA5wynjZ4dpBdq6xLzs58GSthNml/UlP/FOV4aUfH
         DnkuxVlQbHfLSkxr4eupfZBe2mhwiGNDcz4YGRahN1qpv8lrerxUl6QnrejKNzl9xcTf
         SpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DpksFiKzXK/7fbjaj2c/nORGzAHYKUMZjuznhKyE/A=;
        b=erzC7H/lcqshcttzOvgHo1VqO+2wFDMKnK3DgpvA9j5DdG78yXe2rPsaNHEsFoaI+E
         iFzdyQqboJ7e98BbwAaSCaaJTaiysiV07fJVH/lQjguoLyx4mRNRZv3d41laygOUC86k
         ag7/E+xWIbAprLWogPbbkU6zyww/RLVEzG2y4Org0UHYu9oEsJgzqgjwu/0YEotJvOCI
         VgbhRVS1PSJIO4OeIzT9PeWE1yRkCUdBOH6cmc7pwfD+8dWHVeWTUOnLRbvHkhmksSxD
         ap2oKk60tXOW3FwJqyBMkcf6D9CydFOhZ/VAmYoMnWpuILnYKFZBfPOOPFY1/J/8op6k
         rdOA==
X-Gm-Message-State: APjAAAUzL1WEY0QDwnje+zEdrUNBamWlT0cuyMr2J0/BwKVkFTsyqdd4
        w/BnI0QAYtnpcTYjANubOti48Q==
X-Google-Smtp-Source: APXvYqxgv93anb8pi24i+uB0+YmE6QHeeOW/Hzg9agECyryjOkofzsGOP7q/qxpz40T7xjs7Posn6g==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr2074508wrp.238.1579255098341;
        Fri, 17 Jan 2020 01:58:18 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:17 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL 00/12] interconnect changes for 5.6
Date:   Fri, 17 Jan 2020 11:58:04 +0200
Message-Id: <20200117095816.23575-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

Here are the interconnect patches for the 5.6-rc1 merge window.

- New core helper functions for some common functionalities in drivers.
- Improvements in the information exposed via debugfs.
- Basic tracepoints support.
- New interconnect driver for msm8916 platforms.
- Misc fixes.

All patches have been for a while in linux-next without reported issues.
Please consider queuing them into char-misc-next.

The same is also available via a pull request with a signed tag below.

Thanks,
Georgi

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.6-rc1

for you to fetch changes up to 30c8fa3ec61a46da80698e1f8ab95df4d42bf374:

  interconnect: qcom: Add MSM8916 interconnect provider driver (2020-01-07 09:30:09 +0200)

----------------------------------------------------------------
interconnect patches for 5.6

Here are the interconnect patches for the 5.6-rc1 merge window.

- New core helper functions for some common functionalities in drivers.
- Improvements in the information exposed via debugfs.
- Basic tracepoints support.
- New interconnect driver for msm8916 platforms.
- Misc fixes.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (11):
  interconnect: Add a common helper for removing all nodes
  interconnect: qcom: Use the new common helper for node removal
  interconnect: Move internal structs into a separate file
  interconnect: Add a name to struct icc_path
  interconnect: Add basic tracepoints
  interconnect: Add a common standard aggregate function
  interconnect: qcom: Use the standard aggregate function
  interconnect: Print the tag in the debugfs summary
  interconnect: Check for valid path in icc_set_bw()
  dt-bindings: interconnect: Add Qualcomm MSM8916 DT bindings
  interconnect: qcom: Add MSM8916 interconnect provider driver

Leonard Crestez (1):
  interconnect: Add interconnect_graph file to debugfs

 .../bindings/interconnect/qcom,msm8916.yaml   |  77 +++
 Documentation/driver-api/interconnect.rst     |  22 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/core.c                   | 168 ++++--
 drivers/interconnect/internal.h               |  42 ++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/msm8916.c           | 554 ++++++++++++++++++
 drivers/interconnect/qcom/msm8974.c           |  32 +-
 drivers/interconnect/qcom/qcs404.c            |  32 +-
 drivers/interconnect/qcom/sdm845.c            |  16 +-
 drivers/interconnect/trace.h                  |  88 +++
 .../dt-bindings/interconnect/qcom,msm8916.h   | 100 ++++
 include/linux/interconnect-provider.h         |  14 +
 14 files changed, 1057 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
 create mode 100644 drivers/interconnect/internal.h
 create mode 100644 drivers/interconnect/qcom/msm8916.c
 create mode 100644 drivers/interconnect/trace.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h

