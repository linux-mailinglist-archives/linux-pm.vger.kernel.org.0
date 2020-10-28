Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53E229D7F6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgJ1W1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:27:15 -0400
Received: from foss.arm.com ([217.140.110.172]:40029 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733214AbgJ1W1P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A806D1766;
        Wed, 28 Oct 2020 07:09:16 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBD423F66E;
        Wed, 28 Oct 2020 07:09:13 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, lukasz.luba@arm.com
Subject: [PATCH 0/4] Add sustainable OPP concept
Date:   Wed, 28 Oct 2020 14:08:43 +0000
Message-Id: <20201028140847.1018-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set introduces a concept of sustainable OPP, which then can be used
by kernel frameworks or governors for estimating system sustainable system
state. This kind of estimation is done e.g. in thermal governor Intelligent
Power Allocation (IPA), which calculates sustainable power of the whole system
and then derives some coefficients for internal algorithm.

The patch set introduces a new DT bindings 'opp-sustainable', with parsing
code. It also adds a function (in patch 3/4) which allows device drivers to set
directly the sustainable OPP. This is helpful when the device drivers populate
the OPP table by themself (example in patch 4/4).

The patch set should apply on top of next-20201028.

Regards,
Lukasz Luba

Lukasz Luba (4):
  dt-bindings: opp: Introduce opp-sustainable bindings
  OPP: Add support for parsing the 'opp-sustainable' property
  OPP: Add dev_pm_opp_set_sustainable_opp_freq()
  firmware: arm_scmi/perf: Mark sustainable OPP

 Documentation/devicetree/bindings/opp/opp.txt |  4 +
 drivers/firmware/arm_scmi/perf.c              | 10 +++
 drivers/opp/core.c                            | 75 +++++++++++++++++++
 drivers/opp/of.c                              | 14 ++++
 drivers/opp/opp.h                             |  3 +
 include/linux/pm_opp.h                        | 14 ++++
 6 files changed, 120 insertions(+)

-- 
2.17.1

