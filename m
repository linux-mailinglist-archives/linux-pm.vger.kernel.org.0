Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB22741753C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbhIXNSE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 09:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345482AbhIXNQY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Sep 2021 09:16:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0CF060F4C;
        Fri, 24 Sep 2021 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632489291;
        bh=VSbgQFvXId/bgojPS2ErFjSgYOZUoEfsMFPutOlktNc=;
        h=From:To:Cc:Subject:Date:From;
        b=EAIk84cpvdk8reOq2pmVxfcgut1ZB6Ck35pFoWppmWzA+O4iP5nFyIY5F1tGoIrGP
         LeNaGYa5vd54q3aFlVhi/mU9WO2MUGDA5C1+sXyTMtVtIvdsOgKB63zlagZQ/iw5ym
         I7+ZBEW/RsT68AGwlcJHayYKUiVAjHEAP3NJtQT++qUUtV9wu1/VGS8NSiaKEOkseV
         29ZesYYU57+3J7gc5mHZIyR6YtVEIiLZN/Chb1tHUXULkXaNVB+l/otRt9sJWP9Hz1
         4fHeQ5s5CoZkNnNJcPKyHR9NMyqLpB03qbEr28hX6AZUNVne54Z4np04PpeaSDYHsH
         KT7FfXGoVnYDA==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 5.15-rc
Date:   Fri, 24 Sep 2021 16:14:51 +0300
Message-Id: <20210924131451.31371-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This pull request contains interconnect driver fixes for 5.15-rc.
The details are in the signed tag. Please pull them into char-misc-linus
when possible. The patches have been in linux-next during the last few
days.

Thanks,
Georgi

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.15-rc3

for you to fetch changes up to 13404ac8882f5225af07545215f4975a564c3740:

  interconnect: qcom: sdm660: Add missing a2noc qos clocks (2021-09-13 15:49:55 +0300)

----------------------------------------------------------------
interconnect fixes for v5.15

This contains a few fixes for the sdm660 driver:
- sdm660: Fix id of slv_cnoc_mnoc_cfg
- sdm660: Correct NOC_QOS_PRIORITY shift and mask
- sdm660: Add missing a2noc qos clocks

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Shawn Guo (4):
      interconnect: qcom: sdm660: Fix id of slv_cnoc_mnoc_cfg
      interconnect: qcom: sdm660: Correct NOC_QOS_PRIORITY shift and mask
      dt-bindings: interconnect: sdm660: Add missing a2noc qos clocks
      interconnect: qcom: sdm660: Add missing a2noc qos clocks

 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml | 46 +++++++-
 drivers/interconnect/qcom/sdm660.c                              | 25 +++-
 2 files changed, 61 insertions(+), 10 deletions(-)
