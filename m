Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0548CE52E0
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfJYSAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 14:00:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54222 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbfJYSAy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 14:00:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 036091A0A2A;
        Fri, 25 Oct 2019 20:00:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E9A371A081F;
        Fri, 25 Oct 2019 20:00:51 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 88405205DB;
        Fri, 25 Oct 2019 20:00:51 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 0/3] PM: QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
Date:   Fri, 25 Oct 2019 21:00:46 +0300
Message-Id: <cover.1572025364.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support for frequency limits in dev_pm_qos was removed when cpufreq was
switched to freq_qos, this series attempts to restore it by
reimplementing top of freq_qos.

Previous discussion here:

https://lore.kernel.org/linux-pm/VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com/T/#u

The cpufreq core switched away because it needs contraints at the level
of a "cpufreq_policy" which cover multiple cpus so dev_pm_qos coupling
to struct device was not useful (and was incorrectly handling). Cpufreq
could only use dev_pm_qos by implementing an additional layer of
aggregation from CPU to policy.

However the devfreq subsystem scaling is always performed for each
device so dev_pm_qos is a very good match. Support for dev_pm_qos
inside devfreq is implemented by this series:

	https://patchwork.kernel.org/cover/11171807/

Rafael: If this makes sense to you I could incorporate the restoration
of DEV_PM_QOS_MIN/MAX_FREQUENCY in v10 of the devfreq qos series.

In theory if freq_qos is extended to handle conflicting min/max values then
this sharing would be useful. Right now freq_qos just ties two unrelated
pm_qos aggregations for min/max freq.

---
This is implemented by embeding a freq_qos_request inside dev_pm_qos_request:
the data field was already an union in order to deal with flag requests.

The internal _freq_qos_apply is exported so that it can be called from
dev_pm_qos apply_constraints.

The dev_pm_qos_constraints_destroy function has no obvious equivalent in
freq_qos but really the whole approach of "removing requests" is somewhat dubios:
request objects should be owned by consumers and the list of qos requests
should be empty when the target device is deleted. Clearing the request
list and would likely result in a WARN next time "update_request" is
called by the requestor.

Leonard Crestez (3):
  PM: QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
  PM: QoS: Export _freq_qos_apply
  PM: QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY

 drivers/base/power/qos.c | 69 +++++++++++++++++++++++++++++---
 include/linux/pm_qos.h   | 86 +++++++++++++++++++++++-----------------
 kernel/power/qos.c       | 11 ++---
 3 files changed, 119 insertions(+), 47 deletions(-)

-- 
2.17.1

