Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CC114ABC8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 22:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0VzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 16:55:19 -0500
Received: from foss.arm.com ([217.140.110.172]:49528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgA0VzT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jan 2020 16:55:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B720331B;
        Mon, 27 Jan 2020 13:55:18 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02FD73F68E;
        Mon, 27 Jan 2020 13:55:13 -0800 (PST)
From:   lukasz.luba@arm.com
To:     kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: [PATCH 0/3] Enable Odroid-XU3/4 to use Energy Model and Energy Aware Scheduler 
Date:   Mon, 27 Jan 2020 21:54:50 +0000
Message-Id: <20200127215453.15144-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

The Odroid-XU3/4 is a decent and easy accessible ARM big.LITTLE platform,
which might be used for research and development.

This small patch set provides possibility to run Energy Aware Scheduler (EAS)
on Odroid-XU4/3 and experiment with it. 

The patch 1 enables SCHED_MC, which adds another level in sched_domain.
The patch 2 provides 'dynamic-power-coefficient' in CPU DT nodes, which is
then is used by the Energy Model (EM).
The patch 3 enables EM and makes EAS possible to run. Please read the commit
message in the patch 3 describing how to enable or disable EAS at runtime.
Some of the test results are provided also in there.

The patch set is on top of Krzysztof's tree, branch 'next/dt' [1] and has 
been tested on Odroid-XU3.

Regards,
Lukasz Luba

[1] https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=next/dt

Lukasz Luba (3):
  ARM: exynos_defconfig: Enable SCHED_MC
  ARM: dts: exynos: Add Exynos5422 CPU dynamic-power-coefficient
    information
  ARM: exynos_defconfig: Enable Energy Model framework

 arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 ++++++++
 arch/arm/configs/exynos_defconfig      | 2 ++
 2 files changed, 10 insertions(+)

-- 
2.17.1

