Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21C3B0500
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFVMpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhFVMpp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 08:45:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31C4B6135A;
        Tue, 22 Jun 2021 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624365810;
        bh=Pto6p0xlUC22Ixk2miZ0kKtGmnsBgMupPgtuYUb3iAc=;
        h=From:To:Cc:Subject:Date:From;
        b=n/GHBQSQTagLyAtRyv423Acj6YpV51GvWNFwwNs7qwh3rvg2XQEilIskMoCIRRFfG
         imoR6uyEjqTeWmP4vZ7fLU4q5FRWUN2cgfwFpcEeKFEoPKjvAiSYvHMG6duDRApbl7
         LF9cutFcAMF/AXVhRxgyvjNFVybDi05OmHT1blLYdtetQeSpMQ2mjpUDvNUOo6M1h4
         +0IFlrW6yPOKZLWFw3soFJXp4M1UB6uW+rI3k5eYI73ouFviwuHasXNb7GeJtQ1EDe
         sGbiC9AV8/TxQ8y4rjcnmhhVMAlTUYnHJo6+wYIcd2MTLE8O1zYqq9FuZGyvGkCL0F
         anHjl2PzKCdGQ==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 5.14
Date:   Tue, 22 Jun 2021 15:43:37 +0300
Message-Id: <20210622124337.26529-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.14-rc1
merge window containing driver changes.

Patches have been in linux-next for more than a month and without any
reported issues. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.14-rc1

for you to fetch changes up to 46bdcac533cca06c481524343de7d9cc46d67093:

  interconnect: qcom: Add SC7280 interconnect provider driver (2021-05-11 11:53:31 +0300)

----------------------------------------------------------------
interconnect changes for 5.14

Here are changes for the 5.14-rc1 merge window consisting of interconnect
driver updates.

Driver changes:
- New driver for SC7280 platforms.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Odelu Kukatla (2):
      dt-bindings: interconnect: Add Qualcomm SC7280 DT bindings
      interconnect: qcom: Add SC7280 interconnect provider driver

 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml |   12 +
 drivers/interconnect/qcom/Kconfig                             |    9 +
 drivers/interconnect/qcom/Makefile                            |    2 +
 drivers/interconnect/qcom/sc7280.c                            | 1938 ++++++++
 drivers/interconnect/qcom/sc7280.h                            |  154 +
 include/dt-bindings/interconnect/qcom,sc7280.h                |  165 +
 6 files changed, 2280 insertions(+)
 create mode 100644 drivers/interconnect/qcom/sc7280.c
 create mode 100644 drivers/interconnect/qcom/sc7280.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7280.h
