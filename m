Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457F5FBC6F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 00:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKMXVl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 18:21:41 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58126 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKMXVl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 18:21:41 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CBD8200199;
        Thu, 14 Nov 2019 00:21:38 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F2F5200139;
        Thu, 14 Nov 2019 00:21:38 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F83B205D5;
        Thu, 14 Nov 2019 00:21:38 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH 0/5] PM / devfreq: Don't take lock in devfreq_add_device
Date:   Thu, 14 Nov 2019 01:21:30 +0200
Message-Id: <cover.1573686315.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Right now the devfreq_add_device takes devfreq->lock as soon as the device is
allocated, this is awkward and unnecessary. In general an object should be
initialized in isolation and only be made available to the system when it's in
a consistent state.

Locking the device during initialization causes problems (lockdep warnings)
when interacting with other subsystems that also use heavy locking. There are
also a few fields (such as trans_table) which are initialized after
device_register even through they're readable from sysfs, these are now
allocated earlier.

This was spawned by the attempt to add dev_pm_qos support. I split this series
here because it might benefit from separate discussion.

Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
need to take devfreq->lock, this means that in order to prevent possible
deadlocks all initialization of dev_pm_qos must be performed outside the
devfreq->lock.

PM QoS requests from sysfs should be initialized before the device is
registered (because they're touched from sysfs) but all of that is currently
done with devfreq->lock held!

This series makes some tricky changes but the end results is easier to
understand and maintain. For example it removes a scary unlock/lock pair
around set_freq_table, maybe this also caused problems in the past?

Alternative solutions exist: all PM QoS setup could be done after device_add
just like governor setup and the min/max_freq_store could return an error if
the qos request is not yet properly initialized.

It might even be possible to modify dev_pm_qos to call notifiers without
holding internal locks? That is generally a good idea for all notifiers.

Changes since split from PM_QOS:
* Add a patch which moves devm from devfreq->dev->parent to devfreq->dev.
See: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=196443

Leonard Crestez (5):
  PM / devfreq: Don't fail devfreq_dev_release if not in list
  PM / devfreq: Split device_register usage
  PM / devfreq: Move more initialization before registration
  PM / devfreq: Don't use devm on parent device
  PM / devfreq: Don't take lock in devfreq_add_device

 drivers/devfreq/devfreq.c | 41 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

-- 
2.17.1

