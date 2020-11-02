Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373822A2A45
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 13:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKBMBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 07:01:53 -0500
Received: from foss.arm.com ([217.140.110.172]:58556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgKBMBx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 07:01:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 781B030E;
        Mon,  2 Nov 2020 04:01:52 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.53.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C9FB3F66E;
        Mon,  2 Nov 2020 04:01:50 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v3 0/3] CPUFreq: Add support for cpu performance dependencies
Date:   Mon,  2 Nov 2020 12:01:12 +0000
Message-Id: <20201102120115.29993-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

In this V3 posting I have replaced the new dt-binding with minor changes/
improvements for opp (since we are now using opp tables instead).
The RFC still stands on how to make this info available to sw consumers.

In the RFC, I am proposing a simple addition of a performance dependencies
cpumask in CPUFreq core and an example of how drivers and consumers would
make use of it.
I also propose an alternative approach, which does not require changes in
CPUFreq core, but - possibly - in all the consumers.

This is to support systems where exposed cpu performance controls are more
fine-grained that the platform's ability to scale cpus independently.

[v3]
  * Remove proposal for new 'cpu-performance-dependencies' as we instead
    can reuse the opp table.
  * Update documentation for devicetree/bindings/opp
  * Minor changes within opp to support empty opp table
  * Rework the RFC by adding a second proposal

[v2]
  * Fix errors when running make dt_binding_check
  * Improve commit message description for the dt-binding
  * Add RFC for implementation in cpufreq-core and one of its
    drivers.

Nicola Mazzucato (3):
  dt-bindings/opp: Update documentation for opp-shared
  opp/of: Allow empty opp-table with opp-shared
  [RFC] CPUFreq: Add support for cpu-perf-dependencies

 Documentation/devicetree/bindings/opp/opp.txt | 53 +++++++++++++++++++
 drivers/opp/of.c                              | 13 ++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.27.0

