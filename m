Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E781C3310CE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 15:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhCHOcP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 09:32:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:9466 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhCHObs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 09:31:48 -0500
IronPort-SDR: lS4p2Iltii6z8kmxu6C8b7BoUIrmUD3ltpnwOceVmQHC9v/SKTplxumpK2QutJH/lwXdq3hhIl
 C6BAd7nLGzpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="187401919"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="187401919"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 06:31:48 -0800
IronPort-SDR: MVB9OIH4LOPqwh3KPAnw36OKRvtq5h4JC1sqIUfGGuSQUSSLix245eeTgq8usd9mENgYbnjguD
 Xw3Wx3mhS0SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="385866301"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2021 06:31:46 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] intel_idle: update ICX C6 data
Date:   Mon,  8 Mar 2021 16:31:46 +0200
Message-Id: <20210308143146.3443166-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch changes IceLake Xeon C6 latency from 128 us to 170 us. The latency
was measured with the "wult" tool and corresponds to the 99.99th percentile
when measuring with the "nic" method. Note, the 128 us figure correspond to the
median latency, but in intel_idle we use the "worst case" latency figure
instead.

C6 target residency was increased from 384 us to 600 us, which may result in
less C6 residency in some workloads. This value was tested and compared to
values 384, and 1000. Value 600 is a reasonable tradeoff between power and
performance.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changelog:
v2->v3: Change target_residency from 1000us to 600us, based on Rui's feedback.
v1->v2: Re-measured ICX with newer BIOS 21D02, which has C1 demotion bug fixed.

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3273360f30f7..6cac0b748efa 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -744,8 +744,8 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.name = "C6",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
-		.exit_latency = 128,
-		.target_residency = 384,
+		.exit_latency = 170,
+		.target_residency = 600,
 		.enter = &intel_idle,
 		.enter_s2idle = intel_idle_s2idle, },
 	{
-- 
2.29.2

