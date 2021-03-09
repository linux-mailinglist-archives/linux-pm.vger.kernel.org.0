Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F241332633
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCINMy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:12:54 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46668 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCINMY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:24 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AFFB1A09B2;
        Tue,  9 Mar 2021 14:12:19 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 129671A1005;
        Tue,  9 Mar 2021 14:12:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BBA82402A7;
        Tue,  9 Mar 2021 14:12:04 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 00/11] PM / devfreq: a few small fixes and improvements
Date:   Tue,  9 Mar 2021 20:58:30 +0800
Message-Id: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few small fixes and improvements

Dong Aisheng (11):
  doc: ABI: devfreq: remove invalid central_polling description
  PM / devfreq: remove the invalid description for get_target_freq
  PM / devfreq: fix the wrong set_freq path for userspace governor
  PM / devfreq: bail out early if no freq changes in devfreq_set_target
  PM / devfreq: use more accurate returned new_freq as resume_freq
  PM / devfreq: drop the unnecessary low variable initialization
  PM / devfreq: check get_dev_status before start monitor
  PM / devfreq: check get_dev_status in devfreq_update_stats
  PM / devfreq: governor: optimize simpleondemand get_target_freq
  PM / devfreq: imx8m-ddrc: remove imx8m_ddrc_get_dev_status
  PM / devfreq: imx8m-ddrc: drop polling_ms

 Documentation/ABI/testing/sysfs-class-devfreq |  5 +-
 drivers/devfreq/Kconfig                       |  2 +-
 drivers/devfreq/devfreq.c                     | 21 +++++---
 drivers/devfreq/governor.h                    |  7 +--
 drivers/devfreq/governor_simpleondemand.c     | 53 ++++++++++++-------
 drivers/devfreq/imx8m-ddrc.c                  | 14 -----
 6 files changed, 55 insertions(+), 47 deletions(-)

-- 
2.25.1

