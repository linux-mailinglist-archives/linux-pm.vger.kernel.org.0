Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE9186B90
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgCPMzp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 08:55:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731059AbgCPMzo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Mar 2020 08:55:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D163E6274A3E00B1B0E7;
        Mon, 16 Mar 2020 20:55:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Mar 2020 20:55:34 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH V2 0/2] thermal: Add HiSilicon Kunpeng thermal driver and Maintainers
Date:   Mon, 16 Mar 2020 20:54:59 +0800
Message-ID: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add HiSilicon Kunpeng thermal driver and Maintainers.

Changelog:
v2:
 * fix sizeof(* tdev) and sizeof(* tdev->tsensor)

Yang Shen (2):
  thermal: Add HiSilicon Kunpeng thermal driver
  MAINTAINERS: Add maintainers for kunpeng thermal

 MAINTAINERS                       |   7 ++
 drivers/thermal/Kconfig           |   8 ++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/kunpeng_thermal.c | 219 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 drivers/thermal/kunpeng_thermal.c

--
2.7.4

