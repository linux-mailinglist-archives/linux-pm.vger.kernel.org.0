Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C434ACCA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 17:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZQqT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 12:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhCZQqH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Mar 2021 12:46:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B181E619DC;
        Fri, 26 Mar 2021 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616777166;
        bh=ySHsI6khIU76uTuOiE+nqycqkX0Uih0vLk+zEBZVABA=;
        h=From:To:Cc:Subject:Date:From;
        b=pJQWoIxmpGhFpSnYwbRDHCZeiQfQrId64iRgXtVnn94nMpz5jNC39RfWo48U5O3Oh
         8ngNaE2p1dLFXHA4lbnfQ47ssVTYNHCMpgHpTfyKtk97j02s145r03eDX6/CguyghX
         Ms0t32944NufwJsaomnoqZOUxa/xs/AyqE8wsFPHJ4Hc9vBI13AMDEdPaJncKbPtct
         4BdedU7zXaGdf80JE6GGBMWyYFCQhRTLNFrui43AFj9jhv85j04z26TPCrZmef+bpo
         g2emhH+Ujn7tE5ddi+1rba9R+Ca6jkUdDFJmYynsmQtCddnjw9pTxH3FUD3XVFkzxa
         WZ0nOo+TSWfbQ==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, Georgi Djakov <djakov@kernel.org>
Subject: [GIT PULL] interconnect fixes for 5.12-rc
Date:   Fri, 26 Mar 2021 18:46:03 +0200
Message-Id: <20210326164603.28202-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

Here is a pull request with a few tiny interconnect fixes for 5.12-rc.
The details are in the signed tag. Please take them into char-misc-linus
when possible. The patches have been in linux-next for more than a week.

Thanks,
Georgi

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.12-rc5

for you to fetch changes up to 491aef7caeb345ccfd658a7fc8a42944a7f82494:

  interconnect: Fix kerneldoc warning (2021-03-18 23:46:21 +0200)

----------------------------------------------------------------
interconnect fixes for v5.12

This contains a few tiny drivers and core fixes that have been
reported during this cycle.

- msm8939: Remove rpm-ids from non-RPM nodes
- core: Fix error return code of icc_link_destroy()
- core: Fix kerneldoc warning

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Benjamin Li (1):
      interconnect: qcom: msm8939: remove rpm-ids from non-RPM nodes

Georgi Djakov (1):
      interconnect: Fix kerneldoc warning

Jia-Ju Bai (1):
      interconnect: core: fix error return code of icc_link_destroy()

 drivers/interconnect/bulk.c         |  2 +-
 drivers/interconnect/core.c         |  2 +
 drivers/interconnect/qcom/msm8939.c | 16 ++++----
 3 files changed, 11 insertions(+), 9 deletions(-)
