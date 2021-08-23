Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539FE3F4D8C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 17:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhHWPdI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 11:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhHWPdH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Aug 2021 11:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D18886103D;
        Mon, 23 Aug 2021 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629732745;
        bh=ngUR+MM/ilv8/jLT7nHf2++cpL+J4qBSF8Vka7YyoY0=;
        h=From:To:Cc:Subject:Date:From;
        b=RtXIJemwdhAtD2pzbMPF7rZgDfQ+mu71sEusgpCLzJAfRJFMmO1jeuhKTrIXLj5jh
         aeXbcX5JmRQY6Icf3pq/97tPvCWz0+16iHxctGd96oxw1RC1yYRJJ4jnXVxOvoak2i
         hC4K1B5EHLqkP3+TMLqnG32hGwP9xmaYyUkq1WsmpGPJ7asHwHql+a+EQgmnMVdbVv
         Mz/yNXNjoPeQ7uZI2bse7Qi5nmB1T7YF2/O/1I2pxJJXvKm2ykDS7KXIvp3OSwFqei
         lwmJfamM42T5AXuX71NK7gexmueQ8Rp2EGFUwn4NeQsUDtZ9YQl470ZOLi1epADSnh
         3N73OGBoPBJ6g==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 5.15
Date:   Mon, 23 Aug 2021 18:32:22 +0300
Message-Id: <20210823153222.9638-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.15-rc1
merge window containing framework and driver changes. Details are available
in the signed tag.

Patches have been in linux-next for two weeks and without any reported
issues. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.15-rc1

for you to fetch changes up to 8bf5d31c4f06d806ae24a3ba998a2f4eaccfa7c1:

  interconnect: qcom: osm-l3: Use driver-specific naming (2021-08-09 20:10:19 +0300)

----------------------------------------------------------------
interconnect changes for 5.15

Here are changes for the 5.15-rc1 merge window consisting of interconnect
core and driver updates.

Framework change:
- Add sanity check to detect if node is already added to provider.

Driver changes:
- RPMh drivers probe function consolidation
- Add driver for SC8180x platforms
- Add support for SC8180x OSM L3
- Use driver-specific naming in OSM L3

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Bjorn Andersson (4):
      interconnect: Sanity check that node isn't already on list
      dt-bindings: interconnect: Add SC8180x to OSM L3 DT binding
      interconnect: qcom: osm-l3: Add sc8180x support
      interconnect: qcom: osm-l3: Use driver-specific naming

Georgi Djakov (2):
      dt-bindings: interconnect: Add Qualcomm SC8180x DT bindings
      interconnect: qcom: Add SC8180x providers

Mike Tipton (1):
      interconnect: qcom: icc-rpmh: Consolidate probe functions

 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml |   1 +
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml   |  11 +
 drivers/interconnect/core.c                                     |   3 +
 drivers/interconnect/qcom/Kconfig                               |   9 +
 drivers/interconnect/qcom/Makefile                              |   2 +
 drivers/interconnect/qcom/icc-rpmh.c                            |  93 ++
 drivers/interconnect/qcom/icc-rpmh.h                            |   2 +
 drivers/interconnect/qcom/osm-l3.c                              |  60 +-
 drivers/interconnect/qcom/sc7180.c                              |  96 +-
 drivers/interconnect/qcom/sc7280.c                              |  96 +-
 drivers/interconnect/qcom/sc8180x.c                             | 626 ++++++++
 drivers/interconnect/qcom/sc8180x.h                             | 174 ++
 drivers/interconnect/qcom/sdm845.c                              |  99 +-
 drivers/interconnect/qcom/sdx55.c                               |  96 +-
 drivers/interconnect/qcom/sm8150.c                              |  96 +-
 drivers/interconnect/qcom/sm8250.c                              |  96 +-
 drivers/interconnect/qcom/sm8350.c                              |  97 +-
 include/dt-bindings/interconnect/qcom,sc8180x.h                 | 185 +++
 18 files changed, 1159 insertions(+), 683 deletions(-)
 create mode 100644 drivers/interconnect/qcom/sc8180x.c
 create mode 100644 drivers/interconnect/qcom/sc8180x.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sc8180x.h
