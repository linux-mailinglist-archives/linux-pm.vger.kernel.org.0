Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A1783059
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 13:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfHFLMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 07:12:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54118 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730676AbfHFLMe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:12:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E137B1A05CE;
        Tue,  6 Aug 2019 13:12:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D487C1A00D8;
        Tue,  6 Aug 2019 13:12:31 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 52694205DD;
        Tue,  6 Aug 2019 13:12:31 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        linux-pm@vger.kernel.org
Subject: [RFC 0/4] opp: Parse required-opp as dev_pm_qos_request
Date:   Tue,  6 Aug 2019 14:12:24 +0300
Message-Id: <cover.1565089196.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "required-opps" property can be placed on any device and point to
any OPP table according to bindings doc but this is not fully
implemented. In practice it can only point from the opp table of a
device to the opp table of a power domain.

As part of my investingating QOS mechanisms I implemented support for
parsing "required-opps" into a DEV_PM_QOS_MIN_FREQUENCY
dev_pm_qos_request. Since OPPs can be shared between devices this only
works when OPP tables are unshared.

This would need to be called from a device probe function and any
suspend/resume handling (which likely means disabling the QOS requests)
would also be handled manually by each driver.

This is RFC mostly because I plan to use the "interconnect" framework
for device requests instead. In theory this could be used if you don't
care about implementing smart aggregation and just want to "set bus freq
to high".

Devfreq support for dev_pm_qos is here: https://patchwork.kernel.org/patch/11078475/

Leonard Crestez (4):
  opp: Drop const from opp_device struct device
  opp: Add dev_pm_opp_table_get_device
  opp: Add dev_pm_parse_required_opp_as_qos
  PM / QoS: Add dev_pm_qos_get_curr_value

 drivers/base/power/qos.c | 59 +++++++++++++++++++++++++-----------
 drivers/opp/core.c       | 34 +++++++++++++++++++--
 drivers/opp/of.c         | 65 ++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h        |  4 +--
 include/linux/pm_opp.h   | 15 ++++++++++
 include/linux/pm_qos.h   |  1 +
 6 files changed, 157 insertions(+), 21 deletions(-)

-- 
2.17.1

