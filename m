Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54559FFBED
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2019 23:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfKQWXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Nov 2019 17:23:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:5207 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfKQWXK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Nov 2019 17:23:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 14:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="258247394"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Nov 2019 14:23:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iWSwm-00067I-4M; Mon, 18 Nov 2019 06:23:08 +0800
Date:   Mon, 18 Nov 2019 06:22:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH] firmware: imx: scu-pd: imx_con_rsrc can be static
Message-ID: <20191117222256.lpxfujyawdh4fjng@4978f4969bb8>
References: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Fixes: 3eb6739fc067 ("firmware: imx: scu-pd: do not power off console domain")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 scu-pd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 770e3681bbbf6..cae678feda645 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -85,7 +85,7 @@ struct imx_sc_pd_soc {
 	u8 num_ranges;
 };
 
-int imx_con_rsrc;
+static int imx_con_rsrc;
 
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
