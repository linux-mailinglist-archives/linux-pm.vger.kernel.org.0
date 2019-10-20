Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44127DE0DE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 00:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfJTWVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 18:21:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:9616 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfJTWVN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 20 Oct 2019 18:21:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 15:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="195950107"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2019 15:21:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iMJZW-0006LL-UI; Mon, 21 Oct 2019 06:21:10 +0800
Date:   Mon, 21 Oct 2019 06:20:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kbuild-all@lists.01.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH power-supply] power: supply: cpcap-charger:
 cpcap_charger_voltage_to_regval() can be static
Message-ID: <20191020222052.hud2r3jx2rvrrip3@4978f4969bb8>
References: <201910210600.WlHJI3rO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910210600.WlHJI3rO%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Fixes: d4ee021c410f ("power: supply: cpcap-charger: Limit voltage to 4.2V for battery")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 cpcap-charger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 88bbab6e62f07..b4b7f9dc6c4ea 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -478,7 +478,7 @@ static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
 	dev_dbg(ddata->dev, "state: %s\n", status);
 }
 
-int cpcap_charger_voltage_to_regval(int voltage)
+static int cpcap_charger_voltage_to_regval(int voltage)
 {
 	int offset;
 
