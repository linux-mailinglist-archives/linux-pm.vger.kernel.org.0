Return-Path: <linux-pm+bounces-162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6457E7F6DBC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212912811E2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3861F9464;
	Fri, 24 Nov 2023 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103FC1BD
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:11:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-0005I1-03; Fri, 24 Nov 2023 09:10:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-00BDaF-16; Fri, 24 Nov 2023 09:10:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGn-007HhU-N0; Fri, 24 Nov 2023 09:10:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Deepak R Varma <drv@mailo.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/9] pmdomain: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:24 +0100
Message-ID: <20231124080623.564924-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=V6/Win2+afEijP7B7dUEmmqOQe8ODNS48YHTBw6iZNw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFl/zuJTtS9uFTzDY6XEJpsXpdcznf6FRrZbn AzC++PBgNyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZfwAKCRCPgPtYfRL+ TkDaCACyGq0mdpsWIwvJqcWsdqkGY4LK1XiXD0dHxxRrNs4orsKEOkLlFqU0epWfbtZaRpouC+h 4a7bK5vqMum+o3Ij188wO4Ja6Q8iRdHuWCEgY6iS/WKY+0KfqsNgHLvh7eb/fe7LrBdAOtK9j6Z SEDe90IdI/kD4ZpM5kIw5+0ljb/kCZw/maz32Z8fBuZ/sJSTd7TQPVN2WYrStPNbILWrjl/inUk JjAY4uz/VoIliFCmWj30nSDc8IoPG7uboOB5RbgrQtDI+7JHrnDhmwyn3ZEabGxN95Ic+s2+Bc2 ncRIvml15F6Knig+DDB81w4Q03pEl/xVyrjWQzOI2cq+cdOb
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hello,

this patch set converts all drivers below drivers/pmdomain to use struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

While working on drivers/pmdomain/imx/gpc.c I noticed three issues, but
didn't address them:

 - The driver uses builtin_platform_driver twice. The documentation
   however mandates that "Each driver may only use this macro once".
   I don't know if the documentation is wrong and using it twice works
   as intended.

 - imx_gpc_remove() only removes two PDs, but there might be up to four?!

 - In imx_gpc_remove() if
   pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base) fails,
   removing the ARM PD is skipped. So together with the previous item
   the driver leaks up to three genpd instances.

Maybe someone caring for this driver will pick these up and prepare
patches? Ideally pm_genpd_remove() should return void caring for still
existing providers, parents and devices in generic code. I think that
erroring out in genpd_remove() before the PM domain is removed from the
various lists might result in use-after-free errors.

Best regards
Uwe

Uwe Kleine-König (9):
  pmdomain: imx-pgc: Convert to platform remove callback returning void
  pmdomain: imx-gpc: Convert to platform remove callback returning void
  pmdomain: imx-gpcv2: Convert to platform remove callback returning
    void
  pmdomain: imx8m-blk-ctrl: Convert to platform remove callback
    returning void
  pmdomain: imx8mp-blk-ctrl: Convert to platform remove callback
    returning void
  pmdomain: imx93-blk-ctrl: Convert to platform remove callback
    returning void
  pmdomain: imx93-pd: Convert to platform remove callback returning void
  pmdomain: qcom-cpr: Convert to platform remove callback returning void
  pmdomain: xilinx/zynqmp: Convert to platform remove callback returning
    void

 drivers/pmdomain/imx/gpc.c                  | 28 +++++++++++----------
 drivers/pmdomain/imx/gpcv2.c                |  6 ++---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c       |  6 ++---
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c      |  6 ++---
 drivers/pmdomain/imx/imx93-blk-ctrl.c       |  6 ++---
 drivers/pmdomain/imx/imx93-pd.c             |  6 ++---
 drivers/pmdomain/qcom/cpr.c                 |  6 ++---
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  6 ++---
 8 files changed, 29 insertions(+), 41 deletions(-)

base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
-- 
2.42.0


