Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A581BA406
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgD0Mxq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 08:53:46 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:43455 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgD0Mxq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 08:53:46 -0400
X-IronPort-AV: E=Sophos;i="5.73,324,1583161200"; 
   d="scan'208";a="45618953"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Apr 2020 21:53:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EE54D42290A8;
        Mon, 27 Apr 2020 21:53:42 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RESEND] cpufreq: dt: Add support for r8a7742
Date:   Mon, 27 Apr 2020 13:53:30 +0100
Message-Id: <1587992010-7203-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the compatible strings for supporting the generic cpufreq driver on
the Renesas RZ/G1H (R8A7742) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index cb9db16..148aa66 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -53,6 +53,7 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "renesas,r7s72100", },
 	{ .compatible = "renesas,r8a73a4", },
 	{ .compatible = "renesas,r8a7740", },
+	{ .compatible = "renesas,r8a7742", },
 	{ .compatible = "renesas,r8a7743", },
 	{ .compatible = "renesas,r8a7744", },
 	{ .compatible = "renesas,r8a7745", },
-- 
2.7.4

