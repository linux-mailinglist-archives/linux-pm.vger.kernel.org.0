Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09E7310C27
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhBENsZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 08:48:25 -0500
Received: from muru.com ([72.249.23.125]:57602 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhBENqU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 08:46:20 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8457E8061;
        Fri,  5 Feb 2021 13:45:50 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCHv2 0/4] Thermal fixes for omaps for single mode read
Date:   Fri,  5 Feb 2021 15:45:30 +0200
Message-Id: <20210205134534.49200-1-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here's v2 set of thermal fixes for single mode read. Turns out the
EOCZ and SOC bit handling is quite different between the various
SoCs.

With these changes we fix the following issues for reading a
single sample:

- Get rid of pointless register access and loops for dra7

- Fix omap3 to use proper timeouts, the current looping is
  way too short and always times out probably leading to
  bogus values as folks have reported

- Fix omap4430 where EOCZ only seems to work for continuous
  mode

Regards,

Tony

Changes since v1:
- Use better MODE_CONFIG checks as suggested by Peter
- Fix issues for omap3 as noted by Adam
- Fix handling for dra7

Tony Lindgren (4):
  thermal: ti-soc-thermal: Skip pointless register access for dra7
  thermal: ti-soc-thermal: Fix stuck sensor with continuous mode for
    4430
  thermal: ti-soc-thermal: Simplify polling with iopoll
  thermal: ti-soc-thermal: Use non-inverted define for omap4

 .../ti-soc-thermal/omap4-thermal-data.c       |  7 +--
 .../thermal/ti-soc-thermal/omap4xxx-bandgap.h |  4 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c   | 54 ++++++++++---------
 drivers/thermal/ti-soc-thermal/ti-bandgap.h   |  2 +
 4 files changed, 38 insertions(+), 29 deletions(-)

-- 
2.30.0
