Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57B7899C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfG2K3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 06:29:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53678 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfG2K3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 06:29:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hs2uI-0005Fo-C9; Mon, 29 Jul 2019 10:29:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drivers: thermal: processor_thermal_device: fix missing bitwise-or operator
Date:   Mon, 29 Jul 2019 11:29:30 +0100
Message-Id: <20190729102930.2956-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable val is having the top 8 bits cleared and then the variable
is being re-assinged and setting just the top 8 bits.  I believe the
intention was bitwise-or in the top 8 bits.  Fix this by replacing
the = operator with |= instead.

Addresses-Coverity: ("Unused value")
Fixes: b0c74b08517e ("drivers: thermal: processor_thermal_device: Export sysfs inteface for TCC offset")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 6f6ac6a8e82d..cb22317911ef 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -164,7 +164,7 @@ static int tcc_offset_update(int tcc)
 		return err;
 
 	val = ~GENMASK_ULL(31, 24);
-	val = (tcc & 0xff) << 24;
+	val |= (tcc & 0xff) << 24;
 
 	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
 	if (err)
-- 
2.20.1

