Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E54A5463
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbfIBKuo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 06:50:44 -0400
Received: from foss.arm.com ([217.140.110.172]:52070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbfIBKuo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 06:50:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830B328;
        Mon,  2 Sep 2019 03:50:43 -0700 (PDT)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F0333F246;
        Mon,  2 Sep 2019 03:50:41 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, juri.lelli@redhat.com, will@kernel.org,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, qperret@qperret.net
Subject: [PATCH] mailmap: Update email address for Quentin Perret
Date:   Mon,  2 Sep 2019 11:50:36 +0100
Message-Id: <20190902105036.32419-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

My @arm.com email address will stop working in a few weeks, so add an
entry to .mailmap so others have a way to reach me if they want to.

While at it, move some entries around to keep the file in alphabetical
order.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
Hi guys,

Will/Catalin: any chance this could be merged via the arm64 tree ?

Thanks,
Quentin
---
 .mailmap | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index afaad605284a..934d848f0b2f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -180,6 +180,11 @@ Mythri P K <mythripk@ti.com>
 Nguyen Anh Quynh <aquynh@gmail.com>
 Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
 Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
+Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
+Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
+Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
+Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
+Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
 Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
@@ -190,11 +195,7 @@ Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
 Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
-Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
-Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
-Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
-Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
-Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
+Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
 Rajesh Shah <rajesh.shah@intel.com>
 Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
-- 
2.22.1

