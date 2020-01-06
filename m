Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458811311C4
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 13:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAFMGG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 07:06:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43311 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFMGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 07:06:06 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ioR8w-0008Es-8J; Mon, 06 Jan 2020 12:05:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: avs: fix uninitialized error return on failed cpr_read_fuse_uV call
Date:   Mon,  6 Jan 2020 12:05:58 +0000
Message-Id: <20200106120558.37758-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the call cpr_read_fuse_uV returns an error the value in the
uninitialized variable ret is returned. Fix this by instread returning the
error value in the variable uV.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/avs/qcom-cpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index 9247f53550b3..0321729431a5 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -922,7 +922,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 		uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
 				      step_volt, drv);
 		if (uV < 0)
-			return ret;
+			return uV;
 
 		fuse->min_uV = fdata->min_uV;
 		fuse->max_uV = fdata->max_uV;
-- 
2.24.0

