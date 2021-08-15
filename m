Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F6B3EC7DB
	for <lists+linux-pm@lfdr.de>; Sun, 15 Aug 2021 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhHOHJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Aug 2021 03:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235656AbhHOHJN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Aug 2021 03:09:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F29960462;
        Sun, 15 Aug 2021 07:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629011324;
        bh=RlitLgKnBt3LCQGRkgYeOYO479RGDpOCpI5wlfk8f80=;
        h=From:To:Cc:Subject:Date:From;
        b=JuYRPq51P4UvCD1K2m8aD20/AdKDQ2xWdWfSyxYI0XR4W8btbWZHWdbVHakMKKKSn
         jzzUBQHrVfnodkY+0P0E7/xBn3UqC0BRHiLNpPlAmRaAa5k279jX+nCvJRPZjEemCZ
         KgzXH7xWCVTuPIYn92+i6fWWxL3WjAgsMS+l+btol0Gm4ZlN4DaOz6VMP6uxBYrxBh
         Gb5tsXEaij/b6rn93T1pwVySJM1cnyWw73u0unoiDarEkLJpb7IFumCA7ZEeLEvmXt
         WbywwmZZniA7srPoh24iah/I5aPOIzm1GuCHh/O/I0d4evITj/JLsLG1VzhN3GTKbH
         PrUPljKQScsUQ==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fix for 5.14-rc
Date:   Sun, 15 Aug 2021 10:08:42 +0300
Message-Id: <20210815070842.29372-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This pull request contains a revert for a patch that has been reported to
cause a regression on 5.14-rc. More details are in the signed tag and in
the commit. Please pull it into char-misc-linus when possible.

Thanks,
Georgi

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.14-rc6

for you to fetch changes up to f753067494c2726d7a09ffca351d9b2599fee876:

  Revert "interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate" (2021-08-12 09:24:39 +0300)

----------------------------------------------------------------
interconnect fix for v5.14

This contains a revert for a patch that has been causing issues:
- Revert: qcom: rpmh: Add BCMs to commit list in pre_aggregate

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (1):
      Revert "interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate"

 drivers/interconnect/qcom/icc-rpmh.c | 10 ++++----
 1 file changed, 5 insertions(+), 5 deletions(-)
