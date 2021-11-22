Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57DE458DA5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 12:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbhKVLpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 06:45:42 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:15303 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236718AbhKVLpm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Nov 2021 06:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581356; x=1669117356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vhcTba1ne75WkgRBeSRP/dFHeD0gKaOOhW9fbVsPCMk=;
  b=hdMv5XImStFiilZGb8zyNDwkjFgEnuTXrbsAkKZFoM5LfL8A6YUZylVi
   aLPEp7Nt0F8cXEvEVkpHcRWjn7qIC5LQJdvsM09vCgKpVUfR6gEqPW8/m
   c+kU0PyUuV9PaSqIQjzYzuBWtJIhbQDHevxxknDsFrkrkRzrclOY8Ss4z
   1GfB/JImcFkYKLzovt79/eaYTHsPQY29H5JFGCkr0Ei9ddAj7D+OILDHw
   RmO5KD/E4RBB6GZQ0FtCPr9U7+hijImQAD0SAB0N/JWQdgVNsYVwUIXaz
   eiL657B3maaz2hoprBL5MjugpzlEHN8Pdu4Sjr4V8+qBnLrPlbP63et/W
   w==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20594060"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Nov 2021 12:42:35 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 22 Nov 2021 12:42:35 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 22 Nov 2021 12:42:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637581355; x=1669117355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vhcTba1ne75WkgRBeSRP/dFHeD0gKaOOhW9fbVsPCMk=;
  b=f1y8XmGFnvf/5WHvhbn3Wd3AX+MnR2jLYyf8RHG/HDPZTEp3MYomP5+h
   ByAm/yD2b7gXxTXa4berY0CaCv/60IwZqYpV7MVPauLbw+tfcG8oxvO3S
   qInO5v61SyiDjhmHJw5xNOW9iqL773LNcAKlDQDgqp/NhUTBfCrywMp2C
   dE4G6ucu/yUnWEtM0y1ogl1B6pOE3s5zJzXL/4F321nVUo9/c/oJG6gag
   t8VLQF6oR34RGZLIBaEJMfGJBd/GAzclibr8qwCggwO0KG7oE7tK+UItS
   1sHCLiyPc+qrq3KCabJLOUcU0NAXz3YVkloID2PIprmiAxVmwFqa3kqyE
   w==;
X-IronPort-AV: E=Sophos;i="5.87,254,1631570400"; 
   d="scan'208";a="20594059"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Nov 2021 12:42:35 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 22850280065;
        Mon, 22 Nov 2021 12:42:35 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Paul Gerber <Paul.Gerber@tq-group.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] thermal: imx8mm: enable ADC when enabling monitor
Date:   Mon, 22 Nov 2021 12:42:25 +0100
Message-Id: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Paul Gerber <Paul.Gerber@tq-group.com>

The i.MX 8MP has a ADC_PD bit in the TMU_TER register that controls the
operating mode of the ADC:
* 0 means normal operating mode
* 1 means power down mode

When enabling/disabling the TMU, the ADC operating mode must be set
accordingly.

i.MX 8M Mini & Nano are lacking this bit.

Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Often this bit is set already by the bootloader, but in case this is not
done, the file /sys/class/thermal/thermal_zone0/temp will always return
-EAGAIN.

 drivers/thermal/imx8mm_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 7442e013738f..af666bd9e8d4 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -21,6 +21,7 @@
 #define TPS			0x4
 #define TRITSR			0x20	/* TMU immediate temp */
 
+#define TER_ADC_PD		BIT(30)
 #define TER_EN			BIT(31)
 #define TRITSR_TEMP0_VAL_MASK	0xff
 #define TRITSR_TEMP1_VAL_MASK	0xff0000
@@ -113,6 +114,8 @@ static void imx8mm_tmu_enable(struct imx8mm_tmu *tmu, bool enable)
 
 	val = readl_relaxed(tmu->base + TER);
 	val = enable ? (val | TER_EN) : (val & ~TER_EN);
+	if (tmu->socdata->version == TMU_VER2)
+		val = enable ? (val & ~TER_ADC_PD) : (val | TER_ADC_PD);
 	writel_relaxed(val, tmu->base + TER);
 }
 
-- 
2.25.1

