Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525E9120815
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfLPOGp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:06:45 -0500
Received: from foss.arm.com ([217.140.110.172]:56554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfLPOGo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 09:06:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294CD1FB;
        Mon, 16 Dec 2019 06:06:44 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C27733F718;
        Mon, 16 Dec 2019 06:06:41 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     amit.kucheria@verdurent.com, corbet@lwn.net, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH 0/3] Thermal extensions for flexibility in cooling device bindings
Date:   Mon, 16 Dec 2019 14:06:19 +0000
Message-Id: <20191216140622.25467-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Hi all,

This patch set adds extensions to existing thermal zones and cooling devices
binding. Currently they are pinned using static definitions e.g. DT cooling
maps. These changes enable userspace like trusted middleware to change the
layout of cooling maps unbinding and binding the cooling devices.
It might be helpful for drivers loaded as a modules. They can be added to
existing thermal zones to take part of the power split.
It is based on the current work in thermal branch thermal/linux-next
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

Regards,
Lukasz Luba

Lukasz Luba (3):
  docs: thermal: Add bind, unbind information together with trip point
  thermal: Make cooling device trip point writable from sysfs
  thermal: Add sysfs binding for cooling device and thermal zone

 .../driver-api/thermal/sysfs-api.rst          | 30 +++++++-
 drivers/thermal/thermal_core.c                |  3 +-
 drivers/thermal/thermal_core.h                |  2 +
 drivers/thermal/thermal_sysfs.c               | 77 +++++++++++++++++++
 4 files changed, 109 insertions(+), 3 deletions(-)

-- 
2.17.1

