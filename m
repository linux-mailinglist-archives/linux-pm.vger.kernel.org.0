Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06077392DDE
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhE0MY0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 08:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234702AbhE0MY0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 08:24:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 385E4610CC;
        Thu, 27 May 2021 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622118173;
        bh=PeOYBj4dYdEHtrpaWtOXdXVv99HMaaHLcMB50u37K2o=;
        h=From:To:Cc:Subject:Date:From;
        b=e4OCGEKHT2SWsVARZo3tAt3lp80XgxmGP6jesG8e1XzpSDtHo6lm9AsnbMTyp4i9G
         +L1mLVU9K+/PbpJSILSmDfMXg6eGujRVh8yJOPHJsv4o6A8ga/BVoKzS6TVTVlliuj
         ZE73sOe+/5ERTbXLjdF31bJeuF+HvgCoBwToaL0K8JO3o9BbIfV+dVo+QPapAWThWd
         2okWM+GQQ2jgBc1mYw2WB1WlXK8gVsvHPvGNMnXfsrZilLSLx86UHcsO128QhU/U48
         Cw2wZnBjG203xN5ZeNw3ov7SKbrwoIDGVKW5ijqP0nr6D6JL/iTyvru4bwL6uy8KzJ
         vFHo5nde2+rdg==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 5.13-rc
Date:   Thu, 27 May 2021 15:22:55 +0300
Message-Id: <20210527122255.31418-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Greg,

This pull request contains a few tiny interconnect driver fixes for 5.13-rc.
The details are in the signed tag. Please pull them into char-misc-linus
when possible. The patches have been in linux-next for more than two weeks.

Thanks,
Georgi

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.13-rc4

for you to fetch changes up to 1fd86e280d8b21762901e43d42d66dbfe8b8e0d3:

  interconnect: qcom: Add missing MODULE_DEVICE_TABLE (2021-05-11 07:26:31 +0300)

----------------------------------------------------------------
interconnect fixes for v5.13

This contains two tiny driver fixes:

- bcm-voter: Add missing MODULE_DEVICE_TABLE
- bcm-voter: Add a missing of_node_put()

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Subbaraman Narayanamurthy (1):
      interconnect: qcom: bcm-voter: add a missing of_node_put()

Zou Wei (1):
      interconnect: qcom: Add missing MODULE_DEVICE_TABLE

 drivers/interconnect/qcom/bcm-voter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
