Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B723DEBB6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhHCL1s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 07:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235429AbhHCL1r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 07:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 984DC60555;
        Tue,  3 Aug 2021 11:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627990056;
        bh=2Hnb/SYH4D/freRinp9WTMeqInAJxPAyRYnQK2gIqeI=;
        h=From:To:Cc:Subject:Date:From;
        b=RdDnH4K9gqTHFeXRdHD/lcDeAc3tTG+KNvkyPaMlsCtrQixs0hrsQVMxaH6lMo+BM
         yZ+YeRGHNgIanxihv5ofTr7/BTqritg/ul+Ct64fXk3FvzBjzTH8bu0Pm0BvrCPY/R
         rP5ALiFyz+hSrT/rrxUFzgtOkIuxdcxy4UT/FXlx1Q1Y4Ghdms0ZD5iJ+jIkH7/9Zn
         pwshQ48YWkqwbTLCpFOHMuSQvoqO2ao1LBFDiNDT2OpvvmUOVNTE/hDk1bDJKy7wl/
         QtorgFR0auhFbcXR8rv0EOMSRPY6FOCzOzhmBiQy+FrER/ey9s9LJ+gR0qWaFlHlQL
         DLsBoN+TpTaQA==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 5.14-rc
Date:   Tue,  3 Aug 2021 14:27:33 +0300
Message-Id: <20210803112733.9408-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This pull request contains interconnect core and driver fixes for 5.14-rc.
The details are in the signed tag. Please pull them into char-misc-linus
when possible. The patches have been also in linux-next.

Thanks,
Georgi

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.14-rc5

for you to fetch changes up to 85b1ebfea2b0d8797266bcc6f04b6cc87e38290a:

  interconnect: Fix undersized devress_alloc allocation (2021-08-02 12:25:00 +0300)

----------------------------------------------------------------
interconnect fixes for v5.14

This contains a few core and driver fixes that have been reported.
- core: Fix undersized devres_alloc allocation
- core: Zero initial BW after sync-state
- core: Always call pre_aggregate before aggregate
- qcom: rpmh: Ensure floor BW is enforced for all nodes
- qcom: rpmh: Add BCMs to commit list in pre_aggregate

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Colin Ian King (1):
      interconnect: Fix undersized devress_alloc allocation

Mike Tipton (4):
      interconnect: Zero initial BW after sync-state
      interconnect: Always call pre_aggregate before aggregate
      interconnect: qcom: icc-rpmh: Ensure floor BW is enforced for all nodes
      interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

 drivers/interconnect/core.c          |  9 ++-
 drivers/interconnect/qcom/icc-rpmh.c | 22 ++++----
 2 files changed, 18 insertions(+), 13 deletions(-)
