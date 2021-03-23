Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDE345605
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 04:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCWDNJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 23:13:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55178 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhCWDNF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 23:13:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63978201AFB;
        Tue, 23 Mar 2021 04:13:00 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A6C9D200D74;
        Tue, 23 Mar 2021 04:12:55 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 38EFD402AC;
        Tue, 23 Mar 2021 04:12:49 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 0/6] PM / devfreq: a few small fixes and improvements
Date:   Tue, 23 Mar 2021 10:59:13 +0800
Message-Id: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few small fixes and improvements

ChangeLog:
v1->v2:
 * squash a few patches
 * rebase to devfreq-testing
 * drop two patches which are already in devfreq-next

Dong Aisheng (6):
  PM / devfreq: fix build error when DEVFREQ_GOV_PASSIVE enabled
  PM / devfreq: Use more accurate returned new_freq as resume_freq
  PM / devfreq: Remove the invalid description for get_target_freq
  PM / devfreq: bail out early if no freq changes in devfreq_set_target
  PM / devfreq: governor: optimize simpleondemand get_target_freq
  PM / devfreq: imx8m-ddrc: remove imx8m_ddrc_get_dev_status

 Documentation/ABI/testing/sysfs-class-devfreq |  5 +--
 drivers/devfreq/devfreq.c                     | 37 +++++++------------
 drivers/devfreq/governor.h                    |  2 -
 drivers/devfreq/governor_simpleondemand.c     | 31 ++++++++++------
 drivers/devfreq/imx8m-ddrc.c                  | 14 -------
 5 files changed, 35 insertions(+), 54 deletions(-)

-- 
2.25.1

