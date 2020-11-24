Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E202C232A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgKXKoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 05:44:01 -0500
Received: from foss.arm.com ([217.140.110.172]:53200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgKXKoB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 05:44:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26DBC1396;
        Tue, 24 Nov 2020 02:44:01 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.29.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5F243F71F;
        Tue, 24 Nov 2020 02:43:58 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, Dietmar.Eggemann@arm.com,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org
Subject: [PATCH 0/2] SCMI performance protocol power scale interface
Date:   Tue, 24 Nov 2020 10:43:44 +0000
Message-Id: <20201124104346.27167-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The Energy Model (EM) supports power values expressed in an abstract scale
via new API. The SCMI performance protocol provides the information about
power scale. This patch set implements the needed interface and updates
cpufreq driver to set the right scale in the EM.

It is based on top of patch series adding milli-Watts flag in EM [1]
(next-20201124 was used as a base).

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20201103090600.29053-1-lukasz.luba@arm.com/

Lukasz Luba (2):
  firmware: arm_scmi: Add power_scale_mw_get() interface
  cpufreq: arm_scmi: Discover the power scale in performance protocol

 drivers/cpufreq/scmi-cpufreq.c   | 4 +++-
 drivers/firmware/arm_scmi/perf.c | 8 ++++++++
 include/linux/scmi_protocol.h    | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.17.1

